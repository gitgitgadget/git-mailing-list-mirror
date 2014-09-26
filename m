From: "brian m. carlson" <sandals@crustytoothpaste.net>
Subject: Re: bug reporting
Date: Fri, 26 Sep 2014 23:51:58 +0000
Message-ID: <20140926235158.GC6553@vauxhall.crustytoothpaste.net>
References: <54256D0F.4000003@galaxyweblinks.in>
Mime-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha512;
	protocol="application/pgp-signature"; boundary="vOmOzSkFvhd7u8Ms"
Cc: git@vger.kernel.org
To: Ajay <ajay.dadgas@galaxyweblinks.in>
X-From: git-owner@vger.kernel.org Sat Sep 27 01:52:26 2014
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1XXfJJ-0004OV-P8
	for gcvg-git-2@plane.gmane.org; Sat, 27 Sep 2014 01:52:26 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1756032AbaIZXwI (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Fri, 26 Sep 2014 19:52:08 -0400
Received: from castro.crustytoothpaste.net ([173.11.243.49]:50419 "EHLO
	castro.crustytoothpaste.net" rhost-flags-OK-OK-OK-OK)
	by vger.kernel.org with ESMTP id S1754739AbaIZXwH (ORCPT
	<rfc822;git@vger.kernel.org>); Fri, 26 Sep 2014 19:52:07 -0400
Received: from vauxhall.crustytoothpaste.net (unknown [IPv6:2001:470:1f05:79:6680:99ff:fe4f:73a0])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by castro.crustytoothpaste.net (Postfix) with ESMTPSA id 18B882808F;
	Fri, 26 Sep 2014 23:52:02 +0000 (UTC)
Mail-Followup-To: Ajay <ajay.dadgas@galaxyweblinks.in>, git@vger.kernel.org
Content-Disposition: inline
In-Reply-To: <54256D0F.4000003@galaxyweblinks.in>
X-Machine: Running on vauxhall using GNU/Linux on x86_64 (Linux kernel
 3.17-rc5-amd64)
User-Agent: Mutt/1.5.23 (2014-03-12)
X-Spam-Score: -0.175 () BAYES_00,RDNS_NONE,WEIRD_PORT
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/257555>


--vOmOzSkFvhd7u8Ms
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Fri, Sep 26, 2014 at 07:11:35PM +0530, Ajay wrote:
> Hello,
>=20
>          I have faced a git bug. When I try to clone a git repo it shows =
an
> error "protocol error: bad pack header".
>=20
>          This is the full error message which I got while cloning git
> project :
>=20
> Clone: protocol error: bad pack header
>     $ git clone -v --progress
> http://dev.galaxylipl.com:88/galaxygit/privatenovator.git
> /home/lipl/privateschoolinnovator
>     Cloning into '/home/lipl/privatenovator'...
>     POST git-upload-pack (190 bytes)
>     remote: error: Could not read e9a6c4c684a5e8758026e8b0e25867c03332fe7c
>     remote: fatal: bad tree object e9a6c4c684a5e8758026e8b0e25867c03332fe=
7c
>     remote: aborting due to possible repository corruption on the remote
> side.
>     protocol error: bad pack header

This indicates some sort of corruption between the client and server.  I
notice you're cloning over HTTP.  Are you using a proxy?  Can you try
using a git, ssh, or https (without MITM) URL?  Sometimes broken proxies
can end up corrupting data.

Also, what version of git are you using on the client and the server?
--=20
brian m. carlson / brian with sandals: Houston, Texas, US
+1 832 623 2791 | http://www.crustytoothpaste.net/~bmc | My opinion only
OpenPGP: RSA v4 4096b: 88AC E9B2 9196 305B A994 7552 F1BA 225C 0223 B187

--vOmOzSkFvhd7u8Ms
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: Digital signature

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1

iQIcBAEBCgAGBQJUJfweAAoJEL9TXYEfUvaLvUQP/0pHiMHloUUDtUYy7coUDU1L
V8IdSo9k8+yyC28qtRlxhF1GPfO39z25XF7W2UyakSdPtJqpyd6vijQxd3lrj/jG
1gzt+FabbmqfKA0lQNIKWPTFM/XQWiLLvZZXH1Aemv11vyDAFLydpbgJ5CCiyvWu
cruCFgpmAgRTvCbYlW43ymK1bH14pA4abEZ96iuQ4LfCoE2cLjmkWQQH1eVSY1x6
XVuQDICMLkmy9+wpWzpeLNVW614zTfp6LAU8AhkSKIS/Jn51e/DJ/GCdEzQSdPxK
syreXfOyGNN+nwkd3lwOHnaBSdn6LzT2tKIKX9EmiYet1NXw6orMFvwPfiyII86x
3/sCeal0SQLXoOZtEH6jYE3wsiBUpSt0E1PmMfChaPhbnFMPpYO0Q8UrtgtEUkXy
b7dVjpvgrNtspOWSuRORfWprPpTN3zN3yCh87c5QYuqaaD3cO2ykNWOHgROX4GWW
TgPxAcqfGgGbgr3RUAxJ8iGek4Y6Gn6gxEMLlQtve2m0xDY+EymljXKSziKwSyWI
uyPEctbFaR8+YXsdyaxUbhQcl0GnTqgJDh6rUofvJPlKlaJiCGLutkiB2DY3Vxw6
OW9oJiX1/xhpt26vrn6g3SrBI3Q7e2kYxG2eu/429K8zHDtWBG6sSWGOeqvOCynR
k1UVKZHmyfM6W5g7PpZA
=5xVn
-----END PGP SIGNATURE-----

--vOmOzSkFvhd7u8Ms--
