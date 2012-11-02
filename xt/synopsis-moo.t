use v5.14;
use strict;
use Test::More;

package Document {
	use Moo;
	use MooX::Augment -class;
	has recipient => (is => 'ro');
	sub as_xml    { sprintf "<document>%s</document>", inner }
}

package Greeting {
	use Moo;
	use MooX::Augment -class;
	extends qw( Document );
	augment as_xml => sub {
		sprintf "<greet>%s</greet>", inner
	}
}

package Greeting::English {
	use Moo;
	use MooX::Augment -class;
	extends qw( Greeting );
	augment as_xml => sub {
		my $self = shift;
		sprintf "Hello %s", $self->recipient;
	}
}

my $obj = Greeting::English->new(recipient => "World");
is(
	$obj->as_xml,
	"<document><greet>Hello World</greet></document>",
);

done_testing();
