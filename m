Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.2 (2018-09-13) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-3.9 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,RCVD_IN_DNSWL_HI,
	SPF_HELO_NONE,SPF_NONE shortcircuit=no autolearn=ham
	autolearn_force=no version=3.4.2
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 2F15D1F454
	for <e@80x24.org>; Mon, 11 Nov 2019 21:28:38 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727451AbfKKV2f (ORCPT <rfc822;e@80x24.org>);
        Mon, 11 Nov 2019 16:28:35 -0500
Received: from mail-wm1-f53.google.com ([209.85.128.53]:34622 "EHLO
        mail-wm1-f53.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727325AbfKKV2W (ORCPT <rfc822;git@vger.kernel.org>);
        Mon, 11 Nov 2019 16:28:22 -0500
Received: by mail-wm1-f53.google.com with SMTP id j18so810004wmk.1
        for <git@vger.kernel.org>; Mon, 11 Nov 2019 13:28:20 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=message-id:in-reply-to:references:from:date:subject:fcc
         :content-transfer-encoding:mime-version:to:cc;
        bh=Yj6dU6eAFClAyLjY8JX8pFhWVOm+gb6VPcSQ1NX0okY=;
        b=o+ANiO604cQggN8tD/bQYc4AK5Quj4avl8pvr1Z60X5AGoralVItNAJ/+PZeVua7i8
         +KOUEsaRShdDaiF8QZrr0tgSE52geKsm8WiYgIip6xvzy7AQ/K2V2YOMuFdAwXbamFfZ
         gUWaUNTs3MtvrCQ30CZ1stfIDMROjVCt1sqtw2a9bJKuS5VWu35qq0pp8tHWYwjb0Yht
         mrsB8BhhcK08v3x6yNISxuzqPfcicuOzstz5sR67EgQ9l15RxAuR/hXw+oOHZA+MxY0k
         sQaCVxMPBnnrSLx7aOje5mNze3RCL28jGSZUQRinapnkIKHGcmO3lOPE77AiRrZX9dNY
         izDg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:message-id:in-reply-to:references:from:date
         :subject:fcc:content-transfer-encoding:mime-version:to:cc;
        bh=Yj6dU6eAFClAyLjY8JX8pFhWVOm+gb6VPcSQ1NX0okY=;
        b=jSGT2mQaZ8uRkVr2w0H3ecAa7mHj1cEVd9gUGXCU337r3qP9eojwRG/8ER7UvuC37Y
         4HasW2u+3FtlFEw9dvFLdjt2nSV93yq0Xe8xesJ7ovDjIl9x4jOYJvqzOKRfZmvnvSY7
         ZG4p2QEXhpcvPdmclwcJi4oa84zW41Bt5ICzxauhtGznfpPYoS/OZPoNfGLBmyBrMA/F
         IGU+L1+EwfShi+V1Pfd09h0rP8E1GvaWXxVlD9Pmt3LovRc/VigZpMRcfVm0FSJl2xsu
         9ZVupt9brMfPOlKncmSEGWr8rrYsxKLjy9LUFW3z4EzTi6YEaI3VUD6NMouAEG3z+cxh
         KRNw==
X-Gm-Message-State: APjAAAWyDP1aayd/DS3onFa/AkKtqLIfbV9ZXrh2fuaQu72vLG27ZzGn
        aljNbRAhlCUKA33mWLKwkl6gYIn0
X-Google-Smtp-Source: APXvYqxc7iB8X2wEED32lWKyyQDuQoSyxdeWOordIqBiCx0XaoKupqR8/fpaBZApX7M4y61eILtrNw==
X-Received: by 2002:a1c:b404:: with SMTP id d4mr937558wmf.9.1573507699565;
        Mon, 11 Nov 2019 13:28:19 -0800 (PST)
Received: from [127.0.0.1] ([13.74.141.28])
        by smtp.gmail.com with ESMTPSA id b15sm9285773wrx.77.2019.11.11.13.28.18
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Mon, 11 Nov 2019 13:28:18 -0800 (PST)
Message-Id: <f4df8e16ed2a93b7ffe8cd33c53118aef3fcbf8b.1573507684.git.gitgitgadget@gmail.com>
In-Reply-To: <pull.434.v3.git.1573507684.gitgitgadget@gmail.com>
References: <pull.434.v2.git.1573034387.gitgitgadget@gmail.com>
        <pull.434.v3.git.1573507684.gitgitgadget@gmail.com>
From:   "Heba Waly via GitGitGadget" <gitgitgadget@gmail.com>
Date:   Mon, 11 Nov 2019 21:28:00 +0000
Subject: [PATCH v3 17/21] trace: move doc to trace.h
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

