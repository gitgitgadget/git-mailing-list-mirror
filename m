From: Carlos =?ISO-8859-1?Q?Mart=EDn?= Nieto <cmn@elego.de>
Subject: Re: unable to index file UsrClass.dat
Date: Mon, 18 Jun 2012 15:49:49 +0200
Message-ID: <1340027389.10106.18.camel@beez.lab.cmartin.tk>
References: <CACUgyLmvWk0WeMqx-7Qkw0py8=1ND+4pZNJDp5JOYxEcjU-UXQ@mail.gmail.com>
Mime-Version: 1.0
Content-Type: multipart/signed; micalg="pgp-sha1"; protocol="application/pgp-signature";
	boundary="=-9xjigutkzTcSDos0O0kc"
Cc: git@vger.kernel.org
To: Grant Zhao <zhao.grant@gmail.com>
X-From: git-owner@vger.kernel.org Mon Jun 18 15:50:11 2012
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1SgcLH-0002eR-Ts
	for gcvg-git-2@plane.gmane.org; Mon, 18 Jun 2012 15:50:08 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751715Ab2FRNt6 (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Mon, 18 Jun 2012 09:49:58 -0400
Received: from kimmy.cmartin.tk ([91.121.65.165]:41495 "EHLO kimmy.cmartin.tk"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1751678Ab2FRNt4 (ORCPT <rfc822;git@vger.kernel.org>);
	Mon, 18 Jun 2012 09:49:56 -0400
Received: from [10.10.10.234] (i59F7870A.versanet.de [89.247.135.10])
	by kimmy.cmartin.tk (Postfix) with ESMTPSA id 8D36A46057;
	Mon, 18 Jun 2012 15:49:54 +0200 (CEST)
In-Reply-To: <CACUgyLmvWk0WeMqx-7Qkw0py8=1ND+4pZNJDp5JOYxEcjU-UXQ@mail.gmail.com>
X-Mailer: Evolution 3.2.2-1+b1 
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/200141>


--=-9xjigutkzTcSDos0O0kc
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Mon, 2012-06-18 at 03:09 -0700, Grant Zhao wrote:
> I used "git add .",but "fatal: adding files failed".
> because
>=20
> error: open("Local Settings/Application Data/Microsoft/Windows/UsrClass.d=
at"): P
> ermission denied
>=20
> I cannot open the file "UsrClass.dat",I use Windows XP Profesional
> Sp3, please tell me why!

Did you miss the part where is says "Permission denied"? You even quoted
it in the e-mail.

As to why you don't have permission to read the file, that shouldn't be
related to git at all. It looks like you're trying to read someone
else's data, which would certainly account for the lack of permissions.

   cmn


--=-9xjigutkzTcSDos0O0kc
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: This is a digitally signed message part
Content-Transfer-Encoding: 7bit

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1.4.12 (GNU/Linux)

iQEcBAABAgAGBQJP3zH9AAoJEHKRP1jG7ZzTHU4IAKO+2DpHjeE5rOdQJD1ry9Qi
auj4t3c7th9Fqkj9illr5zOSagTkY5qn04NKEhj5bqzEMP6OGQwnG/tAttyC7i6b
4Ma+kYvY5yXoGC232jZbAtEmCEq+2MxTViGPQGFPm2Z8zVLzFkhe2ptiL5vasS7h
tu0C0Ys4kb26XHPGFRupBhncybRFKMa4YMbvVRLyL5iwnf+telogOUzpUQ/UT2eY
dvPEa959d+n6BcqAz3e+WsNUxi/16D5pqaVx+OKkw8mnZABOdx9duJYTl48zn+GD
sLJ7FJ2p8pwNhn9fKQcn05xAUis8dcx65SlKi/UCSaR0UG86Ro1/7hrLI+U+03k=
=1yaG
-----END PGP SIGNATURE-----

--=-9xjigutkzTcSDos0O0kc--
