Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.2 (2018-09-13) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-4.2 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,RCVD_IN_DNSWL_HI
	shortcircuit=no autolearn=ham autolearn_force=no version=3.4.2
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id C5A531F453
	for <e@80x24.org>; Mon, 29 Apr 2019 20:14:27 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729398AbfD2UO0 (ORCPT <rfc822;e@80x24.org>);
        Mon, 29 Apr 2019 16:14:26 -0400
Received: from mail-ed1-f48.google.com ([209.85.208.48]:46706 "EHLO
        mail-ed1-f48.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1729363AbfD2UOY (ORCPT <rfc822;git@vger.kernel.org>);
        Mon, 29 Apr 2019 16:14:24 -0400
Received: by mail-ed1-f48.google.com with SMTP id d1so10257906edd.13
        for <git@vger.kernel.org>; Mon, 29 Apr 2019 13:14:22 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=date:message-id:in-reply-to:references:from:subject:fcc
         :content-transfer-encoding:mime-version:to:cc;
        bh=MoCGeeTDIpiPg6479hr8tszZ7UyZVIfv7RJYyJjZi4c=;
        b=LNjbEISHUlnFiH5cDVdoVREqShJkyc4ebJ/bcu0cy5PNpxy8ySn/hrGbHGC/eCRvKm
         85r7QgLG0SbuuwMK0xIm3bPN9hoYvxSfI0t2MzBqlY2Cwllph8A0+eFGPebfypJ3pz1E
         FHBvncLChmFxjlI0wYGKPKomKShYDMvLpnM8woDgELGd1WXjaOPrp3oA56XmuUdOoALv
         nu6ezR0c/dwvGOXurG9ZAZjKwtS1RrQezLHcmlGwEMbl3HR4u8wUK80l/1M7fmv+H+IB
         qtmNdDeHZPXhpnaIcdmOLlfpsulROGD/Edn/BGDSCEX6hCIgN1YphVEZTtCwaCwkmfxJ
         +/gg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:message-id:in-reply-to:references:from
         :subject:fcc:content-transfer-encoding:mime-version:to:cc;
        bh=MoCGeeTDIpiPg6479hr8tszZ7UyZVIfv7RJYyJjZi4c=;
        b=II4SWllwkOSTrt7EyxIKOoWb3XD0BUiClZ2t7FuPUAD2gTJhk9XWzP5CeaXvDQ4GqN
         1GRrdDzDEo1MlfG3sHzjn0P1Gm0730dn2OpamenAeHZvy2j2AJ3R8NTEp8HTtgZNlM9o
         W3aYx72z5WI+Rdj2eLBeSvWmWWy3Hc+99N4DOrCW+B9c3ZvTz5vEMBkQ71BTfgxGPCGK
         8dDTkksYSzfDAXI4tktTFc2/RmV4ViQwHIJ48IoTfm4lrj10ZsmzW+ZzNSsRMZSef5BK
         knlTRF7FvfwOAjSFPw9W1ESB0TMx+K4tZMGyOd91ETfoi6cxc4CNJQloI61EQUrBllNB
         jSjQ==
X-Gm-Message-State: APjAAAUSO4QVW7sjriFp33hPzW+kGxoEw4tG8wQJvIiS+rmqs6pQd/s7
        DoEZlHskFOFK1uBxu/esdT5LJlmL
X-Google-Smtp-Source: APXvYqwGES9nAvBk3kaO/agBLyQ53dfJOn0Su6WFFQPFIqe386LOSApLp+WpaospZTblus9cc13o2w==
X-Received: by 2002:a17:906:48c7:: with SMTP id d7mr31170825ejt.225.1556568861338;
        Mon, 29 Apr 2019 13:14:21 -0700 (PDT)
Received: from [127.0.0.1] ([13.74.141.28])
        by smtp.gmail.com with ESMTPSA id p1sm6027708ejf.40.2019.04.29.13.14.20
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Mon, 29 Apr 2019 13:14:20 -0700 (PDT)
Date:   Mon, 29 Apr 2019 13:14:20 -0700 (PDT)
X-Google-Original-Date: Mon, 29 Apr 2019 20:14:09 GMT
Message-Id: <9fdcb50140571f888712366f9187a23342d56ac7.1556568852.git.gitgitgadget@gmail.com>
In-Reply-To: <pull.169.v5.git.gitgitgadget@gmail.com>
References: <pull.169.v4.git.gitgitgadget@gmail.com>
        <pull.169.v5.git.gitgitgadget@gmail.com>
From:   "Jeff Hostetler via GitGitGadget" <gitgitgadget@gmail.com>
Subject: [PATCH v5 09/11] trace2: make SIDs more unique
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
 trace2/tr2_sid.c                       | 53 ++++++++++++++++++++++++--
 trace2/tr2_tbuf.c                      | 15 ++++++++
 trace2/tr2_tbuf.h                      |  1 +
 4 files changed, 73 insertions(+), 12 deletions(-)

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
index 984524a43c..5047095478 100644
--- a/trace2/tr2_sid.c
+++ b/trace2/tr2_sid.c
@@ -1,4 +1,5 @@
 #include "cache.h"
+#include "trace2/tr2_tbuf.h"
 #include "trace2/tr2_sid.h"
 
 #define TR2_ENVVAR_PARENT_SID "GIT_TR2_PARENT_SID"
@@ -6,6 +7,53 @@
 static struct strbuf tr2sid_buf = STRBUF_INIT;
 static int tr2sid_nr_git_parents;
 
+/*
+ * Compute the final component of the SID representing the current process.
+ * This should uniquely identify the process and be a valid filename (to
+ * allow writing trace2 data to per-process files).  It should also be fixed
+ * length for possible use as a database key.
+ *
+ * "<yyyymmdd>T<hhmmss>.<fraction>Z-<host>-<process>"
+ *
+ * where <host> is a 9 character string:
+ *    "H<first_8_chars_of_sha1_of_hostname>"
+ *    "Localhost" when no hostname.
+ *
+ * where <process> is a 9 character string containing the least signifcant
+ * 32 bits in the process-id.
+ *    "P<pid>"
+ * (This is an abribrary choice.  On most systems pid_t is a 32 bit value,
+ * so limit doesn't matter.  On larger systems, a truncated value is fine
+ * for our purposes here.)
+ */
+static void tr2_sid_append_my_sid_component(void)
+{
+	const struct git_hash_algo *algo = &hash_algos[GIT_HASH_SHA1];
+	struct tr2_tbuf tb_now;
+	git_hash_ctx ctx;
+	pid_t pid = getpid();
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
+	strbuf_addf(&tr2sid_buf, "-P%08"PRIx32, (uint32_t)pid);
+}
+
 /*
  * Compute a "unique" session id (SID) for the current process.  This allows
  * all events from this process to have a single label (much like a PID).
@@ -20,7 +68,6 @@ static int tr2sid_nr_git_parents;
  */
 static void tr2_sid_compute(void)
 {
-	uint64_t us_now;
 	const char *parent_sid;
 
 	if (tr2sid_buf.len)
@@ -38,9 +85,7 @@ static void tr2_sid_compute(void)
 		tr2sid_nr_git_parents++;
 	}
 
-	us_now = getnanotime() / 1000;
-	strbuf_addf(&tr2sid_buf, "%" PRIuMAX "-%" PRIdMAX, (uintmax_t)us_now,
-		    (intmax_t)getpid());
+	tr2_sid_append_my_sid_component();
 
 	setenv(TR2_ENVVAR_PARENT_SID, tr2sid_buf.buf, 1);
 }
diff --git a/trace2/tr2_tbuf.c b/trace2/tr2_tbuf.c
index eb1b240d8a..2498482d9a 100644
--- a/trace2/tr2_tbuf.c
+++ b/trace2/tr2_tbuf.c
@@ -30,3 +30,18 @@ void tr2_tbuf_utc_datetime_extended(struct tr2_tbuf *tb)
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
+	xsnprintf(tb->buf, sizeof(tb->buf), "%4d%02d%02dT%02d%02d%02d.%06ldZ",
+		  tm.tm_year + 1900, tm.tm_mon + 1, tm.tm_mday, tm.tm_hour,
+		  tm.tm_min, tm.tm_sec, (long)tv.tv_usec);
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

