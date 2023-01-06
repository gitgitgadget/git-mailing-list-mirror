Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id E7BF8C3DA7A
	for <git@archiver.kernel.org>; Fri,  6 Jan 2023 13:13:12 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233148AbjAFNNM (ORCPT <rfc822;git@archiver.kernel.org>);
        Fri, 6 Jan 2023 08:13:12 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:54940 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229869AbjAFNNK (ORCPT <rfc822;git@vger.kernel.org>);
        Fri, 6 Jan 2023 08:13:10 -0500
Received: from mail-ej1-x632.google.com (mail-ej1-x632.google.com [IPv6:2a00:1450:4864:20::632])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 3A4EE45656
        for <git@vger.kernel.org>; Fri,  6 Jan 2023 05:13:09 -0800 (PST)
Received: by mail-ej1-x632.google.com with SMTP id tz12so3333519ejc.9
        for <git@vger.kernel.org>; Fri, 06 Jan 2023 05:13:09 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=content-transfer-encoding:mime-version:message-id:date:subject:to
         :from:from:to:cc:subject:date:message-id:reply-to;
        bh=4cVGZ/E5e3BOBhZq0zlKFihuRvoWLHZA5Xn0qCf4E9M=;
        b=aWaUuZyw8niQN77Wpt1/SkzdAJKDFe82mxWiD0aDPcrM75+Z/jh7vfRpo5CFLWeGQ/
         J+Du7p57zyl+/zRN9DD2GLegmZyvxAjHUvi6qpoLL+AnOH3T0KNbvvptNw/pp+gAJEN7
         xOkaiOBM8VMWciIXmu6FyiPa7YJdDK1Zd6EP03bMuLV0xnNYhvzYUUzgjN5ukzDlo0W8
         T9GoEbu1nnGjaRweN9PgZorV+1i+KNJieG5CV5Qi5N2l8OvyP2X36A/NndLkQp5UpFC7
         ez2o+8n8WUVdsxf85yVcZZViH0Hh41HKoMKURFz+ZcGAOdmNrNB6ynYn8GMa2xFXjFsw
         66iA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=content-transfer-encoding:mime-version:message-id:date:subject:to
         :from:x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=4cVGZ/E5e3BOBhZq0zlKFihuRvoWLHZA5Xn0qCf4E9M=;
        b=7FerRfTgYvJLmy4BoJm2lZxSC/H/DyT02IXnVqBfQQSLupE2BFWDrK3r+QISX5jHVC
         iHEN6bo+W9Imk6NsBtxTE4vQkKYPgWH7bfvIncl1FGKOb1Ab9ybw/DMkx+QnMbd+BrUT
         PJSrx2k322C1FR4kcPqnwTgDKGhX6tx+DX9SlKyCbnfW0Vrt96nqKscny+SV4/ux76kb
         MCxy5T7vqQlEmIZRO4o4DIw34VZTmAwN0Bjq/eNS2d4MjiVtmfssBB8F8MjKvsxu7YoP
         IA6dUG1uc76RTQPbR2tKKZEQQVVdEjx3IZ3RjWxXDOrHd4TGlmn52wJWFlcXCOuN6j+k
         tLPQ==
X-Gm-Message-State: AFqh2krd0BOJu87pUlEDmHlr0+2CSvPjqVwtgG41ya8M4kX8+fsCRvzM
        xBhXFqrTMcKxJDnwq33mkaUP6Wq1/x9UZA==
X-Google-Smtp-Source: AMrXdXtf6hKxRNJd/AdEGFLPy3Db8LjatIzt3Voqd6BiYFBa15TaNi6oPM16OhuB1WHmwZ2lllfYXQ==
X-Received: by 2002:a17:906:8e91:b0:7c1:5248:4f3a with SMTP id ru17-20020a1709068e9100b007c152484f3amr43641115ejc.56.1673010787382;
        Fri, 06 Jan 2023 05:13:07 -0800 (PST)
Received: from titov.fritz.box ([191.101.157.12])
        by smtp.gmail.com with ESMTPSA id o11-20020a170906768b00b0084d242d07ffsm172232ejm.8.2023.01.06.05.13.06
        for <git@vger.kernel.org>
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 06 Jan 2023 05:13:06 -0800 (PST)
From:   Andrei Rybak <rybak.a.v@gmail.com>
To:     git@vger.kernel.org
Subject: [PATCH] *: fix typos which duplicate a word
Date:   Fri,  6 Jan 2023 14:13:04 +0100
Message-Id: <20230106131304.20779-1-rybak.a.v@gmail.com>
X-Mailer: git-send-email 2.38.1
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Fix typos in code comments which repeat various words.  Most of the
cases are simple in that they repeat a word that usually cannot be
repeated in a grammatically correct sentence.  Just remove the
incorrectly duplicated word in these cases and rewrap text, if needed.

