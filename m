From: Thomas Rast <trast@student.ethz.ch>
Subject: Re: [PATCH] refuse to merge during a merge
Date: Sat, 30 May 2009 12:57:23 +0200
Message-ID: <200905301257.27630.trast@student.ethz.ch>
References: <20090527210410.GA14742@localhost> <20090530083721.GA12963@localhost> <m34ov2c1wx.fsf@localhost.localdomain>
Mime-Version: 1.0
Content-Type: multipart/signed;
  boundary="nextPart4278181.WuI1JWUMKa";
  protocol="application/pgp-signature";
  micalg=pgp-sha1
Content-Transfer-Encoding: 7bit
Cc: Clemens Buchacher <drizzd@aon.at>,
	John Tapsell <johnflux@gmail.com>, git@vger.kernel.org,
	Dave Olszewski <cxreg@pobox.com>
To: Jakub Narebski <jnareb@gmail.com>
X-From: git-owner@vger.kernel.org Sat May 30 12:57:40 2009
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1MAMFv-0008VO-NT
	for gcvg-git-2@gmane.org; Sat, 30 May 2009 12:57:40 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1757460AbZE3K53 (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Sat, 30 May 2009 06:57:29 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1756571AbZE3K53
	(ORCPT <rfc822;git-outgoing>); Sat, 30 May 2009 06:57:29 -0400
Received: from xsmtp1.ethz.ch ([82.130.70.13]:47893 "EHLO xsmtp1.ethz.ch"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1755464AbZE3K52 (ORCPT <rfc822;git@vger.kernel.org>);
	Sat, 30 May 2009 06:57:28 -0400
Received: from xfe1.d.ethz.ch ([82.130.124.41]) by xsmtp1.ethz.ch with Microsoft SMTPSVC(6.0.3790.3959);
	 Sat, 30 May 2009 12:57:17 +0200
Received: from thomas.localnet ([84.75.150.195]) by xfe1.d.ethz.ch over TLS secured channel with Microsoft SMTPSVC(6.0.3790.3959);
	 Sat, 30 May 2009 12:57:28 +0200
User-Agent: KMail/1.11.3 (Linux/2.6.27.21-0.1-default; KDE/4.2.3; x86_64; ; )
In-Reply-To: <m34ov2c1wx.fsf@localhost.localdomain>
X-OriginalArrivalTime: 30 May 2009 10:57:28.0426 (UTC) FILETIME=[6C4C1CA0:01C9E115]
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/120348>

--nextPart4278181.WuI1JWUMKa
Content-Type: text/plain;
  charset="iso-8859-15"
Content-Transfer-Encoding: quoted-printable
Content-Disposition: inline

Jakub Narebski wrote:
> Clemens Buchacher <drizzd@aon.at> writes:
> > fatal: You are in the middle of a [conflicted] merge. To complete the m=
erge
> > [resolve conflicts and] commit the changes. To abort, use "git reset HE=
AD".
> >=20
> > The part about resolving changes is only displayed if there are unmerged
> > entries. I intentionally left out --hard, because it potentially removes
> > changes unrelated to the merge (if the work tree was dirty prior to the
> > merge). The user will find out how to reset the work tree by reading the
> > docs.
>=20
> Why not advertise new "git reset --merge HEAD" then?

That doesn't deal with conflicts at all.  It fills the rather
different case where you did a clean merge with some uncommitted
changes in the worktree, but then want to discard the merge again
without losing the uncommitted changes.  In absence of the changes,
you would just use --hard, but here you want to move the branch tip
while merging them over, similar to what 'git checkout -m' does for
moving HEAD.

=2D-=20
Thomas Rast
trast@{inf,student}.ethz.ch

--nextPart4278181.WuI1JWUMKa
Content-Type: application/pgp-signature; name=signature.asc 
Content-Description: This is a digitally signed message part.

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v2.0.9 (GNU/Linux)

iEYEABECAAYFAkohERcACgkQqUud07tmzP1kPACggBH2urQkUeH7PVG1L56hBHGd
yiIAn32slXhNI+JDeDKfef2XtYSGrFCS
=qjTU
-----END PGP SIGNATURE-----

--nextPart4278181.WuI1JWUMKa--
