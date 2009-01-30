From: Thomas Rast <trast@student.ethz.ch>
Subject: Re: question re dcommit problem
Date: Fri, 30 Jan 2009 22:43:54 +0100
Message-ID: <200901302243.57996.trast@student.ethz.ch>
References: <49824650.2070209@epstudiossoftware.com> <20090130084253.GA30046@denkbrett.schottelius.org>
Mime-Version: 1.0
Content-Type: multipart/signed;
  boundary="nextPart1607060.X2lJV9tFEE";
  protocol="application/pgp-signature";
  micalg=pgp-sha1
Content-Transfer-Encoding: 7bit
Cc: David Mann <mannd@epstudiossoftware.com>, git@vger.kernel.org
To: "Nico -telmich- Schottelius" <nico-linux-git@schottelius.org>
X-From: git-owner@vger.kernel.org Fri Jan 30 23:45:27 2009
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1LT26x-0006VY-Nq
	for gcvg-git-2@gmane.org; Fri, 30 Jan 2009 23:45:20 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1754740AbZA3Wny (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Fri, 30 Jan 2009 17:43:54 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1754497AbZA3Wny
	(ORCPT <rfc822;git-outgoing>); Fri, 30 Jan 2009 17:43:54 -0500
Received: from xsmtp0.ethz.ch ([82.130.70.14]:8397 "EHLO XSMTP0.ethz.ch"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1751893AbZA3Wnx (ORCPT <rfc822;git@vger.kernel.org>);
	Fri, 30 Jan 2009 17:43:53 -0500
Received: from xfe0.d.ethz.ch ([82.130.124.40]) by XSMTP0.ethz.ch with Microsoft SMTPSVC(6.0.3790.3959);
	 Fri, 30 Jan 2009 23:43:51 +0100
Received: from thomas.localnet ([77.56.223.244]) by xfe0.d.ethz.ch over TLS secured channel with Microsoft SMTPSVC(6.0.3790.3959);
	 Fri, 30 Jan 2009 23:43:51 +0100
User-Agent: KMail/1.11.0 (Linux/2.6.25.20-0.1-default; KDE/4.2.0; x86_64; ; )
In-Reply-To: <20090130084253.GA30046@denkbrett.schottelius.org>
X-OriginalArrivalTime: 30 Jan 2009 22:43:51.0267 (UTC) FILETIME=[38DE6B30:01C9832C]
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/107877>

--nextPart1607060.X2lJV9tFEE
Content-Type: text/plain;
  charset="iso-8859-15"
Content-Transfer-Encoding: quoted-printable
Content-Disposition: inline

Nico -telmich- Schottelius wrote:
> David Mann [Thu, Jan 29, 2009 at 07:14:08PM -0500]:
> > I created a git repository from my svn repository, later uploaded it to
> > GitHub, and after some branching and merging, can no longer dcommit back
> > to the svn repository. [...]
>=20
> Iirc git svn does not support merges. You've to use git rebase or
> update through the svn server.

It does support them on the git side.  To SVN, the merge should look
like the squashed result (along the first-parent line).  On your local
git end, it should rebase the merge (to allow for git-svn-id) but
preserve parents, thus keeping history.

However, it is very important that the SVN line of history is always
reachable along the first-parent line.  David, did you ensure that?

=2D-=20
Thomas Rast
trast@{inf,student}.ethz.ch

--nextPart1607060.X2lJV9tFEE
Content-Type: application/pgp-signature; name=signature.asc 
Content-Description: This is a digitally signed message part.

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v2.0.9 (GNU/Linux)

iEYEABECAAYFAkmDdJ0ACgkQqUud07tmzP3hHgCeLhhB1REs0Jr+TBzgqibv5OoB
1MAAn0zMfbNndf+71DFBwceaakdTG92a
=qeH5
-----END PGP SIGNATURE-----

--nextPart1607060.X2lJV9tFEE--
