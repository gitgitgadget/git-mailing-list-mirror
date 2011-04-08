From: Robert David <robert.david.public@gmail.com>
Subject: Re: GSOC idea: build in scripts and cleanups
Date: Fri, 8 Apr 2011 11:51:22 +0200
Organization: DDM Praha
Message-ID: <201104081151.23392.robert.david.public@gmail.com>
References: <201103260141.20798.robert.david.public@gmail.com> <201104071530.19566.robert.david.public@gmail.com> <7vk4f5emcm.fsf@alter.siamese.dyndns.org>
Mime-Version: 1.0
Content-Type: multipart/signed;
  boundary="nextPart14313313.BchE1OOBty";
  protocol="application/pgp-signature";
  micalg=pgp-sha256
Content-Transfer-Encoding: 7bit
Cc: Jeff King <peff@peff.net>, Thomas Rast <trast@student.ethz.ch>,
	Jonathan Nieder <jrnieder@gmail.com>,
	Git Mailing List <git@vger.kernel.org>,
	Matthieu Moy <Matthieu.Moy@imag.fr>
To: Junio C Hamano <gitster@pobox.com>
X-From: git-owner@vger.kernel.org Fri Apr 08 11:51:40 2011
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1Q88Lp-0001Kt-8h
	for gcvg-git-2@lo.gmane.org; Fri, 08 Apr 2011 11:51:38 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1755919Ab1DHJva (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Fri, 8 Apr 2011 05:51:30 -0400
Received: from mail-fx0-f46.google.com ([209.85.161.46]:65467 "EHLO
	mail-fx0-f46.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1755801Ab1DHJv3 (ORCPT <rfc822;git@vger.kernel.org>);
	Fri, 8 Apr 2011 05:51:29 -0400
Received: by fxm17 with SMTP id 17so2217291fxm.19
        for <git@vger.kernel.org>; Fri, 08 Apr 2011 02:51:28 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=gamma;
        h=domainkey-signature:from:organization:to:subject:date:user-agent:cc
         :references:in-reply-to:mime-version:content-type
         :content-transfer-encoding:message-id;
        bh=DtHkgUp3mS1sINL9MraTRF2u3JgstA8UHxAWA8sl6Es=;
        b=UiHxRmwEcT8qv+KJlmgTkkMmGd/2C/2h2begz54DxVVlN/24fHwW9Ni/ivLfEf/09/
         8DkZeyXYxs5iTds+6JBZ9/FQbE0HUX9+1ICC1tL2zFX7ldlfQQ6bcKrRUbQk8JL5Cm44
         dHSLOc3mtBEjhMAstuhT+77GI7H33vscArJ1k=
DomainKey-Signature: a=rsa-sha1; c=nofws;
        d=gmail.com; s=gamma;
        h=from:organization:to:subject:date:user-agent:cc:references
         :in-reply-to:mime-version:content-type:content-transfer-encoding
         :message-id;
        b=esvJqf8Kgkvi1Tis3AlkB8MAoyRoHD8W/iVt0wTavpFWiKxRT7NUSqtWSxmC9zj/ni
         6CbkiIhXsMA+kU2aAG/U1xfwPKlgYz6h8e293INLQUOf4xSi0QbJ50faUKJuu5f+BtcS
         Mnfl2aJE2MLbb4+Hn19v6UVeWkHGUpKuPvjeI=
Received: by 10.223.86.200 with SMTP id t8mr2000429fal.26.1302256288221;
        Fri, 08 Apr 2011 02:51:28 -0700 (PDT)
Received: from robert-eee.localnet (gate.chabry.cz [80.92.246.13])
        by mx.google.com with ESMTPS id n1sm733528fam.40.2011.04.08.02.51.24
        (version=SSLv3 cipher=OTHER);
        Fri, 08 Apr 2011 02:51:25 -0700 (PDT)
User-Agent: KMail/1.13.5 (Linux/2.6.32-5-686; KDE/4.4.5; i686; ; )
In-Reply-To: <7vk4f5emcm.fsf@alter.siamese.dyndns.org>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/171120>

--nextPart14313313.BchE1OOBty
Content-Type: multipart/mixed;
  boundary="Boundary-01=_bqtnN3hRJja8Bl8"
Content-Transfer-Encoding: 7bit


--Boundary-01=_bqtnN3hRJja8Bl8
Content-Type: Text/Plain;
  charset="iso-8859-1"
Content-Transfer-Encoding: quoted-printable
Content-Disposition: inline

Dne p=E1tek 08 dubna 2011 00:19:05 Junio C Hamano napsal(a):
> Robert David <robert.david.public@gmail.com> writes:
> > This task also include cleaning the functionality of this code, to make
> > these functions more "standardized".
> > This means consolidate the differences in these functions and make them
> > more consistent in the user point of view.
>=20
> Standardized, consolidate, consistent are all pretty words but at the same
> time they are highly subjective. Even though you may not have to have the
> detailed description of everything in the proposal, you would need to at
> least have a handful of examples of what are wrong with the current code
> in mind when making such a sweeping statement, but I cannot sense that
> from this proposal.

While I have read the code, first thing I noticed is the inconsistence of=20
general coding standarts used. Sometimes the code is pretty nice divided in=
to=20
subrutines to get the code understand fast, and sometimes it is a huge=20
subrutine that does as much things as possible, and thus is no so good to r=
ead=20
(also I don't speak here about comments missing in a lot of code, where=20
sometimes there are some). With the lack of documentation in Documentation=
=20
directory, that means that this code is something like black box. And hard =
to=20
learn for newcomer. Tell me if Im wrong, but isnt the open-source demand al=
so=20
to let as many people ac possible to involve in development?=20

The biggest example is the "patch_update_file". Which can be divided in few=
=20
parts. For example the "if ($line) { ..... }" big big box.
This also mean for list_and_chose and list_modified (and maybe others).

Sometimes there are perl like statements:

"something if|for|while|etc something"
and common things are written next like=20
"if (something) { something }"

Is there demand to write scripts (mainly perl) like in C to keep the code m=
ore=20
readable for C people or just write it more in perl style (to keep the code=
=20
cleaner and shorter)?

Another thing is parsing command line options, why not use Getopt::Long her=
e?



>=20
> While reading the current add-i code recently, I noticed that over time
> the code quality deteriorated compared to the reasonably clean design in
> the original version, perhaps due to excessive copying and mimicing,
> especially when "Edit patch" feature was added and then more recently when
> new modes to apply patches in different directions are added to allow
> other commands like "git reset" and "git checkout" to implement their
> "--patch" options.
>=20
> An example of a clean-up in the right direction may be a patch I posted a
> few days ago:
>=20
> =20
> http://thread.gmane.org/gmane.comp.version-control.git/170685/focus=3D171=
017
>=20
> Is that the kind of "consolidation" you have in mind?

I have read that conversation before. I also tried to reproduce that bug, b=
ut=20
have no success (in version 1.7.4.3). But before I read the code and try to=
=20
find something that this can occur, you send the patch. I'm not so fast as=
=20
you:)


>=20
> Also I am a bit puzzled by the inconsistency between the various stages of
>=20
> your goals.  A clearly stated primary goal is:
> > Main and final project goal is integrating fully git-add--interactive
> > into current git-add code.
>=20
> but the success criteria is only about the above "This task also include"?

I will try to clear that up today, to finalize that in the meaning of doing=
 the=20
cleanup and extension part as part of GSoC and prepare the rewriting part f=
or=20
further work. I still think I can handle that and rewrite that as part of=20
GSoC, but I didn't do such a big open-source project before, so I'm going t=
o=20
adopt your style of coding standards and timings.=20

I also attach a example perl code I'm now writing, it is a half done(40%) d=
ata=20
=2D> animated graph converter (part of my seminar work).=20

Robert.

> --
> To unsubscribe from this list: send the line "unsubscribe git" in
> the body of a message to majordomo@vger.kernel.org
> More majordomo info at  http://vger.kernel.org/majordomo-info.html

--Boundary-01=_bqtnN3hRJja8Bl8
Content-Type: application/x-perl;
  name="semestralka.pl"
Content-Transfer-Encoding: quoted-printable
Content-Disposition: attachment;
	filename="semestralka.pl"

#!/usr/bin/perl
#
###########################################################################=
#####
# Semestralni prace: animace grafu
###########################################################################=
#####
#

use strict;
use warnings;
use Getopt::Std;
use File::Path;

# defualt values
my %params =3D=20
  (=20
   "Name", "$0-flow",
   "TimeFormat", "[%Y-%m-%d %H:%M:%S]",
   "Xmax" , "max",
   "Xmin" , "min",
   "Ymax" , "auto",
   "Ymin" , "auto",
   "Speed" , 1,
   "Time", "",
   "FPS" , 25,
   "Legend", "",
   "GnuplotParam", "",
   "EffectParams", "",
   "ConfigFile", ""
  );
# END

###########################################################################=
#####
# Funkce
###########################################################################=
#####
sub get_addr_name
{
  my $name =3D shift;
  my @dirs =3D < ${name}_* >;
  if( -d $name )
  {
    my $max =3D 0;

    for( @dirs )
    {
      if( -d && m/^${name}_\d*$/ )
      {
        s/${name}_//;
        $max=3D$_ if ($_>$max);
      }
    }
    $max++;
    return "${name}_${max}";
  }
  else
  {
    return "$name";
  }
}

sub parse_config_file
{
  open( CONFIG, shift ) or die "Nemohu naj=C3=ADt konfigura=C4=8Dn=C3=AD so=
ubor.\n";

  my @line;
  my %multiline;

  while(<CONFIG>)
  {
    s/#.*//;
    s/^\s+//;
    s/\s+$//;
    if(/\S/)
    {
      @line =3D split(/ /);
      if( exists $multiline{$line[0]} )
      {
        $params{$line[0]} .=3D ":@line[1..$#line]" if exists $params{$line[=
0]};
      }
      else
      {
        $params{$line[0]} =3D "@line[1..$#line]" if exists $params{$line[0]=
};
        $multiline{$line[0]} =3D "";
      }
    }
  }
}

sub parse_commandline
{
  my %par;
  my %opt;
  &getopts('t:X:x:Y:y:S:T:F:l:g:e:f:n:', \%opt);
  $par{"ConfigFile"} =3D $opt{'f'} if defined $opt{'f'};
  $par{"Name"} =3D $opt{'n'} if defined $opt{'n'};
  $par{"TimeFormat"} =3D $opt{'t'} if defined $opt{'t'};
  $par{"Xmax"} =3D $opt{'X'} if defined $opt{'X'};
  $par{"Xmin"} =3D $opt{'x'} if defined $opt{'x'};
  $par{"Ymax"} =3D $opt{'Y'} if defined $opt{'Y'};
  $par{"Ymin"} =3D $opt{'y'} if defined $opt{'y'};
  $par{"Speed"} =3D $opt{'S'} if defined $opt{'S'};
  $par{"Time"} =3D $opt{'T'} if defined $opt{'T'};
  $par{"FPS"} =3D $opt{'F'} if defined $opt{'F'};
  $par{"Legend"} =3D $opt{'l'} if defined $opt{'l'};
  $par{"GnuplotParams"} =3D $opt{'g'} if defined $opt{'g'};
  $par{"EffectParams"} =3D "$opt{'e'}" if defined $opt{'e'};
  return %par;
}

sub check_params
{
  foreach ( "FPS", "Time", "Speed" )
  {
    $params{$_} =3D~ /^\d*$/ or die "=C5=A0patn=C3=BD parametr $_.\n";
  }
  $params{"TimeFormat"} =3D~ s/\s+/_/;
}

sub image_generator
{
  my ( $count, $max_len, $min, $max, $addr, $x, $y ) =3D @_;

  $count =3D "0"x(length($max_len)-length($count)) . $count;

  open( DATA_FILE, ">", $addr . "/image-" . $count . ".data" );
  print DATA_FILE @$x[$_] . " " . @$y[$_] . "\n" foreach (0..$count);
  close DATA_FILE;

  system( "/usr/bin/gnuplot -e \"" .=20
    " set term png; set xdata time; " .=20
    " set timefmt \'" . $params{"TimeFormat"} . "\';" .
    " set xrange \[\'" . @$x[0] . "\':\'" . @$x[-1] . "\'\];" .
    " set yrange \[\'" . $min . "\':\'" . $max . "\'\];" .
    " plot \'" . $addr . "/image-" . $count . ".data\' using 1:2 with lines=
 title \'" .=20
    $params{"Legend"} . "\'\"" .=20
    ">" . $addr . "/image-" . $count . ".png" ); =20

  unlink( $addr . "/image-" . $count . ".data" );
}=20

###########################################################################=
#####
# Zacatek programu
###########################################################################=
#####

my %params_commandline =3D &parse_commandline;
my @input_files;
my @data_x;
my @data_y;

###=C2=A0parsuj, spoj a zkontroluj parametry
&parse_config_file( $params_commandline{"ConfigFile"} ) if defined $params_=
commandline{"ConfigFile"};
$params{$_} =3D $params_commandline{$_} foreach( keys %params_commandline );
&check_params;

### zkontroluj a vytvor prislusny adresar
my $addr_name =3D &get_addr_name($params{"Name"});
mkdir $addr_name or die "Nelze vytvo=C5=99it adres=C3=A1=C5=99.\n";

### nacti vstupni soubory
push( @input_files, $_ ) while( $_ =3D shift );
print "Neni specifikovan datovy sobor.\n" if not @input_files;
foreach my $file (@input_files)
{
  open( FILE, $file );
  while(<FILE>)
  {
    push( @data_x, /(\[.*\])/ );
    push( @data_y, /\[.*\]\s*(\S*)/ );
  }
  close FILE;
}

my $max =3D $data_y[0];
my $min =3D $data_y[0];
$max =3D $max < $_ ? $_ : $max foreach (@data_y);
$min =3D $min > $_ ? $_ : $min foreach (@data_y);

### vygenerovat obrazky
foreach ( 0..$#data_x )
{
  $data_x[$_] =3D~ s/\s+/_/g;
  &image_generator( $_, $#data_x, $min, $max, $addr_name, \@data_x, \@data_=
y );
}

# test
#print $_, "\t=3D>\t", $params{$_}, "\n" foreach (keys %params);
#print $addr_name, "\n";
#print "@input_files", "\n";
#&rmtree("$addr_name"); # clean
# end test

###########################################################################=
#####
# Konec programu
###########################################################################=
#####

--Boundary-01=_bqtnN3hRJja8Bl8--

--nextPart14313313.BchE1OOBty
Content-Type: application/pgp-signature; name=signature.asc 
Content-Description: This is a digitally signed message part.

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1.4.10 (GNU/Linux)

iF4EABEIAAYFAk2e2psACgkQLSNWchw0XGyTkwD9EApz2+LB0s9iDUQwJlsq7X+O
+bcpb/6lcT6+0gbPcPUBAPji+KAkucyWEthW2ZulkBj6gSUDC36pfkMJ+jT1t+UT
=k9iJ
-----END PGP SIGNATURE-----

--nextPart14313313.BchE1OOBty--
