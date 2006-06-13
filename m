From: Keith Packard <keithp@keithp.com>
Subject: Re: git-cvsimport doesn't quite work, wrt branches
Date: Tue, 13 Jun 2006 11:46:51 -0700
Message-ID: <1150224411.20536.79.camel@neko.keithp.com>
References: <87irn5ovn6.fsf@rho.meyering.net>
	 <Pine.LNX.4.64.0606131008470.5498@g5.osdl.org>
Mime-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha1; protocol="application/pgp-signature"; boundary="=-5aMpBWUU3BuEAvn7LpYU"
Cc: keithp@keithp.com, Jim Meyering <jim@meyering.net>,
	Git Mailing List <git@vger.kernel.org>,
	Matthias Urlichs <smurf@smurf.noris.de>,
	Yann Dirson <ydirson@altern.org>, Pavel Roskin <proski@gnu.org>
X-From: git-owner@vger.kernel.org Tue Jun 13 20:47:34 2006
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by ciao.gmane.org with esmtp (Exim 4.43)
	id 1FqDv6-0005r5-0p
	for gcvg-git@gmane.org; Tue, 13 Jun 2006 20:47:20 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932127AbWFMSrR (ORCPT <rfc822;gcvg-git@m.gmane.org>);
	Tue, 13 Jun 2006 14:47:17 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S932131AbWFMSrR
	(ORCPT <rfc822;git-outgoing>); Tue, 13 Jun 2006 14:47:17 -0400
Received: from home.keithp.com ([63.227.221.253]:62727 "EHLO keithp.com")
	by vger.kernel.org with ESMTP id S932127AbWFMSrQ (ORCPT
	<rfc822;git@vger.kernel.org>); Tue, 13 Jun 2006 14:47:16 -0400
Received: from localhost (localhost [127.0.0.1])
	by keithp.com (Postfix) with ESMTP id 8286313001F;
	Tue, 13 Jun 2006 11:47:15 -0700 (PDT)
Received: from keithp.com ([127.0.0.1])
	by localhost (keithp.com [127.0.0.1]) (amavisd-new, port 10024)
	with LMTP id 14310-03; Tue, 13 Jun 2006 11:47:15 -0700 (PDT)
Received: by keithp.com (Postfix, from userid 1033)
	id EF0BB13001E; Tue, 13 Jun 2006 11:47:14 -0700 (PDT)
Received: from neko.keithp.com (localhost [127.0.0.1])
	by keithp.com (Postfix) with ESMTP id 8D6D714001;
	Tue, 13 Jun 2006 11:47:14 -0700 (PDT)
Received: by neko.keithp.com (Postfix, from userid 1488)
	id DE21C54337; Tue, 13 Jun 2006 11:46:51 -0700 (PDT)
To: Linus Torvalds <torvalds@osdl.org>
In-Reply-To: <Pine.LNX.4.64.0606131008470.5498@g5.osdl.org>
X-Mailer: Evolution 2.6.1 
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/21803>


--=-5aMpBWUU3BuEAvn7LpYU
Content-Type: text/plain
Content-Transfer-Encoding: quoted-printable

On Tue, 2006-06-13 at 10:20 -0700, Linus Torvalds wrote:

> Well, it's a cvsps problem.=20
>=20
> Big surprise.

Yeah, we've got

	git-cvsimport
	cvsps
	cvs rlog
	,v files

cvs rlog is designed to 'represent' the history of the repository to
users. Cvsps was built as a software analysis tool, and is used by
putative software engineering researchers. Basing a supposedly lossless
repository conversion system on this pair seems foolish to me,
notwithstanding the heroic efforts to make it work.

--=20
keith.packard@intel.com

--=-5aMpBWUU3BuEAvn7LpYU
Content-Type: application/pgp-signature; name=signature.asc
Content-Description: This is a digitally signed message part

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1.4.3 (GNU/Linux)

iD8DBQBEjwgbQp8BWwlsTdMRAmARAJ4zW0HSkFd0tYBTYLkIADtBBYae8gCfa79/
3csfzTDB7y+IHXsqcKq8A38=
=7EEp
-----END PGP SIGNATURE-----

--=-5aMpBWUU3BuEAvn7LpYU--
