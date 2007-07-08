From: Johannes Schindelin <Johannes.Schindelin@gmx.de>
Subject: [TICPATCH] rebase -i: put a nice warning into the todo list
Date: Sun, 8 Jul 2007 21:32:22 +0100 (BST)
Message-ID: <Pine.LNX.4.64.0707082130230.4248@racer.site>
Mime-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
To: git@vger.kernel.org, VMiklos <vmiklos@gmail.com>
X-From: git-owner@vger.kernel.org Sun Jul 08 22:39:52 2007
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1I7dXr-0002m2-Kd
	for gcvg-git@gmane.org; Sun, 08 Jul 2007 22:39:51 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1756563AbXGHUjt (ORCPT <rfc822;gcvg-git@m.gmane.org>);
	Sun, 8 Jul 2007 16:39:49 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1756339AbXGHUjt
	(ORCPT <rfc822;git-outgoing>); Sun, 8 Jul 2007 16:39:49 -0400
Received: from mail.gmx.net ([213.165.64.20]:40125 "HELO mail.gmx.net"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with SMTP
	id S1755455AbXGHUjs (ORCPT <rfc822;git@vger.kernel.org>);
	Sun, 8 Jul 2007 16:39:48 -0400
Received: (qmail invoked by alias); 08 Jul 2007 20:39:47 -0000
Received: from wbgn013.biozentrum.uni-wuerzburg.de (EHLO localhost) [132.187.25.13]
  by mail.gmx.net (mp021) with SMTP; 08 Jul 2007 22:39:47 +0200
X-Authenticated: #1490710
X-Provags-ID: V01U2FsdGVkX18Fwmd5zooFpoPlQvSun0pom+c0IaIK7xGChxzKpw
	RpYNZmlp603gi3
X-X-Sender: gene099@racer.site
X-Y-GMX-Trusted: 0
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/51917>


It seems that not everybody expects a difference between keeping a "pick" 
line, and deleting it.  So be a bit more explicit about that, with all 
capitals to get the attention.

Noticed by vmiklos on IRC.

Signed-off-by: Johannes Schindelin <Johannes.Schindelin@gmx.de>

---

 git-rebase--interactive.sh |    3 +++
 1 files changed, 3 insertions(+), 0 deletions(-)

diff --git a/git-rebase--interactive.sh b/git-rebase--interactive.sh
index a9bb622..03ad8e6 100755
--- a/git-rebase--interactive.sh
+++ b/git-rebase--interactive.sh
@@ -400,6 +400,9 @@ do
 #  pick = use commit
 #  edit = use commit, but stop for amending
 #  squash = use commit, but meld into previous commit
+#
+# If you remove a line here THAT COMMIT WILL BE LOST.
+#
 EOF
 		git rev-list $MERGES_OPTION --pretty=oneline --abbrev-commit \
 			--abbrev=7 --reverse $UPSTREAM..$HEAD | \
