Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.2 (2018-09-13) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-4.1 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,RCVD_IN_DNSWL_HI
	shortcircuit=no autolearn=ham autolearn_force=no version=3.4.2
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id A7DF120248
	for <e@80x24.org>; Thu, 28 Mar 2019 13:31:03 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726879AbfC1NbC (ORCPT <rfc822;e@80x24.org>);
        Thu, 28 Mar 2019 09:31:02 -0400
Received: from mail-ed1-f65.google.com ([209.85.208.65]:41120 "EHLO
        mail-ed1-f65.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726059AbfC1NbC (ORCPT <rfc822;git@vger.kernel.org>);
        Thu, 28 Mar 2019 09:31:02 -0400
Received: by mail-ed1-f65.google.com with SMTP id a25so17219624edc.8
        for <git@vger.kernel.org>; Thu, 28 Mar 2019 06:31:00 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=date:message-id:in-reply-to:references:from:subject:fcc
         :content-transfer-encoding:mime-version:to:cc;
        bh=VsFPVQlrbd+oBjrpClEK4LCZ+NiKxOzUOqbfxGpd3qw=;
        b=L7oWL/uopKhskf5aF415iYf/RzZuTAax2BEDcK83LlsePnFVOcoGijKHdl9cJTni+/
         m2IpFKobRog85pMz77eVvKaIGX4sMnIdXSJvfkLEJfLamgfIJ18mBaYrw0OrowvQuIlA
         WoTjFmHK5TEBm6Na/ij6Ij9N1yyIIg+Y/GrLiuB2t5KrJnCeO6RDlXyEMcpIPQACw+lD
         kWHhzhDjae2dtrgqyv5XQnWQthdq7hAIeTy5VuRHN6kScajIgtrIHtbP2lS0TzfhgbFt
         g75HV8G71vdbqpd1EQ/5w4HW3B8kSEflyD1YHLslRtj457qbNONfiwU1TFXT6/YLNmrj
         E7RQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:message-id:in-reply-to:references:from
         :subject:fcc:content-transfer-encoding:mime-version:to:cc;
        bh=VsFPVQlrbd+oBjrpClEK4LCZ+NiKxOzUOqbfxGpd3qw=;
        b=XyPdNdxzflS/PaslMeVoVeRjup/FBVmR8d3pKCn9fxaQ6QmzTX5DoiDHZ1t0/VgAhk
         BoAztHpoJAWVqIrdAt5kWtK/D2OFsFvoseUAPxX3Deu6qvD4OTVajxCQ8BI4GLDyIddE
         LNOFga3IBt9SqWOJ5kDe5+9r52VKzgs1iO5074RUFgndAskTcL87Sa0V0hOp4D4a5ZJr
         vGKIonJLlIVp16S3kfHymZ1qhW9Z81NL3TKzSCkpX8SX9horbDCidRj2wLxIb3QtQ1cH
         oR/18hO5UsrGCJ0CbnJx3J1f7OmLsCWIrZApxQ4hUnVQxa9uDiettYK9ykM1mZOUU+Pv
         ik7w==
X-Gm-Message-State: APjAAAVNXsO+0Fn0Th42g5E6OUF0najO3q5en0YRkEjhCh3p52ScewdN
        2ZcwZm8ztEO+5j6Y1ZBHSRypxlNn
X-Google-Smtp-Source: APXvYqz2JhFK1wXisY+9uOAcTfxjYDVvjox/WDWhEaOm+/pGz0TeCySQl5B6KIG6ro0Ml7fak2AWuQ==
X-Received: by 2002:a17:906:b756:: with SMTP id fx22mr24288474ejb.192.1553779859751;
        Thu, 28 Mar 2019 06:30:59 -0700 (PDT)
Received: from [127.0.0.1] ([13.74.141.28])
        by smtp.gmail.com with ESMTPSA id f13sm6111615eda.38.2019.03.28.06.30.57
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Thu, 28 Mar 2019 06:30:57 -0700 (PDT)
Date:   Thu, 28 Mar 2019 06:30:57 -0700 (PDT)
X-Google-Original-Date: Thu, 28 Mar 2019 13:30:48 GMT
Message-Id: <7f1a34732271f9fbdbec0f4cd0a5990466ebd071.1553779851.git.gitgitgadget@gmail.com>
In-Reply-To: <pull.169.git.gitgitgadget@gmail.com>
References: <pull.169.git.gitgitgadget@gmail.com>
From:   "Jeff Hostetler via GitGitGadget" <gitgitgadget@gmail.com>
Subject: [PATCH 1/4] trace2: refactor setting process starting time
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
index 8e65b0361d..31fb529f93 100644
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
+	tr2tls_thread_main = tr2tls_create_self("main",
+						tr2tls_us_start_process);
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

