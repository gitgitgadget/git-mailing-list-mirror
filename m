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
	by dcvr.yhbt.net (Postfix) with ESMTP id 80C701F4B5
	for <e@80x24.org>; Sun, 17 Nov 2019 21:05:24 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726541AbfKQVFW (ORCPT <rfc822;e@80x24.org>);
        Sun, 17 Nov 2019 16:05:22 -0500
Received: from mail-wr1-f48.google.com ([209.85.221.48]:43157 "EHLO
        mail-wr1-f48.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726453AbfKQVFT (ORCPT <rfc822;git@vger.kernel.org>);
        Sun, 17 Nov 2019 16:05:19 -0500
Received: by mail-wr1-f48.google.com with SMTP id n1so17072912wra.10
        for <git@vger.kernel.org>; Sun, 17 Nov 2019 13:05:15 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=message-id:in-reply-to:references:from:date:subject:fcc
         :content-transfer-encoding:mime-version:to:cc;
        bh=QBZ/+RgZXz1vcOqcHbVhWx+TyI3mhUOApwCrSkjBZZI=;
        b=LMzl/zvZR2JLJgiLUARZMYnA2ecRzqZA9LRDJyKuLA9CqG69VvLzjVRY8znq2lOYol
         Eyd2ARoTyc4DTXS/WIbiS7Rl4nqk1Z3bRN2rRJdo3h5vFpMlQ1KkMNR7TGx1fWpUl+39
         jkeXJL1VNLdJGvERpl22OsU8vARO06ODXbZoU7SsSneg/28czeU+2LswQU45D0ZC7OQi
         MlfiNoUg0R6xxoKWkI40578qlaRD1ssyfxP6hU4EDxvGsCbgyJhvpxobRa/gBtI+gHaI
         TnhtMQuefbqZwzI0HqVQPmsrWvgcK23SJ4bCnDM3pu0ZvVL6Z4Zndea7Hrx0YAKtWrqa
         5cFw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:message-id:in-reply-to:references:from:date
         :subject:fcc:content-transfer-encoding:mime-version:to:cc;
        bh=QBZ/+RgZXz1vcOqcHbVhWx+TyI3mhUOApwCrSkjBZZI=;
        b=J5/bO5LIbnTqYfA7jifQo/0BWVBwYQPiS61UR4FQH7b9wo4VOzH1rdeXOmhM+Avjix
         Tg3IE3Im7cA12UP3TBzx2jYcvrypJff55Azmfburwmj+jVucb5Cc/DyV1BGSI7o00VAe
         QfLWussZz2hLl/b+UmF+qiQFWlaxiEhEWf/Fv5Vx/XxrB/NT8akX9ZbC0nLKnG4IPtnQ
         1NXC90oN4JMkMps7QwpSvmMsSfbUl0qzfP7nr1HwHWVM9CN6l9HWn8Nt72oTaGxTh1Xz
         knUFzh0aIrlkv/mkmJRwcdy8HZQQO9oWxL8o1zd9ib6dp/Vut+g1LzDkh6vuyX9njfVl
         GOcQ==
X-Gm-Message-State: APjAAAVCUx/Rlvu0/XepvSVd9uRqLVBwFXKCwEs0bBM2iZuDolQYrLb9
        2ciRoGPmTiLlGSfwXlwkpDDzzmoK
X-Google-Smtp-Source: APXvYqwSH6RrrLYtVcO43BgEUsezlc+YXZgZ9t/C9/4LkA6cKNvcBvQMqfkftq/0jNtW+nD2mND3MA==
X-Received: by 2002:a5d:4a10:: with SMTP id m16mr24701191wrq.294.1574024714351;
        Sun, 17 Nov 2019 13:05:14 -0800 (PST)
Received: from [127.0.0.1] ([13.74.141.28])
        by smtp.gmail.com with ESMTPSA id d7sm20855182wrx.11.2019.11.17.13.05.13
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Sun, 17 Nov 2019 13:05:13 -0800 (PST)
Message-Id: <474911ff773f6b136d875c80764fec14d46ce590.1574024701.git.gitgitgadget@gmail.com>
In-Reply-To: <pull.434.v5.git.1574024700.gitgitgadget@gmail.com>
References: <pull.434.v4.git.1573811626.gitgitgadget@gmail.com>
        <pull.434.v5.git.1574024700.gitgitgadget@gmail.com>
From:   "Heba Waly via GitGitGadget" <gitgitgadget@gmail.com>
Date:   Sun, 17 Nov 2019 21:04:55 +0000
Subject: [PATCH v5 16/21] run-command: move doc to run-command.h
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

Move the documentation from Documentation/technical/api-run-command.txt
to run-command.h as it's easier for the developers to find the usage
information beside the code instead of looking for it in another doc file.

Documentation/technical/api-run-command.txt is removed because the
information it has is now redundant and it'll be hard to keep it up to
date and synchronized with the documentation in the header file.

Signed-off-by: Heba Waly <heba.waly@gmail.com>
---
 Documentation/technical/api-run-command.txt | 264 --------------------
 run-command.h                               | 252 ++++++++++++++++++-
 2 files changed, 245 insertions(+), 271 deletions(-)
 delete mode 100644 Documentation/technical/api-run-command.txt

diff --git a/Documentation/technical/api-run-command.txt b/Documentation/technical/api-run-command.txt
deleted file mode 100644
index 8bf3e37f53..0000000000
--- a/Documentation/technical/api-run-command.txt
+++ /dev/null
@@ -1,264 +0,0 @@
-run-command API
-===============
-
-The run-command API offers a versatile tool to run sub-processes with
-redirected input and output as well as with a modified environment
-and an alternate current directory.
-
-A similar API offers the capability to run a function asynchronously,
-which is primarily used to capture the output that the function
-produces in the caller in order to process it.
-
-
-Functions
----------
-
-`child_process_init`::
-
-	Initialize a struct child_process variable.
-
-`start_command`::
-
-	Start a sub-process. Takes a pointer to a `struct child_process`
-	that specifies the details and returns pipe FDs (if requested).
-	See below for details.
-
-`finish_command`::
-
-	Wait for the completion of a sub-process that was started with
-	start_command().
-
-`run_command`::
-
-	A convenience function that encapsulates a sequence of
-	start_command() followed by finish_command(). Takes a pointer
-	to a `struct child_process` that specifies the details.
-
-`run_command_v_opt`, `run_command_v_opt_cd_env`::
-
-	Convenience functions that encapsulate a sequence of
-	start_command() followed by finish_command(). The argument argv
-	specifies the program and its arguments. The argument opt is zero
-	or more of the flags `RUN_COMMAND_NO_STDIN`, `RUN_GIT_CMD`,
-	`RUN_COMMAND_STDOUT_TO_STDERR`, or `RUN_SILENT_EXEC_FAILURE`
-	that correspond to the members .no_stdin, .git_cmd,
-	.stdout_to_stderr, .silent_exec_failure of `struct child_process`.
-	The argument dir corresponds the member .dir. The argument env
-	corresponds to the member .env.
-
-`child_process_clear`::
-
-	Release the memory associated with the struct child_process.
-	Most users of the run-command API don't need to call this
-	function explicitly because `start_command` invokes it on
-	failure and `finish_command` calls it automatically already.
-
-The functions above do the following:
-
-. If a system call failed, errno is set and -1 is returned. A diagnostic
-  is printed.
-
-. If the program was not found, then -1 is returned and errno is set to
-  ENOENT; a diagnostic is printed only if .silent_exec_failure is 0.
-
-. Otherwise, the program is run. If it terminates regularly, its exit
-  code is returned. No diagnostic is printed, even if the exit code is
-  non-zero.
-
-. If the program terminated due to a signal, then the return value is the
-  signal number + 128, ie. the same value that a POSIX shell's $? would
-  report.  A diagnostic is printed.
-
-
-`start_async`::
-
-	Run a function asynchronously. Takes a pointer to a `struct
-	async` that specifies the details and returns a set of pipe FDs
-	for communication with the function. See below for details.
-
-`finish_async`::
-
-	Wait for the completion of an asynchronous function that was
-	started with start_async().
-
-`run_hook`::
-
-	Run a hook.
-	The first argument is a pathname to an index file, or NULL
-	if the hook uses the default index file or no index is needed.
-	The second argument is the name of the hook.
-	The further arguments correspond to the hook arguments.
-	The last argument has to be NULL to terminate the arguments list.
-	If the hook does not exist or is not executable, the return
-	value will be zero.
-	If it is executable, the hook will be executed and the exit
-	status of the hook is returned.
-	On execution, .stdout_to_stderr and .no_stdin will be set.
-	(See below.)
-
-
-Data structures
----------------
-
-* `struct child_process`
-
-This describes the arguments, redirections, and environment of a
-command to run in a sub-process.
-
-The caller:
-
-1. allocates and clears (using child_process_init() or
-   CHILD_PROCESS_INIT) a struct child_process variable;
-2. initializes the members;
-3. calls start_command();
-4. processes the data;
-5. closes file descriptors (if necessary; see below);
-6. calls finish_command().
-
-The .argv member is set up as an array of string pointers (NULL
-terminated), of which .argv[0] is the program name to run (usually
-without a path). If the command to run is a git command, set argv[0] to
-the command name without the 'git-' prefix and set .git_cmd = 1.
-
-Note that the ownership of the memory pointed to by .argv stays with the
-caller, but it should survive until `finish_command` completes. If the
-.argv member is NULL, `start_command` will point it at the .args
-`argv_array` (so you may use one or the other, but you must use exactly
-one). The memory in .args will be cleaned up automatically during
-`finish_command` (or during `start_command` when it is unsuccessful).
-
-The members .in, .out, .err are used to redirect stdin, stdout,
-stderr as follows:
-
-. Specify 0 to request no special redirection. No new file descriptor
-  is allocated. The child process simply inherits the channel from the
-  parent.
-
-. Specify -1 to have a pipe allocated; start_command() replaces -1
-  by the pipe FD in the following way:
-
-	.in: Returns the writable pipe end into which the caller writes;
-		the readable end of the pipe becomes the child's stdin.
-
-	.out, .err: Returns the readable pipe end from which the caller
-		reads; the writable end of the pipe end becomes child's
-		stdout/stderr.
-
-  The caller of start_command() must close the so returned FDs
-  after it has completed reading from/writing to it!
-
-. Specify a file descriptor > 0 to be used by the child:
-
-	.in: The FD must be readable; it becomes child's stdin.
-	.out: The FD must be writable; it becomes child's stdout.
-	.err: The FD must be writable; it becomes child's stderr.
-
-  The specified FD is closed by start_command(), even if it fails to
-  run the sub-process!
-
-. Special forms of redirection are available by setting these members
-  to 1:
-
-	.no_stdin, .no_stdout, .no_stderr: The respective channel is
-		redirected to /dev/null.
-
-	.stdout_to_stderr: stdout of the child is redirected to its
-		stderr. This happens after stderr is itself redirected.
-		So stdout will follow stderr to wherever it is
-		redirected.
-
-To modify the environment of the sub-process, specify an array of
-string pointers (NULL terminated) in .env:
-
-. If the string is of the form "VAR=value", i.e. it contains '='
-  the variable is added to the child process's environment.
-
-. If the string does not contain '=', it names an environment
-  variable that will be removed from the child process's environment.
-
-If the .env member is NULL, `start_command` will point it at the
-.env_array `argv_array` (so you may use one or the other, but not both).
-The memory in .env_array will be cleaned up automatically during
-`finish_command` (or during `start_command` when it is unsuccessful).
-
-To specify a new initial working directory for the sub-process,
-specify it in the .dir member.
-
-If the program cannot be found, the functions return -1 and set
-errno to ENOENT. Normally, an error message is printed, but if
-.silent_exec_failure is set to 1, no message is printed for this
-special error condition.
-
-
-* `struct async`
-
-This describes a function to run asynchronously, whose purpose is
-to produce output that the caller reads.
-
-The caller:
-
-1. allocates and clears (memset(&asy, 0, sizeof(asy));) a
-   struct async variable;
-2. initializes .proc and .data;
-3. calls start_async();
-4. processes communicates with proc through .in and .out;
-5. closes .in and .out;
-6. calls finish_async().
-
-The members .in, .out are used to provide a set of fd's for
-communication between the caller and the callee as follows:
-
-. Specify 0 to have no file descriptor passed.  The callee will
-  receive -1 in the corresponding argument.
-
-. Specify < 0 to have a pipe allocated; start_async() replaces
-  with the pipe FD in the following way:
-
-	.in: Returns the writable pipe end into which the caller
-	writes; the readable end of the pipe becomes the function's
-	in argument.
-
-	.out: Returns the readable pipe end from which the caller
-	reads; the writable end of the pipe becomes the function's
-	out argument.
-
-  The caller of start_async() must close the returned FDs after it
-  has completed reading from/writing from them.
-
-. Specify a file descriptor > 0 to be used by the function:
-
-	.in: The FD must be readable; it becomes the function's in.
-	.out: The FD must be writable; it becomes the function's out.
-
-  The specified FD is closed by start_async(), even if it fails to
-  run the function.
-
-The function pointer in .proc has the following signature:
-
-	int proc(int in, int out, void *data);
-
-. in, out specifies a set of file descriptors to which the function
-  must read/write the data that it needs/produces.  The function
-  *must* close these descriptors before it returns.  A descriptor
-  may be -1 if the caller did not configure a descriptor for that
-  direction.
-
-. data is the value that the caller has specified in the .data member
-  of struct async.
-
-. The return value of the function is 0 on success and non-zero
-  on failure. If the function indicates failure, finish_async() will
-  report failure as well.
-
-
-There are serious restrictions on what the asynchronous function can do
-because this facility is implemented by a thread in the same address
-space on most platforms (when pthreads is available), but by a pipe to
-a forked process otherwise:
-
-. It cannot change the program's state (global variables, environment,
-  etc.) in a way that the caller notices; in other words, .in and .out
-  are the only communication channels to the caller.
-
-. It must not change the program's state that the caller of the
-  facility also uses.
diff --git a/run-command.h b/run-command.h
index f769e03f01..592d9dc035 100644
--- a/run-command.h
+++ b/run-command.h
@@ -5,8 +5,60 @@
 
 #include "argv-array.h"
 
