From: "brian m. carlson" <sandals@crustytoothpaste.net>
Subject: Multiple push remotes via aliases
Date: Sun, 10 May 2015 18:17:03 +0000
Message-ID: <20150510181703.GC225482@vauxhall.crustytoothpaste.net>
Mime-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha512;
	protocol="application/pgp-signature"; boundary="at6+YcpfzWZg/htY"
To: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Sun May 10 20:17:19 2015
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1YrVmw-00025b-9E
	for gcvg-git-2@plane.gmane.org; Sun, 10 May 2015 20:17:18 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751663AbbEJSRN (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Sun, 10 May 2015 14:17:13 -0400
Received: from castro.crustytoothpaste.net ([173.11.243.49]:35150 "EHLO
	castro.crustytoothpaste.net" rhost-flags-OK-OK-OK-OK)
	by vger.kernel.org with ESMTP id S1751466AbbEJSRM (ORCPT
	<rfc822;git@vger.kernel.org>); Sun, 10 May 2015 14:17:12 -0400
Received: from vauxhall.crustytoothpaste.net (unknown [IPv6:2001:470:1f05:79:7d3a:6691:d1f:cd1e])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by castro.crustytoothpaste.net (Postfix) with ESMTPSA id 17DB32808D
	for <git@vger.kernel.org>; Sun, 10 May 2015 18:17:10 +0000 (UTC)
Mail-Followup-To: "brian m. carlson" <sandals@crustytoothpaste.net>,
	git@vger.kernel.org
Content-Disposition: inline
X-Machine: Running on vauxhall using GNU/Linux on x86_64 (Linux kernel
 4.0.0-trunk-amd64)
User-Agent: Mutt/1.5.23 (2014-03-12)
X-Spam-Score: 1.228 (*) RDNS_NONE
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/268735>


--at6+YcpfzWZg/htY
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

I recently discovered that it was possible to specify multiple push URLs
for a remote.  This is useful for me because some of my projects live
both on GitHub and on my own server, and some live only one place or the
other.

One feature that I'm looking for, however, is the ability to specify
those URLs by reference to another remote.  For example, making the
remote def (default) refer to the remotes gh and upstream instead of
duplicating the URLs.  This makes dealing with URL changes easier and
goes along with the DRY approach.

I don't think we already have this functionality (at least I don't see
code for it), and I'd like to implement it, but maybe the documentation
is just missing and I should submit a patch for that instead.  Do we
have such a thing, and if not, do people think this is a worthwhile
feature?
--=20
brian m. carlson / brian with sandals: Houston, Texas, US
+1 832 623 2791 | http://www.crustytoothpaste.net/~bmc | My opinion only
OpenPGP: RSA v4 4096b: 88AC E9B2 9196 305B A994 7552 F1BA 225C 0223 B187

--at6+YcpfzWZg/htY
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: Digital signature

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v2

iQIcBAEBCgAGBQJVT6CNAAoJEL9TXYEfUvaL2UQQAKW2FMRgkbkD7zxTOzpDDLzP
/D8Ya+Rj4sfRrSnV7LPhEpR5RiXv1C3Pwwsl5Ey40O1ebkTMJCJZAXsXZ8j/y3V7
82yG1Taq9zzQiIiZZGt/tXfLXG344nqFern83R1r8KsM/y32Fm5XAYqCGPY5Re09
SNHnrMgTcMWwr4uNjqF8xuf0Yeu+AboSHOX1mVqkDs9vUxM3fbm8LUWcJpqsA0eB
azyN2lugYHuJZvTFZxUWZAUatKsc4aKUbZ/eWVsV+n96wtpc9RIzhAFJS+egWPSS
7vlFiNtZTkNP998vH+O07NoN1e0QAECzMjB1qQKNORtLfX1ZtnhefskdEtyVImGL
FkARwvCVwdFIJEH+/6sMsDsaKMUcwaftE80Y8TSDpYiYnst/MbBW6VORLQ8kTYfe
3/AGh2qia/zNhYT0jXVaYwWvrTiWpZ2xPnqsZwvd3Y4nTdyTC2LDf5wdMJgUIGBE
9tIslwPbPc4dpWUZ9PEyfdz797cam4mCCxLRKYXx2Bl+ivZ1OmHEkK940ub2B3HZ
dPk359phtBzTM3GymrhRu3x8Mebga5EAM5uFmkheukrLLaRKIh5zUROc+6ccmvS9
fFjBIfAjYA5klXfSnSMfmo8BsHkJRGyRvL2m1NuZHzXo7vNGB1JMio8+7QNvTFuI
XX3iyVQZwo/meYMpoyV6
=BZv8
-----END PGP SIGNATURE-----

--at6+YcpfzWZg/htY--
