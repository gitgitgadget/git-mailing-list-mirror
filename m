From: "brian m. carlson" <sandals@crustytoothpaste.net>
Subject: Re: [PATCH 3/4] cat-file: add --batch-disk-sizes option
Date: Sun, 7 Jul 2013 21:15:41 +0000
Message-ID: <20130707211538.GB6478@vauxhall.crustytoothpaste.net>
References: <20130707100133.GA18717@sigill.intra.peff.net>
 <20130707100949.GC19143@sigill.intra.peff.net>
Mime-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha512;
	protocol="application/pgp-signature"; boundary="JYK4vJDZwFMowpUq"
Cc: git@vger.kernel.org
To: Jeff King <peff@peff.net>
X-From: git-owner@vger.kernel.org Sun Jul 07 23:16:13 2013
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1UvwJZ-0000NV-64
	for gcvg-git-2@plane.gmane.org; Sun, 07 Jul 2013 23:16:13 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1753180Ab3GGVPx (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Sun, 7 Jul 2013 17:15:53 -0400
Received: from qmta06.westchester.pa.mail.comcast.net ([76.96.62.56]:36496
	"EHLO qmta06.westchester.pa.mail.comcast.net" rhost-flags-OK-OK-OK-OK)
	by vger.kernel.org with ESMTP id S1753170Ab3GGVPw (ORCPT
	<rfc822;git@vger.kernel.org>); Sun, 7 Jul 2013 17:15:52 -0400
Received: from omta07.westchester.pa.mail.comcast.net ([76.96.62.59])
	by qmta06.westchester.pa.mail.comcast.net with comcast
	id xZED1l0031GhbT856ZFmZm; Sun, 07 Jul 2013 21:15:46 +0000
Received: from castro.crustytoothpaste.net ([173.11.243.49])
	by omta07.westchester.pa.mail.comcast.net with comcast
	id xZFl1l00W14fh3h3TZFlTb; Sun, 07 Jul 2013 21:15:46 +0000
Received: from vauxhall.crustytoothpaste.net (unknown [IPv6:2001:470:1f05:79:6680:99ff:fe4f:73a0])
	by castro.crustytoothpaste.net (Postfix) with ESMTPSA id E394928073;
	Sun,  7 Jul 2013 21:15:44 +0000 (UTC)
Content-Disposition: inline
In-Reply-To: <20130707100949.GC19143@sigill.intra.peff.net>
X-Machine: Running on vauxhall using GNU/Linux on x86_64 (Linux kernel
 3.10-rc7-amd64)
User-Agent: Mutt/1.5.21 (2010-09-15)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=comcast.net;
	s=q20121106; t=1373231746;
	bh=pzcrtFmJSCdJ9+JEpwTS78i0cEf4Hbqu/ZxrEZB2WeA=;
	h=Received:Received:Received:Date:From:To:Subject:Message-ID:
	 MIME-Version:Content-Type;
	b=SmKGsj4tlU4d1gJtAtqJjV/Cz9Na9ecFCyTJe0etgx4oPou8dC1+6mRW17+AHOJmU
	 0V7DYJv7gf9gaOXXphvlEi0x5zmMbQSfpR9gUuJbmvvnWMlSt/O5iWW8FdW4SuiGe2
	 oU6/weT08mk+RE6mxC+2z4feM/v/S744rjSOuBKDX4sdVlk53p5W2nSDro6RjsSEN5
	 FWFjdhRxqeMtgxyOiULOsf6cUZZZLPDTOngAX4tpfJCQRG6LkNMB9/GOKcMXDJYTWZ
	 2LljpYB5ucl29Rf8RJHFcmxbCZ+bRGgmtLqnaDHdIYk9FcAqeAc3ZarJlbUkJdUjHj
	 0k1CbTRBdDlRQ==
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/229806>


--JYK4vJDZwFMowpUq
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Sun, Jul 07, 2013 at 06:09:49AM -0400, Jeff King wrote:
> +NOTE: The on-disk size reported is accurate, but care should be taken in
> +drawing conclusions about which refs or objects are responsible for disk
> +usage. The size of a packed non-delta object be much larger than the

You probably meant "may be" here.               ^

--=20
brian m. carlson / brian with sandals: Houston, Texas, US
+1 832 623 2791 | http://www.crustytoothpaste.net/~bmc | My opinion only
OpenPGP: RSA v4 4096b: 88AC E9B2 9196 305B A994 7552 F1BA 225C 0223 B187

--JYK4vJDZwFMowpUq
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: Digital signature

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1.4.12 (GNU/Linux)

iQIcBAEBCgAGBQJR2dp6AAoJEL9TXYEfUvaLiFEP/j7pTnkRlIcMhkURI6n60hTV
9aJ0KMCiBIk1EY090WUr+LFAldbUwPm0XNRMRUj1z+77dTsWyoDSq3zatOKQaQzj
iVaUKX9gPFiV+iu1hQpPK3XKcvOXHrpiiNmsXsQQmEW2g6unR+K40VFoVrkLEQFO
bi1APbU9QXo8zvFzO2jKcEnwdzHREGJ0hVDcEtOhVrfMxcIiKbaa7nJEqezZYYsD
g+hzI251U0uMENm+q0gFU8UmgaC3l5G36zKAamVz5ZzsPPGeDVjA2vlY290PC3xm
IE2J1mOybz2RJOXaXhtmLB3Rr0S/duLKrbGfdoA4mUo6SFuj7lQwKNlzl2NIfVIi
65LnROzM1PnKKc4oAhiL0NcCVConYwZHFerSaZzuZ+LveuBAqAYZ7hTcE4otK958
23WfARSa8BvVNSnPXVq7EGE6b4JOwuvwlk7fnXluqyGEwlkdkB+/qfmOebkt0HvP
YkDUnt9P+eDySjFbT+YWyPoZb6UhHTz/qdPNM7qQfv9FzMkNDQHT4k9u/dkkHZ1/
DMCNfJ1Nk/ZYD/S2JDwsdMzlgYT/GSxcwy36XyJUwep1qSIJRr5TtilJ6TOgzE04
loMpN93VjDoRDlXBpzsB3CATqMqv2bwy2RyH5IOjdOfQRVGDtv24HhxtvqtTQSRZ
Nq+n2WEcRbH0gMlZNhzV
=c7Rh
-----END PGP SIGNATURE-----

--JYK4vJDZwFMowpUq--
