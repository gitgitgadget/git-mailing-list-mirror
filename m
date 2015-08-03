From: "brian m. carlson" <sandals@crustytoothpaste.net>
Subject: Re: [PATCH v2 00/10] object_id part 2
Date: Mon, 3 Aug 2015 23:45:36 +0000
Message-ID: <20150803234536.GC581651@vauxhall.crustytoothpaste.net>
References: <1434233803-422442-1-git-send-email-sandals@crustytoothpaste.net>
 <55BEA8E4.7040902@alum.mit.edu>
Mime-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha512;
	protocol="application/pgp-signature"; boundary="C+ts3FVlLX8+P6JN"
Cc: git@vger.kernel.org, Jeff King <peff@peff.net>,
	=?utf-8?B?Tmd1eeG7hW4gVGjDoWkgTmfhu41j?= Duy <pclouds@gmail.com>
To: Michael Haggerty <mhagger@alum.mit.edu>
X-From: git-owner@vger.kernel.org Tue Aug 04 01:45:48 2015
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1ZMPQR-0000WI-H5
	for gcvg-git-2@plane.gmane.org; Tue, 04 Aug 2015 01:45:47 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1755567AbbHCXpn (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Mon, 3 Aug 2015 19:45:43 -0400
Received: from castro.crustytoothpaste.net ([173.11.243.49]:37674 "EHLO
	castro.crustytoothpaste.net" rhost-flags-OK-OK-OK-OK)
	by vger.kernel.org with ESMTP id S1751538AbbHCXpm (ORCPT
	<rfc822;git@vger.kernel.org>); Mon, 3 Aug 2015 19:45:42 -0400
Received: from vauxhall.crustytoothpaste.net (unknown [IPv6:2001:470:1f05:79:f2de:f1ff:feb8:36fd])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by castro.crustytoothpaste.net (Postfix) with ESMTPSA id CB42B2808D;
	Mon,  3 Aug 2015 23:45:41 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=simple/simple; d=crustytoothpaste.net;
	s=default; t=1438645541;
	bh=k15R6HdiK/dOauHpKolj22cgkNBD3YkdYX2Oe2wGg+o=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=jtaY4MtceGUzIrlPVMxQYPQbu9cE+a33MbHwHslU4BahPJnuZ7mMX3Hxb1DHQhH72
	 FmZC2LFkT+rTKrVRcUUTxAV9wA8aLta2x+mjGyPe5MijbGt1y6bnwcCHwXg/Tf+aop
	 +rlZ0Oq2A2uNFNzj6OuplZ3zkapmZJRo/m5SJNhxT7/f448mIkldM/Yj/Pt9fBIXFr
	 BXgiGQMXJDEqZJr6uqVOFr67++q15BZMaOUha3/88Fr2WTz+miJdBggS93QL7NW93l
	 hw0OreV7WQKf6DKeaMo5nacTJkgxFkdz5fqksPQVbIWbXCgDHVW5KTTp4fcwaaiAvl
	 9b6C4TBrs9JfDs2QFdD8tW/XszaDsIv5UBH5xLt+w018SNxuSTh+P5O6RCDbCTH0/l
	 qj1PT0Sh7SdGQz5R5T5XRWNHC9barTovMgAH4hpEs3+3IrSI8xbZW0RIKX6eN32ihe
	 8VpnDztxA+KAj9m8TlzdIvuteaDS7CrosO7TGKG1BSGRJIHpjbX
Mail-Followup-To: "brian m. carlson" <sandals@crustytoothpaste.net>,
	Michael Haggerty <mhagger@alum.mit.edu>, git@vger.kernel.org,
	Jeff King <peff@peff.net>,
	=?utf-8?B?Tmd1eeG7hW4gVGjDoWkgTmfhu41j?= Duy <pclouds@gmail.com>
Content-Disposition: inline
In-Reply-To: <55BEA8E4.7040902@alum.mit.edu>
X-Machine: Running on vauxhall using GNU/Linux on x86_64 (Linux kernel
 4.0.0-2-amd64)
User-Agent: Mutt/1.5.23 (2014-03-12)
X-Spam-Score: -0.272 BAYES_00,RDNS_NONE
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/275230>


--C+ts3FVlLX8+P6JN
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Mon, Aug 03, 2015 at 01:33:56AM +0200, Michael Haggerty wrote:
> Brian, what was your experience when writing these patches? Did they
> tend to work as soon as they compiled without errors (i.e., not super
> risky) or did you often have test suite failures that you had to go back
> and fix (i.e., risky)? If the latter, what kinds of code patterns tended
> to be problematic? Your answers might help reviewers decide how much
> diligence is needed when reviewing these patches and what kind of
> changes to inspect extra carefully. Because doing a thorough review of
> all of the patches would be quite a bit of work.

In this particular branch, I think I may have had one bad patch.  (I'm
trying to recall because I've been working on patches for part 3 in the
mean time, and they all seem to group together.)  In general, over all
my patches, the conversions I've had to fix the most have been the ones
to use the GIT_SHA1_* constants, because it's very easy to get
off-by-one errors in there or mess up the values such that things break.
Extra effort on those, or additional suggestions on how to make them
cleaner and less brittle, both now and in the future, would be welcome.
--=20
brian m. carlson / brian with sandals: Houston, Texas, US
+1 832 623 2791 | http://www.crustytoothpaste.net/~bmc | My opinion only
OpenPGP: RSA v4 4096b: 88AC E9B2 9196 305B A994 7552 F1BA 225C 0223 B187

--C+ts3FVlLX8+P6JN
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: Digital signature

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v2.1.6 (GNU/Linux)

iQIcBAEBCgAGBQJVv/0gAAoJEL9TXYEfUvaL3mcQAIkmjgRH+d07DHu2d1D1gVk2
QSdlkI/drIYwfDvbscJAKnZRFaZxV4cM2lROYaRSCDThzxZYES1hlpyuigVYDA1o
LEMfd3lTW6HRIs3lP0G46rkgCILbiSD4lb4brRSU3CXTCU3M4rXkArUse86cbD2p
JNqZLU6FwFRuao+cjKfTuspLswgkuQXnFXrWbZtpm5REVuxdYu2/X2eUHbZQmAXe
pgtkIfbEbI6oUaXElXEfojNAdSPfSEMNpiVQ4wGg4PSaijJpq1zn3FX1nns0y9Fi
Qzq9EhPBC30KuI2rzEbYidmjDOn+hqtmBfKYUpJfXbLHp695HkxJ0ZgilNlTdeXV
hxq//pbNICTEJgbS0rXdojvaKSL+eYqZtUuUb87qiGh08Dgtj2B+jDgy4PCyuflp
GK8wbTuSCtNBWEXa3bY2UjP2zu8aU/49BFAMVCRzxIAEamhipfaEkP8C0rw+SxYu
28/T836uP5ievrjwvkdNjiLkc/Yga47133juoTDiYT8mpc4n4NBIw6Lnuta0uJ+d
9N/8oV3oomrj178ks0KGFa9i6K1gznMjIyrg3GaRtivRLw6Lf3laLZh/nfF/VElj
l6Shet+MBTsYK6+OtT7w6OyGDmeeQCVdZyTmsIaQxyHWerab8eZecHa69T2MDQa3
ND+Xf9Ut4+DQGNYBoWjr
=c2px
-----END PGP SIGNATURE-----

--C+ts3FVlLX8+P6JN--
