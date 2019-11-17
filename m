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
	by dcvr.yhbt.net (Postfix) with ESMTP id 965661F4B5
	for <e@80x24.org>; Sun, 17 Nov 2019 21:05:27 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726579AbfKQVF0 (ORCPT <rfc822;e@80x24.org>);
        Sun, 17 Nov 2019 16:05:26 -0500
Received: from mail-wr1-f49.google.com ([209.85.221.49]:39705 "EHLO
        mail-wr1-f49.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726460AbfKQVFR (ORCPT <rfc822;git@vger.kernel.org>);
        Sun, 17 Nov 2019 16:05:17 -0500
Received: by mail-wr1-f49.google.com with SMTP id l7so17093143wrp.6
        for <git@vger.kernel.org>; Sun, 17 Nov 2019 13:05:16 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=message-id:in-reply-to:references:from:date:subject:fcc
         :content-transfer-encoding:mime-version:to:cc;
        bh=Yj6dU6eAFClAyLjY8JX8pFhWVOm+gb6VPcSQ1NX0okY=;
        b=MsRF9g3ryHq4Q1b2RJ/E8il12iHfxN5eemqXMUXScoojQ8s753nAWQFlZGjW9qdcj/
         EEjcGnzwlvSqnVpfekB+VoP0hAI/6gOiLxPZ3+GSrlGhXcKFb2BKcIa4xFOufjnquqdI
         klAmBr/8y6dG3CG5094DIa8UuJVW+y9Sg6UEbMvp8IO9HsNbEB47/PdNykdoTk682BAF
         Hm0b0ZtRDd/x8X2vfslNXeMqAh3pUu68gV0vhvNPuahWy2w2ULKAwypk/wN+/KGydbkR
         9daGakV85jbk2DsDey1Kzayq6Vi1NZSz671OJ1dPfYF/IP3WT/YisTCSaMqGiXa8Qdz5
         HAnA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:message-id:in-reply-to:references:from:date
         :subject:fcc:content-transfer-encoding:mime-version:to:cc;
        bh=Yj6dU6eAFClAyLjY8JX8pFhWVOm+gb6VPcSQ1NX0okY=;
        b=OdAvaX02H5EM9awYu9fvyX6019vaSvTS2PO5MywIAB2XUD5UnlqI3FkpK/s+877xZX
         9vk9jmEA5phKhK+KfpD+hot99+UEm02dXuLhyEl63+aJBaj/w1II3rrzfdJBGBdwi3qA
         AkzQFPlmcQhemJJdPm5B2wWAo8ZcPIaS4Pl+tWCgkMSIW8sw0ojODDOp+6jQImoNDSAj
         3Zx2y+HrsC2lYiHH98wZ8jEsNfBFjyAJ1BQcB0vPAqDzCModVFz2J377lpt30RS9HuWL
         RZmDRc7sPju2+0qRUMx9bgeBTe47uruxKFs2fGRG2IZqoSf6eW7AJY7pq+dnAt+Elt8v
         Q06A==
X-Gm-Message-State: APjAAAVV5M3sKKwyUc1MJXHVMsMGwKJ+ugLmlYrMmFWPTPvckugV9O1N
        y5Hs2QTHHYd29eD1q7sj1SMXeail
X-Google-Smtp-Source: APXvYqx0rSUFC1gw2Y02nbV8IrFXSNHFyZLnbj/Uuag7u81xmhr5XUhfDXFwuW2gtMUSt/2GjLKiiA==
X-Received: by 2002:adf:f203:: with SMTP id p3mr27769756wro.2.1574024715046;
        Sun, 17 Nov 2019 13:05:15 -0800 (PST)
Received: from [127.0.0.1] ([13.74.141.28])
        by smtp.gmail.com with ESMTPSA id z6sm21291261wro.18.2019.11.17.13.05.14
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Sun, 17 Nov 2019 13:05:14 -0800 (PST)
Message-Id: <f313d74e1ea0f5976a08bb3c1fe78e70937c1027.1574024701.git.gitgitgadget@gmail.com>
In-Reply-To: <pull.434.v5.git.1574024700.gitgitgadget@gmail.com>
References: <pull.434.v4.git.1573811626.gitgitgadget@gmail.com>
        <pull.434.v5.git.1574024700.gitgitgadget@gmail.com>
From:   "Heba Waly via GitGitGadget" <gitgitgadget@gmail.com>
Date:   Sun, 17 Nov 2019 21:04:56 +0000
Subject: [PATCH v5 17/21] trace: move doc to trace.h
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

Move the documentation from Documentation/technical/api-trace.txt
to trace.h as it's easier for the developers to find the usage
information beside the code instead of looking for it in another doc file.

Documentation/technical/api-trace.txt is removed because the
information it has is now redundant and it'll be hard to keep it up to
date and synchronized with the documentation in the header file.

Signed-off-by: Heba Waly <heba.waly@gmail.com>
---
 Documentation/technical/api-trace.txt | 140 --------------------------
 trace.h                               | 133 +++++++++++++++++++++++-
 2 files changed, 131 insertions(+), 142 deletions(-)
 delete mode 100644 Documentation/technical/api-trace.txt

diff --git a/Documentation/technical/api-trace.txt b/Documentation/technical/api-trace.txt
deleted file mode 100644
index fadb5979c4..0000000000
--- a/Documentation/technical/api-trace.txt
+++ /dev/null
@@ -1,140 +0,0 @@
-trace API
-=========
-
-The trace API can be used to print debug messages to stderr or a file. Trace
-code is inactive unless explicitly enabled by setting `GIT_TRACE*` environment
-variables.
-
-The trace implementation automatically adds `timestamp file:line ... \n` to
-all trace messages. E.g.:
-
-------------
-23:59:59.123456 git.c:312               trace: built-in: git 'foo'
-00:00:00.000001 builtin/foo.c:99        foo: some message
-------------
-
-Data Structures
----------------
-
-`struct trace_key`::
-
-	Defines a trace key (or category). The default (for API functions that
-	don't take a key) is `GIT_TRACE`.
-+
-E.g. to define a trace key controlled by environment variable `GIT_TRACE_FOO`:
-+
-------------
-static struct trace_key trace_foo = TRACE_KEY_INIT(FOO);
-
-static void trace_print_foo(const char *message)
-{
-	trace_printf_key(&trace_foo, "%s", message);
-}
-------------
-+
-Note: don't use `const` as the trace implementation stores internal state in
-the `trace_key` structure.
-
-Functions
----------
-
-`int trace_want(struct trace_key *key)`::
-
-	Checks whether the trace key is enabled. Used to prevent expensive
-	string formatting before calling one of the printing APIs.
-
-`void trace_disable(struct trace_key *key)`::
-
-	Disables tracing for the specified key, even if the environment
-	variable was set.
-
-`void trace_printf(const char *format, ...)`::
-`void trace_printf_key(struct trace_key *key, const char *format, ...)`::
-
-	Prints a formatted message, similar to printf.
-
-`void trace_argv_printf(const char **argv, const char *format, ...)``::
-
-	Prints a formatted message, followed by a quoted list of arguments.
-
-`void trace_strbuf(struct trace_key *key, const struct strbuf *data)`::
-
-	Prints the strbuf, without additional formatting (i.e. doesn't
-	choke on `%` or even `\0`).
-
-`uint64_t getnanotime(void)`::
-
-	Returns nanoseconds since the epoch (01/01/1970), typically used
-	for performance measurements.
-+
-Currently there are high precision timer implementations for Linux (using
-`clock_gettime(CLOCK_MONOTONIC)`) and Windows (`QueryPerformanceCounter`).
-Other platforms use `gettimeofday` as time source.
-
-`void trace_performance(uint64_t nanos, const char *format, ...)`::
-`void trace_performance_since(uint64_t start, const char *format, ...)`::
-
-	Prints the elapsed time (in nanoseconds), or elapsed time since
-	`start`, followed by a formatted message. Enabled via environment
-	variable `GIT_TRACE_PERFORMANCE`. Used for manual profiling, e.g.:
-+
-------------
-uint64_t start = getnanotime();
-/* code section to measure */
-trace_performance_since(start, "foobar");
-------------
-+
-------------
-uint64_t t = 0;
-for (;;) {
-	/* ignore */
-	t -= getnanotime();
-	/* code section to measure */
-	t += getnanotime();
-	/* ignore */
-}
-trace_performance(t, "frotz");
-------------
-
-Bugs & Caveats
---------------
-
-GIT_TRACE_* environment variables can be used to tell Git to show
-trace output to its standard error stream. Git can often spawn a pager
-internally to run its subcommand and send its standard output and
-standard error to it.
-
-Because GIT_TRACE_PERFORMANCE trace is generated only at the very end
-of the program with atexit(), which happens after the pager exits, it
-would not work well if you send its log to the standard error output
-and let Git spawn the pager at the same time.
-
-As a work around, you can for example use '--no-pager', or set
-GIT_TRACE_PERFORMANCE to another file descriptor which is redirected
-to stderr, or set GIT_TRACE_PERFORMANCE to a file specified by its
-absolute path.
-
-For example instead of the following command which by default may not
-print any performance information:
-
-------------
-GIT_TRACE_PERFORMANCE=2 git log -1
-------------
-
-you may want to use:
-
-------------
-GIT_TRACE_PERFORMANCE=2 git --no-pager log -1
-------------
-
-or:
-
-------------
-GIT_TRACE_PERFORMANCE=3 3>&2 git log -1
-------------
-
-or:
-
-------------
-GIT_TRACE_PERFORMANCE=/path/to/log/file git log -1
-------------
diff --git a/trace.h b/trace.h
index 9fa3e7a594..9826618b33 100644
--- a/trace.h
+++ b/trace.h
@@ -4,6 +4,82 @@
 #include "git-compat-util.h"
 #include "strbuf.h"
 
+/**
+ * The trace API can be used to print debug messages to stderr or a file. Trace
+ * code is inactive unless explicitly enabled by setting `GIT_TRACE*` environment
+ * variables.
+ *
+ * The trace implementation automatically adds `timestamp file:line ... \n` to
+ * all trace messages. E.g.:
+ *
+ * ------------
+ * 23:59:59.123456 git.c:312               trace: built-in: git 'foo'
+ * 00:00:00.000001 builtin/foo.c:99        foo: some message
+ * ------------
+ *
+ * Bugs & Caveats
+ * --------------
+ *
+ * GIT_TRACE_* environment variables can be used to tell Git to show
+ * trace output to its standard error stream. Git can often spawn a pager
+ * internally to run its subcommand and send its standard output and
+ * standard error to it.
+ *
+ * Because GIT_TRACE_PERFORMANCE trace is generated only at the very end
+ * of the program with atexit(), which happens after the pager exits, it
+ * would not work well if you send its log to the standard error output
+ * and let Git spawn the pager at the same time.
+ *
+ * As a work around, you can for example use '--no-pager', or set
+ * GIT_TRACE_PERFORMANCE to another file descriptor which is redirected
+ * to stderr, or set GIT_TRACE_PERFORMANCE to a file specified by its
+ * absolute path.
+ *
+ * For example instead of the following command which by default may not
+ * print any performance information:
+ *
+ * ------------
+ * GIT_TRACE_PERFORMANCE=2 git log -1
+ * ------------
+ *
+ * you may want to use:
+ *
+ * ------------
+ * GIT_TRACE_PERFORMANCE=2 git --no-pager log -1
+ * ------------
+ *
+ * or:
+ *
+ * ------------
+ * GIT_TRACE_PERFORMANCE=3 3>&2 git log -1
+ * ------------
+ *
+ * or:
+ *
+ * ------------
+ * GIT_TRACE_PERFORMANCE=/path/to/log/file git log -1
+ * ------------
+ *
+ */
+
+/**
+ * Defines a trace key (or category). The default (for API functions that
+ * don't take a key) is `GIT_TRACE`.
+ *
+ * E.g. to define a trace key controlled by environment variable `GIT_TRACE_FOO`:
+ *
+ * ------------
+ * static struct trace_key trace_foo = TRACE_KEY_INIT(FOO);
+ *
+ * static void trace_print_foo(const char *message)
+ * {
+ * 	trace_printf_key(&trace_foo, "%s", message);
+ * }
+ * ------------
+ *
+ * Note: don't use `const` as the trace implementation stores internal state in
+ * the `trace_key` structure.
+ */
 struct trace_key {
 	const char * const key;
 	int fd;
@@ -18,31 +94,84 @@ extern struct trace_key trace_perf_key;
 extern struct trace_key trace_setup_key;
 
 void trace_repo_setup(const char *prefix);
+
+/**
+ * Checks whether the trace key is enabled. Used to prevent expensive
+ * string formatting before calling one of the printing APIs.
+ */
 int trace_want(struct trace_key *key);
+
+/**
+ * Disables tracing for the specified key, even if the environment variable
+ * was set.
+ */
 void trace_disable(struct trace_key *key);
+
+/**
+ * Returns nanoseconds since the epoch (01/01/1970), typically used
+ * for performance measurements.
+ * Currently there are high precision timer implementations for Linux (using
+ * `clock_gettime(CLOCK_MONOTONIC)`) and Windows (`QueryPerformanceCounter`).
+ * Other platforms use `gettimeofday` as time source.
+ */
 uint64_t getnanotime(void);
+
 void trace_command_performance(const char **argv);
 void trace_verbatim(struct trace_key *key, const void *buf, unsigned len);
 uint64_t trace_performance_enter(void);
 
 #ifndef HAVE_VARIADIC_MACROS
 
+/**
+ * Prints a formatted message, similar to printf.
+ */
 __attribute__((format (printf, 1, 2)))
 void trace_printf(const char *format, ...);
 
 __attribute__((format (printf, 2, 3)))
 void trace_printf_key(struct trace_key *key, const char *format, ...);
 
+/**
+ * Prints a formatted message, followed by a quoted list of arguments.
+ */
 __attribute__((format (printf, 2, 3)))
 void trace_argv_printf(const char **argv, const char *format, ...);
 
+/**
+ * Prints the strbuf, without additional formatting (i.e. doesn't
+ * choke on `%` or even `\0`).
+ */
 void trace_strbuf(struct trace_key *key, const struct strbuf *data);
 
-/* Prints elapsed time (in nanoseconds) if GIT_TRACE_PERFORMANCE is enabled. */
+/**
+ * Prints elapsed time (in nanoseconds) if GIT_TRACE_PERFORMANCE is enabled.
+ *
+ * Example:
+ * ------------
+ * uint64_t t = 0;
+ * for (;;) {
+ * 	// ignore
+ * t -= getnanotime();
+ * // code section to measure
+ * t += getnanotime();
+ * // ignore
+ * }
+ * trace_performance(t, "frotz");
+ * ------------
+ */
 __attribute__((format (printf, 2, 3)))
 void trace_performance(uint64_t nanos, const char *format, ...);
 
-/* Prints elapsed time since 'start' if GIT_TRACE_PERFORMANCE is enabled. */
+/**
+ * Prints elapsed time since 'start' if GIT_TRACE_PERFORMANCE is enabled.
+ *
+ * Example:
+ * ------------
+ * uint64_t start = getnanotime();
+ * // code section to measure
+ * trace_performance_since(start, "foobar");
+ * ------------
+ */
 __attribute__((format (printf, 2, 3)))
 void trace_performance_since(uint64_t start, const char *format, ...);
 
-- 
gitgitgadget

