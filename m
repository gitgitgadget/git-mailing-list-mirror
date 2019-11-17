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
	by dcvr.yhbt.net (Postfix) with ESMTP id 34C8B1F4B5
	for <e@80x24.org>; Sun, 17 Nov 2019 21:05:26 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726568AbfKQVFZ (ORCPT <rfc822;e@80x24.org>);
        Sun, 17 Nov 2019 16:05:25 -0500
Received: from mail-wm1-f67.google.com ([209.85.128.67]:53993 "EHLO
        mail-wm1-f67.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726518AbfKQVFV (ORCPT <rfc822;git@vger.kernel.org>);
        Sun, 17 Nov 2019 16:05:21 -0500
Received: by mail-wm1-f67.google.com with SMTP id u18so15311192wmc.3
        for <git@vger.kernel.org>; Sun, 17 Nov 2019 13:05:18 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=message-id:in-reply-to:references:from:date:subject:fcc
         :content-transfer-encoding:mime-version:to:cc;
        bh=CfHNXFWw1Svzx+gN1b1XYrLzg+8yOHUYq4ZIqgZKEDY=;
        b=XajYBMctke8fbRDUk4ioascrUGmnVBDmPybMSk1cExY1NgOwvlZ4v1D+IwrDa9omIn
         OshLQHMG7PJtEZ/mktEtzBFNiXLFyIElyvOkoVYzJEOEHMfuHgRxNnymdQu7kD+D1QSr
         ER1ffVpfNFV3JIpsJ8TnItVE+nQxnhE6MoAKbXwwRsCybmSgE2pBjvDlOx6Tm6A1Xz28
         20/WNjqqzV7kzaZGWMM/Xs6JksOVo3QVXLptYT5W07zyvHhdCPG7K806xxP5BHK9IUHz
         O5SI2EukTd2RChcXpfZg8BWD9dgPxzQ5kncHHq1kTWJFCBmwq9ztLSpGZDAuXg1iwoSE
         mgZA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:message-id:in-reply-to:references:from:date
         :subject:fcc:content-transfer-encoding:mime-version:to:cc;
        bh=CfHNXFWw1Svzx+gN1b1XYrLzg+8yOHUYq4ZIqgZKEDY=;
        b=ABlLuc8AA4zZgB0WBz8iBPS7+OPSH+YK8n8sYNgOnVQSkcpmQyHe4eYGxpvgKuffbs
         mU6P+VvByYezpeH56XezqmFswNKmAMnq3d6kEiSYO62RXgsLhL1TQvaIBp1jCs5yPgww
         3nhau8t+DU8enF20Lhqsos7pxHCclx1P8loDb/983Pngs/7UujRVXCIpRvMBKPpA5cEE
         1S1/gGJqFxbrI/f6SPU+Q+9iR23bIEdmd4XsFZtPvSENKQEq2bbasWYqWN0Wj5xu8+n4
         EDjTIBN98OxXfc2IovILJAXPydPKuQnBrutCqb9I67OTSojybEfZQpTEm0mJZqKKZgLs
         8UMw==
X-Gm-Message-State: APjAAAXSsCl11GHc1XMl1d1au4irgY6y+7UxkFNoZgKstLJU/QVxT/mt
        Spka2TomgvYCeaenZMKU2+6LyJ83
X-Google-Smtp-Source: APXvYqwpcBf74CmslSqe43BVN2xm2cqffCbI7hg1iYEfh7zBcUhBMg2PUFlOw2sVbcI8NOJBED9F9Q==
X-Received: by 2002:a1c:4946:: with SMTP id w67mr27030710wma.16.1574024717069;
        Sun, 17 Nov 2019 13:05:17 -0800 (PST)
Received: from [127.0.0.1] ([13.74.141.28])
        by smtp.gmail.com with ESMTPSA id f188sm16748431wmf.3.2019.11.17.13.05.16
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Sun, 17 Nov 2019 13:05:16 -0800 (PST)
Message-Id: <cf3e3dd0c217845dce9df285693fcba420d8b179.1574024701.git.gitgitgadget@gmail.com>
In-Reply-To: <pull.434.v5.git.1574024700.gitgitgadget@gmail.com>
References: <pull.434.v4.git.1573811626.gitgitgadget@gmail.com>
        <pull.434.v5.git.1574024700.gitgitgadget@gmail.com>
From:   "Heba Waly via GitGitGadget" <gitgitgadget@gmail.com>
Date:   Sun, 17 Nov 2019 21:04:59 +0000
Subject: [PATCH v5 20/21] trace2: move doc to trace2.h
Fcc:    Sent
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
MIME-Version: 1.0
To:     git@vger.kernel.org
Cc:     Heba Waly <heba.waly@gmail.com>,
        Junio C Hamano <gitster@pobox.com>,
        Heba Waly <heba.waly@gmail.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

From: Heba Waly <heba.waly@gmail.com>

Move the functions documentation from
Documentation/technical/api-trace2.txt to trace2.h as it's easier for the
developers to find the usage information beside the code instead of looking
for it in another doc file.

Only the functions documentation section is removed from
Documentation/technical/api-trace2.txt as the file is full of
details that seemed more appropriate to be in a separate doc file
as it is, with a link to the doc file added in the trace2.h.
Also the functions doc is removed to avoid having redundandt info which
will be hard to keep syncronized with the documentation in the header file.

Signed-off-by: Heba Waly <heba.waly@gmail.com>
---
 Documentation/technical/api-trace2.txt | 243 +------------------------
 trace2.h                               | 124 ++++++++++---
 2 files changed, 111 insertions(+), 256 deletions(-)

diff --git a/Documentation/technical/api-trace2.txt b/Documentation/technical/api-trace2.txt
index a045dbe422..9907244d64 100644
--- a/Documentation/technical/api-trace2.txt
+++ b/Documentation/technical/api-trace2.txt
@@ -188,261 +188,36 @@ purposes.
 === Basic Command Messages
 
 These are concerned with the lifetime of the overall git process.
-
-`void trace2_initialize_clock()`::
-
-	Initialize the Trace2 start clock and nothing else.  This should
-	be called at the very top of main() to capture the process start
-	time and reduce startup order dependencies.
-
-`void trace2_initialize()`::
-
-	Determines if any Trace2 Targets should be enabled and
-	initializes the Trace2 facility.  This includes setting up the
-	Trace2 thread local storage (TLS).
-+
-This function emits a "version" message containing the version of git
-and the Trace2 protocol.
-+
-This function should be called from `main()` as early as possible in
-the life of the process after essential process initialization.
-
-`int trace2_is_enabled()`::
-
-	Returns 1 if Trace2 is enabled (at least one target is
-	active).
-
-`void trace2_cmd_start(int argc, const char **argv)`::
-
-	Emits a "start" message containing the process command line
-	arguments.
-
-`int trace2_cmd_exit(int exit_code)`::
-
-	Emits an "exit" message containing the process exit-code and
-	elapsed time.
-+
-Returns the exit-code.
-
-`void trace2_cmd_error(const char *fmt, va_list ap)`::
-
-	Emits an "error" message containing a formatted error message.
-
-`void trace2_cmd_path(const char *pathname)`::
-
-	Emits a "cmd_path" message with the full pathname of the
-	current process.
+e.g: `void trace2_initialize_clock()`, `void trace2_initialize()`,
+`int trace2_is_enabled()`, `void trace2_cmd_start(int argc, const char **argv)`.
 
 === Command Detail Messages
 
 These are concerned with describing the specific Git command
 after the command line, config, and environment are inspected.
-
-`void trace2_cmd_name(const char *name)`::
-
-	Emits a "cmd_name" message with the canonical name of the
-	command, for example "status" or "checkout".
-
-`void trace2_cmd_mode(const char *mode)`::
-
-	Emits a "cmd_mode" message with a qualifier name to further
-	describe the current git command.
-+
-This message is intended to be used with git commands having multiple
-major modes.  For example, a "checkout" command can checkout a new
-branch or it can checkout a single file, so the checkout code could
-emit a cmd_mode message of "branch" or "file".
-
-`void trace2_cmd_alias(const char *alias, const char **argv_expansion)`::
-
-	Emits an "alias" message containing the alias used and the
-	argument expansion.
-
-`void trace2_def_param(const char *parameter, const char *value)`::
-
-	Emits a "def_param" message containing a key/value pair.
-+
-This message is intended to report some global aspect of the current
-command, such as a configuration setting or command line switch that
-significantly affects program performance or behavior, such as
-`core.abbrev`, `status.showUntrackedFiles`, or `--no-ahead-behind`.
-
-`void trace2_cmd_list_config()`::
-
-	Emits a "def_param" messages for "important" configuration
-	settings.
-+
-The environment variable `GIT_TRACE2_CONFIG_PARAMS` or the `trace2.configParams`
-config value can be set to a
-list of patterns of important configuration settings, for example:
-`core.*,remote.*.url`.  This function will iterate over all config
-settings and emit a "def_param" message for each match.
-
-`void trace2_cmd_set_config(const char *key, const char *value)`::
-
-	Emits a "def_param" message for a new or updated key/value
-	pair IF `key` is considered important.
-+
-This is used to hook into `git_config_set()` and catch any
-configuration changes and update a value previously reported by
-`trace2_cmd_list_config()`.
-
-`void trace2_def_repo(struct repository *repo)`::
-
-	Registers a repository with the Trace2 layer.  Assigns a
-	unique "repo-id" to `repo->trace2_repo_id`.
-+
-Emits a "worktree" messages containing the repo-id and the worktree
-pathname.
-+
-Region and data messages (described later) may refer to this repo-id.
-+
-The main/top-level repository will have repo-id value 1 (aka "r1").
-+
-The repo-id field is in anticipation of future in-proc submodule
-repositories.
+e.g: `void trace2_cmd_name(const char *name)`,
+`void trace2_cmd_mode(const char *mode)`.
 
 === Child Process Messages
 
 These are concerned with the various spawned child processes,
 including shell scripts, git commands, editors, pagers, and hooks.
 
-`void trace2_child_start(struct child_process *cmd)`::
-
-	Emits a "child_start" message containing the "child-id",
-	"child-argv", and "child-classification".
-+
-Before calling this, set `cmd->trace2_child_class` to a name
-describing the type of child process, for example "editor".
-+
-This function assigns a unique "child-id" to `cmd->trace2_child_id`.
-This field is used later during the "child_exit" message to associate
-it with the "child_start" message.
-+
-This function should be called before spawning the child process.
-
-`void trace2_child_exit(struct child_proess *cmd, int child_exit_code)`::
-
-	Emits a "child_exit" message containing the "child-id",
-	the child's elapsed time and exit-code.
-+
-The reported elapsed time includes the process creation overhead and
-time spend waiting for it to exit, so it may be slightly longer than
-the time reported by the child itself.
-+
-This function should be called after reaping the child process.
-
-`int trace2_exec(const char *exe, const char **argv)`::
-
-	Emits a "exec" message containing the "exec-id" and the
-	argv of the new process.
-+
-This function should be called before calling one of the `exec()`
-variants, such as `execvp()`.
-+
-This function returns a unique "exec-id".  This value is used later
-if the exec() fails and a "exec-result" message is necessary.
-
-`void trace2_exec_result(int exec_id, int error_code)`::
-
-	Emits a "exec_result" message containing the "exec-id"
-	and the error code.
-+
-On Unix-based systems, `exec()` does not return if successful.
-This message is used to indicate that the `exec()` failed and
-that the current program is continuing.
+e.g: `void trace2_child_start(struct child_process *cmd)`.
 
 === Git Thread Messages
 
 These messages are concerned with Git thread usage.
 
-`void trace2_thread_start(const char *thread_name)`::
-
-	Emits a "thread_start" message.
-+
-The `thread_name` field should be a descriptive name, such as the
-unique name of the thread-proc.  A unique "thread-id" will be added
-to the name to uniquely identify thread instances.
-+
-Region and data messages (described later) may refer to this thread
-name.
-+
-This function must be called by the thread-proc of the new thread
-(so that TLS data is properly initialized) and not by the caller
-of `pthread_create()`.
-
-`void trace2_thread_exit()`::
-
-	Emits a "thread_exit" message containing the thread name
-	and the thread elapsed time.
-+
-This function must be called by the thread-proc before it returns
-(so that the coorect TLS data is used and cleaned up.  It should
-not be called by the caller of `pthread_join()`.
+e.g: `void trace2_thread_start(const char *thread_name)`.
 
 === Region and Data Messages
 
 These are concerned with recording performance data
-over regions or spans of code.
-
-`void trace2_region_enter(const char *category, const char *label, const struct repository *repo)`::
-
-`void trace2_region_enter_printf(const char *category, const char *label, const struct repository *repo, const char *fmt, ...)`::
-
-`void trace2_region_enter_printf_va(const char *category, const char *label, const struct repository *repo, const char *fmt, va_list ap)`::
-
-	Emits a thread-relative "region_enter" message with optional
-	printf string.
-+
-This function pushes a new region nesting stack level on the current
-thread and starts a clock for the new stack frame.
-+
-The `category` field is an arbitrary category name used to classify
-regions by feature area, such as "status" or "index".  At this time
-it is only just printed along with the rest of the message.  It may
-be used in the future to filter messages.
-+
-The `label` field is an arbitrary label used to describe the activity
-being started, such as "read_recursive" or "do_read_index".
-+
-The `repo` field, if set, will be used to get the "repo-id", so that
-recursive oerations can be attributed to the correct repository.
-
-`void trace2_region_leave(const char *category, const char *label, const struct repository *repo)`::
-
-`void trace2_region_leave_printf(const char *category, const char *label, const struct repository *repo, const char *fmt, ...)`::
-
-`void trace2_region_leave_printf_va(const char *category, const char *label, const struct repository *repo, const char *fmt, va_list ap)`::
-
-	Emits a thread-relative "region_leave" message with optional
-	printf string.
-+
-This function pops the region nesting stack on the current thread
-and reports the elapsed time of the stack frame.
-+
-The `category`, `label`, and `repo` fields are the same as above.
-The `category` and `label` do not need to match the correpsonding
-"region_enter" message, but it makes the data stream easier to
-understand.
-
-`void trace2_data_string(const char *category, const struct repository *repo, const char *key, const char * value)`::
-
-`void trace2_data_intmax(const char *category, const struct repository *repo, const char *key, intmax value)`::
-
-`void trace2_data_json(const char *category, const struct repository *repo, const char *key, const struct json_writer *jw)`::
-
-	Emits a region- and thread-relative "data" or "data_json" message.
-+
-This is a key/value pair message containing information about the
-current thread, region stack, and repository.  This could be used
-to print the number of files in a directory during a multi-threaded
-recursive tree walk.
-
-`void trace2_printf(const char *fmt, ...)`::
-
-`void trace2_printf_va(const char *fmt, va_list ap)`::
+over regions or spans of code. e.g:
+`void trace2_region_enter(const char *category, const char *label, const struct repository *repo)`.
 
-	Emits a region- and thread-relative "printf" message.
+Refer to trace2.h for details about all trace2 functions.
 
 == Trace2 Target Formats
 
diff --git a/trace2.h b/trace2.h
index 050bf3c8c1..e5e81c0533 100644
--- a/trace2.h
+++ b/trace2.h
@@ -1,6 +1,40 @@
 #ifndef TRACE2_H
 #define TRACE2_H
 
+/**
+ * The Trace2 API can be used to print debug, performance, and telemetry
+ * information to stderr or a file.  The Trace2 feature is inactive unless
+ * explicitly enabled by enabling one or more Trace2 Targets.
+ *
+ * The Trace2 API is intended to replace the existing (Trace1)
+ * printf-style tracing provided by the existing `GIT_TRACE` and
+ * `GIT_TRACE_PERFORMANCE` facilities.  During initial implementation,
+ * Trace2 and Trace1 may operate in parallel.
+ *
+ * The Trace2 API defines a set of high-level messages with known fields,
+ * such as (`start`: `argv`) and (`exit`: {`exit-code`, `elapsed-time`}).
+ *
+ * Trace2 instrumentation throughout the Git code base sends Trace2
+ * messages to the enabled Trace2 Targets.  Targets transform these
+ * messages content into purpose-specific formats and write events to
+ * their data streams.  In this manner, the Trace2 API can drive
+ * many different types of analysis.
+ *
+ * Targets are defined using a VTable allowing easy extension to other
+ * formats in the future.  This might be used to define a binary format,
+ * for example.
+ *
+ * Trace2 is controlled using `trace2.*` config values in the system and
+ * global config files and `GIT_TRACE2*` environment variables.  Trace2 does
+ * not read from repo local or worktree config files or respect `-c`
+ * command line config settings.
+ *
+ * For more info about: trace2 targets, conventions for public functions and
+ * macros, trace2 target formats and examples on trace2 API usage refer to
+ * Documentation/technical/api-trace2.txt
+ *
+ */
+
 struct child_process;
 struct repository;
 struct json_writer;
@@ -39,7 +73,12 @@ void trace2_initialize_clock(void);
 /*
  * Initialize TRACE2 tracing facility if any of the builtin TRACE2
  * targets are enabled in the system config or the environment.
- * Emits a 'version' event.
+ * This includes setting up the Trace2 thread local storage (TLS).
+ * Emits a 'version' message containing the version of git
+ * and the Trace2 protocol.
+ *
+ * This function should be called from `main()` as early as possible in
+ * the life of the process after essential process initialization.
  *
  * Cleanup/Termination is handled automatically by a registered
  * atexit() routine.
@@ -49,7 +88,7 @@ void trace2_initialize_fl(const char *file, int line);
 #define trace2_initialize() trace2_initialize_fl(__FILE__, __LINE__)
 
 /*
- * Return true if trace2 is enabled.
+ * Return 1 if trace2 is enabled (at least one target is active).
  */
 int trace2_is_enabled(void);
 
@@ -114,7 +153,8 @@ void trace2_cmd_mode_fl(const char *file, int line, const char *mode);
 #define trace2_cmd_mode(sv) trace2_cmd_mode_fl(__FILE__, __LINE__, (sv))
 
 /*
- * Emit an 'alias' expansion event.
+ * Emits an "alias" message containing the alias used and the argument
+ * expansion.
  */
 void trace2_cmd_alias_fl(const char *file, int line, const char *alias,
 			 const char **argv);
@@ -123,7 +163,7 @@ void trace2_cmd_alias_fl(const char *file, int line, const char *alias,
 	trace2_cmd_alias_fl(__FILE__, __LINE__, (alias), (argv))
 
 /*
- * Emit one or more 'def_param' events for "interesting" configuration
+ * Emit one or more 'def_param' events for "important" configuration
  * settings.
  *
  * Use the TR2_SYSENV_CFG_PARAM setting to register a comma-separated
@@ -144,7 +184,7 @@ void trace2_cmd_list_config_fl(const char *file, int line);
 
 /*
  * Emit a "def_param" event for the given config key/value pair IF
- * we consider the key to be "interesting".
+ * we consider the key to be "important".
  *
  * Use this for new/updated config settings created/updated after
  * trace2_cmd_list_config() is called.
@@ -155,20 +195,34 @@ void trace2_cmd_set_config_fl(const char *file, int line, const char *key,
 #define trace2_cmd_set_config(k, v) \
 	trace2_cmd_set_config_fl(__FILE__, __LINE__, (k), (v))
 
-/*
- * Emit a 'child_start' event prior to spawning a child process.
+/**
+ * Emits a "child_start" message containing the "child-id",
+ * "child-argv", and "child-classification".
  *
  * Before calling optionally set "cmd->trace2_child_class" to a string
  * describing the type of the child process.  For example, "editor" or
  * "pager".
+ *
+ * This function assigns a unique "child-id" to `cmd->trace2_child_id`.
+ * This field is used later during the "child_exit" message to associate
+ * it with the "child_start" message.
+ *
+ * This function should be called before spawning the child process.
  */
 void trace2_child_start_fl(const char *file, int line,
 			   struct child_process *cmd);
 
 #define trace2_child_start(cmd) trace2_child_start_fl(__FILE__, __LINE__, (cmd))
 
-/*
- * Emit a 'child_exit' event after the child process completes.
+/**
+ * Emits a "child_exit" message containing the "child-id",
+ * the child's elapsed time and exit-code.
+ *
+ * The reported elapsed time includes the process creation overhead and
+ * time spend waiting for it to exit, so it may be slightly longer than
+ * the time reported by the child itself.
+ *
+ * This function should be called after reaping the child process.
  */
 void trace2_child_exit_fl(const char *file, int line, struct child_process *cmd,
 			  int child_exit_code);
@@ -176,21 +230,22 @@ void trace2_child_exit_fl(const char *file, int line, struct child_process *cmd,
 #define trace2_child_exit(cmd, code) \
 	trace2_child_exit_fl(__FILE__, __LINE__, (cmd), (code))
 
-/*
+/**
  * Emit an 'exec' event prior to calling one of exec(), execv(),
  * execvp(), and etc.  On Unix-derived systems, this will be the
  * last event emitted for the current process, unless the exec
  * fails.  On Windows, exec() behaves like 'child_start' and a
  * waitpid(), so additional events may be emitted.
  *
- * Returns the "exec_id".
+ * Returns a unique "exec-id".  This value is used later
+ * if the exec() fails and a "exec-result" message is necessary.
  */
 int trace2_exec_fl(const char *file, int line, const char *exe,
 		   const char **argv);
 
 #define trace2_exec(exe, argv) trace2_exec_fl(__FILE__, __LINE__, (exe), (argv))
 
-/*
+/**
  * Emit an 'exec_result' when possible.  On Unix-derived systems,
  * this should be called after exec() returns (which only happens
  * when there is an error starting the new process).  On Windows,
@@ -226,11 +281,12 @@ void trace2_thread_exit_fl(const char *file, int line);
 #define trace2_thread_exit() trace2_thread_exit_fl(__FILE__, __LINE__)
 
 /*
- * Emit a 'param' event.
+ * Emits a "def_param" message containing a key/value pair.
  *
- * Write a "<param> = <value>" pair describing some aspect of the
- * run such as an important configuration setting or command line
- * option that significantly changes command behavior.
+ * This message is intended to report some global aspect of the current
+ * command, such as a configuration setting or command line switch that
+ * significantly affects program performance or behavior, such as
+ * `core.abbrev`, `status.showUntrackedFiles`, or `--no-ahead-behind`.
  */
 void trace2_def_param_fl(const char *file, int line, const char *param,
 			 const char *value);
@@ -243,18 +299,35 @@ void trace2_def_param_fl(const char *file, int line, const char *param,
  * a trace2-repo-id to be used in subsequent activity events.
  *
  * Emits a 'worktree' event for this repo instance.
+ *
+ * Region and data messages may refer to this repo-id.
+ *
+ * The main/top-level repository will have repo-id value 1 (aka "r1").
+ *
+ * The repo-id field is in anticipation of future in-proc submodule
+ * repositories.
  */
 void trace2_def_repo_fl(const char *file, int line, struct repository *repo);
 
 #define trace2_def_repo(repo) trace2_def_repo_fl(__FILE__, __LINE__, repo)
 
-/*
+/**
  * Emit a 'region_enter' event for <category>.<label> with optional
  * repo-id and printf message.
  *
- * Enter a new nesting level on the current thread and remember the
- * current time.  This controls the indenting of all subsequent events
- * on this thread.
+ * This function pushes a new region nesting stack level on the current
+ * thread and starts a clock for the new stack frame.
+ *
+ * The `category` field is an arbitrary category name used to classify
+ * regions by feature area, such as "status" or "index".  At this time
+ * it is only just printed along with the rest of the message.  It may
+ * be used in the future to filter messages.
+ *
+ * The `label` field is an arbitrary label used to describe the activity
+ * being started, such as "read_recursive" or "do_read_index".
+ *
+ * The `repo` field, if set, will be used to get the "repo-id", so that
+ * recursive oerations can be attributed to the correct repository.
  */
 void trace2_region_enter_fl(const char *file, int line, const char *category,
 			    const char *label, const struct repository *repo, ...);
@@ -289,12 +362,17 @@ void trace2_region_enter_printf(const char *category, const char *label,
 /* clang-format on */
 #endif
 
-/*
+/**
  * Emit a 'region_leave' event for <category>.<label> with optional
  * repo-id and printf message.
  *
  * Leave current nesting level and report the elapsed time spent
  * in this nesting level.
+ *
+ * The `category`, `label`, and `repo` fields are the same as
+ * trace2_region_enter_fl. The `category` and `label` do not
+ * need to match the corresponding "region_enter" message,
+ * but it makes the data stream easier to understand.
  */
 void trace2_region_leave_fl(const char *file, int line, const char *category,
 			    const char *label, const struct repository *repo, ...);
@@ -329,10 +407,12 @@ void trace2_region_leave_printf(const char *category, const char *label,
 /* clang-format on */
 #endif
 
-/*
+/**
  * Emit a key-value pair 'data' event of the form <category>.<key> = <value>.
  * This event implicitly contains information about thread, nesting region,
  * and optional repo-id.
+ * This could be used to print the number of files in a directory during
+ * a multi-threaded recursive tree walk.
  *
  * On event-based TRACE2 targets, this generates a 'data' event suitable
  * for post-processing.  On printf-based TRACE2 targets, this is converted
-- 
gitgitgadget

