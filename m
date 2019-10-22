Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.2 (2018-09-13) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-3.9 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,RCVD_IN_DNSWL_HI,
	SPF_HELO_NONE,SPF_NONE shortcircuit=no autolearn=ham
	autolearn_force=no version=3.4.2
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 829151F4C0
	for <e@80x24.org>; Tue, 22 Oct 2019 23:30:29 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2389700AbfJVXa2 (ORCPT <rfc822;e@80x24.org>);
        Tue, 22 Oct 2019 19:30:28 -0400
Received: from mail-wr1-f66.google.com ([209.85.221.66]:47005 "EHLO
        mail-wr1-f66.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1731847AbfJVXa1 (ORCPT <rfc822;git@vger.kernel.org>);
        Tue, 22 Oct 2019 19:30:27 -0400
Received: by mail-wr1-f66.google.com with SMTP id n15so9111986wrw.13
        for <git@vger.kernel.org>; Tue, 22 Oct 2019 16:30:26 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=message-id:in-reply-to:references:from:date:subject:fcc
         :content-transfer-encoding:mime-version:to:cc;
        bh=9kiJBPjXBiY57qM+looaZ5N10i1Ax8FM7j53JmFqfO0=;
        b=WZUrcV5fWUH2S2Mdj14rTK3C1Fe50RgUmdKOQwTFcOfpTL5H47lwFGuLZjKxAOo7NP
         xXOCMil+AX47FHQjsRHoYWex8A1vNGhCV2xW3JSdhL5GHlySEW7z/vb/rp9mQBUzs6mq
         YPiqm8P3WeU5YixZitdU9wj7ZK4XZE1Z+Y7bJUgei/vFcgRHG0nEryKv7bm3FGKHycKz
         F13PJ7B4gVl/Kt5QFuKNVYpCLYv7HCHqvsu3vbrZdHVi9CDm5E0YwZ17GkxtsYTBGoqP
         E3wbVPZtxXdP2sK3KPUFE1aaTo4ZMmNuR4/WKWXcweVQOHLxQC0tPYv3HdzSczdv80CD
         +rCw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:message-id:in-reply-to:references:from:date
         :subject:fcc:content-transfer-encoding:mime-version:to:cc;
        bh=9kiJBPjXBiY57qM+looaZ5N10i1Ax8FM7j53JmFqfO0=;
        b=nbxwR9r7dJqcCbprbIXXx02ZvmKFuSGKwoJ/kzmFNIFA+XMYAYd1inslcbx5uTkjdD
         fLaLlQzdumTcRHhslchXYIFq0Z/au9OMNemb0MD6GCm4fVM/Z5bHwO/odJFs7wN4Y+aP
         /fUWViYZ2qxOUFcuMINYktyYkJDo22LmJY5T2wJiOElQK0NgMegqarKnRxZZaqLic4oA
         FeLsmamOu2jId6ypKyCI9umaVYOiX+6LH3op6JgnF8T6ab909XbzQ8aPCoCweUNtXluv
         Kv9za1mc8bghkT37QxSDjuNaLj2UuiU8kcQ25x1V1EA2rn7WH2O84kl7tjDd1BMau9lR
         /vwA==
X-Gm-Message-State: APjAAAVkDCXIRYA8hZLWM7UEK7LuK7AUOGi0N39lQW8yzjEw6x2xwGIu
        8XoZwWkoGFs8gndbLmGku1RXagYN
X-Google-Smtp-Source: APXvYqzU1osrW0M7ofjTKo0bC130GoFnjgc34FLZW6EdbXxnEa1sX2SsRGLMPlZCrMznaGizMlNvQQ==
X-Received: by 2002:adf:e2c5:: with SMTP id d5mr5306612wrj.283.1571787025522;
        Tue, 22 Oct 2019 16:30:25 -0700 (PDT)
Received: from [127.0.0.1] ([13.74.141.28])
        by smtp.gmail.com with ESMTPSA id m7sm21069770wrv.40.2019.10.22.16.30.24
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Tue, 22 Oct 2019 16:30:25 -0700 (PDT)
Message-Id: <0d168b4a75c65e786f4b14f5da723957c32fa390.1571787022.git.gitgitgadget@gmail.com>
In-Reply-To: <pull.417.git.1571787022.gitgitgadget@gmail.com>
References: <pull.417.git.1571787022.gitgitgadget@gmail.com>
From:   "Johannes Schindelin via GitGitGadget" <gitgitgadget@gmail.com>
Date:   Tue, 22 Oct 2019 23:30:22 +0000
Subject: [PATCH 3/3] commit: give correct advice for empty commit during a
 rebase
Fcc:    Sent
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
MIME-Version: 1.0
To:     git@vger.kernel.org
Cc:     Rohit Ashiwal <rohit.ashiwal265@gmail.com>,
        Johannes Schindelin <johannes.schindelin@gmx.de>,
        Junio C Hamano <gitster@pobox.com>,
        Johannes Schindelin <johannes.schindelin@gmx.de>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

From: Johannes Schindelin <johannes.schindelin@gmx.de>

In dcb500dc16c (cherry-pick/revert: advise using --skip, 2019-07-02),
`git commit` learned to suggest to run `git cherry-pick --skip` when
trying to cherry-pick an empty patch.

However, it was overlooked that there are more conditions than just a
`git cherry-pick` when this advice is printed (which originally
suggested the neutral `git reset`): the same can happen during a rebase.

Let's suggest the correct command, even during a rebase.

While at it, we adjust more places in `builtin/commit.c` that
incorrectly assumed that the presence of a `CHERRY_PICK_HEAD` meant that
surely this must be a `cherry-pick` in progress.

Note: we take pains to handle the situation when a user runs a `git
cherry-pick` _during_ a rebase. This is quite valid (e.g. in an `exec`
line in an interactive rebase). On the other hand, it is not possible to
run a rebase during a cherry-pick, meaning: if both `rebase-merge/` and
`sequencer/` exist, we still want to advise to use `git cherry-pick
--skip`.

Signed-off-by: Johannes Schindelin <johannes.schindelin@gmx.de>
---
 builtin/commit.c       | 33 ++++++++++++++++++++++++---------
 t/t3403-rebase-skip.sh |  9 +++++++++
 2 files changed, 33 insertions(+), 9 deletions(-)

diff --git a/builtin/commit.c b/builtin/commit.c
index e588bc6ad3..2beae13620 100644
--- a/builtin/commit.c
+++ b/builtin/commit.c
@@ -59,6 +59,9 @@ N_("The previous cherry-pick is now empty, possibly due to conflict resolution.\
 "    git commit --allow-empty\n"
 "\n");
 
+static const char empty_rebase_advice[] =
+N_("Otherwise, please use 'git rebase --skip'\n");
+
 static const char empty_cherry_pick_advice_single[] =
 N_("Otherwise, please use 'git cherry-pick --skip'\n");
 
@@ -122,7 +125,7 @@ static enum commit_msg_cleanup_mode cleanup_mode;
 static const char *cleanup_arg;
 
 static enum commit_whence whence;
-static int sequencer_in_use;
+static int sequencer_in_use, rebase_in_progress;
 static int use_editor = 1, include_status = 1;
 static int have_option_m;
 static struct strbuf message = STRBUF_INIT;
@@ -183,6 +186,8 @@ static void determine_whence(struct wt_status *s)
 		whence = FROM_CHERRY_PICK;
 		if (file_exists(git_path_seq_dir()))
 			sequencer_in_use = 1;
+		if (file_exists(git_path_rebase_merge_dir()))
+			rebase_in_progress = 1;
 	}
 	else
 		whence = FROM_COMMIT;
