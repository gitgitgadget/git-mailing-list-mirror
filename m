Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.1 (2015-04-28) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-3.8 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,RCVD_IN_DNSWL_HI
	shortcircuit=no autolearn=ham autolearn_force=no version=3.4.1
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 6A7041F404
	for <e@80x24.org>; Wed, 29 Aug 2018 14:31:20 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728767AbeH2S2b (ORCPT <rfc822;e@80x24.org>);
        Wed, 29 Aug 2018 14:28:31 -0400
Received: from mail-pf1-f196.google.com ([209.85.210.196]:33330 "EHLO
        mail-pf1-f196.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727595AbeH2S2b (ORCPT <rfc822;git@vger.kernel.org>);
        Wed, 29 Aug 2018 14:28:31 -0400
Received: by mail-pf1-f196.google.com with SMTP id d4-v6so2378597pfn.0
        for <git@vger.kernel.org>; Wed, 29 Aug 2018 07:31:18 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=date:message-id:in-reply-to:references:from:subject:fcc
         :content-transfer-encoding:mime-version:to:cc;
        bh=yaQd7IYI9C16XldO1MJrWh41iq0qbdxZlG7BDt8pDb8=;
        b=gtVWsrRl3h/GYZeqfjzS0EXoAShGrjv+MAR53AlVO29MZT9w0z3quHXKtomk2JUFKt
         tz1sdyMyRaHzv0vRVRWAcmjMQy+CyegBpUWfAcsxJoqomYQxL3msWRXXj+FEYvIcZUjO
         OUY9XYNc/ZmcZLb4QyVQV85zFGCxhjDZRctieoEGYJap1BJ8K6y9bCqvJiky601jtloY
         m1XkVd2IkBseVKgmIuLvRIRXlXaSFrwwmOA5buSwMKqMCUEvTCufvVMfDIUv1F0YcepZ
         IRC8hTPUCjMfJsOH0Cr0ni8Ic7uBhfI6zh6py/ZZGzTrI1HD0xzXjrukMDeVRK5DQ9lP
         w3iA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:message-id:in-reply-to:references:from
         :subject:fcc:content-transfer-encoding:mime-version:to:cc;
        bh=yaQd7IYI9C16XldO1MJrWh41iq0qbdxZlG7BDt8pDb8=;
        b=lPQ2UOXurPIWnFMJ+rcycP/Z4zIlD2E5dYJzoXgaoBxxLd31qtN7qeBLKHtrDNj4KO
         7ABO6aEmw5os8eX7btIb4LwstvyRjCXGGsL/yozuuhA/0nBDU1HOaMch2kGN7V359scr
         r4cTqacM76t4eA11WddPT9xvM0qoXC5EhzKawfczFYuu9Dw7DzHKPycy4V3DRZ5rbwXE
         H1IIzoQViB6zwT66xBP2ZeqbR50wrCP1x00lseejC67WaGCjwsJneGbegG/1EVwOy5vp
         n/D2cvl4WS+0dsYXiMwvhiU+/cnJCZkJRBIIPtutJSta41iSZvQ8ChyqsQtjONAGFEkH
         dxvg==
X-Gm-Message-State: APzg51BzBnN1b9H3+i71jN793YqCNGKtT5bu2TSiSXNsnm6yNZ/eJb2w
        PNBIi+4KBIxHlxPHn6ixRqYt1XgO
X-Google-Smtp-Source: ANB0Vdbd9XAhOPH63f6Gjs9aTszQsiSwTxlpjir0GMmpNPVzUdhKE/3cFyIjZcem6NuVW2xGI4x0Ew==
X-Received: by 2002:a62:3306:: with SMTP id z6-v6mr6203007pfz.85.1535553077895;
        Wed, 29 Aug 2018 07:31:17 -0700 (PDT)
Received: from [127.0.0.1] ([40.112.142.204])
        by smtp.gmail.com with ESMTPSA id v22-v6sm9285987pfi.60.2018.08.29.07.31.16
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Wed, 29 Aug 2018 07:31:17 -0700 (PDT)
Date:   Wed, 29 Aug 2018 07:31:17 -0700 (PDT)
X-Google-Original-Date: Wed, 29 Aug 2018 14:31:13 GMT
Message-Id: <5403014be738425e942a9bc1ca2029dd8d2137bb.1535553074.git.gitgitgadget@gmail.com>
In-Reply-To: <pull.23.v2.git.gitgitgadget@gmail.com>
References: <pull.23.git.gitgitgadget@gmail.com>
        <pull.23.v2.git.gitgitgadget@gmail.com>
From:   "Johannes Schindelin via GitGitGadget" <gitgitgadget@gmail.com>
Subject: [PATCH v2 1/1] builtin rebase: prepare for builtin rebase -i
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

The builtin rebase and the builtin interactive rebase have been
developed independently, on purpose: Google Summer of Code rules
specifically state that students have to work on independent projects,
they cannot collaborate on the same project.

One fallout is that the rebase-in-c and rebase-i-in-c patches cause no
merge conflicts but a royal number of tests in the test suite to fail.

It is easy to explain why: rebase-in-c was developed under the
assumption that all rebase backends are implemented in Unix shell script
and can be sourced via `. git-rebase--<backend>`, which is no longer
true with rebase-i-in-c, where git-rebase--interactive is a hard-linked
builtin.

This patch fixes that.

Signed-off-by: Johannes Schindelin <johannes.schindelin@gmx.de>
---
 builtin/rebase.c | 81 ++++++++++++++++++++++++++++++++++++++++++++++++
 1 file changed, 81 insertions(+)

diff --git a/builtin/rebase.c b/builtin/rebase.c
index 4e69458161..99fd5d4017 100644
--- a/builtin/rebase.c
+++ b/builtin/rebase.c
@@ -326,6 +326,13 @@ static void add_var(struct strbuf *buf, const char *name, const char *value)
 	}
 }
 
