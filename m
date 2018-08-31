Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.1 (2015-04-28) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-3.8 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,RCVD_IN_DNSWL_HI
	shortcircuit=no autolearn=ham autolearn_force=no version=3.4.1
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 1BD401F404
	for <e@80x24.org>; Fri, 31 Aug 2018 16:50:00 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727631AbeHaU6U (ORCPT <rfc822;e@80x24.org>);
        Fri, 31 Aug 2018 16:58:20 -0400
Received: from mail-pg1-f171.google.com ([209.85.215.171]:40853 "EHLO
        mail-pg1-f171.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727572AbeHaU6T (ORCPT <rfc822;git@vger.kernel.org>);
        Fri, 31 Aug 2018 16:58:19 -0400
Received: by mail-pg1-f171.google.com with SMTP id l63-v6so1210811pga.7
        for <git@vger.kernel.org>; Fri, 31 Aug 2018 09:49:58 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=date:message-id:in-reply-to:references:from:subject:fcc
         :content-transfer-encoding:mime-version:to:cc;
        bh=+BTXYNetKE5ZwuAgkX0sDBgSEHyebx37hxf1N5WPBkE=;
        b=Dmmxnx8GXkBdR+xPBDFtiuDGl/trCJgykIerNCBlj5WM5Yqx7+BpzHXPEm4wJuhYz9
         3lhkDNOw7JiXiunrhbFnbpxhoECgQtxu8wakczs+ihrNWmk6x+evcDLvx5xZ/bkvncaN
         Vuei8ro01widbcMJiO9gfIgQHabs139hP7ln0V6ridDVaZyA4pv+R3DdXLOPtPbcAcgt
         pDorsQlosxwpoVyTHyeLrGSQfn4RRmH4NKifNwAJRRBOLhzgho1PxJCrr1oP3gwF5dqx
         Q8tXqm9NnbkSpV9RmHh7/BR7qndFitSW0BAF/eaXBWQi2VNHGcrGqGKmoEMusW7rv9bX
         UaWg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:message-id:in-reply-to:references:from
         :subject:fcc:content-transfer-encoding:mime-version:to:cc;
        bh=+BTXYNetKE5ZwuAgkX0sDBgSEHyebx37hxf1N5WPBkE=;
        b=EMNwQPDlWcAAPXKDPAaRyozMVs+dQAGnQ1tOrVs+7n0qmUn7ek9K1Xx5/jsJi2cACi
         kEp5hbuctHzK0gPjndkPf8y6+ExlssJJcrHzybfXh5vsD081EgYjPg74eTsZMTyBu+9y
         XowCg0qU1ztpe5aIxo4AjsAdBGdt1T9NHM7ecLHH52ssQ/C43fwvVwJNmhKmzvMxyvOL
         /7fPsAzvXdx6rWjiNRlrGbF3goQ2u73vJE/tQ+7pWdStqP1nl28Ld5QMBv0l1Yj9N38x
         CV7RdZn7l2Hrfg9Ww3UsCeuMAwY/Pnq/eMIIWTw+0PlkxA2NAdBIOjeblogrLRWcJ9ze
         7x1A==
X-Gm-Message-State: APzg51Dq7ST5ATVtR8JdYyt/rbHwvvHGnbHol6/N3FOFtrwfQ0Xduson
        vVHnOfvZt1CDzQmOaxUAkQ55pF4U
X-Google-Smtp-Source: ANB0VdbUumPgyVC6L+o322EDn1KfNVfM9W8Tqc9+OudGRHe2+FE9T8NwpkAMTLuGlD2A5iUfftLp3w==
X-Received: by 2002:a62:3a08:: with SMTP id h8-v6mr16679670pfa.61.1535734197494;
        Fri, 31 Aug 2018 09:49:57 -0700 (PDT)
Received: from [127.0.0.1] ([40.112.142.204])
        by smtp.gmail.com with ESMTPSA id j22-v6sm14101411pfh.45.2018.08.31.09.49.56
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Fri, 31 Aug 2018 09:49:56 -0700 (PDT)
Date:   Fri, 31 Aug 2018 09:49:56 -0700 (PDT)
X-Google-Original-Date: Fri, 31 Aug 2018 16:49:45 GMT
Message-Id: <2430ff0d46b4f7972084fb7e8cf74e75202840b5.1535734192.git.gitgitgadget@gmail.com>
In-Reply-To: <pull.29.git.gitgitgadget@gmail.com>
References: <pull.29.git.gitgitgadget@gmail.com>
From:   "Jeff Hostetler via GitGitGadget" <gitgitgadget@gmail.com>
Subject: [PATCH 2/8] trace2: add trace2 to main
Fcc:    Sent
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
MIME-Version: 1.0
To:     git@vger.kernel.org
Cc:     jeffhost@microsoft.com, Junio C Hamano <gitster@pobox.com>,
        Jeff Hostetler <jeffhost@microsoft.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

From: Jeff Hostetler <jeffhost@microsoft.com>

Signed-off-by: Jeff Hostetler <jeffhost@microsoft.com>
---
 compat/mingw.h    | 3 +--
 git-compat-util.h | 7 +++++++
 git.c             | 9 ++++++++-
 repository.c      | 2 ++
 run-command.c     | 8 +++++++-
 run-command.h     | 5 +++++
 usage.c           | 5 +++++
 7 files changed, 35 insertions(+), 4 deletions(-)

diff --git a/compat/mingw.h b/compat/mingw.h
index 571019d0bd..606402faeb 100644
--- a/compat/mingw.h
+++ b/compat/mingw.h
@@ -144,8 +144,7 @@ static inline int fcntl(int fd, int cmd, ...)
 	errno = EINVAL;
 	return -1;
 }
