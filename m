From: "brian m. carlson" <sandals@crustytoothpaste.net>
Subject: Re: [PATCH] create_delta_index: simplify condition always evaluating
 to true
Date: Fri, 16 Aug 2013 11:43:46 +0000
Message-ID: <20130816114346.GC5123@vauxhall.crustytoothpaste.net>
References: <1376595460-6546-1-git-send-email-stefanbeller@googlemail.com>
Mime-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha512;
	protocol="application/pgp-signature"; boundary="E/DnYTRukya0zdZ1"
Cc: git@vger.kernel.org, gitster@pobox.com
To: Stefan Beller <stefanbeller@googlemail.com>
X-From: git-owner@vger.kernel.org Fri Aug 16 13:44:00 2013
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1VAIRj-0007DC-Gm
	for gcvg-git-2@plane.gmane.org; Fri, 16 Aug 2013 13:43:59 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1755058Ab3HPLny (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Fri, 16 Aug 2013 07:43:54 -0400
Received: from castro.crustytoothpaste.net ([173.11.243.49]:45871 "EHLO
	castro.crustytoothpaste.net" rhost-flags-OK-OK-OK-OK)
	by vger.kernel.org with ESMTP id S1753957Ab3HPLnx (ORCPT
	<rfc822;git@vger.kernel.org>); Fri, 16 Aug 2013 07:43:53 -0400
Received: from vauxhall.crustytoothpaste.net (unknown [IPv6:2001:470:1f05:79:6680:99ff:fe4f:73a0])
	by castro.crustytoothpaste.net (Postfix) with ESMTPSA id A891028072;
	Fri, 16 Aug 2013 11:43:50 +0000 (UTC)
Content-Disposition: inline
In-Reply-To: <1376595460-6546-1-git-send-email-stefanbeller@googlemail.com>
X-Machine: Running on vauxhall using GNU/Linux on x86_64 (Linux kernel
 3.11-rc4-amd64)
User-Agent: Mutt/1.5.21 (2010-09-15)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/232420>


--E/DnYTRukya0zdZ1
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Thu, Aug 15, 2013 at 09:37:40PM +0200, Stefan Beller wrote:
> When checking the previous lines in that function, we can deduct that
> hsize must always be smaller than (1u<<31), since 506049c7df2c6
> (fix >4GiB source delta assertion failure), because the entries is

the entries are

> capped at an upper bound of 0xfffffffeU, so hsize contains a maximum
> value of 0x3fffffff, which is smaller than (1u<<31), so i will never
> be larger than 31.

--=20
brian m. carlson / brian with sandals: Houston, Texas, US
+1 832 623 2791 | http://www.crustytoothpaste.net/~bmc | My opinion only
OpenPGP: RSA v4 4096b: 88AC E9B2 9196 305B A994 7552 F1BA 225C 0223 B187

--E/DnYTRukya0zdZ1
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: Digital signature

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1.4.14 (GNU/Linux)

iQIcBAEBCgAGBQJSDhByAAoJEL9TXYEfUvaLo6MQAIVNJMY/u6DENOTcKbh7r80x
06UvnNEManNbFyuW5HsEl8AkWufvgsl7g8hD00DJHamTJ363MVkiMhjikP1m3g3T
uskhXf9a0hchYQCvOKf0KmY7azDk+mfCq6YQJ1V7KKljcp7hBv+kWoVvZLpW2X+s
lFzeWq4N2dKT9BSWaMa88gxx1+p0L7tZnoJRdO9wPcc59mHH0+TuJ6iUu5WL2YW0
XgDNc0yXnmoX39lKd8a+XbW7Ba6236vrdOZdqDwKiByc+Iv+77Q1QMJsIRYWNMsr
NmPzGjoO+95WhMjL89xHMiYvYin07Ik3GdzY1fLZ3ENoP+Iomn+U243IszOIfoM5
eNBZqf2RlLxPLc229vVG2fUIJDxQPuvAiE4ImunO6MrbFKpEqufWHhCkg305/6tk
dm4xf+rgA4poS2dhHxFTvnOADbAxwJNm4gIc/9q08HYZVCVuMDyRDf3JSYrirzj5
X1sMUAN191jiBuEGHCtTB0AY0+bisxze8T92ycHzJIYHsbT7uFVLEfaNk1d1rrBg
BO2WaMp2MbTCJFdhrNR8uNplMV+9WjO0Sv61+PvLxPCnc9XrQCR0e/DOcx/vi9fl
cp2yInx5D7mDC/+TOXGFdFLBEplcgdXEktccPfw2pqQ/cQsaliqGaAV+vh/J7Pec
82x37S00vQS1QTf1ntsD
=Y5es
-----END PGP SIGNATURE-----

--E/DnYTRukya0zdZ1--
