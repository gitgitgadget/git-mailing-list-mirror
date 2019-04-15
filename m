Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.2 (2018-09-13) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-4.1 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,RCVD_IN_DNSWL_HI
	shortcircuit=no autolearn=ham autolearn_force=no version=3.4.2
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id ACB0520248
	for <e@80x24.org>; Mon, 15 Apr 2019 20:39:49 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727831AbfDOUjs (ORCPT <rfc822;e@80x24.org>);
        Mon, 15 Apr 2019 16:39:48 -0400
Received: from mail-ed1-f66.google.com ([209.85.208.66]:42345 "EHLO
        mail-ed1-f66.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727720AbfDOUjr (ORCPT <rfc822;git@vger.kernel.org>);
        Mon, 15 Apr 2019 16:39:47 -0400
Received: by mail-ed1-f66.google.com with SMTP id x61so15882199edc.9
        for <git@vger.kernel.org>; Mon, 15 Apr 2019 13:39:45 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=date:message-id:in-reply-to:references:from:subject:fcc
         :content-transfer-encoding:mime-version:to:cc;
        bh=ktNx9nrsRgI+0jnvlP8nBufSFfGnqbif1MQBkfUhywA=;
        b=OWGMfmLKbCKo2Ee/GLHx3VYDVuqwu+a4We5MLvTDj3ADDYXc7onbS3wAs9T2LbZ0vU
         DWieLg7v+SYdns+EWwt7eCHUpDcdnWN/V8/rSr1odG7rRf4oEg7xXDlXeNbVt68h30Ld
         YtS0cCRp5W6D06CHIW/LJSNRwnOfI/QrJoSAA2ESa3MTZWPXE6XN4uTNNdbdVzY798g0
         mn5OzHi02PjG/Ud2LjBRcwTnY8XxSc52amHgwDvTm7evYZoHlq6Q6rxqUvyIZKC4cx0U
         W2ZFEcTBUbj/wDxZocUwj91iHJKIe2nePf915jo4ndsOmvr5UlYw51DfgaY2//ujwUfT
         cPug==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:message-id:in-reply-to:references:from
         :subject:fcc:content-transfer-encoding:mime-version:to:cc;
        bh=ktNx9nrsRgI+0jnvlP8nBufSFfGnqbif1MQBkfUhywA=;
        b=SDKgLiVTO1OpPg5EqpPgD1OCunZ8xGOx9ZbEsPCxwrBTBe3FOjjRyhaSGWjTUCWZvM
         BS6672bBRhs850iI9hXM5/OjUCKreJDrB3DarTXnfhleBrm3FxgMHY4cBKIKzcFH/VwX
         tjfAq3dMTkgvgXS/H+8iQCa/WKBKkkEbWZzQNArq3fN/k+auI+nhLOzgJgHDGcZhOvcZ
         iD+9frF+JloY0pmH5Ubi95BkbEGPTsZNlqM12HdOgixu95sR3NdbdfNtgJY2wR3rfyfC
         O4KFU5aDNXzW62ZlQA4JVYWRaYkbaEhIgI/X0z5nHbQdcxfZDr4Cduj/nd1GYbdAItVG
         PT8A==
X-Gm-Message-State: APjAAAXCdeywEJZj+Rk29AKzyL6L8dHoAXB0Yl+uCHB8DnftX5zFEKDg
        9ppHi4Z17t1TL2J1Sd7Yfip8KfYI
X-Google-Smtp-Source: APXvYqy+pw57fPn/xyUWwziXIoYeEIbQY5//XiqcUMVzSeB5A/h2gEjqKwa9k0ErUgM+vbHNoxdynA==
X-Received: by 2002:a17:906:5ad6:: with SMTP id x22mr37312115ejs.79.1555360784348;
        Mon, 15 Apr 2019 13:39:44 -0700 (PDT)
Received: from [127.0.0.1] ([13.74.141.28])
        by smtp.gmail.com with ESMTPSA id j8sm3191535edq.39.2019.04.15.13.39.43
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Mon, 15 Apr 2019 13:39:43 -0700 (PDT)
Date:   Mon, 15 Apr 2019 13:39:43 -0700 (PDT)
X-Google-Original-Date: Mon, 15 Apr 2019 20:39:32 GMT
Message-Id: <48e34834b6a65b9f2c68d4f4e459586b2948b6cd.1555360780.git.gitgitgadget@gmail.com>
In-Reply-To: <pull.169.v4.git.gitgitgadget@gmail.com>
References: <pull.169.v3.git.gitgitgadget@gmail.com>
        <pull.169.v4.git.gitgitgadget@gmail.com>
From:   "Jeff Hostetler via GitGitGadget" <gitgitgadget@gmail.com>
Subject: [PATCH v4 02/10] trace2: refactor setting process starting time
Fcc:    Sent
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
MIME-Version: 1.0
To:     git@vger.kernel.org
Cc:     gitster@pobox.com, peff@peff.net, jrnieder@gmail.com,
        steadmon@google.com, avarab@gmail.com,
        Junio C Hamano <gitster@pobox.com>,
        Jeff Hostetler <jeffhost@microsoft.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

From: Jeff Hostetler <jeffhost@microsoft.com>

Create trace2_initialize_clock() and call from main() to capture
process start time in isolation and before other sub-systems are
ready.

Signed-off-by: Jeff Hostetler <jeffhost@microsoft.com>
---
 Documentation/technical/api-trace2.txt | 12 ++++++--
 common-main.c                          |  2 ++
 compat/mingw.c                         |  2 ++
 trace2.c                               |  7 ++++-
 trace2.h                               | 17 ++++++++++++
 trace2/tr2_tls.c                       | 38 ++++++++++++++++----------
 trace2/tr2_tls.h                       |  8 +++++-
 7 files changed, 67 insertions(+), 19 deletions(-)

diff --git a/Documentation/technical/api-trace2.txt b/Documentation/technical/api-trace2.txt
index 2de565fa3d..f37fccf1da 100644
--- a/Documentation/technical/api-trace2.txt
+++ b/Documentation/technical/api-trace2.txt
@@ -160,17 +160,23 @@ purposes.
 
 These are concerned with the lifetime of the overall git process.
 
+`void trace2_initialize_clock()`::
+
+	Initialize the Trace2 start clock and nothing else.  This should
+	be called at the very top of main() to capture the process start
+	time and reduce startup order dependencies.
+
 `void trace2_initialize()`::
 
 	Determines if any Trace2 Targets should be enabled and
-	initializes the Trace2 facility.  This includes starting the
-	elapsed time clocks and thread local storage (TLS).
+	initializes the Trace2 facility.  This includes setting up the
+	Trace2 thread local storage (TLS).
 +
 This function emits a "version" message containing the version of git
 and the Trace2 protocol.
 +
 This function should be called from `main()` as early as possible in
-the life of the process.
+the life of the process after essential process initialization.
 
 `int trace2_is_enabled()`::
 
diff --git a/common-main.c b/common-main.c
index d484aec209..6137af0e63 100644
--- a/common-main.c
+++ b/common-main.c
@@ -27,6 +27,8 @@ int main(int argc, const char **argv)
 {
 	int result;
 
+	trace2_initialize_clock();
+
 	/*
 	 * Always open file descriptors 0/1/2 to avoid clobbering files
 	 * in die().  It also avoids messing up when the pipes are dup'ed
diff --git a/compat/mingw.c b/compat/mingw.c
index 6b04514cdc..a2f74aca6a 100644
--- a/compat/mingw.c
+++ b/compat/mingw.c
@@ -2569,6 +2569,8 @@ void mingw_startup(void)
 	wchar_t **wenv, **wargv;
 	_startupinfo si;
 
+	trace2_initialize_clock();
+
 	maybe_redirect_std_handles();
 
 	/* get wide char arguments and environment */
diff --git a/trace2.c b/trace2.c
index ccccd4ef09..6dd51e6aa5 100644
--- a/trace2.c
+++ b/trace2.c
@@ -142,6 +142,11 @@ static void tr2main_signal_handler(int signo)
 	raise(signo);
 }
 
+void trace2_initialize_clock(void)
+{
+	tr2tls_start_process_clock();
+}
+
 void trace2_initialize_fl(const char *file, int line)
 {
 	struct tr2_tgt *tgt_j;
@@ -428,7 +433,7 @@ void trace2_thread_start_fl(const char *file, int line, const char *thread_name)
 	us_now = getnanotime() / 1000;
 	us_elapsed_absolute = tr2tls_absolute_elapsed(us_now);
 
-	tr2tls_create_self(thread_name);
+	tr2tls_create_self(thread_name, us_now);
 
 	for_each_wanted_builtin (j, tgt_j)
 		if (tgt_j->pfn_thread_start_fl)
diff --git a/trace2.h b/trace2.h
index ae5020d0e6..8f89e70c44 100644
--- a/trace2.h
+++ b/trace2.h
@@ -19,6 +19,23 @@ struct json_writer;
  * [] trace2_printf*    -- legacy trace[1] messages.
  */
 
+/*
+ * Initialize the TRACE2 clock and do nothing else, in particular
+ * no mallocs, no system inspection, and no environment inspection.
+ *
+ * This should be called at the very top of main() to capture the
+ * process start time.  This is intended to reduce chicken-n-egg
+ * bootstrap pressure.
+ *
+ * It is safe to call this more than once.  This allows capturing
+ * absolute startup costs on Windows which uses a little trickery
+ * to do setup work before common-main.c:main() is called.
+ *
+ * The main trace2_initialize_fl() may be called a little later
+ * after more infrastructure is established.
+ */
+void trace2_initialize_clock(void);
+
 /*
  * Initialize TRACE2 tracing facility if any of the builtin TRACE2
  * targets are enabled in the environment.  Emits a 'version' event.
diff --git a/trace2/tr2_tls.c b/trace2/tr2_tls.c
index 8e65b0361d..e76d8c5d92 100644
--- a/trace2/tr2_tls.c
+++ b/trace2/tr2_tls.c
@@ -10,16 +10,30 @@
 #define TR2_REGION_NESTING_INITIAL_SIZE (100)
 
 static struct tr2tls_thread_ctx *tr2tls_thread_main;
-static uint64_t tr2tls_us_start_main;
+static uint64_t tr2tls_us_start_process;
 
 static pthread_mutex_t tr2tls_mutex;
 static pthread_key_t tr2tls_key;
 
 static int tr2_next_thread_id; /* modify under lock */
 
-struct tr2tls_thread_ctx *tr2tls_create_self(const char *thread_name)
+void tr2tls_start_process_clock(void)
+{
+	if (tr2tls_us_start_process)
+		return;
+
+	/*
+	 * Keep the absolute start time of the process (i.e. the main
+	 * process) in a fixed variable since other threads need to
+	 * access it.  This allows them to do that without a lock on
+	 * main thread's array data (because of reallocs).
+	 */
+	tr2tls_us_start_process = getnanotime() / 1000;
+}
+
+struct tr2tls_thread_ctx *tr2tls_create_self(const char *thread_name,
+					     uint64_t us_thread_start)
 {
-	uint64_t us_now = getnanotime() / 1000;
 	struct tr2tls_thread_ctx *ctx = xcalloc(1, sizeof(*ctx));
 
 	/*
@@ -29,7 +43,7 @@ struct tr2tls_thread_ctx *tr2tls_create_self(const char *thread_name)
 	 */
 	ctx->alloc = TR2_REGION_NESTING_INITIAL_SIZE;
 	ctx->array_us_start = (uint64_t *)xcalloc(ctx->alloc, sizeof(uint64_t));
-	ctx->array_us_start[ctx->nr_open_regions++] = us_now;
+	ctx->array_us_start[ctx->nr_open_regions++] = us_thread_start;
 
 	ctx->thread_id = tr2tls_locked_increment(&tr2_next_thread_id);
 
@@ -55,7 +69,7 @@ struct tr2tls_thread_ctx *tr2tls_get_self(void)
 	 * here and silently continue.
 	 */
 	if (!ctx)
-		ctx = tr2tls_create_self("unknown");
+		ctx = tr2tls_create_self("unknown", getnanotime() / 1000);
 
 	return ctx;
 }
@@ -124,22 +138,18 @@ uint64_t tr2tls_absolute_elapsed(uint64_t us)
 	if (!tr2tls_thread_main)
 		return 0;
 
-	return us - tr2tls_us_start_main;
+	return us - tr2tls_us_start_process;
 }
 
 void tr2tls_init(void)
 {
+	tr2tls_start_process_clock();
+
 	pthread_key_create(&tr2tls_key, NULL);
 	init_recursive_mutex(&tr2tls_mutex);
 
-	tr2tls_thread_main = tr2tls_create_self("main");
-	/*
-	 * Keep a copy of the absolute start time of the main thread
-	 * in a fixed variable since other threads need to access it.
-	 * This also eliminates the need to lock accesses to the main
-	 * thread's array (because of reallocs).
-	 */
-	tr2tls_us_start_main = tr2tls_thread_main->array_us_start[0];
+	tr2tls_thread_main =
+		tr2tls_create_self("main", tr2tls_us_start_process);
 }
 
 void tr2tls_release(void)
diff --git a/trace2/tr2_tls.h b/trace2/tr2_tls.h
index bb80e3f8e7..b1e327a928 100644
--- a/trace2/tr2_tls.h
+++ b/trace2/tr2_tls.h
@@ -31,7 +31,8 @@ struct tr2tls_thread_ctx {
  * In this and all following functions the term "self" refers to the
  * current thread.
  */
-struct tr2tls_thread_ctx *tr2tls_create_self(const char *thread_name);
+struct tr2tls_thread_ctx *tr2tls_create_self(const char *thread_name,
+					     uint64_t us_thread_start);
 
 /*
  * Get our TLS data.
@@ -94,4 +95,9 @@ void tr2tls_release(void);
  */
 int tr2tls_locked_increment(int *p);
 
+/*
+ * Capture the process start time and do nothing else.
+ */
+void tr2tls_start_process_clock(void);
+
 #endif /* TR2_TLS_H */
-- 
gitgitgadget

