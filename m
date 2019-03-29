Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.2 (2018-09-13) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-4.1 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,RCVD_IN_DNSWL_HI
	shortcircuit=no autolearn=ham autolearn_force=no version=3.4.2
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 19F2F20248
	for <e@80x24.org>; Fri, 29 Mar 2019 17:04:32 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729868AbfC2RE3 (ORCPT <rfc822;e@80x24.org>);
        Fri, 29 Mar 2019 13:04:29 -0400
Received: from mail-ed1-f66.google.com ([209.85.208.66]:35177 "EHLO
        mail-ed1-f66.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1729845AbfC2RE3 (ORCPT <rfc822;git@vger.kernel.org>);
        Fri, 29 Mar 2019 13:04:29 -0400
Received: by mail-ed1-f66.google.com with SMTP id s39so2668976edb.2
        for <git@vger.kernel.org>; Fri, 29 Mar 2019 10:04:27 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=date:message-id:in-reply-to:references:from:subject:fcc
         :content-transfer-encoding:mime-version:to:cc;
        bh=yhflm1h/FZKF58Ok6RL8hgAJqkUeqZLAyJDxkCErf3w=;
        b=LdbJ+mhcA5SR1DefVjPrRyjGpYNAiTR6+a/2hCxdxORPyxo/b9RP0He/Oko61Mh+OW
         26LaJBsQIvYwmu/XMEywnq9i1dEkiYzWCMmaxHWXmW4puhR7BHsrBCXB6+1CNsKcBOP4
         VOKrh57qqwFgaLE5Fr3YEeTg7IryeXYGcenJjf+1UXXw0EOe5P6whDBjjM62f6ZxSz+z
         hyLJPi+FrYNJn1s+2Fd6+zusgOG0dBR0sS/eNAbl31+4JC+52qoSANZLi8UJUnmoY2dW
         LqPYGosk61KGHtp5e0dhaVVOnQagY0nl6TC2ec34TulIwHW356t8lu1m+WTkx9s8Atmc
         a7/Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:message-id:in-reply-to:references:from
         :subject:fcc:content-transfer-encoding:mime-version:to:cc;
        bh=yhflm1h/FZKF58Ok6RL8hgAJqkUeqZLAyJDxkCErf3w=;
        b=uDPijaGAuGXyCsSJsxJ437NlCMf98ImjvaTdQP33wEIKvxP8oh+gti9czxph4qGVwV
         tkM4Cpw3NR4i/myQzFYmiYqZFZ9K6pMGWq/HTeUePCz6ZvZP4hYd21gg1MHWPkh9obSx
         6YUJbm0IebvzHDzQzBpC39QKkSwv1iHOje5KKuoaznHiGJh1TKBE+WXMjKYF8BtOBZ40
         jcG10JRt0zLDR47P4mogJjOYeCZMUTyMHi8ExwmNApgdckjSjPNWohwSr/QPyGi3TvhC
         8dd60IPo7m88OywMp5SY743fJT0kqzJ7XAqntjbxpQm2klk78PrImnrdACPSVRIsyUlZ
         MVjA==
X-Gm-Message-State: APjAAAVRi5nDq4jcw/Da6Rw6m5rO9TScHhv/GDfLzJJWXQwGXgswVNTV
        byd3mOh9qkB+fXcSoNA8iBoQXBne
X-Google-Smtp-Source: APXvYqwH4kHHqkib5ZVf32k/zG9dyYvcGHgEZsRjThbSVqoxiy4ww8e1xIRvvzfYWWPlD0pi27r+Ug==
X-Received: by 2002:a17:906:7703:: with SMTP id q3mr11838301ejm.172.1553879066868;
        Fri, 29 Mar 2019 10:04:26 -0700 (PDT)
Received: from [127.0.0.1] ([13.74.141.28])
        by smtp.gmail.com with ESMTPSA id q12sm787158eda.51.2019.03.29.10.04.26
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Fri, 29 Mar 2019 10:04:26 -0700 (PDT)
Date:   Fri, 29 Mar 2019 10:04:26 -0700 (PDT)
X-Google-Original-Date: Fri, 29 Mar 2019 17:04:18 GMT
Message-Id: <c15f783c26ea426688b488c2522dd9c9072cc1bf.1553879063.git.gitgitgadget@gmail.com>
In-Reply-To: <pull.169.v2.git.gitgitgadget@gmail.com>
References: <pull.169.git.gitgitgadget@gmail.com>
        <pull.169.v2.git.gitgitgadget@gmail.com>
From:   "Jeff Hostetler via GitGitGadget" <gitgitgadget@gmail.com>
Subject: [PATCH v2 2/7] trace2: add absolute elapsed time to start event
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

Add elapsed process time to "start" event to measure
the performance of early process startup.

Signed-off-by: Jeff Hostetler <jeffhost@microsoft.com>
---
 Documentation/technical/api-trace2.txt | 11 ++++++-----
 t/t0211-trace2-perf.sh                 | 12 ++++++------
 trace2.c                               |  8 +++++++-
 trace2/tr2_tgt.h                       |  1 +
 trace2/tr2_tgt_event.c                 |  5 ++++-
 trace2/tr2_tgt_normal.c                |  3 ++-
 trace2/tr2_tgt_perf.c                  |  7 ++++---
 7 files changed, 30 insertions(+), 17 deletions(-)

diff --git a/Documentation/technical/api-trace2.txt b/Documentation/technical/api-trace2.txt
index f37fccf1da..baaa1153bb 100644
--- a/Documentation/technical/api-trace2.txt
+++ b/Documentation/technical/api-trace2.txt
@@ -60,7 +60,7 @@ git version 2.20.1.155.g426c96fcdb
 ------------
 $ cat ~/log.perf
 12:28:42.620675 common-main.c:38                  | d0 | main                     | version      |     |           |           |            | 2.20.1.155.g426c96fcdb
-12:28:42.621001 common-main.c:39                  | d0 | main                     | start        |     |           |           |            | git version
+12:28:42.621001 common-main.c:39                  | d0 | main                     | start        |     |  0.001173 |           |            | git version
 12:28:42.621111 git.c:432                         | d0 | main                     | cmd_name     |     |           |           |            | version (version)
 12:28:42.621225 git.c:662                         | d0 | main                     | exit         |     |  0.001227 |           |            | code:0
 12:28:42.621259 trace2/tr2_tgt_perf.c:211         | d0 | main                     | atexit       |     |  0.001265 |           |            | code:0
@@ -79,7 +79,7 @@ git version 2.20.1.155.g426c96fcdb
 ------------
 $ cat ~/log.event
 {"event":"version","sid":"1547659722619736-11614","thread":"main","time":"2019-01-16 17:28:42.620713","file":"common-main.c","line":38,"evt":"1","exe":"2.20.1.155.g426c96fcdb"}
-{"event":"start","sid":"1547659722619736-11614","thread":"main","time":"2019-01-16 17:28:42.621027","file":"common-main.c","line":39,"argv":["git","version"]}
+{"event":"start","sid":"1547659722619736-11614","thread":"main","time":"2019-01-16 17:28:42.621027","file":"common-main.c","line":39,"t_abs":0.001173,"argv":["git","version"]}
 {"event":"cmd_name","sid":"1547659722619736-11614","thread":"main","time":"2019-01-16 17:28:42.621122","file":"git.c","line":432,"name":"version","hierarchy":"version"}
 {"event":"exit","sid":"1547659722619736-11614","thread":"main","time":"2019-01-16 17:28:42.621236","file":"git.c","line":662,"t_abs":0.001227,"code":0}
 {"event":"atexit","sid":"1547659722619736-11614","thread":"main","time":"2019-01-16 17:28:42.621268","file":"trace2/tr2_tgt_event.c","line":163,"t_abs":0.001265,"code":0}
@@ -601,6 +601,7 @@ from all events and the `time` field is only present on the "start" and
 {
 	"event":"start",
 	...
+	"t_abs":0.001227, # elapsed time in seconds
 	"argv":["git","version"]
 }
 ------------
@@ -1118,7 +1119,7 @@ $ git status
 
 $ cat ~/log.perf
 d0 | main                     | version      |     |           |           |            | 2.20.1.160.g5676107ecd.dirty
-d0 | main                     | start        |     |           |           |            | git status
+d0 | main                     | start        |     |  0.001173 |           |            | git status
 d0 | main                     | def_repo     | r1  |           |           |            | worktree:/Users/jeffhost/work/gfw
 d0 | main                     | cmd_name     |     |           |           |            | status (status)
 ...
@@ -1163,7 +1164,7 @@ $ git status
 ...
 $ cat ~/log.perf
 d0 | main                     | version      |     |           |           |            | 2.20.1.162.gb4ccea44db.dirty
-d0 | main                     | start        |     |           |           |            | git status
+d0 | main                     | start        |     |  0.001173 |           |            | git status
 d0 | main                     | def_repo     | r1  |           |           |            | worktree:/Users/jeffhost/work/gfw
 d0 | main                     | cmd_name     |     |           |           |            | status (status)
 ...
@@ -1219,7 +1220,7 @@ $ git status
 ...
 $ cat ~/log.perf
 d0 | main                     | version      |     |           |           |            | 2.20.1.156.gf9916ae094.dirty
-d0 | main                     | start        |     |           |           |            | git status
+d0 | main                     | start        |     |  0.001173 |           |            | git status
 d0 | main                     | def_repo     | r1  |           |           |            | worktree:/Users/jeffhost/work/gfw
 d0 | main                     | cmd_name     |     |           |           |            | status (status)
 d0 | main                     | region_enter | r1  |  0.001791 |           | index      | label:do_read_index .git/index
diff --git a/t/t0211-trace2-perf.sh b/t/t0211-trace2-perf.sh
index 953e2f7847..c9694b29f7 100755
--- a/t/t0211-trace2-perf.sh
+++ b/t/t0211-trace2-perf.sh
@@ -50,7 +50,7 @@ test_expect_success 'perf stream, return code 0' '
 	perl "$TEST_DIRECTORY/t0211/scrub_perf.perl" <trace.perf >actual &&
 	cat >expect <<-EOF &&
 		d0|main|version|||||$V
-		d0|main|start|||||_EXE_ trace2 001return 0
+		d0|main|start||_T_ABS_|||_EXE_ trace2 001return 0
 		d0|main|cmd_name|||||trace2 (trace2)
 		d0|main|exit||_T_ABS_|||code:0
 		d0|main|atexit||_T_ABS_|||code:0
@@ -64,7 +64,7 @@ test_expect_success 'perf stream, return code 1' '
 	perl "$TEST_DIRECTORY/t0211/scrub_perf.perl" <trace.perf >actual &&
 	cat >expect <<-EOF &&
 		d0|main|version|||||$V
-		d0|main|start|||||_EXE_ trace2 001return 1
+		d0|main|start||_T_ABS_|||_EXE_ trace2 001return 1
 		d0|main|cmd_name|||||trace2 (trace2)
 		d0|main|exit||_T_ABS_|||code:1
 		d0|main|atexit||_T_ABS_|||code:1
@@ -82,7 +82,7 @@ test_expect_success 'perf stream, error event' '
 	perl "$TEST_DIRECTORY/t0211/scrub_perf.perl" <trace.perf >actual &&
 	cat >expect <<-EOF &&
 		d0|main|version|||||$V
-		d0|main|start|||||_EXE_ trace2 003error '\''hello world'\'' '\''this is a test'\''
+		d0|main|start||_T_ABS_|||_EXE_ trace2 003error '\''hello world'\'' '\''this is a test'\''
 		d0|main|cmd_name|||||trace2 (trace2)
 		d0|main|error|||||hello world
 		d0|main|error|||||this is a test
@@ -128,15 +128,15 @@ test_expect_success 'perf stream, child processes' '
 	perl "$TEST_DIRECTORY/t0211/scrub_perf.perl" <trace.perf >actual &&
 	cat >expect <<-EOF &&
 		d0|main|version|||||$V
-		d0|main|start|||||_EXE_ trace2 004child test-tool trace2 004child test-tool trace2 001return 0
+		d0|main|start||_T_ABS_|||_EXE_ trace2 004child test-tool trace2 004child test-tool trace2 001return 0
 		d0|main|cmd_name|||||trace2 (trace2)
 		d0|main|child_start||_T_ABS_|||[ch0] class:? argv: test-tool trace2 004child test-tool trace2 001return 0
 		d1|main|version|||||$V
-		d1|main|start|||||_EXE_ trace2 004child test-tool trace2 001return 0
+		d1|main|start||_T_ABS_|||_EXE_ trace2 004child test-tool trace2 001return 0
 		d1|main|cmd_name|||||trace2 (trace2/trace2)
 		d1|main|child_start||_T_ABS_|||[ch0] class:? argv: test-tool trace2 001return 0
 		d2|main|version|||||$V
-		d2|main|start|||||_EXE_ trace2 001return 0
+		d2|main|start||_T_ABS_|||_EXE_ trace2 001return 0
 		d2|main|cmd_name|||||trace2 (trace2/trace2/trace2)
 		d2|main|exit||_T_ABS_|||code:0
 		d2|main|atexit||_T_ABS_|||code:0
diff --git a/trace2.c b/trace2.c
index 6dd51e6aa5..1c180062dd 100644
--- a/trace2.c
+++ b/trace2.c
@@ -182,13 +182,19 @@ void trace2_cmd_start_fl(const char *file, int line, const char **argv)
 {
 	struct tr2_tgt *tgt_j;
 	int j;
+	uint64_t us_now;
+	uint64_t us_elapsed_absolute;
 
 	if (!trace2_enabled)
 		return;
 
+	us_now = getnanotime() / 1000;
+	us_elapsed_absolute = tr2tls_absolute_elapsed(us_now);
+
 	for_each_wanted_builtin (j, tgt_j)
 		if (tgt_j->pfn_start_fl)
-			tgt_j->pfn_start_fl(file, line, argv);
+			tgt_j->pfn_start_fl(file, line, us_elapsed_absolute,
+					    argv);
 }
 
 int trace2_cmd_exit_fl(const char *file, int line, int code)
diff --git a/trace2/tr2_tgt.h b/trace2/tr2_tgt.h
index 297bb8ffbe..7b90469212 100644
--- a/trace2/tr2_tgt.h
+++ b/trace2/tr2_tgt.h
@@ -15,6 +15,7 @@ typedef void(tr2_tgt_term_t)(void);
 typedef void(tr2_tgt_evt_version_fl_t)(const char *file, int line);
 
 typedef void(tr2_tgt_evt_start_fl_t)(const char *file, int line,
+				     uint64_t us_elapsed_absolute,
 				     const char **argv);
 typedef void(tr2_tgt_evt_exit_fl_t)(const char *file, int line,
 				    uint64_t us_elapsed_absolute, int code);
diff --git a/trace2/tr2_tgt_event.c b/trace2/tr2_tgt_event.c
index 107cb5317d..89a4d3ae9a 100644
--- a/trace2/tr2_tgt_event.c
+++ b/trace2/tr2_tgt_event.c
@@ -122,13 +122,16 @@ static void fn_version_fl(const char *file, int line)
 	jw_release(&jw);
 }
 
