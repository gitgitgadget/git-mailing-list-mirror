From: Carlos =?ISO-8859-1?Q?Mart=EDn?= Nieto <cmn@elego.de>
Subject: Re: [PATCH V4] git on Mac OS and precomposed unicode
Date: Sat, 21 Jan 2012 23:28:54 +0100
Message-ID: <1327184934.31804.32.camel@centaur.lab.cmartin.tk>
References: <201201212036.57632.tboegi@web.de>
Mime-Version: 1.0
Content-Type: multipart/signed; micalg="pgp-sha1"; protocol="application/pgp-signature";
	boundary="=-x87JoSv+7oJKQrNtJYC4"
Cc: git@vger.kernel.org
To: Torsten =?ISO-8859-1?Q?B=F6gershausen?= <tboegi@web.de>
X-From: git-owner@vger.kernel.org Sat Jan 21 23:29:25 2012
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1RojR5-0004mO-Sc
	for gcvg-git-2@lo.gmane.org; Sat, 21 Jan 2012 23:29:24 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751259Ab2AUW24 (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Sat, 21 Jan 2012 17:28:56 -0500
Received: from kimmy.cmartin.tk ([91.121.65.165]:47901 "EHLO kimmy.cmartin.tk"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1751144Ab2AUW2z (ORCPT <rfc822;git@vger.kernel.org>);
	Sat, 21 Jan 2012 17:28:55 -0500
Received: from [192.168.1.17] (brln-4db9ca9c.pool.mediaWays.net [77.185.202.156])
	by kimmy.cmartin.tk (Postfix) with ESMTPSA id A316C461C3;
	Sat, 21 Jan 2012 23:28:52 +0100 (CET)
In-Reply-To: <201201212036.57632.tboegi@web.de>
X-Mailer: Evolution 3.2.2-1 
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/188938>


--=-x87JoSv+7oJKQrNtJYC4
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Sat, 2012-01-21 at 20:36 +0100, Torsten B=C3=B6gershausen wrote:
> Allow git on Mac OS to store file names in the index in precomposed unico=
de,
> while the file system uses decomposed unicode.
>=20
> The problem:
> When a file called "LATIN CAPITAL LETTER A WITH DIAERESIS"
> (in utf-8 encoded as 0xc3 0x84) is created, the Mac OS filesystem
> converts "precomposed unicode" into "decomposed unicode".
> This means that readdir() will return 0x41 0xcc 0x88.
>=20
> Git under Mac OS reverts the unicode decomposition of filenames.
>=20
> This is useful when pulling/pushing from repositories containing utf-8
> encoded filenames using precomposed utf-8 like Linux or Windows (*).
>=20
> It allows sharing git repositories stored on a VFAT file system
> (e.g. a USB stick), and mounted network share using samba.
>=20
> * (Not all Windows versions support UTF-8 yet:
>    Msysgit needs the unicode branch, cygwin supports UTF-8 since 1.7)

This might be overly pedantic, but Windows doesn't really deal with
UTF-8. To use Unicode you need to use the "wide" variant of the
functions, and those take UTF-16.

   cmn



--=-x87JoSv+7oJKQrNtJYC4
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: This is a digitally signed message part
Content-Transfer-Encoding: 7bit

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1.4.11 (GNU/Linux)

iQEcBAABAgAGBQJPGzwmAAoJEHKRP1jG7ZzTxPMH/1sJTH8thIxT0W+rZUVrYXQJ
Igs+hN3pNELE//qUTxPbhs/ahYp/utx7XIAp2JZUuYblDOHbVWQM8pZfyQXnSTUj
nPAPQxKV3IAYFownCEEmP3cNICqnttiQ4hDzcefp6XJ692ABs7navt1PDbnHO/lh
iuEDN38bXYx5sC4TB4Pa6EJNBWE7SeeBH7TrwTdED0m0MJRYKkekQR1DNiOmCS2L
SsrLWlcZIRiUBt9EHagC2OoZCNYZbICapJLwIdikaahaXNO/tg3WoAMAiXRJKtO5
ALE17PRoVsF2+ohMNdWhSXYh3Uxv7hUledqIg/gIWLhLLGT5CGkOqLrV48OI52w=
=XVfb
-----END PGP SIGNATURE-----

--=-x87JoSv+7oJKQrNtJYC4--
