From: Joey Hess <joey@kitenet.net>
Subject: is it kosher for pre-commit to change what's staged?
Date: Wed, 10 Nov 2010 13:08:19 -0400
Message-ID: <20101110170819.GA3031@gnu.kitenet.net>
Mime-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha256;
	protocol="application/pgp-signature"; boundary="3V7upXqbjpZ4EhLz"
To: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Wed Nov 10 18:08:46 2010
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1PGE9w-00044Q-5n
	for gcvg-git-2@lo.gmane.org; Wed, 10 Nov 2010 18:08:32 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1757163Ab0KJRI0 (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Wed, 10 Nov 2010 12:08:26 -0500
Received: from wren.kitenet.net ([80.68.85.49]:56158 "EHLO kitenet.net"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1757148Ab0KJRI0 (ORCPT <rfc822;git@vger.kernel.org>);
	Wed, 10 Nov 2010 12:08:26 -0500
Received: from gnu.kitenet.net (dialup-4.153.253.136.Dial1.Atlanta1.Level3.net [4.153.253.136])
	(using TLSv1 with cipher DHE-RSA-AES256-SHA (256/256 bits))
	(Client CN "gnu", Issuer "Joey Hess" (verified OK))
	by kitenet.net (Postfix) with ESMTPS id 7A37F118071
	for <git@vger.kernel.org>; Wed, 10 Nov 2010 12:08:24 -0500 (EST)
Received: by gnu.kitenet.net (Postfix, from userid 1000)
	id D074C466CD; Wed, 10 Nov 2010 12:08:19 -0500 (EST)
Content-Disposition: inline
User-Agent: Mutt/1.5.20 (2009-06-14)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/161159>


--3V7upXqbjpZ4EhLz
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

I've noticed that if I make a pre-commit hook change the files that are
staged, those changes are not reflected in the commit message. For
example, if a pre-commit hook git add's somefile, the commit message
won't reflect that. I guess prepare-commit-msg is being run before
pre-commit for some reason?

--=20
see shy jo

--3V7upXqbjpZ4EhLz
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: Digital signature
Content-Disposition: inline

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1.4.10 (GNU/Linux)

iQIVAwUBTNrRgMkQ2SIlEuPHAQi0Kw/+Njdo57mw/iecEBT5RzkRHnNhwiaQNmy5
IxYSSzEBxxnQExtG3D5VJxlAlAQBgDIQF+W6l4yeZ0O/pmQQ3j7xIj9GuWEsdcwN
3vmlxzAm9ypUfQc6P0TGdHE6/1sTNidkG8k1MAscTKAnJi/+7fjK5iCFyHRCNYZJ
RK+AXNTm5862mQCK4a7X4IC0ywswqU32YSUp0KNGLNBJdQdJ6Hg0qN289vUEkwrz
BhJPysRKUMYYQn5AADB7ns5aIcobXxn7ST3JLtgpv/J6nV/XitRRQrhuXfa9cju8
mgL0m8/edR+p+8kAnWTyfFgXMrQiCMcxBXcnaU+lM9t/2RR9k70ERIuIcMPIBwWd
+FyVB1SxIlGUoMYz8l9CMbHotwVO9iz2QUXTLqZBzh73KVdJh+1jSgBPW6Z4MyU7
5Yvo982Am5/SgeFFxDrRCgbG88FsudP3B7GIXJVSRX9bdMKxj95ksyXM7xrhP0FS
vUoQ9EUhqXs1ceZ9UH7/vtzmHWMIX9aJaPeL+9Z+pUViKno0vH8mc4xmGV30xs8P
DY+pp7ByyMoRAmQ2NDTUDHIJxxoyX4jhBYHRWRwoIX+WJjrIMbE28YaDlIbP18PF
vjtkf+ZPDBNBM25vP/g9ZHGbwY5cXnIn7/id/Mppgz7CvEyguRlBrhyKHJbEY0tc
3rQD3okJ3l4=
=bMmb
-----END PGP SIGNATURE-----

--3V7upXqbjpZ4EhLz--