-static void fn_start_fl(const char *file, int line, const char **argv)
+static void fn_start_fl(const char *file, int line,
+			uint64_t us_elapsed_absolute, const char **argv)
 {
 	const char *event_name = "start";
 	struct json_writer jw = JSON_WRITER_INIT;
+	double t_abs = (double)us_elapsed_absolute / 1000000.0;
 
 	jw_object_begin(&jw, 0);
 	event_fmt_prepare(event_name, file, line, NULL, &jw);
+	jw_object_double(&jw, "t_abs", 6, t_abs);
 	jw_object_inline_begin_array(&jw, "argv");
 	jw_array_argv(&jw, argv);
 	jw_end(&jw);
diff --git a/trace2/tr2_tgt_normal.c b/trace2/tr2_tgt_normal.c
index 547183d5b6..57f3e18f5b 100644
--- a/trace2/tr2_tgt_normal.c
+++ b/trace2/tr2_tgt_normal.c
@@ -81,7 +81,8 @@ static void fn_version_fl(const char *file, int line)
 	strbuf_release(&buf_payload);
 }
 
-static void fn_start_fl(const char *file, int line, const char **argv)
+static void fn_start_fl(const char *file, int line,
+			uint64_t us_elapsed_absolute, const char **argv)
 {
 	struct strbuf buf_payload = STRBUF_INIT;
 
diff --git a/trace2/tr2_tgt_perf.c b/trace2/tr2_tgt_perf.c
index f0746fcf86..9c3b4d8a0f 100644
--- a/trace2/tr2_tgt_perf.c
+++ b/trace2/tr2_tgt_perf.c
@@ -159,15 +159,16 @@ static void fn_version_fl(const char *file, int line)
 	strbuf_release(&buf_payload);
 }
 
-static void fn_start_fl(const char *file, int line, const char **argv)
+static void fn_start_fl(const char *file, int line,
+			uint64_t us_elapsed_absolute, const char **argv)
 {
 	const char *event_name = "start";
 	struct strbuf buf_payload = STRBUF_INIT;
 
 	sq_quote_argv_pretty(&buf_payload, argv);
 
-	perf_io_write_fl(file, line, event_name, NULL, NULL, NULL, NULL,
-			 &buf_payload);
+	perf_io_write_fl(file, line, event_name, NULL, &us_elapsed_absolute,
+			 NULL, NULL, &buf_payload);
 	strbuf_release(&buf_payload);
 }
 
-- 
gitgitgadget

