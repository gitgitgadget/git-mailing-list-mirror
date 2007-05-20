From: Martin Waitz <tali@admingilde.org>
Subject: Re: [PATCH 06/15] git-read-tree: take --submodules option
Date: Sun, 20 May 2007 23:24:04 +0200
Message-ID: <20070520212404.GK5412@admingilde.org>
References: <11796842882917-git-send-email-skimo@liacs.nl> <11796842893584-git-send-email-skimo@liacs.nl>
Mime-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha1;
	protocol="application/pgp-signature"; boundary="ExXT7PjY8AI4Hyfa"
Cc: git@vger.kernel.org, Junio C Hamano <junkio@cox.net>
To: skimo@liacs.nl
X-From: git-owner@vger.kernel.org Sun May 20 23:24:10 2007
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1Hpssr-0005LJ-IK
	for gcvg-git@gmane.org; Sun, 20 May 2007 23:24:09 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1760014AbXETVYH (ORCPT <rfc822;gcvg-git@m.gmane.org>);
	Sun, 20 May 2007 17:24:07 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1756748AbXETVYH
	(ORCPT <rfc822;git-outgoing>); Sun, 20 May 2007 17:24:07 -0400
Received: from mail.admingilde.org ([213.95.32.147]:57181 "EHLO
	mail.admingilde.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1760014AbXETVYG (ORCPT <rfc822;git@vger.kernel.org>);
	Sun, 20 May 2007 17:24:06 -0400
Received: from martin by mail.admingilde.org with local  (Exim 4.50 #1)
	id 1Hpssm-0005vx-W2; Sun, 20 May 2007 23:24:04 +0200
Content-Disposition: inline
In-Reply-To: <11796842893584-git-send-email-skimo@liacs.nl>
X-PGP-Fingerprint: B21B 5755 9684 5489 7577  001A 8FF1 1AC5 DFE8 0FB2
User-Agent: Mutt/1.5.9i
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/47923>


--ExXT7PjY8AI4Hyfa
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

hoi :)

what really is the motivation to suppress submodule checkout at this
level?  I can see that we need some per-submodule option for checkout,
but this should influence the actual checkout process and not
read-tree.

At least we really want to always update the index correctly and a
read-tree --no-submodules  which updates the index for submodules but
doesn't go into existing submodules just feels wrong.

--=20
Martin Waitz

--ExXT7PjY8AI4Hyfa
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: Digital signature
Content-Disposition: inline

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1.4.1 (GNU/Linux)

iD8DBQFGULx0j/Eaxd/oD7IRAh7rAJoDAdQSwacZUBczjIBndMQz6WgTXACff+sG
XTob+nXTbZWG9ux2rALxpls=
=oWWr
-----END PGP SIGNATURE-----

--ExXT7PjY8AI4Hyfa--
