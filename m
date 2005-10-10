From: Christian Meder <chris@absolutegiganten.org>
Subject: [PATCH] Remove the version tags from the manpages
Date: Mon, 10 Oct 2005 23:25:07 +0200
Message-ID: <1128979507.7097.36.camel@localhost>
Mime-Version: 1.0
Content-Type: text/plain
Content-Transfer-Encoding: 7bit
X-From: git-owner@vger.kernel.org Mon Oct 10 23:28:26 2005
Return-path: <git-owner@vger.kernel.org>
Received: from vger.kernel.org ([209.132.176.167])
	by ciao.gmane.org with esmtp (Exim 4.43)
	id 1EP59x-0007Zd-Dz
	for gcvg-git@gmane.org; Mon, 10 Oct 2005 23:26:14 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751122AbVJJV0K (ORCPT <rfc822;gcvg-git@m.gmane.org>);
	Mon, 10 Oct 2005 17:26:10 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751256AbVJJV0K
	(ORCPT <rfc822;git-outgoing>); Mon, 10 Oct 2005 17:26:10 -0400
Received: from a15181680.alturo-server.de ([217.160.108.75]:8147 "EHLO
	a15181680.alturo-server.de") by vger.kernel.org with ESMTP
	id S1751122AbVJJV0I (ORCPT <rfc822;git@vger.kernel.org>);
	Mon, 10 Oct 2005 17:26:08 -0400
Received: from p54a21cce.dip0.t-ipconnect.de ([84.162.28.206] helo=localhost)
	by a15181680.alturo-server.de with esmtpsa (TLS-1.0:RSA_AES_256_CBC_SHA1:32)
	(Exim 4.52)
	id 1EP59r-00066Q-6s
	for git@vger.kernel.org; Mon, 10 Oct 2005 23:26:07 +0200
Received: from chris by localhost with local (Exim 4.52)
	id 1EP58t-00026w-NC
	for git@vger.kernel.org; Mon, 10 Oct 2005 23:25:07 +0200
To: git@vger.kernel.org
X-Mailer: Evolution 2.2.3 
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/9939>

Remove the version tags from the manpages.

Signed-off-by: Christian Meder <chris@absolutegiganten.org>

---

 Documentation/cvs-migration.txt          |    1 -
 Documentation/git-apply.txt              |    1 -
 Documentation/git-cat-file.txt           |    1 -
 Documentation/git-checkout-index.txt     |    1 -
 Documentation/git-cherry-pick.txt        |    1 -
 Documentation/git-clone-pack.txt         |    1 -
 Documentation/git-clone.txt              |    1 -
 Documentation/git-commit-tree.txt        |    1 -
 Documentation/git-commit.txt             |    1 -
 Documentation/git-convert-objects.txt    |    1 -
 Documentation/git-cvsimport.txt          |    1 -
 Documentation/git-diff-files.txt         |    1 -
 Documentation/git-diff-index.txt         |    1 -
 Documentation/git-diff-stages.txt        |    1 -
 Documentation/git-diff-tree.txt          |    1 -
 Documentation/git-fetch-pack.txt         |    1 -
 Documentation/git-fetch.txt              |    1 -
 Documentation/git-fsck-objects.txt       |    1 -
 Documentation/git-grep.txt               |    1 -
 Documentation/git-hash-object.txt        |    1 -
 Documentation/git-http-fetch.txt         |    1 -
 Documentation/git-init-db.txt            |    1 -
 Documentation/git-local-fetch.txt        |    1 -
 Documentation/git-log.txt                |    1 -
 Documentation/git-ls-remote.txt          |    1 -
 Documentation/git-ls-tree.txt            |    1 -
 Documentation/git-merge-base.txt         |    1 -
 Documentation/git-merge-index.txt        |    1 -
 Documentation/git-merge-one-file.txt     |    1 -
 Documentation/git-merge.txt              |    1 -
 Documentation/git-mktag.txt              |    1 -
 Documentation/git-octopus.txt            |    1 -
 Documentation/git-pack-objects.txt       |    1 -
 Documentation/git-peek-remote.txt        |    1 -
 Documentation/git-prune-packed.txt       |    1 -
 Documentation/git-prune.txt              |    1 -
 Documentation/git-pull.txt               |    1 -
 Documentation/git-read-tree.txt          |    1 -
 Documentation/git-receive-pack.txt       |    1 -
 Documentation/git-rename.txt             |    1 -
 Documentation/git-repack.txt             |    1 -
 Documentation/git-resolve.txt            |    1 -
 Documentation/git-rev-list.txt           |    1 -
 Documentation/git-send-email.txt         |    1 -
 Documentation/git-send-pack.txt          |    1 -
 Documentation/git-shortlog.txt           |    1 -
 Documentation/git-show-branch.txt        |    1 -
 Documentation/git-show-index.txt         |    1 -
 Documentation/git-ssh-fetch.txt          |    1 -
 Documentation/git-ssh-upload.txt         |    1 -
 Documentation/git-status.txt             |    1 -
 Documentation/git-tag.txt                |    1 -
 Documentation/git-tar-tree.txt           |    1 -
 Documentation/git-unpack-file.txt        |    1 -
 Documentation/git-unpack-objects.txt     |    1 -
 Documentation/git-update-server-info.txt |    1 -
 Documentation/git-upload-pack.txt        |    1 -
 Documentation/git-var.txt                |    1 -
 Documentation/git-verify-pack.txt        |    1 -
 Documentation/git-whatchanged.txt        |    1 -
 Documentation/git-write-tree.txt         |    1 -
 Documentation/git.txt                    |    1 -
 Documentation/hooks.txt                  |    1 -
 Documentation/repository-layout.txt      |    1 -
 Documentation/tutorial.txt               |    1 -
 65 files changed, 0 insertions(+), 65 deletions(-)

39c33dea976abc89b5897e24e95711c7bde43617
diff --git a/Documentation/cvs-migration.txt b/Documentation/cvs-migration.txt
--- a/Documentation/cvs-migration.txt
+++ b/Documentation/cvs-migration.txt
@@ -1,6 +1,5 @@
 Git for CVS users
 =================
-v0.99.5, Aug 2005
 
 Ok, so you're a CVS user. That's ok, it's a treatable condition, and the
 first step to recovery is admitting you have a problem. The fact that
diff --git a/Documentation/git-apply.txt b/Documentation/git-apply.txt
--- a/Documentation/git-apply.txt
+++ b/Documentation/git-apply.txt
@@ -1,6 +1,5 @@
 git-apply(1)
 ============
-v0.1, June 2005
 
 NAME
 ----
diff --git a/Documentation/git-cat-file.txt b/Documentation/git-cat-file.txt
--- a/Documentation/git-cat-file.txt
+++ b/Documentation/git-cat-file.txt
@@ -1,6 +1,5 @@
 git-cat-file(1)
 ===============
-v0.1, May 2005
 
 NAME
 ----
diff --git a/Documentation/git-checkout-index.txt b/Documentation/git-checkout-index.txt
--- a/Documentation/git-checkout-index.txt
+++ b/Documentation/git-checkout-index.txt
@@ -1,6 +1,5 @@
 git-checkout-index(1)
 =====================
-v0.1, May 2005
 
 NAME
 ----
diff --git a/Documentation/git-cherry-pick.txt b/Documentation/git-cherry-pick.txt
--- a/Documentation/git-cherry-pick.txt
+++ b/Documentation/git-cherry-pick.txt
@@ -1,6 +1,5 @@
 git-cherry-pick(1)
 ==================
-v0.99.5 Aug 2005
 
 NAME
 ----
diff --git a/Documentation/git-clone-pack.txt b/Documentation/git-clone-pack.txt
--- a/Documentation/git-clone-pack.txt
+++ b/Documentation/git-clone-pack.txt
@@ -1,6 +1,5 @@
 git-clone-pack(1)
 =================
-v0.1, July 2005
 
 NAME
 ----
diff --git a/Documentation/git-clone.txt b/Documentation/git-clone.txt
--- a/Documentation/git-clone.txt
+++ b/Documentation/git-clone.txt
@@ -1,6 +1,5 @@
 git-clone(1)
 ============
-v0.1, July 2005
 
 NAME
 ----
diff --git a/Documentation/git-commit-tree.txt b/Documentation/git-commit-tree.txt
--- a/Documentation/git-commit-tree.txt
+++ b/Documentation/git-commit-tree.txt
@@ -1,6 +1,5 @@
 git-commit-tree(1)
 ==================
-v0.1, May 2005
 
 NAME
 ----
diff --git a/Documentation/git-commit.txt b/Documentation/git-commit.txt
--- a/Documentation/git-commit.txt
+++ b/Documentation/git-commit.txt
@@ -1,6 +1,5 @@
 git-commit(1)
 =============
-v0.99.4, Aug 2005
 
 NAME
 ----
diff --git a/Documentation/git-convert-objects.txt b/Documentation/git-convert-objects.txt
--- a/Documentation/git-convert-objects.txt
+++ b/Documentation/git-convert-objects.txt
@@ -1,6 +1,5 @@
 git-convert-objects(1)
 ======================
-v0.1, May 2005
 
 NAME
 ----
diff --git a/Documentation/git-cvsimport.txt b/Documentation/git-cvsimport.txt
--- a/Documentation/git-cvsimport.txt
+++ b/Documentation/git-cvsimport.txt
@@ -1,6 +1,5 @@
 git-cvsimport(1)
 ================
-v0.1, July 2005
 
 NAME
 ----
diff --git a/Documentation/git-diff-files.txt b/Documentation/git-diff-files.txt
--- a/Documentation/git-diff-files.txt
+++ b/Documentation/git-diff-files.txt
@@ -1,6 +1,5 @@
 git-diff-files(1)
 =================
-v0.1, May 2005
 
 NAME
 ----
diff --git a/Documentation/git-diff-index.txt b/Documentation/git-diff-index.txt
--- a/Documentation/git-diff-index.txt
+++ b/Documentation/git-diff-index.txt
@@ -1,6 +1,5 @@
 git-diff-index(1)
 =================
-v0.1, May 2005
 
 NAME
 ----
diff --git a/Documentation/git-diff-stages.txt b/Documentation/git-diff-stages.txt
--- a/Documentation/git-diff-stages.txt
+++ b/Documentation/git-diff-stages.txt
@@ -1,6 +1,5 @@
 git-diff-stages(1)
 ==================
-v0.1, June 2005
 
 NAME
 ----
diff --git a/Documentation/git-diff-tree.txt b/Documentation/git-diff-tree.txt
--- a/Documentation/git-diff-tree.txt
+++ b/Documentation/git-diff-tree.txt
@@ -1,6 +1,5 @@
 git-diff-tree(1)
 ================
-v0.1, May 2005
 
 NAME
 ----
diff --git a/Documentation/git-fetch-pack.txt b/Documentation/git-fetch-pack.txt
--- a/Documentation/git-fetch-pack.txt
+++ b/Documentation/git-fetch-pack.txt
@@ -1,6 +1,5 @@
 git-fetch-pack(1)
 =================
-v0.1, July 2005
 
 NAME
 ----
diff --git a/Documentation/git-fetch.txt b/Documentation/git-fetch.txt
--- a/Documentation/git-fetch.txt
+++ b/Documentation/git-fetch.txt
@@ -1,6 +1,5 @@
 git-fetch(1)
 ============
-v0.99.5, Aug 2005
 
 NAME
 ----
diff --git a/Documentation/git-fsck-objects.txt b/Documentation/git-fsck-objects.txt
--- a/Documentation/git-fsck-objects.txt
+++ b/Documentation/git-fsck-objects.txt
@@ -1,6 +1,5 @@
 git-fsck-objects(1)
 ===================
-v0.1, May 2005
 
 NAME
 ----
diff --git a/Documentation/git-grep.txt b/Documentation/git-grep.txt
--- a/Documentation/git-grep.txt
+++ b/Documentation/git-grep.txt
@@ -1,6 +1,5 @@
 git-grep(1)
 ===========
-v0.99.6, Sep 2005
 
 NAME
 ----
diff --git a/Documentation/git-hash-object.txt b/Documentation/git-hash-object.txt
--- a/Documentation/git-hash-object.txt
+++ b/Documentation/git-hash-object.txt
@@ -1,6 +1,5 @@
 git-hash-object(1)
 ==================
-v0.1, May 2005
 
 NAME
 ----
diff --git a/Documentation/git-http-fetch.txt b/Documentation/git-http-fetch.txt
--- a/Documentation/git-http-fetch.txt
+++ b/Documentation/git-http-fetch.txt
@@ -1,6 +1,5 @@
 git-http-fetch(1)
 =================
-v0.1, May 2005
 
 NAME
 ----
diff --git a/Documentation/git-init-db.txt b/Documentation/git-init-db.txt
--- a/Documentation/git-init-db.txt
+++ b/Documentation/git-init-db.txt
@@ -1,6 +1,5 @@
 git-init-db(1)
 ==============
-v0.1, May 2005
 
 NAME
 ----
diff --git a/Documentation/git-local-fetch.txt b/Documentation/git-local-fetch.txt
--- a/Documentation/git-local-fetch.txt
+++ b/Documentation/git-local-fetch.txt
@@ -1,6 +1,5 @@
 git-local-fetch(1)
 ==================
-v0.1, May 2005
 
 NAME
 ----
diff --git a/Documentation/git-log.txt b/Documentation/git-log.txt
--- a/Documentation/git-log.txt
+++ b/Documentation/git-log.txt
@@ -1,6 +1,5 @@
 git-log(1)
 ==========
-v0.99.4, Aug 2005
 
 NAME
 ----
diff --git a/Documentation/git-ls-remote.txt b/Documentation/git-ls-remote.txt
--- a/Documentation/git-ls-remote.txt
+++ b/Documentation/git-ls-remote.txt
@@ -1,6 +1,5 @@
 git-ls-remote(1)
 ================
-v0.1, May 2005
 
 NAME
 ----
diff --git a/Documentation/git-ls-tree.txt b/Documentation/git-ls-tree.txt
--- a/Documentation/git-ls-tree.txt
+++ b/Documentation/git-ls-tree.txt
@@ -1,6 +1,5 @@
 git-ls-tree(1)
 ==============
-v0.1, May 2005
 
 NAME
 ----
diff --git a/Documentation/git-merge-base.txt b/Documentation/git-merge-base.txt
--- a/Documentation/git-merge-base.txt
+++ b/Documentation/git-merge-base.txt
@@ -1,6 +1,5 @@
 git-merge-base(1)
 =================
-v0.1, May 2005
 
 NAME
 ----
diff --git a/Documentation/git-merge-index.txt b/Documentation/git-merge-index.txt
--- a/Documentation/git-merge-index.txt
+++ b/Documentation/git-merge-index.txt
@@ -1,6 +1,5 @@
 git-merge-index(1)
 ==================
-v0.1, May 2005
 
 NAME
 ----
diff --git a/Documentation/git-merge-one-file.txt b/Documentation/git-merge-one-file.txt
--- a/Documentation/git-merge-one-file.txt
+++ b/Documentation/git-merge-one-file.txt
@@ -1,6 +1,5 @@
 git-merge-one-file(1)
 =====================
-v0.99.4, Aug 2005
 
 NAME
 ----
diff --git a/Documentation/git-merge.txt b/Documentation/git-merge.txt
--- a/Documentation/git-merge.txt
+++ b/Documentation/git-merge.txt
@@ -1,6 +1,5 @@
 git-merge(1)
 ============
-v0.99.6, Sep 2005
 
 NAME
 ----
diff --git a/Documentation/git-mktag.txt b/Documentation/git-mktag.txt
--- a/Documentation/git-mktag.txt
+++ b/Documentation/git-mktag.txt
@@ -1,6 +1,5 @@
 git-mktag(1)
 ============
-v0.1, May 2005
 
 NAME
 ----
diff --git a/Documentation/git-octopus.txt b/Documentation/git-octopus.txt
--- a/Documentation/git-octopus.txt
+++ b/Documentation/git-octopus.txt
@@ -1,6 +1,5 @@
 git-octopus(1)
 ==============
-v0.99.5, Aug 2005
 
 NAME
 ----
diff --git a/Documentation/git-pack-objects.txt b/Documentation/git-pack-objects.txt
--- a/Documentation/git-pack-objects.txt
+++ b/Documentation/git-pack-objects.txt
@@ -1,6 +1,5 @@
 git-pack-objects(1)
 ===================
-v0.1, July 2005
 
 NAME
 ----
diff --git a/Documentation/git-peek-remote.txt b/Documentation/git-peek-remote.txt
--- a/Documentation/git-peek-remote.txt
+++ b/Documentation/git-peek-remote.txt
@@ -1,6 +1,5 @@
 git-peek-remote(1)
 ==================
-v0.1, July 2005
 
 NAME
 ----
diff --git a/Documentation/git-prune-packed.txt b/Documentation/git-prune-packed.txt
--- a/Documentation/git-prune-packed.txt
+++ b/Documentation/git-prune-packed.txt
@@ -1,6 +1,5 @@
 git-prune-packed(1)
 =====================
-v0.1, August 2005
 
 NAME
 ----
diff --git a/Documentation/git-prune.txt b/Documentation/git-prune.txt
--- a/Documentation/git-prune.txt
+++ b/Documentation/git-prune.txt
@@ -1,6 +1,5 @@
 git-prune(1)
 ============
-v0.99.5, Aug 2005
 
 NAME
 ----
diff --git a/Documentation/git-pull.txt b/Documentation/git-pull.txt
--- a/Documentation/git-pull.txt
+++ b/Documentation/git-pull.txt
@@ -1,6 +1,5 @@
 git-pull(1)
 ===========
-v0.99.4, Aug 2005
 
 NAME
 ----
diff --git a/Documentation/git-read-tree.txt b/Documentation/git-read-tree.txt
--- a/Documentation/git-read-tree.txt
+++ b/Documentation/git-read-tree.txt
@@ -1,6 +1,5 @@
 git-read-tree(1)
 ================
-v0.1, May 2005
 
 NAME
 ----
diff --git a/Documentation/git-receive-pack.txt b/Documentation/git-receive-pack.txt
--- a/Documentation/git-receive-pack.txt
+++ b/Documentation/git-receive-pack.txt
@@ -1,6 +1,5 @@
 git-receive-pack(1)
 ===================
-v0.1, July 2005
 
 NAME
 ----
diff --git a/Documentation/git-rename.txt b/Documentation/git-rename.txt
--- a/Documentation/git-rename.txt
+++ b/Documentation/git-rename.txt
@@ -1,6 +1,5 @@
 git-rename(1)
 =============
-v0.1, May 2005
 
 NAME
 ----
diff --git a/Documentation/git-repack.txt b/Documentation/git-repack.txt
--- a/Documentation/git-repack.txt
+++ b/Documentation/git-repack.txt
@@ -1,6 +1,5 @@
 git-repack(1)
 =============
-v0.99.5, August 2005
 
 NAME
 ----
diff --git a/Documentation/git-resolve.txt b/Documentation/git-resolve.txt
--- a/Documentation/git-resolve.txt
+++ b/Documentation/git-resolve.txt
@@ -1,6 +1,5 @@
 git-resolve(1)
 ==============
-v0.99.5, Aug 2005
 
 NAME
 ----
diff --git a/Documentation/git-rev-list.txt b/Documentation/git-rev-list.txt
--- a/Documentation/git-rev-list.txt
+++ b/Documentation/git-rev-list.txt
@@ -1,6 +1,5 @@
 git-rev-list(1)
 ===============
-v0.1, May 2005
 
 NAME
 ----
diff --git a/Documentation/git-send-email.txt b/Documentation/git-send-email.txt
--- a/Documentation/git-send-email.txt
+++ b/Documentation/git-send-email.txt
@@ -1,6 +1,5 @@
 git-send-email(1)
 =================
-v0.1, July 2005
 
 NAME
 ----
diff --git a/Documentation/git-send-pack.txt b/Documentation/git-send-pack.txt
--- a/Documentation/git-send-pack.txt
+++ b/Documentation/git-send-pack.txt
@@ -1,6 +1,5 @@
 git-send-pack(1)
 ================
-v0.1, July 2005
 
 NAME
 ----
diff --git a/Documentation/git-shortlog.txt b/Documentation/git-shortlog.txt
--- a/Documentation/git-shortlog.txt
+++ b/Documentation/git-shortlog.txt
@@ -1,6 +1,5 @@
 git-shortlog(1)
 ===============
-v0.99.4, Aug 2005
 
 NAME
 ----
diff --git a/Documentation/git-show-branch.txt b/Documentation/git-show-branch.txt
--- a/Documentation/git-show-branch.txt
+++ b/Documentation/git-show-branch.txt
@@ -1,6 +1,5 @@
 git-show-branch(1)
 ==================
-v0.99.5, Aug 2005
 
 NAME
 ----
diff --git a/Documentation/git-show-index.txt b/Documentation/git-show-index.txt
--- a/Documentation/git-show-index.txt
+++ b/Documentation/git-show-index.txt
@@ -1,6 +1,5 @@
 git-show-index(1)
 =================
-v0.1, July 2005
 
 NAME
 ----
diff --git a/Documentation/git-ssh-fetch.txt b/Documentation/git-ssh-fetch.txt
--- a/Documentation/git-ssh-fetch.txt
+++ b/Documentation/git-ssh-fetch.txt
@@ -1,6 +1,5 @@
 git-ssh-fetch(1)
 ================
-v0.1, May 2005
 
 NAME
 ----
diff --git a/Documentation/git-ssh-upload.txt b/Documentation/git-ssh-upload.txt
--- a/Documentation/git-ssh-upload.txt
+++ b/Documentation/git-ssh-upload.txt
@@ -1,6 +1,5 @@
 git-ssh-upload(1)
 =================
-v0.1, Jun 2005
 
 NAME
 ----
diff --git a/Documentation/git-status.txt b/Documentation/git-status.txt
--- a/Documentation/git-status.txt
+++ b/Documentation/git-status.txt
@@ -1,6 +1,5 @@
 git-status(1)
 =============
-v0.99.4, Aug 2005
 
 NAME
 ----
diff --git a/Documentation/git-tag.txt b/Documentation/git-tag.txt
--- a/Documentation/git-tag.txt
+++ b/Documentation/git-tag.txt
@@ -1,6 +1,5 @@
 git-tag(1)
 ==========
-v0.99.4, Aug 2005
 
 NAME
 ----
diff --git a/Documentation/git-tar-tree.txt b/Documentation/git-tar-tree.txt
--- a/Documentation/git-tar-tree.txt
+++ b/Documentation/git-tar-tree.txt
@@ -1,6 +1,5 @@
 git-tar-tree(1)
 ===============
-v0.1, May 2005
 
 NAME
 ----
diff --git a/Documentation/git-unpack-file.txt b/Documentation/git-unpack-file.txt
--- a/Documentation/git-unpack-file.txt
+++ b/Documentation/git-unpack-file.txt
@@ -1,6 +1,5 @@
 git-unpack-file(1)
 ==================
-v0.1, May 2005
 
 NAME
 ----
diff --git a/Documentation/git-unpack-objects.txt b/Documentation/git-unpack-objects.txt
--- a/Documentation/git-unpack-objects.txt
+++ b/Documentation/git-unpack-objects.txt
@@ -1,6 +1,5 @@
 git-unpack-objects(1)
 =====================
-v0.1, July 2005
 
 NAME
 ----
diff --git a/Documentation/git-update-server-info.txt b/Documentation/git-update-server-info.txt
--- a/Documentation/git-update-server-info.txt
+++ b/Documentation/git-update-server-info.txt
@@ -1,6 +1,5 @@
 git-update-server-info(1)
 =========================
-v0.1, July 2005
 
 NAME
 ----
diff --git a/Documentation/git-upload-pack.txt b/Documentation/git-upload-pack.txt
--- a/Documentation/git-upload-pack.txt
+++ b/Documentation/git-upload-pack.txt
@@ -1,6 +1,5 @@
 git-upload-pack(1)
 ==================
-v0.1, July 2005
 
 NAME
 ----
diff --git a/Documentation/git-var.txt b/Documentation/git-var.txt
--- a/Documentation/git-var.txt
+++ b/Documentation/git-var.txt
@@ -1,6 +1,5 @@
 git-var(1)
 ==========
-v0.1, July 2005
 
 NAME
 ----
diff --git a/Documentation/git-verify-pack.txt b/Documentation/git-verify-pack.txt
--- a/Documentation/git-verify-pack.txt
+++ b/Documentation/git-verify-pack.txt
@@ -1,6 +1,5 @@
 git-verify-pack(1)
 ==================
-v0.1, June 2005
 
 NAME
 ----
diff --git a/Documentation/git-whatchanged.txt b/Documentation/git-whatchanged.txt
--- a/Documentation/git-whatchanged.txt
+++ b/Documentation/git-whatchanged.txt
@@ -1,6 +1,5 @@
 git-whatchanged(1)
 ==================
-v0.99.4, Aug 2005
 
 NAME
 ----
diff --git a/Documentation/git-write-tree.txt b/Documentation/git-write-tree.txt
--- a/Documentation/git-write-tree.txt
+++ b/Documentation/git-write-tree.txt
@@ -1,6 +1,5 @@
 git-write-tree(1)
 =================
-v0.1, May 2005
 
 NAME
 ----
diff --git a/Documentation/git.txt b/Documentation/git.txt
--- a/Documentation/git.txt
+++ b/Documentation/git.txt
@@ -1,6 +1,5 @@
 git(7)
 ======
-v0.99.6, Sep 2005
 
 NAME
 ----
diff --git a/Documentation/hooks.txt b/Documentation/hooks.txt
--- a/Documentation/hooks.txt
+++ b/Documentation/hooks.txt
@@ -1,6 +1,5 @@
 Hooks used by GIT
 =================
-v0.99.6, Sep 2005
 
 Hooks are little scripts you can place in `$GIT_DIR/hooks`
 directory to trigger action at certain points.  When
diff --git a/Documentation/repository-layout.txt b/Documentation/repository-layout.txt
--- a/Documentation/repository-layout.txt
+++ b/Documentation/repository-layout.txt
@@ -1,6 +1,5 @@
 GIT repository layout
 =====================
-v0.99.5, Sep 2005
 
 You may find these things in your git repository (`.git`
 directory for a repository associated with your working tree, or
diff --git a/Documentation/tutorial.txt b/Documentation/tutorial.txt
--- a/Documentation/tutorial.txt
+++ b/Documentation/tutorial.txt
@@ -1,6 +1,5 @@
 A short git tutorial
 ====================
-v0.99.5, Aug 2005
 
 Introduction
 ------------
