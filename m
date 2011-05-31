From: Joey Hess <joey@kitenet.net>
Subject: speed of git reset -- file
Date: Tue, 31 May 2011 15:00:15 -0400
Message-ID: <20110531190015.GA12113@gnu.kitenet.net>
Mime-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha256;
	protocol="application/pgp-signature"; boundary="gBBFr7Ir9EOA20Yy"
To: GIT Mailing-list <git@vger.kernel.org>
X-From: git-owner@vger.kernel.org Tue May 31 21:00:30 2011
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1QRUB2-0006aL-FM
	for gcvg-git-2@lo.gmane.org; Tue, 31 May 2011 21:00:28 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1758187Ab1EaTAW (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Tue, 31 May 2011 15:00:22 -0400
Received: from wren.kitenet.net ([80.68.85.49]:55665 "EHLO kitenet.net"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1758170Ab1EaTAW (ORCPT <rfc822;git@vger.kernel.org>);
	Tue, 31 May 2011 15:00:22 -0400
Received: from gnu.kitenet.net (dialup-4.152.246.205.Dial1.Atlanta1.Level3.net [4.152.246.205])
	(using TLSv1 with cipher ECDHE-RSA-AES256-SHA (256/256 bits))
	(Client CN "gnu", Issuer "Joey Hess" (verified OK))
	by kitenet.net (Postfix) with ESMTPS id 126651194FD
	for <git@vger.kernel.org>; Tue, 31 May 2011 15:00:20 -0400 (EDT)
Received: by gnu.kitenet.net (Postfix, from userid 1000)
	id 333F24C929; Tue, 31 May 2011 15:00:15 -0400 (EDT)
Content-Disposition: inline
User-Agent: Mutt/1.5.21 (2010-09-15)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/174821>


--gBBFr7Ir9EOA20Yy
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

I'd expect that resetting a single file would need to update the index,
reading some objects from .git to do it.

But according to strace, it also stats every file in the working tree.
I have lots of files, and so that is very slow. Is it really necessary?

git version 1.7.5.1

--=20
see shy jo

--gBBFr7Ir9EOA20Yy
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: Digital signature

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1.4.11 (GNU/Linux)

iQIVAwUBTeU6vskQ2SIlEuPHAQh1DBAAo7dU1YG+CYBHdWzBFBpIGiWF7sEMshJ7
nmD54EUwpmYUKUXt/1qRTTxiWQiVqJdYt9jsUMn8RAAFnMIq8bgVRoPX7KZroWwA
SYmj2nWrsiap5apAPsbQMXndOvlMziLVekX2x8A33svdLFnf9+ShhgbjDK4OqxS5
14VS6XMuU3YtthZlNoVX84lqNhHmUrR5ob4hNThsvHTn7BoR9surLJ7SJhiH9uhb
Qt1I/V22IXvC3mINWlPPICYEn3HAlBxbKOfhyDIL+tPG9l7JpA+0wXTMthoSNncX
5JjlZhEC01rUzdRISi1rF/771eF4JDuFMiWreLpOadjwvpIvYld3ELSpua8Wngkp
k1pObV7NREEVaDcyku2Tgn3+v5iZ+BdoxYcLS5qNlEKcEvNn7igeDtX+YBvtenhk
pgzTa+WDoBZpSXFVq2pSD7j7I5xVSKQW1YTE2kfv5K+erA+hqjgCKPLGAahX1Ypw
XL9fJdnUYiUbCcp9B488CldtiXOQaqy8fSP8C3FSHN2tvmqZnktDydmzmLHWRRWn
gOF9ZD/I7xDRQzrJSiQCkwxeBpoH6KzqZ06cpqaIVxoXhFwzjX9VgJqFciSRcyCQ
e0nYWraCwYyFggfc1PyhZWhwNr3Snowbc7GDZSj7ZWbmUxV54LBBrjl6FZyjLwuu
XYgIdKRj920=
=3DcS
-----END PGP SIGNATURE-----

--gBBFr7Ir9EOA20Yy--
