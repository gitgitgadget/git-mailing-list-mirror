From: Sergey Vlasov <vsu@altlinux.ru>
Subject: [PATCH 2/2] Documentation: Update all files to use the new gitlink: macro
Date: Mon, 19 Sep 2005 14:10:51 +0400
Message-ID: <20050919101051.GC28095@master.mivlgu.local>
References: <20050919100914.GA28095@master.mivlgu.local>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Mon Sep 19 12:12:43 2005
Return-path: <git-owner@vger.kernel.org>
Received: from vger.kernel.org ([209.132.176.167])
	by ciao.gmane.org with esmtp (Exim 4.43)
	id 1EHIbz-0003nH-31
	for gcvg-git@gmane.org; Mon, 19 Sep 2005 12:10:59 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932404AbVISKK4 (ORCPT <rfc822;gcvg-git@m.gmane.org>);
	Mon, 19 Sep 2005 06:10:56 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S932408AbVISKK4
	(ORCPT <rfc822;git-outgoing>); Mon, 19 Sep 2005 06:10:56 -0400
Received: from mivlgu.ru ([81.18.140.87]:11223 "EHLO master.mivlgu.local")
	by vger.kernel.org with ESMTP id S932404AbVISKKz (ORCPT
	<rfc822;git@vger.kernel.org>); Mon, 19 Sep 2005 06:10:55 -0400
Received: by master.mivlgu.local (Postfix, from userid 1000)
	id 86D74180110; Mon, 19 Sep 2005 14:10:51 +0400 (MSD)
To: Junio C Hamano <junkio@cox.net>
Content-Disposition: inline
In-Reply-To: <20050919100914.GA28095@master.mivlgu.local>
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/8852>