-/* bash cannot reliably detect negative return codes as failure */
-#define exit(code) exit((code) & 0xff)
+
 #define sigemptyset(x) (void)0
 static inline int sigaddset(sigset_t *set, int signum)
 { return 0; }
diff --git a/git-compat-util.h b/git-compat-util.h
index 5f2e90932f..c0901d9ec6 100644
--- a/git-compat-util.h
+++ b/git-compat-util.h
@@ -1219,6 +1219,13 @@ static inline int is_missing_file_error(int errno_)
 
 extern int cmd_main(int, const char **);
 
+/*
+ * Intercept all calls to exit() and route them to trace2 to
+ * optionally emit a message before calling the real exit().
+ */
+int trace2_exit_fl(const char *file, int line, int code);
+#define exit(code) exit(trace2_exit_fl(__FILE__, __LINE__, (code)))
+
 /*
  * You can mark a stack variable with UNLEAK(var) to avoid it being
  * reported as a leak by tools like LSAN or valgrind. The argument
diff --git a/git.c b/git.c
index c27c38738b..cc56279a8c 100644
--- a/git.c
+++ b/git.c
@@ -331,6 +331,8 @@ static int handle_alias(int *argcp, const char ***argv)
 			argv_array_push(&child.args, alias_string + 1);
 			argv_array_pushv(&child.args, (*argv) + 1);
 
+			trace2_alias(alias_command, child.args.argv);
+
 			ret = run_command(&child);
 			if (ret >= 0)   /* normal exit */
 				exit(ret);
@@ -365,6 +367,8 @@ static int handle_alias(int *argcp, const char ***argv)
 		/* insert after command name */
 		memcpy(new_argv + count, *argv + 1, sizeof(char *) * *argcp);
 
+		trace2_alias(alias_command, new_argv);
+
 		*argv = new_argv;
 		*argcp += count - 1;
 
@@ -413,6 +417,7 @@ static int run_builtin(struct cmd_struct *p, int argc, const char **argv)
 		setup_work_tree();
 
 	trace_argv_printf(argv, "trace: built-in: git");
+	trace2_command(p->cmd);
 
 	validate_cache_entries(&the_index);
 	status = p->fn(argc, argv, prefix);
@@ -719,6 +724,8 @@ int cmd_main(int argc, const char **argv)
 			cmd = slash + 1;
 	}
 
+	trace2_start(argv);
+
 	trace_command_performance(argv);
 
 	/*
@@ -782,5 +789,5 @@ int cmd_main(int argc, const char **argv)
 	fprintf(stderr, _("failed to run command '%s': %s\n"),
 		cmd, strerror(errno));
 
-	return 1;
+	return trace2_exit(1);
 }
diff --git a/repository.c b/repository.c
index 5dd1486718..c169f61ccd 100644
--- a/repository.c
+++ b/repository.c
@@ -113,6 +113,8 @@ out:
 void repo_set_worktree(struct repository *repo, const char *path)
 {
 	repo->worktree = real_pathdup(path, 1);
+
+	trace2_worktree(repo->worktree);
 }
 
 static int read_and_verify_repository_format(struct repository_format *format,
diff --git a/run-command.c b/run-command.c
index 84b883c213..e833d9a277 100644
--- a/run-command.c
+++ b/run-command.c
@@ -706,6 +706,7 @@ fail_pipe:
 		cmd->err = fderr[0];
 	}
 
+	trace2_child_start(cmd);
 	trace_run_command(cmd);
 
 	fflush(NULL);
@@ -911,6 +912,8 @@ fail_pipe:
 #endif
 
 	if (cmd->pid < 0) {
+		trace2_child_exit(cmd, -1);
+
 		if (need_in)
 			close_pair(fdin);
 		else if (cmd->in)
@@ -949,13 +952,16 @@ fail_pipe:
 int finish_command(struct child_process *cmd)
 {
 	int ret = wait_or_whine(cmd->pid, cmd->argv[0], 0);
+	trace2_child_exit(cmd, ret);
 	child_process_clear(cmd);
 	return ret;
 }
 
 int finish_command_in_signal(struct child_process *cmd)
 {
-	return wait_or_whine(cmd->pid, cmd->argv[0], 1);
+	int ret = wait_or_whine(cmd->pid, cmd->argv[0], 1);
+	trace2_child_exit(cmd, ret);
+	return ret;
 }
 
 
diff --git a/run-command.h b/run-command.h
index 3932420ec8..a91206b08c 100644
--- a/run-command.h
+++ b/run-command.h
@@ -12,6 +12,11 @@ struct child_process {
 	struct argv_array args;
 	struct argv_array env_array;
 	pid_t pid;
+
+	int trace2_child_id;
+	uint64_t trace2_child_us_start;
+	const char *trace2_child_class;
+
 	/*
 	 * Using .in, .out, .err:
 	 * - Specify 0 for no redirections (child inherits stdin, stdout,
diff --git a/usage.c b/usage.c
index cc803336bd..1838c46d20 100644
--- a/usage.c
+++ b/usage.c
@@ -28,12 +28,17 @@ static NORETURN void usage_builtin(const char *err, va_list params)
 static NORETURN void die_builtin(const char *err, va_list params)
 {
 	vreportf("fatal: ", err, params);
+
+	trace2_error_va(err, params);
+
 	exit(128);
 }
 
 static void error_builtin(const char *err, va_list params)
 {
 	vreportf("error: ", err, params);
+
+	trace2_error_va(err, params);
 }
 
 static void warn_builtin(const char *warn, va_list params)
-- 
gitgitgadget

