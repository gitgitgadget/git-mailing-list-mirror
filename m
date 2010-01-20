From: Joey Hess <joey@kitenet.net>
Subject: git notes: notes
Date: Wed, 20 Jan 2010 00:03:43 -0500
Message-ID: <20100120050343.GA12860@gnu.kitenet.net>
Mime-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha256;
	protocol="application/pgp-signature"; boundary="/04w6evG8XlLl3ft"
To: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Wed Jan 20 06:03:55 2010
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1NXSjT-0000Xi-6j
	for gcvg-git-2@lo.gmane.org; Wed, 20 Jan 2010 06:03:55 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1750938Ab0ATFDt (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Wed, 20 Jan 2010 00:03:49 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1750813Ab0ATFDt
	(ORCPT <rfc822;git-outgoing>); Wed, 20 Jan 2010 00:03:49 -0500
Received: from wren.kitenet.net ([80.68.85.49]:40909 "EHLO kitenet.net"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1750807Ab0ATFDs (ORCPT <rfc822;git@vger.kernel.org>);
	Wed, 20 Jan 2010 00:03:48 -0500
Received: from gnu.kitenet.net (fttu-216-41-255-233.btes.tv [216.41.255.233])
	(using TLSv1 with cipher DHE-RSA-AES256-SHA (256/256 bits))
	(Client CN "gnu", Issuer "Joey Hess" (verified OK))
	by kitenet.net (Postfix) with ESMTPS id B423B119144
	for <git@vger.kernel.org>; Wed, 20 Jan 2010 00:03:46 -0500 (EST)
Received: by gnu.kitenet.net (Postfix, from userid 1000)
	id C8B43298023; Wed, 20 Jan 2010 00:03:43 -0500 (EST)
Content-Disposition: inline
User-Agent: Mutt/1.5.20 (2009-06-14)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/137519>


--/04w6evG8XlLl3ft
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

Just a quick note that the new notes feature can break things that parse
git log. For example a parser that assumes it can split the log on blank
lines to separate the header and commit message, can easily become
confused by the new blank line before "Notes:".

Might be worth documenting in release notes, maybe too late now though.
But really, it's all good, notes are a great feature.

PS, Has anyone thought about using notes to warn bisect away from
commits that are known to be unbuildable or otherwise cause bisection
trouble?

--=20
see shy jo

--/04w6evG8XlLl3ft
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: Digital signature
Content-Disposition: inline

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1.4.10 (GNU/Linux)

iQIVAwUBS1aOq8kQ2SIlEuPHAQhgLg//dYgqWPqO8vN6WWXYBptbPpiBnQyPXCnc
2M2D38Gh4QKOJ1oOlMEHsr1+PHijXFL79f5hnxXpnt+yOrKth+DlRcNzesrU2U7e
+OMD+o4HJouKhSo2wWafypEa24Ivkqzq+tsBZ6wUjxIzsA6+LnjW9CLeSRFEBvry
j+0EkI2K62jMDhqUFE6s3D+MMwjKUY0gtrjBparrKbA/vuMnfdtcA41lbskDATBs
RxLK4Id6RpihNt69pZDtF+lW39MRcJbah/kKGnO3+6sU+50ekHBBtYMgvN/CF5c/
waEUVz+NaTjlOzGwZLX0aSVqEOnkkX1WAXDhjKzh/ChH8OY9sTGmMWHOm4ojH21M
ZF9fgapHMckOQ4t6hyjLrcoGgpxw/1PvqYl9TiiCP5N86ZAvOD/1GE5i7nALR3mF
8HZk400ukoPofWL1YmK1wWkLOL7XtQDPzw30Xcp7BuSV3Ty/HXpzwDjqPsk2vR+y
TWR9wQcZr4JsyzTbdVsXwvrMyV//Ol7JTaLAhV4uuHJ/lxuqF/vNiQtb32fwbg6z
Gr92olRfE+IvoCVlQ7/JSNJGo3cgFiHj76jzwGPGZDdPHVXAYzFAnk4nfuwQgouG
7sZWXs5Q2/WNwSqy/ujsj64kNoQ1UOiUUOZ0g2KVYcQFRv4PREOOruVsxVus858N
8LvnRxrOX48=
=yWai
-----END PGP SIGNATURE-----

--/04w6evG8XlLl3ft--
