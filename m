From: Martin Waitz <tali@admingilde.org>
Subject: Re: [PATCH] submodule merge support
Date: Mon, 7 May 2007 00:16:23 +0200
Message-ID: <20070506221621.GH30511@admingilde.org>
References: <20070506190224.GG30511@admingilde.org> <20070506220745.GA2439@steel.home>
Mime-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha1;
	protocol="application/pgp-signature"; boundary="RE3pQJLXZi4fr8Xo"
Cc: Junio C Hamano <junkio@cox.net>, git@vger.kernel.org
To: Alex Riesen <raa.lkml@gmail.com>
X-From: git-owner@vger.kernel.org Mon May 07 00:16:34 2007
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1Hkp1t-00015O-GJ
	for gcvg-git@gmane.org; Mon, 07 May 2007 00:16:33 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751722AbXEFWQ0 (ORCPT <rfc822;gcvg-git@m.gmane.org>);
	Sun, 6 May 2007 18:16:26 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751762AbXEFWQ0
	(ORCPT <rfc822;git-outgoing>); Sun, 6 May 2007 18:16:26 -0400
Received: from mail.admingilde.org ([213.95.32.147]:40744 "EHLO
	mail.admingilde.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751722AbXEFWQZ (ORCPT <rfc822;git@vger.kernel.org>);
	Sun, 6 May 2007 18:16:25 -0400
Received: from martin by mail.admingilde.org with local  (Exim 4.50 #1)
	id 1Hkp1j-0003LO-Hp; Mon, 07 May 2007 00:16:23 +0200
Content-Disposition: inline
In-Reply-To: <20070506220745.GA2439@steel.home>
X-PGP-Fingerprint: B21B 5755 9684 5489 7577  001A 8FF1 1AC5 DFE8 0FB2
User-Agent: Mutt/1.5.9i
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/46381>


--RE3pQJLXZi4fr8Xo
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

hoi :)

On Mon, May 07, 2007 at 12:07:45AM +0200, Alex Riesen wrote:
> Martin Waitz, Sun, May 06, 2007 21:02:24 +0200:
> > When merge-recursive gets to a dirlink, it starts an automatic
> > submodule merge and then uses the resulting merge commit for the
> > top-level tree.
>=20
> merge-recursive is a mess already, you just made even more so.
> Besides, you completely forgot all other merge strategies.
>=20
> How about making all existing strategies just ignore submodules, and
> move recursive merge in the merge driver (git-merge.sh)?

Well, I don't think it can be done in the merge driver but it does make
sense to consolidate all the low-level file-based merging (and the new
submodule merge is exactly that) between merge strategies.

--=20
Martin Waitz

--RE3pQJLXZi4fr8Xo
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: Digital signature
Content-Disposition: inline

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1.4.1 (GNU/Linux)

iD8DBQFGPlO1j/Eaxd/oD7IRApkBAJ9bGAmX1G6WpoGEyklpBJsnOMWuZwCdFsRQ
VcZIsnTJ2KOZFqWHQeKfQmU=
=CNL5
-----END PGP SIGNATURE-----

--RE3pQJLXZi4fr8Xo--
