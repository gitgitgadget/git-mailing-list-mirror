From: Dennis Schridde <devurandom@gmx.net>
Subject: Re: git-svn feature requests
Date: Wed, 14 May 2008 01:41:50 +0200
Message-ID: <200805140141.53414.devurandom@gmx.net>
References: <200805111804.57784.devurandom@gmx.net>
Mime-Version: 1.0
Content-Type: multipart/signed;
  boundary="nextPart3232130.ofD8jp2UEd";
  protocol="application/pgp-signature";
  micalg=pgp-sha1
Content-Transfer-Encoding: 7bit
To: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Wed May 14 01:43:02 2008
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1Jw497-0005ik-Cl
	for gcvg-git-2@gmane.org; Wed, 14 May 2008 01:43:01 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1757132AbYEMXmH (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Tue, 13 May 2008 19:42:07 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1752925AbYEMXmG
	(ORCPT <rfc822;git-outgoing>); Tue, 13 May 2008 19:42:06 -0400
Received: from mail.gmx.net ([213.165.64.20]:49991 "HELO mail.gmx.net"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with SMTP
	id S1754062AbYEMXmF (ORCPT <rfc822;git@vger.kernel.org>);
	Tue, 13 May 2008 19:42:05 -0400
Received: (qmail invoked by alias); 13 May 2008 23:42:02 -0000
Received: from hnvr-4dbbb360.pool.einsundeins.de (EHLO ernie.local) [77.187.179.96]
  by mail.gmx.net (mp046) with SMTP; 14 May 2008 01:42:02 +0200
X-Authenticated: #19202771
X-Provags-ID: V01U2FsdGVkX1/OcHZyMUfO0Nuhaudtj5MKY80ZU6hndPUi+OSlUO
	nBmL8kA/sqPa4p
User-Agent: KMail/1.9.9
In-Reply-To: <200805111804.57784.devurandom@gmx.net>
X-Y-GMX-Trusted: 0
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/82054>

--nextPart3232130.ofD8jp2UEd
Content-Type: text/plain;
  charset="iso-8859-1"
Content-Transfer-Encoding: 7bit
Content-Disposition: inline

Am Sonntag, 11. Mai 2008 18:04:54 schrieb Dennis Schridde:
> Hello!
>
> I am missing two features in git-svn, which are:
> (a) git-svn-dcommit should give credits to other authors when I commit
> their patches.
> I imported a patch from another author via git-am, and then svn-dcommited
> it, but git-svn striped the author information. It should do something
> like: if (author != me) write(commitmessage, "Author: %author%");
Addition to this:
Information like the date of the original commit may also be useful.

> (b) git-svn-rebase should have the location configurable where it tries to
> svn-up/svn-commit from/to, instead of searching the commits in the history
> for git-svn-id tags.
> I tried to maintain a git-svn clone of a repository, fetching from a svn://
> address, but when I use it locally I need to commit via svn+ssh://
> (while "updating" from the git-svn mirror).
> This did not seem to work. Even after rewriting the svn addresses in the
> commitlogs git-svn was unable to find the svn repository in the history.
>
> I tried to create a patch for this myself, but I clashed a bit with my
> knowledge of Perl (or the complete lack thereof), so I hope it might be
> easier for you to do it.
>
> Thanks in advance,
> Dennis
>
> PS: Please CC me on replies, because I am not subscribed to this list.

--nextPart3232130.ofD8jp2UEd
Content-Type: application/pgp-signature; name=signature.asc 
Content-Description: This is a digitally signed message part.

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v2.0.9 (GNU/Linux)

iEYEABECAAYFAkgqJ0EACgkQjqfyF1DtJW7a4QCguwdjjiFo28sXpVXAO/zFMzJa
mYEAoIQkwFUvzXeJVfgZQEINDdaXt2U8
=5+QP
-----END PGP SIGNATURE-----

--nextPart3232130.ofD8jp2UEd--
