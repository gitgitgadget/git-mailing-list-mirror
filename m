From: Jan-Benedict Glaw <jbglaw@lug-owl.de>
Subject: Re: [PATCH] Reintroduce svn pools to solve the memory leak.
Date: Tue, 28 Mar 2006 10:10:37 +0200
Message-ID: <20060328081037.GH31387@lug-owl.de>
References: <8aa486160603270326i3a8ddcfau61ca84cdac036ff9@mail.gmail.com> <7vhd5joiqt.fsf@assigned-by-dhcp.cox.net>
Mime-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha1;
	protocol="application/pgp-signature"; boundary="k040vn1t/h12DMPO"
Cc: Santi =?utf-8?B?QsOpamFy?= <sbejar@gmail.com>, git@vger.kernel.org,
	Karl =?utf-8?Q?Hasselstr=C3=B6m?= <kha@treskal.com>
X-From: git-owner@vger.kernel.org Tue Mar 28 10:11:05 2006
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by ciao.gmane.org with esmtp (Exim 4.43)
	id 1FO9Hm-0002Vl-9L
	for gcvg-git@gmane.org; Tue, 28 Mar 2006 10:10:42 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751370AbWC1IKj (ORCPT <rfc822;gcvg-git@m.gmane.org>);
	Tue, 28 Mar 2006 03:10:39 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751374AbWC1IKj
	(ORCPT <rfc822;git-outgoing>); Tue, 28 Mar 2006 03:10:39 -0500
Received: from lug-owl.de ([195.71.106.12]:22420 "EHLO lug-owl.de")
	by vger.kernel.org with ESMTP id S1751370AbWC1IKi (ORCPT
	<rfc822;git@vger.kernel.org>); Tue, 28 Mar 2006 03:10:38 -0500
Received: by lug-owl.de (Postfix, from userid 1001)
	id 596FEF0037; Tue, 28 Mar 2006 10:10:37 +0200 (CEST)
To: Junio C Hamano <junkio@cox.net>
Content-Disposition: inline
In-Reply-To: <7vhd5joiqt.fsf@assigned-by-dhcp.cox.net>
X-Operating-System: Linux mail 2.6.12.3lug-owl 
X-gpg-fingerprint: 250D 3BCF 7127 0D8C A444  A961 1DBD 5E75 8399 E1BB
X-gpg-key: wwwkeys.de.pgp.net
X-Echelon-Enable: howto poison arsenous mail psychological biological nuclear warfare test the bombastical terror of flooding the spy listeners explosion sex drugs and rock'n'roll
X-TKUeV: howto poison arsenous mail psychological biological nuclear warfare test the bombastical terror of flooding the spy listeners explosion sex drugs and rock'n'roll
User-Agent: Mutt/1.5.9i
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/18114>


--k040vn1t/h12DMPO
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Mon, 2006-03-27 10:16:58 -0800, Junio C Hamano <junkio@cox.net> wrote:
> "Santi B=C3=A9jar" <sbejar@gmail.com> writes:
> > On 3/24/06, Santi B=C3=A9jar <sbejar@gmail.com> wrote:
> >> Jan-Benedict Glaw <jbglaw@lug-owl.de> writes:
> >>
> >> diff-tree 4802426... (from 525c0d7...)
> >> Author: Karl  Hasselstr=C3=B6m <kha@treskal.com>
> >> Date:   Sun Feb 26 06:11:27 2006 +0100
> >>
> >>     svnimport: Convert executable flag
> >>
> >>     Convert the svn:executable property to file mode 755 when converti=
ng
> >>     an SVN repository to GIT.
> >>
> >>     Signed-off-by: Karl Hasselstr=C3=B6m <kha@treskal.com>
> >>     Signed-off-by: Junio C Hamano <junkio@cox.net>
> >>
> >> :100755 100755 ee2940f... 6603b96... M  git-svnimport.perl
> >
> > And this patch fixes my problems.
>=20
> Jan-Benedict, thanks for pinpointing the regression, and Santi,
> thanks for the patch.

I'm currently running another test with GCC: this patch cuts down
memory consumption to less than 1/10 of the previous state (VSZ) and
even more for RSS (my system is quite loaded...)

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

--k040vn1t/h12DMPO
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: Digital signature
Content-Disposition: inline

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1.4.1 (GNU/Linux)

iD8DBQFEKO99Hb1edYOZ4bsRAikeAJ96BytU2HH/tuQlUdLjAuq9VfvpMgCfbOwV
WABC0vXIL1gpz81j1qVDSvY=
=RRzo
-----END PGP SIGNATURE-----

--k040vn1t/h12DMPO--
