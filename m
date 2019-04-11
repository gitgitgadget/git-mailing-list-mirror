Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.2 (2018-09-13) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-4.1 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,RCVD_IN_DNSWL_HI
	shortcircuit=no autolearn=ham autolearn_force=no version=3.4.2
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 77AFE20248
	for <e@80x24.org>; Thu, 11 Apr 2019 15:18:45 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726828AbfDKPSo (ORCPT <rfc822;e@80x24.org>);
        Thu, 11 Apr 2019 11:18:44 -0400
Received: from mail-ed1-f66.google.com ([209.85.208.66]:41565 "EHLO
        mail-ed1-f66.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726585AbfDKPSm (ORCPT <rfc822;git@vger.kernel.org>);
        Thu, 11 Apr 2019 11:18:42 -0400
Received: by mail-ed1-f66.google.com with SMTP id g6so1592789edc.8
        for <git@vger.kernel.org>; Thu, 11 Apr 2019 08:18:41 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=date:message-id:in-reply-to:references:from:subject:fcc
         :content-transfer-encoding:mime-version:to:cc;
        bh=yhflm1h/FZKF58Ok6RL8hgAJqkUeqZLAyJDxkCErf3w=;
        b=GOZtTebG/Q3FzVhqX1M0R1k8iW8SDZZJlMmNSuY9pRqWTigoirrZLBHvte0aHvyTpZ
         wninpsb0XAyGc7icwAd2ecqiXdSBrgBJBVC8gf8QIDLp5EJlylm+uv4eCKRWBnVe5vGr
         B2RwJi2j78TATKv5M5yO9JEAYJlV0ndyrx/DDQb/AAWXmMM+TjIibZSdpdDTYL/JP32t
         uAE22hERFHI5+ez5+FDJWvfyhk5kblomZ4GT8wsPTakTeT8emHw6l6kMN42eXuy+bEAg
         ZXaX1wztQiBFSXHLPbwnbiy4S2NhBHcZT2G92PsJWK4Q7jAvBSvupLialQkDu+9rQ3mb
         v53Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:message-id:in-reply-to:references:from
         :subject:fcc:content-transfer-encoding:mime-version:to:cc;
        bh=yhflm1h/FZKF58Ok6RL8hgAJqkUeqZLAyJDxkCErf3w=;
        b=iSQ6DghGeg3lqChjVUhz90uiun935wGfz5oljT+eRn0eud1qY3WQr8V9vJc+JdQ5sw
         yxMnyFt0b4n+fRXaQmY2BjyCeDTzu8rdavIQnOW/zuYVOJCGzGmU039SO/CoB1kBUHuK
         4rfwm3USN61ZWTtuV6V8ZjT/lgy6POcVk68RlGYbxOiUtjkBnKy183ESpb8rxQH1l08I
         ueZ/9MB1MpRsXd3/qX7I7MKW5Cg0pt22qY3pplf005/KrTwDA/ybp0E0q7rROmhdphxb
         QM5wp291g6QaOup3XeXZrXwDiXE/R2LaZVHQbeDf0lvPQk9S2nWktGRZ0T/BetlkTHfg
         WL2A==
X-Gm-Message-State: APjAAAUnbdQ1wXm8iONpHRrJpKsViLwm6JAFG5KwZMb2fn85P7omCTPV
        O9A7eLK0WtP9bWiKO81kiTl2Mxyl
X-Google-Smtp-Source: APXvYqwKpZpsybvfiQwOv7psV4w5RNZ1Zi6p+EuDBs2nRSp2z3Mf22SKvuUCzKrBnF90BnCAvS9GsQ==
X-Received: by 2002:a50:9188:: with SMTP id g8mr1190784eda.266.1554995920391;
        Thu, 11 Apr 2019 08:18:40 -0700 (PDT)
Received: from [127.0.0.1] ([13.74.141.28])
        by smtp.gmail.com with ESMTPSA id p20sm11062988edq.62.2019.04.11.08.18.39
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Thu, 11 Apr 2019 08:18:39 -0700 (PDT)
Date:   Thu, 11 Apr 2019 08:18:39 -0700 (PDT)
X-Google-Original-Date: Thu, 11 Apr 2019 15:18:29 GMT
Message-Id: <8b00025af54fe32fe47adb4daa75d1324441acbc.1554995916.git.gitgitgadget@gmail.com>
In-Reply-To: <pull.169.v3.git.gitgitgadget@gmail.com>
References: <pull.169.v2.git.gitgitgadget@gmail.com>
        <pull.169.v3.git.gitgitgadget@gmail.com>
From:   "Jeff Hostetler via GitGitGadget" <gitgitgadget@gmail.com>
Subject: [PATCH v3 03/10] trace2: add absolute elapsed time to start event
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

