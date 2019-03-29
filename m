Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.2 (2018-09-13) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-4.1 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,RCVD_IN_DNSWL_HI
	shortcircuit=no autolearn=ham autolearn_force=no version=3.4.2
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 33AA220248
	for <e@80x24.org>; Fri, 29 Mar 2019 17:04:38 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729890AbfC2REg (ORCPT <rfc822;e@80x24.org>);
        Fri, 29 Mar 2019 13:04:36 -0400
Received: from mail-ed1-f66.google.com ([209.85.208.66]:33090 "EHLO
        mail-ed1-f66.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1729814AbfC2REe (ORCPT <rfc822;git@vger.kernel.org>);
        Fri, 29 Mar 2019 13:04:34 -0400
Received: by mail-ed1-f66.google.com with SMTP id q3so2675240edg.0
        for <git@vger.kernel.org>; Fri, 29 Mar 2019 10:04:32 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=date:message-id:in-reply-to:references:from:subject:fcc
         :content-transfer-encoding:mime-version:to:cc;
        bh=NQjHoIFjs3C/cZ7OrubkbcSGMwDWVDHj/4Rt1jlRsFs=;
        b=gK3jX1oQrCBBWPK9WYctD4deGaBV7r6H0Ot9iBsMr+/Jp3hzs9XZ6n+nAmKlxxBp1C
         2v0U7o8YeuqVwECghzCXchxpj+2zzAjUE/pPbpLaKBjI+Z6XEyFxPEmXxVJcZy0yCw12
         Pl6mCEGbQVVlB3EL0qlP/+rtGk541O38V+Sa2BASrzcq3AP54rll64TSMD2ql9N42xRJ
         cet5uFjlLVumd1gRyy2aSbT+cR+IPyPaXIsJPhnVEyE7AgNe9UPgeEmRwq4tdkjn5APC
         1jRwsySLhMoUrlKxcNKi8XJaWuXxa4ZGbxOY4HF45PfFFqRroTF1XdcoWss40NklYNRd
         GoKA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:message-id:in-reply-to:references:from
         :subject:fcc:content-transfer-encoding:mime-version:to:cc;
        bh=NQjHoIFjs3C/cZ7OrubkbcSGMwDWVDHj/4Rt1jlRsFs=;
        b=BN1ISdOaG7YKNfr+rWkSbOx6WoEKmPRdi1GKEPnbyBWkiwBt8EKxHBLR12Cl47U4NM
         gleH02r5MQuTn/zBwfNNVlJLlliD7UgPTcon2Bjo1YfRPbJlde0bt0eApaBKbgou9KWP
         Ubuh5x5xCtp3xQMyC2+d1qQDcREn4ylmBHWteDAoCw91InaL4WNappHB8b6MiAfRKqkR
         rLLjl8xIfiJG3m5xzCw35S3nmbHw4gCz+n70yfV+kKffzHIHbJK9X7bt2K8UT/cT2e12
         0a9AMMpVNcD4DTtgbEAQnwAj4IttuP2QndH6DMwmr6KxjmIDWb1zuB5dwS5wpJftdcJ/
         Cirg==
X-Gm-Message-State: APjAAAX5Rgdn2CLSzpUJ3spAofDb4k3kovPgzFKAoPnoHvOGnTrz/4vb
        8qe7ht2h5//rj7pJwKcACX4qA0jZ
X-Google-Smtp-Source: APXvYqwO3/za0w/KL8F/SbVZusIfyM8g4yyrk+XLrw+9hKNH2goAG1IXMfm4iSh2dLSJ2DuC9xzbIQ==
X-Received: by 2002:a17:906:2306:: with SMTP id l6mr27525969eja.27.1553879071650;
        Fri, 29 Mar 2019 10:04:31 -0700 (PDT)
Received: from [127.0.0.1] ([13.74.141.28])
        by smtp.gmail.com with ESMTPSA id b34sm518569edd.24.2019.03.29.10.04.30
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Fri, 29 Mar 2019 10:04:30 -0700 (PDT)
Date:   Fri, 29 Mar 2019 10:04:30 -0700 (PDT)
X-Google-Original-Date: Fri, 29 Mar 2019 17:04:23 GMT
Message-Id: <4352952677a11776a18ec9b6862cf358307cfafd.1553879063.git.gitgitgadget@gmail.com>
In-Reply-To: <pull.169.v2.git.gitgitgadget@gmail.com>
References: <pull.169.git.gitgitgadget@gmail.com>
        <pull.169.v2.git.gitgitgadget@gmail.com>
From:   "Jeff Hostetler via GitGitGadget" <gitgitgadget@gmail.com>
Subject: [PATCH v2 7/7] trace2: make SIDs more unique
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

Update SID component construction to use the current UTC datetime
and a portion of the SHA1 of the hostname.

Use an simplified date/time format to make it easier to use the
SID component as a logfile filename.

Signed-off-by: Jeff Hostetler <jeffhost@microsoft.com>
---
 Documentation/technical/api-trace2.txt | 12 ++++----
 trace2/tr2_sid.c                       | 39 +++++++++++++++++++++++---
 trace2/tr2_tbuf.c                      | 16 +++++++++++
 trace2/tr2_tbuf.h                      |  1 +
 4 files changed, 58 insertions(+), 10 deletions(-)

diff --git a/Documentation/technical/api-trace2.txt b/Documentation/technical/api-trace2.txt
index db968e31f7..e740db3907 100644
--- a/Documentation/technical/api-trace2.txt
+++ b/Documentation/technical/api-trace2.txt
@@ -78,11 +78,11 @@ git version 2.20.1.155.g426c96fcdb
 +
 ------------
 $ cat ~/log.event
-{"event":"version","sid":"1547659722619736-11614","thread":"main","time":"2019-01-16T17:28:42.620713Z","file":"common-main.c","line":38,"evt":"1","exe":"2.20.1.155.g426c96fcdb"}
-{"event":"start","sid":"1547659722619736-11614","thread":"main","time":"2019-01-16T17:28:42.621027Z","file":"common-main.c","line":39,"t_abs":0.001173,"argv":["git","version"]}
-{"event":"cmd_name","sid":"1547659722619736-11614","thread":"main","time":"2019-01-16T17:28:42.621122Z","file":"git.c","line":432,"name":"version","hierarchy":"version"}
-{"event":"exit","sid":"1547659722619736-11614","thread":"main","time":"2019-01-16T17:28:42.621236Z","file":"git.c","line":662,"t_abs":0.001227,"code":0}
-{"event":"atexit","sid":"1547659722619736-11614","thread":"main","time":"2019-01-16T17:28:42.621268Z","file":"trace2/tr2_tgt_event.c","line":163,"t_abs":0.001265,"code":0}
+{"event":"version","sid":"20190329-144314-319944-9b68c35f-012232","thread":"main","time":"2019-01-16T17:28:42.620713Z","file":"common-main.c","line":38,"evt":"1","exe":"2.20.1.155.g426c96fcdb"}
+{"event":"start","sid":"20190329-144314-319944-9b68c35f-012232","thread":"main","time":"2019-01-16T17:28:42.621027Z","file":"common-main.c","line":39,"t_abs":0.001173,"argv":["git","version"]}
+{"event":"cmd_name","sid":"20190329-144314-319944-9b68c35f-012232","thread":"main","time":"2019-01-16T17:28:42.621122Z","file":"git.c","line":432,"name":"version","hierarchy":"version"}
+{"event":"exit","sid":"20190329-144314-319944-9b68c35f-012232","thread":"main","time":"2019-01-16T17:28:42.621236Z","file":"git.c","line":662,"t_abs":0.001227,"code":0}
+{"event":"atexit","sid":"20190329-144314-319944-9b68c35f-012232","thread":"main","time":"2019-01-16T17:28:42.621268Z","file":"trace2/tr2_tgt_event.c","line":163,"t_abs":0.001265,"code":0}
 ------------
 
 == Enabling a Target
@@ -571,7 +571,7 @@ The following key/value pairs are common to all events:
 ------------
 {
 	"event":"version",
-	"sid":"1547659722619736-11614",
+	"sid":"20190329-144314-319944-9b68c35f-012232",
 	"thread":"main",
 	"time":"2019-01-16T17:28:42.620713Z",
 	"file":"common-main.c",
diff --git a/trace2/tr2_sid.c b/trace2/tr2_sid.c
index 984524a43c..6801113e53 100644
--- a/trace2/tr2_sid.c
+++ b/trace2/tr2_sid.c
@@ -1,4 +1,5 @@
 #include "cache.h"
+#include "trace2/tr2_tbuf.h"
 #include "trace2/tr2_sid.h"
 
 #define TR2_ENVVAR_PARENT_SID "GIT_TR2_PARENT_SID"
@@ -6,6 +7,39 @@
 static struct strbuf tr2sid_buf = STRBUF_INIT;
 static int tr2sid_nr_git_parents;
 
+/*
+ * Compute the final component of the SID representing the current process.
+ * This should uniquely identify the process and be a valid filename (to
+ * allow writing trace2 data to per-process files).
+ *
+ * <yyyymmdd> '-' <hhmmss> '-' <fraction> '-' <sha1-prefix> '-' <pid>
+ */
+static void tr2_sid_append_my_sid_component(void)
+{
+	const struct git_hash_algo *algo = &hash_algos[GIT_HASH_SHA1];
+	struct tr2_tbuf tb_now;
+	git_hash_ctx ctx;
+	unsigned char hash[GIT_MAX_RAWSZ + 1];
+	char hex[GIT_MAX_HEXSZ + 1];
+	char hostname[HOST_NAME_MAX + 1];
+
+	tr2_tbuf_utc_datetime_for_filename(&tb_now);
+	strbuf_addstr(&tr2sid_buf, tb_now.buf);
+	strbuf_addch(&tr2sid_buf, '-');
+
+	if (xgethostname(hostname, sizeof(hostname)))
+		xsnprintf(hostname, sizeof(hostname), "localhost");
+
+	algo->init_fn(&ctx);
+	algo->update_fn(&ctx, hostname, strlen(hostname));
+	algo->final_fn(hash, &ctx);
+	hash_to_hex_algop_r(hex, hash, algo);
+	strbuf_add(&tr2sid_buf, hex, 8);
+
+	strbuf_addch(&tr2sid_buf, '-');
+	strbuf_addf(&tr2sid_buf, "%06"PRIuMAX, (uintmax_t)getpid());
+}
+
 /*
  * Compute a "unique" session id (SID) for the current process.  This allows
  * all events from this process to have a single label (much like a PID).
@@ -20,7 +54,6 @@ static int tr2sid_nr_git_parents;
  */
 static void tr2_sid_compute(void)
 {
-	uint64_t us_now;
 	const char *parent_sid;
 
 	if (tr2sid_buf.len)
@@ -38,9 +71,7 @@ static void tr2_sid_compute(void)
 		tr2sid_nr_git_parents++;
 	}
 
-	us_now = getnanotime() / 1000;
-	strbuf_addf(&tr2sid_buf, "%" PRIuMAX "-%" PRIdMAX, (uintmax_t)us_now,
-		    (intmax_t)getpid());
+	tr2_sid_append_my_sid_component();
 
 	setenv(TR2_ENVVAR_PARENT_SID, tr2sid_buf.buf, 1);
 }
diff --git a/trace2/tr2_tbuf.c b/trace2/tr2_tbuf.c
index eb1b240d8a..c1a50fe084 100644
--- a/trace2/tr2_tbuf.c
+++ b/trace2/tr2_tbuf.c
@@ -30,3 +30,19 @@ void tr2_tbuf_utc_datetime_extended(struct tr2_tbuf *tb)
 		  tm.tm_mon + 1, tm.tm_mday, tm.tm_hour, tm.tm_min, tm.tm_sec,
 		  (long)tv.tv_usec);
 }
