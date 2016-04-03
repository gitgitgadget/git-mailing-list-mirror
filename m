From: Eric Engestrom <eric@engestrom.ch>
Subject: [PATCH] Fix spelling mistakes
Date: Sun,  3 Apr 2016 13:56:05 +0100
Message-ID: <1459688165-8720-1-git-send-email-eric@engestrom.ch>
Cc: git@vger.kernel.org, Eric Engestrom <eric@engestrom.ch>
To: gitster@pobox.com
X-From: git-owner@vger.kernel.org Sun Apr 03 14:57:12 2016
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1amhaa-00004s-78
	for gcvg-git-2@plane.gmane.org; Sun, 03 Apr 2016 14:57:12 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1753534AbcDCM5D (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Sun, 3 Apr 2016 08:57:03 -0400
Received: from mail-lb0-f193.google.com ([209.85.217.193]:34017 "EHLO
	mail-lb0-f193.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1752989AbcDCM5B (ORCPT <rfc822;git@vger.kernel.org>);
	Sun, 3 Apr 2016 08:57:01 -0400
Received: by mail-lb0-f193.google.com with SMTP id vk4so16920588lbb.1
        for <git@vger.kernel.org>; Sun, 03 Apr 2016 05:57:00 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20130820;
        h=x-gm-message-state:from:to:cc:subject:date:message-id;
        bh=swnDg+Yxx+dGNG0XmHKplebW84SYbBl5cK9sHx8pYdY=;
        b=e5SVlSml+tzzks3wKYuOM5bAi87HwC+o37l1giATrRQv8x7WOElh4T6rQ+jXCSPUrY
         tBum/G4ikcYyud/KS6W1WevA1NTS1SPEqV4uPV4eXZQRBD9nzu1TYwP0uVlgXyXKPHPu
         yDdrrcwvh5s/N/W4z7Hf3Y8fM3MQx3inSAubri/h0jrrU39qVFt4qNx2qA9JpZmxaiZG
         ZcF8o33iJoqsVyYdNunPt92Pgl5aWjetI5r/ep/24ii2AzUHVsH/URNKW2nEGBrTR/Pm
         /yuhK4+Ce1h62nw/Pa9rkVyIfpm/glNDkVI9g91jWB7FxTHUZSMIJVcAXeIAAXljJT99
         HQJg==
X-Gm-Message-State: AD7BkJKQZr8snhy6lEJsxKc2f8pQHF3hvHTEmbVoxsxTGQXR48j9jY6ucgG8XDCZVuuQVg==
X-Received: by 10.28.224.212 with SMTP id x203mr7241382wmg.75.1459688219617;
        Sun, 03 Apr 2016 05:56:59 -0700 (PDT)
Received: from Eric-XPS.localdomain (0545748a.skybroadband.com. [5.69.116.138])
        by smtp.gmail.com with ESMTPSA id 198sm8596454wml.22.2016.04.03.05.56.58
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-SHA bits=128/128);
        Sun, 03 Apr 2016 05:56:58 -0700 (PDT)
X-Mailer: git-send-email 2.8.0
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/290638>

Signed-off-by: Eric Engestrom <eric@engestrom.ch>
---
 builtin/apply.c                    | 2 +-
 builtin/clean.c                    | 2 +-
 config.c                           | 2 +-
 contrib/examples/git-am.sh         | 2 +-
 contrib/hooks/multimail/README     | 2 +-
 contrib/subtree/t/t7900-subtree.sh | 2 +-
 diff.c                             | 2 +-
 dir.c                              | 2 +-
 git-p4.py                          | 2 +-
 refs.h                             | 2 +-
 sha1-lookup.c                      | 2 +-
 t/t5535-fetch-push-symref.sh       | 2 +-
 t/t6030-bisect-porcelain.sh        | 2 +-
 worktree.c                         | 2 +-
 14 files changed, 14 insertions(+), 14 deletions(-)

diff --git a/builtin/apply.c b/builtin/apply.c
index deb05d0..02a0259 100644
--- a/builtin/apply.c
+++ b/builtin/apply.c
@@ -3980,7 +3980,7 @@ static void show_rename_copy(struct patch *p)
 		old = slash_old + 1;
 		new = slash_new + 1;
 	}
