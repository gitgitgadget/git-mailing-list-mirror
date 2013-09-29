From: "brian m. carlson" <sandals@crustytoothpaste.net>
Subject: Re: [PATCH 6/9] http: update base URLs when we see redirects
Date: Sun, 29 Sep 2013 18:54:08 +0000
Message-ID: <20130929185408.GB18384@vauxhall.crustytoothpaste.net>
References: <20130928082956.GA22610@sigill.intra.peff.net>
 <20130928083405.GA2782@sigill.intra.peff.net>
Mime-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha512;
	protocol="application/pgp-signature"; boundary="rS8CxjVDS/+yyDmU"
Cc: git@vger.kernel.org, "Kyle J. McKay" <mackyle@gmail.com>
To: Jeff King <peff@peff.net>
X-From: git-owner@vger.kernel.org Sun Sep 29 20:54:22 2013
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1VQM8L-0006FR-LX
	for gcvg-git-2@plane.gmane.org; Sun, 29 Sep 2013 20:54:22 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1754891Ab3I2SyS (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Sun, 29 Sep 2013 14:54:18 -0400
Received: from castro.crustytoothpaste.net ([173.11.243.49]:60631 "EHLO
	castro.crustytoothpaste.net" rhost-flags-OK-OK-OK-OK)
	by vger.kernel.org with ESMTP id S1754734Ab3I2SyR (ORCPT
	<rfc822;git@vger.kernel.org>); Sun, 29 Sep 2013 14:54:17 -0400
Received: from vauxhall.crustytoothpaste.net (wsip-184-177-1-73.no.no.cox.net [184.177.1.73])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by castro.crustytoothpaste.net (Postfix) with ESMTPSA id 36E4C28074;
	Sun, 29 Sep 2013 18:54:14 +0000 (UTC)
Content-Disposition: inline
In-Reply-To: <20130928083405.GA2782@sigill.intra.peff.net>
X-Machine: Running on vauxhall using GNU/Linux on x86_64 (Linux kernel
 3.11-rc4-amd64)
User-Agent: Mutt/1.5.21 (2010-09-15)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/235602>


--rS8CxjVDS/+yyDmU
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Sat, Sep 28, 2013 at 04:34:05AM -0400, Jeff King wrote:
> Subsequent requests will not be for "info/refs", but for
> other paths relative to the base. We must ask the caller to
> pass in the original base, and we must pass the redirected
> base back to the caller (so that it can generte more URLs

s/generte/generate/

> from it). Furthermore, we need to feed the new base to the
> credential code, so that requests to credential helpers (or
> to the user) match the URL we will be requesting.

--=20
brian m. carlson / brian with sandals: Houston, Texas, US
+1 832 623 2791 | http://www.crustytoothpaste.net/~bmc | My opinion only
OpenPGP: RSA v4 4096b: 88AC E9B2 9196 305B A994 7552 F1BA 225C 0223 B187

--rS8CxjVDS/+yyDmU
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: Digital signature

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1.4.14 (GNU/Linux)

iQIcBAEBCgAGBQJSSHdQAAoJEL9TXYEfUvaLX4oP/ifP9Fbuy21Pf7beo/JLjQi0
d7f5TADYzwftZWpAvFhjMpDpkr9dJ4m30qCTUKAyeRJLSesRTded7QTc70CI5Qan
DBTH14XSmz6+69ozNAtskfczmArsFNhN15r/Jq1JbPUquIzv8ZvJQbRc9RafYLhP
RD7XyWGeEWzqJai8QraIvej7MHc2KDoUFLjeXm52fw+6cGI/DF6g/sZGMNGx3u0d
taLlUkF1OaG88wWENFEtaf4MRhd8NA+KqDMPCORqXBgDT9WQvG/VXZZ6YHm3IRGR
kAQROsU67HkjPHkVqcXqZyVmux/v+Nv7jR6IDB4lZgvU0anWm+gyVixGKOGCYP/k
jXX4ARWcu+hUIrl2JzOrhKG+qnulv88AW3VZZspRzSYOIV7zZP+FVuSa38ZTwPjP
wq4nezVT4tE2PtlFnjyx2hPyXDcQui8sQZo3tZec4idWdJHwb3ApmhAgqwl96ybp
pNSOGOJ5KrWeLZjzs+qY1XrERoWKlJb6HAOtvrc+sOJf4bFekXpX5THpLLDWAY7G
XCQmGgjHkmF28Oszv8+4GnIv3a0aEJez30HdlyVBqthCNBrdkE1Kb2lK0L2De1N3
zcmbzKN7u1WFRUqAsMjCc3ZX8NDxI9f/UU3/azHG6gRGOxAaX6GWBMRRLu9Gs9vi
Gl6TP/g8eiDT/YP4oYMl
=VRBw
-----END PGP SIGNATURE-----

--rS8CxjVDS/+yyDmU--
