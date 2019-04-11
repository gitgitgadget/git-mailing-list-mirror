Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.2 (2018-09-13) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-4.1 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,RCVD_IN_DNSWL_HI
	shortcircuit=no autolearn=ham autolearn_force=no version=3.4.2
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 3CFF920248
	for <e@80x24.org>; Thu, 11 Apr 2019 15:18:58 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726867AbfDKPSz (ORCPT <rfc822;e@80x24.org>);
        Thu, 11 Apr 2019 11:18:55 -0400
Received: from mail-ed1-f66.google.com ([209.85.208.66]:41591 "EHLO
        mail-ed1-f66.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726836AbfDKPSs (ORCPT <rfc822;git@vger.kernel.org>);
        Thu, 11 Apr 2019 11:18:48 -0400
Received: by mail-ed1-f66.google.com with SMTP id g6so1593102edc.8
        for <git@vger.kernel.org>; Thu, 11 Apr 2019 08:18:46 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=date:message-id:in-reply-to:references:from:subject:fcc
         :content-transfer-encoding:mime-version:to:cc;
        bh=m7CUh+R/7oUqzscKHaVccUmPLs3cY/V7ngmQ3fXpoy4=;
        b=VTbVOJBNq8X27vSTd6xAF0UbMMnYUu5AGTftxkF01SZ7744H3h6hF/Viwr1hdvfR9v
         1uk49I9BUpnJmwaHvt4K1CFxxXuhKlM+X/yY+PzDZjFOyKpjPEW9vsLzcs5qMGzpKtcq
         tRNA+Zop/ycmLg7wzA8wjpir+PmG443u7DzyiJWu6dMKKS90k4djveblyazvwZ6s0/+y
         iPRpp7xkB4pbW6ZCspSxvpqDae4Rn6a4kY2ACbz8TIAYBGJYp3fPI/nh45q7yJaed2in
         cHwsg+wGWmyN+rC7p8IcoK6J6t5Tubd9UAq1dN8OCNOmOfSyqhtMbatXCye1xvFEj1vs
         Lbjg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:message-id:in-reply-to:references:from
         :subject:fcc:content-transfer-encoding:mime-version:to:cc;
        bh=m7CUh+R/7oUqzscKHaVccUmPLs3cY/V7ngmQ3fXpoy4=;
        b=pPTBHrPlUd3vZXowAm72FWycAyfsbjIromEEjRV8l0JXR1xaKuKZeRiKywIMsR3jF7
         fKLxvJ9EA5cW/fD/99XQoUqGHng81WGFmpCY5xgCsdO7Lkoh8UQJZBNeuwD7Z12h2Tym
         HsPciiOBFAsvdpL4eRclNQigcET9C7ZSWO422wtOyeL0LXGDIe0mjIMU795BXgfqIyH8
         QovmbKZIpYBGOVGFQ7HscVDkxZQoFJ6i4/nds1K/zsS5lEa/sDkuWzPPZzIiVNi24LDf
         YhIEutYeHBqoPzJG8y5IdyUYPhm5G+YA25Ug6qMGlWa9modmxXqx3rHXkhJP5o5koesl
         0L0Q==
X-Gm-Message-State: APjAAAVgKPo0hgqgz/rt1nXOhEqQQxf+GH4SI6NDYFGNehmRwzpfcJLr
        5BReLP/eQb6Q201iyj7rk6CVnAyk
X-Google-Smtp-Source: APXvYqwULUyVT3Yn4D0L2eDk5wuGNt6HScJ7+pVu3oZCOoDHyJ9AeP7ZnnzHe6CfQownNAe++ORQMA==
X-Received: by 2002:a50:b582:: with SMTP id a2mr32402383ede.268.1554995925674;
        Thu, 11 Apr 2019 08:18:45 -0700 (PDT)
Received: from [127.0.0.1] ([13.74.141.28])
        by smtp.gmail.com with ESMTPSA id a38sm11482161eda.71.2019.04.11.08.18.45
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Thu, 11 Apr 2019 08:18:45 -0700 (PDT)
Date:   Thu, 11 Apr 2019 08:18:45 -0700 (PDT)
X-Google-Original-Date: Thu, 11 Apr 2019 15:18:35 GMT
Message-Id: <156ffde4895ac1a64e033341a313ccb3ba7485cd.1554995916.git.gitgitgadget@gmail.com>
In-Reply-To: <pull.169.v3.git.gitgitgadget@gmail.com>
References: <pull.169.v2.git.gitgitgadget@gmail.com>
        <pull.169.v3.git.gitgitgadget@gmail.com>
From:   "Jeff Hostetler via GitGitGadget" <gitgitgadget@gmail.com>
Subject: [PATCH v3 09/10] trace2: make SIDs more unique
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
 Documentation/technical/api-trace2.txt | 16 ++++----
 trace2/tr2_sid.c                       | 55 ++++++++++++++++++++++++--
 trace2/tr2_tbuf.c                      | 16 ++++++++
 trace2/tr2_tbuf.h                      |  1 +
 4 files changed, 76 insertions(+), 12 deletions(-)

diff --git a/Documentation/technical/api-trace2.txt b/Documentation/technical/api-trace2.txt
index cdc00bcc5d..43adbf00eb 100644
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
+{"event":"version","sid":"sid":"20190408T191610.507018Z-H9b68c35f-P028492","thread":"main","time":"2019-01-16T17:28:42.620713Z","file":"common-main.c","line":38,"evt":"1","exe":"2.20.1.155.g426c96fcdb"}
+{"event":"start","sid":"20190408T191610.507018Z-H9b68c35f-P028492","thread":"main","time":"2019-01-16T17:28:42.621027Z","file":"common-main.c","line":39,"t_abs":0.001173,"argv":["git","version"]}
+{"event":"cmd_name","sid":"20190408T191610.507018Z-H9b68c35f-P028492","thread":"main","time":"2019-01-16T17:28:42.621122Z","file":"git.c","line":432,"name":"version","hierarchy":"version"}
+{"event":"exit","sid":"20190408T191610.507018Z-H9b68c35f-P028492","thread":"main","time":"2019-01-16T17:28:42.621236Z","file":"git.c","line":662,"t_abs":0.001227,"code":0}
+{"event":"atexit","sid":"20190408T191610.507018Z-H9b68c35f-P028492","thread":"main","time":"2019-01-16T17:28:42.621268Z","file":"trace2/tr2_tgt_event.c","line":163,"t_abs":0.001265,"code":0}
 ------------
 
 == Enabling a Target
@@ -540,11 +540,11 @@ The following key/value pairs are common to all events:
 ------------
 {
 	"event":"version",
-	"sid":"1547659722619736-11614",
+	"sid":"20190408T191827.272759Z-H9b68c35f-P011764",
 	"thread":"main",
-	"time":"2019-01-16T17:28:42.620713Z",
+	"time":"2019-04-08T19:18:27.282761Z",
 	"file":"common-main.c",
-	"line":38,
+	"line":42,
 	...
 }
 ------------
diff --git a/trace2/tr2_sid.c b/trace2/tr2_sid.c
index 984524a43c..68d723bc6c 100644
--- a/trace2/tr2_sid.c
+++ b/trace2/tr2_sid.c
@@ -1,4 +1,5 @@
 #include "cache.h"
+#include "trace2/tr2_tbuf.h"
 #include "trace2/tr2_sid.h"
 
 #define TR2_ENVVAR_PARENT_SID "GIT_TR2_PARENT_SID"
@@ -6,6 +7,55 @@
 static struct strbuf tr2sid_buf = STRBUF_INIT;
 static int tr2sid_nr_git_parents;
 
+/*
+ * Compute the final component of the SID representing the current process.
+ * This should uniquely identify the process and be a valid filename (to
+ * allow writing trace2 data to per-process files).  It should also be fixed
+ * possible length for use as a database key.
+ *
+ * "<yyyymmdd>T<hhmmss>.<fraction>Z-<host>-<process>"
+ *
+ * where <host> is a 9 character string:
+ *    "H<first_8_chars_of_sha1_of_hostname>"
+ *    "Localhost" when no hostname.
+ *
+ * where <process> is a possibly wrapped PID:
+ *    "P<6-digit-pid>"
+ *    "W<wrapped-6-digit-pid>" when PID too big.
+ *    
+ */
+static void tr2_sid_append_my_sid_component(void)
+{
+	const struct git_hash_algo *algo = &hash_algos[GIT_HASH_SHA1];
+	struct tr2_tbuf tb_now;
+	git_hash_ctx ctx;
+	uintmax_t pid = getpid();
+	unsigned char hash[GIT_MAX_RAWSZ + 1];
+	char hex[GIT_MAX_HEXSZ + 1];
+	char hostname[HOST_NAME_MAX + 1];
+
+	tr2_tbuf_utc_datetime(&tb_now);
+	strbuf_addstr(&tr2sid_buf, tb_now.buf);
+
+	strbuf_addch(&tr2sid_buf, '-');
+	if (xgethostname(hostname, sizeof(hostname)))
+		strbuf_add(&tr2sid_buf, "Localhost", 9);
+	else {
+		algo->init_fn(&ctx);
+		algo->update_fn(&ctx, hostname, strlen(hostname));
+		algo->final_fn(hash, &ctx);
+		hash_to_hex_algop_r(hex, hash, algo);
+		strbuf_addch(&tr2sid_buf, 'H');
+		strbuf_add(&tr2sid_buf, hex, 8);
+	}
+
+	strbuf_addch(&tr2sid_buf, '-');
+	if (pid > 999999)
+		strbuf_addf(&tr2sid_buf, "W%06d", (int)(pid % 1000000));
+	else
+		strbuf_addf(&tr2sid_buf, "P%06d", (int)pid);
+}
+
 /*
  * Compute a "unique" session id (SID) for the current process.  This allows
  * all events from this process to have a single label (much like a PID).
@@ -20,7 +70,6 @@ static int tr2sid_nr_git_parents;
  */
 static void tr2_sid_compute(void)
 {
-	uint64_t us_now;
 	const char *parent_sid;
 
 	if (tr2sid_buf.len)
@@ -38,9 +87,7 @@ static void tr2_sid_compute(void)
 		tr2sid_nr_git_parents++;
 	}
 
-	us_now = getnanotime() / 1000;
-	strbuf_addf(&tr2sid_buf, "%" PRIuMAX "-%" PRIdMAX, (uintmax_t)us_now,
-		    (intmax_t)getpid());
+	tr2_sid_append_my_sid_component();
 
 	setenv(TR2_ENVVAR_PARENT_SID, tr2sid_buf.buf, 1);
 }
