Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.2 (2018-09-13) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-4.1 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,RCVD_IN_DNSWL_HI,
	SPF_HELO_NONE,SPF_NONE shortcircuit=no autolearn=ham
	autolearn_force=no version=3.4.2
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 442611F462
	for <e@80x24.org>; Thu, 25 Jul 2019 10:11:29 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2388975AbfGYKL2 (ORCPT <rfc822;e@80x24.org>);
        Thu, 25 Jul 2019 06:11:28 -0400
Received: from mail-wr1-f68.google.com ([209.85.221.68]:33054 "EHLO
        mail-wr1-f68.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S2388602AbfGYKL1 (ORCPT <rfc822;git@vger.kernel.org>);
        Thu, 25 Jul 2019 06:11:27 -0400
Received: by mail-wr1-f68.google.com with SMTP id n9so50214229wru.0
        for <git@vger.kernel.org>; Thu, 25 Jul 2019 03:11:25 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=date:message-id:in-reply-to:references:from:subject:fcc
         :content-transfer-encoding:mime-version:to:cc;
        bh=uFnxawjxK4tSxebjalC2w2K/V4jScZleumkF8di6WZA=;
        b=Zj1EGX6/4GNYu5NFtuvkjCyHnxALekaQVi0t9YBltC9nrVbRjqaKe26gJ7/CbA/YuO
         gYu0yngUaKzF4wgFJgt2Rfr6D9nw9O8HLtwkkLMVNFPEallhv8ASQF/8p+E4SqMf/n3g
         W35d+eJJlnRJOLffQG6ZIGNoc6uZMwUyHhlSaPTDJxKmjwrShxdHDD1XmEII9eBxOIyn
         aEYiZiOVIQ+dlTNLMfg0zqQnKeRO3asfA7IMummrNYryjNg6Z3LVaDMQXFJkiwE3bqSg
         Ch95FJ6BvyFKDAGVMBbrsnH6Wqeq4sEJm5AKttGeZH92/+j1v02NF8n/Z4KLW+DbEWLk
         m8bw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:message-id:in-reply-to:references:from
         :subject:fcc:content-transfer-encoding:mime-version:to:cc;
        bh=uFnxawjxK4tSxebjalC2w2K/V4jScZleumkF8di6WZA=;
        b=MokkWHPz2jfMlQLkP5DCVWoehVyzHSiMdbOqEEx7JJJ9oHon9CDBZrB9pcIhKVpFdM
         0wB6xzFLnaGEeEaH0GPgfeEHfM8tixNK2u3wWjXqvanX+MPLXyBQyNDyVQDFECP7ETX+
         mVFnvAhflu3r/6HpsTzXE0n1e5YclmDF1OuuGnBirt7G78kYQ2jWkEHYodI2WUoyNCC0
         g+CNZ4oHQPW6RUkfHJD/mY52p/sJSCkjJ2bH2VyaQ6cCDlg+tSlYiC/vMNTzHwHhy/4E
         3TLMEHX/E4Ijf6bNkoZHATSUcvN4tXjtyeMXCL7BqCoaPHY5G2dauXzd8+xtpyNhv8gP
         AX9A==
X-Gm-Message-State: APjAAAU8IeehITy9uyQSng+clK7yvUN2r4bM8fbI5PDOA/NsTvQEeMNu
        II5VftluUEp1lfQ6lS9vrVppG1VE
X-Google-Smtp-Source: APXvYqxy7fccje77bnkkcSMV5KLMCpeNBn0bKEK9gF9RBBRI8CHZyk66KSFzEEN9ZqaewlZ1tqnvvA==
X-Received: by 2002:adf:ea82:: with SMTP id s2mr87261244wrm.91.1564049484376;
        Thu, 25 Jul 2019 03:11:24 -0700 (PDT)
Received: from [127.0.0.1] ([13.74.141.28])
        by smtp.gmail.com with ESMTPSA id l9sm41210344wmh.36.2019.07.25.03.11.23
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Thu, 25 Jul 2019 03:11:23 -0700 (PDT)
Date:   Thu, 25 Jul 2019 03:11:23 -0700 (PDT)
X-Google-Original-Date: Thu, 25 Jul 2019 10:11:13 GMT
Message-Id: <e6713568dc9170acd671d3c737939c829937b5b5.1564049474.git.gitgitgadget@gmail.com>
In-Reply-To: <pull.294.git.gitgitgadget@gmail.com>
References: <pull.294.git.gitgitgadget@gmail.com>
From:   "Johannes Schindelin via GitGitGadget" <gitgitgadget@gmail.com>
Subject: [PATCH 12/12] rebase -r: do not (re-)generate root commits with
 `--root` *and* `--onto`
Fcc:    Sent
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
MIME-Version: 1.0
To:     git@vger.kernel.org
Cc:     Junio C Hamano <gitster@pobox.com>,
        Johannes Schindelin <johannes.schindelin@gmx.de>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

From: Johannes Schindelin <johannes.schindelin@gmx.de>

When rebasing a complete commit history onto a given commit, it is
pretty obvious that the root commits should be rebased on top of said
given commit.

To test this, let's kill two birds with one stone and add a test case to
t3427-rebase-subtree.sh that not only demonstrates that this works, but
also that `git rebase -r` works with merge strategies now.

Signed-off-by: Johannes Schindelin <johannes.schindelin@gmx.de>
---
 builtin/rebase.c          |  7 +++++--
 sequencer.c               |  4 +++-
 sequencer.h               |  6 ++++++
 t/t3427-rebase-subtree.sh | 11 +++++++++++
 4 files changed, 25 insertions(+), 3 deletions(-)

diff --git a/builtin/rebase.c b/builtin/rebase.c
index c1ea617125..6a789c4421 100644
--- a/builtin/rebase.c
+++ b/builtin/rebase.c
@@ -62,7 +62,7 @@ struct rebase_options {
 	const char *onto_name;
 	const char *revisions;
 	const char *switch_to;
-	int root;
+	int root, root_with_onto;
 	struct object_id *squash_onto;
 	struct commit *restrict_revision;
 	int dont_finish_rebase;
@@ -374,6 +374,7 @@ static int run_rebase_interactive(struct rebase_options *opts,
 	flags |= abbreviate_commands ? TODO_LIST_ABBREVIATE_CMDS : 0;
 	flags |= opts->rebase_merges ? TODO_LIST_REBASE_MERGES : 0;
 	flags |= opts->rebase_cousins > 0 ? TODO_LIST_REBASE_COUSINS : 0;
+	flags |= opts->root_with_onto ? TODO_LIST_ROOT_WITH_ONTO : 0;
 	flags |= command == ACTION_SHORTEN_OIDS ? TODO_LIST_SHORTEN_IDS : 0;
 
 	switch (command) {
@@ -1845,7 +1846,9 @@ int cmd_rebase(int argc, const char **argv, const char *prefix)
 			options.squash_onto = &squash_onto;
 			options.onto_name = squash_onto_name =
 				xstrdup(oid_to_hex(&squash_onto));
-		}
+		} else
+			options.root_with_onto = 1;
+
 		options.upstream_name = NULL;
 		options.upstream = NULL;
 		if (argc > 1)
diff --git a/sequencer.c b/sequencer.c
index d228448cd8..ca119c84e5 100644
--- a/sequencer.c
+++ b/sequencer.c
@@ -4440,6 +4440,7 @@ static int make_script_with_merges(struct pretty_print_context *pp,
 {
 	int keep_empty = flags & TODO_LIST_KEEP_EMPTY;
 	int rebase_cousins = flags & TODO_LIST_REBASE_COUSINS;
+	int root_with_onto = flags & TODO_LIST_ROOT_WITH_ONTO;
 	struct strbuf buf = STRBUF_INIT, oneline = STRBUF_INIT;
 	struct strbuf label = STRBUF_INIT;
 	struct commit_list *commits = NULL, **tail = &commits, *iter;
@@ -4606,7 +4607,8 @@ static int make_script_with_merges(struct pretty_print_context *pp,
 
 		if (!commit)
 			strbuf_addf(out, "%s %s\n", cmd_reset,
-				    rebase_cousins ? "onto" : "[new root]");
+				    rebase_cousins || root_with_onto ?
+				    "onto" : "[new root]");
 		else {
 			const char *to = NULL;
 
diff --git a/sequencer.h b/sequencer.h
index 0c494b83d4..d506081d3c 100644
--- a/sequencer.h
+++ b/sequencer.h
@@ -142,6 +142,12 @@ int sequencer_remove_state(struct replay_opts *opts);
  */
 #define TODO_LIST_REBASE_COUSINS (1U << 4)
 #define TODO_LIST_APPEND_TODO_HELP (1U << 5)
+/*
+ * When generating a script that rebases merges with `--root` *and* with
+ * `--onto`, we do not want to re-generate the root commits.
+ */
+#define TODO_LIST_ROOT_WITH_ONTO (1U << 6)
+
 
 int sequencer_make_script(struct repository *r, struct strbuf *out, int argc,
 			  const char **argv, unsigned flags);
diff --git a/t/t3427-rebase-subtree.sh b/t/t3427-rebase-subtree.sh
index 7a37235768..39e348de16 100755
--- a/t/t3427-rebase-subtree.sh
+++ b/t/t3427-rebase-subtree.sh
@@ -93,4 +93,15 @@ test_expect_success 'Rebase -Xsubtree --keep-empty --onto commit' '
 	verbose test "$(commit_message HEAD)" = "Empty commit"
 '
 
+test_expect_success 'Rebase -Xsubtree --keep-empty --rebase-merges --onto commit' '
+	reset_rebase &&
+	git checkout -b rebase-merges-onto to-rebase &&
+	test_must_fail git rebase -Xsubtree=files_subtree --keep-empty --rebase-merges --onto files-master --root &&
+	: first pick results in no changes &&
+	git rebase --continue &&
+	verbose test "$(commit_message HEAD~2)" = "master4" &&
+	verbose test "$(commit_message HEAD~)" = "files_subtree/master5" &&
+	verbose test "$(commit_message HEAD)" = "Empty commit"
+'
+
 test_done
-- 
gitgitgadget
