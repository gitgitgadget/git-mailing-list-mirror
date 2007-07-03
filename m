From: Uwe =?iso-8859-1?Q?Kleine-K=F6nig?= 
	<ukleinek@informatik.uni-freiburg.de>
Subject: [PATCH] stash: end commit log with a newline
Date: Tue, 3 Jul 2007 10:59:06 +0200
Organization: Universitaet Freiburg, Institut f. Informatik
Message-ID: <20070703085906.GA4963@lala>
Mime-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
Content-Transfer-Encoding: QUOTED-PRINTABLE
To: Git Mailing List <git@vger.kernel.org>
X-From: git-owner@vger.kernel.org Tue Jul 03 10:59:23 2007
connect(): Connection refused
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1I5eED-0007KU-Nn
	for gcvg-git@gmane.org; Tue, 03 Jul 2007 10:59:22 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1755771AbXGCI7M convert rfc822-to-quoted-printable (ORCPT
	<rfc822;gcvg-git@m.gmane.org>); Tue, 3 Jul 2007 04:59:12 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1753841AbXGCI7M
	(ORCPT <rfc822;git-outgoing>); Tue, 3 Jul 2007 04:59:12 -0400
Received: from atlas.informatik.uni-freiburg.de ([132.230.150.3]:60609 "EHLO
	atlas.informatik.uni-freiburg.de" rhost-flags-OK-OK-OK-OK)
	by vger.kernel.org with ESMTP id S1754569AbXGCI7L (ORCPT
	<rfc822;git@vger.kernel.org>); Tue, 3 Jul 2007 04:59:11 -0400
Received: from login.informatik.uni-freiburg.de ([132.230.151.6])
	by atlas.informatik.uni-freiburg.de with esmtps (TLSv1:DES-CBC3-SHA:168)
	(Exim 4.66)
	(envelope-from <zeisberg@informatik.uni-freiburg.de>)
	id 1I5eE1-0007F6-Om
	for git@vger.kernel.org; Tue, 03 Jul 2007 10:59:09 +0200
Received: from login.informatik.uni-freiburg.de (localhost [127.0.0.1])
	by login.informatik.uni-freiburg.de (8.13.8+Sun/8.12.11) with ESMTP id l638x8mv007896
	for <git@vger.kernel.org>; Tue, 3 Jul 2007 10:59:08 +0200 (MEST)
Received: (from zeisberg@localhost)
	by login.informatik.uni-freiburg.de (8.13.8+Sun/8.12.11/Submit) id l638x7rt007895
	for git@vger.kernel.org; Tue, 3 Jul 2007 10:59:07 +0200 (MEST)
Mail-Followup-To: Uwe =?iso-8859-1?Q?Kleine-K=F6nig?= <ukleinek@informatik.uni-freiburg.de>,
	Git Mailing List <git@vger.kernel.org>
Content-Disposition: inline
User-Agent: Mutt/1.5.16 (2007-06-11)
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/51468>

If I do

	git cat-file commit $commitid

for a commit created by stash, the next prompt starts directly after th=
e
shortlog of HEAD.

Signed-off-by: Uwe Kleine-K=F6nig <ukleinek@informatik.uni-freiburg.de>
---
 git-stash.sh |    2 +-
 1 files changed, 1 insertions(+), 1 deletions(-)

diff --git a/git-stash.sh b/git-stash.sh
index 16979ab..9deda44 100755
--- a/git-stash.sh
+++ b/git-stash.sh
@@ -67,7 +67,7 @@ save_stash () {
 		die "Cannot save the current worktree state"
=20
 	# create the stash
-	w_commit=3D$(printf 'WIP on %s' "$msg" |
+	w_commit=3D$(printf 'WIP on %s\n' "$msg" |
 		git commit-tree $w_tree -p $b_commit -p $i_commit) ||
 		die "Cannot record working tree state"
=20
--=20
1.5.2.2.1451.gb0e5e


--=20
Uwe Kleine-K=F6nig

cal 9 1752 | grep 10
