From: Jan-Benedict Glaw <jbglaw@lug-owl.de>
Subject: Re: [Patch] Using 'perl' in *.sh
Date: Sun, 9 Jul 2006 11:51:15 +0200
Message-ID: <20060709095114.GQ22573@lug-owl.de>
References: <200607081732.04273.michal.rokos@nextsoft.cz> <7v3bdcq7dy.fsf@assigned-by-dhcp.cox.net> <20060709094630.GB5919@steel.home>
Mime-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha1;
	protocol="application/pgp-signature"; boundary="TRkqPRiqIDKgfg/F"
Cc: Junio C Hamano <junkio@cox.net>,
	Michal Rokos <michal.rokos@nextsoft.cz>, git@vger.kernel.org
X-From: git-owner@vger.kernel.org Sun Jul 09 11:51:34 2006
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by ciao.gmane.org with esmtp (Exim 4.43)
	id 1FzVwj-0003mJ-Mk
	for gcvg-git@gmane.org; Sun, 09 Jul 2006 11:51:26 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751323AbWGIJvR (ORCPT <rfc822;gcvg-git@m.gmane.org>);
	Sun, 9 Jul 2006 05:51:17 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751325AbWGIJvR
	(ORCPT <rfc822;git-outgoing>); Sun, 9 Jul 2006 05:51:17 -0400
Received: from lug-owl.de ([195.71.106.12]:24757 "EHLO lug-owl.de")
	by vger.kernel.org with ESMTP id S1751323AbWGIJvQ (ORCPT
	<rfc822;git@vger.kernel.org>); Sun, 9 Jul 2006 05:51:16 -0400
Received: by lug-owl.de (Postfix, from userid 1001)
	id 216EAF0260; Sun,  9 Jul 2006 11:51:15 +0200 (CEST)
To: Alex Riesen <raa.lkml@gmail.com>
Content-Disposition: inline
In-Reply-To: <20060709094630.GB5919@steel.home>
X-Operating-System: Linux mail 2.6.12.3lug-owl 
X-gpg-fingerprint: 250D 3BCF 7127 0D8C A444  A961 1DBD 5E75 8399 E1BB
X-gpg-key: wwwkeys.de.pgp.net
X-Echelon-Enable: howto poison arsenous mail psychological biological nuclear warfare test the bombastical terror of flooding the spy listeners explosion sex drugs and rock'n'roll
X-TKUeV: howto poison arsenous mail psychological biological nuclear warfare test the bombastical terror of flooding the spy listeners explosion sex drugs and rock'n'roll
User-Agent: Mutt/1.5.9i
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/23538>


--TRkqPRiqIDKgfg/F
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Sun, 2006-07-09 11:46:30 +0200, Alex Riesen <fork0@t-online.de> wrote:
> Junio C Hamano, Sat, Jul 08, 2006 20:27:37 +0200:
> > >
> > > some GIT's shell script are using bare 'perl' for perl invocation. It=
's=20
> > > causing me problems... I compile git with PERL_PATH set and I'd sugge=
st to=20
> > > use it everywhere.
> > >
> > > So @@PERL@@ would be replaced with PERL_PATH_SQ instead.
> > >
> > > What do you think?
> >=20
> > Absolutely.
>=20
> Now imagine a non-posix system where an upgrade was made. Amongst
> other things perl was moved, i.e. from /opt/perl-5.8.8 to
> /usr/local/{bin,lib}. Suddenly git breaks.

My personal oppinion is to call perl scripts as `perl foo.pl' and thus
let the user decide (by means of setting $PATH) which perl incarnation
she wants to use.

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

--TRkqPRiqIDKgfg/F
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: Digital signature
Content-Disposition: inline

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1.4.1 (GNU/Linux)

iD8DBQFEsNGSHb1edYOZ4bsRAgZvAKCHz4KWsKM70IxUa1hDYgYwTjWKUwCePzD4
rXGJvhubRNahYayq5WgTtiY=
=9pNm
-----END PGP SIGNATURE-----

--TRkqPRiqIDKgfg/F--