A tricky case is usage of "that that", which is sometimes grammatically
correct.  However, an instance of this in "t7527-builtin-fsmonitor.sh"
doesn't need two words "that", because there is only one daemon being
discussed, so the word "daemon" does not need a determiner.

Reword code comment "entries exist on on-disk index" in function
update_one in file cache-tree.c, by replacing incorrect preposition "on"
with "in".

Signed-off-by: Andrei Rybak <rybak.a.v@gmail.com>
---
 Documentation/gitprotocol-v2.txt | 2 +-
 builtin/checkout.c               | 2 +-
 builtin/submodule--helper.c      | 5 ++---
 cache-tree.c                     | 2 +-
 config.c                         | 2 +-
 run-command.c                    | 2 +-
 t/t4301-merge-tree-write-tree.sh | 4 ++--
 t/t6421-merge-partial-clone.sh   | 4 ++--
 t/t7527-builtin-fsmonitor.sh     | 4 ++--
 9 files changed, 13 insertions(+), 14 deletions(-)

diff --git a/Documentation/gitprotocol-v2.txt b/Documentation/gitprotocol-v2.txt
index 10bd2d40ce..acb97ad0c2 100644
--- a/Documentation/gitprotocol-v2.txt
+++ b/Documentation/gitprotocol-v2.txt
@@ -665,7 +665,7 @@ headers and their prerequisite relationships, or something else.
 +
 Server operators should feel confident in turning on "bundle-uri" and
 not worry if e.g. their CDN goes down that clones or fetches will run
-into hard failures. Even if the server bundle bundle(s) are
+into hard failures. Even if the server bundle(s) are
 incomplete, or bad in some way the client should still end up with a
 functioning repository, just as if it had chosen not to use this
 protocol extension.
