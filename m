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
	by dcvr.yhbt.net (Postfix) with ESMTP id 3F0621F731
	for <e@80x24.org>; Thu,  8 Aug 2019 14:19:08 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2403843AbfHHOTH (ORCPT <rfc822;e@80x24.org>);
        Thu, 8 Aug 2019 10:19:07 -0400
Received: from mail-wr1-f66.google.com ([209.85.221.66]:32895 "EHLO
        mail-wr1-f66.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S2403831AbfHHOTF (ORCPT <rfc822;git@vger.kernel.org>);
        Thu, 8 Aug 2019 10:19:05 -0400
Received: by mail-wr1-f66.google.com with SMTP id n9so95235318wru.0
        for <git@vger.kernel.org>; Thu, 08 Aug 2019 07:19:04 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=date:message-id:in-reply-to:references:from:subject:fcc
         :content-transfer-encoding:mime-version:to:cc;
        bh=IVgpJQrq1SvWAoMKotTroh8WIIygwQ+5IhrXiCkd4F4=;
        b=BF1bhn+PVUEY2zYmHFri+EqHWWuyxUuVxYeTKE/VjId9WO5UKORBRJD83oXtlgHs4w
         87XOJ/Q9s3RHA9e7ktQwANbOcULKCXaJ2t49VWCkcWYohb3mBmNAq4dMwn0clBTWSSWz
         2oyks1pEVrugNSjIs85RnraqTSeGUJymRQjl4ojGUTgmu73p2KH94tLpq1d3F4v4+Efi
         tzQL6sQwQVpNN8N913UavwLwkKz8csHKR93d9YMxQe6USeu0Y9CSMglFmuwMXbVO6Dzf
         I4iR/BQGg8R0jeP2MVuJ69nqwd6qr4PzXD2TQYFqphJ4EjmpYy7qL1TVCiFd6PsbZpxZ
         /CQA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:message-id:in-reply-to:references:from
         :subject:fcc:content-transfer-encoding:mime-version:to:cc;
        bh=IVgpJQrq1SvWAoMKotTroh8WIIygwQ+5IhrXiCkd4F4=;
        b=Wqmfl4r3yot3ThdD7qKzUJ2m71EU4I+hw7dsSXCjsXUVpgUJRBlFNfoVktFtPRMnuH
         +Zc4d0WHGnM3jWzAnMMTz93BJGsqKNQQEXBxclzjeObTQh3fRB1HScuuaY8RwaWuPDq2
         FM5ev8/UD5kEJxLNGEvQIZS9M+LS6Qio0NGj4Wo8Mvo3bOLi7ZU3dcuL7KJVB/r+6u/0
         pwt1UyZV4fqE/nARAlMOkie+uI8+0y/YmBmYtLxd/8horMaeldKVpCG+hWoMWklQuD3r
         ioz6kjLb7wPzjG0W5ht7oYD3FtiBVBrX87pnSBk5igEzRk1t2M8pxUCUw1S0/kU3L5Ua
         TaSA==
X-Gm-Message-State: APjAAAVuAIuiyU167Xy7F1g1AeIWGAD1HkAa1daJoASY9UYdDbZkJeD9
        NWddsBVMiQ0sdGp6jZ1CEyst5Ulb
X-Google-Smtp-Source: APXvYqwWLa9iinBWPk74bWpQDTI4+bEp28h11ZUVwUiQxBbJiA+Iyp440pADIuS6NenhbSHxvrUmIA==
X-Received: by 2002:a5d:4206:: with SMTP id n6mr17404535wrq.110.1565273943922;
        Thu, 08 Aug 2019 07:19:03 -0700 (PDT)
Received: from [127.0.0.1] ([13.74.141.28])
        by smtp.gmail.com with ESMTPSA id y16sm202618587wrg.85.2019.08.08.07.19.03
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Thu, 08 Aug 2019 07:19:03 -0700 (PDT)
Date:   Thu, 08 Aug 2019 07:19:03 -0700 (PDT)
X-Google-Original-Date: Thu, 08 Aug 2019 14:18:57 GMT
Message-Id: <bb64bb251331ab60c2feac365bee9cbc7f6c16d1.1565273938.git.gitgitgadget@gmail.com>
In-Reply-To: <pull.298.v2.git.gitgitgadget@gmail.com>
References: <pull.298.git.gitgitgadget@gmail.com>
        <pull.298.v2.git.gitgitgadget@gmail.com>
From:   "Jeff Hostetler via GitGitGadget" <gitgitgadget@gmail.com>
Subject: [PATCH v2 6/7] trace2: cleanup whitespace in normal format
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
how we handle leading whitespace in normal format messages.

Signed-off-by: Jeff Hostetler <jeffhost@microsoft.com>
---
 trace2/tr2_tgt_normal.c | 21 ++++++++++++---------
 1 file changed, 12 insertions(+), 9 deletions(-)

diff --git a/trace2/tr2_tgt_normal.c b/trace2/tr2_tgt_normal.c
index 213724d5cb..5de2f8214c 100644
--- a/trace2/tr2_tgt_normal.c
+++ b/trace2/tr2_tgt_normal.c
@@ -87,7 +87,7 @@ static void fn_start_fl(const char *file, int line,
 	struct strbuf buf_payload = STRBUF_INIT;
 
 	strbuf_addstr(&buf_payload, "start ");
-	sq_quote_argv_pretty(&buf_payload, argv);
+	sq_quote_argv_pretty_ltrim(&buf_payload, argv);
 	normal_io_write_fl(file, line, &buf_payload);
 	strbuf_release(&buf_payload);
 }
@@ -186,8 +186,8 @@ static void fn_alias_fl(const char *file, int line, const char *alias,
 {
 	struct strbuf buf_payload = STRBUF_INIT;
 
-	strbuf_addf(&buf_payload, "alias %s ->", alias);
-	sq_quote_argv_pretty(&buf_payload, argv);
+	strbuf_addf(&buf_payload, "alias %s -> ", alias);
+	sq_quote_argv_pretty_ltrim(&buf_payload, argv);
 	normal_io_write_fl(file, line, &buf_payload);
 	strbuf_release(&buf_payload);
 }
@@ -198,12 +198,12 @@ static void fn_child_start_fl(const char *file, int line,
 {
 	struct strbuf buf_payload = STRBUF_INIT;
 
-	strbuf_addf(&buf_payload, "child_start[%d] ", cmd->trace2_child_id);
+	strbuf_addf(&buf_payload, "child_start[%d]", cmd->trace2_child_id);
 
 	if (cmd->dir) {
 		strbuf_addstr(&buf_payload, " cd");
 		sq_quote_buf_pretty(&buf_payload, cmd->dir);
-		strbuf_addstr(&buf_payload, "; ");
+		strbuf_addstr(&buf_payload, ";");
 	}
 
 	/*
@@ -211,9 +211,10 @@ static void fn_child_start_fl(const char *file, int line,
 	 * See trace_add_env() in run-command.c as used by original trace.c
 	 */
 
+	strbuf_addch(&buf_payload, ' ');
 	if (cmd->git_cmd)
-		strbuf_addstr(&buf_payload, "git");
-	sq_quote_argv_pretty(&buf_payload, cmd->argv);
+		strbuf_addstr(&buf_payload, "git ");
+	sq_quote_argv_pretty_ltrim(&buf_payload, cmd->argv);
 
 	normal_io_write_fl(file, line, &buf_payload);
 	strbuf_release(&buf_payload);
@@ -238,9 +239,11 @@ static void fn_exec_fl(const char *file, int line, uint64_t us_elapsed_absolute,
 	struct strbuf buf_payload = STRBUF_INIT;
 
 	strbuf_addf(&buf_payload, "exec[%d] ", exec_id);
-	if (exe)
+	if (exe) {
 		strbuf_addstr(&buf_payload, exe);
-	sq_quote_argv_pretty(&buf_payload, argv);
+		strbuf_addch(&buf_payload, ' ');
+	}
+	sq_quote_argv_pretty_ltrim(&buf_payload, argv);
 	normal_io_write_fl(file, line, &buf_payload);
 	strbuf_release(&buf_payload);
 }
-- 
gitgitgadget