+
+void tr2_tbuf_utc_datetime_for_filename(struct tr2_tbuf *tb)
+{
+	struct timeval tv;
+	struct tm tm;
+	time_t secs;
+
+	gettimeofday(&tv, NULL);
+	secs = tv.tv_sec;
+	gmtime_r(&secs, &tm);
+
+	xsnprintf(tb->buf, sizeof(tb->buf),
+		  "%4d%02d%02d-%02d%02d%02d-%06ld", tm.tm_year + 1900,
+		  tm.tm_mon + 1, tm.tm_mday, tm.tm_hour, tm.tm_min, tm.tm_sec,
+		  (long)tv.tv_usec);
+}
diff --git a/trace2/tr2_tbuf.h b/trace2/tr2_tbuf.h
index 2a1d173ff2..29efff1ef7 100644
--- a/trace2/tr2_tbuf.h
+++ b/trace2/tr2_tbuf.h
@@ -19,5 +19,6 @@ void tr2_tbuf_local_time(struct tr2_tbuf *tb);
  * Fill buffer with formatted UTC datatime string.
  */
 void tr2_tbuf_utc_datetime_extended(struct tr2_tbuf *tb);
+void tr2_tbuf_utc_datetime_for_filename(struct tr2_tbuf *tb);
 
 #endif /* TR2_TBUF_H */
-- 
gitgitgadget
