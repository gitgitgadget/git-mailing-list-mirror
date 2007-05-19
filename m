From: "Robin H. Johnson" <robbat2@gentoo.org>
Subject: Re: Commits gone AWOL, but not reported by git-fsck --unreachable
Date: Sat, 19 May 2007 05:09:33 -0700
Message-ID: <20070519120933.GW17511@curie-int.orbis-terrarum.net>
References: <20070519103011.GU17511@curie-int.orbis-terrarum.net> <20070519115245.GA10035@coredump.intra.peff.net>
Mime-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha1;
	protocol="application/pgp-signature"; boundary="mmR5Tf+WJGm+vTLg"
To: Jeff King <peff@peff.net>, Git Mailing List <git@vger.kernel.org>
X-From: git-owner@vger.kernel.org Sat May 19 14:09:42 2007
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1HpNkj-0007QB-1P
	for gcvg-git@gmane.org; Sat, 19 May 2007 14:09:41 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1757846AbXESMJd (ORCPT <rfc822;gcvg-git@m.gmane.org>);
	Sat, 19 May 2007 08:09:33 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1758012AbXESMJd
	(ORCPT <rfc822;git-outgoing>); Sat, 19 May 2007 08:09:33 -0400
Received: from b01.ext.isohunt.com ([208.71.112.51]:36306 "EHLO
	mail.isohunt.com" rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org
	with ESMTP id S1757846AbXESMJc (ORCPT <rfc822;git@vger.kernel.org>);
	Sat, 19 May 2007 08:09:32 -0400
Received: (qmail 3955 invoked from network); 19 May 2007 12:09:31 -0000
Received: from Unknown (HELO curie.orbis-terrarum.net) (24.81.201.182)
  (smtp-auth username robbat2@isohunt.com, mechanism login)
  by mail.isohunt.com (qpsmtpd/0.33-dev on beta01) with (AES256-SHA encrypted) ESMTPSA; Sat, 19 May 2007 12:09:30 +0000
Received: (qmail 26573 invoked by uid 10000); 19 May 2007 05:09:33 -0700
Content-Disposition: inline
In-Reply-To: <20070519115245.GA10035@coredump.intra.peff.net>
User-Agent: Mutt/1.5.15 (2007-04-06)
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/47743>


--mmR5Tf+WJGm+vTLg
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Sat, May 19, 2007 at 07:52:45AM -0400, Jeff King wrote:
> On Sat, May 19, 2007 at 03:30:11AM -0700, Robin H. Johnson wrote:
> > Problem:
> > --------
> > A bunch of my commits are NOT present in git-log, git-rev-list, or any
> > tool that provides the history of my branches.
> >=20
> > If I hack around and recover the commitid, I can pass it to git-show,
> > and the commit does still exist in the data.
> >=20
> > git-fsck --unreachable does not list the commit in question either, but
> > does list other blobs and trees.
> Are you sure it isn't in your reflog? Try 'git reflog show' or 'git log
> -g'.
Ahh, they do show up there (and I learnt a new git command now, thanks)
- the ones that I can remember the Subject lines for anyway.

Any hints for the future on finding stuff that is in the reflog but not
in the tree? (Remembering every subject line isn't feasible).

--=20
Robin Hugh Johnson
Gentoo Linux Developer & Council Member
E-Mail     : robbat2@gentoo.org
GnuPG FP   : 11AC BA4F 4778 E3F6 E4ED  F38E B27B 944E 3488 4E85

--mmR5Tf+WJGm+vTLg
Content-Type: application/pgp-signature
Content-Disposition: inline

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v2.0.2 (GNU/Linux)
Comment: Robbat2 @ Orbis-Terrarum Networks - The text below is a digital signature. If it doesn't make any sense to you, ignore it.

iD8DBQFGTuj9PpIsIjIzwiwRAr/WAKDIM4qn06hOz7fvXVgw3h6pGeAGbwCg1DqM
WSS30hNqrsr8HFhpBit/kM0=
=6g9l
-----END PGP SIGNATURE-----

--mmR5Tf+WJGm+vTLg--
