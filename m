From: "brian m. carlson" <sandals@crustytoothpaste.net>
Subject: Re: [PATCH v2 1/3] connect.c: allow ssh://user@[2001:db8::1]/repo.git
Date: Mon, 23 Feb 2015 00:23:16 +0000
Message-ID: <20150223002316.GB514544@vauxhall.crustytoothpaste.net>
References: <54E8A9D0.30108@web.de>
 <xmqqwq39vit7.fsf@gitster.dls.corp.google.com>
Mime-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha512;
	protocol="application/pgp-signature"; boundary="zx4FCpZtqtKETZ7O"
Cc: Torsten =?utf-8?Q?B=C3=B6gershausen?= <tboegi@web.de>,
	git@vger.kernel.org, lists@hcf.yourweb.de
To: Junio C Hamano <gitster@pobox.com>
X-From: git-owner@vger.kernel.org Mon Feb 23 01:23:29 2015
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1YPgo5-0001wD-Ce
	for gcvg-git-2@plane.gmane.org; Mon, 23 Feb 2015 01:23:29 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1752170AbbBWAXZ (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Sun, 22 Feb 2015 19:23:25 -0500
Received: from castro.crustytoothpaste.net ([173.11.243.49]:49184 "EHLO
	castro.crustytoothpaste.net" rhost-flags-OK-OK-OK-OK)
	by vger.kernel.org with ESMTP id S1752109AbbBWAXY (ORCPT
	<rfc822;git@vger.kernel.org>); Sun, 22 Feb 2015 19:23:24 -0500
Received: from vauxhall.crustytoothpaste.net (unknown [IPv6:2001:470:1f05:79:dde5:8ef1:d645:2bbf])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by castro.crustytoothpaste.net (Postfix) with ESMTPSA id 406E72808F;
	Mon, 23 Feb 2015 00:23:22 +0000 (UTC)
Mail-Followup-To: "brian m. carlson" <sandals@crustytoothpaste.net>,
	Junio C Hamano <gitster@pobox.com>,
	Torsten =?utf-8?Q?B=C3=B6gershausen?= <tboegi@web.de>,
	git@vger.kernel.org, lists@hcf.yourweb.de
Content-Disposition: inline
In-Reply-To: <xmqqwq39vit7.fsf@gitster.dls.corp.google.com>
X-Machine: Running on vauxhall using GNU/Linux on x86_64 (Linux kernel
 3.19.0-trunk-amd64)
User-Agent: Mutt/1.5.23 (2014-03-12)
X-Spam-Score: -0.272 BAYES_00,RDNS_NONE
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/264243>


--zx4FCpZtqtKETZ7O
Content-Type: text/plain; charset=us-ascii; format=flowed
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Sun, Feb 22, 2015 at 11:37:40AM -0800, Junio C Hamano wrote:
>Let me double check if I understand Brian and the above correctly:
>
> * The original 2386d658 (Add first cut at "git protocol" connect
>   logic., 2005-07-13) did not even care that the IPv6 syntax was
>   valid or not, and worse yet, it did not correctly handle literal
>   addresses in brackets;
>
> * Later we started supporting literal addresses in brackets, but
>   "user@[literal]:port" form did not work.  Instead, a bug in the
>   parser allowed "[user@literal]:port" (which is not a valid way to
>   spell such things) to work as if it were "user@[literal]:port",
>   which is what users would expect.
>
> * This three-patch series is an attempt to allow that kosher
>   syntax, "user@[literal]:port", to work.

Yes.  My overwhelming concern is that this work, because this is the=20
syntax we want people to use and that they will expect to work based on=20
the standards, other software, and Git using HTTPS.

> * It does not terribly matter if we broke the invalid syntax
>   "user@literal:port" without brackets, and it might even be
>   beneficial if we declared such addresses invalid and deprecated
>   for the sake of uniformity with other protocols.  Making that
>   judgement, however, is outside the scope of this series.
>   "user@literal:port" will continue to behave as it did before.

That's an accurate assessment of my position.

>Is that what is going on?
>
>If that is the case, I think it addresses Brian's concern well.

Yes, if that's the case, it addresses my concern.
--=20
brian m. carlson / brian with sandals: Houston, Texas, US
+1 832 623 2791 | http://www.crustytoothpaste.net/~bmc | My opinion only
OpenPGP: RSA v4 4096b: 88AC E9B2 9196 305B A994 7552 F1BA 225C 0223 B187

--zx4FCpZtqtKETZ7O
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: Digital signature

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1

iQIcBAEBCgAGBQJU6nL0AAoJEL9TXYEfUvaLC8YP/0yWsCC9NFqVwn/ciI3YNUKr
emeIcOUED18ApHo8gQYfhSRtRiT/lsND/2UcCUppezE4Cl1NvOR3NxNlJXoJL+7r
lwrq3VyXZhcqp2Ux6c3RVFTE/fWULkaLufZFduWoEz/+WvyiW5XnsGPq+UuSbY/j
HX8K76vqZpelXerihTlleQDPeBXKSVq+gY7XrfFlFSuK54tzpJwkQC9eBJ95TfLt
8/X7R3lDWugsRQgUurSUqYF8Zh3SYCLsdlepOmY/TIaENRmOLdbKVsuZNd0T4rDp
DPaqJC3ixjZN+WXFxHoJs16M2zUqRm9QTIirx1+T09yolY/9U4HGzfuGIo67ougd
h8FHL9CeQQybayYgbSSBrjAf3l0P4Mrl0/8R1CgTZ7gB+QQZA+rLX6tkDjc8s/Zm
XiIup6cNEP9/SpLAA+eHTv4gYUp77AOFJXPWcXdeMxAOeQ4mp/7xAX4Y5xkDkjIq
bWXaU9Z/MPb3jRLQhTPbD7TVGafjzXMc6xx3Is96xXbBXK9/gwhebkeV2zxRd7pX
XXg6/gyJmm96cxuoBGC43s9Nf0rgMK9Iu35PM7NxHxFuxkKIw9nusJjWVVd8PPhO
Cf03LDk25DZBL+ffGqgXYy199fWEFpOpC1Z4PHI1MxZNd/igqZKbW05zdH6vYDfE
5yubTA9TBnsqDpTZQLOF
=oYbO
-----END PGP SIGNATURE-----

--zx4FCpZtqtKETZ7O--
