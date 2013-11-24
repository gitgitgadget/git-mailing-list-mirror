From: "brian m. carlson" <sandals@crustytoothpaste.net>
Subject: Re: error: git-remote-https died of signal 13
Date: Sun, 24 Nov 2013 23:51:57 +0000
Message-ID: <20131124235157.GC26897@vauxhall.crustytoothpaste.net>
References: <5290D994.9040505@googlemail.com>
 <20131124065400.GB5535@sigill.intra.peff.net>
 <5291F70A.7070508@googlemail.com>
 <20131124133356.GA3507@sigill.intra.peff.net>
 <529214D7.1030203@googlemail.com>
 <20131124155439.GA8047@sigill.intra.peff.net>
Mime-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha512;
	protocol="application/pgp-signature"; boundary="hOcCNbCCxyk/YU74"
Cc: Stefan Beller <stefanbeller@googlemail.com>,
	Daniel Stenberg <daniel@haxx.se>,
	GIT Mailing-list <git@vger.kernel.org>
To: Jeff King <peff@peff.net>
X-From: git-owner@vger.kernel.org Mon Nov 25 00:52:18 2013
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1VkjTN-0002vH-BJ
	for gcvg-git-2@plane.gmane.org; Mon, 25 Nov 2013 00:52:17 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1752013Ab3KXXwL (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Sun, 24 Nov 2013 18:52:11 -0500
Received: from castro.crustytoothpaste.net ([173.11.243.49]:34147 "EHLO
	castro.crustytoothpaste.net" rhost-flags-OK-OK-OK-OK)
	by vger.kernel.org with ESMTP id S1751884Ab3KXXwJ (ORCPT
	<rfc822;git@vger.kernel.org>); Sun, 24 Nov 2013 18:52:09 -0500
Received: from vauxhall.crustytoothpaste.net (unknown [IPv6:2001:470:1f05:79:94e8:90e1:789b:36ff])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by castro.crustytoothpaste.net (Postfix) with ESMTPSA id A340D2807E;
	Sun, 24 Nov 2013 23:52:01 +0000 (UTC)
Content-Disposition: inline
In-Reply-To: <20131124155439.GA8047@sigill.intra.peff.net>
X-Machine: Running on vauxhall using GNU/Linux on x86_64 (Linux kernel
 3.11-1-amd64)
User-Agent: Mutt/1.5.21 (2010-09-15)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/238270>


--hOcCNbCCxyk/YU74
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Sun, Nov 24, 2013 at 10:54:39AM -0500, Jeff King wrote:
> Another thought is that the curl fix seems to only kick in when built
> with openssl support.  I'm not sure I understand how ubuntu's packaging
> of curl uses gnutls versus openssl for the shared library. That may be
> related.

Debian (and presumably Ubuntu) build the curl source three times: once
each for OpenSSL, GnuTLS, and NSS.  Each shared library is named
differently (libcurl-openssl.so.3, etc.) and in its own package
(libcurl3-openssl).  The corresponding -dev package for each version
sets up the symlinks and install headers to point to the proper version,
so you always compile and link as you expect.

The reason for this is that Debian cannot distribute GPLv2-only programs
(like git) linked against OpenSSL, so GnuTLS becomes necessary.  On
Debian and Ubuntu, git is by default linked against libcurl3-gnutls.

--=20
brian m. carlson / brian with sandals: Houston, Texas, US
+1 832 623 2791 | http://www.crustytoothpaste.net/~bmc | My opinion only
OpenPGP: RSA v4 4096b: 88AC E9B2 9196 305B A994 7552 F1BA 225C 0223 B187

--hOcCNbCCxyk/YU74
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: Digital signature

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1.4.15 (GNU/Linux)

iQIcBAEBCgAGBQJSkpEdAAoJEL9TXYEfUvaLqJoQALcF1H/L0PfnxH8MIUhRufbA
IXMSNUss+3Z50gwk7O6AuiFr4YbU/Z2Oy5JJvJzvEkL3GtYSb41938oz/3M0tgYZ
IxBQ2X9W0tsZ+MC0B3jOBF2cr5eylPXCPktRTDRS8gUlpPOESD3fABna/790KC2P
gPJCjK29X92td3uums+zaL1gncVz4vtKxhf5DRRDs9WT4DZ8jbnbuG5UvGnw+O8p
nGgSLtXuaiyBG+/unYirJTzOUt5QlC35RAi1BAmm33aD97hvhxWz/hq0nL+XU1Zk
TzLOKw/NRYFQApBZdBVZzEJLPQH3/yXdus2dfHexA2TozDlNuztpOSVzzh419fBg
j3T3DR7Vb/LyQT0ZQ+TiOyTSnu6Kc6pfmCjosPWKk98KzCm1INwyHcLeTabX/WFF
nf4tdeCSsLeHLfw6GAQIlCWkYMrHNtHD+7rEDVE86VhpLylLGPXMITsdgwiCn/L9
ffpMp6PBqujLrK04tObpinpITFdkTeYBIu7K4xZgQPbw4xp1T0+5bAw7+AVQSzYN
0UzVhuk2esQZeYDtMAcWDEyBCawl2ReV8814j21bMXLwXHLdMnUkOqPHDXouxytG
cUAeJV0FYYnfmWrVU33dsfG7PIKDML4qro5+AUtyDLP5VtrV41OPTSOuE3948eY/
/Nv1SjLy+eJEFbTskTbc
=823G
-----END PGP SIGNATURE-----

--hOcCNbCCxyk/YU74--
