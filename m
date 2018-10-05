Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.1 (2015-04-28) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-3.7 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,RCVD_IN_DNSWL_HI
	shortcircuit=no autolearn=ham autolearn_force=no version=3.4.1
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id B31DC1F453
	for <e@80x24.org>; Fri,  5 Oct 2018 15:54:41 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728314AbeJEWx6 (ORCPT <rfc822;e@80x24.org>);
        Fri, 5 Oct 2018 18:53:58 -0400
Received: from mail-pf1-f196.google.com ([209.85.210.196]:33592 "EHLO
        mail-pf1-f196.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727746AbeJEWx5 (ORCPT <rfc822;git@vger.kernel.org>);
        Fri, 5 Oct 2018 18:53:57 -0400
Received: by mail-pf1-f196.google.com with SMTP id d4-v6so5291038pfn.0
        for <git@vger.kernel.org>; Fri, 05 Oct 2018 08:54:39 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=date:message-id:in-reply-to:references:from:subject:fcc
         :content-transfer-encoding:mime-version:to:cc;
        bh=tJ+snIZZ1QZgO4iOL4yiRbZqPsT2d/X4WDcOvMVdCtg=;
        b=KVae4AlUBxSA+9qc9ygyL9NMgGuvawEZmXMctZREc6AmLQwayK9K4STS2Qv9u2j8Dq
         rK+QWPx+swmQJ7/1hKM/5VenM63Ct8xdNBUp4uUMLmgUHICeFiO/vL6ZJYmbVR8bWkJL
         3NDn2b1JSgjiTwJv5O2+cfiZgh/SmfwX4rxqV32+FDFheO8qVEf4zwQ2h/BAp/pfBPdF
         QINpq3awU3rWLK9iuNF0bHxCIAkc5xDnlKlQ55tlfsG++gVUNGtRD/qLcHO2kfxOGp4U
         pxbw3d2Z/CBVinO8xRGQ6tUpc3Rmrx3D2xEAjf35fTAvGFHIaWYt2n3kwurBcN8b0kAC
         C+eg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:message-id:in-reply-to:references:from
         :subject:fcc:content-transfer-encoding:mime-version:to:cc;
        bh=tJ+snIZZ1QZgO4iOL4yiRbZqPsT2d/X4WDcOvMVdCtg=;
        b=AErSUe3ab9RdwH0jU2o5+ZK+qtpppqiMHodMXwt7+AO+MH84rMoYLX2B1SJ/lIfhjf
         VB3otuoItYpEsYJSWspM4yiquB0xM6e7jtds1+NlpOHhXjnGjgFZgzH/ByqW2a11jh+R
         ZMc7Y1V3g9frhEXcXiIfAHXcBNVeFDxRkyiPptnkrPHtfYd6bghr2cSlJnBjjHJ9j3TO
         8kPHDS/+zE2J4g80xEBnrVh9up2WHWuh7F0+moWl932iKim/vlkK2147s1awbd3O67pc
         iBs1BI/HgnuU04RwtzGU7fhJp3j8AroMl2dYuKIGyt5iN+Ipfrvc7dcIkcm+kgpW5xdG
         b4IA==
X-Gm-Message-State: ABuFfogZelCvIB8Jysw2iw3OZW8GBWTIKnxRCDIRlJEY0lU52TniNWuO
        +okFi0WoRI6K3daJCOILK5dEYMVm
X-Google-Smtp-Source: ACcGV601S13zMmMVD/isf8V304ZRuheAlwqj0MihQGv1S8SY9RKnu9V/5JoavKonucQtheQ6gDiybg==
X-Received: by 2002:a63:d0e:: with SMTP id c14-v6mr10637451pgl.281.1538754878806;
        Fri, 05 Oct 2018 08:54:38 -0700 (PDT)
Received: from [127.0.0.1] ([40.112.137.127])
        by smtp.gmail.com with ESMTPSA id e19-v6sm18792089pfb.153.2018.10.05.08.54.37
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Fri, 05 Oct 2018 08:54:38 -0700 (PDT)
Date:   Fri, 05 Oct 2018 08:54:38 -0700 (PDT)
X-Google-Original-Date: Fri, 05 Oct 2018 15:54:34 GMT
Message-Id: <db1652ef3e6f46cace5edc9c420411f08e5420aa.1538754875.git.gitgitgadget@gmail.com>
In-Reply-To: <pull.23.v3.git.gitgitgadget@gmail.com>
References: <pull.23.v2.git.gitgitgadget@gmail.com>
        <pull.23.v3.git.gitgitgadget@gmail.com>
From:   "Johannes Schindelin via GitGitGadget" <gitgitgadget@gmail.com>
Subject: [PATCH v3 1/1] builtin rebase: prepare for builtin rebase -i
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

Please note that we also skip the finish_rebase() call for interactive
rebases because the built-in interactive rebase already takes care of
that. This is needed to support the upcoming `break` command that wants
to interrupt the rebase with exit code 0 (and naturally wants to keep
the state directory intact when doing so).

While at it, remove the `case` arm for the interactive rebase that is
now skipped in favor of the short-cut to the built-in rebase.

Signed-off-by: Johannes Schindelin <johannes.schindelin@gmx.de>
---
 builtin/rebase.c | 87 +++++++++++++++++++++++++++++++++++++++++++++---
 1 file changed, 83 insertions(+), 4 deletions(-)

diff --git a/builtin/rebase.c b/builtin/rebase.c
index 1a697d70c9..20f7159cf2 100644
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
 
@@ -395,10 +475,6 @@ static int run_specific_rebase(struct rebase_options *opts)
 		backend = "git-rebase--am";
 		backend_func = "git_rebase__am";
 		break;
-	case REBASE_INTERACTIVE:
-		backend = "git-rebase--interactive";
-		backend_func = "git_rebase__interactive";
-		break;
 	case REBASE_MERGE:
 		backend = "git-rebase--merge";
 		backend_func = "git_rebase__merge";
@@ -418,8 +494,11 @@ static int run_specific_rebase(struct rebase_options *opts)
 	argv[0] = script_snippet.buf;
 
 	status = run_command_v_opt(argv, RUN_USING_SHELL);
+finished_rebase:
 	if (opts->dont_finish_rebase)
 		; /* do nothing */
+	else if (opts->type == REBASE_INTERACTIVE)
+		; /* interactive rebase cleans up after itself */
 	else if (status == 0) {
 		if (!file_exists(state_dir_path("stopped-sha", opts)))
 			finish_rebase(opts);
-- 
gitgitgadget
