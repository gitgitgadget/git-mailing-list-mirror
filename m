From: Joey Hess <joey@kitenet.net>
Subject: Re: usage for git-p2p (was: git pack/unpack over bittorrent -
 works!)
Date: Sat, 4 Sep 2010 15:29:47 -0400
Message-ID: <20100904192947.GA15621@gnu.kitenet.net>
References: <AANLkTin0-Zjy7Chvntf2pNj5iCQ-4Y5u=bu8r7DSejeu@mail.gmail.com>
Mime-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha256;
	protocol="application/pgp-signature"; boundary="J2SCkAp4GZ/dPZZf"
To: git <git@vger.kernel.org>
X-From: git-owner@vger.kernel.org Sat Sep 04 21:29:58 2010
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1OryR3-0002Ti-SJ
	for gcvg-git-2@lo.gmane.org; Sat, 04 Sep 2010 21:29:58 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1752026Ab0IDT3u (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Sat, 4 Sep 2010 15:29:50 -0400
Received: from wren.kitenet.net ([80.68.85.49]:46625 "EHLO kitenet.net"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1751316Ab0IDT3u (ORCPT <rfc822;git@vger.kernel.org>);
	Sat, 4 Sep 2010 15:29:50 -0400
Received: from gnu.kitenet.net (sctv-77-114.mounet.com [216.145.77.114])
	(using TLSv1 with cipher DHE-RSA-AES256-SHA (256/256 bits))
	(Client CN "gnu", Issuer "Joey Hess" (verified OK))
	by kitenet.net (Postfix) with ESMTPS id CCDE71D20DD
	for <git@vger.kernel.org>; Sat,  4 Sep 2010 15:29:48 -0400 (EDT)
Received: by gnu.kitenet.net (Postfix, from userid 1000)
	id 9D2E042351; Sat,  4 Sep 2010 15:29:47 -0400 (EDT)
Content-Disposition: inline
In-Reply-To: <AANLkTin0-Zjy7Chvntf2pNj5iCQ-4Y5u=bu8r7DSejeu@mail.gmail.com>
User-Agent: Mutt/1.5.20 (2009-06-14)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/155347>


--J2SCkAp4GZ/dPZZf
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

Luke Kenneth Casson Leighton wrote:
> ikiwiki is one, and moinmoin can also be configured to use git. Wikis
> have already solved the "conflict" problem, in particular i know that
> joey is a smart bunny and has solved conflict resolution in ikiwiki.

More accurately, I have entirely punted conflict resolution onto the
underlying VCS, such as git, and taken advantage of its generally
excellent merging behavior to avoid the most common classes of things
that result in conflicts/locking on other wikis (like two users editing
different parts of the same page concurrently).

Two branches of a wiki with committers to both can still of course
result in conflicts. In this case, it might make sense to avoid conflict
resolution during merging, and make the conflicted page be committed
containing both versions and some sort of "conflict here!" warning
directive. Then the wiki software can provide an web interface for
cleaning up the conflict later. A custom merge driver could do something
like that, although there's the problem that not all files in the wiki
will be wiki pages, or the conflict could involve conflicting renames of
pages. (Another approach would be to use the "ours" merge strategy.)

--=20
see shy jo, lazy bunny

--J2SCkAp4GZ/dPZZf
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: Digital signature
Content-Disposition: inline

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1.4.10 (GNU/Linux)

iQIVAwUBTIKeK8kQ2SIlEuPHAQh0Qw/+K4gBLL09SHMNV0WhqXvnE6wnZQoX8SVD
Xv5l+9Jyqn2fQ/tNi7QI0xUVNcwc17fabcHOvAwHLEbrfRI0kkRWRIOnSp8aUGcS
Jq5wvstkLywu9ww4pLXaC+Tn0GRRPnea8nQrENsQEM1zGSf0vJFmxqSzB3keMsnG
TwpqjFqvK6oSR0US51iyC+fW96+/mzw3qbXS5oHtKjtYEJsDfIxnnZpohNOM648K
M2Jl+19Y/TlwsCcHDA/YmrW7uiCWSnYTGpFren9cCbMTZpHdt7Yl6Wnr8Xf5UiGU
rn+gNj7K7/qA7vY7oYmG+3CSqj5TOZIz94A7XP/HWYVRcrrtoC1wu6Q6e6v0Q/59
q09Mfm4ZrqvnxzxM43FGk7BynVanOTdpfzb9IUGQ+GqSP+MjjVfIbLifjbu8VzGq
a3YYVe7PPTvJy8/8X/LcimL0dYYq5P21NBTAecXDI83yZIkwDZjt5GgftDpYyN3u
ubwPQI5FEnufEJ1XkFt65xMxwzK0+jCie5zxFse9mdec+vQezgDcK5LwUSKALxym
SApyVFQZu/99a4tkwngIhsAsZ+O1Dv8zrzgdyBqy70hbOBC5kusAgsEsA3bFI1Vi
wXGPFb+5WoTh6CFLGbI3BItXzZmFED9U4ET3DYT5+X7M3id1toGttiG0YUFjixt4
wJQygt8Li7k=
=bje0
-----END PGP SIGNATURE-----

--J2SCkAp4GZ/dPZZf--
