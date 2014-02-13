From: "brian m. carlson" <sandals@crustytoothpaste.net>
Subject: Re: Make the git codebase thread-safe
Date: Thu, 13 Feb 2014 01:42:30 +0000
Message-ID: <20140213014229.GE4582@vauxhall.crustytoothpaste.net>
References: <CA+TurHgyUK5sfCKrK+3xY8AeOg0t66vEvFxX=JiA9wXww7eZXQ@mail.gmail.com>
Mime-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha512;
	protocol="application/pgp-signature"; boundary="K/NRh952CO+2tg14"
Cc: git@vger.kernel.org
To: Stefan Zager <szager@chromium.org>
X-From: git-owner@vger.kernel.org Thu Feb 13 02:42:39 2014
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1WDlK2-000353-Pr
	for gcvg-git-2@plane.gmane.org; Thu, 13 Feb 2014 02:42:39 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751719AbaBMBme (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Wed, 12 Feb 2014 20:42:34 -0500
Received: from castro.crustytoothpaste.net ([173.11.243.49]:51832 "EHLO
	castro.crustytoothpaste.net" rhost-flags-OK-OK-OK-OK)
	by vger.kernel.org with ESMTP id S1751256AbaBMBme (ORCPT
	<rfc822;git@vger.kernel.org>); Wed, 12 Feb 2014 20:42:34 -0500
Received: from vauxhall.crustytoothpaste.net (unknown [IPv6:2001:470:1f05:79:485c:27a1:8772:5ef8])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by castro.crustytoothpaste.net (Postfix) with ESMTPSA id 9B5562807A;
	Thu, 13 Feb 2014 01:42:33 +0000 (UTC)
Mail-Followup-To: Stefan Zager <szager@chromium.org>, git@vger.kernel.org
Content-Disposition: inline
In-Reply-To: <CA+TurHgyUK5sfCKrK+3xY8AeOg0t66vEvFxX=JiA9wXww7eZXQ@mail.gmail.com>
X-Machine: Running on vauxhall using GNU/Linux on x86_64 (Linux kernel
 3.12-1-amd64)
User-Agent: Mutt/1.5.21 (2010-09-15)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/242040>


--K/NRh952CO+2tg14
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Tue, Feb 11, 2014 at 05:54:51PM -0800, Stefan Zager wrote:
> To this end, I'd like to start submitting patches that make the code
> base generally more thread-safe and thread-friendly.  Right after this
> email, I'm going to send the first such patch, which makes the global
> list of pack files (packed_git) internal to sha1_file.c.

I'm definitely interested in this if it also works on POSIX systems.  At
work, we have a 7.6 GiB repo (packed)[0], so while performance is not
bad, I certainly wouldn't object if it were better.

[0] Using du -sh.  For comparison, the Linux kernel repo is 1.4 GiB.

--=20
brian m. carlson / brian with sandals: Houston, Texas, US
+1 832 623 2791 | http://www.crustytoothpaste.net/~bmc | My opinion only
OpenPGP: RSA v4 4096b: 88AC E9B2 9196 305B A994 7552 F1BA 225C 0223 B187

--K/NRh952CO+2tg14
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: Digital signature

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1

iQIcBAEBCgAGBQJS/CMFAAoJEL9TXYEfUvaLQEAQAKfNZVR03GTiq6PgMLOvhaai
zehfy5QksJdNsbV9qtvyezTbofbSyowmvG8Hgww6oRccT+sbx3XOBr5RnU588kbm
me+dtiGF9U5GiLwLLbKsXBUs+7AYngfOJi3OSuHhbDQzLZV1N/rlj7oRO+JNxji/
cEOv2b8z5HsxLbSikeKJANB+07I6ic1PMWz4vlty/gxz1RfU7kRPI3WihRzRzE6p
xworQe68zL3mvRLosyS580zSqBeaZ4DXsK2Y7t/dXee+hyBTH8jOMln9HDGmFx9O
lD2m+zOlz57lxw4zcojE8Pb5cIz2atyEhq0JBz7Whlz3W5gcp+mn0gyIA2lYVaeC
jZM7eibkwHsejcVfnvIPzIzwlPA0vB3cXX6r6TJDVjoT1HmO6FmZVwPIcnSoM3rm
MUO1ZMU2dUvaC4i47yvg6YgFrG+mqbEuPh9hnQKiNvFsirJus3TJIm9+6vL2jhCA
drpsVySmsP0CxweMUkB3e7kNRGHRNd3f8ZmDtVUENpbx2si8AmDxUDz9Gv6YE1fW
6+F0yRsM+iR86gxxD/gP33WlSbi8CC8Sm9iGBwP4ka6Zr9hZgAWbPTNg/RxoR4mW
eyfeQ7KumjmIpGW8DwSxa14sP9KINbxKBvVBlOV0sASdNtjl4x6/o37+BCG0mz3l
ZdzZHYKIOLrQhVp8I204
=Mjkc
-----END PGP SIGNATURE-----

--K/NRh952CO+2tg14--
