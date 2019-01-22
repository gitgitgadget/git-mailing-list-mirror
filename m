Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.2 (2018-09-13) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-4.3 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,RCVD_IN_DNSWL_HI
	shortcircuit=no autolearn=ham autolearn_force=no version=3.4.2
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 2CD191F453
	for <e@80x24.org>; Tue, 22 Jan 2019 21:22:28 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726792AbfAVVW1 (ORCPT <rfc822;e@80x24.org>);
        Tue, 22 Jan 2019 16:22:27 -0500
Received: from mail-ed1-f52.google.com ([209.85.208.52]:33508 "EHLO
        mail-ed1-f52.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726225AbfAVVWY (ORCPT <rfc822;git@vger.kernel.org>);
        Tue, 22 Jan 2019 16:22:24 -0500
Received: by mail-ed1-f52.google.com with SMTP id p6so29602eds.0
        for <git@vger.kernel.org>; Tue, 22 Jan 2019 13:22:17 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=date:message-id:in-reply-to:references:from:subject:fcc
         :content-transfer-encoding:mime-version:to:cc;
        bh=VJhsi+vAoHYRsy3Pr9WhqfWSnYJ+IYBhQV6umEdv6O0=;
        b=JbGYUN7fEkeoLipt6DNlgCzUNv9BunkOcyiFsEuGYTtcnS+5z1Gqlj5vBHynNuN3id
         fVQEr+cD3c3LhGIW7oI4oHXRhX/Vk0lLW6IynhFCTadZ+Mp3Q89DGBNZdWXu0VS9GZpx
         AWkN5buflM51jvs7mw+JTloiEqLVUh6BPCGi+aseftc9Mh6JG7+uQdHoHyMmx89iRHhY
         mAxMi//RwzDNzPf03/nz6Z0H8j85hB5fPv9Jn5iUTyJbkSJWNDD2RiMbDU9b3KlRi8xB
         suyQVN5rG50kTzbBoCb+G9QxTfaOj6vkQpRZusunY8DICAwV1RgV581M2IAM0mNY9S+d
         j3CA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:message-id:in-reply-to:references:from
         :subject:fcc:content-transfer-encoding:mime-version:to:cc;
        bh=VJhsi+vAoHYRsy3Pr9WhqfWSnYJ+IYBhQV6umEdv6O0=;
        b=X2j7mhwPEtiFnIW7ssA6BfDVSxQ0J9/ZOXIZEAFw6dJy6lYvBk3zMHxu9QjHlES4QQ
         +Rf+OEqdpDtmz91LWK+V5Nr5ilug6jL/HXbinimF6znH3ZBkzGZYIGu8K0IdnXpsT73m
         RhNJ9SAAYxCrQMaaooGXyWJfKbP4/e3w1+Im44IBE4JtAZsYh0PEui5CDW4pn6jPesYU
         O/uizRRsusZR9RT7IcWRUNUJmFuab+Br+dq4Fcy1DPsEBmBfGMwgOD7xCbd/ud/UKSRr
         GMDEIgyiINYVLaLnuhqPRIBg5TxrpPGkPkI0EKEE+dJ4/GrSiP3HzwChzDyfDJ0YT5gw
         SnAw==
X-Gm-Message-State: AJcUukdA8rv8JBXbU2xjMqI6nyCtjvO5zr+GZ76UhoqGrxOjQnCXRKnE
        itj2hVWzO6yUZnIxir9ivVXK7qQB
X-Google-Smtp-Source: ALg8bN7EYU4cYEGam8jRZrzViitE/OrQVxNev7Wm5KY/alwbB3Yk1o5APFd7FXGQ695TKIPCT0MaIQ==
X-Received: by 2002:a05:6402:295:: with SMTP id l21mr117030edv.149.1548192134790;
        Tue, 22 Jan 2019 13:22:14 -0800 (PST)
Received: from [127.0.0.1] ([13.74.141.28])
        by smtp.gmail.com with ESMTPSA id u33sm9943002edm.88.2019.01.22.13.22.13
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Tue, 22 Jan 2019 13:22:14 -0800 (PST)
Date:   Tue, 22 Jan 2019 13:22:14 -0800 (PST)
X-Google-Original-Date: Tue, 22 Jan 2019 21:21:59 GMT
Message-Id: <4aaf4834bfa9f2169e2c00f7cdc6c75281567c15.1548192131.git.gitgitgadget@gmail.com>
In-Reply-To: <pull.108.git.gitgitgadget@gmail.com>
References: <pull.108.git.gitgitgadget@gmail.com>
From:   "Jeff Hostetler via GitGitGadget" <gitgitgadget@gmail.com>
Subject: [PATCH 02/14] trace2: create new combined trace facility
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

Create a new unified tracing facility for git.  The eventual intent is to
replace the current trace_printf* and trace_performance* routines with a
unified set of git_trace2* routines.

In addition to the usual printf-style API, trace2 provides higer-level
event verbs with fixed-fields allowing structured data to be written.
This makes post-processing and analysis easier for external tools.

Trace2 defines 3 output targets.  These are set using the environment
variables "GIT_TR2", "GIT_TR2_PERF", and "GIT_TR2_EVENT".  These may be
set to "1" or to an absolute pathname (just like the current GIT_TRACE).

* GIT_TR2 is intended to be a replacement for GIT_TRACE and logs command
  summary data.

* GIT_TR2_PERF is intended as a replacement for GIT_TRACE_PERFORMANCE.
  It extends the output with columns for the command process, thread,
  repo, absolute and relative elapsed times.  It reports events for
  child process start/stop, thread start/stop, and per-thread function
  nesting.

* GIT_TR2_EVENT is a new structured format. It writes event data as a
  series of JSON records.

Calls to trace2 functions log to any of the 3 output targets enabled
without the need to call different trace_printf* or trace_performance*
routines.

Signed-off-by: Jeff Hostetler <jeffhost@microsoft.com>
---
 Makefile                      |  10 +
 builtin/submodule--helper.c   |  11 +-
 cache.h                       |   1 +
 common-main.c                 |  12 +-
 compat/mingw.c                |  11 +-
 compat/mingw.h                |   3 +-
 config.c                      |   2 +
 exec-cmd.c                    |   2 +
 git-compat-util.h             |   7 +
 git.c                         |  65 +++
 remote-curl.c                 |   7 +
 repository.c                  |   2 +
 repository.h                  |   3 +
 run-command.c                 |  63 ++-
 run-command.h                 |  17 +-
 sh-i18n--envsubst.c           |   3 +
 submodule.c                   |  11 +-
 t/helper/test-parse-options.c |   3 +
 t/helper/test-tool.c          |   3 +
 t/t0001-init.sh               |   1 +
 trace2.c                      | 809 ++++++++++++++++++++++++++++++++++
 trace2.h                      | 390 ++++++++++++++++
 trace2/tr2_cfg.c              |  92 ++++
 trace2/tr2_cfg.h              |  19 +
 trace2/tr2_dst.c              |  90 ++++
 trace2/tr2_dst.h              |  34 ++
 trace2/tr2_sid.c              |  67 +++
 trace2/tr2_sid.h              |  18 +
 trace2/tr2_tbuf.c             |  32 ++
 trace2/tr2_tbuf.h             |  23 +
 trace2/tr2_tgt.h              | 126 ++++++
 trace2/tr2_tgt_event.c        | 606 +++++++++++++++++++++++++
 trace2/tr2_tgt_normal.c       | 331 ++++++++++++++
 trace2/tr2_tgt_perf.c         | 573 ++++++++++++++++++++++++
 trace2/tr2_tls.c              | 164 +++++++
 trace2/tr2_tls.h              |  95 ++++
 trace2/tr2_verb.c             |  30 ++
 trace2/tr2_verb.h             |  24 +
 usage.c                       |  31 ++
 39 files changed, 3774 insertions(+), 17 deletions(-)
 create mode 100644 trace2.c
 create mode 100644 trace2.h
 create mode 100644 trace2/tr2_cfg.c
 create mode 100644 trace2/tr2_cfg.h
 create mode 100644 trace2/tr2_dst.c
 create mode 100644 trace2/tr2_dst.h
 create mode 100644 trace2/tr2_sid.c
 create mode 100644 trace2/tr2_sid.h
 create mode 100644 trace2/tr2_tbuf.c
 create mode 100644 trace2/tr2_tbuf.h
 create mode 100644 trace2/tr2_tgt.h
 create mode 100644 trace2/tr2_tgt_event.c
 create mode 100644 trace2/tr2_tgt_normal.c
 create mode 100644 trace2/tr2_tgt_perf.c
 create mode 100644 trace2/tr2_tls.c
 create mode 100644 trace2/tr2_tls.h
 create mode 100644 trace2/tr2_verb.c
 create mode 100644 trace2/tr2_verb.h

diff --git a/Makefile b/Makefile
index 1a44c811aa..5d4e993cdc 100644
--- a/Makefile
+++ b/Makefile
@@ -996,6 +996,16 @@ LIB_OBJS += tempfile.o
 LIB_OBJS += thread-utils.o
 LIB_OBJS += tmp-objdir.o
 LIB_OBJS += trace.o
+LIB_OBJS += trace2.o
+LIB_OBJS += trace2/tr2_cfg.o
+LIB_OBJS += trace2/tr2_dst.o
+LIB_OBJS += trace2/tr2_sid.o
+LIB_OBJS += trace2/tr2_tbuf.o
+LIB_OBJS += trace2/tr2_tgt_event.o
+LIB_OBJS += trace2/tr2_tgt_normal.o
+LIB_OBJS += trace2/tr2_tgt_perf.o
+LIB_OBJS += trace2/tr2_tls.o
+LIB_OBJS += trace2/tr2_verb.o
 LIB_OBJS += trailer.o
 LIB_OBJS += transport.o
 LIB_OBJS += transport-helper.o
diff --git a/builtin/submodule--helper.c b/builtin/submodule--helper.c
index b45514be31..82716b5060 100644
--- a/builtin/submodule--helper.c
+++ b/builtin/submodule--helper.c
@@ -1813,11 +1813,12 @@ static int update_submodules(struct submodule_update_clone *suc)
 {
 	int i;
 
-	run_processes_parallel(suc->max_jobs,
-			       update_clone_get_next_task,
-			       update_clone_start_failure,
-			       update_clone_task_finished,
-			       suc);
+	run_processes_parallel_tr2(suc->max_jobs,
+				   update_clone_get_next_task,
+				   update_clone_start_failure,
+				   update_clone_task_finished,
+				   suc,
+				   "submodule", "parallel/update");
 
 	/*
 	 * We saved the output and put it out all at once now.
diff --git a/cache.h b/cache.h
index 49713cc5a5..af996443ee 100644
--- a/cache.h
+++ b/cache.h
@@ -9,6 +9,7 @@
 #include "gettext.h"
 #include "convert.h"
 #include "trace.h"
+#include "trace2.h"
 #include "string-list.h"
 #include "pack-revindex.h"
 #include "hash.h"
diff --git a/common-main.c b/common-main.c
index 3728f66b4c..6dbdc4adf2 100644
--- a/common-main.c
+++ b/common-main.c
@@ -25,12 +25,18 @@ static void restore_sigpipe_to_default(void)
 
 int main(int argc, const char **argv)
 {
+	int result;
+
 	/*
 	 * Always open file descriptors 0/1/2 to avoid clobbering files
 	 * in die().  It also avoids messing up when the pipes are dup'ed
 	 * onto stdin/stdout/stderr in the child processes we spawn.
 	 */
 	sanitize_stdfds();
+	restore_sigpipe_to_default();
+
+	trace2_initialize();
+	trace2_cmd_start(argv);
 
 	git_resolve_executable_dir(argv[0]);
 
@@ -40,7 +46,9 @@ int main(int argc, const char **argv)
 
 	attr_start();
 
-	restore_sigpipe_to_default();
+	result = cmd_main(argc, argv);
+
+	trace2_cmd_exit(result);
 
-	return cmd_main(argc, argv);
+	return result;
 }
diff --git a/compat/mingw.c b/compat/mingw.c
index b459e1a291..111fe68baf 100644
--- a/compat/mingw.c
+++ b/compat/mingw.c
@@ -1476,19 +1476,23 @@ static int try_shell_exec(const char *cmd, char *const *argv)
 		return 0;
 	prog = path_lookup(interpr, 1);
 	if (prog) {
+		int exec_id;
 		int argc = 0;
 		const char **argv2;
 		while (argv[argc]) argc++;
 		ALLOC_ARRAY(argv2, argc + 1);
 		argv2[0] = (char *)cmd;	/* full path to the script file */
 		memcpy(&argv2[1], &argv[1], sizeof(*argv) * argc);
+		exec_id = trace2_exec(prog, argv2);
 		pid = mingw_spawnv(prog, argv2, 1);
 		if (pid >= 0) {
 			int status;
 			if (waitpid(pid, &status, 0) < 0)
 				status = 255;
+			trace2_exec_result(exec_id, status);
 			exit(status);
 		}
+		trace2_exec_result(exec_id, -1);
 		pid = 1;	/* indicate that we tried but failed */
 		free(prog);
 		free(argv2);
@@ -1501,12 +1505,17 @@ int mingw_execv(const char *cmd, char *const *argv)
 	/* check if git_command is a shell script */
 	if (!try_shell_exec(cmd, argv)) {
 		int pid, status;
+		int exec_id;
 
+		exec_id = trace2_exec(cmd, (const char **)argv);
 		pid = mingw_spawnv(cmd, (const char **)argv, 0);
-		if (pid < 0)
+		if (pid < 0) {
+			trace2_exec_result(exec_id, -1);
 			return -1;
+		}
 		if (waitpid(pid, &status, 0) < 0)
 			status = 255;
+		trace2_exec_result(exec_id, status);
 		exit(status);
 	}
 	return -1;
diff --git a/compat/mingw.h b/compat/mingw.h
index 30d9fb3e36..4d73f8aa9d 100644
--- a/compat/mingw.h
+++ b/compat/mingw.h
@@ -147,8 +147,7 @@ static inline int fcntl(int fd, int cmd, ...)
 	errno = EINVAL;
 	return -1;
 }
-/* bash cannot reliably detect negative return codes as failure */
-#define exit(code) exit((code) & 0xff)
+
 #define sigemptyset(x) (void)0
 static inline int sigaddset(sigset_t *set, int signum)
 { return 0; }
diff --git a/config.c b/config.c
index ff521eb27a..4beeb7795a 100644
--- a/config.c
+++ b/config.c
@@ -2656,6 +2656,8 @@ int git_config_set_gently(const char *key, const char *value)
 void git_config_set(const char *key, const char *value)
 {
 	git_config_set_multivar(key, value, NULL, 0);
+
+	trace2_cmd_set_config(key, value);
 }
 
 /*
diff --git a/exec-cmd.c b/exec-cmd.c
index 4f81f44310..7deeab3039 100644
--- a/exec-cmd.c
+++ b/exec-cmd.c
@@ -209,6 +209,8 @@ static int git_get_exec_path(struct strbuf *buf, const char *argv0)
 		return -1;
 	}
 
+	trace2_cmd_path(buf->buf);
+
 	return 0;
 }
 
diff --git a/git-compat-util.h b/git-compat-util.h
index b8ace77410..a41b277929 100644
--- a/git-compat-util.h
+++ b/git-compat-util.h
@@ -1238,6 +1238,13 @@ static inline int is_missing_file_error(int errno_)
 
 extern int cmd_main(int, const char **);
 
+/*
+ * Intercept all calls to exit() and route them to trace2 to
+ * optionally emit a message before calling the real exit().
+ */
+int trace2_cmd_exit_fl(const char *file, int line, int code);
+#define exit(code) exit(trace2_cmd_exit_fl(__FILE__, __LINE__, (code)))
+
 /*
  * You can mark a stack variable with UNLEAK(var) to avoid it being
  * reported as a leak by tools like LSAN or valgrind. The argument
diff --git a/git.c b/git.c
index 4d53a3d50d..2db81c775a 100644
--- a/git.c
+++ b/git.c
@@ -146,16 +146,20 @@ static int handle_options(const char ***argv, int *argc, int *envchanged)
 				git_set_exec_path(cmd + 1);
 			else {
 				puts(git_exec_path());
+				trace2_cmd_verb("_query_");
 				exit(0);
 			}
 		} else if (!strcmp(cmd, "--html-path")) {
 			puts(system_path(GIT_HTML_PATH));
+			trace2_cmd_verb("_query_");
 			exit(0);
 		} else if (!strcmp(cmd, "--man-path")) {
 			puts(system_path(GIT_MAN_PATH));
+			trace2_cmd_verb("_query_");
 			exit(0);
 		} else if (!strcmp(cmd, "--info-path")) {
 			puts(system_path(GIT_INFO_PATH));
+			trace2_cmd_verb("_query_");
 			exit(0);
 		} else if (!strcmp(cmd, "-p") || !strcmp(cmd, "--paginate")) {
 			use_pager = 1;
@@ -284,6 +288,7 @@ static int handle_options(const char ***argv, int *argc, int *envchanged)
 			(*argv)++;
 			(*argc)--;
 		} else if (skip_prefix(cmd, "--list-cmds=", &cmd)) {
+			trace2_cmd_verb("_query_");
 			if (!strcmp(cmd, "parseopt")) {
 				struct string_list list = STRING_LIST_INIT_DUP;
 				int i;
@@ -331,9 +336,14 @@ static int handle_alias(int *argcp, const char ***argv)
 			commit_pager_choice();
 
 			child.use_shell = 1;
+			child.trace2_child_class = "shell_alias";
 			argv_array_push(&child.args, alias_string + 1);
 			argv_array_pushv(&child.args, (*argv) + 1);
 
+			trace2_cmd_alias(alias_command, child.args.argv);
+			trace2_cmd_list_config();
+			trace2_cmd_verb("_run_shell_alias_");
+
 			ret = run_command(&child);
 			if (ret >= 0)   /* normal exit */
 				exit(ret);
@@ -368,6 +378,9 @@ static int handle_alias(int *argcp, const char ***argv)
 		/* insert after command name */
 		memcpy(new_argv + count, *argv + 1, sizeof(char *) * *argcp);
 
+		trace2_cmd_alias(alias_command, new_argv);
+		trace2_cmd_list_config();
+
 		*argv = new_argv;
 		*argcp += count - 1;
 
@@ -416,6 +429,8 @@ static int run_builtin(struct cmd_struct *p, int argc, const char **argv)
 		setup_work_tree();
 
 	trace_argv_printf(argv, "trace: built-in: git");
+	trace2_cmd_verb(p->cmd);
+	trace2_cmd_list_config();
 
 	validate_cache_entries(&the_index);
 	status = p->fn(argc, argv, prefix);
@@ -665,7 +680,14 @@ static void execv_dashed_external(const char **argv)
 	cmd.clean_on_exit = 1;
 	cmd.wait_after_clean = 1;
 	cmd.silent_exec_failure = 1;
+	cmd.trace2_child_class = "dashed";
 
+	trace2_cmd_verb("_run_dashed_");
+
+	/*
+	 * The code in run_command() logs trace2 child_start/child_exit
+	 * events, so we do not need to report exec/exec_result events here.
+	 */
 	trace_argv_printf(cmd.args.argv, "trace: exec:");
 
 	/*
@@ -675,6 +697,12 @@ static void execv_dashed_external(const char **argv)
 	 * the program.
 	 */
 	status = run_command(&cmd);
+
+	/*
+	 * If the child process ran and we are now going to exit, emit a
+	 * generic string as our trace2 command verb to indicate that we
+	 * launched a dashed command.
+	 */
 	if (status >= 0)
 		exit(status);
 	else if (errno != ENOENT)
@@ -700,6 +728,43 @@ static int run_argv(int *argcp, const char ***argv)
 		if (!done_alias)
 			handle_builtin(*argcp, *argv);
 
+#if 0 // TODO In GFW, need to amend a7924b655e940b06cb547c235d6bed9767929673 to include trace2_ and _tr2 lines.
+		else if (get_builtin(**argv)) {
+			struct argv_array args = ARGV_ARRAY_INIT;
+			int i;
+
+			/*
+			 * The current process is committed to launching a
+			 * child process to run the command named in (**argv)
+			 * and exiting.  Log a generic string as the trace2
+			 * command verb to indicate this.  Note that the child
+			 * process will log the actual verb when it runs.
+			 */
+			trace2_cmd_verb("_run_git_alias_");
+
+			if (get_super_prefix())
+				die("%s doesn't support --super-prefix", **argv);
+
+			commit_pager_choice();
+
+			argv_array_push(&args, "git");
+			for (i = 0; i < *argcp; i++)
+				argv_array_push(&args, (*argv)[i]);
+
+			trace_argv_printf(args.argv, "trace: exec:");
+
+			/*
+			 * if we fail because the command is not found, it is
+			 * OK to return. Otherwise, we just pass along the status code.
+			 */
+			i = run_command_v_opt_tr2(args.argv, RUN_SILENT_EXEC_FAILURE |
+						  RUN_CLEAN_ON_EXIT, "git_alias");
+			if (i >= 0 || errno != ENOENT)
+				exit(i);
+			die("could not execute builtin %s", **argv);
+		}
+#endif // a7924b655e940b06cb547c235d6bed9767929673
+
 		/* .. then try the external ones */
 		execv_dashed_external(*argv);
 
diff --git a/remote-curl.c b/remote-curl.c
index 1220dffcdc..8950b5c383 100644
--- a/remote-curl.c
+++ b/remote-curl.c
@@ -1340,6 +1340,13 @@ int cmd_main(int argc, const char **argv)
 	string_list_init(&options.deepen_not, 1);
 	string_list_init(&options.push_options, 1);
 
+	/*
+	 * Just report "remote-curl" here (folding all the various aliases
+	 * ("git-remote-http", "git-remote-https", and etc.) here since they
+	 * are all just copies of the same actual executable.
+	 */
+	trace2_cmd_verb("remote-curl");
+
 	remote = remote_get(argv[1]);
 
 	if (argc > 2) {
diff --git a/repository.c b/repository.c
index 7b02e1dffa..b741089dbb 100644
--- a/repository.c
+++ b/repository.c
@@ -119,6 +119,8 @@ static int repo_init_gitdir(struct repository *repo, const char *gitdir)
 void repo_set_worktree(struct repository *repo, const char *path)
 {
 	repo->worktree = real_pathdup(path, 1);
+
+	trace2_def_repo(repo);
 }
 
 static int read_and_verify_repository_format(struct repository_format *format,
diff --git a/repository.h b/repository.h
index 9f16c42c1e..97b03846ba 100644
--- a/repository.h
+++ b/repository.h
@@ -90,6 +90,9 @@ struct repository {
 	/* Repository's current hash algorithm, as serialized on disk. */
 	const struct git_hash_algo *hash_algo;
 
+	/* A unique-id for tracing purposes. */
+	int trace2_repo_id;
+
 	/* Configurations */
 
 	/* Indicate if a repository has a different 'commondir' from 'gitdir' */
diff --git a/run-command.c b/run-command.c
index 3db26b7b0e..8948f6fc6f 100644
--- a/run-command.c
+++ b/run-command.c
@@ -219,9 +219,29 @@ static int exists_in_PATH(const char *file)
 
 int sane_execvp(const char *file, char * const argv[])
 {
+#ifndef GIT_WINDOWS_NATIVE
+	/*
+	 * execvp() doesn't return, so we all we can do is tell trace2
+	 * what we are about to do and let it leave a hint in the log
+	 * (unless of course the execvp() fails).
+	 *
+	 * we skip this for Windows because the compat layer already
+	 * has to emulate the execvp() call anyway.
+	 */
+	int exec_id = trace2_exec(file, (const char**)argv);
+#endif
+
 	if (!execvp(file, argv))
 		return 0; /* cannot happen ;-) */
 
+#ifndef GIT_WINDOWS_NATIVE
+	{
+		int ec = errno;
+		trace2_exec_result(exec_id, ec);
+		errno = ec;
+	}
+#endif
+
 	/*
 	 * When a command can't be found because one of the directories
 	 * listed in $PATH is unsearchable, execvp reports EACCES, but
@@ -712,6 +732,7 @@ int start_command(struct child_process *cmd)
 		cmd->err = fderr[0];
 	}
 
+	trace2_child_start(cmd);
 	trace_run_command(cmd);
 
 	fflush(NULL);
@@ -926,6 +947,8 @@ int start_command(struct child_process *cmd)
 #endif
 
 	if (cmd->pid < 0) {
+		trace2_child_exit(cmd, -1);
+
 		if (need_in)
 			close_pair(fdin);
 		else if (cmd->in)
@@ -964,13 +987,16 @@ int start_command(struct child_process *cmd)
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
 
 
@@ -992,7 +1018,18 @@ int run_command_v_opt(const char **argv, int opt)
 	return run_command_v_opt_cd_env(argv, opt, NULL, NULL);
 }
 
+int run_command_v_opt_tr2(const char **argv, int opt, const char *tr2_class)
+{
+	return run_command_v_opt_cd_env_tr2(argv, opt, NULL, NULL, tr2_class);
+}
+
 int run_command_v_opt_cd_env(const char **argv, int opt, const char *dir, const char *const *env)
+{
+	return run_command_v_opt_cd_env_tr2(argv, opt, dir, env, NULL);
+}
+
+int run_command_v_opt_cd_env_tr2(const char **argv, int opt, const char *dir, const char *const *env,
+				 const char *tr2_class)
 {
 	struct child_process cmd = CHILD_PROCESS_INIT;
 	cmd.argv = argv;
@@ -1004,6 +1041,7 @@ int run_command_v_opt_cd_env(const char **argv, int opt, const char *dir, const
 	cmd.clean_on_exit = opt & RUN_CLEAN_ON_EXIT ? 1 : 0;
 	cmd.dir = dir;
 	cmd.env = env;
+	cmd.trace2_child_class = tr2_class;
 	return run_command(&cmd);
 }
 
@@ -1319,6 +1357,7 @@ int run_hook_ve(const char *const *env, const char *name, va_list args)
 	hook.env = env;
 	hook.no_stdin = 1;
 	hook.stdout_to_stderr = 1;
+	hook.trace2_hook_name = name;
 
 	return run_command(&hook);
 }
@@ -1807,3 +1846,25 @@ int run_processes_parallel(int n,
 	pp_cleanup(&pp);
 	return 0;
 }
+
+int run_processes_parallel_tr2(int n,
+			       get_next_task_fn get_next_task,
+			       start_failure_fn start_failure,
+			       task_finished_fn task_finished,
+			       void *pp_cb,
+			       const char *tr2_category,
+			       const char *tr2_label)
+{
+	int result;
+
+	trace2_region_enter_printf(tr2_category, tr2_label, NULL,
+				   "max:%d", ((n < 1) ? online_cpus() : n));
+
+	result = run_processes_parallel(n, get_next_task, start_failure,
+					task_finished, pp_cb);
+
+	trace2_region_leave(tr2_category, tr2_label, NULL);
+
+	return result;
+}
+
diff --git a/run-command.h b/run-command.h
index 68f5369fc2..91ac29102d 100644
--- a/run-command.h
+++ b/run-command.h
@@ -10,6 +10,12 @@ struct child_process {
 	struct argv_array args;
 	struct argv_array env_array;
 	pid_t pid;
+
+	int trace2_child_id;
+	uint64_t trace2_child_us_start;
+	const char *trace2_child_class;
+	const char *trace2_hook_name;
+
 	/*
 	 * Using .in, .out, .err:
 	 * - Specify 0 for no redirections (child inherits stdin, stdout,
@@ -73,12 +79,14 @@ extern int run_hook_ve(const char *const *env, const char *name, va_list args);
 #define RUN_USING_SHELL 16
 #define RUN_CLEAN_ON_EXIT 32
 int run_command_v_opt(const char **argv, int opt);
-
+int run_command_v_opt_tr2(const char **argv, int opt, const char *tr2_class);
 /*
  * env (the environment) is to be formatted like environ: "VAR=VALUE".
  * To unset an environment variable use just "VAR".
  */
 int run_command_v_opt_cd_env(const char **argv, int opt, const char *dir, const char *const *env);
+int run_command_v_opt_cd_env_tr2(const char **argv, int opt, const char *dir, const char *const *env,
+				 const char *tr2_class);
 
 /**
  * Execute the given command, sending "in" to its stdin, and capturing its
@@ -220,5 +228,12 @@ int run_processes_parallel(int n,
 			   start_failure_fn,
 			   task_finished_fn,
 			   void *pp_cb);
+int run_processes_parallel_tr2(int n,
+			       get_next_task_fn,
+			       start_failure_fn,
+			       task_finished_fn,
+			       void *pp_cb,
+			       const char *tr2_category,
+			       const char *tr2_label);
 
 #endif
diff --git a/sh-i18n--envsubst.c b/sh-i18n--envsubst.c
index 09c6b445b9..2296ba1a2d 100644
--- a/sh-i18n--envsubst.c
+++ b/sh-i18n--envsubst.c
@@ -14,6 +14,7 @@
  */
 
 #include "git-compat-util.h"
+#include "trace2.h"
 
 /* Substitution of environment variables in shell format strings.
    Copyright (C) 2003-2007 Free Software Foundation, Inc.
@@ -67,6 +68,8 @@ cmd_main (int argc, const char *argv[])
   /* Default values for command line options.  */
   /* unsigned short int show_variables = 0; */
 
+  trace2_cmd_verb("sh-i18n--envsubst");
+
   switch (argc)
 	{
 	case 1:
diff --git a/submodule.c b/submodule.c
index 6415cc5580..acc96e133b 100644
--- a/submodule.c
+++ b/submodule.c
@@ -1374,11 +1374,12 @@ int fetch_populated_submodules(struct repository *r,
 	/* default value, "--submodule-prefix" and its value are added later */
 
 	calculate_changed_submodule_paths(r);
-	run_processes_parallel(max_parallel_jobs,
-			       get_next_submodule,
-			       fetch_start_failure,
-			       fetch_finish,
-			       &spf);
+	run_processes_parallel_tr2(max_parallel_jobs,
+				   get_next_submodule,
+				   fetch_start_failure,
+				   fetch_finish,
+				   &spf,
+				   "submodule", "parallel/fetch");
 
 	argv_array_clear(&spf.args);
 out:
diff --git a/t/helper/test-parse-options.c b/t/helper/test-parse-options.c
index 47fee660b8..5318681739 100644
--- a/t/helper/test-parse-options.c
+++ b/t/helper/test-parse-options.c
@@ -2,6 +2,7 @@
 #include "cache.h"
 #include "parse-options.h"
 #include "string-list.h"
+#include "trace2.h"
 
 static int boolean = 0;
 static int integer = 0;
@@ -153,6 +154,8 @@ int cmd__parse_options(int argc, const char **argv)
 	int i;
 	int ret = 0;
 
+	trace2_cmd_verb("_parse_");
+
 	argc = parse_options(argc, (const char **)argv, prefix, options, usage, 0);
 
 	if (length_cb.called) {
diff --git a/t/helper/test-tool.c b/t/helper/test-tool.c
index bfb195b1a8..85d1f812fe 100644
--- a/t/helper/test-tool.c
+++ b/t/helper/test-tool.c
@@ -1,5 +1,6 @@
 #include "git-compat-util.h"
 #include "test-tool.h"
+#include "trace2.h"
 
 struct test_cmd {
 	const char *name;
@@ -78,6 +79,8 @@ int cmd_main(int argc, const char **argv)
 		if (!strcmp(cmds[i].name, argv[1])) {
 			argv++;
 			argc--;
+			trace2_cmd_verb(cmds[i].name);
+			trace2_cmd_list_config();
 			return cmds[i].fn(argc, argv);
 		}
 	}
diff --git a/t/t0001-init.sh b/t/t0001-init.sh
index 42a263cada..5e27604b24 100755
--- a/t/t0001-init.sh
+++ b/t/t0001-init.sh
@@ -93,6 +93,7 @@ test_expect_success 'No extra GIT_* on alias scripts' '
 		sed -n \
 			-e "/^GIT_PREFIX=/d" \
 			-e "/^GIT_TEXTDOMAINDIR=/d" \
+			-e "/^GIT_TR2_PARENT/d" \
 			-e "/^GIT_/s/=.*//p" |
 		sort
 	EOF
diff --git a/trace2.c b/trace2.c
new file mode 100644
index 0000000000..72af89ba73
--- /dev/null
+++ b/trace2.c
@@ -0,0 +1,809 @@
+#include "cache.h"
+#include "config.h"
+#include "json-writer.h"
+#include "quote.h"
+#include "run-command.h"
+#include "sigchain.h"
+#include "thread-utils.h"
+#include "version.h"
+#include "trace2/tr2_cfg.h"
+#include "trace2/tr2_dst.h"
+#include "trace2/tr2_sid.h"
+#include "trace2/tr2_tgt.h"
+#include "trace2/tr2_tls.h"
+#include "trace2/tr2_verb.h"
+
+static int trace2_enabled;
+
+static int tr2_next_child_id; /* modify under lock */
+static int tr2_next_exec_id; /* modify under lock */
+static int tr2_next_repo_id = 1; /* modify under lock. zero is reserved */
+
+/*
+ * A table of the builtin TRACE2 targets.  Each of these may be independently
+ * enabled or disabled.  Each TRACE2 API method will try to write an event to
+ * *each* of the enabled targets.
+ */
+static struct tr2_tgt *tr2_tgt_builtins[] =
+{
+	&tr2_tgt_normal,
+	&tr2_tgt_perf,
+	&tr2_tgt_event,
+	NULL
+};
+
+#define for_each_builtin(j, tgt_j)			\
+	for (j = 0, tgt_j = tr2_tgt_builtins[j];	\
+	     tgt_j;					\
+	     j++, tgt_j = tr2_tgt_builtins[j])
+
+#define for_each_wanted_builtin(j, tgt_j)	\
+	for_each_builtin(j, tgt_j)		\
+	if (tr2_dst_trace_want(tgt_j->pdst))
+
+/*
+ * Force (rather than lazily) initialize any of the requested
+ * builtin TRACE2 targets at startup (and before we've seen an
+ * actual TRACE2 event call) so we can see if we need to setup
+ * the TR2 and TLS machinery.
+ *
+ * Return the number of builtin targets enabled.
+ */
+static int tr2_tgt_want_builtins(void)
+{
+	struct tr2_tgt *tgt_j;
+	int j;
+	int sum = 0;
+
+	for_each_builtin(j, tgt_j) {
+		if (tgt_j->pfn_init())
+			sum++;
+	}
+
+	return sum;
+}
+
+/*
+ * Properly terminate each builtin target.  Give each target
+ * a chance to write a summary event and/or flush if necessary
+ * and then close the fd.
+ */
+static void tr2_tgt_disable_builtins(void)
+{
+	struct tr2_tgt *tgt_j;
+	int j;
+
+	for_each_builtin(j, tgt_j) {
+		tgt_j->pfn_term();
+	}
+}
+
+static int tr2main_exit_code;
+
+/*
+ * Our atexit routine should run after everything has finished.
+ *
+ * Note that events generated here might not actually appear if
+ * we are writing to fd 1 or 2 and our atexit routine runs after
+ * the pager's atexit routine (since it closes them to shutdown
+ * the pipes).
+ */
+static void tr2main_atexit_handler(void)
+{
+	struct tr2_tgt *tgt_j;
+	int j;
+	uint64_t us_now;
+	uint64_t us_elapsed_absolute;
+
+	us_now = getnanotime() / 1000;
+	us_elapsed_absolute = tr2tls_absolute_elapsed(us_now);
+
+	/*
+	 * Clear any unbalanced regions so that our atexit message
+	 * does not appear nested.  This improves the appearance of
+	 * the trace output if someone calls die(), for example.
+	 */
+	tr2tls_pop_unwind_self();
+	
+	for_each_wanted_builtin(j, tgt_j) {
+		if (tgt_j->pfn_atexit)
+			tgt_j->pfn_atexit(us_elapsed_absolute,
+					  tr2main_exit_code);
+	}
+
+	tr2_tgt_disable_builtins();
+
+	tr2tls_release();
+	tr2_sid_release();
+	tr2_verb_release();
+	tr2_cfg_free_patterns();
+
+	trace2_enabled = 0;
+}
+
+static void tr2main_signal_handler(int signo)
+{
+	struct tr2_tgt *tgt_j;
+	int j;
+	uint64_t us_now;
+	uint64_t us_elapsed_absolute;
+
+	us_now = getnanotime() / 1000;
+	us_elapsed_absolute = tr2tls_absolute_elapsed(us_now);
+
+	for_each_wanted_builtin(j, tgt_j) {
+		if (tgt_j->pfn_signal)
+			tgt_j->pfn_signal(us_elapsed_absolute, signo);
+	}
+
+	sigchain_pop(signo);
+	raise(signo);
+}
+
+void trace2_initialize_fl(const char *file, int line)
+{
+	struct tr2_tgt *tgt_j;
+	int j;
+
+	if (trace2_enabled)
+		return;
+
+	if (!tr2_tgt_want_builtins())
+		return;
+	trace2_enabled = 1;
+
+	tr2_sid_get();
+
+	atexit(tr2main_atexit_handler);
+	sigchain_push(SIGPIPE, tr2main_signal_handler);
+	tr2tls_init();
+
+	/*
+	 * Emit 'version' message on each active builtin target.
+	 */
+	for_each_wanted_builtin(j, tgt_j) {
+		if (tgt_j->pfn_version_fl)
+			tgt_j->pfn_version_fl(file, line);
+	}
+}
+
+int trace2_is_enabled(void)
+{
+	return trace2_enabled;
+}
+
+void trace2_cmd_start_fl(const char *file, int line, const char **argv)
+{
+	struct tr2_tgt *tgt_j;
+	int j;
+
+	if (!trace2_enabled)
+		return;
+
+	for_each_wanted_builtin(j, tgt_j) {
+		if (tgt_j->pfn_start_fl)
+			tgt_j->pfn_start_fl(file, line, argv);
+	}
+}
+
+int trace2_cmd_exit_fl(const char *file, int line, int code)
+{
+	struct tr2_tgt *tgt_j;
+	int j;
+	uint64_t us_now;
+	uint64_t us_elapsed_absolute;
+
+	code &= 0xff;
+
+	if (!trace2_enabled)
+		return code;
+
+	tr2main_exit_code = code;
+
+	us_now = getnanotime() / 1000;
+	us_elapsed_absolute = tr2tls_absolute_elapsed(us_now);
+
+	for_each_wanted_builtin(j, tgt_j) {
+		if (tgt_j->pfn_exit_fl)
+			tgt_j->pfn_exit_fl(file, line, us_elapsed_absolute, code);
+	}
+
+	return code;
+}
+
+void trace2_cmd_error_va_fl(const char *file, int line,
+			    const char *fmt, va_list ap)
+{
+	struct tr2_tgt *tgt_j;
+	int j;
+
+	if (!trace2_enabled)
+		return;
+
+	/*
+	 * We expect each target function to treat 'ap' as constant
+	 * and use va_copy (because an 'ap' can only be walked once).
+	 */
+	for_each_wanted_builtin(j, tgt_j) {
+		if (tgt_j->pfn_error_va_fl)
+			tgt_j->pfn_error_va_fl(file, line, fmt, ap);
+	}
+}
+
+void trace2_cmd_path_fl(const char *file, int line, const char *pathname)
+{
+	struct tr2_tgt *tgt_j;
+	int j;
+
+	if (!trace2_enabled)
+		return;
+
+	for_each_wanted_builtin(j, tgt_j) {
+		if (tgt_j->pfn_command_path_fl)
+			tgt_j->pfn_command_path_fl(file, line, pathname);
+	}
+}
+
+void trace2_cmd_verb_fl(const char *file, int line, const char *command_verb)
+{
+	struct tr2_tgt *tgt_j;
+	const char *hierarchy;
+	int j;
+
+	if (!trace2_enabled)
+		return;
+
+	tr2_verb_append_hierarchy(command_verb);
+	hierarchy = tr2_verb_get_hierarchy();
+
+	for_each_wanted_builtin(j, tgt_j) {
+		if (tgt_j->pfn_command_verb_fl)
+			tgt_j->pfn_command_verb_fl(file, line, command_verb,
+						   hierarchy);
+	}
+}
+
+void trace2_cmd_subverb_fl(const char *file, int line,
+			   const char *command_subverb)
+{
+	struct tr2_tgt *tgt_j;
+	int j;
+
+	if (!trace2_enabled)
+		return;
+
+	for_each_wanted_builtin(j, tgt_j) {
+		if (tgt_j->pfn_command_subverb_fl)
+			tgt_j->pfn_command_subverb_fl(file, line,
+						      command_subverb);
+	}
+}
+
+void trace2_cmd_alias_fl(const char *file, int line,
+			 const char *alias, const char **argv)
+{
+	struct tr2_tgt *tgt_j;
+	int j;
+
+	if (!trace2_enabled)
+		return;
+
+	for_each_wanted_builtin(j, tgt_j) {
+		if (tgt_j->pfn_alias_fl)
+			tgt_j->pfn_alias_fl(file, line, alias, argv);
+	}
+}
+
+void trace2_cmd_list_config_fl(const char *file, int line)
+{
+	if (!trace2_enabled)
+		return;
+
+	tr2_cfg_list_config_fl(file, line);
+}
+
+void trace2_cmd_set_config_fl(const char *file, int line,
+			      const char *key, const char *value)
+{
+	if (!trace2_enabled)
+		return;
+
+	tr2_cfg_set_fl(file, line, key, value);
+}
+
+void trace2_child_start_fl(const char *file, int line,
+			   struct child_process *cmd)
+{
+	struct tr2_tgt *tgt_j;
+	int j;
+	uint64_t us_now;
+	uint64_t us_elapsed_absolute;
+
+	if (!trace2_enabled)
+		return;
+
+	us_now = getnanotime() / 1000;
+	us_elapsed_absolute = tr2tls_absolute_elapsed(us_now);
+
+	cmd->trace2_child_id = tr2tls_locked_increment(&tr2_next_child_id);
+	cmd->trace2_child_us_start = us_now;
+
+	for_each_wanted_builtin(j, tgt_j) {
+		if (tgt_j->pfn_child_start_fl)
+			tgt_j->pfn_child_start_fl(file, line,
+						  us_elapsed_absolute, cmd);
+	}
+}
+
+void trace2_child_exit_fl(const char *file, int line,
+			  struct child_process *cmd,
+			  int child_exit_code)
+{
+	struct tr2_tgt *tgt_j;
+	int j;
+	uint64_t us_now;
+	uint64_t us_elapsed_absolute;
+	uint64_t us_elapsed_child;
+
+	if (!trace2_enabled)
+		return;
+
+	us_now = getnanotime() / 1000;
+	us_elapsed_absolute = tr2tls_absolute_elapsed(us_now);
+	
+	if (cmd->trace2_child_us_start)
+		us_elapsed_child = us_now - cmd->trace2_child_us_start;
+	else
+		us_elapsed_child = 0;
+	
+	for_each_wanted_builtin(j, tgt_j) {
+		if (tgt_j->pfn_child_exit_fl)
+			tgt_j->pfn_child_exit_fl(
+				file, line, us_elapsed_absolute,
+				cmd->trace2_child_id,
+				cmd->pid,
+				child_exit_code, us_elapsed_child);
+	}
+}
+
+int trace2_exec_fl(const char *file, int line,
+		   const char *exe, const char **argv)
+{
+	struct tr2_tgt *tgt_j;
+	int j;
+	int exec_id;
+	uint64_t us_now;
+	uint64_t us_elapsed_absolute;
+
+	if (!trace2_enabled)
+		return -1;
+
+	us_now = getnanotime() / 1000;
+	us_elapsed_absolute = tr2tls_absolute_elapsed(us_now);
+
+	exec_id = tr2tls_locked_increment(&tr2_next_exec_id);
+
+	for_each_wanted_builtin(j, tgt_j) {
+		if (tgt_j->pfn_exec_fl)
+			tgt_j->pfn_exec_fl(file, line, us_elapsed_absolute,
+					   exec_id, exe, argv);
+	}
+
+	return exec_id;
+}
+
+void trace2_exec_result_fl(const char *file, int line, int exec_id, int code)
+{
+	struct tr2_tgt *tgt_j;
+	int j;
+	uint64_t us_now;
+	uint64_t us_elapsed_absolute;
+
+	if (!trace2_enabled)
+		return;
+
+	us_now = getnanotime() / 1000;
+	us_elapsed_absolute = tr2tls_absolute_elapsed(us_now);
+
+	for_each_wanted_builtin(j, tgt_j) {
+		if (tgt_j->pfn_exec_result_fl)
+			tgt_j->pfn_exec_result_fl(file, line,
+						  us_elapsed_absolute,
+						  exec_id, code);
+	}
+}
+
+void trace2_thread_start_fl(const char *file, int line,
+			    const char *thread_name)
+{
+	struct tr2_tgt *tgt_j;
+	int j;
+	uint64_t us_now;
+	uint64_t us_elapsed_absolute;
+
+	if (!trace2_enabled)
+		return;
+
+	if (tr2tls_is_main_thread())
+	{
+		/*
+		 * We should only be called from the new thread's thread-proc,
+		 * so this is technically a bug.  But in those cases where the
+		 * main thread also runs the thread-proc function (or when we
+		 * are built with threading disabled), we need to allow it.
+		 *
+		 * Convert this call to a region-enter so the nesting looks
+		 * looks correct.  
+		 */
+		trace2_region_enter_printf_fl(file, line, NULL, NULL, NULL,
+					      "thread-proc on main: %s",
+					      thread_name);
+		return;
+	}
+
+	us_now = getnanotime() / 1000;
+	us_elapsed_absolute = tr2tls_absolute_elapsed(us_now);
+
+	tr2tls_create_self(thread_name);
+
+	for_each_wanted_builtin(j, tgt_j) {
+		if (tgt_j->pfn_thread_start_fl)
+			tgt_j->pfn_thread_start_fl(file, line,
+						   us_elapsed_absolute);
+	}
+}
+
+void trace2_thread_exit_fl(const char *file, int line)
+{
+	struct tr2_tgt *tgt_j;
+	int j;
+	uint64_t us_now;
+	uint64_t us_elapsed_absolute;
+	uint64_t us_elapsed_thread;
+
+	if (!trace2_enabled)
+		return;
+
+	if (tr2tls_is_main_thread())
+	{
+		/*
+		 * We should only be called from the exiting thread's thread-proc,
+		 * so this is technically a bug.  But in those cases where the
+		 * main thread also runs the thread-proc function (or when we
+		 * are built with threading disabled), we need to allow it.
+		 *
+		 * Convert this call to a region-leave so the nesting looks
+		 * looks correct.  
+		 */
+		trace2_region_leave_printf_fl(file, line, NULL, NULL, NULL,
+					      "thread-proc on main");
+		return;
+	}
+
+	us_now = getnanotime() / 1000;
+	us_elapsed_absolute = tr2tls_absolute_elapsed(us_now);
+
+	/*
+	 * Clear any unbalanced regions and then get the relative time
+	 * for the outer-most region (which we pushed when the thread
+	 * started).  This gives us the run time of the thread.
+	 */
+	tr2tls_pop_unwind_self();
+	us_elapsed_thread = tr2tls_region_elasped_self(us_now);
+
+	for_each_wanted_builtin(j, tgt_j) {
+		if (tgt_j->pfn_thread_exit_fl)
+			tgt_j->pfn_thread_exit_fl(file, line,
+						  us_elapsed_absolute,
+						  us_elapsed_thread);
+	}
+
+	tr2tls_unset_self();
+}
+
+void trace2_def_param_fl(const char *file, int line,
+			 const char *param, const char *value)
+{
+	struct tr2_tgt *tgt_j;
+	int j;
+
+	if (!trace2_enabled)
+		return;
+
+	for_each_wanted_builtin(j, tgt_j) {
+		if (tgt_j->pfn_param_fl)
+			tgt_j->pfn_param_fl(file, line, param, value);
+	}
+}
+
+void trace2_def_repo_fl(const char *file, int line,
+			struct repository *repo)
+{
+	struct tr2_tgt *tgt_j;
+	int j;
+
+	if (!trace2_enabled)
+		return;
+
+	if (repo->trace2_repo_id)
+		return;
+
+	repo->trace2_repo_id = tr2tls_locked_increment(&tr2_next_repo_id);
+
+	for_each_wanted_builtin(j, tgt_j) {
+		if (tgt_j->pfn_repo_fl)
+			tgt_j->pfn_repo_fl(file, line, repo);
+	}
+}
+
+void trace2_region_enter_printf_va_fl(const char *file, int line,
+				      const char *category,
+				      const char *label,
+				      const struct repository *repo,
+				      const char *fmt, va_list ap)
+{
+	struct tr2_tgt *tgt_j;
+	int j;
+	uint64_t us_now;
+	uint64_t us_elapsed_absolute;
+
+	if (!trace2_enabled)
+		return;
+
+	us_now = getnanotime() / 1000;
+	us_elapsed_absolute = tr2tls_absolute_elapsed(us_now);
+
+	/*
+	 * Print the region-enter message at the current nesting
+	 * (indentation) level and then push a new level.
+	 *
+	 * We expect each target function to treat 'ap' as constant
+	 * and use va_copy.
+	 */
+	for_each_wanted_builtin(j, tgt_j) {
+		if (tgt_j->pfn_region_enter_printf_va_fl)
+			tgt_j->pfn_region_enter_printf_va_fl(
+				file, line, us_elapsed_absolute,
+				category, label, repo, fmt, ap);
+	}
+
+	tr2tls_push_self(us_now);
+}
+
+void trace2_region_enter_fl(const char *file, int line,
+			    const char *category,
+			    const char *label,
+			    const struct repository *repo)
+{
+	trace2_region_enter_printf_va_fl(file, line,
+					 category, label, repo,
+					 NULL, NULL);
+}
+
+void trace2_region_enter_printf_fl(const char *file, int line,
+				   const char *category,
+				   const char *label,
+				   const struct repository *repo,
+				   const char *fmt, ...)
+{
+	va_list ap;
+
+	va_start(ap, fmt);
+	trace2_region_enter_printf_va_fl(file, line,
+					 category, label, repo,
+					 fmt, ap);
+	va_end(ap);
+}
+
+#ifndef HAVE_VARIADIC_MACROS
+void trace2_region_enter_printf(const char *category, const char *label,
+				const struct repository *repo,
+				const char *fmt, ...)
+{
+	va_list ap;
+
+	va_start(ap, fmt);
+	trace2_region_enter_printf_va_fl(NULL, 0,
+					 category, label, repo,
+					 fmt, ap);
+	va_end(ap);
+}
+#endif
+
+void trace2_region_leave_printf_va_fl(const char *file, int line,
+				      const char *category,
+				      const char *label,
+				      const struct repository *repo,
+				      const char *fmt, va_list ap)
+{
+	struct tr2_tgt *tgt_j;
+	int j;
+	uint64_t us_now;
+	uint64_t us_elapsed_absolute;
+	uint64_t us_elapsed_region;
+
+	if (!trace2_enabled)
+		return;
+
+	us_now = getnanotime() / 1000;
+	us_elapsed_absolute = tr2tls_absolute_elapsed(us_now);
+
+	/*
+	 * Get the elapsed time in the current region before we
+	 * pop it off the stack.  Pop the stack.  And then print
+	 * the perf message at the new (shallower) level so that
+	 * it lines up with the corresponding push/enter.
+	 */
+	us_elapsed_region = tr2tls_region_elasped_self(us_now);
+	
+	tr2tls_pop_self();
+
+	/*
+	 * We expect each target function to treat 'ap' as constant
+	 * and use va_copy.
+	 */
+	for_each_wanted_builtin(j, tgt_j) {
+		if (tgt_j->pfn_region_leave_printf_va_fl)
+			tgt_j->pfn_region_leave_printf_va_fl(
+				file, line, us_elapsed_absolute,
+				us_elapsed_region,
+				category, label, repo,
+				fmt, ap);
+	}
+}
+
+void trace2_region_leave_fl(const char *file, int line,
+			    const char *category,
+			    const char *label,
+			    const struct repository *repo)
+{
+	trace2_region_leave_printf_va_fl(file, line,
+					 category, label, repo,
+					 NULL, NULL);
+}
+
+void trace2_region_leave_printf_fl(const char *file, int line,
+				   const char *category,
+				   const char *label,
+				   const struct repository *repo,
+				   const char *fmt, ...)
+{
+	va_list ap;
+
+	va_start(ap, fmt);
+	trace2_region_leave_printf_va_fl(file, line,
+					 category, label, repo,
+					 fmt, ap);
+	va_end(ap);
+}
+
+#ifndef HAVE_VARIADIC_MACROS
+void trace2_region_leave_printf(const char *category, const char *label,
+				const struct repository *repo,
+				const char *fmt, ...)
+{
+	va_list ap;
+
+	va_start(ap, fmt);
+	trace2_region_leave_printf_va_fl(NULL, 0,
+					 category, label, repo,
+					 fmt, ap);
+	va_end(ap);
+}
+#endif
+
+void trace2_data_string_fl(const char *file, int line,
+			   const char *category,
+			   const struct repository *repo,
+			   const char *key,
+			   const char *value)
+{
+	struct tr2_tgt *tgt_j;
+	int j;
+	uint64_t us_now;
+	uint64_t us_elapsed_absolute;
+	uint64_t us_elapsed_region;
+
+	if (!trace2_enabled)
+		return;
+
+	us_now = getnanotime() / 1000;
+	us_elapsed_absolute = tr2tls_absolute_elapsed(us_now);
+	us_elapsed_region = tr2tls_region_elasped_self(us_now);
+
+	for_each_wanted_builtin(j, tgt_j) {
+		if (tgt_j->pfn_data_fl)
+			tgt_j->pfn_data_fl(file, line, us_elapsed_absolute,
+					   us_elapsed_region,
+					   category, repo, key, value);
+	}
+}
+
+void trace2_data_intmax_fl(const char *file, int line,
+			   const char *category,
+			   const struct repository *repo,
+			   const char *key,
+			   intmax_t value)
+{
+	struct strbuf buf_string = STRBUF_INIT;
+
+	if (!trace2_enabled)
+		return;
+
+	strbuf_addf(&buf_string, "%"PRIdMAX, value);
+	trace2_data_string_fl(file, line, category, repo, key, buf_string.buf);
+	strbuf_release(&buf_string);
+}
+
+void trace2_data_json_fl(const char *file, int line,
+			 const char *category,
+			 const struct repository *repo,
+			 const char *key,
+			 const struct json_writer *value)
+{
+	struct tr2_tgt *tgt_j;
+	int j;
+	uint64_t us_now;
+	uint64_t us_elapsed_absolute;
+	uint64_t us_elapsed_region;
+
+	if (!trace2_enabled)
+		return;
+
+	us_now = getnanotime() / 1000;
+	us_elapsed_absolute = tr2tls_absolute_elapsed(us_now);
+	us_elapsed_region = tr2tls_region_elasped_self(us_now);
+
+	for_each_wanted_builtin(j, tgt_j) {
+		if (tgt_j->pfn_data_fl)
+			tgt_j->pfn_data_json_fl(file, line, us_elapsed_absolute,
+						us_elapsed_region,
+						category, repo, key, value);
+	}
+}
+
+void trace2_printf_va_fl(const char *file, int line,
+			 const char *fmt, va_list ap)
+{
+	struct tr2_tgt *tgt_j;
+	int j;
+	uint64_t us_now;
+	uint64_t us_elapsed_absolute;
+
+	if (!trace2_enabled)
+		return;
+
+	us_now = getnanotime() / 1000;
+	us_elapsed_absolute = tr2tls_absolute_elapsed(us_now);
+
+	/*
+	 * We expect each target function to treat 'ap' as constant
+	 * and use va_copy.
+	 */
+	for_each_wanted_builtin(j, tgt_j) {
+		if (tgt_j->pfn_printf_va_fl)
+			tgt_j->pfn_printf_va_fl(file, line, us_elapsed_absolute,
+						fmt, ap);
+	}
+}
+
+void trace2_printf_fl(const char *file, int line,
+		      const char *fmt, ...)
+{
+	va_list ap;
+
+	va_start(ap, fmt);
+	trace2_printf_va_fl(file, line, fmt, ap);
+	va_end(ap);
+}
+
+#ifndef HAVE_VARIADIC_MACROS
+void trace2_printf(const char *fmt, ...)
+{
+	va_list ap;
+
+	va_start(ap, fmt);
+	trace2_printf_va_fl(NULL, 0, fmt, ap);
+	va_end(ap);
+}
+#endif
diff --git a/trace2.h b/trace2.h
new file mode 100644
index 0000000000..7ab9f355f3
--- /dev/null
+++ b/trace2.h
@@ -0,0 +1,390 @@
+#ifndef TRACE2_H
+#define TRACE2_H
+
+struct child_process;
+struct repository;
+struct json_writer;
+
+/*
+ * The public TRACE2 routines are grouped into the following groups:
+ *
+ * [] trace2_initialize -- initialization.
+ * [] trace2_cmd_*      -- emit command/control messages.
+ * [] trace2_child*     -- emit child start/stop messages.
+ * [] trace2_exec*      -- emit exec start/stop messages.
+ * [] trace2_thread*    -- emit thread start/stop messages.
+ * [] trace2_def*       -- emit definition/parameter mesasges.
+ * [] trace2_region*    -- emit region nesting messages.
+ * [] trace2_data*      -- emit region/thread/repo data messages.
+ * [] trace2_printf*    -- legacy trace[1] messages.
+ */
+
+/*
+ * Initialize TRACE2 tracing facility if any of the builtin TRACE2
+ * targets are enabled in the environment.  Emits a 'version' event.
+ *
+ * Cleanup/Termination is handled automatically by a registered
+ * atexit() routine.
+ */
+void trace2_initialize_fl(const char *file, int line);
+
+#define trace2_initialize() trace2_initialize_fl(__FILE__, __LINE__)
+
+/*
+ * Return true if trace2 is enabled.
+ */
+int trace2_is_enabled(void);
+
+/*
+ * Emit a 'start' event with the original (unmodified) argv.
+ */
+void trace2_cmd_start_fl(const char *file, int line, const char **argv);
+
+#define trace2_cmd_start(argv) trace2_cmd_start_fl(__FILE__, __LINE__, (argv))
+
+/*
+ * Emit an 'exit' event.
+ *
+ * Write the exit-code that will be passed to exit() or returned
+ * from main().
+ *
+ * Use this prior to actually calling exit().
+ * See "#define exit()" in git-compat-util.h
+ */
+int trace2_cmd_exit_fl(const char *file, int line, int code);
+
+#define trace2_cmd_exit(code) (trace2_cmd_exit_fl(__FILE__, __LINE__, (code)))
+
+/*
+ * Emit an 'error' event.
+ *
+ * Write an error message to the TRACE2 targets.
+ */
+void trace2_cmd_error_va_fl(const char *file, int line,
+			    const char *fmt, va_list ap);
+
+#define trace2_cmd_error_va(fmt, ap) \
+	trace2_cmd_error_va_fl(__FILE__, __LINE__, (fmt), (ap))
+
+/*
+ * Emit a 'pathname' event with the canonical pathname of the current process
+ * This gives post-processors a simple field to identify the command without
+ * having to parse the argv.  For example, to distinguish invocations from
+ * installed versus debug executables.
+ */
+void trace2_cmd_path_fl(const char *file, int line, const char *pathname);
+
+#define trace2_cmd_path(p) \
+	trace2_cmd_path_fl(__FILE__, __LINE__, (p))
+
+/*
+ * Emit a 'cmd_verb' event with the canonical name of the (usually)
+ * builtin command.  This gives post-processors a simple field
+ * to identify the command verb without having to parse the argv.
+ */
+void trace2_cmd_verb_fl(const char *file, int line, const char *command_verb);
+
+#define trace2_cmd_verb(v) \
+	trace2_cmd_verb_fl(__FILE__, __LINE__, (v))
+
+/*
+ * Emit a 'cmd_subverb' event to further describe the command being run.
+ * For example, "checkout" can checkout a single file or can checkout a
+ * different branch.  This gives post-processors a simple field to compare
+ * equivalent commands without having to parse the argv.
+ */
+void trace2_cmd_subverb_fl(const char *file, int line,
+			   const char *command_subverb);
+
+#define trace2_cmd_subverb(sv) \
+	trace2_cmd_subverb_fl(__FILE__, __LINE__, (sv))
+
+/*
+ * Emit an 'alias' expansion event.
+ */
+void trace2_cmd_alias_fl(const char *file, int line,
+			 const char *alias, const char **argv);
+
+#define trace2_cmd_alias(alias, argv) \
+	trace2_cmd_alias_fl(__FILE__, __LINE__, (alias), (argv))
+
+/*
+ * Emit one or more 'def_param' events for "interesting" configuration
+ * settings.
+ *
+ * The environment variable "GIT_TR2_CONFIG_PARAMS" can be set to a
+ * list of patterns considered important.  For example:
+ *
+ *    GIT_TR2_CONFIG_PARAMS="core.*,remote.*.url"
+ *
+ * Note: this routine does a read-only iteration on the config data
+ * (using read_early_config()), so it must not be called until enough
+ * of the process environment has been established.  This includes the
+ * location of the git and worktree directories, expansion of any "-c"
+ * and "-C" command line options, and etc.
+ */
+void trace2_cmd_list_config_fl(const char *file, int line);
+
+#define trace2_cmd_list_config() \
+	trace2_cmd_list_config_fl(__FILE__, __LINE__)
+
+/*
+ * Emit a "def_param" event for the given config key/value pair IF
+ * we consider the key to be "interesting".
+ *
+ * Use this for new/updated config settings created/updated after
+ * trace2_cmd_list_config() is called.
+ */
+void trace2_cmd_set_config_fl(const char *file, int line,
+			      const char *key, const char *value);
+
+#define trace2_cmd_set_config(k, v) \
+	trace2_cmd_set_config_fl(__FILE__, __LINE__, (k), (v))
+
+/*
+ * Emit a 'child_start' event prior to spawning a child process.
+ *
+ * Before calling optionally set "cmd->trace2_child_class" to a string
+ * describing the type of the child process.  For example, "editor" or
+ * "pager".
+ */
+void trace2_child_start_fl(const char *file, int line,
+			   struct child_process *cmd);
+
+#define trace2_child_start(cmd) \
+	trace2_child_start_fl(__FILE__, __LINE__, (cmd))
+
+/*
+ * Emit a 'child_exit' event after the child process completes. 
+ */
+void trace2_child_exit_fl(const char *file, int line,
+			  struct child_process *cmd,
+			  int child_exit_code);
+
+#define trace2_child_exit(cmd, code) \
+	trace2_child_exit_fl(__FILE__, __LINE__, (cmd), (code))
+
+/*
+ * Emit an 'exec' event prior to calling one of exec(), execv(),
+ * execvp(), and etc.  On Unix-derived systems, this will be the
+ * last event emitted for the current process, unless the exec
+ * fails.  On Windows, exec() behaves like 'child_start' and a
+ * waitpid(), so additional events may be emitted.
+ *
+ * Returns the "exec_id".
+ */
+int trace2_exec_fl(const char *file, int line,
+		   const char *exe, const char **argv);
+
+#define trace2_exec(exe, argv) \
+	trace2_exec_fl(__FILE__, __LINE__, (exe), (argv))
+
+/*
+ * Emit an 'exec_result' when possible.  On Unix-derived systems,
+ * this should be called after exec() returns (which only happens
+ * when there is an error starting the new process).  On Windows,
+ * this should be called after the waitpid().
+ *
+ * The "exec_id" should be the value returned from trace2_exec().
+ */
+void trace2_exec_result_fl(const char *file, int line, int exec_id, int code);
+
+#define trace2_exec_result(id, code) \
+	trace2_exec_result_fl(__FILE__, __LINE__, (id), (code))
+
+/*
+ * Emit a 'thread_start' event.  This must be called from inside the
+ * thread-proc to set up the trace2 TLS data for the thread.
+ *
+ * Thread names should be descriptive, like "preload_index".
+ * Thread names will be decorated with an instance number automatically.
+ */
+void trace2_thread_start_fl(const char *file, int line,
+				 const char *thread_name);
+
+#define trace2_thread_start(thread_name) \
+	trace2_thread_start_fl(__FILE__, __LINE__, (thread_name))
+
+/*
+ * Emit a 'thread_exit' event.  This must be called from inside the
+ * thread-proc to report thread-specific data and cleanup TLS data
+ * for the thread.
+ */
+void trace2_thread_exit_fl(const char *file, int line);
+
+#define trace2_thread_exit() trace2_thread_exit_fl(__FILE__, __LINE__)
+
+/*
+ * Emit a 'param' event.
+ *
+ * Write a "<param> = <value>" pair describing some aspect of the
+ * run such as an important configuration setting or command line
+ * option that significantly changes command behavior.
+ */ 
+void trace2_def_param_fl(const char *file, int line,
+			 const char *param, const char *value);
+
+#define trace2_def_param(param, value) \
+	trace2_def_param_fl(__FILE__, __LINE__, (param), (value))
+
+/*
+ * Tell trace2 about a newly instantiated repo object and assign
+ * a trace2-repo-id to be used in subsequent activity events.
+ *
+ * Emits a 'worktree' event for this repo instance.
+ */
+void trace2_def_repo_fl(const char *file, int line,
+			struct repository *repo);
+
+#define trace2_def_repo(repo) \
+	trace2_def_repo_fl(__FILE__, __LINE__, repo)
+
+/*
+ * Emit a 'region_enter' event for <category>.<label> with optional
+ * repo-id and printf message.
+ *
+ * Enter a new nesting level on the current thread and remember the
+ * current time.  This controls the indenting of all subsequent events
+ * on this thread.
+ */
+void trace2_region_enter_fl(const char *file, int line,
+			    const char *category,
+			    const char *label,
+			    const struct repository *repo);
+
+#define trace2_region_enter(category, label, repo) \
+	trace2_region_enter_fl( \
+		__FILE__, __LINE__, (category), (label), (repo))
+
+void trace2_region_enter_printf_va_fl(const char *file, int line,
+				      const char *category,
+				      const char *label,
+				      const struct repository *repo,
+				      const char *fmt, va_list ap);
+
+#define trace2_region_enter_printf_va(category, label, repo, fmt, ap) \
+	trace2_region_enter_printf_va_fl( \
+		__FILE__, __LINE__, (category), (label), (repo), (fmt), (ap))
+
+void trace2_region_enter_printf_fl(const char *file, int line,
+				   const char *category, const char *label,
+				   const struct repository *repo,
+				   const char *fmt, ...);
+
+#ifdef HAVE_VARIADIC_MACROS
+#define trace2_region_enter_printf(category, label, repo, ...) \
+	trace2_region_enter_printf_fl( \
+		__FILE__, __LINE__, (category), (label), (repo), __VA_ARGS__)
+#else
+__attribute__((format (region_enter_printf, 4, 5)))
+void trace2_region_enter_printf(const char *category, const char *label,
+				const struct repository *repo,
+				const char *fmt, ...);
+#endif
+
+/*
+ * Emit a 'region_leave' event for <category>.<label> with optional
+ * repo-id and printf message.
+ *
+ * Leave current nesting level and report the elapsed time spent
+ * in this nesting level.
+ */
+void trace2_region_leave_fl(const char *file, int line,
+			    const char *category,
+			    const char *label,
+			    const struct repository *repo);
+
+#define trace2_region_leave(category, label, repo) \
+	trace2_region_leave_fl( \
+		__FILE__, __LINE__, (category), (label), (repo))
+
+void trace2_region_leave_printf_va_fl(const char *file, int line,
+				      const char *category,
+				      const char *label,
+				      const struct repository *repo,
+				      const char *fmt, va_list ap);
+
+#define trace2_region_leave_printf_va(category, label, repo, fmt, ap) \
+	trace2_region_leave_printf_va_fl( \
+		__FILE__, __LINE__, (category), (label), (repo), (fmt), (ap))
+
+void trace2_region_leave_printf_fl(const char *file, int line,
+				   const char *category, const char *label,
+				   const struct repository *repo,
+				   const char *fmt, ...);
+
+#ifdef HAVE_VARIADIC_MACROS
+#define trace2_region_leave_printf(category, label, repo, ...) \
+	trace2_region_leave_printf_fl( \
+		__FILE__, __LINE__, (category), (label), (repo), __VA_ARGS__)
+#else
+__attribute__((format (region_leave_printf, 4, 5)))
+void trace2_region_leave_printf(const char *category, const char *label,
+				const struct repository *repo,
+				const char *fmt, ...);
+#endif
+
+/*
+ * Emit a key-value pair 'data' event of the form <category>.<key> = <value>.
+ * This event implicitly contains information about thread, nesting region,
+ * and optional repo-id.
+ *
+ * On event-based TRACE2 targets, this generates a 'data' event suitable
+ * for post-processing.  On printf-based TRACE2 targets, this is converted
+ * into a fixed-format printf message.
+ */
+void trace2_data_string_fl(const char *file, int line,
+			   const char *category,
+			   const struct repository *repo,
+			   const char *key,
+			   const char *value);
+
+#define trace2_data_string(category, repo, key, value) \
+	trace2_data_string_fl( \
+		__FILE__, __LINE__, (category), (repo), (key), (value))
+
+void trace2_data_intmax_fl(const char *file, int line,
+			   const char *category,
+			   const struct repository *repo,
+			   const char *key,
+			   intmax_t value);
+
+#define trace2_data_intmax(category, repo, key, value) \
+	trace2_data_intmax_fl( \
+		__FILE__, __LINE__, (category), (repo), (key), (value))
+
+void trace2_data_json_fl(const char *file, int line,
+			 const char *category,
+			 const struct repository *repo,
+			 const char *key,
+			 const struct json_writer *jw);
+
+#define trace2_data_json(category, repo, key, value) \
+	trace2_data_json_fl( \
+		__FILE__, __LINE__, (category), (repo), (key), (value))
+
+/*
+ * Emit a 'printf' event.
+ *
+ * Write an arbitrary formatted message to the TRACE2 targets.  These
+ * text messages should be considered as human-readable strings without
+ * any formatting guidelines.  Post-processors may choose to ignore
+ * them.
+ */
+void trace2_printf_va_fl(const char *file, int line,
+			 const char *fmt, va_list ap);
+
+#define trace2_printf_va(fmt, ap) \
+	trace2_printf_va_fl(__FILE__, __LINE__, (fmt), (ap))
+
+void trace2_printf_fl(const char *file, int line, const char *fmt, ...);
+
+#ifdef HAVE_VARIADIC_MACROS
+#define trace2_printf(...) \
+	trace2_printf_fl(__FILE__, __LINE__, __VA_ARGS__)
+#else
+__attribute__((format (printf, 1, 2)))
+void trace2_printf(const char *fmt, ...);
+#endif
+
+#endif /* TRACE2_H */
diff --git a/trace2/tr2_cfg.c b/trace2/tr2_cfg.c
new file mode 100644
index 0000000000..7b8291010f
--- /dev/null
+++ b/trace2/tr2_cfg.c
@@ -0,0 +1,92 @@
+#include "cache.h"
+#include "config.h"
+#include "tr2_cfg.h"
+
+#define TR2_ENVVAR_CFG_PARAM "GIT_TR2_CONFIG_PARAMS"
+
+static struct strbuf **tr2_cfg_patterns;
+static int tr2_cfg_count_patterns;
+static int tr2_cfg_loaded;
+
+/*
+ * Parse a string containing a comma-delimited list of config keys
+ * or wildcard patterns into a list of strbufs.
+ */
+static int tr2_cfg_load_patterns(void)
+{
+	struct strbuf **s;
+	const char *envvar;
+
+	if (tr2_cfg_loaded)
+		return tr2_cfg_count_patterns;
+	tr2_cfg_loaded = 1;
+
+	envvar = getenv(TR2_ENVVAR_CFG_PARAM);
+	if (!envvar || !*envvar)
+		return tr2_cfg_count_patterns;
+
+	tr2_cfg_patterns = strbuf_split_buf(envvar, strlen(envvar), ',', -1);
+	for (s = tr2_cfg_patterns; *s; s++) {
+		struct strbuf *buf = *s;
+
+		if (buf->len && buf->buf[buf->len - 1] == ',')
+			strbuf_setlen(buf, buf->len - 1);
+		strbuf_trim_trailing_newline(*s);
+		strbuf_trim(*s);
+	}
+
+	tr2_cfg_count_patterns = s - tr2_cfg_patterns;
+	return tr2_cfg_count_patterns;
+}
+
+void tr2_cfg_free_patterns(void)
+{
+	if (tr2_cfg_patterns)
+		strbuf_list_free(tr2_cfg_patterns);
+	tr2_cfg_count_patterns = 0;
+	tr2_cfg_loaded = 0;
+}
+
+struct tr2_cfg_data
+{
+	const char *file;
+	int line;
+};
+
+/*
+ * See if the given config key matches any of our patterns of interest.
+ */
+static int tr2_cfg_cb(const char *key, const char *value, void *d)
+{
+	struct strbuf **s;
+	struct tr2_cfg_data *data = (struct tr2_cfg_data *)d;
+
+	for (s = tr2_cfg_patterns; *s; s++) {
+		struct strbuf *buf = *s;
+		int wm = wildmatch(buf->buf, key, WM_CASEFOLD);
+		if (wm == WM_MATCH) {
+			trace2_def_param_fl(data->file, data->line, key, value);
+			return 0;
+		}
+	}
+
+	return 0;
+}
+
+void tr2_cfg_list_config_fl(const char *file, int line)
+{
+	struct tr2_cfg_data data = { file, line };
+
+	if (tr2_cfg_load_patterns() > 0)
+		read_early_config(tr2_cfg_cb, &data);
+}
+
+void tr2_cfg_set_fl(const char *file, int line,
+		    const char *key, const char *value)
+{
+	struct tr2_cfg_data data = { file, line };
+
+	if (tr2_cfg_load_patterns() > 0)
+		tr2_cfg_cb(key, value, &data);
+}
+
diff --git a/trace2/tr2_cfg.h b/trace2/tr2_cfg.h
new file mode 100644
index 0000000000..0e7ca4eace
--- /dev/null
+++ b/trace2/tr2_cfg.h
@@ -0,0 +1,19 @@
+#ifndef TR2_CFG_H
+#define TR2_CFG_H
+
+/*
+ * Iterate over all config settings and emit 'def_param' events for the
+ * "interesting" ones to TRACE2.
+ */
+void tr2_cfg_list_config_fl(const char *file, int line);
+
+/*
+ * Emit a "def_param" event for the given key/value pair IF we consider
+ * the key to be "interesting".
+ */
+void tr2_cfg_set_fl(const char *file, int line,
+		    const char *key, const char *value);
+
+void tr2_cfg_free_patterns(void);
+
+#endif /* TR2_CFG_H */
diff --git a/trace2/tr2_dst.c b/trace2/tr2_dst.c
new file mode 100644
index 0000000000..485b2f8851
--- /dev/null
+++ b/trace2/tr2_dst.c
@@ -0,0 +1,90 @@
+#include "cache.h"
+#include "trace2/tr2_dst.h"
+
+void tr2_dst_trace_disable(struct tr2_dst *dst)
+{
+	if (dst->need_close)
+		close(dst->fd);
+	dst->fd = 0;
+	dst->initialized = 1;
+	dst->need_close = 0;
+}
+
+int tr2_dst_get_trace_fd(struct tr2_dst *dst)
+{
+	const char *trace;
+
+	/* don't open twice */
+	if (dst->initialized)
+		return dst->fd;
+
+	trace = getenv(dst->env_var_name);
+
+	if (!trace || !strcmp(trace, "") ||
+	    !strcmp(trace, "0") || !strcasecmp(trace, "false"))
+		dst->fd = 0;
+	else if (!strcmp(trace, "1") || !strcasecmp(trace, "true"))
+		dst->fd = STDERR_FILENO;
+	else if (strlen(trace) == 1 && isdigit(*trace))
+		dst->fd = atoi(trace);
+	else if (is_absolute_path(trace)) {
+		int fd = open(trace, O_WRONLY | O_APPEND | O_CREAT, 0666);
+		if (fd == -1) {
+			/*
+			 * Silently eat the error and disable tracing on this
+			 * destination.  This will cause us to lose events,
+			 * but that is better than causing a stream of warnings
+			 * for each git command they run.
+			 *
+			 * warning("could not open '%s' for tracing: %s",
+			 *         trace, strerror(errno));
+			 */
+			tr2_dst_trace_disable(dst);
+		} else {
+			dst->fd = fd;
+			dst->need_close = 1;
+		}
+	} else {
+		warning("unknown trace value for '%s': %s\n"
+			"         If you want to trace into a file, then please set %s\n"
+			"         to an absolute pathname (starting with /)",
+			dst->env_var_name, trace, dst->env_var_name);
+		tr2_dst_trace_disable(dst);
+	}
+
+	dst->initialized = 1;
+	return dst->fd;
+}
+
+int tr2_dst_trace_want(struct tr2_dst *dst)
+{
+	return !!tr2_dst_get_trace_fd(dst);
+}
+
+void tr2_dst_write_line(struct tr2_dst *dst, struct strbuf *buf_line)
+{
+	strbuf_complete_line(buf_line); /* ensure final NL on buffer */
+
+	/*
+	 * We do not use write_in_full() because we do not want
+	 * a short-write to try again.  We are using O_APPEND mode
+	 * files and the kernel handles the atomic seek+write. If
+	 * another thread or git process is concurrently writing to
+	 * this fd or file, our remainder-write may not be contiguous
+	 * with our initial write of this message.  And that will
+	 * confuse readers.  So just don't bother.
+	 *
+	 * It is assumed that TRACE2 messages are short enough that
+	 * the system can write them in 1 attempt and we won't see
+	 * a short-write.
+	 *
+	 * If we get an IO error, just close the trace dst.
+	 */
+
+	if (write(tr2_dst_get_trace_fd(dst),
+		  buf_line->buf, buf_line->len) < 0) {
+		warning("unable to write trace for '%s': %s",
+			dst->env_var_name, strerror(errno));
+		tr2_dst_trace_disable(dst);
+	}
+}
diff --git a/trace2/tr2_dst.h b/trace2/tr2_dst.h
new file mode 100644
index 0000000000..3eea3f2d1a
--- /dev/null
+++ b/trace2/tr2_dst.h
@@ -0,0 +1,34 @@
+#ifndef TR2_DST_H
+#define TR2_DST_H
+
+struct tr2_dst {
+	const char * const env_var_name;
+	int fd;
+	unsigned int initialized : 1;
+	unsigned int  need_close : 1;
+};
+
+/*
+ * Disable TRACE2 on the destination.  In TRACE2 a destination (DST)
+ * wraps a file descriptor; it is associated with a TARGET which
+ * defines the formatting.
+ */
+void tr2_dst_trace_disable(struct tr2_dst *dst);
+
+/*
+ * Return the file descriptor for the DST.
+ * If 0, the dst is closed or disabled.
+ */
+int tr2_dst_get_trace_fd(struct tr2_dst *dst);
+
+/*
+ * Return true if the DST is opened for writing.
+ */
+int tr2_dst_trace_want(struct tr2_dst *dst);
+
+/*
+ * Write a single line/message to the trace file.
+ */
+void tr2_dst_write_line(struct tr2_dst *dst, struct strbuf *buf_line);
+
+#endif /* TR2_DST_H */
diff --git a/trace2/tr2_sid.c b/trace2/tr2_sid.c
new file mode 100644
index 0000000000..43e8a3e184
--- /dev/null
+++ b/trace2/tr2_sid.c
@@ -0,0 +1,67 @@
+#include "cache.h"
+#include "trace2/tr2_sid.h"
+
+#define TR2_ENVVAR_PARENT_SID "GIT_TR2_PARENT_SID"
+
+static struct strbuf tr2sid_buf = STRBUF_INIT;
+static int tr2sid_nr_git_parents;
+
+/*
+ * Compute a "unique" session id (SID) for the current process.  This allows
+ * all events from this process to have a single label (much like a PID).
+ *
+ * Export this into our environment so that all child processes inherit it.
+ *
+ * If we were started by another git instance, use our parent's SID as a
+ * prefix.  (This lets us track parent/child relationships even if there
+ * is an intermediate shell process.)
+ *
+ * Additionally, count the number of nested git processes.
+ */
+static void tr2_sid_compute(void)
+{
+	uint64_t us_now;
+	const char *parent_sid;
+
+	if (tr2sid_buf.len)
+		return;
+
+	parent_sid = getenv(TR2_ENVVAR_PARENT_SID);
+	if (parent_sid && *parent_sid) {
+		const char *p;
+		for (p = parent_sid; *p; p++)
+			if (*p == '/')
+				tr2sid_nr_git_parents++;
+
+		strbuf_addstr(&tr2sid_buf, parent_sid);
+		strbuf_addch(&tr2sid_buf, '/');
+		tr2sid_nr_git_parents++;
+	}
+
+	us_now = getnanotime() / 1000;
+	strbuf_addf(&tr2sid_buf, "%"PRIuMAX"-%"PRIdMAX,
+		    (uintmax_t)us_now, (intmax_t)getpid());
+
+	setenv(TR2_ENVVAR_PARENT_SID, tr2sid_buf.buf, 1);
+}
+
+const char *tr2_sid_get(void)
+{
+	if (!tr2sid_buf.len)
+		tr2_sid_compute();
+
+	return tr2sid_buf.buf;
+}
+
+int tr2_sid_depth(void)
+{
+	if (!tr2sid_buf.len)
+		tr2_sid_compute();
+
+	return tr2sid_nr_git_parents;
+}
+
+void tr2_sid_release(void)
+{
+	strbuf_release(&tr2sid_buf);
+}
diff --git a/trace2/tr2_sid.h b/trace2/tr2_sid.h
new file mode 100644
index 0000000000..9bef321708
--- /dev/null
+++ b/trace2/tr2_sid.h
@@ -0,0 +1,18 @@
+#ifndef TR2_SID_H
+#define TR2_SID_H
+
+/*
+ * Get our session id. Compute if necessary.
+ */
+const char *tr2_sid_get(void);
+
+/*
+ * Get our process depth.  A top-level git process invoked from the
+ * command line will have depth=0.  A child git process will have
+ * depth=1 and so on.
+ */
+int tr2_sid_depth(void);
+
+void tr2_sid_release(void);
+
+#endif /* TR2_SID_H */
diff --git a/trace2/tr2_tbuf.c b/trace2/tr2_tbuf.c
new file mode 100644
index 0000000000..452b4d0520
--- /dev/null
+++ b/trace2/tr2_tbuf.c
@@ -0,0 +1,32 @@
+#include "cache.h"
+#include "tr2_tbuf.h"
+
+void tr2_tbuf_local_time(struct tr2_tbuf *tb)
+{
+	struct timeval tv;
+	struct tm tm;
+	time_t secs;
+
+	gettimeofday(&tv, NULL);
+	secs = tv.tv_sec;
+	localtime_r(&secs, &tm);
+
+	xsnprintf(tb->buf, sizeof(tb->buf), "%02d:%02d:%02d.%06ld",
+		  tm.tm_hour, tm.tm_min, tm.tm_sec, (long)tv.tv_usec);
+}
+
+void tr2_tbuf_utc_time(struct tr2_tbuf *tb)
+{
+	struct timeval tv;
+	struct tm tm;
+	time_t secs;
+
+	gettimeofday(&tv, NULL);
+	secs = tv.tv_sec;
+	gmtime_r(&secs, &tm);
+
+	xsnprintf(tb->buf, sizeof(tb->buf), "%4d-%02d-%02d %02d:%02d:%02d.%06ld",
+		  tm.tm_year+1900, tm.tm_mon+1, tm.tm_mday,
+		  tm.tm_hour, tm.tm_min, tm.tm_sec, (long)tv.tv_usec);
+}
+
diff --git a/trace2/tr2_tbuf.h b/trace2/tr2_tbuf.h
new file mode 100644
index 0000000000..9cdefa3957
--- /dev/null
+++ b/trace2/tr2_tbuf.h
@@ -0,0 +1,23 @@
+#ifndef TR2_TBUF_H
+#define TR2_TBUF_H
+
+/*
+ * A simple wrapper around a fixed buffer to avoid C syntax
+ * quirks and the need to pass around an additional size_t
+ * argument.
+ */
+struct tr2_tbuf {
+	char buf[32];
+};
+
+/*
+ * Fill buffer with formatted local time string.
+ */
+void tr2_tbuf_local_time(struct tr2_tbuf *tb);
+
+/*
+ * Fill buffer with formatted UTC time string.
+ */
+void tr2_tbuf_utc_time(struct tr2_tbuf *tb);
+
+#endif /* TR2_TBUF_H */
diff --git a/trace2/tr2_tgt.h b/trace2/tr2_tgt.h
new file mode 100644
index 0000000000..4fdf253b57
--- /dev/null
+++ b/trace2/tr2_tgt.h
@@ -0,0 +1,126 @@
+#ifndef TR2_TGT_H
+#define TR2_TGT_H
+
+/*
+ * Function prototypes for a TRACE2 "target" vtable.
+ */
+
+typedef int (tr2_tgt_init_t)(void);
+typedef void (tr2_tgt_term_t)(void);
+
+typedef void (tr2_tgt_evt_version_fl_t)
+	(const char *file, int line);
+
+typedef void (tr2_tgt_evt_start_fl_t)
+	(const char *file, int line, const char **argv);
+typedef void (tr2_tgt_evt_exit_fl_t)
+	(const char *file, int line, uint64_t us_elapsed_absolute, int code);
+typedef void (tr2_tgt_evt_signal_t)
+	(uint64_t us_elapsed_absolute, int signo);
+typedef void (tr2_tgt_evt_atexit_t)
+	(uint64_t us_elapsed_absolute, int code);
+
+typedef void (tr2_tgt_evt_error_va_fl_t)
+	(const char *file, int line, const char *fmt, va_list ap);
+
+typedef void (tr2_tgt_evt_command_path_fl_t)
+	(const char *file, int line, const char *command_path);
+typedef void (tr2_tgt_evt_command_verb_fl_t)
+	(const char *file, int line, const char *command_verb,
+	 const char *hierarchy);
+typedef void (tr2_tgt_evt_command_subverb_fl_t)
+	(const char *file, int line, const char *command_subverb);
+
+typedef void (tr2_tgt_evt_alias_fl_t)
+	(const char *file, int line, const char *alias, const char **argv);
+
+typedef void (tr2_tgt_evt_child_start_fl_t)
+	(const char *file, int line, uint64_t us_elapsed_absolute,
+	 const struct child_process *cmd);
+typedef void (tr2_tgt_evt_child_exit_fl_t)
+	(const char *file, int line, uint64_t us_elapsed_absolute, int cid,
+	 int pid, int code, uint64_t us_elapsed_child);
+
+typedef void (tr2_tgt_evt_thread_start_fl_t)
+	(const char *file, int line, uint64_t us_elapsed_absolute);
+typedef void (tr2_tgt_evt_thread_exit_fl_t)
+	(const char *file, int line, uint64_t us_elapsed_absolute,
+	 uint64_t us_elapsed_thread);
+
+typedef void (tr2_tgt_evt_exec_fl_t)
+	(const char *file, int line, uint64_t us_elapsed_absolute,
+	 int exec_id, const char *exe, const char **argv);
+typedef void (tr2_tgt_evt_exec_result_fl_t)
+	(const char *file, int line, uint64_t us_elapsed_absolute,
+	 int exec_id, int code);
+
+typedef void (tr2_tgt_evt_param_fl_t)
+	(const char *file, int line, const char *param, const char *value);
+
+typedef void (tr2_tgt_evt_repo_fl_t)
+	(const char *file, int line, const struct repository *repo);
+
+typedef void (tr2_tgt_evt_region_enter_printf_va_fl_t)
+	(const char *file, int line, uint64_t us_elapsed_absolute,
+	 const char *category, const char *label, const struct repository *repo,
+	 const char *fmt, va_list ap);
+typedef void (tr2_tgt_evt_region_leave_printf_va_fl_t)
+	(const char *file, int line, uint64_t us_elapsed_absolute,
+	 uint64_t us_elapsed_region, const char *category, const char *label,
+	 const struct repository *repo, const char *fmt, va_list ap);
+
+typedef void (tr2_tgt_evt_data_fl_t)
+	(const char *file, int line, uint64_t us_elapsed_absolute,
+	 uint64_t us_elapsed_region, const char *category,
+	 const struct repository *repo, const char *key, const char *value);
+typedef void (tr2_tgt_evt_data_json_fl_t)
+	(const char *file, int line, uint64_t us_elapsed_absolute,
+	 uint64_t us_elapsed_region, const char *category,
+	 const struct repository *repo,
+	 const char *key, const struct json_writer *value);
+
+typedef void (tr2_tgt_evt_printf_va_fl_t)
+	(const char *file, int line, uint64_t us_elapsed_absolute,
+	 const char *fmt, va_list ap);
+
+/*
+ * "vtable" for a TRACE2 target.  Use NULL if a target does not want
+ * to emit that message.
+ */
+struct tr2_tgt
+{
+	struct tr2_dst                          *pdst;
+
+	tr2_tgt_init_t                          *pfn_init;
+	tr2_tgt_term_t                          *pfn_term;
+
+	tr2_tgt_evt_version_fl_t                *pfn_version_fl;
+	tr2_tgt_evt_start_fl_t                  *pfn_start_fl;
+	tr2_tgt_evt_exit_fl_t                   *pfn_exit_fl;
+	tr2_tgt_evt_signal_t                    *pfn_signal;
+	tr2_tgt_evt_atexit_t                    *pfn_atexit;
+	tr2_tgt_evt_error_va_fl_t               *pfn_error_va_fl;
+	tr2_tgt_evt_command_path_fl_t           *pfn_command_path_fl;
+	tr2_tgt_evt_command_verb_fl_t           *pfn_command_verb_fl;
+	tr2_tgt_evt_command_subverb_fl_t        *pfn_command_subverb_fl;
+	tr2_tgt_evt_alias_fl_t                  *pfn_alias_fl;
+	tr2_tgt_evt_child_start_fl_t            *pfn_child_start_fl;
+	tr2_tgt_evt_child_exit_fl_t             *pfn_child_exit_fl;
+	tr2_tgt_evt_thread_start_fl_t           *pfn_thread_start_fl;
+	tr2_tgt_evt_thread_exit_fl_t            *pfn_thread_exit_fl;
+	tr2_tgt_evt_exec_fl_t                   *pfn_exec_fl;
+	tr2_tgt_evt_exec_result_fl_t            *pfn_exec_result_fl;
+	tr2_tgt_evt_param_fl_t                  *pfn_param_fl;
+	tr2_tgt_evt_repo_fl_t                   *pfn_repo_fl;
+	tr2_tgt_evt_region_enter_printf_va_fl_t *pfn_region_enter_printf_va_fl;
+	tr2_tgt_evt_region_leave_printf_va_fl_t *pfn_region_leave_printf_va_fl;
+	tr2_tgt_evt_data_fl_t                   *pfn_data_fl;
+	tr2_tgt_evt_data_json_fl_t              *pfn_data_json_fl;
+	tr2_tgt_evt_printf_va_fl_t              *pfn_printf_va_fl;
+};
+
+extern struct tr2_tgt tr2_tgt_event;
+extern struct tr2_tgt tr2_tgt_normal;
+extern struct tr2_tgt tr2_tgt_perf;
+
+#endif /* TR2_TGT_H */
diff --git a/trace2/tr2_tgt_event.c b/trace2/tr2_tgt_event.c
new file mode 100644
index 0000000000..495171ae6d
--- /dev/null
+++ b/trace2/tr2_tgt_event.c
@@ -0,0 +1,606 @@
+#include "cache.h"
+#include "config.h"
+#include "json-writer.h"
+#include "run-command.h"
+#include "version.h"
+#include "trace2/tr2_dst.h"
+#include "trace2/tr2_tbuf.h"
+#include "trace2/tr2_sid.h"
+#include "trace2/tr2_tgt.h"
+#include "trace2/tr2_tls.h"
+
+static struct tr2_dst tr2dst_event  = { "GIT_TR2_EVENT", 0, 0, 0 };
+
+/*
+ * The version number of the JSON data generated by the EVENT target
+ * in this source file.  Update this if you make a significant change
+ * to the JSON fields or message structure.  You probably do not need
+ * to update this if you just add another call to one of the existing
+ * TRACE2 API methods.
+ */
+#define TR2_EVENT_VERSION "1"
+
+/*
+ * Region nesting limit for messages written to the event target.
+ *
+ * The "region_enter" and "region_leave" messages (especially recursive
+ * messages such as those produced while diving the worktree or index)
+ * are primarily intended for the performance target during debugging.
+ *
+ * Some of the outer-most messages, however, may be of interest to the
+ * event target.  Set this environment variable to a larger integer for
+ * more detail in the event target.
+ */
+#define TR2_ENVVAR_EVENT_NESTING "GIT_TR2_EVENT_NESTING"
+static int tr2env_event_nesting_wanted = 2;
+
+/*
+ * Set this environment variable to true to omit the <time>, <file>, and
+ * <line> fields from most events.
+ */
+#define TR2_ENVVAR_EVENT_BRIEF "GIT_TR2_EVENT_BRIEF"
+static int tr2env_event_brief;
+
+static int fn_init(void)
+{
+	int want = tr2_dst_trace_want(&tr2dst_event);
+	int want_nesting;
+	int want_brief;
+	char *nesting;
+	char *brief;
+
+	if (!want)
+		return want;
+
+	nesting = getenv(TR2_ENVVAR_EVENT_NESTING);
+	if (nesting && ((want_nesting = atoi(nesting)) > 0))
+		tr2env_event_nesting_wanted = want_nesting;
+
+	brief = getenv(TR2_ENVVAR_EVENT_BRIEF);
+	if (brief && ((want_brief = atoi(brief)) > 0))
+		tr2env_event_brief = want_brief;
+
+	return want;
+}
+
+static void fn_term(void)
+{
+	tr2_dst_trace_disable(&tr2dst_event);
+}
+
+/*
+ * Append common key-value pairs to the currently open JSON object.
+ *     "event:"<event_name>"
+ *      "sid":"<sid>"
+ *   "thread":"<thread_name>"
+ *     "time":"<time>"
+ *     "file":"<filename>"
+ *     "line":<line_number>
+ *     "repo":<repo_id>
+ */
+static void event_fmt_prepare(const char *event_name,
+			      const char *file, int line,
+			      const struct repository *repo,
+			      struct json_writer *jw)
+{
+	struct tr2tls_thread_ctx *ctx = tr2tls_get_self();
+	struct tr2_tbuf tb_now;
+
+	jw_object_string(jw, "event", event_name);
+	jw_object_string(jw, "sid", tr2_sid_get());
+	jw_object_string(jw, "thread", ctx->thread_name.buf);
+
+	/*
+	 * In brief mode, only emit <time> on these 2 event types.
+	 */
+	if (!tr2env_event_brief ||
+	    !strcmp(event_name, "version") ||
+	    !strcmp(event_name, "atexit")) {
+		tr2_tbuf_utc_time(&tb_now);
+		jw_object_string(jw, "time", tb_now.buf);
+	}
+
+	if (!tr2env_event_brief && file && *file) {
+		jw_object_string(jw, "file", file);
+		jw_object_intmax(jw, "line", line);
+	}
+
+	if (repo)
+		jw_object_intmax(jw, "repo", repo->trace2_repo_id);
+}
+
+static void fn_version_fl(const char *file, int line)
+{
+	const char *event_name = "version";
+	struct json_writer jw = JSON_WRITER_INIT;
+
+	jw_object_begin(&jw, 0);
+	event_fmt_prepare(event_name, file, line, NULL, &jw);
+	jw_object_string(&jw, "evt", TR2_EVENT_VERSION);
+	jw_object_string(&jw, "exe", git_version_string);
+	jw_end(&jw);
+
+	tr2_dst_write_line(&tr2dst_event, &jw.json);
+	jw_release(&jw);
+}
+
+static void fn_start_fl(const char *file, int line, const char **argv)
+{
+	const char *event_name = "start";
+	struct json_writer jw = JSON_WRITER_INIT;
+
+	jw_object_begin(&jw, 0);
+	event_fmt_prepare(event_name, file, line, NULL, &jw);
+	jw_object_inline_begin_array(&jw, "argv");
+	jw_array_argv(&jw, argv);
+	jw_end(&jw);
+	jw_end(&jw);
+
+	tr2_dst_write_line(&tr2dst_event, &jw.json);
+	jw_release(&jw);
+}
+
+static void fn_exit_fl(const char *file, int line,
+		       uint64_t us_elapsed_absolute, int code)
+{
+	const char *event_name = "exit";
+	struct json_writer jw = JSON_WRITER_INIT;
+	double t_abs = (double)us_elapsed_absolute / 1000000.0;
+
+	jw_object_begin(&jw, 0);
+	event_fmt_prepare(event_name, file, line, NULL, &jw);
+	jw_object_double(&jw, "t_abs", 6, t_abs);
+	jw_object_intmax(&jw, "code", code);
+	jw_end(&jw);
+
+	tr2_dst_write_line(&tr2dst_event, &jw.json);
+	jw_release(&jw);
+}
+
+static void fn_signal(uint64_t us_elapsed_absolute, int signo)
+{
+	const char *event_name = "signal";
+	struct json_writer jw = JSON_WRITER_INIT;
+	double t_abs = (double)us_elapsed_absolute / 1000000.0;
+
+	jw_object_begin(&jw, 0);
+	event_fmt_prepare(event_name, __FILE__, __LINE__, NULL, &jw);
+	jw_object_double(&jw, "t_abs", 6, t_abs);
+	jw_object_intmax(&jw, "signo", signo);
+	jw_end(&jw);
+
+	tr2_dst_write_line(&tr2dst_event, &jw.json);
+	jw_release(&jw);
+}
+
+static void fn_atexit(uint64_t us_elapsed_absolute, int code)
+{
+	const char *event_name = "atexit";
+	struct json_writer jw = JSON_WRITER_INIT;
+	double t_abs = (double)us_elapsed_absolute / 1000000.0;
+
+	jw_object_begin(&jw, 0);
+	event_fmt_prepare(event_name, __FILE__, __LINE__, NULL, &jw);
+	jw_object_double(&jw, "t_abs", 6, t_abs);
+	jw_object_intmax(&jw, "code", code);
+	jw_end(&jw);
+
+	tr2_dst_write_line(&tr2dst_event, &jw.json);
+	jw_release(&jw);
+}
+
+static void maybe_add_string_va(struct json_writer *jw,
+				const char *field_name,
+				const char *fmt, va_list ap)
+{
+	if (fmt && *fmt && ap) {
+		va_list copy_ap;
+		struct strbuf buf = STRBUF_INIT;
+
+		va_copy(copy_ap, ap);
+		strbuf_vaddf(&buf, fmt, copy_ap);
+		va_end(copy_ap);
+
+		jw_object_string(jw, field_name, buf.buf);
+		strbuf_release(&buf);
+		return;
+	}
+
+	if (fmt && *fmt) {
+		jw_object_string(jw, field_name, fmt);
+		return;
+	}
+}
+
+static void fn_error_va_fl(const char *file, int line,
+			   const char *fmt, va_list ap)
+{
+	const char *event_name = "error";
+	struct json_writer jw = JSON_WRITER_INIT;
+
+	jw_object_begin(&jw, 0);
+	event_fmt_prepare(event_name, file, line, NULL, &jw);
+	maybe_add_string_va(&jw, "msg", fmt, ap);
+	/*
+	 * Also emit the format string as a field in case
+	 * post-processors want to aggregate common error
+	 * messages by type without argument fields (such
+	 * as pathnames or branch names) cluttering it up.
+	 */
+	if (fmt && *fmt)
+		jw_object_string(&jw, "fmt", fmt);
+	jw_end(&jw);
+
+	tr2_dst_write_line(&tr2dst_event, &jw.json);
+	jw_release(&jw);
+}
+
+static void fn_command_path_fl(const char *file, int line,
+			       const char *pathname)
+{
+	const char *event_name = "cmd_path";
+	struct json_writer jw = JSON_WRITER_INIT;
+
+	jw_object_begin(&jw, 0);
+	event_fmt_prepare(event_name, file, line, NULL, &jw);
+	jw_object_string(&jw, "path", pathname);
+	jw_end(&jw);
+
+	tr2_dst_write_line(&tr2dst_event, &jw.json);
+	jw_release(&jw);
+}
+
+static void fn_command_verb_fl(const char *file, int line,
+			       const char *command_verb,
+			       const char *verb_hierarchy)
+{
+	const char *event_name = "cmd_verb";
+	struct json_writer jw = JSON_WRITER_INIT;
+
+	jw_object_begin(&jw, 0);
+	event_fmt_prepare(event_name, file, line, NULL, &jw);
+	jw_object_string(&jw, "name", command_verb);
+	if (verb_hierarchy && *verb_hierarchy)
+		jw_object_string(&jw, "hierarchy", verb_hierarchy);
+	jw_end(&jw);
+
+	tr2_dst_write_line(&tr2dst_event, &jw.json);
+	jw_release(&jw);
+}
+
+static void fn_command_subverb_fl(const char *file, int line,
+			       const char *command_subverb)
+{
+	const char *event_name = "cmd_subverb";
+	struct json_writer jw = JSON_WRITER_INIT;
+
+	jw_object_begin(&jw, 0);
+	event_fmt_prepare(event_name, file, line, NULL, &jw);
+	jw_object_string(&jw, "name", command_subverb);
+	jw_end(&jw);
+
+	tr2_dst_write_line(&tr2dst_event, &jw.json);
+	jw_release(&jw);
+}
+
+static void fn_alias_fl(const char *file, int line,
+			const char *alias, const char **argv)
+{
+	const char *event_name = "alias";
+	struct json_writer jw = JSON_WRITER_INIT;
+
+	jw_object_begin(&jw, 0);
+	event_fmt_prepare(event_name, file, line, NULL, &jw);
+	jw_object_string(&jw, "alias", alias);
+	jw_object_inline_begin_array(&jw, "argv");
+	jw_array_argv(&jw, argv);
+	jw_end(&jw);
+	jw_end(&jw);
+
+	tr2_dst_write_line(&tr2dst_event, &jw.json);
+	jw_release(&jw);
+}
+
+static void fn_child_start_fl(const char *file, int line,
+			      uint64_t us_elapsed_absolute,
+			      const struct child_process *cmd)
+{
+	const char *event_name = "child_start";
+	struct json_writer jw = JSON_WRITER_INIT;
+
+	jw_object_begin(&jw, 0);
+	event_fmt_prepare(event_name, file, line, NULL, &jw);
+	jw_object_intmax(&jw, "child_id", cmd->trace2_child_id);
+	if (cmd->trace2_hook_name) {
+		jw_object_string(&jw, "child_class", "hook");
+		jw_object_string(&jw, "hook_name", cmd->trace2_hook_name);
+	} else {
+		const char *child_class = ((cmd->trace2_child_class) ?
+					   cmd->trace2_child_class : "?");
+		jw_object_string(&jw, "child_class", child_class);
+	}
+	if (cmd->dir)
+		jw_object_string(&jw, "cd", cmd->dir);
+	jw_object_bool(&jw, "use_shell", cmd->use_shell);
+	jw_object_inline_begin_array(&jw, "argv");
+	if (cmd->git_cmd)
+		jw_array_string(&jw, "git");
+	jw_array_argv(&jw, cmd->argv);
+	jw_end(&jw);
+	jw_end(&jw);
+
+	tr2_dst_write_line(&tr2dst_event, &jw.json);
+	jw_release(&jw);
+}
+
+static void fn_child_exit_fl(const char *file, int line,
+			     uint64_t us_elapsed_absolute,
+			     int cid, int pid, int code,
+			     uint64_t us_elapsed_child)
+{
+	const char *event_name = "child_exit";
+	struct json_writer jw = JSON_WRITER_INIT;
+	double t_rel = (double)us_elapsed_child / 1000000.0;
+
+	jw_object_begin(&jw, 0);
+	event_fmt_prepare(event_name, file, line, NULL, &jw);
+	jw_object_intmax(&jw, "child_id", cid);
+	jw_object_intmax(&jw, "pid", pid);
+	jw_object_intmax(&jw, "code", code);
+	jw_object_double(&jw, "t_rel", 6, t_rel);
+	jw_end(&jw);
+
+	tr2_dst_write_line(&tr2dst_event, &jw.json);
+
+	jw_release(&jw);
+}
+
+static void fn_thread_start_fl(const char *file, int line,
+			       uint64_t us_elapsed_absolute)
+{
+	const char *event_name = "thread_start";
+	struct json_writer jw = JSON_WRITER_INIT;
+
+	jw_object_begin(&jw, 0);
+	event_fmt_prepare(event_name, file, line, NULL, &jw);
+	jw_end(&jw);
+
+	tr2_dst_write_line(&tr2dst_event, &jw.json);
+	jw_release(&jw);
+}
+
+static void fn_thread_exit_fl(const char *file, int line,
+			      uint64_t us_elapsed_absolute,
+			      uint64_t us_elapsed_thread)
+{
+	const char *event_name = "thread_exit";
+	struct json_writer jw = JSON_WRITER_INIT;
+	double t_rel = (double)us_elapsed_thread / 1000000.0;
+
+	jw_object_begin(&jw, 0);
+	event_fmt_prepare(event_name, file, line, NULL, &jw);
+	jw_object_double(&jw, "t_rel", 6, t_rel);
+	jw_end(&jw);
+
+	tr2_dst_write_line(&tr2dst_event, &jw.json);
+	jw_release(&jw);
+}
+
+static void fn_exec_fl(const char *file, int line,
+		       uint64_t us_elapsed_absolute,
+		       int exec_id, const char *exe, const char **argv)
+{
+	const char *event_name = "exec";
+	struct json_writer jw = JSON_WRITER_INIT;
+
+	jw_object_begin(&jw, 0);
+	event_fmt_prepare(event_name, file, line, NULL, &jw);
+	jw_object_intmax(&jw, "exec_id", exec_id);
+	if (exe)
+		jw_object_string(&jw, "exe", exe);
+	jw_object_inline_begin_array(&jw, "argv");
+	jw_array_argv(&jw, argv);
+	jw_end(&jw);
+	jw_end(&jw);
+
+	tr2_dst_write_line(&tr2dst_event, &jw.json);
+	jw_release(&jw);
+}
+
+static void fn_exec_result_fl(const char *file, int line,
+			      uint64_t us_elapsed_absolute,
+			      int exec_id, int code)
+{
+	const char *event_name = "exec_result";
+	struct json_writer jw = JSON_WRITER_INIT;
+
+	jw_object_begin(&jw, 0);
+	event_fmt_prepare(event_name, file, line, NULL, &jw);
+	jw_object_intmax(&jw, "exec_id", exec_id);
+	jw_object_intmax(&jw, "code", code);
+	jw_end(&jw);
+
+	tr2_dst_write_line(&tr2dst_event, &jw.json);
+	jw_release(&jw);
+}
+
+static void fn_param_fl(const char *file, int line,
+			const char *param, const char *value)
+{
+	const char *event_name = "def_param";
+	struct json_writer jw = JSON_WRITER_INIT;
+
+	jw_object_begin(&jw, 0);
+	event_fmt_prepare(event_name, file, line, NULL, &jw);
+	jw_object_string(&jw, "param", param);
+	jw_object_string(&jw, "value", value);
+	jw_end(&jw);
+
+	tr2_dst_write_line(&tr2dst_event, &jw.json);
+	jw_release(&jw);
+}
+
+static void fn_repo_fl(const char *file, int line,
+		       const struct repository *repo)
+{
+	const char *event_name = "def_repo";
+	struct json_writer jw = JSON_WRITER_INIT;
+
+	jw_object_begin(&jw, 0);
+	event_fmt_prepare(event_name, file, line, repo, &jw);
+	jw_object_string(&jw, "worktree", repo->worktree);
+	jw_end(&jw);
+
+	tr2_dst_write_line(&tr2dst_event, &jw.json);
+	jw_release(&jw);
+}
+
+static void fn_region_enter_printf_va_fl(const char *file, int line,
+					 uint64_t us_elapsed_absolute,
+					 const char *category,
+					 const char *label,
+					 const struct repository *repo,
+					 const char *fmt, va_list ap)
+{
+	const char *event_name = "region_enter";
+	struct tr2tls_thread_ctx *ctx = tr2tls_get_self();
+	if (ctx->nr_open_regions <= tr2env_event_nesting_wanted) {
+		struct json_writer jw = JSON_WRITER_INIT;
+
+		jw_object_begin(&jw, 0);
+		event_fmt_prepare(
+			event_name, file, line, repo, &jw);
+		jw_object_intmax(&jw, "nesting", ctx->nr_open_regions);
+		if (category)
+			jw_object_string(&jw, "category", category);
+		if (label)
+			jw_object_string(&jw, "label", label);
+		maybe_add_string_va(&jw, "msg", fmt, ap);
+		jw_end(&jw);
+
+		tr2_dst_write_line(&tr2dst_event, &jw.json);
+		jw_release(&jw);
+	}
+}
+
+static void fn_region_leave_printf_va_fl(const char *file, int line,
+					 uint64_t us_elapsed_absolute,
+					 uint64_t us_elapsed_region,
+					 const char *category,
+					 const char *label,
+					 const struct repository *repo,
+					 const char *fmt, va_list ap)
+{
+	const char *event_name = "region_leave";
+	struct tr2tls_thread_ctx *ctx = tr2tls_get_self();
+	if (ctx->nr_open_regions <= tr2env_event_nesting_wanted) {
+		struct json_writer jw = JSON_WRITER_INIT;
+		double t_rel = (double)us_elapsed_region / 1000000.0;
+
+		jw_object_begin(&jw, 0);
+		event_fmt_prepare(event_name, file, line, repo, &jw);
+		jw_object_double(&jw, "t_rel", 6, t_rel);
+		jw_object_intmax(&jw, "nesting", ctx->nr_open_regions);
+		if (category)
+			jw_object_string(&jw, "category", category);
+		if (label)
+			jw_object_string(&jw, "label", label);
+		maybe_add_string_va(&jw, "msg", fmt, ap);
+		jw_end(&jw);
+
+		tr2_dst_write_line(&tr2dst_event, &jw.json);
+		jw_release(&jw);
+	}
+}
+
+static void fn_data_fl(const char *file, int line,
+		       uint64_t us_elapsed_absolute,
+		       uint64_t us_elapsed_region,
+		       const char *category,
+		       const struct repository *repo,
+		       const char *key,
+		       const char *value)
+{
+	const char *event_name = "data";
+	struct tr2tls_thread_ctx *ctx = tr2tls_get_self();
+	if (ctx->nr_open_regions <= tr2env_event_nesting_wanted) {
+		struct json_writer jw = JSON_WRITER_INIT;
+		double t_abs = (double)us_elapsed_absolute / 1000000.0;
+		double t_rel = (double)us_elapsed_region / 1000000.0;
+
+		jw_object_begin(&jw, 0);
+		event_fmt_prepare(event_name, file, line, repo, &jw);
+		jw_object_double(&jw, "t_abs", 6, t_abs);
+		jw_object_double(&jw, "t_rel", 6, t_rel);
+		jw_object_intmax(&jw, "nesting", ctx->nr_open_regions);
+		jw_object_string(&jw, "category", category);
+		jw_object_string(&jw, "key", key);
+		jw_object_string(&jw, "value", value);
+		jw_end(&jw);
+
+		tr2_dst_write_line(&tr2dst_event, &jw.json);
+		jw_release(&jw);
+	}
+}
+
+static void fn_data_json_fl(const char *file, int line,
+			    uint64_t us_elapsed_absolute,
+			    uint64_t us_elapsed_region,
+			    const char *category,
+			    const struct repository *repo,
+			    const char *key,
+			    const struct json_writer *value)
+{
+	const char *event_name = "data_json";
+	struct tr2tls_thread_ctx *ctx = tr2tls_get_self();
+	if (ctx->nr_open_regions <= tr2env_event_nesting_wanted) {
+		struct json_writer jw = JSON_WRITER_INIT;
+		double t_abs = (double)us_elapsed_absolute / 1000000.0;
+		double t_rel = (double)us_elapsed_region / 1000000.0;
+
+		jw_object_begin(&jw, 0);
+		event_fmt_prepare(event_name, file, line, repo, &jw);
+		jw_object_double(&jw, "t_abs", 6, t_abs);
+		jw_object_double(&jw, "t_rel", 6, t_rel);
+		jw_object_intmax(&jw, "nesting", ctx->nr_open_regions);
+		jw_object_string(&jw, "category", category);
+		jw_object_string(&jw, "key", key);
+		jw_object_sub_jw(&jw, "value", value);
+		jw_end(&jw);
+
+		tr2_dst_write_line(&tr2dst_event, &jw.json);
+		jw_release(&jw);
+	}
+}
+
+struct tr2_tgt tr2_tgt_event =
+{
+	&tr2dst_event,
+
+	fn_init,
+	fn_term,
+
+	fn_version_fl,
+	fn_start_fl,
+	fn_exit_fl,
+	fn_signal,
+	fn_atexit,
+	fn_error_va_fl,
+	fn_command_path_fl,
+	fn_command_verb_fl,
+	fn_command_subverb_fl,
+	fn_alias_fl,
+	fn_child_start_fl,
+	fn_child_exit_fl,
+	fn_thread_start_fl,
+	fn_thread_exit_fl,
+	fn_exec_fl,
+	fn_exec_result_fl,
+	fn_param_fl,
+	fn_repo_fl,
+	fn_region_enter_printf_va_fl,
+	fn_region_leave_printf_va_fl,
+	fn_data_fl,
+	fn_data_json_fl,
+	NULL, /* printf */
+};
diff --git a/trace2/tr2_tgt_normal.c b/trace2/tr2_tgt_normal.c
new file mode 100644
index 0000000000..602eba5112
--- /dev/null
+++ b/trace2/tr2_tgt_normal.c
@@ -0,0 +1,331 @@
+#include "cache.h"
+#include "config.h"
+#include "run-command.h"
+#include "quote.h"
+#include "version.h"
+#include "trace2/tr2_dst.h"
+#include "trace2/tr2_tbuf.h"
+#include "trace2/tr2_tgt.h"
+#include "trace2/tr2_tls.h"
+
+static struct tr2_dst tr2dst_normal = { "GIT_TR2", 0, 0, 0 };
+
+/*
+ * Set this environment variable to true to omit the "<time> <file>:<line>"
+ * fields from each line written to the builtin normal target.
+ *
+ * Unit tests may want to use this to help with testing.
+ */
+#define TR2_ENVVAR_NORMAL_BRIEF "GIT_TR2_BRIEF"
+static int tr2env_normal_brief;
+
+#define TR2FMT_NORMAL_FL_WIDTH       (50)
+
+static int fn_init(void)
+{
+	int want = tr2_dst_trace_want(&tr2dst_normal);
+	int want_brief;
+	char *brief;
+
+	if (!want)
+		return want;
+
+	brief = getenv(TR2_ENVVAR_NORMAL_BRIEF);
+	if (brief && *brief &&
+	    ((want_brief = git_parse_maybe_bool(brief)) != -1))
+		tr2env_normal_brief = want_brief;
+
+	return want;
+}
+
+static void fn_term(void)
+{
+	tr2_dst_trace_disable(&tr2dst_normal);
+}
+
+static void normal_fmt_prepare(const char *file, int line, struct strbuf *buf)
+{
+	strbuf_setlen(buf,0);
+
+	if (!tr2env_normal_brief) {
+		struct tr2_tbuf tb_now;
+
+		tr2_tbuf_local_time(&tb_now);
+		strbuf_addstr(buf, tb_now.buf);
+		strbuf_addch(buf, ' ');
+
+		if (file && *file)
+			strbuf_addf(buf, "%s:%d ", file, line);
+		while (buf->len < TR2FMT_NORMAL_FL_WIDTH)
+			strbuf_addch(buf, ' ');
+	}
+}
+
+static void normal_io_write_fl(const char *file, int line,
+			       const struct strbuf *buf_payload)
+{
+	struct strbuf buf_line = STRBUF_INIT;
+
+	normal_fmt_prepare(file, line, &buf_line);
+	strbuf_addbuf(&buf_line, buf_payload);
+	tr2_dst_write_line(&tr2dst_normal, &buf_line);
+	strbuf_release(&buf_line);
+}
+
+static void fn_version_fl(const char *file, int line)
+{
+	struct strbuf buf_payload = STRBUF_INIT;
+
+	strbuf_addf(&buf_payload, "version %s", git_version_string);
+	normal_io_write_fl(file, line, &buf_payload);
+	strbuf_release(&buf_payload);
+}
+
+static void fn_start_fl(const char *file, int line, const char **argv)
+{
+	struct strbuf buf_payload = STRBUF_INIT;
+
+	strbuf_addstr(&buf_payload, "start ");
+	sq_quote_argv_pretty(&buf_payload, argv);
+	normal_io_write_fl(file, line, &buf_payload);
+	strbuf_release(&buf_payload);
+}
+
+static void fn_exit_fl(const char *file, int line,
+		       uint64_t us_elapsed_absolute, int code)
+{
+	struct strbuf buf_payload = STRBUF_INIT;
+	double elapsed = (double)us_elapsed_absolute / 1000000.0;
+
+	strbuf_addf(&buf_payload, "exit elapsed:%.6f code:%d",
+		    elapsed, code);
+	normal_io_write_fl(file, line, &buf_payload);
+	strbuf_release(&buf_payload);
+}
+
+static void fn_signal(uint64_t us_elapsed_absolute, int signo)
+{
+	struct strbuf buf_payload = STRBUF_INIT;
+	double elapsed = (double)us_elapsed_absolute / 1000000.0;
+
+	strbuf_addf(&buf_payload, "signal elapsed:%.6f code:%d",
+		    elapsed, signo);
+	normal_io_write_fl(__FILE__, __LINE__, &buf_payload);
+	strbuf_release(&buf_payload);
+}
+
+static void fn_atexit(uint64_t us_elapsed_absolute, int code)
+{
+	struct strbuf buf_payload = STRBUF_INIT;
+	double elapsed = (double)us_elapsed_absolute / 1000000.0;
+
+	strbuf_addf(&buf_payload, "atexit elapsed:%.6f code:%d",
+		    elapsed, code);
+	normal_io_write_fl(__FILE__, __LINE__, &buf_payload);
+	strbuf_release(&buf_payload);
+}
+
+static void maybe_append_string_va(struct strbuf *buf,
+				   const char *fmt, va_list ap)
+{
+	if (fmt && *fmt && ap) {
+		va_list copy_ap;
+
+		va_copy(copy_ap, ap);
+		strbuf_vaddf(buf, fmt, copy_ap);
+		va_end(copy_ap);
+		return;
+	}
+
+	if (fmt && *fmt) {
+		strbuf_addstr(buf, fmt);
+		return;
+	}
+}
+
+static void fn_error_va_fl(const char *file, int line,
+			   const char *fmt, va_list ap)
+{
+	struct strbuf buf_payload = STRBUF_INIT;
+
+	strbuf_addstr(&buf_payload, "error ");
+	maybe_append_string_va(&buf_payload, fmt, ap);
+	normal_io_write_fl(file, line, &buf_payload);
+	strbuf_release(&buf_payload);
+}
+
+static void fn_command_path_fl(const char *file, int line,
+			       const char *pathname)
+{
+	struct strbuf buf_payload = STRBUF_INIT;
+
+	strbuf_addf(&buf_payload, "cmd_path %s", pathname);
+	normal_io_write_fl(file, line, &buf_payload);
+	strbuf_release(&buf_payload);
+}
+
+static void fn_command_verb_fl(const char *file, int line,
+			       const char *command_verb,
+			       const char *verb_hierarchy)
+{
+	struct strbuf buf_payload = STRBUF_INIT;
+
+	strbuf_addf(&buf_payload, "cmd_verb %s", command_verb);
+	if (verb_hierarchy && *verb_hierarchy)
+		strbuf_addf(&buf_payload, " (%s)", verb_hierarchy);
+	normal_io_write_fl(file, line, &buf_payload);
+	strbuf_release(&buf_payload);
+}
+
+static void fn_command_subverb_fl(const char *file, int line,
+			       const char *command_subverb)
+{
+	struct strbuf buf_payload = STRBUF_INIT;
+
+	strbuf_addf(&buf_payload, "cmd_subverb %s", command_subverb);
+	normal_io_write_fl(file, line, &buf_payload);
+	strbuf_release(&buf_payload);
+}
+
+static void fn_alias_fl(const char *file, int line, const char *alias,
+			const char **argv)
+{
+	struct strbuf buf_payload = STRBUF_INIT;
+
+	strbuf_addf(&buf_payload, "alias %s ->", alias);
+	sq_quote_argv_pretty(&buf_payload, argv);
+	normal_io_write_fl(file, line, &buf_payload);
+	strbuf_release(&buf_payload);
+}
+
+static void fn_child_start_fl(const char *file, int line,
+			      uint64_t us_elapsed_absolute,
+			      const struct child_process *cmd)
+{
+	struct strbuf buf_payload = STRBUF_INIT;
+
+	strbuf_addf(&buf_payload, "child_start[%d] ", cmd->trace2_child_id);
+
+	if (cmd->dir) {
+		strbuf_addstr(&buf_payload, " cd");
+		sq_quote_buf_pretty(&buf_payload, cmd->dir);
+		strbuf_addstr(&buf_payload, "; ");
+	}
+
+	/*
+	 * TODO if (cmd->env) { Consider dumping changes to environment. }
+	 * See trace_add_env() in run-command.c as used by original trace.c
+	 */
+
+	if (cmd->git_cmd)
+		strbuf_addstr(&buf_payload, "git");
+	sq_quote_argv_pretty(&buf_payload, cmd->argv);
+
+	normal_io_write_fl(file, line, &buf_payload);
+	strbuf_release(&buf_payload);
+}
+
+static void fn_child_exit_fl(const char *file, int line,
+			     uint64_t us_elapsed_absolute,
+			     int cid, int pid, int code,
+			     uint64_t us_elapsed_child)
+{
+	struct strbuf buf_payload = STRBUF_INIT;
+	double elapsed = (double)us_elapsed_child / 1000000.0;
+
+	strbuf_addf(&buf_payload, "child_exit[%d] pid:%d code:%d elapsed:%.6f",
+		    cid, pid, code, elapsed);
+	normal_io_write_fl(file, line, &buf_payload);
+	strbuf_release(&buf_payload);
+}
+
+static void fn_exec_fl(const char *file, int line,
+		       uint64_t us_elapsed_absolute,
+		       int exec_id, const char *exe, const char **argv)
+{
+	struct strbuf buf_payload = STRBUF_INIT;
+
+	strbuf_addf(&buf_payload, "exec[%d] ", exec_id);
+	if (exe)
+		strbuf_addstr(&buf_payload, exe);
+	sq_quote_argv_pretty(&buf_payload, argv);
+	normal_io_write_fl(file, line, &buf_payload);
+	strbuf_release(&buf_payload);
+}
+
+static void fn_exec_result_fl(const char *file, int line,
+			      uint64_t us_elapsed_absolute,
+			      int exec_id, int code)
+{
+	struct strbuf buf_payload = STRBUF_INIT;
+
+	strbuf_addf(&buf_payload, "exec_result[%d] code:%d", exec_id, code);
+	if (code > 0)
+		strbuf_addf(&buf_payload, " err:%s", strerror(code));
+	normal_io_write_fl(file, line, &buf_payload);
+	strbuf_release(&buf_payload);
+}
+
+static void fn_param_fl(const char *file, int line, const char *param,
+			const char *value)
+{
+	struct strbuf buf_payload = STRBUF_INIT;
+
+	strbuf_addf(&buf_payload, "def_param %s=%s", param, value);
+	normal_io_write_fl(file, line, &buf_payload);
+	strbuf_release(&buf_payload);
+}
+
+static void fn_repo_fl(const char *file, int line,
+		       const struct repository *repo)
+{
+	struct strbuf buf_payload = STRBUF_INIT;
+
+	strbuf_addstr(&buf_payload, "worktree ");
+	sq_quote_buf_pretty(&buf_payload, repo->worktree);
+	normal_io_write_fl(file, line, &buf_payload);
+	strbuf_release(&buf_payload);
+}
+
+static void fn_printf_va_fl(const char *file, int line,
+			    uint64_t us_elapsed_absolute,
+			    const char *fmt, va_list ap)
+{
+	struct strbuf buf_payload = STRBUF_INIT;
+
+	maybe_append_string_va(&buf_payload, fmt, ap);
+	normal_io_write_fl(file, line, &buf_payload);
+	strbuf_release(&buf_payload);
+}
+
+struct tr2_tgt tr2_tgt_normal =
+{
+	&tr2dst_normal,
+
+	fn_init,
+	fn_term,
+
+	fn_version_fl,
+	fn_start_fl,
+	fn_exit_fl,
+	fn_signal,
+	fn_atexit,
+	fn_error_va_fl,
+	fn_command_path_fl,
+	fn_command_verb_fl,
+	fn_command_subverb_fl,
+	fn_alias_fl,
+	fn_child_start_fl,
+	fn_child_exit_fl,
+	NULL, /* thread_start */
+	NULL, /* thread_exit */
+	fn_exec_fl,
+	fn_exec_result_fl,
+	fn_param_fl,
+	fn_repo_fl,
+	NULL, /* region_enter */
+	NULL, /* region_leave */
+	NULL, /* data */
+	NULL, /* data_json */
+	fn_printf_va_fl,
+};
diff --git a/trace2/tr2_tgt_perf.c b/trace2/tr2_tgt_perf.c
new file mode 100644
index 0000000000..035855d883
--- /dev/null
+++ b/trace2/tr2_tgt_perf.c
@@ -0,0 +1,573 @@
+#include "cache.h"
+#include "config.h"
+#include "run-command.h"
+#include "quote.h"
+#include "version.h"
+#include "json-writer.h"
+#include "trace2/tr2_dst.h"
+#include "trace2/tr2_sid.h"
+#include "trace2/tr2_tbuf.h"
+#include "trace2/tr2_tgt.h"
+#include "trace2/tr2_tls.h"
+
+static struct tr2_dst tr2dst_perf   = { "GIT_TR2_PERF", 0, 0, 0 };
+
+/*
+ * Set this environment variable to true to omit the "<time> <file>:<line>"
+ * fields from each line written to the builtin performance target.
+ *
+ * Unit tests may want to use this to help with testing.
+ */
+#define TR2_ENVVAR_PERF_BRIEF "GIT_TR2_PERF_BRIEF"
+static int tr2env_perf_brief;
+
+#define TR2FMT_PERF_FL_WIDTH       (50)
+#define TR2FMT_PERF_MAX_EVENT_NAME (12)
+#define TR2FMT_PERF_REPO_WIDTH     (4)
+#define TR2FMT_PERF_CATEGORY_WIDTH (10)
+
+#define TR2_DOTS_BUFFER_SIZE (100)
+#define TR2_INDENT (2)
+#define TR2_INDENT_LENGTH(ctx) (((ctx)->nr_open_regions - 1) * TR2_INDENT)
+
+static struct strbuf dots = STRBUF_INIT;
+
+static int fn_init(void)
+{
+	int want = tr2_dst_trace_want(&tr2dst_perf);
+	int want_brief;
+	char *brief;
+
+	if (!want)
+		return want;
+
+	strbuf_addchars(&dots, '.', TR2_DOTS_BUFFER_SIZE);
+
+	brief = getenv(TR2_ENVVAR_PERF_BRIEF);
+	if (brief && *brief &&
+	    ((want_brief = git_parse_maybe_bool(brief)) != -1))
+		tr2env_perf_brief = want_brief;
+
+	return want;
+}
+
+static void fn_term(void)
+{
+	tr2_dst_trace_disable(&tr2dst_perf);
+
+	strbuf_release(&dots);
+}
+
+/*
+ * Format trace line prefix in human-readable classic format for
+ * the performance target:
+ *     "[<time> [<file>:<line>] <bar>] <nr_parents> <bar>
+ *         <thread_name> <bar> <event_name> <bar> [<repo>] <bar>
+ *         [<elapsed_absolute>] [<elapsed_relative>] <bar>
+ *         [<category>] <bar> [<dots>] "
+ */
+static void perf_fmt_prepare(
+	const char *event_name, struct tr2tls_thread_ctx *ctx,
+	const char *file, int line, const struct repository *repo,
+	uint64_t *p_us_elapsed_absolute, uint64_t *p_us_elapsed_relative,
+	const char *category, struct strbuf *buf)
+{
+	int len;
+
+	strbuf_setlen(buf,0);
+
+	if (!tr2env_perf_brief) {
+
+		struct tr2_tbuf tb_now;
+
+		tr2_tbuf_local_time(&tb_now);
+		strbuf_addstr(buf, tb_now.buf);
+		strbuf_addch(buf, ' ');
+
+		if (file && *file)
+			strbuf_addf(buf, "%s:%d ", file, line);
+		while (buf->len < TR2FMT_PERF_FL_WIDTH)
+			strbuf_addch(buf, ' ');
+
+		strbuf_addstr(buf, "| ");
+	}
+
+	strbuf_addf(buf, "d%d | ", tr2_sid_depth());
+	strbuf_addf(buf, "%-*s | %-*s | ",
+		    TR2_MAX_THREAD_NAME, ctx->thread_name.buf,
+		    TR2FMT_PERF_MAX_EVENT_NAME, event_name);
+
+	len = buf->len + TR2FMT_PERF_REPO_WIDTH;
+	if (repo)
+		strbuf_addf(buf, "r%d ", repo->trace2_repo_id);
+	while (buf->len < len)
+		strbuf_addch(buf, ' ' );
+	strbuf_addstr(buf, "| ");
+
+	if (p_us_elapsed_absolute)
+		strbuf_addf(buf, "%9.6f | ",
+			    ((double)(*p_us_elapsed_absolute)) / 1000000.0);
+	else
+		strbuf_addf(buf, "%9s | ", " ");
+
+	if (p_us_elapsed_relative)
+		strbuf_addf(buf, "%9.6f | ",
+			    ((double)(*p_us_elapsed_relative)) / 1000000.0);
+	else
+		strbuf_addf(buf, "%9s | ", " ");
+		
+	strbuf_addf(buf, "%-*s | ", TR2FMT_PERF_CATEGORY_WIDTH,
+		    (category ? category : ""));
+
+	if (ctx->nr_open_regions > 0) {
+		int len_indent = TR2_INDENT_LENGTH(ctx);
+		while (len_indent > dots.len) {
+			strbuf_addf(buf, "%s", dots.buf);
+			len_indent -= dots.len;
+		}
+		strbuf_addf(buf, "%.*s", len_indent, dots.buf);
+	}
+}
+
+static void perf_io_write_fl(
+	const char *file, int line,
+	const char *event_name,
+	const struct repository *repo,
+	uint64_t *p_us_elapsed_absolute,
+	uint64_t *p_us_elapsed_relative,
+	const char *category,
+	const struct strbuf *buf_payload)
+{
+	struct tr2tls_thread_ctx *ctx = tr2tls_get_self();
+	struct strbuf buf_line = STRBUF_INIT;
+
+	perf_fmt_prepare(event_name, ctx, file, line, repo,
+			 p_us_elapsed_absolute, p_us_elapsed_relative,
+			 category, &buf_line);
+	strbuf_addbuf(&buf_line, buf_payload);
+	tr2_dst_write_line(&tr2dst_perf, &buf_line);
+	strbuf_release(&buf_line);
+}
+
+static void fn_version_fl(const char *file, int line)
+{
+	const char *event_name = "version";
+	struct strbuf buf_payload = STRBUF_INIT;
+
+	strbuf_addf(&buf_payload, "%s", git_version_string);
+
+	perf_io_write_fl(file, line, event_name, NULL,
+			 NULL, NULL, NULL,
+			 &buf_payload);
+	strbuf_release(&buf_payload);
+}
+
+static void fn_start_fl(const char *file, int line, const char **argv)
+{
+	const char *event_name = "start";
+	struct strbuf buf_payload = STRBUF_INIT;
+
+	sq_quote_argv_pretty(&buf_payload, argv);
+
+	perf_io_write_fl(file, line, event_name, NULL,
+			 NULL, NULL, NULL,
+			 &buf_payload);
+	strbuf_release(&buf_payload);
+}
+
+static void fn_exit_fl(const char *file, int line,
+		       uint64_t us_elapsed_absolute, int code)
+{
+	const char *event_name = "exit";
+	struct strbuf buf_payload = STRBUF_INIT;
+
+	strbuf_addf(&buf_payload, "code:%d", code);
+
+	perf_io_write_fl(file, line, event_name, NULL,
+			 &us_elapsed_absolute, NULL, NULL,
+			 &buf_payload);
+	strbuf_release(&buf_payload);
+}
+
+static void fn_signal(uint64_t us_elapsed_absolute, int signo)
+{
+	const char *event_name = "signal";
+	struct strbuf buf_payload = STRBUF_INIT;
+
+	strbuf_addf(&buf_payload, "signo:%d", signo);
+
+	perf_io_write_fl(__FILE__, __LINE__, event_name, NULL,
+			 &us_elapsed_absolute, NULL, NULL,
+			 &buf_payload);
+	strbuf_release(&buf_payload);
+}
+
+static void fn_atexit(uint64_t us_elapsed_absolute, int code)
+{
+	const char *event_name = "atexit";
+	struct strbuf buf_payload = STRBUF_INIT;
+
+	strbuf_addf(&buf_payload, "code:%d", code);
+
+	perf_io_write_fl(__FILE__, __LINE__, event_name, NULL,
+			 &us_elapsed_absolute, NULL, NULL,
+			 &buf_payload);
+	strbuf_release(&buf_payload);
+}
+
+static void maybe_append_string_va(struct strbuf *buf,
+				   const char *fmt, va_list ap)
+{
+	if (fmt && *fmt && ap) {
+		va_list copy_ap;
+
+		va_copy(copy_ap, ap);
+		strbuf_vaddf(buf, fmt, copy_ap);
+		va_end(copy_ap);
+		return;
+	}
+
+	if (fmt && *fmt) {
+		strbuf_addstr(buf, fmt);
+		return;
+	}
+}
+
+static void fn_error_va_fl(const char *file, int line,
+			   const char *fmt, va_list ap)
+{
+	const char *event_name = "error";
+	struct strbuf buf_payload = STRBUF_INIT;
+
+	maybe_append_string_va(&buf_payload, fmt, ap);
+
+	perf_io_write_fl(file, line, event_name, NULL,
+			 NULL, NULL, NULL,
+			 &buf_payload);
+	strbuf_release(&buf_payload);
+}
+
+static void fn_command_path_fl(const char *file, int line,
+			       const char *pathname)
+{
+	const char *event_name = "cmd_path";
+	struct strbuf buf_payload = STRBUF_INIT;
+
+	strbuf_addstr(&buf_payload, pathname);
+
+	perf_io_write_fl(file, line, event_name, NULL,
+			 NULL, NULL, NULL,
+			 &buf_payload);
+	strbuf_release(&buf_payload);
+}
+
+static void fn_command_verb_fl(const char *file, int line,
+			       const char *command_verb,
+			       const char *verb_hierarchy)
+{
+	const char *event_name = "cmd_verb";
+	struct strbuf buf_payload = STRBUF_INIT;
+
+	strbuf_addstr(&buf_payload, command_verb);
+	if (verb_hierarchy && *verb_hierarchy)
+		strbuf_addf(&buf_payload, " (%s)", verb_hierarchy);
+
+	perf_io_write_fl(file, line, event_name, NULL,
+			 NULL, NULL, NULL,
+			 &buf_payload);
+	strbuf_release(&buf_payload);
+}
+
+static void fn_command_subverb_fl(const char *file, int line,
+			       const char *command_subverb)
+{
+	const char *event_name = "cmd_subverb";
+	struct strbuf buf_payload = STRBUF_INIT;
+
+	strbuf_addstr(&buf_payload, command_subverb);
+
+	perf_io_write_fl(file, line, event_name, NULL,
+			 NULL, NULL, NULL,
+			 &buf_payload);
+	strbuf_release(&buf_payload);
+}
+
+static void fn_alias_fl(const char *file, int line, const char *alias,
+			const char **argv)
+{
+	const char *event_name = "alias";
+	struct strbuf buf_payload = STRBUF_INIT;
+
+	strbuf_addf(&buf_payload, "alias:%s argv:", alias);
+	sq_quote_argv_pretty(&buf_payload, argv);
+
+	perf_io_write_fl(file, line, event_name, NULL,
+			 NULL, NULL, NULL,
+			 &buf_payload);
+	strbuf_release(&buf_payload);
+}
+
+static void fn_child_start_fl(const char *file, int line,
+			      uint64_t us_elapsed_absolute,
+			      const struct child_process *cmd)
+{
+	const char *event_name = "child_start";
+	struct strbuf buf_payload = STRBUF_INIT;
+
+	if (cmd->trace2_hook_name) {
+		strbuf_addf(&buf_payload, "[ch%d] class:hook hook:%s",
+			    cmd->trace2_child_id, cmd->trace2_hook_name);
+	} else {
+		const char *child_class = ((cmd->trace2_child_class) ?
+					   cmd->trace2_child_class : "?");
+		strbuf_addf(&buf_payload, "[ch%d] class:%s",
+			    cmd->trace2_child_id, child_class);
+	}
+
+	if (cmd->dir) {
+		strbuf_addstr(&buf_payload, " cd:");
+		sq_quote_buf_pretty(&buf_payload, cmd->dir);
+	}
+
+	strbuf_addstr(&buf_payload, " argv:");
+	if (cmd->git_cmd)
+		strbuf_addstr(&buf_payload, " git");
+	sq_quote_argv_pretty(&buf_payload, cmd->argv);
+
+	perf_io_write_fl(file, line, event_name, NULL,
+			 &us_elapsed_absolute, NULL, NULL,
+			 &buf_payload);
+	strbuf_release(&buf_payload);
+}
+
+static void fn_child_exit_fl(const char *file, int line,
+			     uint64_t us_elapsed_absolute,
+			     int cid, int pid, int code,
+			     uint64_t us_elapsed_child)
+{
+	const char *event_name = "child_exit";
+	struct strbuf buf_payload = STRBUF_INIT;
+
+	strbuf_addf(&buf_payload, "[ch%d] pid:%d code:%d", cid, pid, code);
+
+	perf_io_write_fl(file, line, event_name, NULL,
+			 &us_elapsed_absolute, &us_elapsed_child, NULL,
+			 &buf_payload);
+	strbuf_release(&buf_payload);
+}
+
+static void fn_thread_start_fl(const char *file, int line,
+				     uint64_t us_elapsed_absolute)
+{
+	const char *event_name = "thread_start";
+	struct strbuf buf_payload = STRBUF_INIT;
+
+	perf_io_write_fl(file, line, event_name, NULL,
+			 &us_elapsed_absolute, NULL, NULL,
+			 &buf_payload);
+	strbuf_release(&buf_payload);
+}
+
+static void fn_thread_exit_fl(const char *file, int line,
+			      uint64_t us_elapsed_absolute,
+			      uint64_t us_elapsed_thread)
+{
+	const char *event_name = "thread_exit";
+	struct strbuf buf_payload = STRBUF_INIT;
+
+	perf_io_write_fl(file, line, event_name, NULL,
+			 &us_elapsed_absolute, &us_elapsed_thread, NULL,
+			 &buf_payload);
+	strbuf_release(&buf_payload);
+}
+
+static void fn_exec_fl(const char *file, int line,
+		       uint64_t us_elapsed_absolute,
+		       int exec_id, const char *exe, const char **argv)
+{
+	const char *event_name = "exec";
+	struct strbuf buf_payload = STRBUF_INIT;
+
+	strbuf_addf(&buf_payload, "id:%d ", exec_id);
+	strbuf_addstr(&buf_payload, "argv:");
+	if (exe)
+		strbuf_addf(&buf_payload, " %s", exe);
+	sq_quote_argv_pretty(&buf_payload, argv);
+
+	perf_io_write_fl(file, line, event_name, NULL,
+			 &us_elapsed_absolute, NULL, NULL,
+			 &buf_payload);
+	strbuf_release(&buf_payload);
+}
+
+static void fn_exec_result_fl(const char *file, int line,
+			      uint64_t us_elapsed_absolute,
+			      int exec_id, int code)
+{
+	const char *event_name = "exec_result";
+	struct strbuf buf_payload = STRBUF_INIT;
+
+	strbuf_addf(&buf_payload, "id:%d code:%d", exec_id, code);
+	if (code > 0)
+		strbuf_addf(&buf_payload, " err:%s", strerror(code));
+
+	perf_io_write_fl(file, line, event_name, NULL,
+			 &us_elapsed_absolute, NULL, NULL,
+			 &buf_payload);
+	strbuf_release(&buf_payload);
+}
+
+static void fn_param_fl(const char *file, int line,
+			const char *param, const char *value)
+{
+	const char *event_name = "def_param";
+	struct strbuf buf_payload = STRBUF_INIT;
+
+	strbuf_addf(&buf_payload, "%s:%s", param, value);
+
+	perf_io_write_fl(file, line, event_name, NULL,
+			 NULL, NULL, NULL,
+			 &buf_payload);
+	strbuf_release(&buf_payload);
+}
+
+static void fn_repo_fl(const char *file, int line,
+		       const struct repository *repo)
+{
+	const char *event_name = "def_repo";
+	struct strbuf buf_payload = STRBUF_INIT;
+
+	strbuf_addstr(&buf_payload, "worktree:");
+	sq_quote_buf_pretty(&buf_payload, repo->worktree);
+
+	perf_io_write_fl(file, line, event_name, repo,
+			 NULL, NULL, NULL,
+			 &buf_payload);
+	strbuf_release(&buf_payload);
+}
+
+static void fn_region_enter_printf_va_fl(const char *file, int line,
+					 uint64_t us_elapsed_absolute,
+					 const char *category,
+					 const char *label,
+					 const struct repository *repo,
+					 const char *fmt, va_list ap)
+{
+	const char *event_name = "region_enter";
+	struct strbuf buf_payload = STRBUF_INIT;
+
+	if (label)
+		strbuf_addf(&buf_payload, "label:%s ", label);
+	maybe_append_string_va(&buf_payload, fmt, ap);
+
+	perf_io_write_fl(file, line, event_name, repo,
+			 &us_elapsed_absolute, NULL, category,
+			 &buf_payload);
+	strbuf_release(&buf_payload);
+}
+
+static void fn_region_leave_printf_va_fl(const char *file, int line,
+					 uint64_t us_elapsed_absolute,
+					 uint64_t us_elapsed_region,
+					 const char *category,
+					 const char *label,
+					 const struct repository *repo,
+					 const char *fmt, va_list ap)
+{
+	const char *event_name = "region_leave";
+	struct strbuf buf_payload = STRBUF_INIT;
+
+	if (label)
+		strbuf_addf(&buf_payload, "label:%s ", label);
+	maybe_append_string_va(&buf_payload, fmt, ap);
+
+	perf_io_write_fl(file, line, event_name, repo,
+			 &us_elapsed_absolute, &us_elapsed_region, category,
+			 &buf_payload);
+	strbuf_release(&buf_payload);
+}
+
+static void fn_data_fl(const char *file, int line,
+		       uint64_t us_elapsed_absolute,
+		       uint64_t us_elapsed_region,
+		       const char *category,
+		       const struct repository *repo,
+		       const char *key,
+		       const char *value)
+{
+	const char *event_name = "data";
+	struct strbuf buf_payload = STRBUF_INIT;
+
+	strbuf_addf(&buf_payload, "%s:%s", key, value);
+
+	perf_io_write_fl(file, line, event_name, repo,
+			 &us_elapsed_absolute, &us_elapsed_region, category,
+			 &buf_payload);
+	strbuf_release(&buf_payload);
+}
+
+static void fn_data_json_fl(const char *file, int line,
+			    uint64_t us_elapsed_absolute,
+			    uint64_t us_elapsed_region,
+			    const char *category,
+			    const struct repository *repo,
+			    const char *key,
+			    const struct json_writer *value)
+{
+	const char *event_name = "data_json";
+	struct strbuf buf_payload = STRBUF_INIT;
+
+	strbuf_addf(&buf_payload, "%s:%s", key, value->json.buf);
+
+	perf_io_write_fl(file, line, event_name, repo,
+			 &us_elapsed_absolute, &us_elapsed_region, category,
+			 &buf_payload);
+	strbuf_release(&buf_payload);
+}
+
+static void fn_printf_va_fl(const char *file, int line,
+			    uint64_t us_elapsed_absolute,
+			    const char *fmt, va_list ap)
+{
+	const char *event_name = "printf";
+	struct strbuf buf_payload = STRBUF_INIT;
+
+	maybe_append_string_va(&buf_payload, fmt, ap);
+
+	perf_io_write_fl(file, line, event_name, NULL,
+			 &us_elapsed_absolute, NULL, NULL,
+			 &buf_payload);
+	strbuf_release(&buf_payload);
+}
+
+struct tr2_tgt tr2_tgt_perf =
+{
+	&tr2dst_perf,
+
+	fn_init,
+	fn_term,
+
+	fn_version_fl,
+	fn_start_fl,
+	fn_exit_fl,
+	fn_signal,
+	fn_atexit,
+	fn_error_va_fl,
+	fn_command_path_fl,
+	fn_command_verb_fl,
+	fn_command_subverb_fl,
+	fn_alias_fl,
+	fn_child_start_fl,
+	fn_child_exit_fl,
+	fn_thread_start_fl,
+	fn_thread_exit_fl,
+	fn_exec_fl,
+	fn_exec_result_fl,
+	fn_param_fl,
+	fn_repo_fl,
+	fn_region_enter_printf_va_fl,
+	fn_region_leave_printf_va_fl,
+	fn_data_fl,
+	fn_data_json_fl,
+	fn_printf_va_fl,
+};
diff --git a/trace2/tr2_tls.c b/trace2/tr2_tls.c
new file mode 100644
index 0000000000..f5e304428c
--- /dev/null
+++ b/trace2/tr2_tls.c
@@ -0,0 +1,164 @@
+#include "cache.h"
+#include "thread-utils.h"
+#include "trace2/tr2_tls.h"
+
+/*
+ * Initialize size of the thread stack for nested regions.
+ * This is used to store nested region start times.  Note that
+ * this stack is per-thread and not per-trace-key.
+ */
+#define TR2_REGION_NESTING_INITIAL_SIZE (100)
+
+static struct tr2tls_thread_ctx *tr2tls_thread_main;
+static uint64_t tr2tls_us_start_main;
+
+static pthread_mutex_t tr2tls_mutex;
+static pthread_key_t tr2tls_key;
+
+static int tr2_next_thread_id; /* modify under lock */
+
+struct tr2tls_thread_ctx *tr2tls_create_self(const char *thread_name)
+{
+	uint64_t us_now = getnanotime() / 1000;
+	struct tr2tls_thread_ctx *ctx = xcalloc(1, sizeof(*ctx));
+
+	/*
+	 * Implicitly "tr2tls_push_self()" to capture the thread's start
+	 * time in array_us_start[0].  For the main thread this gives us the
+	 * application run time.
+	 */
+	ctx->alloc = TR2_REGION_NESTING_INITIAL_SIZE;
+	ctx->array_us_start = (uint64_t*)xcalloc(ctx->alloc, sizeof(uint64_t));
+	ctx->array_us_start[ctx->nr_open_regions++] = us_now;
+
+	ctx->thread_id = tr2tls_locked_increment(&tr2_next_thread_id);
+	
+	strbuf_init(&ctx->thread_name, 0);
+	if (ctx->thread_id)
+		strbuf_addf(&ctx->thread_name, "th%02d:", ctx->thread_id);
+	strbuf_addstr(&ctx->thread_name, thread_name);
+	if (ctx->thread_name.len > TR2_MAX_THREAD_NAME)
+		strbuf_setlen(&ctx->thread_name, TR2_MAX_THREAD_NAME);
+
+	pthread_setspecific(tr2tls_key, ctx);
+
+	return ctx;
+}
+
+struct tr2tls_thread_ctx *tr2tls_get_self(void)
+{
+	struct tr2tls_thread_ctx * ctx = pthread_getspecific(tr2tls_key);
+
+	/*
+	 * If the thread-proc did not call trace2_thread_start(), we won't
+	 * have any TLS data associated with the current thread.  Fix it
+	 * here and silently continue.
+	 */
+	if (!ctx)
+		ctx = tr2tls_create_self("unknown");
+
+	return ctx;
+}
+
+int tr2tls_is_main_thread(void)
+{
+	struct tr2tls_thread_ctx * ctx = pthread_getspecific(tr2tls_key);
+
+	return ctx == tr2tls_thread_main;
+}
+
+void tr2tls_unset_self(void)
+{
+	struct tr2tls_thread_ctx * ctx;
+
+	ctx = tr2tls_get_self();
+
+	pthread_setspecific(tr2tls_key, NULL);
+
+	free(ctx->array_us_start);
+	free(ctx);
+}
+
+void tr2tls_push_self(uint64_t us_now)
+{
+	struct tr2tls_thread_ctx *ctx = tr2tls_get_self();
+
+	ALLOC_GROW(ctx->array_us_start, ctx->nr_open_regions + 1, ctx->alloc);
+	ctx->array_us_start[ctx->nr_open_regions++] = us_now;
+}
+
+void tr2tls_pop_self(void)
+{
+	struct tr2tls_thread_ctx *ctx = tr2tls_get_self();
+
+	if (!ctx->nr_open_regions)
+		BUG("no open regions in thread '%s'", ctx->thread_name.buf);
+
+	ctx->nr_open_regions--;
+}
+
+void tr2tls_pop_unwind_self(void)
+{
+	struct tr2tls_thread_ctx *ctx = tr2tls_get_self();
+
+	while (ctx->nr_open_regions > 1)
+		tr2tls_pop_self();
+}
+
+uint64_t tr2tls_region_elasped_self(uint64_t us)
+{
+	struct tr2tls_thread_ctx *ctx;
+	uint64_t us_start;
+
+	ctx = tr2tls_get_self();
+	if (!ctx->nr_open_regions)
+		return 0;
+	
+	us_start = ctx->array_us_start[ctx->nr_open_regions - 1];
+
+	return us - us_start;
+}
+
+uint64_t tr2tls_absolute_elapsed(uint64_t us)
+{
+	if (!tr2tls_thread_main)
+		return 0;
+
+	return us - tr2tls_us_start_main;
+}
+
+void tr2tls_init(void)
+{
+	pthread_key_create(&tr2tls_key, NULL);
+	init_recursive_mutex(&tr2tls_mutex);
+
+	tr2tls_thread_main = tr2tls_create_self("main");
+	/*
+	 * Keep a copy of the absolute start time of the main thread
+	 * in a fixed variable since other threads need to access it.
+	 * This also eliminates the need to lock accesses to the main
+	 * thread's array (because of reallocs).
+	 */
+	tr2tls_us_start_main = tr2tls_thread_main->array_us_start[0];
+}
+
+void tr2tls_release(void)
+{
+	tr2tls_unset_self();
+	tr2tls_thread_main = NULL;
+
+	pthread_mutex_destroy(&tr2tls_mutex);
+	pthread_key_delete(tr2tls_key);
+}
+
+int tr2tls_locked_increment(int *p)
+{
+	int current_value;
+
+	pthread_mutex_lock(&tr2tls_mutex);
+	current_value = *p;
+	*p = current_value + 1;
+	pthread_mutex_unlock(&tr2tls_mutex);
+
+	return current_value;
+}
diff --git a/trace2/tr2_tls.h b/trace2/tr2_tls.h
new file mode 100644
index 0000000000..99ea9018ce
--- /dev/null
+++ b/trace2/tr2_tls.h
@@ -0,0 +1,95 @@
+#ifndef TR2_TLS_H
+#define TR2_TLS_H
+
+/*
+ * Arbitry limit for thread names for column alignment.
+ */
+#define TR2_MAX_THREAD_NAME (24)
+
+struct tr2tls_thread_ctx {
+	struct strbuf thread_name;
+	uint64_t *array_us_start;
+	int alloc;
+	int nr_open_regions; /* plays role of "nr" in ALLOC_GROW */
+	int thread_id;
+};
+
+/*
+ * Create TLS data for the current thread.  This gives us a place to
+ * put per-thread data, such as thread start time, function nesting
+ * and a per-thread label for our messages.
+ *
+ * We assume the first thread is "main".  Other threads are given
+ * non-zero thread-ids to help distinguish messages from concurrent
+ * threads.
+ *
+ * Truncate the thread name if necessary to help with column alignment
+ * in printf-style messages.
+ *
+ * In this and all following functions the term "self" refers to the
+ * current thread.
+ */
+struct tr2tls_thread_ctx *tr2tls_create_self(const char *thread_name);
+
+/*
+ * Get our TLS data.
+ */
+struct tr2tls_thread_ctx *tr2tls_get_self(void);
+
+/*
+ * return true if the current thread is the main thread.
+ */
+int tr2tls_is_main_thread(void);
+
+/*
+ * Free our TLS data.
+ */
+void tr2tls_unset_self(void);
+
+/*
+ * Begin a new nested region and remember the start time.
+ */
+void tr2tls_push_self(uint64_t us_now);
+
+/*
+ * End the innermost nested region.
+ */
+void tr2tls_pop_self(void);
+
+/*
+ * Pop any extra (above the first) open regions on the current
+ * thread and discard.  During a thread-exit, we should only
+ * have region[0] that was pushed in trace2_thread_start() if
+ * the thread exits normally.
+ */
+void tr2tls_pop_unwind_self(void);
+
+/*
+ * Compute the elapsed time since the innermost region in the
+ * current thread started and the given time (usually now).
+ */
+uint64_t tr2tls_region_elasped_self(uint64_t us);
+
+/*
+ * Compute the elapsed time since the main thread started
+ * and the given time (usually now).  This is assumed to
+ * be the absolute run time of the process.
+ */
+uint64_t tr2tls_absolute_elapsed(uint64_t us);
+
+/*
+ * Initialize the tr2 TLS system.
+ */
+void tr2tls_init(void);
+
+/*
+ * Free all tr2 TLS resources.
+ */
+void tr2tls_release(void);
+
+/*
+ * Protected increment of an integer.
+ */
+int tr2tls_locked_increment(int *p);
+
+#endif /* TR2_TLS_H */
diff --git a/trace2/tr2_verb.c b/trace2/tr2_verb.c
new file mode 100644
index 0000000000..52be27c29f
--- /dev/null
+++ b/trace2/tr2_verb.c
@@ -0,0 +1,30 @@
+#include "cache.h"
+#include "trace2/tr2_verb.h"
+
+#define TR2_ENVVAR_PARENT_VERB "GIT_TR2_PARENT_VERB"
+
+static struct strbuf tr2verb_hierarchy = STRBUF_INIT;
+
+void tr2_verb_append_hierarchy(const char *verb)
+{
+	const char *parent_verb = getenv(TR2_ENVVAR_PARENT_VERB);
+
+	strbuf_reset(&tr2verb_hierarchy);
+	if (parent_verb && *parent_verb) {
+		strbuf_addstr(&tr2verb_hierarchy, parent_verb);
+		strbuf_addch(&tr2verb_hierarchy, '/');
+	}
+	strbuf_addstr(&tr2verb_hierarchy, verb);
+
+	setenv(TR2_ENVVAR_PARENT_VERB, tr2verb_hierarchy.buf, 1);
+}
+
+const char *tr2_verb_get_hierarchy(void)
+{
+	return tr2verb_hierarchy.buf;
+}
+
+void tr2_verb_release(void)
+{
+	strbuf_release(&tr2verb_hierarchy);
+}
diff --git a/trace2/tr2_verb.h b/trace2/tr2_verb.h
new file mode 100644
index 0000000000..f84f873463
--- /dev/null
+++ b/trace2/tr2_verb.h
@@ -0,0 +1,24 @@
+#ifndef TR2_VERB_H
+#define TR2_VERB_H
+
+/*
+ * Append the current git command's "verb" to the list being maintained
+ * in the environment.
+ *
+ * The hierarchy for a top-level git command is just the current verb.
+ * For a child git process, the hierarchy lists the verbs of the parent
+ * git processes (much like the SID).
+ *
+ * The hierarchy for the current process will be exported to the environment
+ * and inherited by child processes.
+ */
+void tr2_verb_append_hierarchy(const char *verb);
+
+/*
+ * Get the verb hierarchy for the current process.
+ */
+const char *tr2_verb_get_hierarchy(void);
+
+void tr2_verb_release(void);
+
+#endif /* TR2_VERB_H */
diff --git a/usage.c b/usage.c
index cc803336bd..5ec7511e11 100644
--- a/usage.c
+++ b/usage.c
@@ -22,17 +22,48 @@ void vreportf(const char *prefix, const char *err, va_list params)
 static NORETURN void usage_builtin(const char *err, va_list params)
 {
 	vreportf("usage: ", err, params);
+
+	/*
+	 * When we detect a usage error *before* the command dispatch in
+	 * cmd_main(), we don't know what verb to report.  Force it to this
+	 * to facilitate post-processing.
+	 */
+	trace2_cmd_verb("_usage_");
+
+	/*
+	 * Currently, the (err, params) are usually just the static usage
+	 * string which isn't very useful here.  Usually, the call site
+	 * manually calls fprintf(stderr,...) with the actual detailed
+	 * syntax error before calling usage().
+	 *
+	 * TODO It would be nice to update the call sites to pass both
+	 * the static usage string and the detailed error message.
+	 */
+
 	exit(129);
 }
 
 static NORETURN void die_builtin(const char *err, va_list params)
 {
+	/*
+	 * We call this trace2 function first and expect it to va_copy 'params'
+	 * before using it (because an 'ap' can only be walked once).
+	 */
+	trace2_cmd_error_va(err, params);
+
 	vreportf("fatal: ", err, params);
+
 	exit(128);
 }
 
 static void error_builtin(const char *err, va_list params)
 {
+	/*
+	 * We call this trace2 function first and expect it to va_copy 'params'
+	 * before using it (because an 'ap' can only be walked once).
+	 */
+	trace2_cmd_error_va(err, params);
+
 	vreportf("error: ", err, params);
 }
 
-- 
gitgitgadget