+static const char *resolvemsg =
+N_("Resolve all conflicts manually, mark them as resolved with\n"
+"\"git add/rm <conflicted_files>\", then run \"git rebase --continue\".\n"
+"You can instead skip this commit: run \"git rebase --skip\".\n"
+"To abort and get back to the state before \"git rebase\", run "
+"\"git rebase --abort\".");
+
 static int run_specific_rebase(struct rebase_options *opts)
 {
 	const char *argv[] = { NULL, NULL };
@@ -333,6 +340,79 @@ static int run_specific_rebase(struct rebase_options *opts)
 	int status;
 	const char *backend, *backend_func;
 
+	if (opts->type == REBASE_INTERACTIVE) {
+		/* Run builtin interactive rebase */
+		struct child_process child = CHILD_PROCESS_INIT;
+
+		argv_array_pushf(&child.env_array, "GIT_CHERRY_PICK_HELP=%s",
+				 resolvemsg);
+		if (!(opts->flags & REBASE_INTERACTIVE_EXPLICIT)) {
+			argv_array_push(&child.env_array, "GIT_EDITOR=:");
+			opts->autosquash = 0;
+		}
+
+		child.git_cmd = 1;
+		argv_array_push(&child.args, "rebase--interactive");
+
+		if (opts->action)
+			argv_array_pushf(&child.args, "--%s", opts->action);
+		if (opts->keep_empty)
+			argv_array_push(&child.args, "--keep-empty");
+		if (opts->rebase_merges)
+			argv_array_push(&child.args, "--rebase-merges");
+		if (opts->rebase_cousins)
+			argv_array_push(&child.args, "--rebase-cousins");
+		if (opts->autosquash)
+			argv_array_push(&child.args, "--autosquash");
+		if (opts->flags & REBASE_VERBOSE)
+			argv_array_push(&child.args, "--verbose");
+		if (opts->flags & REBASE_FORCE)
+			argv_array_push(&child.args, "--no-ff");
+		if (opts->restrict_revision)
+			argv_array_pushf(&child.args,
+					 "--restrict-revision=^%s",
+					 oid_to_hex(&opts->restrict_revision->object.oid));
+		if (opts->upstream)
+			argv_array_pushf(&child.args, "--upstream=%s",
+					 oid_to_hex(&opts->upstream->object.oid));
+		if (opts->onto)
+			argv_array_pushf(&child.args, "--onto=%s",
+					 oid_to_hex(&opts->onto->object.oid));
+		if (opts->squash_onto)
+			argv_array_pushf(&child.args, "--squash-onto=%s",
+					 oid_to_hex(opts->squash_onto));
+		if (opts->onto_name)
+			argv_array_pushf(&child.args, "--onto-name=%s",
+					 opts->onto_name);
+		argv_array_pushf(&child.args, "--head-name=%s",
+				 opts->head_name ?
+				 opts->head_name : "detached HEAD");
+		if (opts->strategy)
+			argv_array_pushf(&child.args, "--strategy=%s",
+					 opts->strategy);
+		if (opts->strategy_opts)
+			argv_array_pushf(&child.args, "--strategy-opts=%s",
+					 opts->strategy_opts);
+		if (opts->switch_to)
+			argv_array_pushf(&child.args, "--switch-to=%s",
+					 opts->switch_to);
+		if (opts->cmd)
+			argv_array_pushf(&child.args, "--cmd=%s", opts->cmd);
+		if (opts->allow_empty_message)
+			argv_array_push(&child.args, "--allow-empty-message");
+		if (opts->allow_rerere_autoupdate > 0)
+			argv_array_push(&child.args, "--rerere-autoupdate");
+		else if (opts->allow_rerere_autoupdate == 0)
+			argv_array_push(&child.args, "--no-rerere-autoupdate");
+		if (opts->gpg_sign_opt)
+			argv_array_push(&child.args, opts->gpg_sign_opt);
+		if (opts->signoff)
+			argv_array_push(&child.args, "--signoff");
+
+		status = run_command(&child);
+		goto finished_rebase;
+	}
+
 	add_var(&script_snippet, "GIT_DIR", absolute_path(get_git_dir()));
 	add_var(&script_snippet, "state_dir", opts->state_dir);
 
@@ -418,6 +498,7 @@ static int run_specific_rebase(struct rebase_options *opts)
 	argv[0] = script_snippet.buf;
 
 	status = run_command_v_opt(argv, RUN_USING_SHELL);
+finished_rebase:
 	if (opts->dont_finish_rebase)
 		; /* do nothing */
 	else if (status == 0) {
-- 
gitgitgadget
