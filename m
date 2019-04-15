Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.2 (2018-09-13) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-4.1 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,RCVD_IN_DNSWL_HI
	shortcircuit=no autolearn=ham autolearn_force=no version=3.4.2
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id B464020248
	for <e@80x24.org>; Mon, 15 Apr 2019 20:40:00 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727942AbfDOUj7 (ORCPT <rfc822;e@80x24.org>);
        Mon, 15 Apr 2019 16:39:59 -0400
Received: from mail-ed1-f68.google.com ([209.85.208.68]:45252 "EHLO
        mail-ed1-f68.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727875AbfDOUjv (ORCPT <rfc822;git@vger.kernel.org>);
        Mon, 15 Apr 2019 16:39:51 -0400
Received: by mail-ed1-f68.google.com with SMTP id o26so15868222edv.12
        for <git@vger.kernel.org>; Mon, 15 Apr 2019 13:39:50 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=date:message-id:in-reply-to:references:from:subject:fcc
         :content-transfer-encoding:mime-version:to:cc;
        bh=Pqjpehq/KCxv/xITMTu3TGOqPYZ/ERIKSTRL7/VxKek=;
        b=Nt31K6r2dsqXgkn3/b8qgVwlgJ0YcfENdnxAHaDjVl7TNFHBZ94IivbB77nKGU3tpX
         toic8WIPx7pfZEh5MYgVe5BtAFdskvYEtySsVn4eB/Ks8qNyJrkmlWQsggU+OyxI0Lfo
         QemNzv/6jJW4xF07DUwnR+qZ9+c9pt6qE6AkfWfGS3CcdjYTlT2U7kk9U+/FLmGeQsn6
         3ccAld98x+4cWwWhhqOkRYNGbyOwayvwhzrLYqz+4ioAE4bI/4+LWDDnDU+VmxiHbPuZ
         UEPdwuA2TNRea8wwTKF0ChJr9ANKctx2U6xdFfmaO70Y4UXsUOT5tVMY8KqWEzvOl3qs
         c88w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:message-id:in-reply-to:references:from
         :subject:fcc:content-transfer-encoding:mime-version:to:cc;
        bh=Pqjpehq/KCxv/xITMTu3TGOqPYZ/ERIKSTRL7/VxKek=;
        b=Tk0r4OFVrwQtWBLx6bgqJ6IjjCG/pzsBq69aamOc+8iJk161+6CYGPVOqJn1FsmIHi
         A2zneXMZfXTw+UzWy3QndCEQ5Sb2V1PTDbGOePXzx61RgbS5sAr/LBga991474jwh1Mz
         6SFUnu0zZIzOMDV05IQcyZtAd1/+B9VSpJtUja7KuFsYsIdUqeRBcz7IlagOnIvTAx98
         aIHIyA++fMGAE+0U07fQXXahGzfU0sr+5wT7BXZ0K8ghqim+Os2z5uP/P1G9tr/ugRK0
         kBjMQp9tJXsO+Bvyaw3XM9stGpig2ZpGvZT0zs9AOJCz84hyTXiqdccCJP72Hj8Fp7Ps
         2JBA==
X-Gm-Message-State: APjAAAWE92BASMmasJHIV6yV30SpCSEkQoHRBSqGJhTsXZ/5sPb17LJL
        +znwnYmdYTcdI/pKrr6k/hS91Llu
X-Google-Smtp-Source: APXvYqyQnwvFGb1C/8+oUJAtiPyiK3v46sKiNoTyFLL5cb2x8Ewq1z+dhkYk9Hoc1nM7+GLC9sChaA==
X-Received: by 2002:a50:cb06:: with SMTP id g6mr30545726edi.89.1555360789447;
        Mon, 15 Apr 2019 13:39:49 -0700 (PDT)
Received: from [127.0.0.1] ([13.74.141.28])
        by smtp.gmail.com with ESMTPSA id 30sm1070108edr.2.2019.04.15.13.39.48
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Mon, 15 Apr 2019 13:39:48 -0700 (PDT)
Date:   Mon, 15 Apr 2019 13:39:48 -0700 (PDT)
X-Google-Original-Date: Mon, 15 Apr 2019 20:39:38 GMT
Message-Id: <196a9d2c852c110f951ccd19fc05741399ec59c1.1555360780.git.gitgitgadget@gmail.com>
In-Reply-To: <pull.169.v4.git.gitgitgadget@gmail.com>
References: <pull.169.v3.git.gitgitgadget@gmail.com>
        <pull.169.v4.git.gitgitgadget@gmail.com>
From:   "Jeff Hostetler via GitGitGadget" <gitgitgadget@gmail.com>
Subject: [PATCH v4 08/10] trace2: clarify UTC datetime formatting
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

Update tr2_tbuf_utc_datetime to generate extended UTC format.
Update tr2_tgt_event target to use extended format in 'time' columns.

Signed-off-by: Jeff Hostetler <jeffhost@microsoft.com>
---
 Documentation/technical/api-trace2.txt | 12 ++++++------
 trace2/tr2_tbuf.c                      |  4 ++--
 trace2/tr2_tbuf.h                      |  4 ++--
 trace2/tr2_tgt_event.c                 |  2 +-
 4 files changed, 11 insertions(+), 11 deletions(-)

diff --git a/Documentation/technical/api-trace2.txt b/Documentation/technical/api-trace2.txt
index baaa1153bb..cdc00bcc5d 100644
--- a/Documentation/technical/api-trace2.txt
+++ b/Documentation/technical/api-trace2.txt
@@ -78,11 +78,11 @@ git version 2.20.1.155.g426c96fcdb
 +
 ------------
 $ cat ~/log.event
-{"event":"version","sid":"1547659722619736-11614","thread":"main","time":"2019-01-16 17:28:42.620713","file":"common-main.c","line":38,"evt":"1","exe":"2.20.1.155.g426c96fcdb"}
-{"event":"start","sid":"1547659722619736-11614","thread":"main","time":"2019-01-16 17:28:42.621027","file":"common-main.c","line":39,"t_abs":0.001173,"argv":["git","version"]}
-{"event":"cmd_name","sid":"1547659722619736-11614","thread":"main","time":"2019-01-16 17:28:42.621122","file":"git.c","line":432,"name":"version","hierarchy":"version"}
-{"event":"exit","sid":"1547659722619736-11614","thread":"main","time":"2019-01-16 17:28:42.621236","file":"git.c","line":662,"t_abs":0.001227,"code":0}
-{"event":"atexit","sid":"1547659722619736-11614","thread":"main","time":"2019-01-16 17:28:42.621268","file":"trace2/tr2_tgt_event.c","line":163,"t_abs":0.001265,"code":0}
+{"event":"version","sid":"1547659722619736-11614","thread":"main","time":"2019-01-16T17:28:42.620713Z","file":"common-main.c","line":38,"evt":"1","exe":"2.20.1.155.g426c96fcdb"}
+{"event":"start","sid":"1547659722619736-11614","thread":"main","time":"2019-01-16T17:28:42.621027Z","file":"common-main.c","line":39,"t_abs":0.001173,"argv":["git","version"]}
+{"event":"cmd_name","sid":"1547659722619736-11614","thread":"main","time":"2019-01-16T17:28:42.621122Z","file":"git.c","line":432,"name":"version","hierarchy":"version"}
+{"event":"exit","sid":"1547659722619736-11614","thread":"main","time":"2019-01-16T17:28:42.621236Z","file":"git.c","line":662,"t_abs":0.001227,"code":0}
+{"event":"atexit","sid":"1547659722619736-11614","thread":"main","time":"2019-01-16T17:28:42.621268Z","file":"trace2/tr2_tgt_event.c","line":163,"t_abs":0.001265,"code":0}
 ------------
 
 == Enabling a Target
@@ -542,7 +542,7 @@ The following key/value pairs are common to all events:
 	"event":"version",
 	"sid":"1547659722619736-11614",
 	"thread":"main",
-	"time":"2019-01-16 17:28:42.620713",
+	"time":"2019-01-16T17:28:42.620713Z",
 	"file":"common-main.c",
 	"line":38,
 	...
diff --git a/trace2/tr2_tbuf.c b/trace2/tr2_tbuf.c
index 0844910423..eb1b240d8a 100644
--- a/trace2/tr2_tbuf.c
+++ b/trace2/tr2_tbuf.c
@@ -15,7 +15,7 @@ void tr2_tbuf_local_time(struct tr2_tbuf *tb)
 		  tm.tm_min, tm.tm_sec, (long)tv.tv_usec);
 }
 
