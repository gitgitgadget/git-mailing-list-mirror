From: Michael Niedermayer <michaelni@gmx.at>
Subject: Re: suggestions for gitweb
Date: Mon, 14 May 2007 19:37:15 +0200
Message-ID: <20070514173714.GA14859@MichaelsNB>
References: <20070512205529.GS14859@MichaelsNB> <20070514085314.GY14859@MichaelsNB> <20070514095857.GI4489@pasky.or.cz> <200705141849.36457.jnareb@gmail.com>
Mime-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha1;
	protocol="application/pgp-signature"; boundary="sSlWXIgxWro0haeJ"
Cc: Petr Baudis <pasky@suse.cz>, Junio C Hamano <junkio@cox.net>,
	git@vger.kernel.org
To: Jakub Narebski <jnareb@gmail.com>
X-From: git-owner@vger.kernel.org Mon May 14 19:41:30 2007
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1HneY5-0007JC-RD
	for gcvg-git@gmane.org; Mon, 14 May 2007 19:41:30 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1756134AbXENRlZ (ORCPT <rfc822;gcvg-git@m.gmane.org>);
	Mon, 14 May 2007 13:41:25 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1756849AbXENRlZ
	(ORCPT <rfc822;git-outgoing>); Mon, 14 May 2007 13:41:25 -0400
Received: from mail.gmx.net ([213.165.64.20]:34903 "HELO mail.gmx.net"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with SMTP
	id S1756134AbXENRlY (ORCPT <rfc822;git@vger.kernel.org>);
	Mon, 14 May 2007 13:41:24 -0400
Received: (qmail invoked by alias); 14 May 2007 17:41:22 -0000
Received: from chello080109116125.4.15.vie.surfer.at (EHLO localhost) [80.109.116.125]
  by mail.gmx.net (mp031) with SMTP; 14 May 2007 19:41:22 +0200
X-Authenticated: #3831892
X-Provags-ID: V01U2FsdGVkX1+L3OxHiTmLcDaH4x9S9+ypuzpYeIKi5u/UtBFCdI
	0CIIQbaxmOitRS
Content-Disposition: inline
In-Reply-To: <200705141849.36457.jnareb@gmail.com>
User-Agent: Mutt/1.5.10i
X-Y-GMX-Trusted: 0
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/47276>


--sSlWXIgxWro0haeJ
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

Hi

On Mon, May 14, 2007 at 06:49:35PM +0200, Jakub Narebski wrote:
[...]
> I think it would be nice to have --blame option to git-ls-tree=20
> (optionally copuled with --porcelain and perhaps --incremental, like
> in git-blame), which would return blame information for tree entries.
> It means that for each tree entry return commit closest to given commit
> (or furthest from a given commit) which has changed entry to current
> version. It should be much easier and faster than to do "blob"-blame.
>=20
> The --porcelain would also return 'last changed' info, like committer
> info for a commit-which-changed.
>=20
> But is this info actually interesting, or is it there in ViewVC because
> it is easy to get this info in CVS and Subversion? The "last changed"
> info for tree entries encourages to think of a history as a collection
> of per file histories... while git is all about whole project history.
> Note that history of two files is *more* than concatenation of
> histories of those individual files. See entries on GitFaq wiki page:

well, i do think that the age can be interesting, consider the 2
hypothetical cases:
'release_notes.txt 5 years ago' while all other files have been recently
changed
clearly says: noone cares about this file or there was no release in=20
the last 5 years

also for example
'vo_x11.c    2 days ago  michael     update all vos to use correct foobar'
'vo_mga.c    8 weeks ago diego       spelling fixes'
would immedeatly hint that ive forgotten vo_mga.c ...

[...]
--=20
Michael     GnuPG fingerprint: 9FF2128B147EF6730BADF133611EC787040B0FAB

Let us carefully observe those good qualities wherein our enemies excel us
and endeavor to excel them, by avoiding what is faulty, and imitating what
is excellent in them. -- Plutarch

--sSlWXIgxWro0haeJ
Content-Type: application/pgp-signature
Content-Disposition: inline

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1.4.6 (GNU/Linux)

iD8DBQFGSJ5KYR7HhwQLD6sRAvobAJ9VmNkPedkQWoOh43Q/Qp+m7x7A9wCeIddE
cUSldksqhC8p2DkywfpAoYU=
=kbnJ
-----END PGP SIGNATURE-----

--sSlWXIgxWro0haeJ--
