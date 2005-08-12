From: Johannes Schindelin <Johannes.Schindelin@gmx.de>
Subject: [PATCH] Use "-script" postfix for scripts
Date: Fri, 12 Aug 2005 15:28:27 +0200 (CEST)
Message-ID: <Pine.LNX.4.63.0508121526050.25606@wgmdd8.biozentrum.uni-wuerzburg.de>
Mime-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
X-From: git-owner@vger.kernel.org Fri Aug 12 15:30:16 2005
Return-path: <git-owner@vger.kernel.org>
Received: from vger.kernel.org ([209.132.176.167])
	by ciao.gmane.org with esmtp (Exim 4.43)
	id 1E3ZaK-0005Np-II
	for gcvg-git@gmane.org; Fri, 12 Aug 2005 15:28:32 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751178AbVHLN23 (ORCPT <rfc822;gcvg-git@m.gmane.org>);
	Fri, 12 Aug 2005 09:28:29 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751180AbVHLN23
	(ORCPT <rfc822;git-outgoing>); Fri, 12 Aug 2005 09:28:29 -0400
Received: from wrzx28.rz.uni-wuerzburg.de ([132.187.3.28]:34696 "EHLO
	wrzx28.rz.uni-wuerzburg.de") by vger.kernel.org with ESMTP
	id S1751178AbVHLN22 (ORCPT <rfc822;git@vger.kernel.org>);
	Fri, 12 Aug 2005 09:28:28 -0400
Received: from wrzx30.rz.uni-wuerzburg.de (wrzx30.rz.uni-wuerzburg.de [132.187.1.30])
	by wrzx28.rz.uni-wuerzburg.de (Postfix) with ESMTP id D703DE2533
	for <git@vger.kernel.org>; Fri, 12 Aug 2005 15:28:27 +0200 (CEST)
Received: from virusscan (localhost [127.0.0.1])
	by wrzx30.rz.uni-wuerzburg.de (Postfix) with ESMTP id BE66E9C788
	for <git@vger.kernel.org>; Fri, 12 Aug 2005 15:28:27 +0200 (CEST)
Received: from wrzx28.rz.uni-wuerzburg.de (wrzx28.rz.uni-wuerzburg.de [132.187.3.28])
	by wrzx30.rz.uni-wuerzburg.de (Postfix) with ESMTP id 9FF1799758
	for <git@vger.kernel.org>; Fri, 12 Aug 2005 15:28:27 +0200 (CEST)
Received: from wgmdd8.biozentrum.uni-wuerzburg.de (wrzx68.rz.uni-wuerzburg.de [132.187.3.68])
	by wrzx28.rz.uni-wuerzburg.de (Postfix) with ESMTP id 7FA10E2533
	for <git@vger.kernel.org>; Fri, 12 Aug 2005 15:28:27 +0200 (CEST)
X-X-Sender: gene099@wgmdd8.biozentrum.uni-wuerzburg.de
To: git@vger.kernel.org
X-Virus-Scanned: by amavisd-new (Rechenzentrum Universitaet Wuerzburg)
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org


For consistency reasons, the names of all scripts should end in "-script".

Signed-off-by: Johannes Schindelin <Johannes.Schindelin@gmx.de>

---

This may be a bit controversial (people might find it unnecessary). 
Subject to discussion.

---

 Makefile                   |   15 ++++++++-------
 git-cherry-script          |    0 
 git-clone-dumb-http-script |    0 
 git-clone-script           |    2 +-
 git-rebase-script          |    4 ++--
 git-request-pull-script    |    4 ++--
 git-shortlog-script        |    0 
 git-whatchanged-script     |    0 
 8 files changed, 13 insertions(+), 12 deletions(-)
 rename git-cherry => git-cherry-script (100%)
 rename git-clone-dumb-http => git-clone-dumb-http-script (100%)
 rename git-shortlog => git-shortlog-script (100%)
 rename git-whatchanged => git-whatchanged-script (100%)

5cc55f08d874b61f1067857c7310fac325504ec8
diff --git a/Makefile b/Makefile
--- a/Makefile
+++ b/Makefile
@@ -58,15 +58,16 @@ SPARSE_FLAGS?=-D__BIG_ENDIAN__ -D__power
 
 
 SCRIPTS=git git-apply-patch-script git-merge-one-file-script git-prune-script \
-	git-pull-script git-tag-script git-resolve-script git-whatchanged \
-	git-fetch-script git-status-script git-commit-script \
-	git-log-script git-shortlog git-cvsimport-script git-diff-script \
-	git-reset-script git-add-script git-checkout-script git-clone-script \
-	gitk git-cherry git-rebase-script git-relink-script git-repack-script \
+	git-pull-script git-tag-script git-resolve-script \
+	git-whatchanged-script git-fetch-script git-status-script \
+	git-commit-script git-log-script git-shortlog-script \
+	git-cvsimport-script git-diff-script git-reset-script git-add-script \
+	git-checkout-script git-clone-script gitk git-cherry-script \
+	git-rebase-script git-relink-script git-repack-script \
 	git-format-patch-script git-sh-setup-script git-push-script \
 	git-branch-script git-parse-remote git-verify-tag-script \
-	git-ls-remote-script git-clone-dumb-http git-rename-script \
-	git-request-pull-script git-bisect-script
+	git-ls-remote-script git-clone-dumb-http-script \
+	git-rename-script git-request-pull-script git-bisect-script
 
 SCRIPTS += git-count-objects-script
 # SCRIPTS += git-send-email-script
diff --git a/git-cherry b/git-cherry-script
similarity index 100%
rename from git-cherry
rename to git-cherry-script
diff --git a/git-clone-dumb-http b/git-clone-dumb-http-script
similarity index 100%
rename from git-clone-dumb-http
rename to git-clone-dumb-http-script
diff --git a/git-clone-script b/git-clone-script
--- a/git-clone-script
+++ b/git-clone-script
@@ -89,7 +89,7 @@ yes,yes)
 		rsync $quiet -avz --ignore-existing "$repo/refs/" "$D/.git/refs/"
 		;;
 	http://*)
