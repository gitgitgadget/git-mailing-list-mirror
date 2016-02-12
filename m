From: Christoph Egger <christoph@christoph-egger.org>
Subject: Re: [PATCH] Implement https public key pinning
Date: Fri, 12 Feb 2016 02:15:29 +0100
Organization: Privat
Message-ID: <87oabmg24u.fsf@mitoraj.siccegge.de>
References: <20160211225437.GA33955@mitoraj.siccegge.de>
	<alpine.DEB.2.20.1602120030120.5268@tvnag.unkk.fr>
Mime-Version: 1.0
Content-Type: multipart/signed; boundary="=-=-=";
	micalg=pgp-sha512; protocol="application/pgp-signature"
Cc: git@vger.kernel.org
To: Daniel Stenberg <daniel@haxx.se>
X-From: git-owner@vger.kernel.org Fri Feb 12 02:15:56 2016
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1aU2Kx-0006aL-1D
	for gcvg-git-2@plane.gmane.org; Fri, 12 Feb 2016 02:15:55 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751171AbcBLBPn (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Thu, 11 Feb 2016 20:15:43 -0500
Received: from chadwick.siccegge.de ([185.44.107.74]:42823 "EHLO
	chadwick.siccegge.de" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751062AbcBLBPm (ORCPT <rfc822;git@vger.kernel.org>);
	Thu, 11 Feb 2016 20:15:42 -0500
Received: by chadwick.siccegge.de with esmtpsa (TLSv1.2:ECDHE-RSA-AES128-GCM-SHA256:128)
	(Exim 4.86 (FreeBSD))
	(envelope-from <christoph@christoph-egger.org>)
	id 1aU2Kd-000Ha6-RN; Fri, 12 Feb 2016 01:15:40 +0000
In-Reply-To: <alpine.DEB.2.20.1602120030120.5268@tvnag.unkk.fr>
	(sfid-20160212_003034_201980_7AA25BC7) (Daniel Stenberg's message of "Fri,
	12 Feb 2016 00:30:57 +0100 (CET)")
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/24.4 (gnu/kfreebsd)
X-SA-Exim-Connect-IP: 95.90.220.243
X-SA-Exim-Mail-From: christoph@christoph-egger.org
X-Spam-Checker-Version: SpamAssassin 3.4.1 (2015-04-28) on chadwick.siccegge.de
X-Spam-Level: 
X-Spam-Status: No, score=-0.0 required=5.0 tests=NO_RELAYS
	autolearn=unavailable autolearn_force=no version=3.4.1
X-SA-Exim-Version: 4.2
X-SA-Exim-Scanned: Yes (on chadwick.siccegge.de)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/286027>

--=-=-=
Content-Type: text/plain

Daniel Stenberg <daniel@haxx.se> writes:
> On Thu, 11 Feb 2016, Christoph Egger wrote:
>> +#if LIBCURL_VERSION_NUM >= 0x074400
>
> That should probably be 0x072c00 ...

This is, of course, right.

I used 7.44 / 0x072c00 as base because it has robust support for this
feature (including the sha256// variant). One could lower that depending
on the compromises one is willing to take FWIW

  Added in 7.39.0 for OpenSSL, GnuTLS and GSKit. Added in 7.43.0 for NSS
  and wolfSSL/CyaSSL. Added for mbedtls in 7.47.0, sha256 support added
  in 7.44.0 for OpenSSL, GnuTLS, NSS and wolfSSL/CyaSSL. Other SSL
  backends not supported.

Also some people suggested that git should fail if this option is
requested in the config but not supported by the libcurl version instead
of falling back to just not pin the key. I'm undecided about that.

  Christoph

--=-=-=
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1

iQIcBAEBCgAGBQJWvTIxAAoJEKv/7bJACMb5Cf0P/2a3q3znawDyWdJmwWdGpYpQ
QXuX2OYHLRaI5knePBaH1zhZkapE0qk2CPqomGd4kG6Vd8ysno0tD5HuAtvpMVr4
cFn82+WZ/3ugOQW6nvL81983/3u7tLisH55B9paZrRuKSmPeAxuxR3fophraQO4v
+Xav7AaK7AE0ifO4ZmUCwdzAc+EoP+TbrpqZkIk/Z0rl0UlNIiJJH//kB6WfjS/O
sbOvThRGy52xLOBSTyfuCT9aXqP0flEibv9sNPwCU2GLLtscWFloOXEUD8hU3Do2
FJic1/k55DTTjKl0uIsmpYIGQVhaWh2k5aSHL3rsY2RvR5U2lH3jFpZpFagTjspG
3a2YcaQaCeqHsjPDhaQbQZpia/EuawTF7GehI5Sh0CSWkyBOVrHDVkWkFe4+E+/X
zLXEJcRMChCAZ7FuU5TKg14x8wA+tMYJtRMQsboFYZbWCgvLhHPZGGh8jEnvDd2I
3nGFQVwdSADc1AvtTRMhzZl6AHK8BvVzFlWLBl+kAnY4mFTpBpN+6NhxieEFBHbA
0O+UWQ1/XTqxu3j7YMVWRhxrSmjGfv7uIfU81xT5Mo+TJn5QnisgK5otpdY8uGrr
CIUVM9e+Pqr3cDn4NsUAWcqUhEgScAo4zik/7TX/to+l2B0aBL9edF89YHm1Gze3
evK+zF48AJZl9mojaUzr
=tcbc
-----END PGP SIGNATURE-----
--=-=-=--
