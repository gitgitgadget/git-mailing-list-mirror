Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.2 (2018-09-13) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-4.0 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,RCVD_IN_DNSWL_HI,
	SPF_HELO_NONE,SPF_NONE shortcircuit=no autolearn=ham
	autolearn_force=no version=3.4.2
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id B47D41F4C0
	for <e@80x24.org>; Thu, 10 Oct 2019 18:36:55 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726888AbfJJSgz (ORCPT <rfc822;e@80x24.org>);
        Thu, 10 Oct 2019 14:36:55 -0400
Received: from mail-wr1-f65.google.com ([209.85.221.65]:46798 "EHLO
        mail-wr1-f65.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726833AbfJJSgy (ORCPT <rfc822;git@vger.kernel.org>);
        Thu, 10 Oct 2019 14:36:54 -0400
Received: by mail-wr1-f65.google.com with SMTP id o18so9056478wrv.13
        for <git@vger.kernel.org>; Thu, 10 Oct 2019 11:36:52 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=date:message-id:in-reply-to:references:from:subject:fcc
         :content-transfer-encoding:mime-version:to:cc;
        bh=IQ2YZVQ/e77LXAgecQhkYAlY0rP6/v+Grw4mfX/8IIA=;
        b=j2N8qZmGD8JGiiknzL41eGo9k117Kuqmf2eN0H8X7CxAxq9LV+P4wiEdUYkNt5uQJJ
         jENUrZkwwaixIvRd+q9n8fZiUBZPMvHMP8VV7td1XKKRtvTBm3Px6r5ihF5I5ijL83Qi
         9YCwfsXk9P+9o0wLhkiq/5jubNikIPXyAvskKz/oNIUM2Rn9ARKTH/pVVQG4Ow2GT0GB
         PqumqobCL3Dk+LszTUl8/qveJ73BgLhGTh9HTqTzeuU/SxUimMTeV7ArQrYCSrFbS9jE
         yan7mIvQ2KZFlxIoKOLbxcQYegq+ZobhXqHx0/zyDVFsRrT1sH2LT6fM+wkkgxi5ZdFI
         mnnA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:message-id:in-reply-to:references:from
         :subject:fcc:content-transfer-encoding:mime-version:to:cc;
        bh=IQ2YZVQ/e77LXAgecQhkYAlY0rP6/v+Grw4mfX/8IIA=;
        b=D4elyWsn15NKajKzrMNAIK2yJ9R7NmnlbIxa7UCBVrtJj+V1vK+eKCcPKGlmBPOtzj
         T/jpxG6U7sP7q0DlQWMy3qLQFssrCVCzc3XzqfzLwxsvQSC6qXqi+qVM3BDoPTLP/iZ5
         Ils5oJPnjbgj4YEH0L1PnMQCoAeM3bzTC+vyDLinzCOUozZMSGBoLGPKqFo3d4d6Jn2P
         J6F7MoxJgLW3a/EXq7/IRLPUu8jAFV7d7av/br8Dn/XE/D5E85MbSej4aLtIm6i/xtCj
         WjoLUUxwn3T7HSGNooyZuSx4aVaQ9+7rwbgClZVR31B9gl1qOkQb2CxwrSuqnfsM72AI
         C5Xg==
X-Gm-Message-State: APjAAAWa5C5kpjGT0AAUhZ92GKMWLrzkjfTt1Knk+sZgirml2v2YxOl5
        SIXhZJJhhJJsdTaR3JDnF7a+rXpq
X-Google-Smtp-Source: APXvYqzke9/6VJ6JLIUYwn708TXmfnIjNnjtGizWCCQkzGc2Iao5tBsWnFo62TL+HIl4PYTU62JKFg==
X-Received: by 2002:adf:fe8b:: with SMTP id l11mr9697476wrr.167.1570732612035;
        Thu, 10 Oct 2019 11:36:52 -0700 (PDT)
Received: from [127.0.0.1] ([13.74.141.28])
        by smtp.gmail.com with ESMTPSA id n17sm6748245wrp.37.2019.10.10.11.36.51
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Thu, 10 Oct 2019 11:36:51 -0700 (PDT)
Date:   Thu, 10 Oct 2019 11:36:51 -0700 (PDT)
X-Google-Original-Date: Thu, 10 Oct 2019 18:36:48 GMT
Message-Id: <acaa086a4860b6853bc0f35dae7fcf07d3aa59e7.1570732608.git.gitgitgadget@gmail.com>
In-Reply-To: <pull.388.git.gitgitgadget@gmail.com>
References: <pull.388.git.gitgitgadget@gmail.com>
From:   "Phillip Wood via GitGitGadget" <gitgitgadget@gmail.com>
Subject: [PATCH 3/3] sequencer: run post-commit hook
Fcc:    Sent
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
MIME-Version: 1.0
To:     git@vger.kernel.org
Cc:     Johannes Schindelin <Johannes.Schindelin@gmx.de>,
        Junio C Hamano <gitster@pobox.com>,
        Phillip Wood <phillip.wood@dunelm.org.uk>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

From: Phillip Wood <phillip.wood@dunelm.org.uk>

Prior to commit 356ee4659b ("sequencer: try to commit without forking
'git commit'", 2017-11-24) the sequencer would always run the
post-commit hook after each pick or revert as it forked `git commit` to
create the commit. The conversion to committing without forking `git
commit` omitted to call the post-commit hook after creating the commit.

Signed-off-by: Phillip Wood <phillip.wood@dunelm.org.uk>
---
 builtin/commit.c              |  2 +-
 sequencer.c                   |  5 +++++
 sequencer.h                   |  1 +
 t/t3404-rebase-interactive.sh | 17 +++++++++++++++++
 4 files changed, 24 insertions(+), 1 deletion(-)

diff --git a/builtin/commit.c b/builtin/commit.c
index d898a57f5d..adb8c89c60 100644
--- a/builtin/commit.c
+++ b/builtin/commit.c
@@ -1653,7 +1653,7 @@ int cmd_commit(int argc, const char **argv, const char *prefix)
 
 	repo_rerere(the_repository, 0);
 	run_command_v_opt(argv_gc_auto, RUN_GIT_CMD);
-	run_commit_hook(use_editor, get_index_file(), "post-commit", NULL);
+	run_post_commit_hook(use_editor, get_index_file());
 	if (amend && !no_post_rewrite) {
 		commit_post_rewrite(the_repository, current_head, &oid);
 	}
diff --git a/sequencer.c b/sequencer.c
index 3ce578c40b..b4947f6969 100644
--- a/sequencer.c
+++ b/sequencer.c
@@ -1173,6 +1173,10 @@ static int run_prepare_commit_msg_hook(struct repository *r,
 	return ret;
 }
 
+void run_post_commit_hook(int editor_is_used, const char *index_file) {
+	run_commit_hook(editor_is_used, index_file, "post-commit", NULL);
+}
+
 static const char implicit_ident_advice_noconfig[] =
 N_("Your name and email address were configured automatically based\n"
 "on your username and hostname. Please check that they are accurate.\n"
@@ -1427,6 +1431,7 @@ static int try_to_commit(struct repository *r,
 		goto out;
 	}
 
+	run_post_commit_hook(0, r->index_file);
 	if (flags & AMEND_MSG)
 		commit_post_rewrite(r, current_head, oid);
 
diff --git a/sequencer.h b/sequencer.h
index b0419d6ddb..e3e73c5635 100644
--- a/sequencer.h
+++ b/sequencer.h
@@ -203,4 +203,5 @@ int sequencer_get_last_command(struct repository* r,
 			       enum replay_action *action);
 LAST_ARG_MUST_BE_NULL
 int run_commit_hook(int editor_is_used, const char *index_file, const char *name, ...);
+void run_post_commit_hook(int editor_is_used, const char *index_file);
 #endif /* SEQUENCER_H */
diff --git a/t/t3404-rebase-interactive.sh b/t/t3404-rebase-interactive.sh
index d2f1d5bd23..d9217235b6 100755
--- a/t/t3404-rebase-interactive.sh
+++ b/t/t3404-rebase-interactive.sh
@@ -1467,4 +1467,21 @@ test_expect_success 'valid author header when author contains single quote' '
 	test_cmp expected actual
 '
 
+test_expect_success 'post-commit hook is called' '
+	test_when_finished "rm -f .git/hooks/post-commit commits" &&
+	mkdir -p .git/hooks &&
+	write_script .git/hooks/post-commit <<-\EOS &&
+	git rev-parse HEAD >>commits
+	EOS
+	set_fake_editor &&
+	FAKE_LINES="edit 4 1 reword 2 fixup 3" git rebase -i A E &&
+	echo x>file3 &&
+	git add file3 &&
+	FAKE_COMMIT_MESSAGE=edited git rebase --continue &&
+	# rev-list does not support -g --reverse
+	git rev-list --no-walk=unsorted HEAD@{5} HEAD@{4} HEAD@{3} HEAD@{2} \
+		HEAD@{1} HEAD >expected &&
+	test_cmp expected commits
+'
+
 test_done
-- 
gitgitgadget
