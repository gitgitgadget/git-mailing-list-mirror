Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.2 (2018-09-13) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-4.3 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,RCVD_IN_DNSWL_HI
	shortcircuit=no autolearn=ham autolearn_force=no version=3.4.2
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 5296D1F453
	for <e@80x24.org>; Wed,  6 Feb 2019 17:16:16 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1731600AbfBFRQO (ORCPT <rfc822;e@80x24.org>);
        Wed, 6 Feb 2019 12:16:14 -0500
Received: from mail-ed1-f65.google.com ([209.85.208.65]:44701 "EHLO
        mail-ed1-f65.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1731590AbfBFRQK (ORCPT <rfc822;git@vger.kernel.org>);
        Wed, 6 Feb 2019 12:16:10 -0500
Received: by mail-ed1-f65.google.com with SMTP id y56so6518770edd.11
        for <git@vger.kernel.org>; Wed, 06 Feb 2019 09:16:07 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=date:message-id:in-reply-to:references:from:subject:fcc
         :content-transfer-encoding:mime-version:to:cc;
        bh=jw0aoFVSsQb4EAfyObvvy2qU6tcuTctjwYVBVozVUfE=;
        b=pWG6nbKZrDvFhtEY81fBIhnHze0XJmASdgnyTEr/s6cWhNz6bDShDqI1fZpKEPg0c/
         ufF9JbGz5xrPu3oMqPXQGTBI9bDN9KuDzk/88RB5amV+D3yxE94eTI0yqGzyDPaKXmcD
         ycRilOk/iX8+xDEp+rgPCJ03qSZO0uiQnQLjk9QQM3hZRStGYz9Cu7muXqToAqx+5YCh
         9FS+apIaGp78MEZjJm0C6KGs8wqZO2oHFgKV55IdK+EHYdlmLPZUioZ8iZjUQvqatwkg
         +ldTFYcFzM7LHXCgUtqDQgM1UP3Ggqq5a5jAcu7JndP30BX8H0MwvFh4kRTum6kz7AcD
         VAyA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:message-id:in-reply-to:references:from
         :subject:fcc:content-transfer-encoding:mime-version:to:cc;
        bh=jw0aoFVSsQb4EAfyObvvy2qU6tcuTctjwYVBVozVUfE=;
        b=LH+89j1E2cJ9v6o5HSc1sh1xRHQdPnjFFLyMWFal8U0YGdviTW9ja3uieDm7nMNO5l
         56YZh98FxjHQNre1SEU/cCJ3/p+sx5/z5SmRpbODBhaypUV8SCityleyfS/RlKgUuNWS
         SGyHkOCvxQ3N4ayfWIIQvO/sVTcjEsCdjfap0/ujUCH1okUUh2O/nVLyX3skxaSMcidF
         EtaOzgAGVrIQdCF4i3pC41jAu5OfBdF5dUAw2vkJeWNL3EJLLhb2j+YnEgfK6DuHbSna
         K7Ha09gAdtkHnSCamQqXfujb40idNTThynzoOsYXQhUDYstaG8AvHUenKJpRgElx2srk
         0ndg==
X-Gm-Message-State: AHQUAuY5aLxVGJgYrsibmnOUTe7c++t3J2WGrp/koUoy1NiaaEy2FC+Y
        v8v2X86wAr0M518AXV/XBCH5MSW+
X-Google-Smtp-Source: AHgI3IblkcGDPLd215pqWvt449ZCGN2wCqL0UzdLE3SEOnrVrVoHJlz03oBXXSpgOVeZ17ZaQT9T5g==
X-Received: by 2002:aa7:dc49:: with SMTP id g9mr3255450edu.93.1549473365824;
        Wed, 06 Feb 2019 09:16:05 -0800 (PST)
Received: from [127.0.0.1] ([13.74.141.28])
        by smtp.gmail.com with ESMTPSA id s3sm6126015edm.31.2019.02.06.09.16.05
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Wed, 06 Feb 2019 09:16:05 -0800 (PST)
Date:   Wed, 06 Feb 2019 09:16:05 -0800 (PST)
X-Google-Original-Date: Wed, 06 Feb 2019 17:15:49 GMT
Message-Id: <b9f0c6fd66ea1ed8570fe2f79a7a2ca1d69c0f51.1549473350.git.gitgitgadget@gmail.com>
In-Reply-To: <pull.108.v6.git.gitgitgadget@gmail.com>
References: <pull.108.v5.git.gitgitgadget@gmail.com>
        <pull.108.v6.git.gitgitgadget@gmail.com>
From:   "Jeff Hostetler via GitGitGadget" <gitgitgadget@gmail.com>
Subject: [PATCH v6 14/15] trace2: t/helper/test-trace2, t0210.sh, t0211.sh,
 t0212.sh
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

Create unit tests for Trace2.

Signed-off-by: Jeff Hostetler <jeffhost@microsoft.com>
---
 Makefile                  |   1 +
 t/helper/test-tool.c      |   1 +
 t/helper/test-tool.h      |   1 +
 t/helper/test-trace2.c    | 273 ++++++++++++++++++++++++++++++++++++++
 t/t0210-trace2-normal.sh  | 135 +++++++++++++++++++
 t/t0210/scrub_normal.perl |  48 +++++++
 t/t0211-trace2-perf.sh    | 153 +++++++++++++++++++++
 t/t0211/scrub_perf.perl   |  76 +++++++++++
 t/t0212-trace2-event.sh   | 234 ++++++++++++++++++++++++++++++++
 t/t0212/parse_events.perl | 251 +++++++++++++++++++++++++++++++++++
 10 files changed, 1173 insertions(+)
 create mode 100644 t/helper/test-trace2.c
 create mode 100755 t/t0210-trace2-normal.sh
 create mode 100644 t/t0210/scrub_normal.perl
 create mode 100755 t/t0211-trace2-perf.sh
 create mode 100644 t/t0211/scrub_perf.perl
 create mode 100755 t/t0212-trace2-event.sh
 create mode 100644 t/t0212/parse_events.perl

diff --git a/Makefile b/Makefile
index 2ab7b73000..040f5846d2 100644
--- a/Makefile
+++ b/Makefile
@@ -762,6 +762,7 @@ TEST_BUILTINS_OBJS += test-string-list.o
 TEST_BUILTINS_OBJS += test-submodule-config.o
 TEST_BUILTINS_OBJS += test-submodule-nested-repo-config.o
 TEST_BUILTINS_OBJS += test-subprocess.o
+TEST_BUILTINS_OBJS += test-trace2.o
 TEST_BUILTINS_OBJS += test-urlmatch-normalization.o
 TEST_BUILTINS_OBJS += test-wildmatch.o
 TEST_BUILTINS_OBJS += test-windows-named-pipe.o
diff --git a/t/helper/test-tool.c b/t/helper/test-tool.c
index 4dbfff7dee..25b1294353 100644
--- a/t/helper/test-tool.c
+++ b/t/helper/test-tool.c
@@ -51,6 +51,7 @@ static struct test_cmd cmds[] = {
 	{ "submodule-config", cmd__submodule_config },
 	{ "submodule-nested-repo-config", cmd__submodule_nested_repo_config },
 	{ "subprocess", cmd__subprocess },
+	{ "trace2", cmd__trace2 },
 	{ "urlmatch-normalization", cmd__urlmatch_normalization },
 	{ "wildmatch", cmd__wildmatch },
 #ifdef GIT_WINDOWS_NATIVE
diff --git a/t/helper/test-tool.h b/t/helper/test-tool.h
index ca5c88edb2..61d2938ce5 100644
--- a/t/helper/test-tool.h
+++ b/t/helper/test-tool.h
@@ -46,6 +46,7 @@ int cmd__string_list(int argc, const char **argv);
 int cmd__submodule_config(int argc, const char **argv);
 int cmd__submodule_nested_repo_config(int argc, const char **argv);
 int cmd__subprocess(int argc, const char **argv);
+int cmd__trace2(int argc, const char **argv);
 int cmd__urlmatch_normalization(int argc, const char **argv);
 int cmd__wildmatch(int argc, const char **argv);
 #ifdef GIT_WINDOWS_NATIVE
diff --git a/t/helper/test-trace2.c b/t/helper/test-trace2.c
new file mode 100644
index 0000000000..197819c872
--- /dev/null
+++ b/t/helper/test-trace2.c
@@ -0,0 +1,273 @@
+#include "test-tool.h"
+#include "cache.h"
+#include "argv-array.h"
+#include "run-command.h"
+#include "exec-cmd.h"
+#include "config.h"
+
+typedef int(fn_unit_test)(int argc, const char **argv);
+
+struct unit_test {
+	fn_unit_test *ut_fn;
+	const char *ut_name;
+	const char *ut_usage;
+};
+
+#define MyOk 0
+#define MyError 1
+
+static int get_i(int *p_value, const char *data)
+{
+	char *endptr;
+
+	if (!data || !*data)
+		return MyError;
+
+	*p_value = strtol(data, &endptr, 10);
+	if (*endptr || errno == ERANGE)
+		return MyError;
+
+	return MyOk;
+}
+
+/*
+ * Cause process to exit with the requested value via "return".
+ *
+ * Rely on test-tool.c:cmd_main() to call trace2_cmd_exit()
+ * with our result.
+ *
+ * Test harness can confirm:
+ * [] the process-exit value.
+ * [] the "code" field in the "exit" trace2 event.
+ * [] the "code" field in the "atexit" trace2 event.
+ * [] the "name" field in the "cmd_name" trace2 event.
+ * [] "def_param" events for all of the "interesting" pre-defined
+ * config settings.
+ */
+static int ut_001return(int argc, const char **argv)
+{
+	int rc;
+
+	if (get_i(&rc, argv[0]))
+		die("expect <exit_code>");
+
+	return rc;
+}
+
+/*
+ * Cause the process to exit with the requested value via "exit()".
+ *
+ * Test harness can confirm:
+ * [] the "code" field in the "exit" trace2 event.
+ * [] the "code" field in the "atexit" trace2 event.
+ * [] the "name" field in the "cmd_name" trace2 event.
+ * [] "def_param" events for all of the "interesting" pre-defined
+ * config settings.
+ */
+static int ut_002exit(int argc, const char **argv)
+{
+	int rc;
+
+	if (get_i(&rc, argv[0]))
+		die("expect <exit_code>");
+
+	exit(rc);
+}
+
+/*
+ * Send an "error" event with each value in argv.  Normally, git only issues
+ * a single "error" event immediately before issuing an "exit" event (such
+ * as in die() or BUG()), but multiple "error" events are allowed.
+ *
+ * Test harness can confirm:
+ * [] a trace2 "error" event for each value in argv.
+ * [] the "name" field in the "cmd_name" trace2 event.
+ * [] (optional) the file:line in the "exit" event refers to this function.
+ */
+static int ut_003error(int argc, const char **argv)
+{
+	int k;
+
+	if (!argv[0] || !*argv[0])
+		die("expect <error_message>");
+
+	for (k = 0; k < argc; k++)
+		error("%s", argv[k]);
+
+	return 0;
+}
+
+/*
+ * Run a child process and wait for it to finish and exit with its return code.
+ * test-tool trace2 004child [<child-command-line>]
+ *
+ * For example:
+ * test-tool trace2 004child git version
+ * test-tool trace2 004child test-tool trace2 001return 0
+ * test-tool trace2 004child test-tool trace2 004child test-tool trace2 004child
+ * test-tool trace2 004child git -c alias.xyz=version xyz
+ *
+ * Test harness can confirm:
+ * [] the "name" field in the "cmd_name" trace2 event.
+ * [] that the outer process has a single component SID (or depth "d0" in
+ *    the PERF stream).
+ * [] that "child_start" and "child_exit" events are generated for the child.
+ * [] if the child process is an instrumented executable:
+ *    [] that "version", "start", ..., "exit", and "atexit" events are
+ *       generated by the child process.
+ *    [] that the child process events have a multiple component SID (or
+ *       depth "dN+1" in the PERF stream).
+ * [] that the child exit code is propagated to the parent process "exit"
+ *    and "atexit" events..
+ * [] (optional) that the "t_abs" field in the child process "atexit" event
+ *    is less than the "t_rel" field in the "child_exit" event of the parent
+ *    process.
+ * [] if the child process is like the alias example above,
+ *    [] (optional) the child process attempts to run "git-xyx" as a dashed
+ *       command.
+ *    [] the child process emits an "alias" event with "xyz" => "version"
+ *    [] the child process runs "git version" as a child process.
+ *    [] the child process has a 3 component SID (or depth "d2" in the PERF
+ *       stream).
+ */
+static int ut_004child(int argc, const char **argv)
+{
+	int result;
+
+	/*
+	 * Allow empty <child_command_line> so we can do arbitrarily deep
+	 * command nesting and let the last one be null.
+	 */
+	if (!argc)
+		return 0;
+
+	result = run_command_v_opt(argv, 0);
+	exit(result);
+}
+
+/*
+ * Exec a git command.  This may either create a child process (Windows)
+ * or replace the existing process.
+ * test-tool trace2 005exec <git_command_args>
+ *
+ * For example:
+ * test-tool trace2 005exec version
+ *
+ * Test harness can confirm (on Windows):
+ * [] the "name" field in the "cmd_name" trace2 event.
+ * [] that the outer process has a single component SID (or depth "d0" in
+ *    the PERF stream).
+ * [] that "exec" and "exec_result" events are generated for the child
+ *    process (since the Windows compatibility layer fakes an exec() with
+ *    a CreateProcess(), WaitForSingleObject(), and exit()).
+ * [] that the child process has multiple component SID (or depth "dN+1"
+ *    in the PERF stream).
+ *
+ * Test harness can confirm (on platforms with a real exec() function):
+ * [] TODO talk about process replacement and how it affects SID.
+ */
+static int ut_005exec(int argc, const char **argv)
+{
+	int result;
+
+	if (!argc)
+		return 0;
+
+	result = execv_git_cmd(argv);
+	return result;
+}
+
+static int ut_006data(int argc, const char **argv)
+{
+	const char *usage_error =
+		"expect <cat0> <k0> <v0> [<cat1> <k1> <v1> [...]]";
+
+	if (argc % 3 != 0)
+		die("%s", usage_error);
+
+	while (argc) {
+		if (!argv[0] || !*argv[0] || !argv[1] || !*argv[1] ||
+		    !argv[2] || !*argv[2])
+			die("%s", usage_error);
+
+		trace2_data_string(argv[0], the_repository, argv[1], argv[2]);
+		argv += 3;
+		argc -= 3;
+	}
+
+	return 0;
+}
+
+/*
+ * Usage:
+ *     test-tool trace2 <ut_name_1> <ut_usage_1>
+ *     test-tool trace2 <ut_name_2> <ut_usage_2>
+ *     ...
+ */
+#define USAGE_PREFIX "test-tool trace2"
+
+/* clang-format off */
+static struct unit_test ut_table[] = {
+	{ ut_001return,   "001return", "<exit_code>" },
+	{ ut_002exit,     "002exit",   "<exit_code>" },
+	{ ut_003error,    "003error",  "<error_message>+" },
+	{ ut_004child,    "004child",  "[<child_command_line>]" },
+	{ ut_005exec,     "005exec",   "<git_command_args>" },
+	{ ut_006data,     "006data",   "[<category> <key> <value>]+" },
+};
+/* clang-format on */
+
+/* clang-format off */
+#define for_each_ut(k, ut_k)			\
+	for (k = 0, ut_k = &ut_table[k];	\
+	     k < ARRAY_SIZE(ut_table);		\
+	     k++, ut_k = &ut_table[k])
+/* clang-format on */
+
+static int print_usage(void)
+{
+	int k;
+	struct unit_test *ut_k;
+
+	fprintf(stderr, "usage:\n");
+	for_each_ut (k, ut_k)
+		fprintf(stderr, "\t%s %s %s\n", USAGE_PREFIX, ut_k->ut_name,
+			ut_k->ut_usage);
+
+	return 129;
+}
+
+/*
+ * Issue various trace2 events for testing.
+ *
+ * We assume that these trace2 routines has already been called:
+ *    [] trace2_initialize()      [common-main.c:main()]
+ *    [] trace2_cmd_start()       [common-main.c:main()]
+ *    [] trace2_cmd_name()        [test-tool.c:cmd_main()]
+ *    [] tracd2_cmd_list_config() [test-tool.c:cmd_main()]
+ * So that:
+ *    [] the various trace2 streams are open.
+ *    [] the process SID has been created.
+ *    [] the "version" event has been generated.
+ *    [] the "start" event has been generated.
+ *    [] the "cmd_name" event has been generated.
+ *    [] this writes various "def_param" events for interesting config values.
+ *
+ * We further assume that if we return (rather than exit()), trace2_cmd_exit()
+ * will be called by test-tool.c:cmd_main().
+ */
+int cmd__trace2(int argc, const char **argv)
+{
+	int k;
+	struct unit_test *ut_k;
+
+	argc--; /* skip over "trace2" arg */
+	argv++;
+
+	if (argc)
+		for_each_ut (k, ut_k)
+			if (!strcmp(argv[0], ut_k->ut_name))
+				return ut_k->ut_fn(argc - 1, argv + 1);
+
+	return print_usage();
+}
diff --git a/t/t0210-trace2-normal.sh b/t/t0210-trace2-normal.sh
new file mode 100755
index 0000000000..03a0aedb1d
--- /dev/null
+++ b/t/t0210-trace2-normal.sh
@@ -0,0 +1,135 @@
+#!/bin/sh
+
+test_description='test trace2 facility (normal target)'
+. ./test-lib.sh
+
+# Add t/helper directory to PATH so that we can use a relative
+# path to run nested instances of test-tool.exe (see 004child).
+# This helps with HEREDOC comparisons later.
+TTDIR="$GIT_BUILD_DIR/t/helper/" && export TTDIR
+PATH="$TTDIR:$PATH" && export PATH
+
+# Warning: use of 'test_cmp' may run test-tool.exe and/or git.exe
+# Warning: to do the actual diff/comparison, so the HEREDOCs here
+# Warning: only cover our actual calls to test-tool and/or git.
+# Warning: So you may see extra lines in artifact files when
+# Warning: interactively debugging.
+
+# Turn off any inherited trace2 settings for this test.
+unset GIT_TR2 GIT_TR2_PERF GIT_TR2_EVENT
+unset GIT_TR2_BRIEF
+unset GIT_TR2_CONFIG_PARAMS
+
+V=$(git version | sed -e 's/^git version //') && export V
+
+# There are multiple trace2 targets: normal, perf, and event.
+# Trace2 events will/can be written to each active target (subject
+# to whatever filtering that target decides to do).
+# This script tests the normal target in isolation.
+#
+# Defer setting GIT_TR2 until the actual command line we want to test
+# because hidden git and test-tool commands run by the test harness
+# can contaminate our output.
+
+# Enable "brief" feature which turns off "<clock> <file>:<line> " prefix.
+GIT_TR2_BRIEF=1 && export GIT_TR2_BRIEF
+
+# Basic tests of the trace2 normal stream.  Since this stream is used
+# primarily with printf-style debugging/tracing, we do limited testing
+# here.
+#
+# We do confirm the following API features:
+# [] the 'version <v>' event
+# [] the 'start <argv>' event
+# [] the 'cmd_name <name>' event
+# [] the 'exit <time> code:<code>' event
+# [] the 'atexit <time> code:<code>' event
+#
+# Fields of the form _FIELD_ are tokens that have been replaced (such
+# as the elapsed time).
+
+# Verb 001return
+#
+# Implicit return from cmd_<verb> function propagates <code>.
+
+test_expect_success 'normal stream, return code 0' '
+	test_when_finished "rm trace.normal actual expect" &&
+	GIT_TR2="$(pwd)/trace.normal" test-tool trace2 001return 0 &&
+	perl "$TEST_DIRECTORY/t0210/scrub_normal.perl" <trace.normal >actual &&
+	cat >expect <<-EOF &&
+		version $V
+		start _EXE_ trace2 001return 0
+		cmd_name trace2 (trace2)
+		exit elapsed:_TIME_ code:0
+		atexit elapsed:_TIME_ code:0
+	EOF
+	test_cmp expect actual
+'
+
+test_expect_success 'normal stream, return code 1' '
+	test_when_finished "rm trace.normal actual expect" &&
+	test_must_fail env GIT_TR2="$(pwd)/trace.normal" test-tool trace2 001return 1 &&
+	perl "$TEST_DIRECTORY/t0210/scrub_normal.perl" <trace.normal >actual &&
+	cat >expect <<-EOF &&
+		version $V
+		start _EXE_ trace2 001return 1
+		cmd_name trace2 (trace2)
+		exit elapsed:_TIME_ code:1
+		atexit elapsed:_TIME_ code:1
+	EOF
+	test_cmp expect actual
+'
+
+# Verb 002exit
+#
+# Explicit exit(code) from within cmd_<verb> propagates <code>.
+
+test_expect_success 'normal stream, exit code 0' '
+	test_when_finished "rm trace.normal actual expect" &&
+	GIT_TR2="$(pwd)/trace.normal" test-tool trace2 002exit 0 &&
+	perl "$TEST_DIRECTORY/t0210/scrub_normal.perl" <trace.normal >actual &&
+	cat >expect <<-EOF &&
+		version $V
+		start _EXE_ trace2 002exit 0
+		cmd_name trace2 (trace2)
+		exit elapsed:_TIME_ code:0
+		atexit elapsed:_TIME_ code:0
+	EOF
+	test_cmp expect actual
+'
+
+test_expect_success 'normal stream, exit code 1' '
+	test_when_finished "rm trace.normal actual expect" &&
+	test_must_fail env GIT_TR2="$(pwd)/trace.normal" test-tool trace2 002exit 1 &&
+	perl "$TEST_DIRECTORY/t0210/scrub_normal.perl" <trace.normal >actual &&
+	cat >expect <<-EOF &&
+		version $V
+		start _EXE_ trace2 002exit 1
+		cmd_name trace2 (trace2)
+		exit elapsed:_TIME_ code:1
+		atexit elapsed:_TIME_ code:1
+	EOF
+	test_cmp expect actual
+'
+
+# Verb 003error
+#
+# To the above, add multiple 'error <msg>' events
+
+test_expect_success 'normal stream, error event' '
+	test_when_finished "rm trace.normal actual expect" &&
+	GIT_TR2="$(pwd)/trace.normal" test-tool trace2 003error "hello world" "this is a test" &&
+	perl "$TEST_DIRECTORY/t0210/scrub_normal.perl" <trace.normal >actual &&
+	cat >expect <<-EOF &&
+		version $V
+		start _EXE_ trace2 003error '\''hello world'\'' '\''this is a test'\''
+		cmd_name trace2 (trace2)
+		error hello world
+		error this is a test
+		exit elapsed:_TIME_ code:0
+		atexit elapsed:_TIME_ code:0
+	EOF
+	test_cmp expect actual
+'
+
+test_done
diff --git a/t/t0210/scrub_normal.perl b/t/t0210/scrub_normal.perl
new file mode 100644
index 0000000000..c65d1a815e
--- /dev/null
+++ b/t/t0210/scrub_normal.perl
@@ -0,0 +1,48 @@
+#!/usr/bin/perl
+#
+# Scrub the variable fields from the normal trace2 output to
+# make testing easier.
+
+use strict;
+use warnings;
+
+my $float = '[0-9]*\.[0-9]+([eE][-+]?[0-9]+)?';
+
+# This code assumes that the trace2 data was written with bare
+# turned on (which omits the "<clock> <file>:<line>" prefix.
+
+while (<>) {
+    # Various messages include an elapsed time in the middle
+    # of the message.  Replace the time with a placeholder to
+    # simplify our HEREDOC in the test script.
+    s/elapsed:$float/elapsed:_TIME_/g;
+
+    my $line = $_;
+
+    # we expect:
+    #    start <argv0> [<argv1> [<argv2> [...]]]
+    #
+    # where argv0 might be a relative or absolute path, with
+    # or without quotes, and platform dependent.  Replace argv0
+    # with a token for HEREDOC matching in the test script.
+
+    if ($line =~ m/^start/) {
+	$line =~ /^start\s+(.*)/;
+	my $argv = $1;
+	$argv =~ m/(\'[^\']*\'|[^ ]+)\s+(.*)/;
+	my $argv_0 = $1;
+	my $argv_rest = $2;
+
+	print "start _EXE_ $argv_rest\n";
+    }
+    elsif ($line =~ m/^cmd_path/) {
+	# Likewise, the 'cmd_path' message breaks out argv[0].
+	#
+	# This line is only emitted when RUNTIME_PREFIX is defined,
+	# so just omit it for testing purposes.
+	# print "cmd_path _EXE_\n";
+    }
+    else {
+	print "$line";
+    }
+}
diff --git a/t/t0211-trace2-perf.sh b/t/t0211-trace2-perf.sh
new file mode 100755
index 0000000000..953e2f7847
--- /dev/null
+++ b/t/t0211-trace2-perf.sh
@@ -0,0 +1,153 @@
+#!/bin/sh
+
+test_description='test trace2 facility (perf target)'
+. ./test-lib.sh
+
+# Add t/helper directory to PATH so that we can use a relative
+# path to run nested instances of test-tool.exe (see 004child).
+# This helps with HEREDOC comparisons later.
+TTDIR="$GIT_BUILD_DIR/t/helper/" && export TTDIR
+PATH="$TTDIR:$PATH" && export PATH
+
+# Warning: use of 'test_cmp' may run test-tool.exe and/or git.exe
+# Warning: to do the actual diff/comparison, so the HEREDOCs here
+# Warning: only cover our actual calls to test-tool and/or git.
+# Warning: So you may see extra lines in artifact files when
+# Warning: interactively debugging.
+
+# Turn off any inherited trace2 settings for this test.
+unset GIT_TR2 GIT_TR2_PERF GIT_TR2_EVENT
+unset GIT_TR2_PERF_BRIEF
+unset GIT_TR2_CONFIG_PARAMS
+
+V=$(git version | sed -e 's/^git version //') && export V
+
+# There are multiple trace2 targets: normal, perf, and event.
+# Trace2 events will/can be written to each active target (subject
+# to whatever filtering that target decides to do).
+# Test each target independently.
+#
+# Defer setting GIT_TR2_PERF until the actual command we want to
+# test because hidden git and test-tool commands in the test
+# harness can contaminate our output.
+
+# Enable "brief" feature which turns off the prefix:
+#     "<clock> <file>:<line> | <nr_parents> | "
+GIT_TR2_PERF_BRIEF=1 && export GIT_TR2_PERF_BRIEF
+
+# Repeat some of the t0210 tests using the perf target stream instead of
+# the normal stream.
+#
+# Tokens here of the form _FIELD_ have been replaced in the observed output.
+
+# Verb 001return
+#
+# Implicit return from cmd_<verb> function propagates <code>.
+
+test_expect_success 'perf stream, return code 0' '
+	test_when_finished "rm trace.perf actual expect" &&
+	GIT_TR2_PERF="$(pwd)/trace.perf" test-tool trace2 001return 0 &&
+	perl "$TEST_DIRECTORY/t0211/scrub_perf.perl" <trace.perf >actual &&
+	cat >expect <<-EOF &&
+		d0|main|version|||||$V
+		d0|main|start|||||_EXE_ trace2 001return 0
+		d0|main|cmd_name|||||trace2 (trace2)
+		d0|main|exit||_T_ABS_|||code:0
+		d0|main|atexit||_T_ABS_|||code:0
+	EOF
+	test_cmp expect actual
+'
+
+test_expect_success 'perf stream, return code 1' '
+	test_when_finished "rm trace.perf actual expect" &&
+	test_must_fail env GIT_TR2_PERF="$(pwd)/trace.perf" test-tool trace2 001return 1 &&
+	perl "$TEST_DIRECTORY/t0211/scrub_perf.perl" <trace.perf >actual &&
+	cat >expect <<-EOF &&
+		d0|main|version|||||$V
+		d0|main|start|||||_EXE_ trace2 001return 1
+		d0|main|cmd_name|||||trace2 (trace2)
+		d0|main|exit||_T_ABS_|||code:1
+		d0|main|atexit||_T_ABS_|||code:1
+	EOF
+	test_cmp expect actual
+'
+
+# Verb 003error
+#
+# To the above, add multiple 'error <msg>' events
+
+test_expect_success 'perf stream, error event' '
+	test_when_finished "rm trace.perf actual expect" &&
+	GIT_TR2_PERF="$(pwd)/trace.perf" test-tool trace2 003error "hello world" "this is a test" &&
+	perl "$TEST_DIRECTORY/t0211/scrub_perf.perl" <trace.perf >actual &&
+	cat >expect <<-EOF &&
+		d0|main|version|||||$V
+		d0|main|start|||||_EXE_ trace2 003error '\''hello world'\'' '\''this is a test'\''
+		d0|main|cmd_name|||||trace2 (trace2)
+		d0|main|error|||||hello world
+		d0|main|error|||||this is a test
+		d0|main|exit||_T_ABS_|||code:0
+		d0|main|atexit||_T_ABS_|||code:0
+	EOF
+	test_cmp expect actual
+'
+
+# Verb 004child
+#
+# Test nested spawning of child processes.
+#
+# Conceptually, this looks like:
+#    P1: TT trace2 004child
+#    P2: |--- TT trace2 004child
+#    P3:      |--- TT trace2 001return 0
+#
+# Which should generate events:
+#    P1: version
+#    P1: start
+#    P1: cmd_name
+#    P1: child_start
+#        P2: version
+#        P2: start
+#        P2: cmd_name
+#        P2: child_start
+#            P3: version
+#            P3: start
+#            P3: cmd_name
+#            P3: exit
+#            P3: atexit
+#        P2: child_exit
+#        P2: exit
+#        P2: atexit
+#    P1: child_exit
+#    P1: exit
+#    P1: atexit
+
+test_expect_success 'perf stream, child processes' '
+	test_when_finished "rm trace.perf actual expect" &&
+	GIT_TR2_PERF="$(pwd)/trace.perf" test-tool trace2 004child test-tool trace2 004child test-tool trace2 001return 0 &&
+	perl "$TEST_DIRECTORY/t0211/scrub_perf.perl" <trace.perf >actual &&
+	cat >expect <<-EOF &&
+		d0|main|version|||||$V
+		d0|main|start|||||_EXE_ trace2 004child test-tool trace2 004child test-tool trace2 001return 0
+		d0|main|cmd_name|||||trace2 (trace2)
+		d0|main|child_start||_T_ABS_|||[ch0] class:? argv: test-tool trace2 004child test-tool trace2 001return 0
+		d1|main|version|||||$V
+		d1|main|start|||||_EXE_ trace2 004child test-tool trace2 001return 0
+		d1|main|cmd_name|||||trace2 (trace2/trace2)
+		d1|main|child_start||_T_ABS_|||[ch0] class:? argv: test-tool trace2 001return 0
+		d2|main|version|||||$V
+		d2|main|start|||||_EXE_ trace2 001return 0
+		d2|main|cmd_name|||||trace2 (trace2/trace2/trace2)
+		d2|main|exit||_T_ABS_|||code:0
+		d2|main|atexit||_T_ABS_|||code:0
+		d1|main|child_exit||_T_ABS_|_T_REL_||[ch0] pid:_PID_ code:0
+		d1|main|exit||_T_ABS_|||code:0
+		d1|main|atexit||_T_ABS_|||code:0
+		d0|main|child_exit||_T_ABS_|_T_REL_||[ch0] pid:_PID_ code:0
+		d0|main|exit||_T_ABS_|||code:0
+		d0|main|atexit||_T_ABS_|||code:0
+	EOF
+	test_cmp expect actual
+'
+
+test_done
diff --git a/t/t0211/scrub_perf.perl b/t/t0211/scrub_perf.perl
new file mode 100644
index 0000000000..351af7844e
--- /dev/null
+++ b/t/t0211/scrub_perf.perl
@@ -0,0 +1,76 @@
+#!/usr/bin/perl
+#
+# Scrub the variable fields from the perf trace2 output to
+# make testing easier.
+
+use strict;
+use warnings;
+
+my $qpath = '\'[^\']*\'|[^ ]*';
+
+my $col_depth=0;
+my $col_thread=1;
+my $col_event=2;
+my $col_repo=3;
+my $col_t_abs=4;
+my $col_t_rel=5;
+my $col_category=6;
+my $col_rest=7;
+
+# This code assumes that the trace2 data was written with bare
+# turned on (which omits the "<clock> <file>:<line> | <parents>"
+# prefix.
+
+while (<>) {
+    my @tokens = split /\|/;
+
+    foreach my $col (@tokens) { $col =~ s/^\s+|\s+$//g; }
+
+    if ($tokens[$col_event] =~ m/^start/) {
+	# The 'start' message lists the contents of argv in $col_rest.
+	# On some platforms (Windows), argv[0] is *sometimes* a canonical
+	# absolute path to the EXE rather than the value passed in the
+	# shell script.  Replace it with a placeholder to simplify our
+	# HEREDOC in the test script.
+	my $argv0;
+	my $argvRest;
+	$tokens[$col_rest] =~ s/^($qpath)\W*(.*)/_EXE_ $2/;
+    }
+    elsif ($tokens[$col_event] =~ m/cmd_path/) {
+	# Likewise, the 'cmd_path' message breaks out argv[0].
+	#
+	# This line is only emitted when RUNTIME_PREFIX is defined,
+	# so just omit it for testing purposes.
+	# $tokens[$col_rest] = "_EXE_";
+	goto SKIP_LINE;
+    }
+    elsif ($tokens[$col_event] =~ m/child_exit/) {
+	$tokens[$col_rest] =~ s/ pid:\d* / pid:_PID_ /;
+    }
+    elsif ($tokens[$col_event] =~ m/data/) {
+	if ($tokens[$col_category] =~ m/process/) {
+	    # 'data' and 'data_json' events containing 'process'
+	    # category data are assumed to be platform-specific
+	    # and highly variable.  Just omit them.
+	    goto SKIP_LINE;
+	}
+    }
+
+    # t_abs and t_rel are either blank or a float.  Replace the float
+    # with a constant for matching the HEREDOC in the test script.
+    if ($tokens[$col_t_abs] =~ m/\d/) {
+	$tokens[$col_t_abs] = "_T_ABS_";
+    }
+    if ($tokens[$col_t_rel] =~ m/\d/) {
+	$tokens[$col_t_rel] = "_T_REL_";
+    }
+
+    my $out;
+
+    $out = join('|', @tokens);
+    print "$out\n";
+
+  SKIP_LINE:
+}
+
+
diff --git a/t/t0212-trace2-event.sh b/t/t0212-trace2-event.sh
new file mode 100755
index 0000000000..ee3ab7ffa0
--- /dev/null
+++ b/t/t0212-trace2-event.sh
@@ -0,0 +1,234 @@
+#!/bin/sh
+
+test_description='test trace2 facility'
+. ./test-lib.sh
+
+# Add t/helper directory to PATH so that we can use a relative
+# path to run nested instances of test-tool.exe (see 004child).
+# This helps with HEREDOC comparisons later.
+TTDIR="$GIT_BUILD_DIR/t/helper/" && export TTDIR
+PATH="$TTDIR:$PATH" && export PATH
+
+# Warning: use of 'test_cmp' may run test-tool.exe and/or git.exe
+# Warning: to do the actual diff/comparison, so the HEREDOCs here
+# Warning: only cover our actual calls to test-tool and/or git.
+# Warning: So you may see extra lines in artifact files when
+# Warning: interactively debugging.
+
+# Turn off any inherited trace2 settings for this test.
+unset GIT_TR2 GIT_TR2_PERF GIT_TR2_EVENT
+unset GIT_TR2_BARE
+unset GIT_TR2_CONFIG_PARAMS
+
+V=$(git version | sed -e 's/^git version //') && export V
+
+# There are multiple trace2 targets: normal, perf, and event.
+# Trace2 events will/can be written to each active target (subject
+# to whatever filtering that target decides to do).
+# Test each target independently.
+#
+# Defer setting GIT_TR2_PERF until the actual command we want to
+# test because hidden git and test-tool commands in the test
+# harness can contaminate our output.
+
+# We don't bother repeating the 001return and 002exit tests, since they
+# have coverage in the normal and perf targets.
+
+# Verb 003error
+#
+# To the above, add multiple 'error <msg>' events
+
+test_expect_success 'event stream, error event' '
+	test_when_finished "rm trace.event actual expect" &&
+	GIT_TR2_EVENT="$(pwd)/trace.event" test-tool trace2 003error "hello world" "this is a test" &&
+	perl "$TEST_DIRECTORY/t0212/parse_events.perl" <trace.event >actual &&
+	sed -e "s/^|//" >expect <<-EOF &&
+	|VAR1 = {
+	|  "_SID0_":{
+	|    "argv":[
+	|      "_EXE_",
+	|      "trace2",
+	|      "003error",
+	|      "hello world",
+	|      "this is a test"
+	|    ],
+	|    "errors":[
+	|      "%s",
+	|      "%s"
+	|    ],
+	|    "exit_code":0,
+	|    "hierarchy":"trace2",
+	|    "name":"trace2",
+	|    "version":"$V"
+	|  }
+	|};
+	EOF
+	test_cmp expect actual
+'
+
+# Verb 004child
+#
+# Test nested spawning of child processes.
+#
+# Conceptually, this looks like:
+#    P1: TT trace2 004child
+#    P2: |--- TT trace2 004child
+#    P3:      |--- TT trace2 001return 0
+
+test_expect_success 'event stream, return code 0' '
+	test_when_finished "rm trace.event actual expect" &&
+	GIT_TR2_EVENT="$(pwd)/trace.event" test-tool trace2 004child test-tool trace2 004child test-tool trace2 001return 0 &&
+	perl "$TEST_DIRECTORY/t0212/parse_events.perl" <trace.event >actual &&
+	sed -e "s/^|//" >expect <<-EOF &&
+	|VAR1 = {
+	|  "_SID0_":{
+	|    "argv":[
+	|      "_EXE_",
+	|      "trace2",
+	|      "004child",
+	|      "test-tool",
+	|      "trace2",
+	|      "004child",
+	|      "test-tool",
+	|      "trace2",
+	|      "001return",
+	|      "0"
+	|    ],
+	|    "child":{
+	|      "0":{
+	|        "child_argv":[
+	|          "_EXE_",
+	|          "trace2",
+	|          "004child",
+	|          "test-tool",
+	|          "trace2",
+	|          "001return",
+	|          "0"
+	|        ],
+	|        "child_class":"?",
+	|        "child_code":0,
+	|        "use_shell":0
+	|      }
+	|    },
+	|    "exit_code":0,
+	|    "hierarchy":"trace2",
+	|    "name":"trace2",
+	|    "version":"$V"
+	|  },
+	|  "_SID0_/_SID1_":{
+	|    "argv":[
+	|      "_EXE_",
+	|      "trace2",
+	|      "004child",
+	|      "test-tool",
+	|      "trace2",
+	|      "001return",
+	|      "0"
+	|    ],
+	|    "child":{
+	|      "0":{
+	|        "child_argv":[
+	|          "_EXE_",
+	|          "trace2",
+	|          "001return",
+	|          "0"
+	|        ],
+	|        "child_class":"?",
+	|        "child_code":0,
+	|        "use_shell":0
+	|      }
+	|    },
+	|    "exit_code":0,
+	|    "hierarchy":"trace2/trace2",
+	|    "name":"trace2",
+	|    "version":"$V"
+	|  },
+	|  "_SID0_/_SID1_/_SID2_":{
+	|    "argv":[
+	|      "_EXE_",
+	|      "trace2",
+	|      "001return",
+	|      "0"
+	|    ],
+	|    "exit_code":0,
+	|    "hierarchy":"trace2/trace2/trace2",
+	|    "name":"trace2",
+	|    "version":"$V"
+	|  }
+	|};
+	EOF
+	test_cmp expect actual
+'
+
+# Test listing of all "interesting" config settings.
+
+test_expect_success 'event stream, list config' '
+	test_when_finished "rm trace.event actual expect" &&
+	git config --local t0212.abc 1 &&
+	git config --local t0212.def "hello world" &&
+	GIT_TR2_EVENT="$(pwd)/trace.event" GIT_TR2_CONFIG_PARAMS="t0212.*" test-tool trace2 001return 0 &&
+	perl "$TEST_DIRECTORY/t0212/parse_events.perl" <trace.event >actual &&
+	sed -e "s/^|//" >expect <<-EOF &&
+	|VAR1 = {
+	|  "_SID0_":{
+	|    "argv":[
+	|      "_EXE_",
+	|      "trace2",
+	|      "001return",
+	|      "0"
+	|    ],
+	|    "exit_code":0,
+	|    "hierarchy":"trace2",
+	|    "name":"trace2",
+	|    "params":[
+	|      {
+	|        "param":"t0212.abc",
+	|        "value":"1"
+	|      },
+	|      {
+	|        "param":"t0212.def",
+	|        "value":"hello world"
+	|      }
+	|    ],
+	|    "version":"$V"
+	|  }
+	|};
+	EOF
+	test_cmp expect actual
+'
+
+test_expect_success 'basic trace2_data' '
+	test_when_finished "rm trace.event actual expect" &&
+	GIT_TR2_EVENT="$(pwd)/trace.event" test-tool trace2 006data test_category k1 v1 test_category k2 v2 &&
+	perl "$TEST_DIRECTORY/t0212/parse_events.perl" <trace.event >actual &&
+	sed -e "s/^|//" >expect <<-EOF &&
+	|VAR1 = {
+	|  "_SID0_":{
+	|    "argv":[
+	|      "_EXE_",
+	|      "trace2",
+	|      "006data",
+	|      "test_category",
+	|      "k1",
+	|      "v1",
+	|      "test_category",
+	|      "k2",
+	|      "v2"
+	|    ],
+	|    "data":{
+	|      "test_category":{
+	|        "k1":"v1",
+	|        "k2":"v2"
+	|      }
+	|    },
+	|    "exit_code":0,
+	|    "hierarchy":"trace2",
+	|    "name":"trace2",
+	|    "version":"$V"
+	|  }
+	|};
+	EOF
+	test_cmp expect actual
+'
+
+test_done
diff --git a/t/t0212/parse_events.perl b/t/t0212/parse_events.perl
new file mode 100644
index 0000000000..a2776ba216
--- /dev/null
+++ b/t/t0212/parse_events.perl
@@ -0,0 +1,251 @@
+#!/usr/bin/perl
+#
+# Parse event stream and convert individual events into a summary
+# record for the process.
+#
+# Git.exe generates one or more "event" records for each API method,
+# such as "start <argv>" and "exit <code>", during the life of the git
+# process.  Additionally, the input may contain interleaved events
+# from multiple concurrent git processes and/or multiple threads from
+# within a git process.
+#
+# Accumulate events for each process (based on its unique SID) in a
+# dictionary and emit process summary records.
+#
+# Convert some of the variable fields (such as elapsed time) into
+# placeholders (or omit them) to make HEREDOC comparisons easier in
+# the test scripts.
+#
+# We may also omit fields not (currently) useful for testing purposes.
+
+use strict;
+use warnings;
+use JSON::PP;
+use Data::Dumper;
+use Getopt::Long;
+
+# The version of the trace2 event target format that we understand.
+# This is reported in the 'version' event in the 'evt' field.
+# It comes from the GIT_TR2_EVENT_VERSION macro in trace2/tr2_tgt_event.c
+my $evt_version = '1';
+
+my $show_children = 1;
+my $show_exec     = 1;
+my $show_threads  = 1;
+
+# A hack to generate test HEREDOC data for pasting into the test script.
+# Usage:
+#    cd "t/trash directory.t0212-trace2-event"
+#    $TT trace ... >trace.event
+#    VV=$(../../git.exe version | sed -e 's/^git version //')
+#    perl ../t0212/parse_events.perl --HEREDOC --VERSION=$VV <trace.event >heredoc
+# Then paste heredoc into your new test.
+
+my $gen_heredoc = 0;
+my $gen_version = '';
+
+GetOptions("children!" => \$show_children,
+	   "exec!"     => \$show_exec,
+	   "threads!"  => \$show_threads,
+	   "HEREDOC!"  => \$gen_heredoc,
+	   "VERSION=s" => \$gen_version    )
+    or die("Error in command line arguments\n");
+
+
+# SIDs contains timestamps and PIDs of the process and its parents.
+# This makes it difficult to match up in a HEREDOC in the test script.
+# Build a map from actual SIDs to predictable constant values and yet
+# keep the parent/child relationships.  For example:
+# {..., "sid":"1539706952458276-8652", ...}
+# {..., "sid":"1539706952458276-8652/1539706952649493-15452", ...}
+# becomes:
+# {..., "sid":"_SID1_", ...}
+# {..., "sid":"_SID1_/_SID2_", ...}
+my $sid_map;
+my $sid_count = 0;
+
+my $processes;
+
+while (<>) {
+    my $line = decode_json( $_ );
+
+    my $sid = "";
+    my $sid_sep = "";
+
+    my $raw_sid = $line->{'sid'};
+    my @raw_sid_parts = split /\//, $raw_sid;
+    foreach my $raw_sid_k (@raw_sid_parts) {
+	if (!exists $sid_map->{$raw_sid_k}) {
+	    $sid_map->{$raw_sid_k} = '_SID' . $sid_count . '_';
+	    $sid_count++;
+	}
+	$sid = $sid . $sid_sep . $sid_map->{$raw_sid_k};
+	$sid_sep = '/';
+    }
+    
+    my $event = $line->{'event'};
+
+    if ($event eq 'version') {
+	$processes->{$sid}->{'version'} = $line->{'exe'};
+	if ($gen_heredoc == 1 && $gen_version eq $line->{'exe'}) {
+	    # If we are generating data FOR the test script, replace
+	    # the reported git.exe version with a reference to an
+	    # environment variable.  When our output is pasted into
+	    # the test script, it will then be expanded in future
+	    # test runs to the THEN current version of git.exe.
+	    # We assume that the test script uses env var $V.
+	    $processes->{$sid}->{'version'} = "\$V";
+	}
+    }
+
+    elsif ($event eq 'start') {
+	$processes->{$sid}->{'argv'} = $line->{'argv'};
+	$processes->{$sid}->{'argv'}[0] = "_EXE_";
+    }
+
+    elsif ($event eq 'exit') {
+	$processes->{$sid}->{'exit_code'} = $line->{'code'};
+    }
+
+    elsif ($event eq 'atexit') {
+	$processes->{$sid}->{'exit_code'} = $line->{'code'};
+    }
+
+    elsif ($event eq 'error') {
+	# For HEREDOC purposes, use the error message format string if
+	# available, rather than the formatted message (which probably
+	# has an absolute pathname).
+	if (exists $line->{'fmt'}) {
+	    push( @{$processes->{$sid}->{'errors'}}, $line->{'fmt'} );
+	}
+	elsif (exists $line->{'msg'}) {
+	    push( @{$processes->{$sid}->{'errors'}}, $line->{'msg'} );
+	}
+    }
+
+    elsif ($event eq 'cmd_path') {
+	## $processes->{$sid}->{'path'} = $line->{'path'};
+	#
+	# Like in the 'start' event, we need to replace the value of
+	# argv[0] with a token for HEREDOC purposes.  However, the
+	# event is only emitted when RUNTIME_PREFIX is defined, so
+	# just omit it for testing purposes.
+	# $processes->{$sid}->{'path'} = "_EXE_";
+    }
+    
+    elsif ($event eq 'cmd_name') {
+	$processes->{$sid}->{'name'} = $line->{'name'};
+	$processes->{$sid}->{'hierarchy'} = $line->{'hierarchy'};
+    }
+
+    elsif ($event eq 'alias') {
+	$processes->{$sid}->{'alias'}->{'key'} = $line->{'alias'};
+	$processes->{$sid}->{'alias'}->{'argv'} = $line->{'argv'};
+    }
+
+    elsif ($event eq 'def_param') {
+	my $kv;
+	$kv->{'param'} = $line->{'param'};
+	$kv->{'value'} = $line->{'value'};
+	push( @{$processes->{$sid}->{'params'}}, $kv );
+    }
+
+    elsif ($event eq 'child_start') {
+	if ($show_children == 1) {
+	    $processes->{$sid}->{'child'}->{$line->{'child_id'}}->{'child_class'} = $line->{'child_class'};
+	    $processes->{$sid}->{'child'}->{$line->{'child_id'}}->{'child_argv'} = $line->{'argv'};
+	    $processes->{$sid}->{'child'}->{$line->{'child_id'}}->{'child_argv'}[0] = "_EXE_";
+	    $processes->{$sid}->{'child'}->{$line->{'child_id'}}->{'use_shell'} = $line->{'use_shell'} ? 1 : 0;
+	}
+    }
+
+    elsif ($event eq 'child_exit') {
+	if ($show_children == 1) {
+	    $processes->{$sid}->{'child'}->{$line->{'child_id'}}->{'child_code'} = $line->{'code'};
+	}
+    }
+
+    # TODO decide what information we want to test from thread events.
+
+    elsif ($event eq 'thread_start') {
+	if ($show_threads == 1) {
+	}
+    }
+
+    elsif ($event eq 'thread_exit') {
+	if ($show_threads == 1) {
+	}
+    }
+
+    # TODO decide what information we want to test from exec events.
+
+    elsif ($event eq 'exec') {
+	if ($show_exec == 1) {
+	}
+    }
+
+    elsif ($event eq 'exec_result') {
+	if ($show_exec == 1) {
+	}
+    }
+
+    elsif ($event eq 'def_param') {
+	# Accumulate parameter key/value pairs by key rather than in an array
+	# so that we get overwrite (last one wins) effects.
+	$processes->{$sid}->{'params'}->{$line->{'param'}} = $line->{'value'};
+    }
+
+    elsif ($event eq 'def_repo') {
+	# $processes->{$sid}->{'repos'}->{$line->{'repo'}} = $line->{'worktree'};
+	$processes->{$sid}->{'repos'}->{$line->{'repo'}} = "_WORKTREE_";
+    }
+
+    # A series of potentially nested and threaded region and data events
+    # is fundamentally incompatibile with the type of summary record we
+    # are building in this script.  Since they are intended for
+    # perf-trace-like analysis rather than a result summary, we ignore
+    # most of them here.
+
+    # elsif ($event eq 'region_enter') {
+    # }
+    # elsif ($event eq 'region_leave') {
+    # }
+
+    elsif ($event eq 'data') {
+	my $cat = $line->{'category'};
+	if ($cat eq 'test_category') {
+	    
+	    my $key = $line->{'key'};
+	    my $value = $line->{'value'};
+	    $processes->{$sid}->{'data'}->{$cat}->{$key} = $value;
+	}
+    }
+
+    # This trace2 target does not emit 'printf' events.
+    #
+    # elsif ($event eq 'printf') {
+    # }
+}
+
+# Dump the resulting hash into something that we can compare against
+# in the test script.  These options make Dumper output look a little
+# bit like JSON.  Also convert variable references of the form "$VAR*"
+# so that the matching HEREDOC doesn't need to escape it.
+
+$Data::Dumper::Sortkeys = 1;
+$Data::Dumper::Indent = 1;
+$Data::Dumper::Purity = 1;
+$Data::Dumper::Pair = ':';
+
+my $out = Dumper($processes);
+$out =~ s/'/"/g;
+$out =~ s/\$VAR/VAR/g;
+
+# Finally, if we're running this script to generate (manually confirmed)
+# data to add to the test script, guard the indentation.
+
+if ($gen_heredoc == 1) {
+    $out =~ s/^/\t\|/gms;
+}
+
+print $out;
-- 
gitgitgadget

