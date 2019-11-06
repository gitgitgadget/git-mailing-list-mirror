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
	by dcvr.yhbt.net (Postfix) with ESMTP id DF8BD1F454
	for <e@80x24.org>; Wed,  6 Nov 2019 10:00:23 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1731833AbfKFKAT (ORCPT <rfc822;e@80x24.org>);
        Wed, 6 Nov 2019 05:00:19 -0500
Received: from mail-wm1-f46.google.com ([209.85.128.46]:50452 "EHLO
        mail-wm1-f46.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1731732AbfKFKAD (ORCPT <rfc822;git@vger.kernel.org>);
        Wed, 6 Nov 2019 05:00:03 -0500
Received: by mail-wm1-f46.google.com with SMTP id 11so2631973wmk.0
        for <git@vger.kernel.org>; Wed, 06 Nov 2019 02:00:02 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=message-id:in-reply-to:references:from:date:subject:fcc
         :content-transfer-encoding:mime-version:to:cc;
        bh=Yj6dU6eAFClAyLjY8JX8pFhWVOm+gb6VPcSQ1NX0okY=;
        b=JYGfjgxn5HRUfJ2+LOcx4fQ3PumjBvHHi9dpAGILihVWnQzGbJ4+v6tKqFnsfNgvza
         fEiKx4I7kyhON7Y3i0xb5AKmLRuf4nt3AxyBq9YZSIGo/Z4PIWrBg9pOGoaFxiEDeBkm
         O4uWW99fx+cn6sCicDUzw6Ln4fD2sWY6iI/r72qA/DG8q20d2qMWO9z1BPWUO+4NsMtW
         2QwiuJqDJt09UHOzLFfk/TtiI2mtAna0zSp5aB6YaGyUZxo+/rtVuF5zNfa1BYT5F3Et
         QBXebcEOWWWyf/QvAbpkyj/nlumPH3fMc+UjYil1Dqx82nRCW3wJB2A9HYqVGGqu8v9b
         k7Aw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:message-id:in-reply-to:references:from:date
         :subject:fcc:content-transfer-encoding:mime-version:to:cc;
        bh=Yj6dU6eAFClAyLjY8JX8pFhWVOm+gb6VPcSQ1NX0okY=;
        b=q8Ct5eRYAic/FIo8vEVuwNMCjRBaqNyXJI3YJbqO1dDxpQNbCBJm3ddXnVC7Z61A1B
         7TwyVfH/NytTMem47hqU4Ora9R6bc751koCPRil89+K4bgAA+CRrp5B1fq3kOz1i8+dd
         NawnM9CQ+hkICP4iCdoPz90R8hTrXfpHQ4Qhj6Xox3hrzxoAUrwrSll2NTuHbNG/K0dQ
         rB4fJDZE8v61PMXkKXbnalCUswwFlRWLSMS+ibTpvvV0fleDbh0eqrvcgOWSRdEP4+VD
         wRCHBjJmXbuhTADWndieI+Vy19HGECeKpmkDQLPYmnCQoFs8HY/4f3aDk2j3799y7AwN
         OPPw==
X-Gm-Message-State: APjAAAWzmZR7J237leemF8NwZcPj0GwtZNj9OpqXJDPU+EBK6T8dUgA+
        Rfra0UQL8k5PN/nTYtgkbD0LsOXB
X-Google-Smtp-Source: APXvYqz2mfPTtGkdl424jmY8XF/8oo3hP+oY51Op77JH6To2VIUMZ9v1NSa6sXR3LDM+lFfObGe2iA==
X-Received: by 2002:a1c:814b:: with SMTP id c72mr1680298wmd.167.1573034400964;
        Wed, 06 Nov 2019 02:00:00 -0800 (PST)
Received: from [127.0.0.1] ([13.74.141.28])
        by smtp.gmail.com with ESMTPSA id 6sm2909209wmd.36.2019.11.06.02.00.00
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Wed, 06 Nov 2019 02:00:00 -0800 (PST)
Message-Id: <9b02b44cc868d8bbdcfd99d26256c2876fc0b03c.1573034387.git.gitgitgadget@gmail.com>
In-Reply-To: <pull.434.v2.git.1573034387.gitgitgadget@gmail.com>
References: <pull.434.git.1572343246.gitgitgadget@gmail.com>
        <pull.434.v2.git.1573034387.gitgitgadget@gmail.com>
From:   "Heba Waly via GitGitGadget" <gitgitgadget@gmail.com>
Date:   Wed, 06 Nov 2019 09:59:44 +0000
Subject: [PATCH v2 17/20] trace: move doc to trace.h
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

