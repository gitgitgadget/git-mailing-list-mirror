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
	by dcvr.yhbt.net (Postfix) with ESMTP id E518C1F4C0
	for <e@80x24.org>; Tue, 15 Oct 2019 10:25:46 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1730551AbfJOKZm (ORCPT <rfc822;e@80x24.org>);
        Tue, 15 Oct 2019 06:25:42 -0400
Received: from mail-wr1-f66.google.com ([209.85.221.66]:46019 "EHLO
        mail-wr1-f66.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1730528AbfJOKZk (ORCPT <rfc822;git@vger.kernel.org>);
        Tue, 15 Oct 2019 06:25:40 -0400
Received: by mail-wr1-f66.google.com with SMTP id r5so23107765wrm.12
        for <git@vger.kernel.org>; Tue, 15 Oct 2019 03:25:39 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=message-id:in-reply-to:references:from:date:subject:fcc
         :content-transfer-encoding:mime-version:to:cc;
        bh=hQ46e5Rl1l75zbqVnUFHivymZxnFCap5PW2VEUHQNN0=;
        b=W/6KxvxGjn4qFpjxvF7BJB5UATBc6WflIu5r6EPj4yI6bOS+U6UTpXWNATQvtKDn4A
         rl83hiw1povXKHKLJbjry7PKR10LW57VuToDWP+eyF1Nxr636a89eIbYNU+E0L/I5KOx
         Xr7hsajk/zBhvpcK3fB4y6iB8kXkPbLSUPDgPPJJqTEWEW5whIEhyfuop+wjiECTb/Ao
         peIIGZPbGhLtz46tILbAfFmFxogZYjP7fhTPAPeyWNmCZUOGuP/bDYqBCd8ELlMVz3bG
         Wfl7x0y9VucYh1Sjv0VQICfkmgcAgLbVd8RW0mvsgK15Bkao4uYth+cb8oXxC6kZ7PIa
         lvcw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:message-id:in-reply-to:references:from:date
         :subject:fcc:content-transfer-encoding:mime-version:to:cc;
        bh=hQ46e5Rl1l75zbqVnUFHivymZxnFCap5PW2VEUHQNN0=;
        b=WBkKZP/zj0f1jqHintFhNuDiAIjxsLD6Ltrh0xfW6HlZCWbHnXw/OCBiMHuBPRcUKK
         FpI9HZnaUIX6FNKOIzdkR5KcIgBMZuOgP73AgRb3Y14LUT1j+3SBYmBok5tTyztnOhF9
         Q/X5e0kD9jWAPGs1/TQJxs+lonnxYYNjWNXqvhrf9UR7ZIxXtyFnwREoQwlTgHQCQsdQ
         V5/LLKqpnlb4SnD0yp4R2LEg5/5VFa0KPWMfs5KfzIoGfoYqL3JxvE7ND6+L1CCgua6F
         BASb+SajXr69A2CZbw/KGx35SXeYLvVgPub6M6zwgcNxGTgUzAhoJ3TbEM6GIq+rCJbd
         JYag==
X-Gm-Message-State: APjAAAVMqtiqo2r+ofUUAlNxZBl+oZidZZa7orPgFjcgdjVkTcxEPFtr
        vS9jVMrIrlKgwdX/hIH5Is5quD3s
X-Google-Smtp-Source: APXvYqx75dqeeT8XJxaLZJPmKNMeYNOK35iEkZHqcfdL7uU2ufeftrg7JHaxYIFlvjMD44BjSkt/tg==
X-Received: by 2002:a5d:4108:: with SMTP id l8mr28822575wrp.391.1571135138821;
        Tue, 15 Oct 2019 03:25:38 -0700 (PDT)
Received: from [127.0.0.1] ([13.74.141.28])
        by smtp.gmail.com with ESMTPSA id h18sm8954829wrr.78.2019.10.15.03.25.38
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Tue, 15 Oct 2019 03:25:38 -0700 (PDT)
Message-Id: <f394a0e1634d865b64b0e44135e525e3c5a2cf3f.1571135132.git.gitgitgadget@gmail.com>
In-Reply-To: <pull.388.v2.git.1571135132.gitgitgadget@gmail.com>
References: <pull.388.git.gitgitgadget@gmail.com>
        <pull.388.v2.git.1571135132.gitgitgadget@gmail.com>
From:   "Phillip Wood via GitGitGadget" <gitgitgadget@gmail.com>
Date:   Tue, 15 Oct 2019 10:25:31 +0000
Subject: [PATCH v2 5/6] move run_commit_hook() to libgit and use it there
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

This function was declared in commit.h but was implemented in
builtin/commit.c so was not part of libgit. Move it to libgit so we can
use it in the sequencer. This simplifies the implementation of
run_prepare_commit_msg_hook() and will be used in the next commit.

Signed-off-by: Phillip Wood <phillip.wood@dunelm.org.uk>
---
 builtin/commit.c | 22 ----------------------
 commit.c         | 24 ++++++++++++++++++++++++
 sequencer.c      | 23 ++++++++++-------------
 3 files changed, 34 insertions(+), 35 deletions(-)

diff --git a/builtin/commit.c b/builtin/commit.c
index 1921401117..d898a57f5d 100644
--- a/builtin/commit.c
+++ b/builtin/commit.c
@@ -1443,28 +1443,6 @@ static int git_commit_config(const char *k, const char *v, void *cb)
 	return git_status_config(k, v, s);
 }
 