+/**
+ * The run-command API offers a versatile tool to run sub-processes with
+ * redirected input and output as well as with a modified environment
+ * and an alternate current directory.
+ *
+ * A similar API offers the capability to run a function asynchronously,
+ * which is primarily used to capture the output that the function
+ * produces in the caller in order to process it.
+ */
+
+
+/**
+ * This describes the arguments, redirections, and environment of a
+ * command to run in a sub-process.
+ *
+ * The caller:
+ *
+ * 1. allocates and clears (using child_process_init() or
+ *    CHILD_PROCESS_INIT) a struct child_process variable;
+ * 2. initializes the members;
+ * 3. calls start_command();
+ * 4. processes the data;
+ * 5. closes file descriptors (if necessary; see below);
+ * 6. calls finish_command().
+ *
+ * Special forms of redirection are available by setting these members
+ * to 1:
+ *
+ *  .no_stdin, .no_stdout, .no_stderr: The respective channel is
+ *		redirected to /dev/null.
+ *
+ *	.stdout_to_stderr: stdout of the child is redirected to its
+ *		stderr. This happens after stderr is itself redirected.
+ *		So stdout will follow stderr to wherever it is
+ *		redirected.
+ */
 struct child_process {
+
+	/**
+	 * The .argv member is set up as an array of string pointers (NULL
+	 * terminated), of which .argv[0] is the program name to run (usually
+	 * without a path). If the command to run is a git command, set argv[0] to
+	 * the command name without the 'git-' prefix and set .git_cmd = 1.
+	 *
+	 * Note that the ownership of the memory pointed to by .argv stays with the
+	 * caller, but it should survive until `finish_command` completes. If the
+	 * .argv member is NULL, `start_command` will point it at the .args
+	 * `argv_array` (so you may use one or the other, but you must use exactly
+	 * one). The memory in .args will be cleaned up automatically during
+	 * `finish_command` (or during `start_command` when it is unsuccessful).
+	 *
+	 */
 	const char **argv;
+
 	struct argv_array args;
 	struct argv_array env_array;
 	pid_t pid;
@@ -18,8 +70,8 @@ struct child_process {
 
 	/*
 	 * Using .in, .out, .err:
-	 * - Specify 0 for no redirections (child inherits stdin, stdout,
-	 *   stderr from parent).
+	 * - Specify 0 for no redirections. No new file descriptor is allocated.
+	 * (child inherits stdin, stdout, stderr from parent).
 	 * - Specify -1 to have a pipe allocated as follows:
 	 *     .in: returns the writable pipe end; parent writes to it,
 	 *          the readable pipe end becomes child's stdin
@@ -37,13 +89,43 @@ struct child_process {
 	int in;
 	int out;
 	int err;
+
+	/**
+	 * To specify a new initial working directory for the sub-process,
+	 * specify it in the .dir member.
+	 */
 	const char *dir;
+
+	/**
+	 * To modify the environment of the sub-process, specify an array of
+	 * string pointers (NULL terminated) in .env:
+	 *
+	 * - If the string is of the form "VAR=value", i.e. it contains '='
+	 *   the variable is added to the child process's environment.
+	 *
+	 * - If the string does not contain '=', it names an environment
+	 *   variable that will be removed from the child process's environment.
+	 *
+	 * If the .env member is NULL, `start_command` will point it at the
+	 * .env_array `argv_array` (so you may use one or the other, but not both).
+	 * The memory in .env_array will be cleaned up automatically during
+	 * `finish_command` (or during `start_command` when it is unsuccessful).
+	 */
 	const char *const *env;
+
 	unsigned no_stdin:1;
 	unsigned no_stdout:1;
 	unsigned no_stderr:1;
-	unsigned git_cmd:1; /* if this is to be git sub-command */
+    unsigned git_cmd:1; /* if this is to be git sub-command */
+
+	/**
+	 * If the program cannot be found, the functions return -1 and set
+	 * errno to ENOENT. Normally, an error message is printed, but if
+	 * .silent_exec_failure is set to 1, no message is printed for this
+	 * special error condition.
+	 */
 	unsigned silent_exec_failure:1;
+
 	unsigned stdout_to_stderr:1;
 	unsigned use_shell:1;
 	unsigned clean_on_exit:1;
@@ -53,13 +135,63 @@ struct child_process {
 };
 
 #define CHILD_PROCESS_INIT { NULL, ARGV_ARRAY_INIT, ARGV_ARRAY_INIT }
+
+/**
+ * The functions: child_process_init, start_command, finish_command,
+ * run_command, run_command_v_opt, run_command_v_opt_cd_env, child_process_clear
+ * do the following:
+ *
+ * - If a system call failed, errno is set and -1 is returned. A diagnostic
+ *   is printed.
+ *
+ * - If the program was not found, then -1 is returned and errno is set to
+ *   ENOENT; a diagnostic is printed only if .silent_exec_failure is 0.
+ *
+ * - Otherwise, the program is run. If it terminates regularly, its exit
+ *   code is returned. No diagnostic is printed, even if the exit code is
+ *   non-zero.
+ *
+ * - If the program terminated due to a signal, then the return value is the
+ *   signal number + 128, ie. the same value that a POSIX shell's $? would
+ *   report.  A diagnostic is printed.
+ *
+ */
+
+/**
+ * Initialize a struct child_process variable.
+ */
 void child_process_init(struct child_process *);
+
+/**
+ * Release the memory associated with the struct child_process.
+ * Most users of the run-command API don't need to call this
+ * function explicitly because `start_command` invokes it on
+ * failure and `finish_command` calls it automatically already.
+ */
 void child_process_clear(struct child_process *);
+
 int is_executable(const char *name);
 
+/**
+ * Start a sub-process. Takes a pointer to a `struct child_process`
+ * that specifies the details and returns pipe FDs (if requested).
+ * See below for details.
+ */
 int start_command(struct child_process *);
+
+/**
+ * Wait for the completion of a sub-process that was started with
+ * start_command().
+ */
 int finish_command(struct child_process *);
+
 int finish_command_in_signal(struct child_process *);
+
+/**
+ * A convenience function that encapsulates a sequence of
+ * start_command() followed by finish_command(). Takes a pointer
+ * to a `struct child_process` that specifies the details.
+ */
 int run_command(struct child_process *);
 
 /*
@@ -68,6 +200,20 @@ int run_command(struct child_process *);
  * overwritten by further calls to find_hook and run_hook_*.
  */
 const char *find_hook(const char *name);
+
+/**
+ * Run a hook.
+ * The first argument is a pathname to an index file, or NULL
+ * if the hook uses the default index file or no index is needed.
+ * The second argument is the name of the hook.
+ * The further arguments correspond to the hook arguments.
+ * The last argument has to be NULL to terminate the arguments list.
+ * If the hook does not exist or is not executable, the return
+ * value will be zero.
+ * If it is executable, the hook will be executed and the exit
+ * status of the hook is returned.
+ * On execution, .stdout_to_stderr and .no_stdin will be set.
+ */
 LAST_ARG_MUST_BE_NULL
 int run_hook_le(const char *const *env, const char *name, ...);
 int run_hook_ve(const char *const *env, const char *name, va_list args);
@@ -78,6 +224,18 @@ int run_hook_ve(const char *const *env, const char *name, va_list args);
 #define RUN_SILENT_EXEC_FAILURE 8
 #define RUN_USING_SHELL 16
 #define RUN_CLEAN_ON_EXIT 32
+
+/**
+ * Convenience functions that encapsulate a sequence of
+ * start_command() followed by finish_command(). The argument argv
+ * specifies the program and its arguments. The argument opt is zero
+ * or more of the flags `RUN_COMMAND_NO_STDIN`, `RUN_GIT_CMD`,
+ * `RUN_COMMAND_STDOUT_TO_STDERR`, or `RUN_SILENT_EXEC_FAILURE`
+ * that correspond to the members .no_stdin, .git_cmd,
+ * .stdout_to_stderr, .silent_exec_failure of `struct child_process`.
+ * The argument dir corresponds the member .dir. The argument env
+ * corresponds to the member .env.
+ */
 int run_command_v_opt(const char **argv, int opt);
 int run_command_v_opt_tr2(const char **argv, int opt, const char *tr2_class);
 /*
@@ -125,15 +283,84 @@ static inline int capture_command(struct child_process *cmd,
  * It is expected that no synchronization and mutual exclusion between
  * the caller and the feed function is necessary so that the function
  * can run in a thread without interfering with the caller.
+ *
+ * The caller:
+ *
+ * 1. allocates and clears (memset(&asy, 0, sizeof(asy));) a
+ *    struct async variable;
+ * 2. initializes .proc and .data;
+ * 3. calls start_async();
+ * 4. processes communicates with proc through .in and .out;
+ * 5. closes .in and .out;
+ * 6. calls finish_async().
+ *
+ * There are serious restrictions on what the asynchronous function can do
+ * because this facility is implemented by a thread in the same address
+ * space on most platforms (when pthreads is available), but by a pipe to
+ * a forked process otherwise:
+ *
+ * - It cannot change the program's state (global variables, environment,
+ *   etc.) in a way that the caller notices; in other words, .in and .out
+ *   are the only communication channels to the caller.
+ *
+ * - It must not change the program's state that the caller of the
+ *   facility also uses.
+ *
  */
 struct async {
-	/*
-	 * proc reads from in; closes it before return
-	 * proc writes to out; closes it before return
-	 * returns 0 on success, non-zero on failure
+
+	/**
+	 * The function pointer in .proc has the following signature:
+	 *
+	 *	int proc(int in, int out, void *data);
+	 *
+	 * - in, out specifies a set of file descriptors to which the function
+	 *  must read/write the data that it needs/produces.  The function
+	 *  *must* close these descriptors before it returns.  A descriptor
+	 *  may be -1 if the caller did not configure a descriptor for that
+	 *  direction.
+	 *
+	 * - data is the value that the caller has specified in the .data member
+	 *  of struct async.
+	 *
+	 * - The return value of the function is 0 on success and non-zero
+	 *  on failure. If the function indicates failure, finish_async() will
+	 *  report failure as well.
+	 *
 	 */
 	int (*proc)(int in, int out, void *data);
+
 	void *data;
+
+	/**
+	 * The members .in, .out are used to provide a set of fd's for
+	 * communication between the caller and the callee as follows:
+	 *
+	 * - Specify 0 to have no file descriptor passed.  The callee will
+	 *   receive -1 in the corresponding argument.
+	 *
+	 * - Specify < 0 to have a pipe allocated; start_async() replaces
+	 *   with the pipe FD in the following way:
+	 *
+	 * 	.in: Returns the writable pipe end into which the caller
+	 * 	writes; the readable end of the pipe becomes the function's
+	 * 	in argument.
+	 *
+	 * 	.out: Returns the readable pipe end from which the caller
+	 * 	reads; the writable end of the pipe becomes the function's
+	 * 	out argument.
+	 *
+	 *   The caller of start_async() must close the returned FDs after it
+	 *   has completed reading from/writing from them.
+	 *
+	 * - Specify a file descriptor > 0 to be used by the function:
+	 *
+	 * 	.in: The FD must be readable; it becomes the function's in.
+	 * 	.out: The FD must be writable; it becomes the function's out.
+	 *
+	 *   The specified FD is closed by start_async(), even if it fails to
+	 *   run the function.
+	 */
 	int in;		/* caller writes here and closes it */
 	int out;	/* caller reads from here and closes it */
 #ifdef NO_PTHREADS
@@ -146,8 +373,19 @@ struct async {
 	int isolate_sigpipe;
 };
 
+/**
+ * Run a function asynchronously. Takes a pointer to a `struct
+ * async` that specifies the details and returns a set of pipe FDs
+ * for communication with the function. See below for details.
+ */
 int start_async(struct async *async);
+
+/**
+ * Wait for the completion of an asynchronous function that was
+ * started with start_async().
+ */
 int finish_async(struct async *async);
+
 int in_async(void);
 int async_with_fork(void);
 void check_pipe(int err);
-- 
gitgitgadget

