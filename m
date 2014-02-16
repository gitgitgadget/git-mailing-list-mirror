From: "brian m. carlson" <sandals@crustytoothpaste.net>
Subject: Re: [PATCH 1/3] wt-status.c: make cut_lines[] const to shrink .data
 section a bit
Date: Sun, 16 Feb 2014 16:21:48 +0000
Message-ID: <20140216162147.GL4582@vauxhall.crustytoothpaste.net>
References: <1392521840-21628-1-git-send-email-pclouds@gmail.com>
 <1392521840-21628-2-git-send-email-pclouds@gmail.com>
Mime-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha512;
	protocol="application/pgp-signature"; boundary="c8UbHMnQwI7BF+TB"
Cc: git@vger.kernel.org
To: =?utf-8?B?Tmd1eeG7hW4gVGjDoWkgTmfhu41j?= Duy <pclouds@gmail.com>
X-From: git-owner@vger.kernel.org Sun Feb 16 17:22:00 2014
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1WF4Tg-00081F-Df
	for gcvg-git-2@plane.gmane.org; Sun, 16 Feb 2014 17:22:00 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1752885AbaBPQV4 (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Sun, 16 Feb 2014 11:21:56 -0500
Received: from castro.crustytoothpaste.net ([173.11.243.49]:51991 "EHLO
	castro.crustytoothpaste.net" rhost-flags-OK-OK-OK-OK)
	by vger.kernel.org with ESMTP id S1752508AbaBPQVz (ORCPT
	<rfc822;git@vger.kernel.org>); Sun, 16 Feb 2014 11:21:55 -0500
Received: from vauxhall.crustytoothpaste.net (unknown [IPv6:2001:470:1f05:79:3559:ce18:7c4e:2abc])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by castro.crustytoothpaste.net (Postfix) with ESMTPSA id 8274528074;
	Sun, 16 Feb 2014 16:21:53 +0000 (UTC)
Mail-Followup-To: =?utf-8?B?Tmd1eeG7hW4gVGjDoWkgTmfhu41j?= Duy <pclouds@gmail.com>,
	git@vger.kernel.org
Content-Disposition: inline
In-Reply-To: <1392521840-21628-2-git-send-email-pclouds@gmail.com>
X-Machine: Running on vauxhall using GNU/Linux on x86_64 (Linux kernel
 3.12-1-amd64)
User-Agent: Mutt/1.5.21 (2010-09-15)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/242234>


--c8UbHMnQwI7BF+TB
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Sun, Feb 16, 2014 at 10:37:18AM +0700, Nguy=E1=BB=85n Th=C3=A1i Ng=E1=BB=
=8Dc Duy wrote:
> -static char cut_line[] =3D
> +static const char cut_line[] =3D

Your subject says cut_lines[], but the variable is cut_line[] (no "s").

--=20
brian m. carlson / brian with sandals: Houston, Texas, US
+1 832 623 2791 | http://www.crustytoothpaste.net/~bmc | My opinion only
OpenPGP: RSA v4 4096b: 88AC E9B2 9196 305B A994 7552 F1BA 225C 0223 B187

--c8UbHMnQwI7BF+TB
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: Digital signature

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1

iQIcBAEBCgAGBQJTAOWbAAoJEL9TXYEfUvaL4GMQALJtAMsVKw9HPI/IOflqzuYc
YfdKCA5GsfvZtI/slMBkZj+BIJHqbRRFdPMTXyBtAjLDZh1OUrGGZag01ttvcFZA
mRHRW+m2U+sRjl6FexbSQH9T/gvC3LtvJdHxhh3Hm8Q4SKriOiPUN/ie1w/mdzYQ
3KfBc9T1P5fKqsQPXfd139d6Y9Q8rOvbczbtMIPkiNQj87L9O6PWOsvA+zfOtVGG
nF3ObAyQ1FVAcpAkLOLAho0V7BxzMP+gPZnpx034QTQFGS+8OV6EFwYIzeD/dhq2
dxVIDcuYFc6D2IPW5ft+Gr6Ed1B5h/NEspzIJzo9SEvXDuqRb3MNhZAuV2NZheDl
asQfqEGHhx5ABQeS01zf02/l56yvUgkIxp/nswIn8UF4YOnI1idUEpHPYqZzR0Gm
GBtWk+uUYR3TOGAvpQ3QDkrhwlxYjf+GqOhpaTuk3ukEXinifwYSBiIRHrPNQR5J
CiTt/OZNnYUbAF/3KrnW2C5vMKYjr68vx2mxEMYjv7763w7KeslvHfXcKbFwOAPV
Jr+8KpZ5XuofBaX9v9zW65G1HirJ3qRynbkl8t+3VhFq2iSbfUiTYrNjOdG72iP7
x8pMhUUzyB6OrMSNA5eJkuSOLuRGriwxMxcTBk0XGNNipyEPSe2RvnVo+NZNggNt
YyKaESmGRgmz3rQdA4vk
=4eaN
-----END PGP SIGNATURE-----

--c8UbHMnQwI7BF+TB--