-	/* p->old_name thru old is the common prefix, and old and new
+	/* p->old_name through old is the common prefix, and old and new
 	 * through the end of names are renames
 	 */
 	if (old != p->old_name)
diff --git a/builtin/clean.c b/builtin/clean.c
index 0371010..5426f9f 100644
--- a/builtin/clean.c
+++ b/builtin/clean.c
@@ -192,7 +192,7 @@ static int remove_dirs(struct strbuf *path, const char *prefix, int force_flag,
 		strbuf_setlen(path, len);
 		strbuf_addstr(path, e->d_name);
 		if (lstat(path->buf, &st))
-			; /* fall thru */
+			; /* fall through */
 		else if (S_ISDIR(st.st_mode)) {
 			if (remove_dirs(path, prefix, force_flag, dry_run, quiet, &gone))
 				ret = 1;
diff --git a/config.c b/config.c
index 9ba40bc..482ef2e 100644
--- a/config.c
+++ b/config.c
@@ -1278,7 +1278,7 @@ static void git_config_raw(config_fn_t fn, void *data)
 		 * something went really wrong and we should stop
 		 * immediately.
 		 */
-		die(_("unknown error occured while reading the configuration files"));
+		die(_("unknown error occurred while reading the configuration files"));
 }
 
 static void configset_iter(struct config_set *cs, config_fn_t fn, void *data)
diff --git a/contrib/examples/git-am.sh b/contrib/examples/git-am.sh
index dd539f1..b3d30b7 100755
--- a/contrib/examples/git-am.sh
+++ b/contrib/examples/git-am.sh
@@ -542,7 +542,7 @@ then
 	rm -f "$dotest/dirtyindex"
 else
 	# Possible stray $dotest directory in the independent-run
-	# case; in the --rebasing case, it is upto the caller
+	# case; in the --rebasing case, it is up to the caller
 	# (git-rebase--am) to take care of stray directories.
 	if test -d "$dotest" && test -z "$rebasing"
 	then
diff --git a/contrib/hooks/multimail/README b/contrib/hooks/multimail/README
index 5512068..80df811 100644
--- a/contrib/hooks/multimail/README
+++ b/contrib/hooks/multimail/README
@@ -489,7 +489,7 @@ multimailhook.commitLogOpts
 multimailhook.dateSubstitute
 
     String to use as a substitute for ``Date:`` in the output of ``git
-    log`` while formatting commit messages. This is usefull to avoid
+    log`` while formatting commit messages. This is useful to avoid
     emitting a line that can be interpreted by mailers as the start of
     a cited message (Zimbra webmail in particular). Defaults to
     ``CommitDate: ``. Set to an empty string or ``none`` to deactivate
diff --git a/contrib/subtree/t/t7900-subtree.sh b/contrib/subtree/t/t7900-subtree.sh
index 3bf96a9..0cf044c 100755
--- a/contrib/subtree/t/t7900-subtree.sh
+++ b/contrib/subtree/t/t7900-subtree.sh
@@ -932,7 +932,7 @@ test_expect_success 'split a new subtree without --onto option' '
 
 		# also test that we still can split out an entirely new subtree
 		# if the parent of the first commit in the tree is not empty,
-		# then the new subtree has accidently been attached to something
+		# then the new subtree has accidentally been attached to something
 		git subtree split --prefix="sub dir2" --branch subproj2-br &&
 		check_equal "$(git log --pretty=format:%P -1 subproj2-br)" ""
 	)
