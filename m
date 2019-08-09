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
	by dcvr.yhbt.net (Postfix) with ESMTP id 55CCD1F731
	for <e@80x24.org>; Fri,  9 Aug 2019 15:01:02 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2436534AbfHIPBB (ORCPT <rfc822;e@80x24.org>);
        Fri, 9 Aug 2019 11:01:01 -0400
Received: from mail-wm1-f51.google.com ([209.85.128.51]:39085 "EHLO
        mail-wm1-f51.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S2407255AbfHIPBA (ORCPT <rfc822;git@vger.kernel.org>);
        Fri, 9 Aug 2019 11:01:00 -0400
Received: by mail-wm1-f51.google.com with SMTP id u25so5888611wmc.4
        for <git@vger.kernel.org>; Fri, 09 Aug 2019 08:00:58 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=date:message-id:in-reply-to:references:from:subject:fcc
         :content-transfer-encoding:mime-version:to:cc;
        bh=J6NILpO33/UmLgaRCTFlWuCuXaFkp1sEBo7HujJ+nU4=;
        b=IPjQYrvxO/L1T7qtLebDT9DgSlys2LJHrIaSVgmTrsiJH3AJJYQCPkxRLXjddKRFvB
         fw50lR7mVJH41lsKnO//fSvnLOdfVng1ASV3aE7vqWbhvh9gU/udwV0Hq99OLaKrhnEG
         7wWXR//U7XnSJW31c7nDmsF1NG8ImiOiMEpt2eJ7XQBDBw6cU1sl03yWAkg/cfQ0dgv/
         rD+ax6bCrf7Z/f04u4vUp+eIPI7pYQ+U/eo4fLyLq829REDFXqo72An+pcf9fmmdec37
         RaCuM6Sl0FAdkxkNBE4qsAArCPN1rpb30uH0KIYuqir1uJ9ZQ1RQC7+ezk+sE1yN4FnG
         4j8Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:message-id:in-reply-to:references:from
         :subject:fcc:content-transfer-encoding:mime-version:to:cc;
        bh=J6NILpO33/UmLgaRCTFlWuCuXaFkp1sEBo7HujJ+nU4=;
        b=RGXPZTLFhwpWlftxUMeiNH6uqKJWnVtS48hR3U9yiq0SN7JKFDWgVMWOFb4PeW6wni
         hVlq6fhL9zWTcoBXw/cPJOhGd4Ku578XMYDEQFC3/ocsA+VcOm7NCci52hu8zdcdtVjv
         HLs0EqhaTI2tNRq1ya5mGN741YGDzAN5w81moR/qZs18HT46kmD5zBc2Zo6qdBBgbnTh
         eS0ZRWfbz9zTqgfBJ5iux1HuzGZMXgA+uFasDKutXGwty4akM/pj1tpXnzwTW6aJibRA
         vy6cr1+Jj1NiBQIKOHrqkb2ScDJEEQ+QiFmL8hVz22RI3h6SCGeA/5AH2xbg100szd/M
         wVbg==
X-Gm-Message-State: APjAAAW5yj/ABsuHRSv2to6Nnqk29FS/jAqmM2UZ5dVqwC7g1OgTongI
        kJTfUQG69kZJbVPnAm3eKXLwI3wI
X-Google-Smtp-Source: APXvYqyv1mDlvsvhPVC7L+EtpYJgnDAOSwcS07IjCoQ46qlz24waIlJqXRA0WSl5/Zfq62blPNfl4w==
X-Received: by 2002:a7b:c745:: with SMTP id w5mr11235493wmk.21.1565362857691;
        Fri, 09 Aug 2019 08:00:57 -0700 (PDT)
Received: from [127.0.0.1] ([13.74.141.28])
        by smtp.gmail.com with ESMTPSA id t63sm5645965wmt.6.2019.08.09.08.00.57
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Fri, 09 Aug 2019 08:00:57 -0700 (PDT)
Date:   Fri, 09 Aug 2019 08:00:57 -0700 (PDT)
X-Google-Original-Date: Fri, 09 Aug 2019 15:00:51 GMT
Message-Id: <9ab73939855f78563b1554282920aa11ff958f4e.1565362851.git.gitgitgadget@gmail.com>
In-Reply-To: <pull.298.v3.git.gitgitgadget@gmail.com>
References: <pull.298.v2.git.gitgitgadget@gmail.com>
        <pull.298.v3.git.gitgitgadget@gmail.com>
From:   "Jeff Hostetler via GitGitGadget" <gitgitgadget@gmail.com>
Subject: [PATCH v3 7/7] trace2: cleanup whitespace in perf format
Fcc:    Sent
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
MIME-Version: 1.0
To:     git@vger.kernel.org
Cc:     Junio C Hamano <gitster@pobox.com>,
        Jeff Hostetler <jeffhost@microsoft.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

From: Jeff Hostetler <jeffhost@microsoft.com>

Make use of new sq_append_quote_argv_pretty() to normalize
how we handle leading whitespace in perf format messages.

Signed-off-by: Jeff Hostetler <jeffhost@microsoft.com>
---
 t/t0211-trace2-perf.sh |  4 ++--
 trace2/tr2_tgt_perf.c  | 31 ++++++++++++++++++++-----------
 2 files changed, 22 insertions(+), 13 deletions(-)

diff --git a/t/t0211-trace2-perf.sh b/t/t0211-trace2-perf.sh
index 2c3ad6e8c1..6ee8ee3b67 100755
--- a/t/t0211-trace2-perf.sh
+++ b/t/t0211-trace2-perf.sh
@@ -130,11 +130,11 @@ test_expect_success 'perf stream, child processes' '
 		d0|main|version|||||$V
 		d0|main|start||_T_ABS_|||_EXE_ trace2 004child test-tool trace2 004child test-tool trace2 001return 0
 		d0|main|cmd_name|||||trace2 (trace2)
-		d0|main|child_start||_T_ABS_|||[ch0] class:? argv: test-tool trace2 004child test-tool trace2 001return 0
+		d0|main|child_start||_T_ABS_|||[ch0] class:? argv:[test-tool trace2 004child test-tool trace2 001return 0]
 		d1|main|version|||||$V
 		d1|main|start||_T_ABS_|||_EXE_ trace2 004child test-tool trace2 001return 0
 		d1|main|cmd_name|||||trace2 (trace2/trace2)
-		d1|main|child_start||_T_ABS_|||[ch0] class:? argv: test-tool trace2 001return 0
+		d1|main|child_start||_T_ABS_|||[ch0] class:? argv:[test-tool trace2 001return 0]
 		d2|main|version|||||$V
 		d2|main|start||_T_ABS_|||_EXE_ trace2 001return 0
 		d2|main|cmd_name|||||trace2 (trace2/trace2/trace2)
diff --git a/trace2/tr2_tgt_perf.c b/trace2/tr2_tgt_perf.c
index 8e52395de2..fd979db4ad 100644
--- a/trace2/tr2_tgt_perf.c
+++ b/trace2/tr2_tgt_perf.c
@@ -184,7 +184,7 @@ static void fn_start_fl(const char *file, int line,
 	const char *event_name = "start";
 	struct strbuf buf_payload = STRBUF_INIT;
 
-	sq_quote_argv_pretty(&buf_payload, argv);
+	sq_append_quote_argv_pretty(&buf_payload, argv);
 
 	perf_io_write_fl(file, line, event_name, NULL, &us_elapsed_absolute,
 			 NULL, NULL, &buf_payload);
@@ -299,8 +299,9 @@ static void fn_alias_fl(const char *file, int line, const char *alias,
 	const char *event_name = "alias";
 	struct strbuf buf_payload = STRBUF_INIT;
 
-	strbuf_addf(&buf_payload, "alias:%s argv:", alias);
-	sq_quote_argv_pretty(&buf_payload, argv);
+	strbuf_addf(&buf_payload, "alias:%s argv:[", alias);
+	sq_append_quote_argv_pretty(&buf_payload, argv);
+	strbuf_addch(&buf_payload, ']');
 
 	perf_io_write_fl(file, line, event_name, NULL, NULL, NULL, NULL,
 			 &buf_payload);
@@ -329,10 +330,14 @@ static void fn_child_start_fl(const char *file, int line,
 		sq_quote_buf_pretty(&buf_payload, cmd->dir);
 	}
 
-	strbuf_addstr(&buf_payload, " argv:");
-	if (cmd->git_cmd)
-		strbuf_addstr(&buf_payload, " git");
-	sq_quote_argv_pretty(&buf_payload, cmd->argv);
+	strbuf_addstr(&buf_payload, " argv:[");
+	if (cmd->git_cmd) {
+		strbuf_addstr(&buf_payload, "git");
+		if (cmd->argv[0])
+			strbuf_addch(&buf_payload, ' ');
+	}
+	sq_append_quote_argv_pretty(&buf_payload, cmd->argv);
+	strbuf_addch(&buf_payload, ']');
 
 	perf_io_write_fl(file, line, event_name, NULL, &us_elapsed_absolute,
 			 NULL, NULL, &buf_payload);
@@ -383,10 +388,14 @@ static void fn_exec_fl(const char *file, int line, uint64_t us_elapsed_absolute,
 	struct strbuf buf_payload = STRBUF_INIT;
 
 	strbuf_addf(&buf_payload, "id:%d ", exec_id);
-	strbuf_addstr(&buf_payload, "argv:");
-	if (exe)
-		strbuf_addf(&buf_payload, " %s", exe);
-	sq_quote_argv_pretty(&buf_payload, argv);
+	strbuf_addstr(&buf_payload, "argv:[");
+	if (exe) {
+		strbuf_addstr(&buf_payload, exe);
+		if (argv[0])
+			strbuf_addch(&buf_payload, ' ');
+	}
+	sq_append_quote_argv_pretty(&buf_payload, argv);
+	strbuf_addch(&buf_payload, ']');
 
 	perf_io_write_fl(file, line, event_name, NULL, &us_elapsed_absolute,
 			 NULL, NULL, &buf_payload);
-- 
gitgitgadget