diff --git a/trace2/tr2_tbuf.c b/trace2/tr2_tbuf.c
index eb1b240d8a..c8a19ac341 100644
--- a/trace2/tr2_tbuf.c
+++ b/trace2/tr2_tbuf.c
@@ -30,3 +30,19 @@ void tr2_tbuf_utc_datetime_extended(struct tr2_tbuf *tb)
 		  tm.tm_mon + 1, tm.tm_mday, tm.tm_hour, tm.tm_min, tm.tm_sec,
 		  (long)tv.tv_usec);
 }
+
+void tr2_tbuf_utc_datetime(struct tr2_tbuf *tb)
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
+		  "%4d%02d%02dT%02d%02d%02d.%06ldZ", tm.tm_year + 1900,
+		  tm.tm_mon + 1, tm.tm_mday, tm.tm_hour, tm.tm_min, tm.tm_sec,
+		  (long)tv.tv_usec);
+}
diff --git a/trace2/tr2_tbuf.h b/trace2/tr2_tbuf.h
index 2a1d173ff2..fa853d8f42 100644
--- a/trace2/tr2_tbuf.h
+++ b/trace2/tr2_tbuf.h
@@ -19,5 +19,6 @@ void tr2_tbuf_local_time(struct tr2_tbuf *tb);
  * Fill buffer with formatted UTC datatime string.
  */
 void tr2_tbuf_utc_datetime_extended(struct tr2_tbuf *tb);
+void tr2_tbuf_utc_datetime(struct tr2_tbuf *tb);
 
 #endif /* TR2_TBUF_H */
-- 
gitgitgadget

