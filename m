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
	by dcvr.yhbt.net (Postfix) with ESMTP id 6EE921F463
	for <e@80x24.org>; Mon, 30 Sep 2019 09:55:46 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1730642AbfI3Jzn (ORCPT <rfc822;e@80x24.org>);
        Mon, 30 Sep 2019 05:55:43 -0400
Received: from mail-wr1-f66.google.com ([209.85.221.66]:43648 "EHLO
        mail-wr1-f66.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1730635AbfI3Jzm (ORCPT <rfc822;git@vger.kernel.org>);
        Mon, 30 Sep 2019 05:55:42 -0400
Received: by mail-wr1-f66.google.com with SMTP id q17so10485324wrx.10
        for <git@vger.kernel.org>; Mon, 30 Sep 2019 02:55:38 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=date:message-id:in-reply-to:references:from:subject:fcc
         :content-transfer-encoding:mime-version:to:cc;
        bh=HGFrFNyVHi280AGFhSwMmw4T+7XoU3wVKH7GZLHn6U0=;
        b=CnQ18tJuSTcWVRWUldAXNYrXqX3lG4ckkBmHZGvQCvQdFUi1kKB0xRr9ZnluNcpaoH
         b524hkRlMvMeF65kNCFew6Dw15ty1fG4yVhQ6Nb1jmLPEMUfQ7kEvwXh+5rDGYlRNL9O
         6tedwbogduprBRfeNJUg8ZY2z0nMrVGd4MjZmUcPtVxhNuVRc3YvsmBooHtwzPPs9ZrP
         Jk7eEYARuWfd9otsVvuFtgFg3K9ygzOkg91/dYi/an+9uYMu5yzkl/SZ3TpezIQiBfkf
         BB+AnDjjb7b770CO4941QDLFD0xYZbuNUf9PM58K4L/8874TwoW1VAXhlSVmeWhuXOBs
         N2wg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:message-id:in-reply-to:references:from
         :subject:fcc:content-transfer-encoding:mime-version:to:cc;
        bh=HGFrFNyVHi280AGFhSwMmw4T+7XoU3wVKH7GZLHn6U0=;
        b=E7JoTsFC24/EsSRaPS/EoO7Q07yFH+T50oIzr3gO2yNQZSy8bKxbAsVvWG4cp+pO+F
         LVvGtsvgZm64NA8435BzMT/Mdz1UbkKC+JrGS3vHaq32KCiQTLW8nEZDH+mC5OpFmnfD
         ehIceY7TjAzs2QvcUAuwnKV2X4WNIrL5ERMsU2n3iTiLQXi/C/NY477FmTOgs4VczXf0
         NJy4TEHH8YC61Ns3XrrVtw7d/zo+57YYXoYMvEa1HBnWh8+OI4xA/ur65kO7vF/Iqt6R
         VEY/mTz6TZlGtXqkIpJ+hK2mb0ruZhgCgL3W/9Vq8PmJn8lDbfNI0iSIYrX1iZpwIwRP
         zYDA==
X-Gm-Message-State: APjAAAVC8UjpjFXI67Sx82v+kfgAtTWuG1mcQ4qSmrupLK2qw+0NjotQ
        vQ3LWELHpb4sDYrNOej2D2OZbbhM
X-Google-Smtp-Source: APXvYqx1epZC9YT9r+bNz6XO+TsrLk3/RoFF+hdQUAyPPDahB/s+e5GUGg1XfNqkZmTlMnJuUA955Q==
X-Received: by 2002:a5d:628f:: with SMTP id k15mr12209528wru.124.1569837338109;
        Mon, 30 Sep 2019 02:55:38 -0700 (PDT)
Received: from [127.0.0.1] ([13.74.141.28])
        by smtp.gmail.com with ESMTPSA id k9sm16640966wrd.7.2019.09.30.02.55.37
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Mon, 30 Sep 2019 02:55:37 -0700 (PDT)
Date:   Mon, 30 Sep 2019 02:55:37 -0700 (PDT)
X-Google-Original-Date: Mon, 30 Sep 2019 09:55:26 GMT
Message-Id: <24b1c7bff35187f8e34012294db3a6670bcddb2a.1569837330.git.gitgitgadget@gmail.com>
In-Reply-To: <pull.288.v2.git.gitgitgadget@gmail.com>
References: <pull.288.git.gitgitgadget@gmail.com>
        <pull.288.v2.git.gitgitgadget@gmail.com>
From:   "Johannes Schindelin via GitGitGadget" <gitgitgadget@gmail.com>
Subject: [PATCH v2 10/13] test-tool run-command: learn to run (parts of) the
 testsuite
Fcc:    Sent
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
MIME-Version: 1.0
To:     git@vger.kernel.org
Cc:     Denton Liu <liu.denton@gmail.com>,
        Johannes Schindelin <johannes.schindelin@gmx.de>,
        Junio C Hamano <gitster@pobox.com>,
        Johannes Schindelin <johannes.schindelin@gmx.de>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

From: Johannes Schindelin <johannes.schindelin@gmx.de>

Git for Windows jumps through hoops to provide a development environment
that allows to build Git and to run its test suite. To that end, an
entire MSYS2 system, including GNU make and GCC is offered as "the Git
for Windows SDK". It does come at a price: an initial download of said
SDK weighs in with several hundreds of megabytes, and the unpacked SDK
occupies ~2GB of disk space.

A much more native development environment on Windows is Visual Studio.
To help contributors use that environment, we already have a Makefile
target `vcxproj` that generates a commit with project files (and other
generated files), and Git for Windows' `vs/master` branch is
continuously re-generated using that target.

The idea is to allow building Git in Visual Studio, and to run
individual tests using a Portable Git.

The one missing thing is a way to run the entire test suite: neither
`make` nor `prove` are required to run Git, therefore Git for Windows
does not support those commands in the Portable Git.

To help with that, add a simple test helper that exercises the
`run_processes_parallel()` function to allow for running test scripts in
parallel (which is really necessary, especially on Windows, as Git's
test suite takes such a long time to run).

This will also come in handy for the upcoming change to our Azure
Pipeline: we will use this helper in a Portable Git to test the Visual
Studio build of Git.

Signed-off-by: Johannes Schindelin <johannes.schindelin@gmx.de>
---
 t/helper/test-run-command.c | 153 ++++++++++++++++++++++++++++++++++++
 1 file changed, 153 insertions(+)

diff --git a/t/helper/test-run-command.c b/t/helper/test-run-command.c
index 2cc93bb69c..ead6dc611a 100644
--- a/t/helper/test-run-command.c
+++ b/t/helper/test-run-command.c
@@ -10,9 +10,14 @@
 
 #include "test-tool.h"
 #include "git-compat-util.h"
+#include "cache.h"
 #include "run-command.h"
 #include "argv-array.h"
 #include "strbuf.h"
+#include "parse-options.h"
+#include "string-list.h"
+#include "thread-utils.h"
+#include "wildmatch.h"
 #include <string.h>
 #include <errno.h>
 
@@ -50,11 +55,159 @@ static int task_finished(int result,
 	return 1;
 }
 
+struct testsuite {
+	struct string_list tests, failed;
+	int next;
+	int quiet, immediate, verbose, verbose_log, trace, write_junit_xml;
+};
+#define TESTSUITE_INIT \
+	{ STRING_LIST_INIT_DUP, STRING_LIST_INIT_DUP, -1, 0, 0, 0, 0, 0, 0 }
+
+static int next_test(struct child_process *cp, struct strbuf *err, void *cb,
+		     void **task_cb)
+{
+	struct testsuite *suite = cb;
+	const char *test;
+	if (suite->next >= suite->tests.nr)
+		return 0;
+
+	test = suite->tests.items[suite->next++].string;
+	argv_array_pushl(&cp->args, "sh", test, NULL);
+	if (suite->quiet)
+		argv_array_push(&cp->args, "--quiet");
+	if (suite->immediate)
+		argv_array_push(&cp->args, "-i");
+	if (suite->verbose)
+		argv_array_push(&cp->args, "-v");
+	if (suite->verbose_log)
+		argv_array_push(&cp->args, "-V");
+	if (suite->trace)
+		argv_array_push(&cp->args, "-x");
+	if (suite->write_junit_xml)
+		argv_array_push(&cp->args, "--write-junit-xml");
+
+	strbuf_addf(err, "Output of '%s':\n", test);
+	*task_cb = (void *)test;
+
+	return 1;
+}
+
+static int test_finished(int result, struct strbuf *err, void *cb,
+			 void *task_cb)
+{
+	struct testsuite *suite = cb;
+	const char *name = (const char *)task_cb;
+
+	if (result)
+		string_list_append(&suite->failed, name);
+
+	strbuf_addf(err, "%s: '%s'\n", result ? "FAIL" : "SUCCESS", name);
+
+	return 0;
+}
+
+static int test_failed(struct strbuf *out, void *cb, void *task_cb)
+{
+	struct testsuite *suite = cb;
+	const char *name = (const char *)task_cb;
+
+	string_list_append(&suite->failed, name);
+	strbuf_addf(out, "FAILED TO START: '%s'\n", name);
+
+	return 0;
+}
+
+static const char * const testsuite_usage[] = {
+	"test-run-command testsuite [<options>] [<pattern>...]",
+	NULL
+};
+
+static int testsuite(int argc, const char **argv)
+{
+	struct testsuite suite = TESTSUITE_INIT;
+	int max_jobs = 1, i, ret;
+	DIR *dir;
+	struct dirent *d;
+	struct option options[] = {
+		OPT_BOOL('i', "immediate", &suite.immediate,
+			 "stop at first failed test case(s)"),
+		OPT_INTEGER('j', "jobs", &max_jobs, "run <N> jobs in parallel"),
+		OPT_BOOL('q', "quiet", &suite.quiet, "be terse"),
+		OPT_BOOL('v', "verbose", &suite.verbose, "be verbose"),
+		OPT_BOOL('V', "verbose-log", &suite.verbose_log,
+			 "be verbose, redirected to a file"),
+		OPT_BOOL('x', "trace", &suite.trace, "trace shell commands"),
+		OPT_BOOL(0, "write-junit-xml", &suite.write_junit_xml,
+			 "write JUnit-style XML files"),
+		OPT_END()
+	};
+
+	memset(&suite, 0, sizeof(suite));
+	suite.tests.strdup_strings = suite.failed.strdup_strings = 1;
+
+	argc = parse_options(argc, argv, NULL, options,
+			testsuite_usage, PARSE_OPT_STOP_AT_NON_OPTION);
+
+	if (max_jobs <= 0)
+		max_jobs = online_cpus();
+
+	dir = opendir(".");
+	if (!dir)
+		die("Could not open the current directory");
+	while ((d = readdir(dir))) {
+		const char *p = d->d_name;
+
+		if (*p != 't' || !isdigit(p[1]) || !isdigit(p[2]) ||
+		    !isdigit(p[3]) || !isdigit(p[4]) || p[5] != '-' ||
+		    !ends_with(p, ".sh"))
+			continue;
+
+		/* No pattern: match all */
+		if (!argc) {
+			string_list_append(&suite.tests, p);
+			continue;
+		}
+
+		for (i = 0; i < argc; i++)
+			if (!wildmatch(argv[i], p, 0)) {
+				string_list_append(&suite.tests, p);
+				break;
+			}
+	}
+	closedir(dir);
+
+	if (!suite.tests.nr)
+		die("No tests match!");
+	if (max_jobs > suite.tests.nr)
+		max_jobs = suite.tests.nr;
+
+	fprintf(stderr, "Running %d tests (%d at a time)\n",
+		suite.tests.nr, max_jobs);
+
+	ret = run_processes_parallel(max_jobs, next_test, test_failed,
+				     test_finished, &suite);
+
+	if (suite.failed.nr > 0) {
+		ret = 1;
+		fprintf(stderr, "%d tests failed:\n\n", suite.failed.nr);
+		for (i = 0; i < suite.failed.nr; i++)
+			fprintf(stderr, "\t%s\n", suite.failed.items[i].string);
+	}
+
+	string_list_clear(&suite.tests, 0);
+	string_list_clear(&suite.failed, 0);
+
+	return !!ret;
+}
+
 int cmd__run_command(int argc, const char **argv)
 {
 	struct child_process proc = CHILD_PROCESS_INIT;
 	int jobs;
 
+	if (argc > 1 && !strcmp(argv[1], "testsuite"))
+		exit(testsuite(argc - 1, argv + 1));
+
 	if (argc < 3)
 		return 1;
 	while (!strcmp(argv[1], "env")) {
-- 
gitgitgadget