-		git-clone-dumb-http "$repo" "$D"
+		git-clone-dumb-http-script "$repo" "$D"
 		case "$?" in
 		2)
 			echo "Somebody should define smarter http server protocol" >&2
diff --git a/git-rebase-script b/git-rebase-script
--- a/git-rebase-script
+++ b/git-rebase-script
@@ -7,7 +7,7 @@
 
 usage="usage: $0 "'<upstream> [<head>]
 
-Uses output from git-cherry to rebase local commits to the new head of
+Uses output from git-cherry-script to rebase local commits to the new head of
 upstream tree.'
 
 case "$#,$1" in
@@ -36,7 +36,7 @@ trap "rm -rf $tmp-*" 0 1 2 3 15
 
 >$fail
 
-git-cherry $upstream $ours |
+git-cherry-script $upstream $ours |
 while read sign commit
 do
 	case "$sign" in
diff --git a/git-request-pull-script b/git-request-pull-script
--- a/git-request-pull-script
+++ b/git-request-pull-script
@@ -24,12 +24,12 @@ headrev=`git-rev-parse --verify $head^0`
 
 echo "The following changes since commit $baserev:"
 git log --max-count=1 --pretty=short "$baserev" |
-git-shortlog | sed -e 's/^\(.\)/  \1/'
+git-shortlog-script | sed -e 's/^\(.\)/  \1/'
 
 echo "are found in the git repository at:" 
 echo
 echo "  $url"
 echo
 
-git log  $baserev..$headrev | git-shortlog ;
+git log  $baserev..$headrev | git-shortlog-script ;
 git diff $baserev..$headrev | git-apply --stat --summary
diff --git a/git-shortlog b/git-shortlog-script
similarity index 100%
rename from git-shortlog
rename to git-shortlog-script
diff --git a/git-whatchanged b/git-whatchanged-script
similarity index 100%
rename from git-whatchanged
rename to git-whatchanged-script
