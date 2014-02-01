From: "brian m. carlson" <sandals@crustytoothpaste.net>
Subject: Re: Performance regression in git fetch between 1.8.3.4 and 1.8.5.3
Date: Sat, 1 Feb 2014 00:41:28 +0000
Message-ID: <20140201004128.GA635004@vauxhall.crustytoothpaste.net>
References: <20140131210154.GA632399@vauxhall.crustytoothpaste.net>
 <20140131213505.GA21264@sigill.intra.peff.net>
Mime-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha512;
	protocol="application/pgp-signature"; boundary="OXfL5xGRrasGEqWY"
Cc: git@vger.kernel.org
To: Jeff King <peff@peff.net>
X-From: git-owner@vger.kernel.org Sat Feb 01 01:41:50 2014
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1W9OeX-0004L9-Ln
	for gcvg-git-2@plane.gmane.org; Sat, 01 Feb 2014 01:41:46 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1754516AbaBAAlf (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Fri, 31 Jan 2014 19:41:35 -0500
Received: from castro.crustytoothpaste.net ([173.11.243.49]:51531 "EHLO
	castro.crustytoothpaste.net" rhost-flags-OK-OK-OK-OK)
	by vger.kernel.org with ESMTP id S1754120AbaBAAle (ORCPT
	<rfc822;git@vger.kernel.org>); Fri, 31 Jan 2014 19:41:34 -0500
Received: from vauxhall.crustytoothpaste.net (unknown [IPv6:2001:470:1f05:79:fd82:88d3:586c:5bd8])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by castro.crustytoothpaste.net (Postfix) with ESMTPSA id 1BFFD28071;
	Sat,  1 Feb 2014 00:41:32 +0000 (UTC)
Mail-Followup-To: Jeff King <peff@peff.net>, git@vger.kernel.org
Content-Disposition: inline
In-Reply-To: <20140131213505.GA21264@sigill.intra.peff.net>
X-Machine: Running on vauxhall using GNU/Linux on x86_64 (Linux kernel
 3.12-1-amd64)
User-Agent: Mutt/1.5.21 (2010-09-15)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/241326>


--OXfL5xGRrasGEqWY
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Fri, Jan 31, 2014 at 04:35:05PM -0500, Jeff King wrote:
> On Fri, Jan 31, 2014 at 09:02:15PM +0000, brian m. carlson wrote:
>=20
> > At work, we recently upgraded our git version from 1.8.3.4 to 1.8.5.3.
> > We've noticed a significant performance regression in git fetch.  The
> > numbers below are for an up-to-date branch (that is, no data is actually
> > being fetched) for a git-over-ssh remote on our gitorious server.
>=20
> Is it better with v1.9-rc1? There was a slowdown in v1.8.4.2 that I
> addressed with commit 200abe7 (which is slated for v1.9).

Yes.  The time is much lower with 1.9-rc1:

  brianc ok # for i in `seq 1 3`; do time git fetch; done
  git fetch  0.90s user 0.18s system 74% cpu 1.447 total
  git fetch  0.88s user 0.20s system 74% cpu 1.456 total
  git fetch  0.88s user 0.19s system 74% cpu 1.438 total

I'll open a case to get it updated once 1.9 is finally released.  Thanks
for your suggestion.

--=20
brian m. carlson / brian with sandals: Houston, Texas, US
+1 832 623 2791 | http://www.crustytoothpaste.net/~bmc | My opinion only
OpenPGP: RSA v4 4096b: 88AC E9B2 9196 305B A994 7552 F1BA 225C 0223 B187

--OXfL5xGRrasGEqWY
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: Digital signature

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1

iQIbBAEBCgAGBQJS7EK3AAoJEL9TXYEfUvaLFDkP+OCE9iPWD2EWdzOrSJXsuTHM
fSbq5FUY/QVncxG8TSCL0weg4SjkxWe0SUrMJwMJwlNA8jVJtX2szi5eLac99m/D
CCFu6QeVHicVaJvt5uzwAgTFgPsT7mLgUB6LDXkv6SeNSvdLDnv0tzGjjFXIgWDX
PH3zH/cwkiDHoXGim6Z5MVyyx9edZ2Gu4j/ayexOvuPd0DSlfsqOhT1MSrI82rHe
JT+DRppwtmSkllKfEKxsAXuvpJCkSFnt8cQXC50w7DJAcKL3bq3aqbrx3Nw/PQb4
8OumwD5BYD5gBVPaKDsXrZmMqdf4zf9e4jHVCACdh7iQE36bGTgKZf3jCUg9NYwV
p10xOdgCi1ZVlTz/2ldq2Baajx6aK9OprRdkSIyYvKXTr4h5ldaljY82pLvA/SwM
jisMhx4TkauG4XLuIG6MzCggP2xlheE5sihwCSjvYeHXw+BXwXat7UgYg2ZXfpQq
FQA7HIW5QfEFfMi97Q6JqE/zXNjaNBLyQ32T3+Z7wAa/ZzKwYSHQngU4N66cg56D
GXxxFLI9/FrvQzzcNVlivjCTfBH22/RFo2ZbqNOxPi9y9H/CWnlQzTK5wbgeigsQ
J+AdTiftcAV+gyQfmV6YIczJB7iXAXL7FESkU2GHLYC7SwHv54bvOlLCnha+4tb7
+WEMfEkxNxHKRbPVbbA=
=PNfE
-----END PGP SIGNATURE-----

--OXfL5xGRrasGEqWY--
