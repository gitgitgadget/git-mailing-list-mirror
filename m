From: Joey Hess <joey@kitenet.net>
Subject: Re: is it kosher for pre-commit to change what's staged?
Date: Thu, 11 Nov 2010 16:46:26 -0400
Message-ID: <20101111204626.GA13937@gnu.kitenet.net>
References: <20101110170819.GA3031@gnu.kitenet.net>
 <7v1v6thrzc.fsf@alter.siamese.dyndns.org>
 <20101110200650.GA13439@burratino>
 <20101110204542.GA11201@gnu.kitenet.net>
 <AANLkTi=W_hwU=3PTTqE4R8Cg5T=GMdMfBsKQ1YE0HWRe@mail.gmail.com>
 <20101111192648.GE30870@efreet.light.src>
Mime-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha256;
	protocol="application/pgp-signature"; boundary="Nq2Wo0NMKNjxTN9z"
To: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Thu Nov 11 21:46:40 2010
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1PGe2Z-0002mX-8Z
	for gcvg-git-2@lo.gmane.org; Thu, 11 Nov 2010 21:46:39 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1755724Ab0KKUqe (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Thu, 11 Nov 2010 15:46:34 -0500
Received: from wren.kitenet.net ([80.68.85.49]:36721 "EHLO kitenet.net"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1754642Ab0KKUqe (ORCPT <rfc822;git@vger.kernel.org>);
	Thu, 11 Nov 2010 15:46:34 -0500
Received: from gnu.kitenet.net (dialup-4.153.250.253.Dial1.Atlanta1.Level3.net [4.153.250.253])
	(using TLSv1 with cipher DHE-RSA-AES256-SHA (256/256 bits))
	(Client CN "gnu", Issuer "Joey Hess" (verified OK))
	by kitenet.net (Postfix) with ESMTPS id 7DF3611917D
	for <git@vger.kernel.org>; Thu, 11 Nov 2010 15:46:30 -0500 (EST)
Received: by gnu.kitenet.net (Postfix, from userid 1000)
	id 3AC224984F; Thu, 11 Nov 2010 15:46:26 -0500 (EST)
Content-Disposition: inline
In-Reply-To: <20101111192648.GE30870@efreet.light.src>
User-Agent: Mutt/1.5.20 (2009-06-14)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/161300>


--Nq2Wo0NMKNjxTN9z
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

Jan Hudec wrote:
> The problem point is not big files, but whether they can change the file =
mode
> associated with the entry, since in this case the tree contains a file, b=
ut
> index should contain a symlink. Looking at the documentation, there does =
not
> seem to be a way to do it.
>=20
> It might be worth adding support for it now we have a use-case.

I suppose that if I were using smudge filters, I'd probably not need to
use symlinks at all. I'll think about it.

It belatedly occured to me that I already had something else modifying
the index in pre-commit, and smudge filters cannot handle its use case.

That is, etckeeper (http://kitenet.net/~joey/code/etckeeper). The
pre-commit script there stores some metadata about files that git
usually doesn't track, by putting it in a dotfile, and stages that
dotfile for commit. Which currently works fine, except for the minor
problem that the user doesn't see the dotfile listed in the commit
message.

--=20
see shy jo

--Nq2Wo0NMKNjxTN9z
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: Digital signature
Content-Disposition: inline

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1.4.10 (GNU/Linux)

iQIVAwUBTNxWH8kQ2SIlEuPHAQgTIQ/+L7L/qI5W7OqJ3q2EAl+PRLrT7nMIhy7V
EiGLdJWHQf36Yv0hymhac4NhiSvry6GgBaGdXdv/F3LolWz5oczVVG6v/xuf0XMH
4w2iQIaeWfYIxH/5t9kBg+DVGlQe/T8cCQdZFYUW5y8CNyiESt1A0UjQi7W+toDb
TxLnqx2+VBmOp2vjMJhfQ8XzhasbrxzwOsDkT79uNE8WxBMQcSX6DjSwmkyCOBPG
GqTL6Im/FozGeIBuTNJJodOEUGpRGt9AwkI7mOCVVVzN1c4zxPrkIkR/A30tprNz
SniXJlqnBAhe0BzWKav49TveGJfKBd0g6p5K+Z2/2QW3jjqIBh7D4SG3LABcvwlh
IgtP7t/0nGeccSdoLj6+5bPhDLmEOdQhQUNrTOEjIIYBqjjkjt56kCsRZW1gAr0d
0g/wTcH0zfujD6dcn4gJG/hC2xZfwATmcLCa0C67/P5jPXHn+WLKaE2M/M0DLC1n
KImI4v2evFlmvl7eMZZK9oLkDs4/3c4NX/+3l/1lFhWE5yGkuCbTbbgWi/ED4kzn
ejlk3K2+mXp4qUCtcfnGQQ0k+eQoi54xEx3eOteSkq3hcNBLlLrI1zzK+NNx1gpx
6uE8g2pX0qbLRiWxEIEiHlFvbtFTCHt1UUdYivdRP5NvnwIG3fWrCDLNrUdL+Ngy
IIILBaELgHA=
=dpuM
-----END PGP SIGNATURE-----

--Nq2Wo0NMKNjxTN9z--
