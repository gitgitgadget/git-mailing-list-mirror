From: Christian Couder <chriscool@tuxfamily.org>
Subject: [PATCH 2/2] documentation: move git(7) to git(1)
Date: Fri, 6 Jun 2008 09:07:32 +0200
Message-ID: <20080606090732.5f76db86.chriscool@tuxfamily.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Cc: git@vger.kernel.org
To: Junio Hamano <junkio@cox.net>, Pieter de Bie <pdebie@ai.rug.nl>,
	Jakub Narebski <jnareb@gmail.com>
X-From: git-owner@vger.kernel.org Fri Jun 06 09:04:21 2008
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1K4Vzg-0006kZ-R9
	for gcvg-git-2@gmane.org; Fri, 06 Jun 2008 09:04:14 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1754747AbYFFHDR (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Fri, 6 Jun 2008 03:03:17 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1753977AbYFFHDR
	(ORCPT <rfc822;git-outgoing>); Fri, 6 Jun 2008 03:03:17 -0400
Received: from smtp1-g19.free.fr ([212.27.42.27]:37194 "EHLO smtp1-g19.free.fr"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1754747AbYFFHDM (ORCPT <rfc822;git@vger.kernel.org>);
	Fri, 6 Jun 2008 03:03:12 -0400
Received: from smtp1-g19.free.fr (localhost.localdomain [127.0.0.1])
	by smtp1-g19.free.fr (Postfix) with ESMTP id B07B21AB2EF;
	Fri,  6 Jun 2008 09:03:10 +0200 (CEST)
Received: from localhost.boubyland (gre92-7-82-243-130-161.fbx.proxad.net [82.243.130.161])
	by smtp1-g19.free.fr (Postfix) with SMTP id A61541AB2C4;
	Fri,  6 Jun 2008 09:03:09 +0200 (CEST)
X-Mailer: Sylpheed 2.5.0beta3 (GTK+ 2.12.9; i486-pc-linux-gnu)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/84035>

As the "git" man page describes the "git" command at the end-user
level, it seems better to move it to man section 1.

Signed-off-by: Christian Couder <chriscool@tuxfamily.org>
---
 Documentation/Makefile                   |    4 ++--
 Documentation/git-add.txt                |    2 +-
 Documentation/git-am.txt                 |    2 +-
 Documentation/git-annotate.txt           |    2 +-
 Documentation/git-apply.txt              |    2 +-
 Documentation/git-archimport.txt         |    2 +-
 Documentation/git-archive.txt            |    2 +-
 Documentation/git-bisect.txt             |    2 +-
 Documentation/git-blame.txt              |    2 +-
 Documentation/git-branch.txt             |    2 +-
 Documentation/git-bundle.txt             |    2 +-
 Documentation/git-cat-file.txt           |    2 +-
 Documentation/git-check-attr.txt         |    2 +-
 Documentation/git-check-ref-format.txt   |    2 +-
 Documentation/git-checkout-index.txt     |    2 +-
 Documentation/git-checkout.txt           |    2 +-
 Documentation/git-cherry-pick.txt        |    2 +-
 Documentation/git-cherry.txt             |    2 +-
 Documentation/git-citool.txt             |    2 +-
 Documentation/git-clean.txt              |    2 +-
 Documentation/git-clone.txt              |    2 +-
 Documentation/git-commit-tree.txt        |    2 +-
 Documentation/git-commit.txt             |    2 +-
 Documentation/git-config.txt             |    2 +-
 Documentation/git-count-objects.txt      |    2 +-
 Documentation/git-cvsexportcommit.txt    |    2 +-
 Documentation/git-cvsimport.txt          |    2 +-
 Documentation/git-cvsserver.txt          |    2 +-
 Documentation/git-daemon.txt             |    2 +-
 Documentation/git-describe.txt           |    2 +-
 Documentation/git-diff-files.txt         |    2 +-
 Documentation/git-diff-index.txt         |    2 +-
 Documentation/git-diff-tree.txt          |    2 +-
 Documentation/git-diff.txt               |    2 +-
 Documentation/git-fast-export.txt        |    2 +-
 Documentation/git-fast-import.txt        |    2 +-
 Documentation/git-fetch-pack.txt         |    2 +-
 Documentation/git-fetch.txt              |    2 +-
 Documentation/git-filter-branch.txt      |    2 +-
 Documentation/git-fmt-merge-msg.txt      |    2 +-
 Documentation/git-format-patch.txt       |    2 +-
 Documentation/git-fsck.txt               |    2 +-
 Documentation/git-gc.txt                 |    2 +-
 Documentation/git-get-tar-commit-id.txt  |    2 +-
 Documentation/git-grep.txt               |    2 +-
 Documentation/git-gui.txt                |    2 +-
 Documentation/git-hash-object.txt        |    2 +-
 Documentation/git-help.txt               |    4 ++--
 Documentation/git-http-fetch.txt         |    2 +-
 Documentation/git-http-push.txt          |    2 +-
 Documentation/git-imap-send.txt          |    2 +-
 Documentation/git-index-pack.txt         |    2 +-
 Documentation/git-init.txt               |    2 +-
 Documentation/git-instaweb.txt           |    2 +-
 Documentation/git-log.txt                |    2 +-
 Documentation/git-lost-found.txt         |    2 +-
 Documentation/git-ls-files.txt           |    2 +-
 Documentation/git-ls-remote.txt          |    2 +-
 Documentation/git-ls-tree.txt            |    2 +-
 Documentation/git-mailinfo.txt           |    2 +-
 Documentation/git-mailsplit.txt          |    2 +-
 Documentation/git-merge-base.txt         |    2 +-
 Documentation/git-merge-file.txt         |    2 +-
 Documentation/git-merge-index.txt        |    2 +-
 Documentation/git-merge-one-file.txt     |    2 +-
 Documentation/git-merge-tree.txt         |    2 +-
 Documentation/git-merge.txt              |    2 +-
 Documentation/git-mergetool.txt          |    2 +-
 Documentation/git-mktag.txt              |    2 +-
 Documentation/git-mktree.txt             |    2 +-
 Documentation/git-mv.txt                 |    2 +-
 Documentation/git-name-rev.txt           |    2 +-
 Documentation/git-pack-objects.txt       |    2 +-
 Documentation/git-pack-redundant.txt     |    2 +-
 Documentation/git-pack-refs.txt          |    2 +-
 Documentation/git-parse-remote.txt       |    2 +-
 Documentation/git-patch-id.txt           |    2 +-
 Documentation/git-peek-remote.txt        |    2 +-
 Documentation/git-prune-packed.txt       |    2 +-
 Documentation/git-prune.txt              |    2 +-
 Documentation/git-pull.txt               |    2 +-
 Documentation/git-push.txt               |    2 +-
 Documentation/git-quiltimport.txt        |    2 +-
 Documentation/git-read-tree.txt          |    2 +-
 Documentation/git-rebase.txt             |    2 +-
 Documentation/git-receive-pack.txt       |    2 +-
 Documentation/git-reflog.txt             |    2 +-
 Documentation/git-relink.txt             |    2 +-
 Documentation/git-remote.txt             |    2 +-
 Documentation/git-repack.txt             |    2 +-
 Documentation/git-request-pull.txt       |    2 +-
 Documentation/git-rerere.txt             |    2 +-
 Documentation/git-reset.txt              |    2 +-
 Documentation/git-rev-list.txt           |    2 +-
 Documentation/git-rev-parse.txt          |    2 +-
 Documentation/git-revert.txt             |    2 +-
 Documentation/git-rm.txt                 |    2 +-
 Documentation/git-send-email.txt         |    2 +-
 Documentation/git-send-pack.txt          |    2 +-
 Documentation/git-sh-setup.txt           |    2 +-
 Documentation/git-shell.txt              |    2 +-
 Documentation/git-shortlog.txt           |    2 +-
 Documentation/git-show-branch.txt        |    2 +-
 Documentation/git-show-index.txt         |    2 +-
 Documentation/git-show-ref.txt           |    2 +-
 Documentation/git-show.txt               |    2 +-
 Documentation/git-stash.txt              |    2 +-
 Documentation/git-status.txt             |    2 +-
 Documentation/git-stripspace.txt         |    2 +-
 Documentation/git-submodule.txt          |    2 +-
 Documentation/git-symbolic-ref.txt       |    2 +-
 Documentation/git-tag.txt                |    2 +-
 Documentation/git-tar-tree.txt           |    2 +-
 Documentation/git-unpack-file.txt        |    2 +-
 Documentation/git-unpack-objects.txt     |    2 +-
 Documentation/git-update-index.txt       |    2 +-
 Documentation/git-update-ref.txt         |    2 +-
 Documentation/git-update-server-info.txt |    2 +-
 Documentation/git-upload-archive.txt     |    2 +-
 Documentation/git-upload-pack.txt        |    2 +-
 Documentation/git-var.txt                |    2 +-
 Documentation/git-verify-pack.txt        |    2 +-
 Documentation/git-verify-tag.txt         |    2 +-
 Documentation/git-web--browse.txt        |    2 +-
 Documentation/git-whatchanged.txt        |    2 +-
 Documentation/git-write-tree.txt         |    2 +-
 Documentation/git.txt                    |    4 ++--
 Documentation/gitattributes.txt          |    4 ++--
 Documentation/gitcli.txt                 |    2 +-
 Documentation/gitcore-tutorial.txt       |    2 +-
 Documentation/gitcvs-migration.txt       |    2 +-
 Documentation/gitdiffcore.txt            |    2 +-
 Documentation/gitglossary.txt            |    2 +-
 Documentation/githooks.txt               |    2 +-
 Documentation/gitignore.txt              |    2 +-
 Documentation/gitk.txt                   |    2 +-
 Documentation/gitmodules.txt             |    2 +-
 Documentation/gitrepository-layout.txt   |    2 +-
 Documentation/gittutorial-2.txt          |    2 +-
 Documentation/gittutorial.txt            |    2 +-
 140 files changed, 144 insertions(+), 144 deletions(-)

diff --git a/Documentation/Makefile b/Documentation/Makefile
index 5bd0e7c..25e6488 100644
--- a/Documentation/Makefile
+++ b/Documentation/Makefile
@@ -1,10 +1,10 @@
 MAN1_TXT= \
 	$(filter-out $(addsuffix .txt, $(ARTICLES) $(SP_ARTICLES)), \
 		$(wildcard git-*.txt)) \
-	gitk.txt
+	gitk.txt git.txt
 MAN5_TXT=gitattributes.txt gitignore.txt gitmodules.txt githooks.txt \
 	gitrepository-layout.txt
-MAN7_TXT=git.txt gitcli.txt gittutorial.txt gittutorial-2.txt \
+MAN7_TXT=gitcli.txt gittutorial.txt gittutorial-2.txt \
 	gitcvs-migration.txt gitcore-tutorial.txt gitglossary.txt \
 	gitdiffcore.txt
 
diff --git a/Documentation/git-add.txt b/Documentation/git-add.txt
index 8eb9de1..88165da 100644
--- a/Documentation/git-add.txt
+++ b/Documentation/git-add.txt
@@ -265,4 +265,4 @@ Documentation by Junio C Hamano and the git-list <git@vger.kernel.org>.
 
 GIT
 ---
-Part of the linkgit:git[7] suite
+Part of the linkgit:git[1] suite
diff --git a/Documentation/git-am.txt b/Documentation/git-am.txt
index 2387a8d..7f6f5b4 100644
--- a/Documentation/git-am.txt
+++ b/Documentation/git-am.txt
@@ -153,4 +153,4 @@ Documentation by Petr Baudis, Junio C Hamano and the git-list <git@vger.kernel.o
 
 GIT
 ---
-Part of the linkgit:git[7] suite
+Part of the linkgit:git[1] suite
diff --git a/Documentation/git-annotate.txt b/Documentation/git-annotate.txt
index 45a6a72..da15379 100644
--- a/Documentation/git-annotate.txt
+++ b/Documentation/git-annotate.txt
@@ -28,4 +28,4 @@ Written by Ryan Anderson <ryan@michonline.com>.
 
 GIT
 ---
-Part of the linkgit:git[7] suite
+Part of the linkgit:git[1] suite
diff --git a/Documentation/git-apply.txt b/Documentation/git-apply.txt
index 2dec2ec..76277bd 100644
--- a/Documentation/git-apply.txt
+++ b/Documentation/git-apply.txt
@@ -206,4 +206,4 @@ Documentation by Junio C Hamano
 
 GIT
 ---
-Part of the linkgit:git[7] suite
+Part of the linkgit:git[1] suite
diff --git a/Documentation/git-archimport.txt b/Documentation/git-archimport.txt
index bd20fd8..603117c 100644
--- a/Documentation/git-archimport.txt
+++ b/Documentation/git-archimport.txt
@@ -117,4 +117,4 @@ Documentation by Junio C Hamano, Martin Langhoff and the git-list <git@vger.kern
 
 GIT
 ---
-Part of the linkgit:git[7] suite
+Part of the linkgit:git[1] suite
diff --git a/Documentation/git-archive.txt b/Documentation/git-archive.txt
index d3eaa16..a3e36db 100644
--- a/Documentation/git-archive.txt
+++ b/Documentation/git-archive.txt
@@ -118,4 +118,4 @@ Documentation by David Greaves, Junio C Hamano and the git-list <git@vger.kernel
 
 GIT
 ---
-Part of the linkgit:git[7] suite
+Part of the linkgit:git[1] suite
diff --git a/Documentation/git-bisect.txt b/Documentation/git-bisect.txt
index 0b8b0eb..37c7acb 100644
--- a/Documentation/git-bisect.txt
+++ b/Documentation/git-bisect.txt
@@ -283,4 +283,4 @@ Documentation by Junio C Hamano and the git-list <git@vger.kernel.org>.
 
 GIT
 ---
-Part of the linkgit:git[7] suite
+Part of the linkgit:git[1] suite
diff --git a/Documentation/git-blame.txt b/Documentation/git-blame.txt
index 14163b6..7900f33 100644
--- a/Documentation/git-blame.txt
+++ b/Documentation/git-blame.txt
@@ -192,4 +192,4 @@ Written by Junio C Hamano <junkio@cox.net>
 
 GIT
 ---
-Part of the linkgit:git[7] suite
+Part of the linkgit:git[1] suite
diff --git a/Documentation/git-branch.txt b/Documentation/git-branch.txt
index c824d88..a70fa76 100644
--- a/Documentation/git-branch.txt
+++ b/Documentation/git-branch.txt
@@ -209,4 +209,4 @@ Documentation by Junio C Hamano and the git-list <git@vger.kernel.org>.
 
 GIT
 ---
-Part of the linkgit:git[7] suite
+Part of the linkgit:git[1] suite
diff --git a/Documentation/git-bundle.txt b/Documentation/git-bundle.txt
index 18330cd..f6a0612 100644
--- a/Documentation/git-bundle.txt
+++ b/Documentation/git-bundle.txt
@@ -171,4 +171,4 @@ Written by Mark Levedahl <mdl123@verizon.net>
 
 GIT
 ---
-Part of the linkgit:git[7] suite
+Part of the linkgit:git[1] suite
diff --git a/Documentation/git-cat-file.txt b/Documentation/git-cat-file.txt
index f6c394c..3f77dbd 100644
--- a/Documentation/git-cat-file.txt
+++ b/Documentation/git-cat-file.txt
@@ -103,4 +103,4 @@ Documentation by David Greaves, Junio C Hamano and the git-list <git@vger.kernel
 
 GIT
 ---
-Part of the linkgit:git[7] suite
+Part of the linkgit:git[1] suite
diff --git a/Documentation/git-check-attr.txt b/Documentation/git-check-attr.txt
index 290f10f..ef16b93 100644
--- a/Documentation/git-check-attr.txt
+++ b/Documentation/git-check-attr.txt
@@ -38,4 +38,4 @@ Documentation by James Bowes.
 
 GIT
 ---
-Part of the linkgit:git[7] suite
+Part of the linkgit:git[1] suite
diff --git a/Documentation/git-check-ref-format.txt b/Documentation/git-check-ref-format.txt
index a676880..c560c0a 100644
--- a/Documentation/git-check-ref-format.txt
+++ b/Documentation/git-check-ref-format.txt
@@ -52,4 +52,4 @@ refname expressions (see linkgit:git-rev-parse[1]).  Namely:
 
 GIT
 ---
-Part of the linkgit:git[7] suite
+Part of the linkgit:git[1] suite
diff --git a/Documentation/git-checkout-index.txt b/Documentation/git-checkout-index.txt
index cbbb0b5..a8cad9c 100644
--- a/Documentation/git-checkout-index.txt
+++ b/Documentation/git-checkout-index.txt
@@ -181,4 +181,4 @@ Junio C Hamano and the git-list <git@vger.kernel.org>.
 
 GIT
 ---
-Part of the linkgit:git[7] suite
+Part of the linkgit:git[1] suite
diff --git a/Documentation/git-checkout.txt b/Documentation/git-checkout.txt
index a644173..a5bf9d6 100644
--- a/Documentation/git-checkout.txt
+++ b/Documentation/git-checkout.txt
@@ -215,4 +215,4 @@ Documentation by Junio C Hamano and the git-list <git@vger.kernel.org>.
 
 GIT
 ---
-Part of the linkgit:git[7] suite
+Part of the linkgit:git[1] suite
diff --git a/Documentation/git-cherry-pick.txt b/Documentation/git-cherry-pick.txt
index ca048f4..3762272 100644
--- a/Documentation/git-cherry-pick.txt
+++ b/Documentation/git-cherry-pick.txt
@@ -78,4 +78,4 @@ Documentation by Junio C Hamano and the git-list <git@vger.kernel.org>.
 
 GIT
 ---
-Part of the linkgit:git[7] suite
+Part of the linkgit:git[1] suite
diff --git a/Documentation/git-cherry.txt b/Documentation/git-cherry.txt
index d8e0a5b..ef7caf6 100644
--- a/Documentation/git-cherry.txt
+++ b/Documentation/git-cherry.txt
@@ -72,4 +72,4 @@ Documentation by Junio C Hamano and the git-list <git@vger.kernel.org>.
 
 GIT
 ---
-Part of the linkgit:git[7] suite
+Part of the linkgit:git[1] suite
diff --git a/Documentation/git-citool.txt b/Documentation/git-citool.txt
index aca1d75..09108d0 100644
--- a/Documentation/git-citool.txt
+++ b/Documentation/git-citool.txt
@@ -29,4 +29,4 @@ Documentation by Shawn O. Pearce <spearce@spearce.org>.
 
 GIT
 ---
-Part of the linkgit:git[7] suite
+Part of the linkgit:git[1] suite
diff --git a/Documentation/git-clean.txt b/Documentation/git-clean.txt
index 5e9da03..deebf3b 100644
--- a/Documentation/git-clean.txt
+++ b/Documentation/git-clean.txt
@@ -54,4 +54,4 @@ Written by Pavel Roskin <proski@gnu.org>
 
 GIT
 ---
-Part of the linkgit:git[7] suite
+Part of the linkgit:git[1] suite
diff --git a/Documentation/git-clone.txt b/Documentation/git-clone.txt
index 9b56442..7973e6a 100644
--- a/Documentation/git-clone.txt
+++ b/Documentation/git-clone.txt
@@ -205,4 +205,4 @@ Documentation by Junio C Hamano and the git-list <git@vger.kernel.org>.
 
 GIT
 ---
-Part of the linkgit:git[7] suite
+Part of the linkgit:git[1] suite
diff --git a/Documentation/git-commit-tree.txt b/Documentation/git-commit-tree.txt
index 700840d..728c2fa 100644
--- a/Documentation/git-commit-tree.txt
+++ b/Documentation/git-commit-tree.txt
@@ -103,4 +103,4 @@ Documentation by David Greaves, Junio C Hamano and the git-list <git@vger.kernel
 
 GIT
 ---
-Part of the linkgit:git[7] suite
+Part of the linkgit:git[1] suite
diff --git a/Documentation/git-commit.txt b/Documentation/git-commit.txt
index c3c9f5b..02d4baa 100644
--- a/Documentation/git-commit.txt
+++ b/Documentation/git-commit.txt
@@ -312,4 +312,4 @@ Junio C Hamano <junkio@cox.net>
 
 GIT
 ---
-Part of the linkgit:git[7] suite
+Part of the linkgit:git[1] suite
diff --git a/Documentation/git-config.txt b/Documentation/git-config.txt
index 5de5d05..84b754f 100644
--- a/Documentation/git-config.txt
+++ b/Documentation/git-config.txt
@@ -334,4 +334,4 @@ Documentation by Johannes Schindelin, Petr Baudis and the git-list <git@vger.ker
 
 GIT
 ---
-Part of the linkgit:git[7] suite
+Part of the linkgit:git[1] suite
diff --git a/Documentation/git-count-objects.txt b/Documentation/git-count-objects.txt
index 7fb08e9..e1219b3 100644
--- a/Documentation/git-count-objects.txt
+++ b/Documentation/git-count-objects.txt
@@ -34,4 +34,4 @@ Documentation by Junio C Hamano and the git-list <git@vger.kernel.org>.
 
 GIT
 ---
-Part of the linkgit:git[7] suite
+Part of the linkgit:git[1] suite
diff --git a/Documentation/git-cvsexportcommit.txt b/Documentation/git-cvsexportcommit.txt
index f75afaa..5fa91e5 100644
--- a/Documentation/git-cvsexportcommit.txt
+++ b/Documentation/git-cvsexportcommit.txt
@@ -117,4 +117,4 @@ Documentation by Martin Langhoff <martin@catalyst.net.nz> and others.
 
 GIT
 ---
-Part of the linkgit:git[7] suite
+Part of the linkgit:git[1] suite
diff --git a/Documentation/git-cvsimport.txt b/Documentation/git-cvsimport.txt
index 58eefd4..2f9b35f 100644
--- a/Documentation/git-cvsimport.txt
+++ b/Documentation/git-cvsimport.txt
@@ -170,4 +170,4 @@ Documentation by Matthias Urlichs <smurf@smurf.noris.de>.
 
 GIT
 ---
-Part of the linkgit:git[7] suite
+Part of the linkgit:git[1] suite
diff --git a/Documentation/git-cvsserver.txt b/Documentation/git-cvsserver.txt
index a33382e..b772113 100644
--- a/Documentation/git-cvsserver.txt
+++ b/Documentation/git-cvsserver.txt
@@ -352,4 +352,4 @@ Documentation by Martyn Smith <martyn@catalyst.net.nz>, Martin Langhoff <martin@
 
 GIT
 ---
-Part of the linkgit:git[7] suite
+Part of the linkgit:git[1] suite
diff --git a/Documentation/git-daemon.txt b/Documentation/git-daemon.txt
index cf261dd..3fb71d6 100644
--- a/Documentation/git-daemon.txt
+++ b/Documentation/git-daemon.txt
@@ -272,4 +272,4 @@ Documentation by Junio C Hamano and the git-list <git@vger.kernel.org>.
 
 GIT
 ---
-Part of the linkgit:git[7] suite
+Part of the linkgit:git[1] suite
diff --git a/Documentation/git-describe.txt b/Documentation/git-describe.txt
index 69e1ab7..3f0b7b2 100644
--- a/Documentation/git-describe.txt
+++ b/Documentation/git-describe.txt
@@ -142,4 +142,4 @@ Documentation by David Greaves, Junio C Hamano and the git-list <git@vger.kernel
 
 GIT
 ---
-Part of the linkgit:git[7] suite
+Part of the linkgit:git[1] suite
diff --git a/Documentation/git-diff-files.txt b/Documentation/git-diff-files.txt
index ca1bb6a..ed9bd75 100644
--- a/Documentation/git-diff-files.txt
+++ b/Documentation/git-diff-files.txt
@@ -54,4 +54,4 @@ Documentation by David Greaves, Junio C Hamano and the git-list <git@vger.kernel
 
 GIT
 ---
-Part of the linkgit:git[7] suite
+Part of the linkgit:git[1] suite
diff --git a/Documentation/git-diff-index.txt b/Documentation/git-diff-index.txt
index e867778..f6e844f 100644
--- a/Documentation/git-diff-index.txt
+++ b/Documentation/git-diff-index.txt
@@ -129,4 +129,4 @@ Documentation by David Greaves, Junio C Hamano and the git-list <git@vger.kernel
 
 GIT
 ---
-Part of the linkgit:git[7] suite
+Part of the linkgit:git[1] suite
diff --git a/Documentation/git-diff-tree.txt b/Documentation/git-diff-tree.txt
index 58d02c6..56caeb2 100644
--- a/Documentation/git-diff-tree.txt
+++ b/Documentation/git-diff-tree.txt
@@ -165,4 +165,4 @@ Documentation by David Greaves, Junio C Hamano and the git-list <git@vger.kernel
 
 GIT
 ---
-Part of the linkgit:git[7] suite
+Part of the linkgit:git[1] suite
diff --git a/Documentation/git-diff.txt b/Documentation/git-diff.txt
index 57c2862..7acd428 100644
--- a/Documentation/git-diff.txt
+++ b/Documentation/git-diff.txt
@@ -168,4 +168,4 @@ Documentation by Junio C Hamano and the git-list <git@vger.kernel.org>.
 
 GIT
 ---
-Part of the linkgit:git[7] suite
+Part of the linkgit:git[1] suite
diff --git a/Documentation/git-fast-export.txt b/Documentation/git-fast-export.txt
index 6dac475..332346c 100644
--- a/Documentation/git-fast-export.txt
+++ b/Documentation/git-fast-export.txt
@@ -80,4 +80,4 @@ Documentation by Johannes E. Schindelin <johannes.schindelin@gmx.de>.
 
 GIT
 ---
-Part of the linkgit:git[7] suite
+Part of the linkgit:git[1] suite
diff --git a/Documentation/git-fast-import.txt b/Documentation/git-fast-import.txt
index c29a4f8..395c055 100644
--- a/Documentation/git-fast-import.txt
+++ b/Documentation/git-fast-import.txt
@@ -1119,4 +1119,4 @@ Documentation by Shawn O. Pearce <spearce@spearce.org>.
 
 GIT
 ---
-Part of the linkgit:git[7] suite
+Part of the linkgit:git[1] suite
diff --git a/Documentation/git-fetch-pack.txt b/Documentation/git-fetch-pack.txt
index 57598eb..6ee3dcc 100644
--- a/Documentation/git-fetch-pack.txt
+++ b/Documentation/git-fetch-pack.txt
@@ -99,4 +99,4 @@ Documentation by Junio C Hamano.
 
 GIT
 ---
-Part of the linkgit:git[7] suite
+Part of the linkgit:git[1] suite
diff --git a/Documentation/git-fetch.txt b/Documentation/git-fetch.txt
index d982f96..489b2b1 100644
--- a/Documentation/git-fetch.txt
+++ b/Documentation/git-fetch.txt
@@ -53,4 +53,4 @@ Documentation by David Greaves, Junio C Hamano and the git-list <git@vger.kernel
 
 GIT
 ---
-Part of the linkgit:git[7] suite
+Part of the linkgit:git[1] suite
diff --git a/Documentation/git-filter-branch.txt b/Documentation/git-filter-branch.txt
index 35cb167..4406068 100644
--- a/Documentation/git-filter-branch.txt
+++ b/Documentation/git-filter-branch.txt
@@ -317,4 +317,4 @@ Documentation by Petr Baudis and the git list.
 
 GIT
 ---
-Part of the linkgit:git[7] suite
+Part of the linkgit:git[1] suite
diff --git a/Documentation/git-fmt-merge-msg.txt b/Documentation/git-fmt-merge-msg.txt
index bf9c26b..384c4fc 100644
--- a/Documentation/git-fmt-merge-msg.txt
+++ b/Documentation/git-fmt-merge-msg.txt
@@ -59,4 +59,4 @@ Documentation by Petr Baudis, Junio C Hamano and the git-list <git@vger.kernel.o
 
 GIT
 ---
-Part of the linkgit:git[7] suite
+Part of the linkgit:git[1] suite
diff --git a/Documentation/git-format-patch.txt b/Documentation/git-format-patch.txt
index fefcd26..cdee642 100644
--- a/Documentation/git-format-patch.txt
+++ b/Documentation/git-format-patch.txt
@@ -238,4 +238,4 @@ Documentation by Junio C Hamano and the git-list <git@vger.kernel.org>.
 
 GIT
 ---
-Part of the linkgit:git[7] suite
+Part of the linkgit:git[1] suite
diff --git a/Documentation/git-fsck.txt b/Documentation/git-fsck.txt
index 4cc26fb..9846c85 100644
--- a/Documentation/git-fsck.txt
+++ b/Documentation/git-fsck.txt
@@ -151,4 +151,4 @@ Documentation by David Greaves, Junio C Hamano and the git-list <git@vger.kernel
 
 GIT
 ---
-Part of the linkgit:git[7] suite
+Part of the linkgit:git[1] suite
diff --git a/Documentation/git-gc.txt b/Documentation/git-gc.txt
index f409700..6ace615 100644
--- a/Documentation/git-gc.txt
+++ b/Documentation/git-gc.txt
@@ -132,4 +132,4 @@ Written by Shawn O. Pearce <spearce@spearce.org>
 
 GIT
 ---
-Part of the linkgit:git[7] suite
+Part of the linkgit:git[1] suite
diff --git a/Documentation/git-get-tar-commit-id.txt b/Documentation/git-get-tar-commit-id.txt
index dea4149..c13bf98 100644
--- a/Documentation/git-get-tar-commit-id.txt
+++ b/Documentation/git-get-tar-commit-id.txt
@@ -33,4 +33,4 @@ Documentation by Junio C Hamano and the git-list <git@vger.kernel.org>.
 
 GIT
 ---
-Part of the linkgit:git[7] suite
+Part of the linkgit:git[1] suite
diff --git a/Documentation/git-grep.txt b/Documentation/git-grep.txt
index a97f055..13b9cf7 100644
--- a/Documentation/git-grep.txt
+++ b/Documentation/git-grep.txt
@@ -145,4 +145,4 @@ Documentation by Junio C Hamano and the git-list <git@vger.kernel.org>.
 
 GIT
 ---
-Part of the linkgit:git[7] suite
+Part of the linkgit:git[1] suite
diff --git a/Documentation/git-gui.txt b/Documentation/git-gui.txt
index bd5fe67..105397f 100644
--- a/Documentation/git-gui.txt
+++ b/Documentation/git-gui.txt
@@ -112,4 +112,4 @@ Documentation by Shawn O. Pearce <spearce@spearce.org>.
 
 GIT
 ---
-Part of the linkgit:git[7] suite
+Part of the linkgit:git[1] suite
diff --git a/Documentation/git-hash-object.txt b/Documentation/git-hash-object.txt
index 99a2143..cf3dce8 100644
--- a/Documentation/git-hash-object.txt
+++ b/Documentation/git-hash-object.txt
@@ -45,4 +45,4 @@ Documentation by David Greaves, Junio C Hamano and the git-list <git@vger.kernel
 
 GIT
 ---
-Part of the linkgit:git[7] suite
+Part of the linkgit:git[1] suite
diff --git a/Documentation/git-help.txt b/Documentation/git-help.txt
index bfbba9e..8994c6d 100644
--- a/Documentation/git-help.txt
+++ b/Documentation/git-help.txt
@@ -172,10 +172,10 @@ Written by Junio C Hamano <gitster@pobox.com> and the git-list
 
 Documentation
 -------------
-Initial documentation was part of the linkgit:git[7] man page.
+Initial documentation was part of the linkgit:git[1] man page.
 Christian Couder <chriscool@tuxfamily.org> extracted and rewrote it a
 little. Maintenance is done by the git-list <git@vger.kernel.org>.
 
 GIT
 ---
-Part of the linkgit:git[7] suite
+Part of the linkgit:git[1] suite
diff --git a/Documentation/git-http-fetch.txt b/Documentation/git-http-fetch.txt
index b784a9d..70fb635 100644
--- a/Documentation/git-http-fetch.txt
+++ b/Documentation/git-http-fetch.txt
@@ -53,4 +53,4 @@ Documentation by David Greaves, Junio C Hamano and the git-list <git@vger.kernel
 
 GIT
 ---
-Part of the linkgit:git[7] suite
+Part of the linkgit:git[1] suite
diff --git a/Documentation/git-http-push.txt b/Documentation/git-http-push.txt
index 0b82722..143291d 100644
--- a/Documentation/git-http-push.txt
+++ b/Documentation/git-http-push.txt
@@ -101,4 +101,4 @@ Documentation by Nick Hengeveld
 
 GIT
 ---
-Part of the linkgit:git[7] suite
+Part of the linkgit:git[1] suite
diff --git a/Documentation/git-imap-send.txt b/Documentation/git-imap-send.txt
index 522b73c..f4fdc24 100644
--- a/Documentation/git-imap-send.txt
+++ b/Documentation/git-imap-send.txt
@@ -59,4 +59,4 @@ Documentation by Mike McCormack
 
 GIT
 ---
-Part of the linkgit:git[7] suite
+Part of the linkgit:git[1] suite
diff --git a/Documentation/git-index-pack.txt b/Documentation/git-index-pack.txt
index a7825b6..6409363 100644
--- a/Documentation/git-index-pack.txt
+++ b/Documentation/git-index-pack.txt
@@ -100,4 +100,4 @@ Documentation by Sergey Vlasov
 
 GIT
 ---
-Part of the linkgit:git[7] suite
+Part of the linkgit:git[1] suite
diff --git a/Documentation/git-init.txt b/Documentation/git-init.txt
index b48c312..c48b615 100644
--- a/Documentation/git-init.txt
+++ b/Documentation/git-init.txt
@@ -122,4 +122,4 @@ Documentation by David Greaves, Junio C Hamano and the git-list <git@vger.kernel
 
 GIT
 ---
-Part of the linkgit:git[7] suite
+Part of the linkgit:git[1] suite
diff --git a/Documentation/git-instaweb.txt b/Documentation/git-instaweb.txt
index 51f1532..11e6a81 100644
--- a/Documentation/git-instaweb.txt
+++ b/Documentation/git-instaweb.txt
@@ -86,4 +86,4 @@ Documentation by Eric Wong <normalperson@yhbt.net>.
 
 GIT
 ---
-Part of the linkgit:git[7] suite
+Part of the linkgit:git[1] suite
diff --git a/Documentation/git-log.txt b/Documentation/git-log.txt
index ebaee4b..db61bc9 100644
--- a/Documentation/git-log.txt
+++ b/Documentation/git-log.txt
@@ -112,4 +112,4 @@ Documentation by David Greaves, Junio C Hamano and the git-list <git@vger.kernel
 
 GIT
 ---
-Part of the linkgit:git[7] suite
+Part of the linkgit:git[1] suite
diff --git a/Documentation/git-lost-found.txt b/Documentation/git-lost-found.txt
index b1c797f..4dc475e 100644
--- a/Documentation/git-lost-found.txt
+++ b/Documentation/git-lost-found.txt
@@ -78,4 +78,4 @@ Documentation by Junio C Hamano and the git-list <git@vger.kernel.org>.
 
 GIT
 ---
-Part of the linkgit:git[7] suite
+Part of the linkgit:git[1] suite
diff --git a/Documentation/git-ls-files.txt b/Documentation/git-ls-files.txt
index 4be45b0..1b0b212 100644
--- a/Documentation/git-ls-files.txt
+++ b/Documentation/git-ls-files.txt
@@ -192,4 +192,4 @@ Documentation by David Greaves, Junio C Hamano, Josh Triplett, and the git-list
 
 GIT
 ---
-Part of the linkgit:git[7] suite
+Part of the linkgit:git[1] suite
diff --git a/Documentation/git-ls-remote.txt b/Documentation/git-ls-remote.txt
index c5ba0aa..8ad7a94 100644
--- a/Documentation/git-ls-remote.txt
+++ b/Documentation/git-ls-remote.txt
@@ -69,4 +69,4 @@ Written by Junio C Hamano <junkio@cox.net>
 
 GIT
 ---
-Part of the linkgit:git[7] suite
+Part of the linkgit:git[1] suite
diff --git a/Documentation/git-ls-tree.txt b/Documentation/git-ls-tree.txt
index 360c0a1..d9881fb 100644
--- a/Documentation/git-ls-tree.txt
+++ b/Documentation/git-ls-tree.txt
@@ -91,4 +91,4 @@ Documentation by David Greaves, Junio C Hamano and the git-list
 
 GIT
 ---
-Part of the linkgit:git[7] suite
+Part of the linkgit:git[1] suite
diff --git a/Documentation/git-mailinfo.txt b/Documentation/git-mailinfo.txt
index 3846f0e..183dc1d 100644
--- a/Documentation/git-mailinfo.txt
+++ b/Documentation/git-mailinfo.txt
@@ -66,4 +66,4 @@ Documentation by Junio C Hamano and the git-list <git@vger.kernel.org>.
 
 GIT
 ---
-Part of the linkgit:git[7] suite
+Part of the linkgit:git[1] suite
diff --git a/Documentation/git-mailsplit.txt b/Documentation/git-mailsplit.txt
index 421e778..9a2aedd 100644
--- a/Documentation/git-mailsplit.txt
+++ b/Documentation/git-mailsplit.txt
@@ -55,4 +55,4 @@ Documentation by Junio C Hamano and the git-list <git@vger.kernel.org>.
 
 GIT
 ---
-Part of the linkgit:git[7] suite
+Part of the linkgit:git[1] suite
diff --git a/Documentation/git-merge-base.txt b/Documentation/git-merge-base.txt
index 07f78b4..bbe8512 100644
--- a/Documentation/git-merge-base.txt
+++ b/Documentation/git-merge-base.txt
@@ -39,4 +39,4 @@ Documentation by David Greaves, Junio C Hamano and the git-list <git@vger.kernel
 
 GIT
 ---
-Part of the linkgit:git[7] suite
+Part of the linkgit:git[1] suite
diff --git a/Documentation/git-merge-file.txt b/Documentation/git-merge-file.txt
index c513184..149f131 100644
--- a/Documentation/git-merge-file.txt
+++ b/Documentation/git-merge-file.txt
@@ -89,4 +89,4 @@ with parts copied from the original documentation of RCS merge.
 
 GIT
 ---
-Part of the linkgit:git[7] suite
+Part of the linkgit:git[1] suite
diff --git a/Documentation/git-merge-index.txt b/Documentation/git-merge-index.txt
index 19ee017..a0ead2b 100644
--- a/Documentation/git-merge-index.txt
+++ b/Documentation/git-merge-index.txt
@@ -84,4 +84,4 @@ Documentation by David Greaves, Junio C Hamano and the git-list <git@vger.kernel
 
 GIT
 ---
-Part of the linkgit:git[7] suite
+Part of the linkgit:git[1] suite
diff --git a/Documentation/git-merge-one-file.txt b/Documentation/git-merge-one-file.txt
index ee95df3..5c9ce64 100644
--- a/Documentation/git-merge-one-file.txt
+++ b/Documentation/git-merge-one-file.txt
@@ -26,4 +26,4 @@ Documentation by David Greaves, Junio C Hamano and the git-list <git@vger.kernel
 
 GIT
 ---
-Part of the linkgit:git[7] suite
+Part of the linkgit:git[1] suite
diff --git a/Documentation/git-merge-tree.txt b/Documentation/git-merge-tree.txt
index 4cc0964..b785e0f 100644
--- a/Documentation/git-merge-tree.txt
+++ b/Documentation/git-merge-tree.txt
@@ -33,4 +33,4 @@ Documentation by Junio C Hamano and the git-list <git@vger.kernel.org>.
 
 GIT
 ---
-Part of the linkgit:git[7] suite
+Part of the linkgit:git[1] suite
diff --git a/Documentation/git-merge.txt b/Documentation/git-merge.txt
index 845d0ed..6ce37e1 100644
--- a/Documentation/git-merge.txt
+++ b/Documentation/git-merge.txt
@@ -210,4 +210,4 @@ Documentation by Junio C Hamano and the git-list <git@vger.kernel.org>.
 
 GIT
 ---
-Part of the linkgit:git[7] suite
+Part of the linkgit:git[1] suite
diff --git a/Documentation/git-mergetool.txt b/Documentation/git-mergetool.txt
index 8ed4494..8352560 100644
--- a/Documentation/git-mergetool.txt
+++ b/Documentation/git-mergetool.txt
@@ -70,4 +70,4 @@ Documentation by Theodore Y Ts'o.
 
 GIT
 ---
-Part of the linkgit:git[7] suite
+Part of the linkgit:git[1] suite
diff --git a/Documentation/git-mktag.txt b/Documentation/git-mktag.txt
index 82db9f5..232bc1a 100644
--- a/Documentation/git-mktag.txt
+++ b/Documentation/git-mktag.txt
@@ -43,4 +43,4 @@ Documentation by David Greaves, Junio C Hamano and the git-list <git@vger.kernel
 
 GIT
 ---
-Part of the linkgit:git[7] suite
+Part of the linkgit:git[1] suite
diff --git a/Documentation/git-mktree.txt b/Documentation/git-mktree.txt
index f312036..1ddbf00 100644
--- a/Documentation/git-mktree.txt
+++ b/Documentation/git-mktree.txt
@@ -31,4 +31,4 @@ Documentation by Junio C Hamano and the git-list <git@vger.kernel.org>.
 
 GIT
 ---
-Part of the linkgit:git[7] suite
+Part of the linkgit:git[1] suite
diff --git a/Documentation/git-mv.txt b/Documentation/git-mv.txt
index bff3fbe..fb485de 100644
--- a/Documentation/git-mv.txt
+++ b/Documentation/git-mv.txt
@@ -50,4 +50,4 @@ Documentation by David Greaves, Junio C Hamano and the git-list <git@vger.kernel
 
 GIT
 ---
-Part of the linkgit:git[7] suite
+Part of the linkgit:git[1] suite
diff --git a/Documentation/git-name-rev.txt b/Documentation/git-name-rev.txt
index efcabdc..12784d7 100644
--- a/Documentation/git-name-rev.txt
+++ b/Documentation/git-name-rev.txt
@@ -75,4 +75,4 @@ Documentation by Johannes Schindelin.
 
 GIT
 ---
-Part of the linkgit:git[7] suite
+Part of the linkgit:git[1] suite
diff --git a/Documentation/git-pack-objects.txt b/Documentation/git-pack-objects.txt
index 35d1856..d5a87ef 100644
--- a/Documentation/git-pack-objects.txt
+++ b/Documentation/git-pack-objects.txt
@@ -208,4 +208,4 @@ linkgit:git-prune-packed[1]
 
 GIT
 ---
-Part of the linkgit:git[7] suite
+Part of the linkgit:git[1] suite
diff --git a/Documentation/git-pack-redundant.txt b/Documentation/git-pack-redundant.txt
index c7bc7b3..6737326 100644
--- a/Documentation/git-pack-redundant.txt
+++ b/Documentation/git-pack-redundant.txt
@@ -54,4 +54,4 @@ linkgit:git-prune-packed[1]
 
 GIT
 ---
-Part of the linkgit:git[7] suite
+Part of the linkgit:git[1] suite
diff --git a/Documentation/git-pack-refs.txt b/Documentation/git-pack-refs.txt
index e4ff934..fa48681 100644
--- a/Documentation/git-pack-refs.txt
+++ b/Documentation/git-pack-refs.txt
@@ -63,4 +63,4 @@ Written by Linus Torvalds <torvalds@osdl.org>
 
 GIT
 ---
-Part of the linkgit:git[7] suite
+Part of the linkgit:git[1] suite
diff --git a/Documentation/git-parse-remote.txt b/Documentation/git-parse-remote.txt
index deb8b2f..951dbd6 100644
--- a/Documentation/git-parse-remote.txt
+++ b/Documentation/git-parse-remote.txt
@@ -47,4 +47,4 @@ Documentation by Junio C Hamano and the git-list <git@vger.kernel.org>.
 
 GIT
 ---
-Part of the linkgit:git[7] suite
+Part of the linkgit:git[1] suite
diff --git a/Documentation/git-patch-id.txt b/Documentation/git-patch-id.txt
index 894852a..bb8a079 100644
--- a/Documentation/git-patch-id.txt
+++ b/Documentation/git-patch-id.txt
@@ -39,4 +39,4 @@ Documentation by Junio C Hamano and the git-list <git@vger.kernel.org>.
 
 GIT
 ---
-Part of the linkgit:git[7] suite
+Part of the linkgit:git[1] suite
diff --git a/Documentation/git-peek-remote.txt b/Documentation/git-peek-remote.txt
index 0001710..56be1b6 100644
--- a/Documentation/git-peek-remote.txt
+++ b/Documentation/git-peek-remote.txt
@@ -47,4 +47,4 @@ Documentation by Junio C Hamano.
 
 GIT
 ---
-Part of the linkgit:git[7] suite
+Part of the linkgit:git[1] suite
diff --git a/Documentation/git-prune-packed.txt b/Documentation/git-prune-packed.txt
index 3219eb3..f330b8a 100644
--- a/Documentation/git-prune-packed.txt
+++ b/Documentation/git-prune-packed.txt
@@ -49,4 +49,4 @@ linkgit:git-repack[1]
 
 GIT
 ---
-Part of the linkgit:git[7] suite
+Part of the linkgit:git[1] suite
diff --git a/Documentation/git-prune.txt b/Documentation/git-prune.txt
index 82a03e3..7283d07 100644
--- a/Documentation/git-prune.txt
+++ b/Documentation/git-prune.txt
@@ -83,4 +83,4 @@ Documentation by David Greaves, Junio C Hamano and the git-list <git@vger.kernel
 
 GIT
 ---
-Part of the linkgit:git[7] suite
+Part of the linkgit:git[1] suite
diff --git a/Documentation/git-pull.txt b/Documentation/git-pull.txt
index eb816bc..f909353 100644
--- a/Documentation/git-pull.txt
+++ b/Documentation/git-pull.txt
@@ -205,4 +205,4 @@ Junio C Hamano and the git-list <git@vger.kernel.org>.
 
 GIT
 ---
-Part of the linkgit:git[7] suite
+Part of the linkgit:git[1] suite
diff --git a/Documentation/git-push.txt b/Documentation/git-push.txt
index 0cc44d7..9d8c379 100644
--- a/Documentation/git-push.txt
+++ b/Documentation/git-push.txt
@@ -200,4 +200,4 @@ Documentation by Junio C Hamano and the git-list <git@vger.kernel.org>.
 
 GIT
 ---
-Part of the linkgit:git[7] suite
+Part of the linkgit:git[1] suite
diff --git a/Documentation/git-quiltimport.txt b/Documentation/git-quiltimport.txt
index 0fc2b56..d0bc182 100644
--- a/Documentation/git-quiltimport.txt
+++ b/Documentation/git-quiltimport.txt
@@ -57,4 +57,4 @@ Documentation by Eric Biederman <ebiederm@lnxi.com>
 
 GIT
 ---
-Part of the linkgit:git[7] suite
+Part of the linkgit:git[1] suite
diff --git a/Documentation/git-read-tree.txt b/Documentation/git-read-tree.txt
index 2e097a1..cbe6835 100644
--- a/Documentation/git-read-tree.txt
+++ b/Documentation/git-read-tree.txt
@@ -361,4 +361,4 @@ Documentation by David Greaves, Junio C Hamano and the git-list <git@vger.kernel
 
 GIT
 ---
-Part of the linkgit:git[7] suite
+Part of the linkgit:git[1] suite
diff --git a/Documentation/git-rebase.txt b/Documentation/git-rebase.txt
index cc4e94f..c150fb4 100644
--- a/Documentation/git-rebase.txt
+++ b/Documentation/git-rebase.txt
@@ -410,4 +410,4 @@ Documentation by Junio C Hamano and the git-list <git@vger.kernel.org>.
 
 GIT
 ---
-Part of the linkgit:git[7] suite
+Part of the linkgit:git[1] suite
diff --git a/Documentation/git-receive-pack.txt b/Documentation/git-receive-pack.txt
index 4111434..a70c716 100644
--- a/Documentation/git-receive-pack.txt
+++ b/Documentation/git-receive-pack.txt
@@ -162,4 +162,4 @@ Documentation by Junio C Hamano.
 
 GIT
 ---
-Part of the linkgit:git[7] suite
+Part of the linkgit:git[1] suite
diff --git a/Documentation/git-reflog.txt b/Documentation/git-reflog.txt
index 047e3ce..8492aea 100644
--- a/Documentation/git-reflog.txt
+++ b/Documentation/git-reflog.txt
@@ -102,4 +102,4 @@ Documentation by Junio C Hamano and the git-list <git@vger.kernel.org>.
 
 GIT
 ---
-Part of the linkgit:git[7] suite
+Part of the linkgit:git[1] suite
diff --git a/Documentation/git-relink.txt b/Documentation/git-relink.txt
index 1b024de..f6dafd4 100644
--- a/Documentation/git-relink.txt
+++ b/Documentation/git-relink.txt
@@ -34,4 +34,4 @@ Documentation by Junio C Hamano and the git-list <git@vger.kernel.org>.
 
 GIT
 ---
-Part of the linkgit:git[7] suite
+Part of the linkgit:git[1] suite
diff --git a/Documentation/git-remote.txt b/Documentation/git-remote.txt
index 5c55290..e97dc09 100644
--- a/Documentation/git-remote.txt
+++ b/Documentation/git-remote.txt
@@ -146,4 +146,4 @@ Documentation by J. Bruce Fields and the git-list <git@vger.kernel.org>.
 
 GIT
 ---
-Part of the linkgit:git[7] suite
+Part of the linkgit:git[1] suite
diff --git a/Documentation/git-repack.txt b/Documentation/git-repack.txt
index ef578f0..793dcca 100644
--- a/Documentation/git-repack.txt
+++ b/Documentation/git-repack.txt
@@ -129,4 +129,4 @@ linkgit:git-prune-packed[1]
 
 GIT
 ---
-Part of the linkgit:git[7] suite
+Part of the linkgit:git[1] suite
diff --git a/Documentation/git-request-pull.txt b/Documentation/git-request-pull.txt
index 9a14c04..c71d869 100644
--- a/Documentation/git-request-pull.txt
+++ b/Documentation/git-request-pull.txt
@@ -36,4 +36,4 @@ Documentation by Junio C Hamano and the git-list <git@vger.kernel.org>.
 
 GIT
 ---
-Part of the linkgit:git[7] suite
+Part of the linkgit:git[1] suite
diff --git a/Documentation/git-rerere.txt b/Documentation/git-rerere.txt
index a53858e..8030ec4 100644
--- a/Documentation/git-rerere.txt
+++ b/Documentation/git-rerere.txt
@@ -208,4 +208,4 @@ Written by Junio C Hamano <junkio@cox.net>
 
 GIT
 ---
-Part of the linkgit:git[7] suite
+Part of the linkgit:git[1] suite
diff --git a/Documentation/git-reset.txt b/Documentation/git-reset.txt
index fac59c9..12ea9b2 100644
--- a/Documentation/git-reset.txt
+++ b/Documentation/git-reset.txt
@@ -203,4 +203,4 @@ Documentation by Junio C Hamano and the git-list <git@vger.kernel.org>.
 
 GIT
 ---
-Part of the linkgit:git[7] suite
+Part of the linkgit:git[1] suite
diff --git a/Documentation/git-rev-list.txt b/Documentation/git-rev-list.txt
index d80cdf5..c9b0950 100644
--- a/Documentation/git-rev-list.txt
+++ b/Documentation/git-rev-list.txt
@@ -109,4 +109,4 @@ and the git-list <git@vger.kernel.org>.
 
 GIT
 ---
-Part of the linkgit:git[7] suite
+Part of the linkgit:git[1] suite
diff --git a/Documentation/git-rev-parse.txt b/Documentation/git-rev-parse.txt
index 5641d99..a0ef1fd 100644
--- a/Documentation/git-rev-parse.txt
+++ b/Documentation/git-rev-parse.txt
@@ -417,4 +417,4 @@ Documentation by Junio C Hamano and the git-list <git@vger.kernel.org>.
 
 GIT
 ---
-Part of the linkgit:git[7] suite
+Part of the linkgit:git[1] suite
diff --git a/Documentation/git-revert.txt b/Documentation/git-revert.txt
index 13ceabb..5e6adfc 100644
--- a/Documentation/git-revert.txt
+++ b/Documentation/git-revert.txt
@@ -65,4 +65,4 @@ Documentation by Junio C Hamano and the git-list <git@vger.kernel.org>.
 
 GIT
 ---
-Part of the linkgit:git[7] suite
+Part of the linkgit:git[1] suite
diff --git a/Documentation/git-rm.txt b/Documentation/git-rm.txt
index 6481f4a..da3fe59 100644
--- a/Documentation/git-rm.txt
+++ b/Documentation/git-rm.txt
@@ -107,4 +107,4 @@ Documentation by Junio C Hamano and the git-list <git@vger.kernel.org>.
 
 GIT
 ---
-Part of the linkgit:git[7] suite
+Part of the linkgit:git[1] suite
diff --git a/Documentation/git-send-email.txt b/Documentation/git-send-email.txt
index 9d0a10c..a295837 100644
--- a/Documentation/git-send-email.txt
+++ b/Documentation/git-send-email.txt
@@ -241,4 +241,4 @@ Documentation by Ryan Anderson
 
 GIT
 ---
-Part of the linkgit:git[7] suite
+Part of the linkgit:git[1] suite
diff --git a/Documentation/git-send-pack.txt b/Documentation/git-send-pack.txt
index 777515b..850c351 100644
--- a/Documentation/git-send-pack.txt
+++ b/Documentation/git-send-pack.txt
@@ -125,4 +125,4 @@ Documentation by Junio C Hamano.
 
 GIT
 ---
-Part of the linkgit:git[7] suite
+Part of the linkgit:git[1] suite
diff --git a/Documentation/git-sh-setup.txt b/Documentation/git-sh-setup.txt
index 16b8b75..c543170 100644
--- a/Documentation/git-sh-setup.txt
+++ b/Documentation/git-sh-setup.txt
@@ -77,4 +77,4 @@ Documentation by Junio C Hamano and the git-list <git@vger.kernel.org>.
 
 GIT
 ---
-Part of the linkgit:git[7] suite
+Part of the linkgit:git[1] suite
diff --git a/Documentation/git-shell.txt b/Documentation/git-shell.txt
index bc031e0..bd09196 100644
--- a/Documentation/git-shell.txt
+++ b/Documentation/git-shell.txt
@@ -31,4 +31,4 @@ Documentation by Petr Baudis and the git-list <git@vger.kernel.org>.
 
 GIT
 ---
-Part of the linkgit:git[7] suite
+Part of the linkgit:git[1] suite
diff --git a/Documentation/git-shortlog.txt b/Documentation/git-shortlog.txt
index d7cb4c0..5079b56 100644
--- a/Documentation/git-shortlog.txt
+++ b/Documentation/git-shortlog.txt
@@ -65,4 +65,4 @@ Documentation by Junio C Hamano.
 
 GIT
 ---
-Part of the linkgit:git[7] suite
+Part of the linkgit:git[1] suite
diff --git a/Documentation/git-show-branch.txt b/Documentation/git-show-branch.txt
index 0bb8250..32595ad 100644
--- a/Documentation/git-show-branch.txt
+++ b/Documentation/git-show-branch.txt
@@ -190,4 +190,4 @@ Documentation by Junio C Hamano.
 
 GIT
 ---
-Part of the linkgit:git[7] suite
+Part of the linkgit:git[1] suite
diff --git a/Documentation/git-show-index.txt b/Documentation/git-show-index.txt
index 535a884..891f0ef 100644
--- a/Documentation/git-show-index.txt
+++ b/Documentation/git-show-index.txt
@@ -31,4 +31,4 @@ Documentation by Junio C Hamano
 
 GIT
 ---
-Part of the linkgit:git[7] suite
+Part of the linkgit:git[1] suite
diff --git a/Documentation/git-show-ref.txt b/Documentation/git-show-ref.txt
index ce0e643..a85332c 100644
--- a/Documentation/git-show-ref.txt
+++ b/Documentation/git-show-ref.txt
@@ -169,4 +169,4 @@ Man page by Jonas Fonseca <fonseca@diku.dk>.
 
 GIT
 ---
-Part of the linkgit:git[7] suite
+Part of the linkgit:git[1] suite
diff --git a/Documentation/git-show.txt b/Documentation/git-show.txt
index 29ed0ac..baaf2bc 100644
--- a/Documentation/git-show.txt
+++ b/Documentation/git-show.txt
@@ -81,4 +81,4 @@ Documentation by David Greaves, Petr Baudis and the git-list <git@vger.kernel.or
 
 GIT
 ---
-Part of the linkgit:git[7] suite
+Part of the linkgit:git[1] suite
diff --git a/Documentation/git-stash.txt b/Documentation/git-stash.txt
index 8dc35d4..baa4f55 100644
--- a/Documentation/git-stash.txt
+++ b/Documentation/git-stash.txt
@@ -182,4 +182,4 @@ Written by Nanako Shiraishi <nanako3@bluebottle.com>
 
 GIT
 ---
-Part of the linkgit:git[7] suite
+Part of the linkgit:git[1] suite
diff --git a/Documentation/git-status.txt b/Documentation/git-status.txt
index 057e2a1..fef62b1 100644
--- a/Documentation/git-status.txt
+++ b/Documentation/git-status.txt
@@ -72,4 +72,4 @@ Documentation by David Greaves, Junio C Hamano and the git-list <git@vger.kernel
 
 GIT
 ---
-Part of the linkgit:git[7] suite
+Part of the linkgit:git[1] suite
diff --git a/Documentation/git-stripspace.txt b/Documentation/git-stripspace.txt
index fc56875..4883834 100644
--- a/Documentation/git-stripspace.txt
+++ b/Documentation/git-stripspace.txt
@@ -32,4 +32,4 @@ Documentation by Junio C Hamano and the git-list <git@vger.kernel.org>.
 
 GIT
 ---
-Part of the linkgit:git[7] suite
+Part of the linkgit:git[1] suite
diff --git a/Documentation/git-submodule.txt b/Documentation/git-submodule.txt
index 0668f29..139206f 100644
--- a/Documentation/git-submodule.txt
+++ b/Documentation/git-submodule.txt
@@ -98,4 +98,4 @@ Written by Lars Hjemli <hjemli@gmail.com>
 
 GIT
 ---
-Part of the linkgit:git[7] suite
+Part of the linkgit:git[1] suite
diff --git a/Documentation/git-symbolic-ref.txt b/Documentation/git-symbolic-ref.txt
index a5b40f3..e9b996b 100644
--- a/Documentation/git-symbolic-ref.txt
+++ b/Documentation/git-symbolic-ref.txt
@@ -58,4 +58,4 @@ Written by Junio C Hamano <junkio@cox.net>
 
 GIT
 ---
-Part of the linkgit:git[7] suite
+Part of the linkgit:git[1] suite
diff --git a/Documentation/git-tag.txt b/Documentation/git-tag.txt
index 9712392..8f40f4b 100644
--- a/Documentation/git-tag.txt
+++ b/Documentation/git-tag.txt
@@ -255,4 +255,4 @@ Documentation by David Greaves, Junio C Hamano and the git-list <git@vger.kernel
 
 GIT
 ---
-Part of the linkgit:git[7] suite
+Part of the linkgit:git[1] suite
diff --git a/Documentation/git-tar-tree.txt b/Documentation/git-tar-tree.txt
index 65c6817..74ed065 100644
--- a/Documentation/git-tar-tree.txt
+++ b/Documentation/git-tar-tree.txt
@@ -86,4 +86,4 @@ Documentation by David Greaves, Junio C Hamano and the git-list <git@vger.kernel
 
 GIT
 ---
-Part of the linkgit:git[7] suite
+Part of the linkgit:git[1] suite
diff --git a/Documentation/git-unpack-file.txt b/Documentation/git-unpack-file.txt
index 1864d13..d0552b2 100644
--- a/Documentation/git-unpack-file.txt
+++ b/Documentation/git-unpack-file.txt
@@ -32,4 +32,4 @@ Documentation by David Greaves, Junio C Hamano and the git-list <git@vger.kernel
 
 GIT
 ---
-Part of the linkgit:git[7] suite
+Part of the linkgit:git[1] suite
diff --git a/Documentation/git-unpack-objects.txt b/Documentation/git-unpack-objects.txt
index 50947c5..b9c4279 100644
--- a/Documentation/git-unpack-objects.txt
+++ b/Documentation/git-unpack-objects.txt
@@ -54,4 +54,4 @@ Documentation by Junio C Hamano
 
 GIT
 ---
-Part of the linkgit:git[7] suite
+Part of the linkgit:git[1] suite
diff --git a/Documentation/git-update-index.txt b/Documentation/git-update-index.txt
index 77d312a..c703365 100644
--- a/Documentation/git-update-index.txt
+++ b/Documentation/git-update-index.txt
@@ -328,4 +328,4 @@ Documentation by David Greaves, Junio C Hamano and the git-list <git@vger.kernel
 
 GIT
 ---
-Part of the linkgit:git[7] suite
+Part of the linkgit:git[1] suite
diff --git a/Documentation/git-update-ref.txt b/Documentation/git-update-ref.txt
index 80b94c3..bae2c8b 100644
--- a/Documentation/git-update-ref.txt
+++ b/Documentation/git-update-ref.txt
@@ -90,4 +90,4 @@ Written by Linus Torvalds <torvalds@osdl.org>.
 
 GIT
 ---
-Part of the linkgit:git[7] suite
+Part of the linkgit:git[1] suite
diff --git a/Documentation/git-update-server-info.txt b/Documentation/git-update-server-info.txt
index b49abbf..aa1ee67 100644
--- a/Documentation/git-update-server-info.txt
+++ b/Documentation/git-update-server-info.txt
@@ -54,4 +54,4 @@ Documentation by Junio C Hamano.
 
 GIT
 ---
-Part of the linkgit:git[7] suite
+Part of the linkgit:git[1] suite
diff --git a/Documentation/git-upload-archive.txt b/Documentation/git-upload-archive.txt
index c1ef144..e49f68f 100644
--- a/Documentation/git-upload-archive.txt
+++ b/Documentation/git-upload-archive.txt
@@ -34,4 +34,4 @@ Documentation by Junio C Hamano and the git-list <git@vger.kernel.org>.
 
 GIT
 ---
-Part of the linkgit:git[7] suite
+Part of the linkgit:git[1] suite
diff --git a/Documentation/git-upload-pack.txt b/Documentation/git-upload-pack.txt
index 2330d13..521da5b 100644
--- a/Documentation/git-upload-pack.txt
+++ b/Documentation/git-upload-pack.txt
@@ -43,4 +43,4 @@ Documentation by Junio C Hamano.
 
 GIT
 ---
-Part of the linkgit:git[7] suite
+Part of the linkgit:git[1] suite
diff --git a/Documentation/git-var.txt b/Documentation/git-var.txt
index 242a1d9..67e8e1f 100644
--- a/Documentation/git-var.txt
+++ b/Documentation/git-var.txt
@@ -61,4 +61,4 @@ Documentation by Eric Biederman and the git-list <git@vger.kernel.org>.
 
 GIT
 ---
-Part of the linkgit:git[7] suite
+Part of the linkgit:git[1] suite
diff --git a/Documentation/git-verify-pack.txt b/Documentation/git-verify-pack.txt
index ba2a157..478f236 100644
--- a/Documentation/git-verify-pack.txt
+++ b/Documentation/git-verify-pack.txt
@@ -50,4 +50,4 @@ Documentation by Junio C Hamano
 
 GIT
 ---
-Part of the linkgit:git[7] suite
+Part of the linkgit:git[1] suite
diff --git a/Documentation/git-verify-tag.txt b/Documentation/git-verify-tag.txt
index 7e9c1ed..dffba89 100644
--- a/Documentation/git-verify-tag.txt
+++ b/Documentation/git-verify-tag.txt
@@ -28,4 +28,4 @@ Documentation by Junio C Hamano and the git-list <git@vger.kernel.org>.
 
 GIT
 ---
-Part of the linkgit:git[7] suite
+Part of the linkgit:git[1] suite
diff --git a/Documentation/git-web--browse.txt b/Documentation/git-web--browse.txt
index 5ba0b9f..f8d5fb1 100644
--- a/Documentation/git-web--browse.txt
+++ b/Documentation/git-web--browse.txt
@@ -118,4 +118,4 @@ git-list <git@vger.kernel.org>.
 
 GIT
 ---
-Part of the linkgit:git[7] suite
+Part of the linkgit:git[1] suite
diff --git a/Documentation/git-whatchanged.txt b/Documentation/git-whatchanged.txt
index a6e7bd4..f5d39c7 100644
--- a/Documentation/git-whatchanged.txt
+++ b/Documentation/git-whatchanged.txt
@@ -76,4 +76,4 @@ Documentation by David Greaves, Junio C Hamano and the git-list <git@vger.kernel
 
 GIT
 ---
-Part of the linkgit:git[7] suite
+Part of the linkgit:git[1] suite
diff --git a/Documentation/git-write-tree.txt b/Documentation/git-write-tree.txt
index 461c813..8744f65 100644
--- a/Documentation/git-write-tree.txt
+++ b/Documentation/git-write-tree.txt
@@ -46,4 +46,4 @@ Documentation by David Greaves, Junio C Hamano and the git-list <git@vger.kernel
 
 GIT
 ---
-Part of the linkgit:git[7] suite
+Part of the linkgit:git[1] suite
diff --git a/Documentation/git.txt b/Documentation/git.txt
index a826bc2..8797352 100644
--- a/Documentation/git.txt
+++ b/Documentation/git.txt
@@ -1,4 +1,4 @@
-git(7)
+git(1)
 ======
 
 NAME
@@ -597,4 +597,4 @@ link:user-manual.html[The Git User's Manual]
 
 GIT
 ---
-Part of the linkgit:git[7] suite
+Part of the linkgit:git[1] suite
diff --git a/Documentation/gitattributes.txt b/Documentation/gitattributes.txt
index 04ca63c..471754e 100644
--- a/Documentation/gitattributes.txt
+++ b/Documentation/gitattributes.txt
@@ -265,7 +265,7 @@ When git needs to show you a diff for the path with `diff`
 attribute set to `jcdiff`, it calls the command you specified
 with the above configuration, i.e. `j-c-diff`, with 7
 parameters, just like `GIT_EXTERNAL_DIFF` program is called.
-See linkgit:git[7] for details.
+See linkgit:git[1] for details.
 
 
 Defining a custom hunk-header
@@ -518,4 +518,4 @@ commit hash.
 
 GIT
 ---
-Part of the linkgit:git[7] suite
+Part of the linkgit:git[1] suite
diff --git a/Documentation/gitcli.txt b/Documentation/gitcli.txt
index 835cb05..8fb5d88 100644
--- a/Documentation/gitcli.txt
+++ b/Documentation/gitcli.txt
@@ -110,4 +110,4 @@ Documentation by Pierre Habouzit.
 
 GIT
 ---
-Part of the linkgit:git[7] suite
+Part of the linkgit:git[1] suite
diff --git a/Documentation/gitcore-tutorial.txt b/Documentation/gitcore-tutorial.txt
index d61d5c9..cb4ec40 100644
--- a/Documentation/gitcore-tutorial.txt
+++ b/Documentation/gitcore-tutorial.txt
@@ -1696,4 +1696,4 @@ link:user-manual.html[The Git User's Manual]
 
 GIT
 ---
-Part of the linkgit:git[7] suite.
+Part of the linkgit:git[1] suite.
diff --git a/Documentation/gitcvs-migration.txt b/Documentation/gitcvs-migration.txt
index de02a42..1db3f52 100644
--- a/Documentation/gitcvs-migration.txt
+++ b/Documentation/gitcvs-migration.txt
@@ -193,4 +193,4 @@ link:user-manual.html[The Git User's Manual]
 
 GIT
 ---
-Part of the linkgit:git[7] suite.
+Part of the linkgit:git[1] suite.
diff --git a/Documentation/gitdiffcore.txt b/Documentation/gitdiffcore.txt
index f68efed..4d56c85 100644
--- a/Documentation/gitdiffcore.txt
+++ b/Documentation/gitdiffcore.txt
@@ -289,4 +289,4 @@ link:user-manual.html[The Git User's Manual]
 
 GIT
 ---
-Part of the linkgit:git[7] suite.
+Part of the linkgit:git[1] suite.
diff --git a/Documentation/gitglossary.txt b/Documentation/gitglossary.txt
index e8475a0..5c5c31d 100644
--- a/Documentation/gitglossary.txt
+++ b/Documentation/gitglossary.txt
@@ -22,4 +22,4 @@ link:user-manual.html[The Git User's Manual]
 
 GIT
 ---
-Part of the linkgit:git[7] suite.
+Part of the linkgit:git[1] suite.
diff --git a/Documentation/githooks.txt b/Documentation/githooks.txt
index 53747fe..4f06ae0 100644
--- a/Documentation/githooks.txt
+++ b/Documentation/githooks.txt
@@ -300,4 +300,4 @@ to abort.
 
 GIT
 ---
-Part of the linkgit:git[7] suite
+Part of the linkgit:git[1] suite
diff --git a/Documentation/gitignore.txt b/Documentation/gitignore.txt
index 613dca0..2881c9c 100644
--- a/Documentation/gitignore.txt
+++ b/Documentation/gitignore.txt
@@ -138,4 +138,4 @@ Frank Lichtenheld, and the git-list <git@vger.kernel.org>.
 
 GIT
 ---
-Part of the linkgit:git[7] suite
+Part of the linkgit:git[1] suite
diff --git a/Documentation/gitk.txt b/Documentation/gitk.txt
index b88fd95..14bcf91 100644
--- a/Documentation/gitk.txt
+++ b/Documentation/gitk.txt
@@ -109,4 +109,4 @@ Documentation by Junio C Hamano, Jonas Fonseca, and the git-list
 
 GIT
 ---
-Part of the linkgit:git[7] suite
+Part of the linkgit:git[1] suite
diff --git a/Documentation/gitmodules.txt b/Documentation/gitmodules.txt
index cc95b69..f8d122a 100644
--- a/Documentation/gitmodules.txt
+++ b/Documentation/gitmodules.txt
@@ -59,4 +59,4 @@ Documentation by Lars Hjemli <hjemli@gmail.com>
 
 GIT
 ---
-Part of the linkgit:git[7] suite
+Part of the linkgit:git[1] suite
diff --git a/Documentation/gitrepository-layout.txt b/Documentation/gitrepository-layout.txt
index 9949093..03c52ff 100644
--- a/Documentation/gitrepository-layout.txt
+++ b/Documentation/gitrepository-layout.txt
@@ -205,4 +205,4 @@ link:user-manual.html[The Git User's Manual]
 
 GIT
 ---
-Part of the linkgit:git[7] suite.
+Part of the linkgit:git[1] suite.
diff --git a/Documentation/gittutorial-2.txt b/Documentation/gittutorial-2.txt
index 4880ba9..e3d5c1f 100644
--- a/Documentation/gittutorial-2.txt
+++ b/Documentation/gittutorial-2.txt
@@ -427,4 +427,4 @@ link:user-manual.html[The Git User's Manual]
 
 GIT
 ---
-Part of the linkgit:git[7] suite.
+Part of the linkgit:git[1] suite.
diff --git a/Documentation/gittutorial.txt b/Documentation/gittutorial.txt
index 722b323..9563a63 100644
--- a/Documentation/gittutorial.txt
+++ b/Documentation/gittutorial.txt
@@ -605,4 +605,4 @@ link:user-manual.html[The Git User's Manual]
 
 GIT
 ---
-Part of the linkgit:git[7] suite.
+Part of the linkgit:git[1] suite.
-- 
1.5.6.rc0.202.g8f5a
