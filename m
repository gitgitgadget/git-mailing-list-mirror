From: Dennis Schridde <devurandom@gmx.net>
Subject: git-svn feature requests
Date: Sun, 11 May 2008 18:04:54 +0200
Message-ID: <200805111804.57784.devurandom@gmx.net>
Mime-Version: 1.0
Content-Type: multipart/signed;
  boundary="nextPart1472855.u0jVhTvIEm";
  protocol="application/pgp-signature";
  micalg=pgp-sha1
Content-Transfer-Encoding: 7bit
To: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Sun May 11 18:05:53 2008
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1JvE3b-0004AA-Bd
	for gcvg-git-2@gmane.org; Sun, 11 May 2008 18:05:52 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1753941AbYEKQFB (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Sun, 11 May 2008 12:05:01 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1753706AbYEKQFB
	(ORCPT <rfc822;git-outgoing>); Sun, 11 May 2008 12:05:01 -0400
Received: from mail.gmx.net ([213.165.64.20]:37516 "HELO mail.gmx.net"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with SMTP
	id S1753671AbYEKQFA (ORCPT <rfc822;git@vger.kernel.org>);
	Sun, 11 May 2008 12:05:00 -0400
Received: (qmail invoked by alias); 11 May 2008 16:04:59 -0000
Received: from hnvr-4dbb9b6a.pool.einsundeins.de (EHLO ernie.local) [77.187.155.106]
  by mail.gmx.net (mp015) with SMTP; 11 May 2008 18:04:59 +0200
X-Authenticated: #19202771
X-Provags-ID: V01U2FsdGVkX18j/zBJRocjK3TXVJJ86Zl5i6F7XwAtdCWiYj6tjj
	fDlp94Cj+2MY+h
User-Agent: KMail/1.9.9
X-Y-GMX-Trusted: 0
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/81780>

--nextPart1472855.u0jVhTvIEm
Content-Type: text/plain;
  charset="us-ascii"
Content-Transfer-Encoding: quoted-printable
Content-Disposition: inline

Hello!

I am missing two features in git-svn, which are:
(a) git-svn-dcommit should give credits to other authors when I commit thei=
r=20
patches.
I imported a patch from another author via git-am, and then svn-dcommited i=
t,=20
but git-svn striped the author information. It should do something like:
if (author !=3D me) write(commitmessage, "Author: %author%");

(b) git-svn-rebase should have the location configurable where it tries to=
=20
svn-up/svn-commit from/to, instead of searching the commits in the history=
=20
for git-svn-id tags.
I tried to maintain a git-svn clone of a repository, fetching from a svn://=
=20
address, but when I use it locally I need to commit via svn+ssh://=20
(while "updating" from the git-svn mirror).
This did not seem to work. Even after rewriting the svn addresses in the=20
commitlogs git-svn was unable to find the svn repository in the history.

I tried to create a patch for this myself, but I clashed a bit with my=20
knowledge of Perl (or the complete lack thereof), so I hope it might be=20
easier for you to do it.

Thanks in advance,
Dennis

PS: Please CC me on replies, because I am not subscribed to this list.

--nextPart1472855.u0jVhTvIEm
Content-Type: application/pgp-signature; name=signature.asc 
Content-Description: This is a digitally signed message part.

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v2.0.9 (GNU/Linux)

iEYEABECAAYFAkgnGSkACgkQjqfyF1DtJW7BRwCgvP5ILTgEVB27py8YK2yBmoFs
uDAAoMcpghJ4YPyYxv1HIQico+Qk9YZS
=Ch3K
-----END PGP SIGNATURE-----

--nextPart1472855.u0jVhTvIEm--