-int run_commit_hook(int editor_is_used, const char *index_file, const char *name, ...)
-{
-	struct argv_array hook_env = ARGV_ARRAY_INIT;
-	va_list args;
-	int ret;
-
-	argv_array_pushf(&hook_env, "GIT_INDEX_FILE=%s", index_file);
-
-	/*
-	 * Let the hook know that no editor will be launched.
-	 */
-	if (!editor_is_used)
-		argv_array_push(&hook_env, "GIT_EDITOR=:");
-
-	va_start(args, name);
-	ret = run_hook_ve(hook_env.argv,name, args);
-	va_end(args);
-	argv_array_clear(&hook_env);
-
-	return ret;
-}
-
 int cmd_commit(int argc, const char **argv, const char *prefix)
 {
 	const char *argv_gc_auto[] = {"gc", "--auto", NULL};
diff --git a/commit.c b/commit.c
index 26ce0770f6..7ca8d12174 100644
--- a/commit.c
+++ b/commit.c
@@ -19,6 +19,7 @@
 #include "advice.h"
 #include "refs.h"
 #include "commit-reach.h"
+#include "run-command.h"
 
 static struct commit_extra_header *read_commit_extra_header_lines(const char *buf, size_t len, const char **);
 
@@ -1581,3 +1582,26 @@ size_t ignore_non_trailer(const char *buf, size_t len)
 	}
 	return boc ? len - boc : len - cutoff;
 }
+
+int run_commit_hook(int editor_is_used, const char *index_file,
+		    const char *name, ...)
+{
+	struct argv_array hook_env = ARGV_ARRAY_INIT;
+	va_list args;
+	int ret;
+
+	argv_array_pushf(&hook_env, "GIT_INDEX_FILE=%s", index_file);
+
+	/*
+	 * Let the hook know that no editor will be launched.
+	 */
+	if (!editor_is_used)
+		argv_array_push(&hook_env, "GIT_EDITOR=:");
+
+	va_start(args, name);
+	ret = run_hook_ve(hook_env.argv,name, args);
+	va_end(args);
+	argv_array_clear(&hook_env);
+
+	return ret;
+}
diff --git a/sequencer.c b/sequencer.c
index 2adcf5a639..cdc0d1dfba 100644
--- a/sequencer.c
+++ b/sequencer.c
@@ -1127,25 +1127,22 @@ static int run_prepare_commit_msg_hook(struct repository *r,
 				       struct strbuf *msg,
 				       const char *commit)
 {
-	struct argv_array hook_env = ARGV_ARRAY_INIT;
-	int ret;
-	const char *name;
+	int ret = 0;
+	const char *name, *arg1 = NULL, *arg2 = NULL;
 
 	name = git_path_commit_editmsg();
 	if (write_message(msg->buf, msg->len, name, 0))
 		return -1;
 
-	argv_array_pushf(&hook_env, "GIT_INDEX_FILE=%s", r->index_file);
-	argv_array_push(&hook_env, "GIT_EDITOR=:");
-	if (commit)
-		ret = run_hook_le(hook_env.argv, "prepare-commit-msg", name,
-				  "commit", commit, NULL);
-	else
-		ret = run_hook_le(hook_env.argv, "prepare-commit-msg", name,
-				  "message", NULL);
-	if (ret)
+	if (commit) {
+		arg1 = "commit";
+		arg2 = commit;
+	} else {
+		arg1 = "message";
+	}
+	if (run_commit_hook(0, r->index_file, "prepare-commit-msg", name,
+			    arg1, arg2, NULL))
 		ret = error(_("'prepare-commit-msg' hook failed"));
-	argv_array_clear(&hook_env);
 
 	return ret;
 }
-- 
gitgitgadget

