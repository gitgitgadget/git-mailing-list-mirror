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
	by dcvr.yhbt.net (Postfix) with ESMTP id 354271F731
	for <e@80x24.org>; Thu,  8 Aug 2019 14:19:10 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2403866AbfHHOTI (ORCPT <rfc822;e@80x24.org>);
        Thu, 8 Aug 2019 10:19:08 -0400
Received: from mail-wr1-f52.google.com ([209.85.221.52]:46305 "EHLO
        mail-wr1-f52.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1733035AbfHHOTG (ORCPT <rfc822;git@vger.kernel.org>);
        Thu, 8 Aug 2019 10:19:06 -0400
Received: by mail-wr1-f52.google.com with SMTP id z1so95121618wru.13
        for <git@vger.kernel.org>; Thu, 08 Aug 2019 07:19:05 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=date:message-id:in-reply-to:references:from:subject:fcc
         :content-transfer-encoding:mime-version:to:cc;
        bh=jEr/cyiBkX9RelGgbKLwfxcdHoBpt/cBoxbWPZaXjSU=;
        b=U2psGgldsU0xJ7I0c1RvJAyil12pBp6ZwYghIddD3UUY1lx7t1ZHdAKGafXkd7gKQv
         8TvA/nET9YKSN8jW5n2zPWOxvbkj0TE5n/OI/tr/yRW2ZBquK02rq8d/+fQbW3Psuvjp
         OEJNFogdHvt6pPjq4f+WT1BxaUpH6UdBphfstFlh8okTytCdzQaWi3SfVGnWXE/wLCPK
         WeZ19z+cea4UpPdMMZVtntO6/LY+0T9WCSMZ2LKraK5YxfTnHR3jvTiBmQmy53LijDSn
         YUGG7ohKwvUKcdm/DCC0Ssp7cGmvFIRexrYQnYoULhH/GvhT6JWOqe6ie96gJOQO0teh
         yEVA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:message-id:in-reply-to:references:from
         :subject:fcc:content-transfer-encoding:mime-version:to:cc;
        bh=jEr/cyiBkX9RelGgbKLwfxcdHoBpt/cBoxbWPZaXjSU=;
        b=LNfzkZO+6tZBJVuAvqEnI18sZHz/yQS3AEI999OrSShd/tU6OH5yeURdvU0ieoR4+y
         TFtVpuGZJ65FVtXx7ZkwCzUSvug7azSPoTHZOREaatZ6JCLQlkaGyQgU6G6DbrWpRyNM
         5akyesUqD8QzTqNoVhDlWlFWgHuip8tOD/obmr397isoDxcpp0jMesuL6pjGU4Fjq1qK
         Ck36PLkulyYd+xuk85rjw1bA/2ym0YXoDSp9V8v/jbuCqOAaRpzFQb56OjkOtb+uCbzF
         5AKHCSTTvgHeHh+nCneE1Rjj5epGZdQuKFuO4gy2rNINTDBIEy7HquaRBvgimEHK1wUO
         eOpg==
X-Gm-Message-State: APjAAAXtxfPYuwt07HRb7ZMT0Fkmw/Y9k2g3FXRwUVKwAs0wIRQtxT1n
        ii+n4QpDUv+XRvN12T/lD0VhhJU+
X-Google-Smtp-Source: APXvYqwpO7fOKsNjIqxYL0IwJETaJ9cRHgUrlntj01yRV4+fHg2++XRd5bFNr0tPaOX3qwbdQxkPSw==
X-Received: by 2002:adf:f204:: with SMTP id p4mr18127290wro.317.1565273944876;
        Thu, 08 Aug 2019 07:19:04 -0700 (PDT)
Received: from [127.0.0.1] ([13.74.141.28])
        by smtp.gmail.com with ESMTPSA id y12sm70233505wru.30.2019.08.08.07.19.04
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Thu, 08 Aug 2019 07:19:04 -0700 (PDT)
Date:   Thu, 08 Aug 2019 07:19:04 -0700 (PDT)
X-Google-Original-Date: Thu, 08 Aug 2019 14:18:58 GMT
Message-Id: <a6e5e7c70b1053fb6c232d01bf00db96585334aa.1565273938.git.gitgitgadget@gmail.com>
In-Reply-To: <pull.298.v2.git.gitgitgadget@gmail.com>
References: <pull.298.git.gitgitgadget@gmail.com>
        <pull.298.v2.git.gitgitgadget@gmail.com>
From:   "Jeff Hostetler via GitGitGadget" <gitgitgadget@gmail.com>
Subject: [PATCH v2 7/7] trace2: cleanup whitespace in perf format
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

Make use of new sq_quote_argv_pretty_ltrim() to normalize
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
index 8e52395de2..59c03a5ed4 100644
--- a/trace2/tr2_tgt_perf.c
+++ b/trace2/tr2_tgt_perf.c
@@ -184,7 +184,7 @@ static void fn_start_fl(const char *file, int line,
 	const char *event_name = "start";
 	struct strbuf buf_payload = STRBUF_INIT;
 
-	sq_quote_argv_pretty(&buf_payload, argv);
+	sq_quote_argv_pretty_ltrim(&buf_payload, argv);
 
 	perf_io_write_fl(file, line, event_name, NULL, &us_elapsed_absolute,
 			 NULL, NULL, &buf_payload);
@@ -299,8 +299,9 @@ static void fn_alias_fl(const char *file, int line, const char *alias,
 	const char *event_name = "alias";
 	struct strbuf buf_payload = STRBUF_INIT;
 
-	strbuf_addf(&buf_payload, "alias:%s argv:", alias);
-	sq_quote_argv_pretty(&buf_payload, argv);
+	strbuf_addf(&buf_payload, "alias:%s argv:[", alias);
+	sq_quote_argv_pretty_ltrim(&buf_payload, argv);
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
+	sq_quote_argv_pretty_ltrim(&buf_payload, cmd->argv);
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
+	sq_quote_argv_pretty_ltrim(&buf_payload, argv);
+	strbuf_addch(&buf_payload, ']');
 
 	perf_io_write_fl(file, line, event_name, NULL, &us_elapsed_absolute,
 			 NULL, NULL, &buf_payload);
-- 
gitgitgadget
