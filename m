From: "brian m. carlson" <sandals@crustytoothpaste.net>
Subject: Re: [PATCH v3 2/4] rev-list: add an option to mark fewer edges as
 uninteresting
Date: Wed, 24 Dec 2014 21:26:40 +0000
Message-ID: <20141224212639.GC170128@vauxhall.crustytoothpaste.net>
References: <1419336082-283091-1-git-send-email-sandals@crustytoothpaste.net>
 <1419336082-283091-3-git-send-email-sandals@crustytoothpaste.net>
 <CAO2U3Qjbmz+fP-SLSeq1S+BDi4PSTSLf_TdqW-ik8GLV7=nUmA@mail.gmail.com>
 <20141223185142.GA27954@peff.net>
Mime-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha512;
	protocol="application/pgp-signature"; boundary="rQ2U398070+RC21q"
Cc: Michael Blume <blume.mike@gmail.com>,
	Git List <git@vger.kernel.org>, Duy Nguyen <pclouds@gmail.com>,
	Junio C Hamano <gitster@pobox.com>
To: Jeff King <peff@peff.net>
X-From: git-owner@vger.kernel.org Wed Dec 24 22:26:55 2014
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1Y3tSI-0000gc-FV
	for gcvg-git-2@plane.gmane.org; Wed, 24 Dec 2014 22:26:54 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751546AbaLXV0u (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Wed, 24 Dec 2014 16:26:50 -0500
Received: from castro.crustytoothpaste.net ([173.11.243.49]:55945 "EHLO
	castro.crustytoothpaste.net" rhost-flags-OK-OK-OK-OK)
	by vger.kernel.org with ESMTP id S1751504AbaLXV0t (ORCPT
	<rfc822;git@vger.kernel.org>); Wed, 24 Dec 2014 16:26:49 -0500
Received: from vauxhall.crustytoothpaste.net (unknown [IPv6:2601:e:280:10f8:116:4aad:5f45:a30d])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by castro.crustytoothpaste.net (Postfix) with ESMTPSA id DCBF12808F;
	Wed, 24 Dec 2014 21:26:45 +0000 (UTC)
Mail-Followup-To: Jeff King <peff@peff.net>,
	Michael Blume <blume.mike@gmail.com>,
	Git List <git@vger.kernel.org>, Duy Nguyen <pclouds@gmail.com>,
	Junio C Hamano <gitster@pobox.com>
Content-Disposition: inline
In-Reply-To: <20141223185142.GA27954@peff.net>
X-Machine: Running on vauxhall using GNU/Linux on x86_64 (Linux kernel
 3.18.0-trunk-amd64)
User-Agent: Mutt/1.5.23 (2014-03-12)
X-Spam-Score: -0.272 BAYES_00,RDNS_NONE
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/261812>


--rQ2U398070+RC21q
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Tue, Dec 23, 2014 at 01:51:42PM -0500, Jeff King wrote:
> On Tue, Dec 23, 2014 at 12:55:48PM -0500, Michael Blume wrote:
>=20
> > This patch causes an error on my mac, test 5500 fetch-pack errors on
> > part 44 - fetch creating new shallow root. It looks for "remote: Total
> > 1" in the fetch output and gets 3 instead.
>=20
> It fails for me on Linux, too. Interestingly the tip of the series
> passes. I didn't investigate further.

Yes, the tip of the series fixes that issue.  I had trouble coming up
with a good technique to split the patches in a way such that they were
logically distinct yet addressed the failure.  I had an epiphany on how
to do that last night, so I'll reroll sometime today.
--=20
brian m. carlson / brian with sandals: Houston, Texas, US
+1 832 623 2791 | http://www.crustytoothpaste.net/~bmc | My opinion only
OpenPGP: RSA v4 4096b: 88AC E9B2 9196 305B A994 7552 F1BA 225C 0223 B187

--rQ2U398070+RC21q
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: Digital signature

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1

iQIcBAEBCgAGBQJUmy+PAAoJEL9TXYEfUvaLUdwQAIFkxdbDeIueu7ZenCLkCZ6O
lCXh+qqLs6Riucpnzl94GH0wpOIsX7wE7dIIqXqY3eqOEeiS7Cukp5H4jAoSLkv6
uQwzCWWmD9bSQhS0aFfHkti9fqLmQugfSgbivq/Hy9mHgwjS4aFoLIAL6oTHmz/R
gSFNybCajXlWryipR+j3oMv8lxM6hbvFkTyaaXN1iOq+LH0xpJ4xfNcTwNq3BXU7
LhAYI2Z8yoSWv4DtogLbXezeiXPm9HRX0+VogDQrN5XZOnNYEXK2jpe7cHPiHDL9
AU+PAw++ljsQ/aMWMwiUmyYuI7JoqHxMiNOXPBKKnOIVqgiFDpEi1xu6maN6PYyg
3D45c13kAnwbJawdDHTMy7ROi1CoOq8KIs1S0wcu9YH55QGFrgAGjcp+Eg6jzh4I
kvWEPhbzRoAomd4Cp3vvc+A7STTukXU/tNezZgNFSUU2nIxUqYhXcRWRzQ/sUVe3
Zj+actFkVazL/pKuJgPYF8V1Nfem9nSaVTFKPKwt4+OgXbx+PSVRo/gfIMGYX/U1
2a4Y4Qyhzmv+32gu4orehcrRJnP4IMDbK1Bm2mtjgrFtxBIpTTjdPi3r9SKXzsnr
gloFRyI0J/ikrqycytTtLEBDVY9QBzUGVHVbdyMVELhCKc/WbL/5MNVFeXwmRsvd
sS9lFhwPbmjkD5eqK2RG
=KFQW
-----END PGP SIGNATURE-----

--rQ2U398070+RC21q--