The replacement was performed automatically by these commands:

	perl -pi -e 's/link:(git.+)\.html\[\1\]/gitlink:$1\[1\]/g' \
		README Documentation/*.txt
	perl -pi -e 's/link:git\.html\[git\]/gitlink:git\[7\]/g' \
		README Documentation/*.txt

Signed-off-by: Sergey Vlasov <vsu@altlinux.ru>


---

 Documentation/git-add.txt                |    2 
 Documentation/git-apply.txt              |    2 
 Documentation/git-applymbox.txt          |    4 -
 Documentation/git-applypatch.txt         |    2 
 Documentation/git-archimport.txt         |    2 
 Documentation/git-bisect.txt             |    2 
 Documentation/git-branch.txt             |    2 
 Documentation/git-cat-file.txt           |    2 
 Documentation/git-checkout-index.txt     |    2 
 Documentation/git-checkout.txt           |    2 
 Documentation/git-cherry-pick.txt        |    2 
 Documentation/git-cherry.txt             |    2 
 Documentation/git-clone-pack.txt         |    2 
 Documentation/git-clone.txt              |    2 
 Documentation/git-commit-tree.txt        |    4 -
 Documentation/git-commit.txt             |    2 
 Documentation/git-convert-objects.txt    |    2 
 Documentation/git-count-objects.txt      |    2 
 Documentation/git-cvsimport.txt          |    2 
 Documentation/git-daemon.txt             |    2 
 Documentation/git-diff-files.txt         |    2 
 Documentation/git-diff-helper.txt        |    4 -
 Documentation/git-diff-index.txt         |    2 
 Documentation/git-diff-stages.txt        |    2 
 Documentation/git-diff-tree.txt          |    2 
 Documentation/git-diff.txt               |    2 
 Documentation/git-export.txt             |    2 
 Documentation/git-fetch-pack.txt         |    2 
 Documentation/git-fetch.txt              |    2 
 Documentation/git-format-patch.txt       |    2 
 Documentation/git-fsck-objects.txt       |    2 
 Documentation/git-get-tar-commit-id.txt  |    2 
 Documentation/git-grep.txt               |    2 
 Documentation/git-hash-object.txt        |    2 
 Documentation/git-http-fetch.txt         |    2 
 Documentation/git-init-db.txt            |    2 
 Documentation/git-local-fetch.txt        |    2 
 Documentation/git-log.txt                |    2 
 Documentation/git-ls-files.txt           |    4 -
 Documentation/git-ls-remote.txt          |    2 
 Documentation/git-ls-tree.txt            |    2 
 Documentation/git-mailinfo.txt           |    2 
 Documentation/git-mailsplit.txt          |    2 
 Documentation/git-merge-base.txt         |    2 
 Documentation/git-merge-index.txt        |    2 
 Documentation/git-merge-one-file.txt     |    2 
 Documentation/git-merge.txt              |    2 
 Documentation/git-mktag.txt              |    2 
 Documentation/git-octopus.txt            |    2 
 Documentation/git-pack-objects.txt       |    2 
 Documentation/git-parse-remote.txt       |    2 
 Documentation/git-patch-id.txt           |    2 
 Documentation/git-peek-remote.txt        |    2 
 Documentation/git-prune-packed.txt       |    2 
 Documentation/git-prune.txt              |    2 
 Documentation/git-pull.txt               |    2 
 Documentation/git-push.txt               |    2 
 Documentation/git-read-tree.txt          |    4 -
 Documentation/git-rebase.txt             |    2 
 Documentation/git-receive-pack.txt       |    4 -
 Documentation/git-relink.txt             |    2 
 Documentation/git-rename.txt             |    2 
 Documentation/git-repack.txt             |    2 
 Documentation/git-request-pull.txt       |    2 
 Documentation/git-reset.txt              |    2 
 Documentation/git-resolve.txt            |    2 
 Documentation/git-rev-list.txt           |    2 
 Documentation/git-rev-parse.txt          |    2 
 Documentation/git-rev-tree.txt           |    2 
 Documentation/git-revert.txt             |    2 
 Documentation/git-send-email.txt         |    2 
 Documentation/git-send-pack.txt          |    2 
 Documentation/git-sh-setup.txt           |    2 
 Documentation/git-shortlog.txt           |    2 
 Documentation/git-show-branch.txt        |    2 
 Documentation/git-show-index.txt         |    2 
 Documentation/git-ssh-fetch.txt          |    2 
 Documentation/git-ssh-upload.txt         |    2 
 Documentation/git-status.txt             |    2 
 Documentation/git-stripspace.txt         |    2 
 Documentation/git-tag.txt                |    2 
 Documentation/git-tar-tree.txt           |    2 
 Documentation/git-unpack-file.txt        |    2 
 Documentation/git-unpack-objects.txt     |    2 
 Documentation/git-update-index.txt       |    2 
 Documentation/git-update-server-info.txt |    2 
 Documentation/git-upload-pack.txt        |    2 
 Documentation/git-var.txt                |    6 -
 Documentation/git-verify-pack.txt        |    2 
 Documentation/git-verify-tag.txt         |    2 
 Documentation/git-whatchanged.txt        |    2 
 Documentation/git-write-tree.txt         |    2 
 Documentation/git.txt                    |  200 +++++++++++++++---------------
 Documentation/gitk.txt                   |    2 
 README                                   |   24 ++--
 95 files changed, 213 insertions(+), 213 deletions(-)

03f3ac7ade700dbd95c91e21a77ed1f4cbf4edb8
diff --git a/Documentation/git-add.txt b/Documentation/git-add.txt
--- a/Documentation/git-add.txt
+++ b/Documentation/git-add.txt
@@ -29,5 +29,5 @@ Documentation by Junio C Hamano and the 
 
 GIT
 ---
-Part of the link:git.html[git] suite
+Part of the gitlink:git[7] suite
 
diff --git a/Documentation/git-apply.txt b/Documentation/git-apply.txt
--- a/Documentation/git-apply.txt
+++ b/Documentation/git-apply.txt
@@ -72,5 +72,5 @@ Documentation by Junio C Hamano
 
 GIT
 ---
-Part of the link:git.html[git] suite
+Part of the gitlink:git[7] suite
 
diff --git a/Documentation/git-applymbox.txt b/Documentation/git-applymbox.txt
--- a/Documentation/git-applymbox.txt
+++ b/Documentation/git-applymbox.txt
@@ -67,7 +67,7 @@ OPTIONS
 
 SEE ALSO
 --------
-link:git-applypatch.html[git-applypatch].
+gitlink:git-applypatch[1].
 
 
 Author
@@ -80,5 +80,5 @@ Documentation by Junio C Hamano and the 
 
 GIT
 ---
-Part of the link:git.html[git] suite
+Part of the gitlink:git[7] suite
 
diff --git a/Documentation/git-applypatch.txt b/Documentation/git-applypatch.txt
--- a/Documentation/git-applypatch.txt
+++ b/Documentation/git-applypatch.txt
@@ -46,5 +46,5 @@ Documentation by Junio C Hamano and the 
 
 GIT
 ---
-Part of the link:git.html[git] suite
+Part of the gitlink:git[7] suite
 
diff --git a/Documentation/git-archimport.txt b/Documentation/git-archimport.txt
--- a/Documentation/git-archimport.txt
+++ b/Documentation/git-archimport.txt
@@ -78,5 +78,5 @@ Documentation by Junio C Hamano, Martin 
 
 GIT
 ---
-Part of the link:git.html[git] suite
+Part of the gitlink:git[7] suite
 
diff --git a/Documentation/git-bisect.txt b/Documentation/git-bisect.txt
--- a/Documentation/git-bisect.txt
+++ b/Documentation/git-bisect.txt
@@ -96,5 +96,5 @@ Documentation by Junio C Hamano and the 
 
 GIT
 ---
-Part of the link:git.html[git] suite
+Part of the gitlink:git[7] suite
 
diff --git a/Documentation/git-branch.txt b/Documentation/git-branch.txt
--- a/Documentation/git-branch.txt
+++ b/Documentation/git-branch.txt
@@ -35,5 +35,5 @@ Documentation by Junio C Hamano and the 
 
 GIT
 ---
-Part of the link:git.html[git] suite
+Part of the gitlink:git[7] suite
 
diff --git a/Documentation/git-cat-file.txt b/Documentation/git-cat-file.txt
--- a/Documentation/git-cat-file.txt
+++ b/Documentation/git-cat-file.txt
@@ -57,5 +57,5 @@ Documentation by David Greaves, Junio C 
 
 GIT
 ---
-Part of the link:git.html[git] suite
+Part of the gitlink:git[7] suite
 
diff --git a/Documentation/git-checkout-index.txt b/Documentation/git-checkout-index.txt
--- a/Documentation/git-checkout-index.txt
+++ b/Documentation/git-checkout-index.txt
@@ -102,5 +102,5 @@ Documentation by David Greaves, Junio C 
 
 GIT
 ---
-Part of the link:git.html[git] suite
+Part of the gitlink:git[7] suite
 
diff --git a/Documentation/git-checkout.txt b/Documentation/git-checkout.txt
--- a/Documentation/git-checkout.txt
+++ b/Documentation/git-checkout.txt
@@ -39,5 +39,5 @@ Documentation by Junio C Hamano and the 
 
 GIT
 ---
-Part of the link:git.html[git] suite
+Part of the gitlink:git[7] suite
 
diff --git a/Documentation/git-cherry-pick.txt b/Documentation/git-cherry-pick.txt
--- a/Documentation/git-cherry-pick.txt
+++ b/Documentation/git-cherry-pick.txt
@@ -53,5 +53,5 @@ Documentation by Junio C Hamano and the 
 
 GIT
 ---
-Part of the link:git.html[git] suite
+Part of the gitlink:git[7] suite
 
diff --git a/Documentation/git-cherry.txt b/Documentation/git-cherry.txt
--- a/Documentation/git-cherry.txt
+++ b/Documentation/git-cherry.txt
@@ -38,5 +38,5 @@ Documentation by Junio C Hamano and the 
 
 GIT
 ---
-Part of the link:git.html[git] suite
+Part of the gitlink:git[7] suite
 
diff --git a/Documentation/git-clone-pack.txt b/Documentation/git-clone-pack.txt
--- a/Documentation/git-clone-pack.txt
+++ b/Documentation/git-clone-pack.txt
@@ -61,5 +61,5 @@ Documentation by Junio C Hamano.
 
 GIT
 ---
-Part of the link:git.html[git] suite
+Part of the gitlink:git[7] suite
 
diff --git a/Documentation/git-clone.txt b/Documentation/git-clone.txt
--- a/Documentation/git-clone.txt
+++ b/Documentation/git-clone.txt
@@ -56,5 +56,5 @@ Documentation by Junio C Hamano.
 
 GIT
 ---
-Part of the link:git.html[git] suite
+Part of the gitlink:git[7] suite
 
diff --git a/Documentation/git-commit-tree.txt b/Documentation/git-commit-tree.txt
--- a/Documentation/git-commit-tree.txt
+++ b/Documentation/git-commit-tree.txt
@@ -75,7 +75,7 @@ Your sysadmin must hate you!::
 
 See Also
 --------
-link:git-write-tree.html[git-write-tree]
+gitlink:git-write-tree[1]
 
 
 Author
@@ -88,5 +88,5 @@ Documentation by David Greaves, Junio C 
 
 GIT
 ---
-Part of the link:git.html[git] suite
+Part of the gitlink:git[7] suite
 
diff --git a/Documentation/git-commit.txt b/Documentation/git-commit.txt
--- a/Documentation/git-commit.txt
+++ b/Documentation/git-commit.txt
@@ -69,4 +69,4 @@ Junio C Hamano <junkio@cox.net>
 
 GIT
 ---
-Part of the link:git.html[git] suite
+Part of the gitlink:git[7] suite
diff --git a/Documentation/git-convert-objects.txt b/Documentation/git-convert-objects.txt
--- a/Documentation/git-convert-objects.txt
+++ b/Documentation/git-convert-objects.txt
@@ -26,5 +26,5 @@ Documentation by David Greaves, Junio C 
 
 GIT
 ---
-Part of the link:git.html[git] suite
+Part of the gitlink:git[7] suite
 
diff --git a/Documentation/git-count-objects.txt b/Documentation/git-count-objects.txt
--- a/Documentation/git-count-objects.txt
+++ b/Documentation/git-count-objects.txt
@@ -24,5 +24,5 @@ Documentation by Junio C Hamano and the 
 
 GIT
 ---
-Part of the link:git.html[git] suite
+Part of the gitlink:git[7] suite
 
diff --git a/Documentation/git-cvsimport.txt b/Documentation/git-cvsimport.txt
--- a/Documentation/git-cvsimport.txt
+++ b/Documentation/git-cvsimport.txt
@@ -105,5 +105,5 @@ Documentation by Matthias Urlichs <smurf
 
 GIT
 ---
-Part of the link:git.html[git] suite
+Part of the gitlink:git[7] suite
 
diff --git a/Documentation/git-daemon.txt b/Documentation/git-daemon.txt
--- a/Documentation/git-daemon.txt
+++ b/Documentation/git-daemon.txt
@@ -42,5 +42,5 @@ Documentation by Junio C Hamano and the 
 
 GIT
 ---
-Part of the link:git.html[git] suite
+Part of the gitlink:git[7] suite
 
diff --git a/Documentation/git-diff-files.txt b/Documentation/git-diff-files.txt
--- a/Documentation/git-diff-files.txt
+++ b/Documentation/git-diff-files.txt
@@ -40,5 +40,5 @@ Documentation by David Greaves, Junio C 
 
 GIT
 ---
-Part of the link:git.html[git] suite
+Part of the gitlink:git[7] suite
 
diff --git a/Documentation/git-diff-helper.txt b/Documentation/git-diff-helper.txt
--- a/Documentation/git-diff-helper.txt
+++ b/Documentation/git-diff-helper.txt
@@ -35,7 +35,7 @@ OPTIONS
 
 See Also
 --------
-The section on generating patches in link:git-diff-index.html[git-diff-index]
+The section on generating patches in gitlink:git-diff-index[1]
 
 
 Author
@@ -49,5 +49,5 @@ Documentation by David Greaves, Junio C 
 
 GIT
 ---
-Part of the link:git.html[git] suite
+Part of the gitlink:git[7] suite
 
diff --git a/Documentation/git-diff-index.txt b/Documentation/git-diff-index.txt
--- a/Documentation/git-diff-index.txt
+++ b/Documentation/git-diff-index.txt
@@ -130,5 +130,5 @@ Documentation by David Greaves, Junio C 
 
 GIT
 ---
-Part of the link:git.html[git] suite
+Part of the gitlink:git[7] suite
 
diff --git a/Documentation/git-diff-stages.txt b/Documentation/git-diff-stages.txt
--- a/Documentation/git-diff-stages.txt
+++ b/Documentation/git-diff-stages.txt
@@ -38,4 +38,4 @@ Documentation by Junio C Hamano.
 
 GIT
 ---
-Part of the link:git.html[git] suite
+Part of the gitlink:git[7] suite
diff --git a/Documentation/git-diff-tree.txt b/Documentation/git-diff-tree.txt
--- a/Documentation/git-diff-tree.txt
+++ b/Documentation/git-diff-tree.txt
@@ -126,5 +126,5 @@ Documentation by David Greaves, Junio C 
 
 GIT
 ---
-Part of the link:git.html[git] suite
+Part of the gitlink:git[7] suite
 
diff --git a/Documentation/git-diff.txt b/Documentation/git-diff.txt
--- a/Documentation/git-diff.txt
+++ b/Documentation/git-diff.txt
@@ -48,5 +48,5 @@ Documentation by Junio C Hamano and the 
 
 GIT
 ---
-Part of the link:git.html[git] suite
+Part of the gitlink:git[7] suite
 
diff --git a/Documentation/git-export.txt b/Documentation/git-export.txt
--- a/Documentation/git-export.txt
+++ b/Documentation/git-export.txt
@@ -27,5 +27,5 @@ Documentation by David Greaves, Junio C 
 
 GIT
 ---
-Part of the link:git.html[git] suite
+Part of the gitlink:git[7] suite
 
diff --git a/Documentation/git-fetch-pack.txt b/Documentation/git-fetch-pack.txt
--- a/Documentation/git-fetch-pack.txt
+++ b/Documentation/git-fetch-pack.txt
@@ -66,4 +66,4 @@ Documentation by Junio C Hamano.
 
 GIT
 ---
-Part of the link:git.html[git] suite
+Part of the gitlink:git[7] suite
diff --git a/Documentation/git-fetch.txt b/Documentation/git-fetch.txt
--- a/Documentation/git-fetch.txt
+++ b/Documentation/git-fetch.txt
@@ -44,4 +44,4 @@ Documentation by David Greaves, Junio C 
 
 GIT
 ---
-Part of the link:git.html[git] suite
+Part of the gitlink:git[7] suite
diff --git a/Documentation/git-format-patch.txt b/Documentation/git-format-patch.txt
--- a/Documentation/git-format-patch.txt
+++ b/Documentation/git-format-patch.txt
@@ -65,5 +65,5 @@ Documentation by Junio C Hamano and the 
 
 GIT
 ---
-Part of the link:git.html[git] suite
+Part of the gitlink:git[7] suite
 
diff --git a/Documentation/git-fsck-objects.txt b/Documentation/git-fsck-objects.txt
--- a/Documentation/git-fsck-objects.txt
+++ b/Documentation/git-fsck-objects.txt
@@ -141,5 +141,5 @@ Documentation by David Greaves, Junio C 
 
 GIT
 ---
-Part of the link:git.html[git] suite
+Part of the gitlink:git[7] suite
 
diff --git a/Documentation/git-get-tar-commit-id.txt b/Documentation/git-get-tar-commit-id.txt
--- a/Documentation/git-get-tar-commit-id.txt
+++ b/Documentation/git-get-tar-commit-id.txt
@@ -33,5 +33,5 @@ Documentation by Junio C Hamano and the 
 
 GIT
 ---
-Part of the link:git.html[git] suite
+Part of the gitlink:git[7] suite
 
diff --git a/Documentation/git-grep.txt b/Documentation/git-grep.txt
--- a/Documentation/git-grep.txt
+++ b/Documentation/git-grep.txt
@@ -43,5 +43,5 @@ Documentation by Junio C Hamano and the 
 
 GIT
 ---
-Part of the link:git.html[git] suite
+Part of the gitlink:git[7] suite
 
diff --git a/Documentation/git-hash-object.txt b/Documentation/git-hash-object.txt
--- a/Documentation/git-hash-object.txt
+++ b/Documentation/git-hash-object.txt
@@ -40,5 +40,5 @@ Documentation by David Greaves, Junio C 
 
 GIT
 ---
-Part of the link:git.html[git] suite
+Part of the gitlink:git[7] suite
 
diff --git a/Documentation/git-http-fetch.txt b/Documentation/git-http-fetch.txt
--- a/Documentation/git-http-fetch.txt
+++ b/Documentation/git-http-fetch.txt
@@ -38,5 +38,5 @@ Documentation by David Greaves, Junio C 
 
 GIT
 ---
-Part of the link:git.html[git] suite
+Part of the gitlink:git[7] suite
 
diff --git a/Documentation/git-init-db.txt b/Documentation/git-init-db.txt
--- a/Documentation/git-init-db.txt
+++ b/Documentation/git-init-db.txt
@@ -37,5 +37,5 @@ Documentation by David Greaves, Junio C 
 
 GIT
 ---
-Part of the link:git.html[git] suite
+Part of the gitlink:git[7] suite
 
diff --git a/Documentation/git-local-fetch.txt b/Documentation/git-local-fetch.txt
--- a/Documentation/git-local-fetch.txt
+++ b/Documentation/git-local-fetch.txt
@@ -40,5 +40,5 @@ Documentation by David Greaves, Junio C 
 
 GIT
 ---
-Part of the link:git.html[git] suite
+Part of the gitlink:git[7] suite
 
diff --git a/Documentation/git-log.txt b/Documentation/git-log.txt
--- a/Documentation/git-log.txt
+++ b/Documentation/git-log.txt
@@ -41,5 +41,5 @@ Documentation by David Greaves, Junio C 
 
 GIT
 ---
-Part of the link:git.html[git] suite
+Part of the gitlink:git[7] suite
 
diff --git a/Documentation/git-ls-files.txt b/Documentation/git-ls-files.txt
--- a/Documentation/git-ls-files.txt
+++ b/Documentation/git-ls-files.txt
@@ -180,7 +180,7 @@ An example:
 
 See Also
 --------
-link:git-read-tree.html[git-read-tree]
+gitlink:git-read-tree[1]
 
 
 Author
@@ -193,5 +193,5 @@ Documentation by David Greaves, Junio C 
 
 GIT
 ---
-Part of the link:git.html[git] suite
+Part of the gitlink:git[7] suite
 
diff --git a/Documentation/git-ls-remote.txt b/Documentation/git-ls-remote.txt
--- a/Documentation/git-ls-remote.txt
+++ b/Documentation/git-ls-remote.txt
@@ -60,5 +60,5 @@ Written by Junio C Hamano <junkio@cox.ne
 
 GIT
 ---
-Part of the link:git.html[git] suite
+Part of the gitlink:git[7] suite
 
diff --git a/Documentation/git-ls-tree.txt b/Documentation/git-ls-tree.txt
--- a/Documentation/git-ls-tree.txt
+++ b/Documentation/git-ls-tree.txt
@@ -51,5 +51,5 @@ Documentation by David Greaves, Junio C 
 
 GIT
 ---
-Part of the link:git.html[git] suite
+Part of the gitlink:git[7] suite
 
diff --git a/Documentation/git-mailinfo.txt b/Documentation/git-mailinfo.txt
--- a/Documentation/git-mailinfo.txt
+++ b/Documentation/git-mailinfo.txt
@@ -61,5 +61,5 @@ Documentation by Junio C Hamano and the 
 
 GIT
 ---
-Part of the link:git.html[git] suite
+Part of the gitlink:git[7] suite
 
diff --git a/Documentation/git-mailsplit.txt b/Documentation/git-mailsplit.txt
--- a/Documentation/git-mailsplit.txt
+++ b/Documentation/git-mailsplit.txt
@@ -32,5 +32,5 @@ Documentation by Junio C Hamano and the 
 
 GIT
 ---
-Part of the link:git.html[git] suite
+Part of the gitlink:git[7] suite
 
diff --git a/Documentation/git-merge-base.txt b/Documentation/git-merge-base.txt
--- a/Documentation/git-merge-base.txt
+++ b/Documentation/git-merge-base.txt
@@ -30,5 +30,5 @@ Documentation by David Greaves, Junio C 
 
 GIT
 ---
-Part of the link:git.html[git] suite
+Part of the gitlink:git[7] suite
 
diff --git a/Documentation/git-merge-index.txt b/Documentation/git-merge-index.txt
--- a/Documentation/git-merge-index.txt
+++ b/Documentation/git-merge-index.txt
@@ -85,5 +85,5 @@ Documentation by David Greaves, Junio C 
 
 GIT
 ---
-Part of the link:git.html[git] suite
+Part of the gitlink:git[7] suite
 
diff --git a/Documentation/git-merge-one-file.txt b/Documentation/git-merge-one-file.txt
--- a/Documentation/git-merge-one-file.txt
+++ b/Documentation/git-merge-one-file.txt
@@ -27,5 +27,5 @@ Documentation by David Greaves, Junio C 
 
 GIT
 ---
-Part of the link:git.html[git] suite
+Part of the gitlink:git[7] suite
 
diff --git a/Documentation/git-merge.txt b/Documentation/git-merge.txt
--- a/Documentation/git-merge.txt
+++ b/Documentation/git-merge.txt
@@ -49,4 +49,4 @@ Documentation by Junio C Hamano and the 
 
 GIT
 ---
-Part of the link:git.html[git] suite
+Part of the gitlink:git[7] suite
diff --git a/Documentation/git-mktag.txt b/Documentation/git-mktag.txt
--- a/Documentation/git-mktag.txt
+++ b/Documentation/git-mktag.txt
@@ -44,5 +44,5 @@ Documentation by David Greaves, Junio C 
 
 GIT
 ---
-Part of the link:git.html[git] suite
+Part of the gitlink:git[7] suite
 
diff --git a/Documentation/git-octopus.txt b/Documentation/git-octopus.txt
--- a/Documentation/git-octopus.txt
+++ b/Documentation/git-octopus.txt
@@ -35,5 +35,5 @@ Documentation by Junio C Hamano and the 
 
 GIT
 ---
-Part of the link:git.html[git] suite
+Part of the gitlink:git[7] suite
 
diff --git a/Documentation/git-pack-objects.txt b/Documentation/git-pack-objects.txt
--- a/Documentation/git-pack-objects.txt
+++ b/Documentation/git-pack-objects.txt
@@ -80,5 +80,5 @@ git-repack(1) git-prune-packed(1)
 
 GIT
 ---
-Part of the link:git.html[git] suite
+Part of the gitlink:git[7] suite
 
diff --git a/Documentation/git-parse-remote.txt b/Documentation/git-parse-remote.txt
--- a/Documentation/git-parse-remote.txt
+++ b/Documentation/git-parse-remote.txt
@@ -45,4 +45,4 @@ Documentation by Junio C Hamano and the 
 
 GIT
 ---
-Part of the link:git.html[git] suite
+Part of the gitlink:git[7] suite
diff --git a/Documentation/git-patch-id.txt b/Documentation/git-patch-id.txt
--- a/Documentation/git-patch-id.txt
+++ b/Documentation/git-patch-id.txt
@@ -33,5 +33,5 @@ Documentation by Junio C Hamano and the 
 
 GIT
 ---
-Part of the link:git.html[git] suite
+Part of the gitlink:git[7] suite
 
diff --git a/Documentation/git-peek-remote.txt b/Documentation/git-peek-remote.txt
--- a/Documentation/git-peek-remote.txt
+++ b/Documentation/git-peek-remote.txt
@@ -49,5 +49,5 @@ Documentation by Junio C Hamano.
 
 GIT
 ---
-Part of the link:git.html[git] suite
+Part of the gitlink:git[7] suite
 
diff --git a/Documentation/git-prune-packed.txt b/Documentation/git-prune-packed.txt
--- a/Documentation/git-prune-packed.txt
+++ b/Documentation/git-prune-packed.txt
@@ -38,5 +38,5 @@ git-pack-objects(1) git-repack(1)
 
 GIT
 ---
-Part of the link:git.html[git] suite
+Part of the gitlink:git[7] suite
 
diff --git a/Documentation/git-prune.txt b/Documentation/git-prune.txt
--- a/Documentation/git-prune.txt
+++ b/Documentation/git-prune.txt
@@ -39,5 +39,5 @@ Documentation by David Greaves, Junio C 
 
 GIT
 ---
-Part of the link:git.html[git] suite
+Part of the gitlink:git[7] suite
 
diff --git a/Documentation/git-pull.txt b/Documentation/git-pull.txt
--- a/Documentation/git-pull.txt
+++ b/Documentation/git-pull.txt
@@ -37,5 +37,5 @@ Documentation by David Greaves, Junio C 
 
 GIT
 ---
-Part of the link:git.html[git] suite
+Part of the gitlink:git[7] suite
 
diff --git a/Documentation/git-push.txt b/Documentation/git-push.txt
--- a/Documentation/git-push.txt
+++ b/Documentation/git-push.txt
@@ -32,5 +32,5 @@ Documentation by Junio C Hamano and the 
 
 GIT
 ---
-Part of the link:git.html[git] suite
+Part of the gitlink:git[7] suite
 
diff --git a/Documentation/git-read-tree.txt b/Documentation/git-read-tree.txt
--- a/Documentation/git-read-tree.txt
+++ b/Documentation/git-read-tree.txt
@@ -251,7 +251,7 @@ updated to the result of the merge.
 
 See Also
 --------
-link:git-write-tree.html[git-write-tree]; link:git-ls-files.html[git-ls-files]
+gitlink:git-write-tree[1]; gitlink:git-ls-files[1]
 
 
 Author
@@ -264,5 +264,5 @@ Documentation by David Greaves, Junio C 
 
 GIT
 ---
-Part of the link:git.html[git] suite
+Part of the gitlink:git[7] suite
 
diff --git a/Documentation/git-rebase.txt b/Documentation/git-rebase.txt
--- a/Documentation/git-rebase.txt
+++ b/Documentation/git-rebase.txt
@@ -31,5 +31,5 @@ Documentation by Junio C Hamano and the 
 
 GIT
 ---
-Part of the link:git.html[git] suite
+Part of the gitlink:git[7] suite
 
diff --git a/Documentation/git-receive-pack.txt b/Documentation/git-receive-pack.txt
--- a/Documentation/git-receive-pack.txt
+++ b/Documentation/git-receive-pack.txt
@@ -80,7 +80,7 @@ OPTIONS
 
 SEE ALSO
 --------
-link:git-send-pack.html[git-send-pack]
+gitlink:git-send-pack[1]
 
 
 Author
@@ -93,4 +93,4 @@ Documentation by Junio C Hamano.
 
 GIT
 ---
-Part of the link:git.html[git] suite
+Part of the gitlink:git[7] suite
diff --git a/Documentation/git-relink.txt b/Documentation/git-relink.txt
--- a/Documentation/git-relink.txt
+++ b/Documentation/git-relink.txt
@@ -33,5 +33,5 @@ Documentation by Junio C Hamano and the 
 
 GIT
 ---
-Part of the link:git.html[git] suite
+Part of the gitlink:git[7] suite
 
diff --git a/Documentation/git-rename.txt b/Documentation/git-rename.txt
--- a/Documentation/git-rename.txt
+++ b/Documentation/git-rename.txt
@@ -29,5 +29,5 @@ Documentation by David Greaves, Junio C 
 
 GIT
 ---
-Part of the link:git.html[git] suite
+Part of the gitlink:git[7] suite
 
diff --git a/Documentation/git-repack.txt b/Documentation/git-repack.txt
--- a/Documentation/git-repack.txt
+++ b/Documentation/git-repack.txt
@@ -55,5 +55,5 @@ git-pack-objects(1) git-prune-packed(1)
 
 GIT
 ---
-Part of the link:git.html[git] suite
+Part of the gitlink:git[7] suite
 
diff --git a/Documentation/git-request-pull.txt b/Documentation/git-request-pull.txt
--- a/Documentation/git-request-pull.txt
+++ b/Documentation/git-request-pull.txt
@@ -36,5 +36,5 @@ Documentation by Junio C Hamano and the 
 
 GIT
 ---
-Part of the link:git.html[git] suite
+Part of the gitlink:git[7] suite
 
diff --git a/Documentation/git-reset.txt b/Documentation/git-reset.txt
--- a/Documentation/git-reset.txt
+++ b/Documentation/git-reset.txt
@@ -41,5 +41,5 @@ Documentation by Junio C Hamano and the 
 
 GIT
 ---
-Part of the link:git.html[git] suite
+Part of the gitlink:git[7] suite
 
diff --git a/Documentation/git-resolve.txt b/Documentation/git-resolve.txt
--- a/Documentation/git-resolve.txt
+++ b/Documentation/git-resolve.txt
@@ -33,5 +33,5 @@ Documentation by David Greaves, Junio C 
 
 GIT
 ---
-Part of the link:git.html[git] suite
+Part of the gitlink:git[7] suite
 
diff --git a/Documentation/git-rev-list.txt b/Documentation/git-rev-list.txt
--- a/Documentation/git-rev-list.txt
+++ b/Documentation/git-rev-list.txt
@@ -95,5 +95,5 @@ Documentation by David Greaves, Junio C 
 
 GIT
 ---
-Part of the link:git.html[git] suite
+Part of the gitlink:git[7] suite
 
diff --git a/Documentation/git-rev-parse.txt b/Documentation/git-rev-parse.txt
--- a/Documentation/git-rev-parse.txt
+++ b/Documentation/git-rev-parse.txt
@@ -122,5 +122,5 @@ Documentation by Junio C Hamano and the 
 
 GIT
 ---
-Part of the link:git.html[git] suite
+Part of the gitlink:git[7] suite
 
diff --git a/Documentation/git-rev-tree.txt b/Documentation/git-rev-tree.txt
--- a/Documentation/git-rev-tree.txt
+++ b/Documentation/git-rev-tree.txt
@@ -84,5 +84,5 @@ Documentation by David Greaves, Junio C 
 
 GIT
 ---
-Part of the link:git.html[git] suite
+Part of the gitlink:git[7] suite
 
diff --git a/Documentation/git-revert.txt b/Documentation/git-revert.txt
--- a/Documentation/git-revert.txt
+++ b/Documentation/git-revert.txt
@@ -44,5 +44,5 @@ Documentation by Junio C Hamano and the 
 
 GIT
 ---
-Part of the link:git.html[git] suite
+Part of the gitlink:git[7] suite
 
diff --git a/Documentation/git-send-email.txt b/Documentation/git-send-email.txt
--- a/Documentation/git-send-email.txt
+++ b/Documentation/git-send-email.txt
@@ -75,5 +75,5 @@ Documentation by Ryan Anderson
 
 GIT
 ---
-Part of the link:git.html[git] suite
+Part of the gitlink:git[7] suite
 
diff --git a/Documentation/git-send-pack.txt b/Documentation/git-send-pack.txt
--- a/Documentation/git-send-pack.txt
+++ b/Documentation/git-send-pack.txt
@@ -108,4 +108,4 @@ Documentation by Junio C Hamano.
 
 GIT
 ---
-Part of the link:git.html[git] suite
+Part of the gitlink:git[7] suite
diff --git a/Documentation/git-sh-setup.txt b/Documentation/git-sh-setup.txt
--- a/Documentation/git-sh-setup.txt
+++ b/Documentation/git-sh-setup.txt
@@ -30,5 +30,5 @@ Documentation by Junio C Hamano and the 
 
 GIT
 ---
-Part of the link:git.html[git] suite
+Part of the gitlink:git[7] suite
 
diff --git a/Documentation/git-shortlog.txt b/Documentation/git-shortlog.txt
--- a/Documentation/git-shortlog.txt
+++ b/Documentation/git-shortlog.txt
@@ -27,5 +27,5 @@ Documentation by Junio C Hamano.
 
 GIT
 ---
-Part of the link:git.html[git] suite
+Part of the gitlink:git[7] suite
 
diff --git a/Documentation/git-show-branch.txt b/Documentation/git-show-branch.txt
--- a/Documentation/git-show-branch.txt
+++ b/Documentation/git-show-branch.txt
@@ -117,4 +117,4 @@ Documentation by Junio C Hamano.
 
 GIT
 ---
-Part of the link:git.html[git] suite
+Part of the gitlink:git[7] suite
diff --git a/Documentation/git-show-index.txt b/Documentation/git-show-index.txt
--- a/Documentation/git-show-index.txt
+++ b/Documentation/git-show-index.txt
@@ -32,5 +32,5 @@ Documentation by Junio C Hamano
 
 GIT
 ---
-Part of the link:git.html[git] suite
+Part of the gitlink:git[7] suite
 
diff --git a/Documentation/git-ssh-fetch.txt b/Documentation/git-ssh-fetch.txt
--- a/Documentation/git-ssh-fetch.txt
+++ b/Documentation/git-ssh-fetch.txt
@@ -48,5 +48,5 @@ Documentation by David Greaves, Junio C 
 
 GIT
 ---
-Part of the link:git.html[git] suite
+Part of the gitlink:git[7] suite
 
diff --git a/Documentation/git-ssh-upload.txt b/Documentation/git-ssh-upload.txt
--- a/Documentation/git-ssh-upload.txt
+++ b/Documentation/git-ssh-upload.txt
@@ -44,5 +44,5 @@ Documentation by Daniel Barkalow
 
 GIT
 ---
-Part of the link:git.html[git] suite
+Part of the gitlink:git[7] suite
 
diff --git a/Documentation/git-status.txt b/Documentation/git-status.txt
--- a/Documentation/git-status.txt
+++ b/Documentation/git-status.txt
@@ -42,5 +42,5 @@ Documentation by David Greaves, Junio C 
 
 GIT
 ---
-Part of the link:git.html[git] suite
+Part of the gitlink:git[7] suite
 
diff --git a/Documentation/git-stripspace.txt b/Documentation/git-stripspace.txt
--- a/Documentation/git-stripspace.txt
+++ b/Documentation/git-stripspace.txt
@@ -29,5 +29,5 @@ Documentation by Junio C Hamano and the 
 
 GIT
 ---
-Part of the link:git.html[git] suite
+Part of the gitlink:git[7] suite
 
diff --git a/Documentation/git-tag.txt b/Documentation/git-tag.txt
--- a/Documentation/git-tag.txt
+++ b/Documentation/git-tag.txt
@@ -36,4 +36,4 @@ Documentation by David Greaves, Junio C 
 
 GIT
 ---
-Part of the link:git.html[git] suite
+Part of the gitlink:git[7] suite
diff --git a/Documentation/git-tar-tree.txt b/Documentation/git-tar-tree.txt
--- a/Documentation/git-tar-tree.txt
+++ b/Documentation/git-tar-tree.txt
@@ -35,5 +35,5 @@ Documentation by David Greaves, Junio C 
 
 GIT
 ---
-Part of the link:git.html[git] suite
+Part of the gitlink:git[7] suite
 
diff --git a/Documentation/git-unpack-file.txt b/Documentation/git-unpack-file.txt
--- a/Documentation/git-unpack-file.txt
+++ b/Documentation/git-unpack-file.txt
@@ -33,5 +33,5 @@ Documentation by David Greaves, Junio C 
 
 GIT
 ---
-Part of the link:git.html[git] suite
+Part of the gitlink:git[7] suite
 
diff --git a/Documentation/git-unpack-objects.txt b/Documentation/git-unpack-objects.txt
--- a/Documentation/git-unpack-objects.txt
+++ b/Documentation/git-unpack-objects.txt
@@ -35,5 +35,5 @@ Documentation by Junio C Hamano
 
 GIT
 ---
-Part of the link:git.html[git] suite
+Part of the gitlink:git[7] suite
 
diff --git a/Documentation/git-update-index.txt b/Documentation/git-update-index.txt
--- a/Documentation/git-update-index.txt
+++ b/Documentation/git-update-index.txt
@@ -122,5 +122,5 @@ Documentation by David Greaves, Junio C 
 
 GIT
 ---
-Part of the link:git.html[git] suite
+Part of the gitlink:git[7] suite
 
diff --git a/Documentation/git-update-server-info.txt b/Documentation/git-update-server-info.txt
--- a/Documentation/git-update-server-info.txt
+++ b/Documentation/git-update-server-info.txt
@@ -55,5 +55,5 @@ Documentation by Junio C Hamano.
 
 GIT
 ---
-Part of the link:git.html[git] suite
+Part of the gitlink:git[7] suite
 
diff --git a/Documentation/git-upload-pack.txt b/Documentation/git-upload-pack.txt
--- a/Documentation/git-upload-pack.txt
+++ b/Documentation/git-upload-pack.txt
@@ -37,4 +37,4 @@ Documentation by Junio C Hamano.
 
 GIT
 ---
-Part of the link:git.html[git] suite
+Part of the gitlink:git[7] suite
diff --git a/Documentation/git-var.txt b/Documentation/git-var.txt
--- a/Documentation/git-var.txt
+++ b/Documentation/git-var.txt
@@ -43,8 +43,8 @@ Your sysadmin must hate you!::
 
 See Also
 --------
-link:git-commit-tree.html[git-commit-tree]
-link:git-tag.html[git-tag]
+gitlink:git-commit-tree[1]
+gitlink:git-tag[1]
 
 Author
 ------
@@ -56,5 +56,5 @@ Documentation by Eric Biederman and the 
 
 GIT
 ---
-Part of the link:git.html[git] suite
+Part of the gitlink:git[7] suite
 
diff --git a/Documentation/git-verify-pack.txt b/Documentation/git-verify-pack.txt
--- a/Documentation/git-verify-pack.txt
+++ b/Documentation/git-verify-pack.txt
@@ -45,5 +45,5 @@ Documentation by Junio C Hamano
 
 GIT
 ---
-Part of the link:git.html[git] suite
+Part of the gitlink:git[7] suite
 
diff --git a/Documentation/git-verify-tag.txt b/Documentation/git-verify-tag.txt
--- a/Documentation/git-verify-tag.txt
+++ b/Documentation/git-verify-tag.txt
@@ -28,5 +28,5 @@ Documentation by Junio C Hamano and the 
 
 GIT
 ---
-Part of the link:git.html[git] suite
+Part of the gitlink:git[7] suite
 
diff --git a/Documentation/git-whatchanged.txt b/Documentation/git-whatchanged.txt
--- a/Documentation/git-whatchanged.txt
+++ b/Documentation/git-whatchanged.txt
@@ -57,5 +57,5 @@ Documentation by David Greaves, Junio C 
 
 GIT
 ---
-Part of the link:git.html[git] suite
+Part of the gitlink:git[7] suite
 
diff --git a/Documentation/git-write-tree.txt b/Documentation/git-write-tree.txt
--- a/Documentation/git-write-tree.txt
+++ b/Documentation/git-write-tree.txt
@@ -39,5 +39,5 @@ Documentation by David Greaves, Junio C 
 
 GIT
 ---
-Part of the link:git.html[git] suite
+Part of the gitlink:git[7] suite
 
diff --git a/Documentation/git.txt b/Documentation/git.txt
--- a/Documentation/git.txt
+++ b/Documentation/git.txt
@@ -21,8 +21,8 @@ at the link:tutorial.html[tutorial] docu
 
 The <<Discussion>> section below contains much useful definition and
 clarification info - read that first.  And of the commands, I suggest
-reading link:git-update-index.html[git-update-index] and
-link:git-read-tree.html[git-read-tree] first - I wish I had!
+reading gitlink:git-update-index[1] and
+gitlink:git-read-tree[1] first - I wish I had!
 
 If you are migrating from CVS, link:cvs-migration.html[cvs migration]
 document may be helpful after you finish the tutorial.
@@ -55,104 +55,104 @@ SCMs layered over git.
 
 Manipulation commands
 ~~~~~~~~~~~~~~~~~~~~~
-link:git-apply.html[git-apply]::
+gitlink:git-apply[1]::
 	Reads a "diff -up1" or git generated patch file and
 	applies it to the working tree.
 
-link:git-checkout-index.html[git-checkout-index]::
+gitlink:git-checkout-index[1]::
 	Copy files from the cache to the working directory
 	Previously this command was known as git-checkout-cache.
 
-link:git-commit-tree.html[git-commit-tree]::
+gitlink:git-commit-tree[1]::
 	Creates a new commit object
 
-link:git-hash-object.html[git-hash-object]::
+gitlink:git-hash-object[1]::
 	Computes the object ID from a file.
 
-link:git-init-db.html[git-init-db]::
+gitlink:git-init-db[1]::
 	Creates an empty git object database
 
-link:git-merge-index.html[git-merge-index]::
+gitlink:git-merge-index[1]::
 	Runs a merge for files needing merging
 	Previously this command was known as git-merge-cache.
 
-link:git-mktag.html[git-mktag]::
+gitlink:git-mktag[1]::
 	Creates a tag object
 
-link:git-pack-objects.html[git-pack-objects]::
+gitlink:git-pack-objects[1]::
 	Creates a packed archive of objects.
 
-link:git-prune-packed.html[git-prune-packed]::
+gitlink:git-prune-packed[1]::
 	Remove extra objects that are already in pack files.
 
-link:git-read-tree.html[git-read-tree]::
+gitlink:git-read-tree[1]::
 	Reads tree information into the directory cache
 
-link:git-unpack-objects.html[git-unpack-objects]::
+gitlink:git-unpack-objects[1]::
 	Unpacks objects out of a packed archive.
 
-link:git-update-index.html[git-update-index]::
+gitlink:git-update-index[1]::
 	Modifies the index or directory cache
 	Previously this command was known as git-update-cache.
 
-link:git-write-tree.html[git-write-tree]::
+gitlink:git-write-tree[1]::
 	Creates a tree from the current cache
 
 
 Interrogation commands
 ~~~~~~~~~~~~~~~~~~~~~~
 
-link:git-cat-file.html[git-cat-file]::
+gitlink:git-cat-file[1]::
 	Provide content or type information for repository objects
 
-link:git-diff-index.html[git-diff-index]::
+gitlink:git-diff-index[1]::
 	Compares content and mode of blobs between the cache and repository
 	Previously this command was known as git-diff-cache.
 
-link:git-diff-files.html[git-diff-files]::
+gitlink:git-diff-files[1]::
 	Compares files in the working tree and the cache
 
-link:git-diff-stages.html[git-diff-stages]::
+gitlink:git-diff-stages[1]::
 	Compares two "merge stages" in the index file.
 
-link:git-diff-tree.html[git-diff-tree]::
+gitlink:git-diff-tree[1]::
 	Compares the content and mode of blobs found via two tree objects
 
-link:git-export.html[git-export]::
+gitlink:git-export[1]::
 	Exports each commit and a diff against each of its parents
 
-link:git-fsck-objects.html[git-fsck-objects]::
+gitlink:git-fsck-objects[1]::
 	Verifies the connectivity and validity of the objects in the database
 	Previously this command was known as git-fsck-cache.
 
-link:git-ls-files.html[git-ls-files]::
+gitlink:git-ls-files[1]::
 	Information about files in the cache/working directory
 
-link:git-ls-tree.html[git-ls-tree]::
+gitlink:git-ls-tree[1]::
 	Displays a tree object in human readable form
 
-link:git-merge-base.html[git-merge-base]::
+gitlink:git-merge-base[1]::
 	Finds as good a common ancestor as possible for a merge
 
-link:git-rev-list.html[git-rev-list]::
+gitlink:git-rev-list[1]::
 	Lists commit objects in reverse chronological order
 
-link:git-rev-tree.html[git-rev-tree]::
+gitlink:git-rev-tree[1]::
 	Provides the revision tree for one or more commits
 
-link:git-show-index.html[git-show-index]::
+gitlink:git-show-index[1]::
 	Displays contents of a pack idx file.
 
-link:git-tar-tree.html[git-tar-tree]::
+gitlink:git-tar-tree[1]::
 	Creates a tar archive of the files in the named tree
 
-link:git-unpack-file.html[git-unpack-file]::
+gitlink:git-unpack-file[1]::
 	Creates a temporary file with a blob's contents
 
-link:git-var.html[git-var]::
+gitlink:git-var[1]::
 	Displays a git logical variable
 
-link:git-verify-pack.html[git-verify-pack]::
+gitlink:git-verify-pack[1]::
 	Validates packed GIT archive files
 
 The interrogate commands may create files - and you can force them to
@@ -162,43 +162,43 @@ touch the working file set - but in gene
 Synching repositories
 ~~~~~~~~~~~~~~~~~~~~~
 
-link:git-clone-pack.html[git-clone-pack]::
+gitlink:git-clone-pack[1]::
 	Clones a repository into the current repository (engine
 	for ssh and local transport)
 
-link:git-fetch-pack.html[git-fetch-pack]::
+gitlink:git-fetch-pack[1]::
 	Updates from a remote repository.
 
-link:git-http-fetch.html[git-http-fetch]::
+gitlink:git-http-fetch[1]::
 	Downloads a remote GIT repository via HTTP
 	Previously this command was known as git-http-pull.
 
-link:git-local-fetch.html[git-local-fetch]::
+gitlink:git-local-fetch[1]::
 	Duplicates another GIT repository on a local system
 	Previously this command was known as git-local-pull.
 
-link:git-peek-remote.html[git-peek-remote]::
+gitlink:git-peek-remote[1]::
 	Lists references on a remote repository using upload-pack protocol.
 
-link:git-receive-pack.html[git-receive-pack]::
+gitlink:git-receive-pack[1]::
 	Invoked by 'git-send-pack' to receive what is pushed to it.
 
-link:git-send-pack.html[git-send-pack]::
+gitlink:git-send-pack[1]::
 	Pushes to a remote repository, intelligently.
 
-link:git-ssh-fetch.html[git-ssh-fetch]::
+gitlink:git-ssh-fetch[1]::
 	Pulls from a remote repository over ssh connection
 	Previously this command was known as git-ssh-pull.
 
-link:git-ssh-upload.html[git-ssh-upload]::
+gitlink:git-ssh-upload[1]::
 	Helper "server-side" program used by git-ssh-fetch
 	Previously this command was known as git-ssh-push.
 
-link:git-update-server-info.html[git-update-server-info]::
+gitlink:git-update-server-info[1]::
 	Updates auxiliary information on a dumb server to help
 	clients discover references and packs on it.
 
-link:git-upload-pack.html[git-upload-pack]::
+gitlink:git-upload-pack[1]::
 	Invoked by 'git-clone-pack' and 'git-fetch-pack' to push
 	what are asked for.
 
@@ -206,114 +206,114 @@ link:git-upload-pack.html[git-upload-pac
 Porcelain-ish Commands
 ----------------------
 
-link:git-add.html[git-add]::
+gitlink:git-add[1]::
 	Add paths to the index file.
 	Previously this command was known as git-add-script.
 
-link:git-applymbox.html[git-applymbox]::
+gitlink:git-applymbox[1]::
 	Apply patches from a mailbox.
 
-link:git-bisect.html[git-bisect]::
+gitlink:git-bisect[1]::
 	Find the change that introduced a bug.
 	Previously this command was known as git-bisect-script.
 
-link:git-branch.html[git-branch]::
+gitlink:git-branch[1]::
 	Create and Show branches.
 	Previously this command was known as git-branch-script.
 
-link:git-checkout.html[git-checkout]::
+gitlink:git-checkout[1]::
 	Checkout and switch to a branch.
 	Previously this command was known as git-checkout-script.
 
-link:git-cherry-pick.html[git-cherry-pick]::
+gitlink:git-cherry-pick[1]::
 	Cherry-pick the effect of an existing commit.
 	Previously this command was known as git-cherry-pick-script.
 
-link:git-clone.html[git-clone]::
+gitlink:git-clone[1]::
 	Clones a repository into a new directory.
 	Previously this command was known as git-clone-script.
 
-link:git-commit.html[git-commit]::
+gitlink:git-commit[1]::
 	Record changes to the repository.
 	Previously this command was known as git-commit-script.
 
-link:git-diff.html[git-diff]::
+gitlink:git-diff[1]::
 	Show changes between commits, commit and working tree, etc.
 	Previously this command was known as git-diff-script.
 
-link:git-fetch.html[git-fetch]::
+gitlink:git-fetch[1]::
 	Download from a remote repository via various protocols.
 	Previously this command was known as git-fetch-script.
 
-link:git-format-patch.html[git-format-patch]::
+gitlink:git-format-patch[1]::
 	Prepare patches for e-mail submission.
 	Previously this command was known as git-format-patch-script.
 
-link:git-grep.html[git-grep]::
+gitlink:git-grep[1]::
 	Print lines matching a pattern
 
-link:git-log.html[git-log]::
+gitlink:git-log[1]::
 	Shows commit logs.
 	Previously this command was known as git-log-script.
 
-link:git-ls-remote.html[git-ls-remote]::
+gitlink:git-ls-remote[1]::
 	Shows references in a remote or local repository.
 	Previously this command was known as git-ls-remote-script.
 
-link:git-merge.html[git-merge]::
+gitlink:git-merge[1]::
 	Grand unified merge driver.
 
-link:git-octopus.html[git-octopus]::
+gitlink:git-octopus[1]::
 	Merge more than two commits.
 	Previously this command was known as git-octopus-script.
 
-link:git-pull.html[git-pull]::
+gitlink:git-pull[1]::
 	Fetch from and merge with a remote repository.
 	Previously this command was known as git-pull-script.
 
-link:git-push.html[git-push]::
+gitlink:git-push[1]::
 	Update remote refs along with associated objects.
 	Previously this command was known as git-push-script.
 
-link:git-rebase.html[git-rebase]::
+gitlink:git-rebase[1]::
 	Rebase local commits to new upstream head.
 	Previously this command was known as git-rebase-script.
 
-link:git-rename.html[git-rename]::
+gitlink:git-rename[1]::
 	Rename files and directories.
 	Previously this command was known as git-rename-script.
 
-link:git-repack.html[git-repack]::
+gitlink:git-repack[1]::
 	Pack unpacked objects in a repository.
 	Previously this command was known as git-repack-script.
 
-link:git-reset.html[git-reset]::
+gitlink:git-reset[1]::
 	Reset current HEAD to the specified state.
 	Previously this command was known as git-reset-script.
 
-link:git-resolve.html[git-resolve]::
+gitlink:git-resolve[1]::
 	Merge two commits.
 	Previously this command was known as git-resolve-script.
 
-link:git-revert.html[git-revert]::
+gitlink:git-revert[1]::
 	Revert an existing commit.
 	Previously this command was known as git-revert-script.
 
-link:git-shortlog.html[git-shortlog]::
+gitlink:git-shortlog[1]::
 	Summarizes 'git log' output.
 
-link:git-show-branch.html[git-show-branch]::
+gitlink:git-show-branch[1]::
 	Show branches and their commits.
 
-link:git-status.html[git-status]::
+gitlink:git-status[1]::
 	Shows the working tree status.
 	Previously this command was known as git-status-script.
 
-link:git-verify-tag.html[git-verify-tag]::
+gitlink:git-verify-tag[1]::
 	Check the GPG signature of tag.
 	Previously this command was known as git-verify-tag-script.
 
-link:git-whatchanged.html[git-whatchanged]::
+gitlink:git-whatchanged[1]::
 	Shows commit logs and differences they introduce.
 
 
@@ -321,92 +321,92 @@ Ancillary Commands
 ------------------
 Manipulators:
 
-link:git-applypatch.html[git-applypatch]::
+gitlink:git-applypatch[1]::
 	Apply one patch extracted from an e-mail.
 
-link:git-archimport.html[git-archimport]::
+gitlink:git-archimport[1]::
 	Import an arch repository into git.
 	Previously this command was known as git-archimport-script.
 
-link:git-convert-objects.html[git-convert-objects]::
+gitlink:git-convert-objects[1]::
 	Converts old-style GIT repository
 	Previously this command was known as git-convert-cache.
 
-link:git-cvsimport.html[git-cvsimport]::
+gitlink:git-cvsimport[1]::
 	Salvage your data out of another SCM people love to hate.
 	Previously this command was known as git-cvsimport-script.
 
-link:git-merge-one-file.html[git-merge-one-file]::
+gitlink:git-merge-one-file[1]::
 	The standard helper program to use with "git-merge-index"
 	Previously this command was known as git-merge-one-file-script.
 
-link:git-prune.html[git-prune]::
+gitlink:git-prune[1]::
 	Prunes all unreachable objects from the object database
 	Previously this command was known as git-prune-script.
 
-link:git-relink.html[git-relink]::
+gitlink:git-relink[1]::
 	Hardlink common objects in local repositories.
 	Previously this command was known as git-relink-script.
 
-link:git-sh-setup.html[git-sh-setup]::
+gitlink:git-sh-setup[1]::
 	Common git shell script setup code.
 	Previously this command was known as git-sh-setup-script.
 
-link:git-tag.html[git-tag]::
+gitlink:git-tag[1]::
 	An example script to create a tag object signed with GPG
 	Previously this command was known as git-tag-script.
 
 
 Interrogators:
 
-link:git-cherry.html[git-cherry]::
+gitlink:git-cherry[1]::
 	Find commits not merged upstream.
 
-link:git-count-objects.html[git-count-objects]::
+gitlink:git-count-objects[1]::
 	Count unpacked number of objects and their disk consumption.
 	Previously this command was known as git-count-objects-script.
 
-link:git-daemon.html[git-daemon]::
+gitlink:git-daemon[1]::
 	A really simple server for GIT repositories.
 
-link:git-diff-helper.html[git-diff-helper]::
+gitlink:git-diff-helper[1]::
 	Generates patch format output for git-diff-*
 
-link:git-get-tar-commit-id.html[git-get-tar-commit-id]::
+gitlink:git-get-tar-commit-id[1]::
 	Extract commit ID from an archive created using git-tar-tree.
 
-link:git-mailinfo.html[git-mailinfo]::
+gitlink:git-mailinfo[1]::
 	Extracts patch from a single e-mail message.
 
-link:git-mailsplit.html[git-mailsplit]::
+gitlink:git-mailsplit[1]::
 	git-mailsplit.
 
-link:git-patch-id.html[git-patch-id]::
+gitlink:git-patch-id[1]::
 	Compute unique ID for a patch.
 
-link:git-parse-remote.html[git-parse-remote]::
+gitlink:git-parse-remote[1]::
 	Routines to help parsing $GIT_DIR/remotes/
 	Previously this command was known as git-parse-remote-script.
 
-link:git-request-pull.html[git-request-pull]::
+gitlink:git-request-pull[1]::
 	git-request-pull.
 	Previously this command was known as git-request-pull-script.
 
-link:git-rev-parse.html[git-rev-parse]::
+gitlink:git-rev-parse[1]::
 	Pick out and massage parameters.
 
-link:git-send-email.html[git-send-email]::
+gitlink:git-send-email[1]::
 	Send patch e-mails out of "format-patch --mbox" output.
 	Previously this command was known as git-send-email-script.
 
-link:git-stripspace.html[git-stripspace]::
+gitlink:git-stripspace[1]::
 	Filter out empty lines.
 
 
 Commands not yet documented
 ---------------------------
 
-link:gitk.html[gitk]::
+gitlink:gitk[1]::
 	gitk.
 
 
@@ -511,16 +511,16 @@ git Commits
 'GIT_AUTHOR_DATE'::
 'GIT_COMMITTER_NAME'::
 'GIT_COMMITTER_EMAIL'::
-	see link:git-commit-tree.html[git-commit-tree]
+	see gitlink:git-commit-tree[1]
 
 git Diffs
 ~~~~~~~~~
 'GIT_DIFF_OPTS'::
 'GIT_EXTERNAL_DIFF'::
 	see the "generating patches" section in :
-	link:git-diff-index.html[git-diff-index];
-	link:git-diff-files.html[git-diff-files];
-	link:git-diff-tree.html[git-diff-tree]
+	gitlink:git-diff-index[1];
+	gitlink:git-diff-files[1];
+	gitlink:git-diff-tree[1]
 
 Discussion[[Discussion]]
 ------------------------
@@ -536,5 +536,5 @@ Documentation by David Greaves, Junio C 
 
 GIT
 ---
-Part of the link:git.html[git] suite
+Part of the gitlink:git[7] suite
 
diff --git a/Documentation/gitk.txt b/Documentation/gitk.txt
--- a/Documentation/gitk.txt
+++ b/Documentation/gitk.txt
@@ -34,5 +34,5 @@ Documentation by Junio C Hamano and the 
 
 GIT
 ---
-Part of the link:git.html[git] suite
+Part of the gitlink:git[7] suite
 
diff --git a/README b/README
--- a/README
+++ b/README
@@ -104,8 +104,8 @@ object. The object is totally independen
 directory tree, and renaming a file does not change the object that
 file is associated with in any way.
 
-A blob is typically created when link:git-update-index.html[git-update-index]
-is run, and its data can be accessed by link:git-cat-file.html[git-cat-file].
+A blob is typically created when gitlink:git-update-index[1]
+is run, and its data can be accessed by gitlink:git-cat-file[1].
 
 Tree Object
 ~~~~~~~~~~~
@@ -143,9 +143,9 @@ involved), you can see trivial renames o
 noticing that the blob stayed the same.  However, renames with data
 changes need a smarter "diff" implementation.
 
-A tree is created with link:git-write-tree.html[git-write-tree] and
-its data can be accessed by link:git-ls-tree.html[git-ls-tree].
-Two trees can be compared with link:git-diff-tree.html[git-diff-tree].
+A tree is created with gitlink:git-write-tree[1] and
+its data can be accessed by gitlink:git-ls-tree[1].
+Two trees can be compared with gitlink:git-diff-tree[1].
 
 Commit Object
 ~~~~~~~~~~~~~
@@ -169,8 +169,8 @@ implicit in the trees involved (the resu
 of the parents), and describing that makes no sense in this idiotic
 file manager.
 
-A commit is created with link:git-commit-tree.html[git-commit-tree] and
-its data can be accessed by link:git-cat-file.html[git-cat-file].
+A commit is created with gitlink:git-commit-tree[1] and
+its data can be accessed by gitlink:git-cat-file[1].
 
 Trust
 ~~~~~
@@ -215,10 +215,10 @@ Note that despite the tag features, "git
 integrity; the trust framework (and signature provision and
 verification) has to come from outside.
 
-A tag is created with link:git-mktag.html[git-mktag],
-its data can be accessed by link:git-cat-file.html[git-cat-file],
+A tag is created with gitlink:git-mktag[1],
+its data can be accessed by gitlink:git-cat-file[1],
 and the signature can be verified by
-link:git-verify-tag.html[git-verify-tag].
+gitlink:git-verify-tag[1].
 
 
 The "index" aka "Current Directory Cache"
@@ -286,7 +286,7 @@ main combinations: 
 ~~~~~~~~~~~~~~~~~~~~~~~~~~~~~
 
 You update the index with information from the working directory with
-the link:git-update-index.html[git-update-index] command.  You
+the gitlink:git-update-index[1] command.  You
 generally update the index information by just specifying the filename
 you want to update, like so:
 
@@ -404,7 +404,7 @@ last committed state was.
 
 You can examine the data represented in the object database and the
 index with various helper tools. For every object, you can use
-link:git-cat-file.html[git-cat-file] to examine details about the
+gitlink:git-cat-file[1] to examine details about the
 object:
 
 		git-cat-file -t <objectname>
