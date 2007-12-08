From: Miklos Vajna <vmiklos@frugalware.org>
Subject: git-svn branch naming question
Date: Sat, 8 Dec 2007 02:04:38 +0100
Message-ID: <20071208010438.GE3199@genesis.frugalware.org>
Mime-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha1;
	protocol="application/pgp-signature"; boundary="mSxgbZZZvrAyzONB"
To: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Sat Dec 08 02:06:02 2007
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1J0o7s-0001yp-Tv
	for gcvg-git-2@gmane.org; Sat, 08 Dec 2007 02:05:17 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1752957AbXLHBEm (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Fri, 7 Dec 2007 20:04:42 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1753136AbXLHBEm
	(ORCPT <rfc822;git-outgoing>); Fri, 7 Dec 2007 20:04:42 -0500
Received: from virgo.iok.hu ([193.202.89.103]:38040 "EHLO virgo.iok.hu"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1752830AbXLHBEl (ORCPT <rfc822;git@vger.kernel.org>);
	Fri, 7 Dec 2007 20:04:41 -0500
Received: from kag.elte.hu (kag.elte.hu [157.181.177.1])
	by virgo.iok.hu (Postfix) with ESMTP id 7B86E1B2505
	for <git@vger.kernel.org>; Sat,  8 Dec 2007 02:04:40 +0100 (CET)
Received: from genesis.frugalware.org (frugalware.elte.hu [157.181.177.34])
	by kag.elte.hu (Postfix) with ESMTP id C1CA84465C
	for <git@vger.kernel.org>; Sat,  8 Dec 2007 02:03:34 +0100 (CET)
Received: by genesis.frugalware.org (Postfix, from userid 1000)
	id 2A5B111904C2; Sat,  8 Dec 2007 02:04:38 +0100 (CET)
Content-Disposition: inline
User-Agent: Mutt/1.5.16 (2007-06-09)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/67490>


--mSxgbZZZvrAyzONB
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline

hi,

i'm using git-svn for projects where i don't just want to commit to
trunk but to other branches, too.

for example:

git-svn clone -s svn+ssh://vmiklos@svn.gnome.org/svn/ooo-build ooo-build

then i have a local 'master' branch and all the other branches are local
branches.

so, when i want to work in the ooo-build-2-3 branch, i do a:

git checkout -b ooo-build-2-3 ooo-build-2-3

but when i do a git svn rebase, i get:

warning: refname 'ooo-build-2-3' is ambiguous.

what am i doing wrong?

in fact i suspect that in case i would use some other branch name, like
simply '2-3' then i could get rid of this warning, but that's the
problem with using the equivalent name of the remote branch when working
in a branch locally?

probably i miss some parameter to git-svn clone so that it would prefix
the refs with some 'origin'?

thanks,
- VMiklos

--mSxgbZZZvrAyzONB
Content-Type: application/pgp-signature
Content-Disposition: inline

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1.4.7 (GNU/Linux)

iD8DBQFHWe2me81tAgORUJYRAkEBAKCNnhr9SEZvLEkJrIwuChlvEDFnygCfXC9L
3BP2fCvqGHyLjIW898xKcBs=
=H01i
-----END PGP SIGNATURE-----

--mSxgbZZZvrAyzONB--
