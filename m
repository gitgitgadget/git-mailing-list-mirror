From: "brian m. carlson" <sandals@crustytoothpaste.net>
Subject: Re: [PATCH] Documentation: fix version numbering
Date: Thu, 22 Jan 2015 20:28:02 +0000
Message-ID: <20150122202802.GC96498@vauxhall.crustytoothpaste.net>
References: <1421955153-14066-1-git-send-email-svenvh@gmail.com>
Mime-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha512;
	protocol="application/pgp-signature"; boundary="NU0Ex4SbNnrxsi6C"
Cc: git@vger.kernel.org
To: Sven van Haastregt <svenvh@gmail.com>
X-From: git-owner@vger.kernel.org Thu Jan 22 21:28:13 2015
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1YEOMP-0006I8-B6
	for gcvg-git-2@plane.gmane.org; Thu, 22 Jan 2015 21:28:13 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1752847AbbAVU2J (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Thu, 22 Jan 2015 15:28:09 -0500
Received: from castro.crustytoothpaste.net ([173.11.243.49]:43397 "EHLO
	castro.crustytoothpaste.net" rhost-flags-OK-OK-OK-OK)
	by vger.kernel.org with ESMTP id S1752442AbbAVU2I (ORCPT
	<rfc822;git@vger.kernel.org>); Thu, 22 Jan 2015 15:28:08 -0500
Received: from vauxhall.crustytoothpaste.net (unknown [IPv6:2001:470:1f05:79:c8c4:ec20:e47c:f338])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by castro.crustytoothpaste.net (Postfix) with ESMTPSA id E06432808F;
	Thu, 22 Jan 2015 20:28:05 +0000 (UTC)
Mail-Followup-To: "brian m. carlson" <sandals@crustytoothpaste.net>,
	Sven van Haastregt <svenvh@gmail.com>, git@vger.kernel.org
Content-Disposition: inline
In-Reply-To: <1421955153-14066-1-git-send-email-svenvh@gmail.com>
X-Machine: Running on vauxhall using GNU/Linux on x86_64 (Linux kernel
 3.16.0-4-amd64)
User-Agent: Mutt/1.5.23 (2014-03-12)
X-Spam-Score: -0.272 BAYES_00,RDNS_NONE
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/262869>


--NU0Ex4SbNnrxsi6C
Content-Type: text/plain; charset=us-ascii; format=flowed
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Thu, Jan 22, 2015 at 07:32:33PM +0000, Sven van Haastregt wrote:
>Version numbers in asciidoc-generated content (such as man pages)
>went missing as of da8a366 (Documentation: refactor common operations
>into variables).  Fix by putting the underscore back in the variable
>name.
>
>Signed-off-by: Sven van Haastregt <svenvh@gmail.com>
>---
> Documentation/Makefile | 2 +-
> 1 file changed, 1 insertion(+), 1 deletion(-)
>
>diff --git a/Documentation/Makefile b/Documentation/Makefile
>index 2f6b6aa..3e39e28 100644
>--- a/Documentation/Makefile
>+++ b/Documentation/Makefile
>@@ -103,7 +103,7 @@ ASCIIDOC_HTML =3D xhtml11
> ASCIIDOC_DOCBOOK =3D docbook
> ASCIIDOC_CONF =3D -f asciidoc.conf
> ASCIIDOC_COMMON =3D $(ASCIIDOC) $(ASCIIDOC_EXTRA) $(ASCIIDOC_CONF) \
>-		-agit-version=3D$(GIT_VERSION)
>+		-agit_version=3D$(GIT_VERSION)

Yes, this does seem to fix it.  My apologies for the bug, and thanks for=20
noticing.
--=20
brian m. carlson / brian with sandals: Houston, Texas, US
+1 832 623 2791 | http://www.crustytoothpaste.net/~bmc | My opinion only
OpenPGP: RSA v4 4096b: 88AC E9B2 9196 305B A994 7552 F1BA 225C 0223 B187

--NU0Ex4SbNnrxsi6C
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: Digital signature

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1

iQIcBAEBCgAGBQJUwV1SAAoJEL9TXYEfUvaLObMP/iSDN2MlFhx+Q1uAKdaBetO1
4wrTtGOkZtbzpG3gv+Lq3gjVFuzza2L591Uc/mNOdK89U1C3SRue1IptZPDdKKg+
WFFl08hsrtFG3EDeKu/YKOapPvgxnxaP+y+HIIy0UuZIp3e1BqEbmAJsBcUlyBMY
+BqxHxOmeHNcWNZ0SSif0XuwLfYoX80rE3ErMfSdiDFJUHtBucrTN5NpaAZ5RrV/
ANm0PYVTI7Ga8RORHuuKhsmGZ/s1IoW1VqxXjQqPrCx83xewxwaNL/bONRB74dt+
/XKi6sX8W3ygH339Ut48EzW8izXOYjRaH72wbnoEcD/kw0MkrZT28Bvh0ozzS5Ss
Y/GeCAtRUU2NX0Bn17Y1nnL2i0XAeXM2STMJVFNHAdLzoM72GCC4JYuYjYSEBh5x
DxNVQzh7xpZwPOaKWdj7YAOb5H6zwDVpXT6mtNKhLk88x10meShNubGz/mYUvYEB
Zgq8PSnbRTWGrViDz/APR4ErsGSaWmUwMH99pMh6SKk+m7wSFIt8o6w9iA7nZwmL
l/WxMGfeTtA8gRI51abgofEy53ei4nxi7hT/Qi6rj00uwxgIEO85Ib1SqPNSNlzK
/rn2a1+ZzidmOkT0byAe0TnrczaM5EKCwqCWZSZaxSHFnbpZEPPewR615ReTQDMC
e0DUtbnkFmdzQSo/Q8Pp
=5bGC
-----END PGP SIGNATURE-----

--NU0Ex4SbNnrxsi6C--