@@ -453,8 +458,11 @@ static const char *prepare_index(int argc, const char **argv, const char *prefix
 	if (whence != FROM_COMMIT) {
 		if (whence == FROM_MERGE)
 			die(_("cannot do a partial commit during a merge."));
-		else if (whence == FROM_CHERRY_PICK)
+		else if (whence == FROM_CHERRY_PICK) {
+			if (rebase_in_progress && !sequencer_in_use)
+				die(_("cannot do a partial commit during a rebase."));
 			die(_("cannot do a partial commit during a cherry-pick."));
+		}
 	}
 
 	if (list_paths(&partial, !current_head ? NULL : "HEAD", &pathspec))
@@ -950,10 +958,12 @@ static int prepare_to_commit(const char *index_file, const char *prefix,
 			fputs(_(empty_amend_advice), stderr);
 		else if (whence == FROM_CHERRY_PICK) {
 			fputs(_(empty_cherry_pick_advice), stderr);
-			if (!sequencer_in_use)
-				fputs(_(empty_cherry_pick_advice_single), stderr);
-			else
+			if (sequencer_in_use)
 				fputs(_(empty_cherry_pick_advice_multi), stderr);
+			else if (rebase_in_progress)
+				fputs(_(empty_rebase_advice), stderr);
+			else
+				fputs(_(empty_cherry_pick_advice_single), stderr);
 		}
 		return 0;
 	}
@@ -1156,8 +1166,11 @@ static int parse_and_validate_options(int argc, const char *argv[],
 	if (amend && whence != FROM_COMMIT) {
 		if (whence == FROM_MERGE)
 			die(_("You are in the middle of a merge -- cannot amend."));
-		else if (whence == FROM_CHERRY_PICK)
+		else if (whence == FROM_CHERRY_PICK) {
+			if (rebase_in_progress && !sequencer_in_use)
+				die(_("You are in the middle of a rebase -- cannot amend."));
 			die(_("You are in the middle of a cherry-pick -- cannot amend."));
+		}
 	}
 	if (fixup_message && squash_message)
 		die(_("Options --squash and --fixup cannot be used together"));
@@ -1628,9 +1641,11 @@ int cmd_commit(int argc, const char **argv, const char *prefix)
 			reduce_heads_replace(&parents);
 	} else {
 		if (!reflog_msg)
-			reflog_msg = (whence == FROM_CHERRY_PICK)
-					? "commit (cherry-pick)"
-					: "commit";
+			reflog_msg = (whence != FROM_CHERRY_PICK)
+					? "commit"
+					: rebase_in_progress && !sequencer_in_use
+					? "commit (rebase)"
+					: "commit (cherry-pick)";
 		commit_list_insert(current_head, &parents);
 	}
 
diff --git a/t/t3403-rebase-skip.sh b/t/t3403-rebase-skip.sh
index 1f5122b632..77b03ac49f 100755
--- a/t/t3403-rebase-skip.sh
+++ b/t/t3403-rebase-skip.sh
@@ -76,4 +76,13 @@ test_expect_success 'moved back to branch correctly' '
 
 test_debug 'gitk --all & sleep 1'
 
+test_expect_success 'correct advice upon empty commit' '
+	git checkout -b rebase-skip &&
+	test_commit a1 &&
+	test_tick &&
+	git commit --amend -m amended --no-edit &&
+	test_must_fail git rebase -m --onto a1 HEAD^ 2>err &&
+	test_i18ngrep "git rebase --skip" err
+'
+
 test_done
-- 
gitgitgadget
