Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.2 (2018-09-13) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-4.1 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,RCVD_IN_DNSWL_HI
	shortcircuit=no autolearn=ham autolearn_force=no version=3.4.2
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 43D5720248
	for <e@80x24.org>; Fri, 29 Mar 2019 17:04:36 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729886AbfC2REe (ORCPT <rfc822;e@80x24.org>);
        Fri, 29 Mar 2019 13:04:34 -0400
Received: from mail-ed1-f65.google.com ([209.85.208.65]:44765 "EHLO
        mail-ed1-f65.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1729876AbfC2REc (ORCPT <rfc822;git@vger.kernel.org>);
        Fri, 29 Mar 2019 13:04:32 -0400
Received: by mail-ed1-f65.google.com with SMTP id x10so2603556edh.11
        for <git@vger.kernel.org>; Fri, 29 Mar 2019 10:04:31 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=date:message-id:in-reply-to:references:from:subject:fcc
         :content-transfer-encoding:mime-version:to:cc;
        bh=1L2OKpObQ0hoaob0riRW3poEAjyOCJcCPzQNYvPQy98=;
        b=cOFIghOmCAxlxHHDho0AEIgAU8TtnouDRwFMlT72XhljC+IUVsgCo8/9Ru2TyrXsG3
         p1R9fUF2keW8D3YIWyvUVMzP1G2BHQh/G09+JKfOheLmu6tHXolJ7+uQa0uTONTTgAKb
         rHLO7MG+NvPlSpP6KDjImcr2aYe77x3/4aOSHwKmknPx5V6rVczNmHMRPyjHMNwAbaKG
         zYkE6wfyLhdbc/fQ0nmvIYHMS1b3T+gtvUBZOA+Q7zrsTDKKI//If/+9ioc1bxB1l5Fm
         EKIZfEsSvK4092dap6dNhgN4ZgRZTg8LnzFxQFZPHKpAficDTmjHcj0D0MVMSQ6BdC2r
         czfw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:message-id:in-reply-to:references:from
         :subject:fcc:content-transfer-encoding:mime-version:to:cc;
        bh=1L2OKpObQ0hoaob0riRW3poEAjyOCJcCPzQNYvPQy98=;
        b=OJQK3SL8WegLHj1iBzL40nNrMeiQkatGWNmyK25ruJDmoOuNavoem9PLBfakrtvodq
         2TLaZc03L8lX063At30BE0AK9dLxCPn7/8r9K1R5YbG4f0yGGelSCH3UlkAS63SJBngw
         jAnMZjIX0YqFDL5m9BBJFcMumCfd10psTcau8RStKwCxW/Qf7VRb67yyOmANPybv3iBc
         9YVIwGF0FZ/TPMN2iDV1QdK6KXpkVQa4LXUu+CEhWIo47NqYjThbK6e1yjW7pVCAndgu
         kMPRDj8+SHvBg4OhUN6ksMRsDJHigIKmW/Umud+GSHNnqMwD7INxlx67lTn/HPGz6es9
         GfcQ==
X-Gm-Message-State: APjAAAW4L+6J+8SFsaa+uoHfiraeGdE/Z5cUCymwSN2r/QGltVYAmzYp
        nZBASAd3czjbLdgG0YTexcy4hNdH
X-Google-Smtp-Source: APXvYqyQX1YpAt0N1ToYucs5bR8dDm/eXCoxE9uAw8RwoF0rf74Ohysbprcz+Ncebt385sIpZenRdg==
X-Received: by 2002:aa7:dcca:: with SMTP id w10mr15836073edu.73.1553879070609;
        Fri, 29 Mar 2019 10:04:30 -0700 (PDT)
Received: from [127.0.0.1] ([13.74.141.28])
        by smtp.gmail.com with ESMTPSA id p16sm459583ejb.13.2019.03.29.10.04.29
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Fri, 29 Mar 2019 10:04:30 -0700 (PDT)
Date:   Fri, 29 Mar 2019 10:04:30 -0700 (PDT)
X-Google-Original-Date: Fri, 29 Mar 2019 17:04:22 GMT
Message-Id: <ae11cc4186e6299ee5d7bd5cc1d85f1a9db2bb35.1553879063.git.gitgitgadget@gmail.com>
In-Reply-To: <pull.169.v2.git.gitgitgadget@gmail.com>
References: <pull.169.git.gitgitgadget@gmail.com>
        <pull.169.v2.git.gitgitgadget@gmail.com>
From:   "Jeff Hostetler via GitGitGadget" <gitgitgadget@gmail.com>
Subject: [PATCH v2 6/7] trace2: clarify UTC datetime formatting
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
index 13ca595c69..db968e31f7 100644
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
@@ -573,7 +573,7 @@ The following key/value pairs are common to all events:
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

