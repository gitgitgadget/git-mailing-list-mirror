From: Carlos =?ISO-8859-1?Q?Mart=EDn?= Nieto <cmn@elego.de>
Subject: Re: git with detached worktrees , push has no effect
Date: Thu, 14 Jul 2011 14:49:27 +0200
Message-ID: <1310647767.6041.73.camel@centaur.lab.cmartin.tk>
References: <20110714181019.2453e3a8@shiva.selfip.org>
Mime-Version: 1.0
Content-Type: multipart/signed; micalg="pgp-sha1"; protocol="application/pgp-signature"; boundary="=-qWVzNeXpgEeCjp66RyyI"
Cc: git@vger.kernel.org
To: "J. Bakshi" <joydeep@infoservices.in>
X-From: git-owner@vger.kernel.org Thu Jul 14 14:53:14 2011
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1QhLPm-0003hl-3c
	for gcvg-git-2@lo.gmane.org; Thu, 14 Jul 2011 14:53:14 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1754721Ab1GNMxJ (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Thu, 14 Jul 2011 08:53:09 -0400
Received: from kimmy.cmartin.tk ([91.121.65.165]:53081 "EHLO kimmy.cmartin.tk"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1754564Ab1GNMxI (ORCPT <rfc822;git@vger.kernel.org>);
	Thu, 14 Jul 2011 08:53:08 -0400
Received: from [192.168.1.15] (brln-d9ba36b2.pool.mediaWays.net [217.186.54.178])
	by kimmy.cmartin.tk (Postfix) with ESMTPSA id 21987461FA;
	Thu, 14 Jul 2011 14:52:56 +0200 (CEST)
In-Reply-To: <20110714181019.2453e3a8@shiva.selfip.org>
X-Mailer: Evolution 2.32.3 
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/177128>


--=-qWVzNeXpgEeCjp66RyyI
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Thu, 2011-07-14 at 18:10 +0530, J. Bakshi wrote:
[...] snip snip snip
> warning: You appear to have cloned an empty repository.
>=20
>  touch A
>  git add A
>=20
>  git commit -m "add A"
>=20
> [master (root-commit) 7662edd] add A
>  0 files changed, 0 insertions(+), 0 deletions(-)
>  create mode 100644 A
>=20
>  git push
>  Username:
>  Password:
>  Everything up-to-date
>=20
>=20
> Why reports  [Everything up-to-date] rather than modify the remote git ?

That's because your remote repository has no branches and per default
git-push will only push matching branches; as no branches match, there
is nothing to do. This is what "warning: You appear to have cloned an
empty repository." is trying to tell you (the message could certainly be
made much more friendly). Your master branch in this case doesn't exist
in the server, so you have to tell git to push it explicitly.

    git push origin master

will do the trick.

Cheers,
   cmn

--=-qWVzNeXpgEeCjp66RyyI
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: This is a digitally signed message part

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1.4.11 (GNU/Linux)

iQEcBAABAgAGBQJOHuXSAAoJEHKRP1jG7ZzTPVcH/AvIOhrrnnParyDjX0qPL+77
T5YDlODzKS6pmZP1G21jba+UtpZO1jyQP2dcviwE0U2DGU6L2snnILANPH1PELed
KM4eysRVV1crxY6I2/S5p1UHP9OlSPLsWQChADC5b4uk7SfXw1k3bZvpOUIMi/n/
C0JBpOxTAy+zipju+iQJt0iMWHl12vZp8C91WFZdERxDUZGPTo3e94vnMM2YUsdo
6cAnr+9LrlM+esnK/97zHEl5S1nj8aVHY5vsL6eWaD92VPzczupPcLjJ//Okzm1+
oEklGn2cH7gsNWA0M8U+nBgqJBuB9/uYx4aOPd6okgPdzQSTJxOpgXdi3BkabsA=
=tXTl
-----END PGP SIGNATURE-----

--=-qWVzNeXpgEeCjp66RyyI--
