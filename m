From: "brian m. carlson" <sandals@crustytoothpaste.net>
Subject: Re: [PATCH v3 01/13] refs: convert some internal functions to use
 object_id
Date: Wed, 14 Oct 2015 02:50:06 +0000
Message-ID: <20151014025006.GC208451@vauxhall.crustytoothpaste.net>
References: <1444355039-186351-1-git-send-email-sandals@crustytoothpaste.net>
 <1444355039-186351-2-git-send-email-sandals@crustytoothpaste.net>
 <561CEE62.4030403@alum.mit.edu>
Mime-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha512;
	protocol="application/pgp-signature"; boundary="69pVuxX8awAiJ7fD"
Cc: git@vger.kernel.org, Jeff King <peff@peff.net>,
	=?utf-8?B?Tmd1eeG7hW4gVGjDoWkgTmfhu41j?= Duy <pclouds@gmail.com>
To: Michael Haggerty <mhagger@alum.mit.edu>
X-From: git-owner@vger.kernel.org Wed Oct 14 04:50:23 2015
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1ZmC8x-0003VE-VQ
	for gcvg-git-2@plane.gmane.org; Wed, 14 Oct 2015 04:50:20 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751752AbbJNCuO (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Tue, 13 Oct 2015 22:50:14 -0400
Received: from castro.crustytoothpaste.net ([173.11.243.49]:34364 "EHLO
	castro.crustytoothpaste.net" rhost-flags-OK-OK-OK-OK)
	by vger.kernel.org with ESMTP id S1750852AbbJNCuN (ORCPT
	<rfc822;git@vger.kernel.org>); Tue, 13 Oct 2015 22:50:13 -0400
Received: from vauxhall.crustytoothpaste.net (unknown [IPv6:2001:470:1f05:79:f2de:f1ff:feb8:36fd])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by castro.crustytoothpaste.net (Postfix) with ESMTPSA id 7DB7B28094;
	Wed, 14 Oct 2015 02:50:11 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=simple/simple; d=crustytoothpaste.net;
	s=default; t=1444791011;
	bh=Lxln+9VOo4TloXSf8z5u0hUBr6xq38Vys23nx3rdKVY=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=pZdgxChKfQpHtPgVlLQ9VFrJyQscX+dnSAqIxaUFR/5Jfq6Sijc8WpwArvQQJZaJ1
	 MEPol40F9kgdFAMvBo1gfQEvamJ6TuGjOSgWFH12y1bTISvdQ9MY1r0bV+2Mfn2Vkx
	 yADpkolS2UC3fsJsDbkqD3ksWoDrk4xqiWyV1aXsUBUYB0n9Ml+JJH0l2Z0mSwsz58
	 fh8EwtPG4YLhFTAMi7C57j+BI/uGfiwexdukXYe8eCTUo6Op4ThNsasgMrQNwXqhPM
	 47LQML31uc8P66ua+/9a6uDjjhFJNCEW4+gFFfpb+zE+1tTyzE4v5X/HpdzkNlMmGy
	 crjsANo81CMn5iuAlCGQemCgANdWSkRoxyA1hv/97tZcEsxNFoVah8qnWxyEaumwzI
	 o0ZqyemUJmwYuU15NYvrgNiFZhFFzXbi6WEttn9k6ETFj57Mx/Gz0824X2RO56l711
	 8PCoTFWyXNyOGkAfKeYALIbos34PoM+Z0TfDWtaIICsUfm/zP27
Mail-Followup-To: "brian m. carlson" <sandals@crustytoothpaste.net>,
	Michael Haggerty <mhagger@alum.mit.edu>, git@vger.kernel.org,
	Jeff King <peff@peff.net>,
	=?utf-8?B?Tmd1eeG7hW4gVGjDoWkgTmfhu41j?= Duy <pclouds@gmail.com>
Content-Disposition: inline
In-Reply-To: <561CEE62.4030403@alum.mit.edu>
X-Machine: Running on vauxhall using GNU/Linux on x86_64 (Linux kernel
 4.2.0-1-amd64)
User-Agent: Mutt/1.5.24 (2015-08-30)
X-Spam-Score: -0.272 BAYES_00,RDNS_NONE
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/279561>


--69pVuxX8awAiJ7fD
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Tue, Oct 13, 2015 at 01:43:30PM +0200, Michael Haggerty wrote:
> On 10/09/2015 03:43 AM, brian m. carlson wrote:
> > Convert several internal functions in refs.c to use struct object_id,
> > and use the GIT_SHA1_HEXSZ constants in parse_ref_line.
> >=20
> > Signed-off-by: brian m. carlson <sandals@crustytoothpaste.net>
> > [...]
>=20
> I looked over this patch at the diff level and didn't find any problems.
>=20
> This patch conflicts heavily with [1]. But I noticed that it is
> independent of the rest of your series. I don't know when either patch
> series will be ready, but see [2] for my take on the other one.
>=20
> Assuming neither series is rejected, I think it would be much easier to
> redo this patch on top of the first part of [1] than vice versa, so that
> would be my suggestion. If it comes down to that, I am willing to help
> redo this patch if you like.

I'll take a look at it over the next couple of days.  I'll probably drop
it from this series and either see if it can be put on top of the other
one, or defer it to a future series.  That way we can minimize
conflicts.
--=20
brian m. carlson / brian with sandals: Houston, Texas, US
+1 832 623 2791 | https://www.crustytoothpaste.net/~bmc | My opinion only
OpenPGP: RSA v4 4096b: 88AC E9B2 9196 305B A994 7552 F1BA 225C 0223 B187

--69pVuxX8awAiJ7fD
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v2.1.8 (GNU/Linux)

iQIcBAEBCgAGBQJWHcLeAAoJEL9TXYEfUvaLAQUP/RXJOvV6KjkW+EObwPnc4NU/
YH5bu/lbKz4g9vC2NAc3ggm3qZQ6ZCCSgN8zwT7gvFQ2dpNGJR5HPX3ev4v/J7Jv
UpHd9lvvqGNAGc3PvaNRl+PYvGRDjLOV8XxMKmiEMhkyknKgLaQVxqsn/27dH4Bf
oxBX7TN7vMUeytUhkuwq6jpdR08JrqWfyUfUhhVX62nq9uY+zbUl8mAYWpb3ItNk
jp8CJnViIPw4RXVsUFJfR8ITX48fIlYKqtKbLxndv+WSieL8017wEkyWL1eZqwOp
j83rg8f4S9sFqUAXVzO3iw+i9pmm3YRj5+XNXR4o8wLkZFAcPCm/sPBR8Z2/ZD43
SJcmBeBxbC8xK1x+7SqdehbZ91IZPjRCiWCeOSiOGpkx6eG0Nis/4U3Wl2F5LmiD
XsISHyP8STqcUPP7Z0IesqKcnDNAHDm4iO/mgVdaJQFDM5Jm6HP33BgjegkRb5Xh
Y0UyCZ/8gxCeIYhTW/B7Cqijj/saKXwfLgMyv07jKACBCxXJD8SMlgixPmbiWgFH
Zd2Q6hm4FvnFxnYSvlMycap59KcSWYaD9MZ65Si2Gr8BwchKy911S9VM4u1z2tjL
48ottlHMgj4VeqTHhowsZEz8Q2oMCg6fVd4RsFKT5f1lPj1EJWcQNf6XlxMMvEZO
VRb1HNLZxeb/tSRas5hL
=c6N9
-----END PGP SIGNATURE-----

--69pVuxX8awAiJ7fD--
