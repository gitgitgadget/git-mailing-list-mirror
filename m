From: Joey Hess <joey@kitenet.net>
Subject: git check-attr -z and quoting
Date: Tue, 2 Nov 2010 11:57:05 -0400
Message-ID: <20101102155705.GA17207@gnu.kitenet.net>
Mime-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha256;
	protocol="application/pgp-signature"; boundary="Dxnq1zWXvFF0Q93v"
To: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Tue Nov 02 16:57:35 2010
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1PDJEs-0005Gy-8j
	for gcvg-git-2@lo.gmane.org; Tue, 02 Nov 2010 16:57:34 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1752634Ab0KBP5N (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Tue, 2 Nov 2010 11:57:13 -0400
Received: from wren.kitenet.net ([80.68.85.49]:38047 "EHLO kitenet.net"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1752517Ab0KBP5M (ORCPT <rfc822;git@vger.kernel.org>);
	Tue, 2 Nov 2010 11:57:12 -0400
Received: from gnu.kitenet.net (fttu-216-41-255-233.btes.tv [216.41.255.233])
	(using TLSv1 with cipher DHE-RSA-AES256-SHA (256/256 bits))
	(Client CN "gnu", Issuer "Joey Hess" (verified OK))
	by kitenet.net (Postfix) with ESMTPS id 24C1011936F
	for <git@vger.kernel.org>; Tue,  2 Nov 2010 11:57:08 -0400 (EDT)
Received: by gnu.kitenet.net (Postfix, from userid 1000)
	id CB79646679; Tue,  2 Nov 2010 11:57:05 -0400 (EDT)
Content-Disposition: inline
User-Agent: Mutt/1.5.20 (2009-06-14)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/160538>


--Dxnq1zWXvFF0Q93v
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

First, thanks to all for supporting -z in various commands like=20
git ls-files and git diff. Big help for plumbing, as I'm sure you know.

But, git check-attr -z only enables NUL separation of its input; output
always has munged pathnames. This bit me trying to use it as plumbing.

--=20
see shy jo

--Dxnq1zWXvFF0Q93v
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: Digital signature
Content-Disposition: inline

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1.4.10 (GNU/Linux)

iQIVAwUBTNA0zckQ2SIlEuPHAQixAQ/9Gm+oMMBnLxUvLBKTXhM2kR361+5QSvKC
10UxE8EhYF7plVwOEIbP7RkohN/F3INEe0kOELSpohDrjcYVhw9JW5DHGm3bIGL8
4vHIzY9/PsRJjI9k5iQ3otVDOIRPJAKe2X7LUBw1og+z6bhy14NzFVftJTaZ795M
poSFp8PAL0joYzQQ0mQFZt6BVMsh3U3PH4N6FTt30kurIagrW+UJmko8kKt4ekvJ
x4rTF16oaVUhvYfNkoadEIhDbO5R/3S6o2r5/52aIUHhCHd6p9MEWZLUm0Eglzmv
j/A8OZsrNT6E2WMx3HlkexxqgyhjKVkKIZhDlY2hM7CGK38xG/N9oQmNswSRUuUT
7HHtT8GBogEnbpE0bD0NGCKSDgJvTH+CtFDFpjncTQZf112Vw7BJLJtHgHeCCTDJ
xreq/pSXB/0tU03qDuDjxl1YYUmsRxtrM05VtpcQUe6IXAqRA2RWPKaaLLBvd8Xy
x893/epmlm5mL0YcpN8GMxJdJyNklO0BonQq1oyPYlBQZU9KREvbFKuQ9U43s/MM
nZ8yKd2hsDIlb0AOnkjh4ySn67ECz3Bd2jx5tPbzJd1cscrEoLjG/VNSzatN/846
WzcJEydlWuZGGjK5QVyPEPREw99Gw7FqXtn51zFxYj/bE3JnVk2GyW1ikihsxEOc
HJbbX+CRB74=
=5RJs
-----END PGP SIGNATURE-----

--Dxnq1zWXvFF0Q93v--