-void tr2_tbuf_utc_time(struct tr2_tbuf *tb)
+void tr2_tbuf_utc_datetime_extended(struct tr2_tbuf *tb)
 {
 	struct timeval tv;
 	struct tm tm;
@@ -26,7 +26,7 @@ void tr2_tbuf_utc_time(struct tr2_tbuf *tb)
 	gmtime_r(&secs, &tm);
 
 	xsnprintf(tb->buf, sizeof(tb->buf),
-		  "%4d-%02d-%02d %02d:%02d:%02d.%06ld", tm.tm_year + 1900,
+		  "%4d-%02d-%02dT%02d:%02d:%02d.%06ldZ", tm.tm_year + 1900,
 		  tm.tm_mon + 1, tm.tm_mday, tm.tm_hour, tm.tm_min, tm.tm_sec,
 		  (long)tv.tv_usec);
 }
diff --git a/trace2/tr2_tbuf.h b/trace2/tr2_tbuf.h
index 9cdefa3957..2a1d173ff2 100644
--- a/trace2/tr2_tbuf.h
+++ b/trace2/tr2_tbuf.h
@@ -16,8 +16,8 @@ struct tr2_tbuf {
 void tr2_tbuf_local_time(struct tr2_tbuf *tb);
 
 /*
- * Fill buffer with formatted UTC time string.
+ * Fill buffer with formatted UTC datatime string.
  */
-void tr2_tbuf_utc_time(struct tr2_tbuf *tb);
+void tr2_tbuf_utc_datetime_extended(struct tr2_tbuf *tb);
 
 #endif /* TR2_TBUF_H */
diff --git a/trace2/tr2_tgt_event.c b/trace2/tr2_tgt_event.c
index 48d9193b2c..2c97cf54be 100644
--- a/trace2/tr2_tgt_event.c
+++ b/trace2/tr2_tgt_event.c
@@ -94,7 +94,7 @@ static void event_fmt_prepare(const char *event_name, const char *file,
 	 */
 	if (!tr2env_event_be_brief || !strcmp(event_name, "version") ||
 	    !strcmp(event_name, "atexit")) {
-		tr2_tbuf_utc_time(&tb_now);
+		tr2_tbuf_utc_datetime_extended(&tb_now);
 		jw_object_string(jw, "time", tb_now.buf);
 	}
 
-- 
gitgitgadget

