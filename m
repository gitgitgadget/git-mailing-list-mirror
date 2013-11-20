From: Joey Hess <joey@kitenet.net>
Subject: Re: corrupt object memory allocation error
Date: Wed, 20 Nov 2013 18:28:06 -0400
Message-ID: <20131120222805.GC26468@kitenet.net>
References: <20131120203350.GA31139@kitenet.net>
 <20131120213348.GA29004@sigill.intra.peff.net>
Mime-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha256;
	protocol="application/pgp-signature"; boundary="PuGuTyElPB9bOcsM"
Cc: git@vger.kernel.org
To: Jeff King <peff@peff.net>
X-From: git-owner@vger.kernel.org Wed Nov 20 23:28:20 2013
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1VjGFv-0004yt-IK
	for gcvg-git-2@plane.gmane.org; Wed, 20 Nov 2013 23:28:19 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1755411Ab3KTW2P (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Wed, 20 Nov 2013 17:28:15 -0500
Received: from wren.kitenet.net ([80.68.85.49]:55740 "EHLO kitenet.net"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1754640Ab3KTW2P (ORCPT <rfc822;git@vger.kernel.org>);
	Wed, 20 Nov 2013 17:28:15 -0500
Received: by darkstar.kitenet.net (Postfix, from userid 1000)
	id 1541A30FCBC; Wed, 20 Nov 2013 17:28:06 -0500 (EST)
Content-Disposition: inline
In-Reply-To: <20131120213348.GA29004@sigill.intra.peff.net>
User-Agent: Mutt/1.5.21 (2010-09-15)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/238101>


--PuGuTyElPB9bOcsM
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

Jeff King wrote:
> As for your specific corruption, I can't make heads or tails of it. It
> is not a single-bit error.

Oh, I should have mentioned that I am generating corrupt git
repositories mechanically for testing. I think in this case it prepended
some garbage to an object.

--=20
see shy jo

--PuGuTyElPB9bOcsM
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: Digital signature

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1.4.15 (GNU/Linux)

iQIVAwUBUo03dckQ2SIlEuPHAQijThAAhfYuTM8s/O82pa7QRxiAMkqDXQ7Iy7pR
8nLtGgn9TQme+dSP1DIwNiCQsRjNcORPkGv8tZbSzzkf409KUG9+7IkXECqXDEDq
p6xNPoazt6B5jG2qdZbrjNqISiQZ2xEuc9vSHCCM35eoRRJ8kkAqypiDa5t/KzXl
mFMbTwW1muOfn9XhmKOYX0coBmZBukgO0C16ebWB9YPLuqwWpPtAe97iaB3VlI2w
DIhs8ZYJYTz5J0EYKaoWinX2kWCPCZ+m3DE8pd3377UDtTNmjhH+nA7+zYPu0QN8
Zvk7tmjNNgzJS4fN4Lz8NY0Cj1UvWkA/cxr02CX1/6kaRZ8ZVgyaiXeySd8nWnEK
+ilc601LwzkngSzgToNMt91doRAqm28qT5GPoxQcFuSz9oyY6UNqtGzsSmPK+s00
b+PYR3j1wJ9mdreICClSXlKhCCBhbbspiIBhzuTeYCKo1CLRqg5m71ZG4P00jNKX
XMmuAUG0fMwwhiuUTy7HCClne+6/QrOhHGrDsGlAp9zyqnKLsMIT5TQRev0/sqlo
ZJWXcN001OKPgiZ2QE/rDMl6woX+8JpEqq5L4RHknOreTfd3e0QP18mtZtB+53q1
rI+p+x1tL1sBH4q4m9uyHfIu7NtpdUBJqcwBjDXp5y9W6sxZnPbmKcLJKwo7XkBs
Bvo9AXCzEFs=
=k3d8
-----END PGP SIGNATURE-----

--PuGuTyElPB9bOcsM--