diff --git a/diff.c b/diff.c
index 059123c..3d8b3e5 100644
--- a/diff.c
+++ b/diff.c
@@ -2084,7 +2084,7 @@ static int is_conflict_marker(const char *line, int marker_size, unsigned long l
 	for (cnt = 1; cnt < marker_size; cnt++)
 		if (line[cnt] != firstchar)
 			return 0;
-	/* line[1] thru line[marker_size-1] are same as firstchar */
+	/* line[1] through line[marker_size-1] are same as firstchar */
 	if (len < marker_size + 1 || !isspace(line[marker_size]))
 		return 0;
 	return 1;
diff --git a/dir.c b/dir.c
index a4a9d9f..57892a5 100644
--- a/dir.c
+++ b/dir.c
@@ -2166,7 +2166,7 @@ static int remove_dir_recurse(struct strbuf *path, int flag, int *kept_up)
 				 * wanted anyway
 				 */
 				continue;
-			/* fall thru */
+			/* fall through */
 		} else if (S_ISDIR(st.st_mode)) {
 			if (!remove_dir_recurse(path, flag, &kept_down))
 				continue; /* happy */
diff --git a/git-p4.py b/git-p4.py
index 825b9f3..4f577e2 100755
--- a/git-p4.py
+++ b/git-p4.py
@@ -1918,7 +1918,7 @@ def run(self, args):
         if self.useClientSpec:
             self.clientSpecDirs = getClientSpec()
 
-        # Check for the existance of P4 branches
+        # Check for the existence of P4 branches
         branchesDetected = (len(p4BranchesInGit().keys()) > 1)
 
         if self.useClientSpec and not branchesDetected:
diff --git a/refs.h b/refs.h
index 2f3decb..fad6281 100644
--- a/refs.h
+++ b/refs.h
@@ -336,7 +336,7 @@ struct ref_transaction *ref_transaction_begin(struct strbuf *err);
  *     msg -- a message describing the change (for the reflog).
  *
  *     err -- a strbuf for receiving a description of any error that
- *         might have occured.
+ *         might have occurred.
  *
  * The functions make internal copies of refname and msg, so the
  * caller retains ownership of these parameters.
diff --git a/sha1-lookup.c b/sha1-lookup.c
index 5f06921..552582f 100644
--- a/sha1-lookup.c
+++ b/sha1-lookup.c
@@ -199,7 +199,7 @@ int sha1_entry_pos(const void *table,
 					break;
 			ofs_0 = ofs;
 			/*
-			 * byte 0 thru (ofs-1) are the same between
+			 * byte 0 through (ofs-1) are the same between
 			 * lo and hi; ofs is the first byte that is
 			 * different.
 			 *
diff --git a/t/t5535-fetch-push-symref.sh b/t/t5535-fetch-push-symref.sh
index 8ed58d2..e8f6d23 100755
--- a/t/t5535-fetch-push-symref.sh
+++ b/t/t5535-fetch-push-symref.sh
@@ -1,6 +1,6 @@
 #!/bin/sh
 
-test_description='avoiding conflicting update thru symref aliasing'
+test_description='avoiding conflicting update through symref aliasing'
 
 . ./test-lib.sh
 
diff --git a/t/t6030-bisect-porcelain.sh b/t/t6030-bisect-porcelain.sh
index e74662b..a1b02b3 100755
--- a/t/t6030-bisect-porcelain.sh
+++ b/t/t6030-bisect-porcelain.sh
@@ -721,7 +721,7 @@ git bisect good 3de952f2416b6084f557ec417709eac740c6818c
 # first bad commit: [32a594a3fdac2d57cf6d02987e30eec68511498c] Add <4: Ciao for now> into <hello>.
 EOF
 
-test_expect_success 'bisect log: successfull result' '
+test_expect_success 'bisect log: successful result' '
 	git bisect reset &&
 	git bisect start $HASH4 $HASH2 &&
 	git bisect good &&
diff --git a/worktree.c b/worktree.c
index 6181a66..89ebe67 100644
--- a/worktree.c
+++ b/worktree.c
@@ -18,7 +18,7 @@ void free_worktrees(struct worktree **worktrees)
 
 /*
  * read 'path_to_ref' into 'ref'.  Also if is_detached is not NULL,
- * set is_detached to 1 (0) if the ref is detatched (is not detached).
+ * set is_detached to 1 (0) if the ref is detached (is not detached).
  *
  * $GIT_COMMON_DIR/$symref (e.g. HEAD) is practically outside $GIT_DIR so
  * for linked worktrees, `resolve_ref_unsafe()` won't work (it uses
-- 
2.8.0
