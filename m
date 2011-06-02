From: Carlos =?utf-8?Q?Mart=C3=ADn?= Nieto <carlos@cmartin.tk>
Subject: Re: Can't get git rebase --onto to work
Date: Thu, 2 Jun 2011 12:32:59 +0200
Message-ID: <20110602103259.GA30081@centaur.lab.cmartin.tk>
References: <BANLkTikF7p_XsU6YJ81bq10S3nL6tBsApg@mail.gmail.com>
Mime-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha1;
	protocol="application/pgp-signature"; boundary="sm4nu43k4a2Rpi4c"
Cc: git@vger.kernel.org
To: Howard Miller <howard@e-learndesign.co.uk>
X-From: git-owner@vger.kernel.org Thu Jun 02 12:33:08 2011
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1QS5DA-00023Z-8D
	for gcvg-git-2@lo.gmane.org; Thu, 02 Jun 2011 12:33:08 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S933381Ab1FBKdB (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Thu, 2 Jun 2011 06:33:01 -0400
Received: from kimmy.cmartin.tk ([91.121.65.165]:47451 "EHLO kimmy.cmartin.tk"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S932749Ab1FBKdA (ORCPT <rfc822;git@vger.kernel.org>);
	Thu, 2 Jun 2011 06:33:00 -0400
Received: from centaur.lab.cmartin.tk (brln-4db9cba1.pool.mediaWays.net [77.185.203.161])
	by kimmy.cmartin.tk (Postfix) with ESMTPA id 835D1461D9;
	Thu,  2 Jun 2011 12:32:31 +0200 (CEST)
Received: (nullmailer pid 32697 invoked by uid 1000);
	Thu, 02 Jun 2011 10:32:59 -0000
Mail-Followup-To: Carlos =?utf-8?Q?Mart=C3=ADn?= Nieto <carlos@cmartin.tk>,
	Howard Miller <howard@e-learndesign.co.uk>, git@vger.kernel.org
Content-Disposition: inline
In-Reply-To: <BANLkTikF7p_XsU6YJ81bq10S3nL6tBsApg@mail.gmail.com>
User-Agent: Mutt/1.5.21 (2010-09-15)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/174935>


--sm4nu43k4a2Rpi4c
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Thu, Jun 02, 2011 at 11:17:41AM +0100, Howard Miller wrote:
> Trying to explain this as concisely as possible.
>=20
> I started with the following branches (names changed to protect the guilt=
y)...
>=20
> * clientA
> * clientB
>=20
> both have a common ancestry....
>=20
> I then checked out clientB created a new branch clientB_patch and did
> a load of work and commits.
>=20
> However, I actually wanted all those commits to apply to clientA
> branch instead so....
>=20
> git checkout clientA
> git checkout -b clientA_patch     (to ensure I didn't wreck original bran=
ch)
> git rebase --onto clientA_patch clientB clientB_patch

The man page for git-rebase covers this exact situation (around line
88 in my version) . In its case, it's

    git rebase --onto master next topic

which translates to your case as

    git rebase --onto clientA clientB clientB_patch

Cheers,
   cmn
--=20
Carlos Mart=C3=ADn Nieto | http://cmartin.tk

"=C2=BFC=C3=B3mo voy a decir bobadas si soy mudo?" -- CACHAI

--sm4nu43k4a2Rpi4c
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: Digital signature

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1.4.11 (GNU/Linux)

iQEcBAEBAgAGBQJN52bbAAoJEHKRP1jG7ZzTqMMH/0kwKZJaL42wRrrJdqvCCOZz
d2Un1UlBLiexK+KkL750n0UvEfsT2IKl56njIGAV14IJYzeM+B1zok7pgKZDpFTA
nXy7kgnr9pbappHR5tbwOmye+OYFJgXx2Rre/fa+OO+TGP4I8jWEljYdCVGQHwzS
hUIl2IDNzE1cLdk+lnyrGsh8sQ5iafMgtd66cW7EPP+zcpOkzanuj0BvAyf/Fp1z
482c1pIxX2lHRvkPFDA7gUDIRnO7haFYpjGEoE6ys/nIdR9tW3GIC8km8zwXKqaq
HpEA7jnq2GIyPxRHkb38+WfAsX88faCsggroE3lGctCdGAAFY5S6ILvv4AQFZv4=
=j9jX
-----END PGP SIGNATURE-----

--sm4nu43k4a2Rpi4c--
