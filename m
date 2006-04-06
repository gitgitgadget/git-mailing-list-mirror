From: Jan-Benedict Glaw <jbglaw@lug-owl.de>
Subject: Re: Fixes to parsecvs
Date: Thu, 6 Apr 2006 18:09:21 +0200
Message-ID: <20060406160921.GU13324@lug-owl.de>
References: <1144305392.2303.240.camel@neko.keithp.com> <20060406120812.GO13324@lug-owl.de> <1144334896.2303.259.camel@neko.keithp.com> <Pine.LNX.4.63.0604061723410.23681@wbgn013.biozentrum.uni-wuerzburg.de>
Mime-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha1;
	protocol="application/pgp-signature"; boundary="2tWkrNKppd65XSnD"
Cc: Keith Packard <keithp@keithp.com>,
	Git Mailing List <git@vger.kernel.org>
X-From: git-owner@vger.kernel.org Thu Apr 06 18:09:58 2006
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by ciao.gmane.org with esmtp (Exim 4.43)
	id 1FRX3H-0004oN-5r
	for gcvg-git@gmane.org; Thu, 06 Apr 2006 18:09:43 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751254AbWDFQJZ (ORCPT <rfc822;gcvg-git@m.gmane.org>);
	Thu, 6 Apr 2006 12:09:25 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751261AbWDFQJZ
	(ORCPT <rfc822;git-outgoing>); Thu, 6 Apr 2006 12:09:25 -0400
Received: from lug-owl.de ([195.71.106.12]:46756 "EHLO lug-owl.de")
	by vger.kernel.org with ESMTP id S1751254AbWDFQJY (ORCPT
	<rfc822;git@vger.kernel.org>); Thu, 6 Apr 2006 12:09:24 -0400
Received: by lug-owl.de (Postfix, from userid 1001)
	id 43CCFF005E; Thu,  6 Apr 2006 18:09:21 +0200 (CEST)
To: Johannes Schindelin <Johannes.Schindelin@gmx.de>
Content-Disposition: inline
In-Reply-To: <Pine.LNX.4.63.0604061723410.23681@wbgn013.biozentrum.uni-wuerzburg.de>
X-Operating-System: Linux mail 2.6.12.3lug-owl 
X-gpg-fingerprint: 250D 3BCF 7127 0D8C A444  A961 1DBD 5E75 8399 E1BB
X-gpg-key: wwwkeys.de.pgp.net
X-Echelon-Enable: howto poison arsenous mail psychological biological nuclear warfare test the bombastical terror of flooding the spy listeners explosion sex drugs and rock'n'roll
X-TKUeV: howto poison arsenous mail psychological biological nuclear warfare test the bombastical terror of flooding the spy listeners explosion sex drugs and rock'n'roll
User-Agent: Mutt/1.5.9i
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/18473>


--2tWkrNKppd65XSnD
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Thu, 2006-04-06 17:26:14 +0200, Johannes Schindelin <Johannes.Schindelin=
@gmx.de> wrote:
> On Thu, 6 Apr 2006, Keith Packard wrote:
> > On Thu, 2006-04-06 at 14:08 +0200, Jan-Benedict Glaw wrote:
> > > But it seems it now starts to really consume memory:
> > The question is whether it needs to be more efficient so that people ca=
n=20
> > constantly convert repositories or whether moving the repository to a=
=20
> > sufficiently large machine for the one-time conversion is 'good enough'.
>=20
> Keep in mind that there are many more valid uses for tracking a CVS=20
> repository than to import it once.

Even the most simplest usage case reveals this. (It's also what I'm
about to do the the converted GCC repository.)

Get the repo, locally track the changes (so the importet branches are
all like "vendor branches") and do own work in local branches.

I'll do this eg. to be able to easily re-diff patches, which I want to
put into GIT, just because it's so much more convenient than SVN.
However, this is only possible because I'm able to keep track of
upstream SVN changes. They probably won't change their SCM again, just
after they've introduced SVN.

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

--2tWkrNKppd65XSnD
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: Digital signature
Content-Disposition: inline

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1.4.1 (GNU/Linux)

iD8DBQFENT0xHb1edYOZ4bsRAlsMAJ9hun4RVbUOinDs4ffQUmiOkmyVewCeJIwr
AMl3CGziaCIsakuaWVWoGuk=
=qkeT
-----END PGP SIGNATURE-----

--2tWkrNKppd65XSnD--
