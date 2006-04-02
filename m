From: Jan-Benedict Glaw <jbglaw@lug-owl.de>
Subject: Re: parsecvs tool now creates git repositories
Date: Sun, 2 Apr 2006 21:31:44 +0200
Message-ID: <20060402193144.GK1259@lug-owl.de>
References: <1143956188.2303.39.camel@neko.keithp.com> <20060402093906.GH1259@lug-owl.de>
Mime-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha1;
	protocol="application/pgp-signature"; boundary="jIYo0VRlfdMI9fLa"
Cc: Git Mailing List <git@vger.kernel.org>
X-From: git-owner@vger.kernel.org Sun Apr 02 21:32:12 2006
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by ciao.gmane.org with esmtp (Exim 4.43)
	id 1FQ8J0-00050v-OG
	for gcvg-git@gmane.org; Sun, 02 Apr 2006 21:32:11 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932295AbWDBTbu (ORCPT <rfc822;gcvg-git@m.gmane.org>);
	Sun, 2 Apr 2006 15:31:50 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S932327AbWDBTbu
	(ORCPT <rfc822;git-outgoing>); Sun, 2 Apr 2006 15:31:50 -0400
Received: from lug-owl.de ([195.71.106.12]:46007 "EHLO lug-owl.de")
	by vger.kernel.org with ESMTP id S932295AbWDBTbs (ORCPT
	<rfc822;git@vger.kernel.org>); Sun, 2 Apr 2006 15:31:48 -0400
Received: by lug-owl.de (Postfix, from userid 1001)
	id F00F5F0025; Sun,  2 Apr 2006 21:31:44 +0200 (CEST)
To: Keith Packard <keithp@keithp.com>
Content-Disposition: inline
In-Reply-To: <20060402093906.GH1259@lug-owl.de>
X-Operating-System: Linux mail 2.6.12.3lug-owl 
X-gpg-fingerprint: 250D 3BCF 7127 0D8C A444  A961 1DBD 5E75 8399 E1BB
X-gpg-key: wwwkeys.de.pgp.net
X-Echelon-Enable: howto poison arsenous mail psychological biological nuclear warfare test the bombastical terror of flooding the spy listeners explosion sex drugs and rock'n'roll
X-TKUeV: howto poison arsenous mail psychological biological nuclear warfare test the bombastical terror of flooding the spy listeners explosion sex drugs and rock'n'roll
User-Agent: Mutt/1.5.9i
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/18280>


--jIYo0VRlfdMI9fLa
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Sun, 2006-04-02 11:39:06 +0200, Jan-Benedict Glaw <jbglaw@lug-owl.de> wr=
ote:
> On Sat, 2006-04-01 21:36:28 -0800, Keith Packard <keithp@keithp.com> wrot=
e:
> > The UI is a total disaster, sufficient for testing. You must create an
> > Authors file in the current directory which looks like the git-cvsimport
> > authors file. You must also have a edit-change-log program in your path
> > which edits the commit message in place. /bin/true will work if you
> > don't need to edit the messages.
>=20
> Well, at least this sounds quite promising. I'll give it a run once
> I've arrived back home on the Binutils repository.

Doesn't build for me:

jbglaw@bixie:~/vax/gittish/parsecvs$ make clean
rm -f gram.o lex.o parsecvs.o cvsutil.o revlist.o atom.o revcvs.o git.o y.t=
ab.h gram.c parsecvs
jbglaw@bixie:~/vax/gittish/parsecvs$ make
yacc -d gram.y=20
mv -f y.tab.c gram.c
cc -O0 -g -Wall -Wpointer-arith -Wstrict-prototypes -Wmissing-prototypes -W=
missing-declarations -Wnested-externs -fno-strict-aliasing   -c -o gram.o g=
ram.c
cc -O0 -g -Wall -Wpointer-arith -Wstrict-prototypes -Wmissing-prototypes -W=
missing-declarations -Wnested-externs -fno-strict-aliasing   -c -o lex.o le=
x.c
lex.l: In function =E2=80=98yylex=E2=80=99:
lex.l:69: warning: implicit declaration of function =E2=80=98yyget_lineno=
=E2=80=99
lex.l:69: warning: nested extern declaration of =E2=80=98yyget_lineno=E2=80=
=99
<stdout>: At top level:
<stdout>:1747: warning: no previous prototype for =E2=80=98yyget_lineno=E2=
=80=99
<stdout>:1756: warning: no previous prototype for =E2=80=98yyget_in=E2=80=99
<stdout>:1764: warning: no previous prototype for =E2=80=98yyget_out=E2=80=
=99
<stdout>:1772: warning: no previous prototype for =E2=80=98yyget_leng=E2=80=
=99
<stdout>:1781: warning: no previous prototype for =E2=80=98yyget_text=E2=80=
=99
<stdout>:1790: warning: no previous prototype for =E2=80=98yyset_lineno=E2=
=80=99
<stdout>:1802: warning: no previous prototype for =E2=80=98yyset_in=E2=80=99
<stdout>:1807: warning: no previous prototype for =E2=80=98yyset_out=E2=80=
=99
<stdout>:1812: warning: no previous prototype for =E2=80=98yyget_debug=E2=
=80=99
<stdout>:1817: warning: no previous prototype for =E2=80=98yyset_debug=E2=
=80=99
<stdout>:1823: warning: no previous prototype for =E2=80=98yylex_destroy=E2=
=80=99
lex.l: In function =E2=80=98parse_data=E2=80=99:
lex.l:90: error: =E2=80=98yytext_ptr=E2=80=99 undeclared (first use in this=
 function)
lex.l:90: error: (Each undeclared identifier is reported only once
lex.l:90: error: for each function it appears in.)
make: *** [lex.o] Error 1

MfG, JBG

--=20
Jan-Benedict Glaw       jbglaw@lug-owl.de    . +49-172-7608481             =
_ O _
"Eine Freie Meinung in  einem Freien Kopf    | Gegen Zensur | Gegen Krieg  =
_ _ O
 f=C3=BCr einen Freien Staat voll Freier B=C3=BCrger"  | im Internet! |   i=
m Irak!   O O O
ret =3D do_actions((curr | FREE_SPEECH) & ~(NEW_COPYRIGHT_LAW | DRM | TCPA)=
);

--jIYo0VRlfdMI9fLa
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: Digital signature
Content-Disposition: inline

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1.4.1 (GNU/Linux)

iD8DBQFEMCagHb1edYOZ4bsRAgxRAJ4p1Uo22NhGyDfAK30Bpq50u8aJtgCfbgre
9YAOz74JEULeAMCR+83lByM=
=QHvU
-----END PGP SIGNATURE-----

--jIYo0VRlfdMI9fLa--