diff --git a/builtin/checkout.c b/builtin/checkout.c
index cd04f0bf57..5963e1b74b 100644
--- a/builtin/checkout.c
+++ b/builtin/checkout.c
@@ -1270,7 +1270,7 @@ static int parse_branchname_arg(int argc, const char **argv,
 	 *       between A and B, A...B names that merge base.
 	 *
 	 *   (b) If <something> is _not_ a commit, either "--" is present
-	 *       or <something> is not a path, no -t or -b was given, and
+	 *       or <something> is not a path, no -t or -b was given,
 	 *       and there is a tracking branch whose name is <something>
 	 *       in one and only one remote (or if the branch exists on the
 	 *       remote named in checkout.defaultRemote), then this is a
diff --git a/builtin/submodule--helper.c b/builtin/submodule--helper.c
index 450680fc70..4c173d8b37 100644
--- a/builtin/submodule--helper.c
+++ b/builtin/submodule--helper.c
@@ -3219,9 +3219,8 @@ static void die_on_index_match(const char *path, int force)
 		ensure_full_index(&the_index);
 
 		/*
-		 * Since there is only one pathspec, we just need
-		 * need to check ps_matched[0] to know if a cache
-		 * entry matched.
+		 * Since there is only one pathspec, we just need to
+		 * check ps_matched[0] to know if a cache entry matched.
 		 */
 		for (i = 0; i < the_index.cache_nr; i++) {
 			ce_path_match(&the_index, the_index.cache[i], &ps,
diff --git a/cache-tree.c b/cache-tree.c
index c97111cccf..9af457f47c 100644
--- a/cache-tree.c
+++ b/cache-tree.c
@@ -405,7 +405,7 @@ static int update_one(struct cache_tree *it,
 		}
 
 		/*
-		 * CE_INTENT_TO_ADD entries exist on on-disk index but
+		 * CE_INTENT_TO_ADD entries exist in on-disk index but
 		 * they are not part of generated trees. Invalidate up
 		 * to root to force cache-tree users to read elsewhere.
 		 */
diff --git a/config.c b/config.c
index 27f38283ad..00090a32fc 100644
--- a/config.c
+++ b/config.c
@@ -3154,7 +3154,7 @@ int git_config_set_gently(const char *key, const char *value)
 int repo_config_set_worktree_gently(struct repository *r,
 				    const char *key, const char *value)
 {
-	/* Only use worktree-specific config if it is is already enabled. */
+	/* Only use worktree-specific config if it is already enabled. */
 	if (repository_format_worktree_config) {
 		char *file = repo_git_path(r, "config.worktree");
 		int ret = git_config_set_multivar_in_file_gently(
diff --git a/run-command.c b/run-command.c
index 756f1839aa..50cc011654 100644
--- a/run-command.c
+++ b/run-command.c
@@ -1853,7 +1853,7 @@ enum start_bg_result start_bg_command(struct child_process *cmd,
 		 *
 		 * We also assume that `start_command()` does not add
 		 * us to the cleanup list.  And that it calls
-		 * calls `child_process_clear()`.
+		 * `child_process_clear()`.
 		 */
 		sbgr = SBGR_ERROR;
 		goto done;
diff --git a/t/t4301-merge-tree-write-tree.sh b/t/t4301-merge-tree-write-tree.sh
index a8983a0edc..250f721795 100755
--- a/t/t4301-merge-tree-write-tree.sh
+++ b/t/t4301-merge-tree-write-tree.sh
@@ -141,7 +141,7 @@ test_expect_success 'test conflict notices and such' '
 #   Commit O: foo, olddir/{a,b,c}
 #   Commit A: modify foo, newdir/{a,b,c}
 #   Commit B: modify foo differently & rename foo -> olddir/bar
-#   Expected: CONFLICT(content) for for newdir/bar (not olddir/bar or foo)
+#   Expected: CONFLICT(content) for newdir/bar (not olddir/bar or foo)
 
 test_expect_success 'directory rename + content conflict' '
 	# Setup
@@ -653,7 +653,7 @@ test_expect_success 'mod6: chains of rename/rename(1to2) and add/add via collidi
 #   Commit O: foo, olddir/{a,b,c}
 #   Commit A: delete foo, rename olddir/ -> newdir/, add newdir/bar/file
 #   Commit B: modify foo & rename foo -> olddir/bar
-#   Expected: CONFLICT(content) for for newdir/bar (not olddir/bar or foo)
+#   Expected: CONFLICT(content) for newdir/bar (not olddir/bar or foo)
 
 test_expect_success 'directory rename + rename/delete + modify/delete + directory/file conflict' '
 	# Setup
diff --git a/t/t6421-merge-partial-clone.sh b/t/t6421-merge-partial-clone.sh
index 5413e5dd9d..711b709e75 100755
--- a/t/t6421-merge-partial-clone.sh
+++ b/t/t6421-merge-partial-clone.sh
@@ -155,7 +155,7 @@ test_setup_repo () {
 #   Commit A:
 #     (Rename leap->jump, rename basename/ -> basename/subdir/, rename dir/
 #      -> folder/, move e into newsubdir, add newfile.rs, remove f, modify
-#      both both Makefiles and jumps)
+#      both Makefiles and jumps)
 #              general/{jump1_A, jump2_A}
 #              basename/subdir/{numbers_A, sequence_A, values_A}
 #              folder/subdir/{a,b,c,d,Makefile_TOP_A}
@@ -343,7 +343,7 @@ test_expect_merge_algorithm failure success 'Objects downloaded when a directory
 #   Commit A:
 #     (Rename leap->jump, rename basename/ -> basename/subdir/, rename dir/
 #      -> folder/, move e into newsubdir, add newfile.rs, remove f, modify
-#      both both Makefiles and jumps)
+#      both Makefiles and jumps)
 #              general/{jump1_A, jump2_A}
 #              basename/subdir/{numbers_A, sequence_A, values_A}
 #              folder/subdir/{a,b,c,d,Makefile_TOP_A}
diff --git a/t/t7527-builtin-fsmonitor.sh b/t/t7527-builtin-fsmonitor.sh
index 76d0220daa..f9aad19d1c 100755
--- a/t/t7527-builtin-fsmonitor.sh
+++ b/t/t7527-builtin-fsmonitor.sh
@@ -904,7 +904,7 @@ test_expect_success "submodule absorbgitdirs implicitly starts daemon" '
 
 # On a case-insensitive file system, confirm that the daemon
 # notices when the .git directory is moved/renamed/deleted
-# regardless of how it is spelled in the the FS event.
+# regardless of how it is spelled in the FS event.
 # That is, does the FS event receive the spelling of the
 # operation or does it receive the spelling preserved with
 # the file/directory.
@@ -922,7 +922,7 @@ test_expect_success CASE_INSENSITIVE_FS 'case insensitive+preserving' '
 	test_path_is_dir test_insensitive/.git &&
 	test_path_is_dir test_insensitive/.GIT &&
 
-	# Rename .git using an alternate spelling to verify that that
+	# Rename .git using an alternate spelling to verify that
 	# daemon detects it and automatically shuts down.
 	mv test_insensitive/.GIT test_insensitive/.FOO &&
 
-- 
2.38.1

