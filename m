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
	by dcvr.yhbt.net (Postfix) with ESMTP id 5AB6D1F731
	for <e@80x24.org>; Fri,  9 Aug 2019 15:01:01 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2407242AbfHIPBA (ORCPT <rfc822;e@80x24.org>);
        Fri, 9 Aug 2019 11:01:00 -0400
Received: from mail-wm1-f65.google.com ([209.85.128.65]:38597 "EHLO
        mail-wm1-f65.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S2407234AbfHIPA7 (ORCPT <rfc822;git@vger.kernel.org>);
        Fri, 9 Aug 2019 11:00:59 -0400
Received: by mail-wm1-f65.google.com with SMTP id m125so1852041wmm.3
        for <git@vger.kernel.org>; Fri, 09 Aug 2019 08:00:57 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=date:message-id:in-reply-to:references:from:subject:fcc
         :content-transfer-encoding:mime-version:to:cc;
        bh=chDA17aNMicsr7d9kGny5j2QgX/uBNNYj8M9vxjiQNA=;
        b=Tr82Td1CKEBWfrMwhTveUtpLqcU2r9JjH9W7mdXvcyO16d5jwk7ACy8NxxnXjvYB/1
         7Lm2zHMCTC+5fsL/Zd7fAFcNDl45UeJnhzfTAkCfnDdq0OXGKxeLX/eVki1+uQaI5D48
         V1/SSs93PZK+LNcXHovF4KNBPZjnieeh1xiK+BE4HqlB3QFRHutRp4A19n+uLZf0yLiB
         Fr8wSNiLAg9X1uqtlgj+OF8xnHjXzN/eDGM0F9q1m1FVgZ0B8DJdlrJzdH06p1nVghk7
         c2+frDdDXVYG/E47cnTALTYiSc/95UuHhDpjyb5uJaF8bt6AGp4+cmb+mjvmCa7WRWEV
         huWA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:message-id:in-reply-to:references:from
         :subject:fcc:content-transfer-encoding:mime-version:to:cc;
        bh=chDA17aNMicsr7d9kGny5j2QgX/uBNNYj8M9vxjiQNA=;
        b=Ic8twu+sCVVBQT8FQAmQTBoUHxDszhpINKoO8Y1RdOV8dTVHnaRBXrNLWlsWDx47M0
         SdmeWkkJ/SNVKqsbTE9EJU5ilXufjrYpVmJYJAyWoOdBtYsR0LWs0QP71FNC+5pIXcjG
         Pd8Lj8ZoDN9yCRi2uYpHqu6wDMlK8Y0YubYLdFvddnt3Kt9CM40P/NubboZM7o0cmuvy
         hdz6u99cINscKcMhjIwV/a+lj+it3iSVY8F4B272FA6rpAy3MgYCiYSaddK2Y7eJlPvw
         nt2ldJrXCNtWnrPLFcSf6S4NSQhhm7JD+sdDq0OtmZlsTiP8JX6SoDE8qxCXzpfFRbs5
         UjkQ==
X-Gm-Message-State: APjAAAW+1eLFBeSdXwpOERMp9ZCcaOLn1t34ew+OAdRv5Hf3UPSGoEI7
        JgS71r3oMVs8cid8sKw7MwjygTGX
X-Google-Smtp-Source: APXvYqwLG/XjLyKYelbKWzgZ56kFXQwzhu9ByKJqqleKbimf8GJd5TlkJ/qLdHrStuYoOXHJxhWsEg==
X-Received: by 2002:a1c:b68a:: with SMTP id g132mr11855377wmf.66.1565362856983;
        Fri, 09 Aug 2019 08:00:56 -0700 (PDT)
Received: from [127.0.0.1] ([13.74.141.28])
        by smtp.gmail.com with ESMTPSA id 91sm197963446wrp.3.2019.08.09.08.00.56
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Fri, 09 Aug 2019 08:00:56 -0700 (PDT)
Date:   Fri, 09 Aug 2019 08:00:56 -0700 (PDT)
X-Google-Original-Date: Fri, 09 Aug 2019 15:00:50 GMT
Message-Id: <d02a0608d7ba7902da3b7622ee2c4619eba6896c.1565362851.git.gitgitgadget@gmail.com>
In-Reply-To: <pull.298.v3.git.gitgitgadget@gmail.com>
References: <pull.298.v2.git.gitgitgadget@gmail.com>
        <pull.298.v3.git.gitgitgadget@gmail.com>
From:   "Jeff Hostetler via GitGitGadget" <gitgitgadget@gmail.com>
Subject: [PATCH v3 6/7] trace2: cleanup whitespace in normal format
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
how we handle leading whitespace in normal format messages.

Signed-off-by: Jeff Hostetler <jeffhost@microsoft.com>
---
 trace2/tr2_tgt_normal.c | 23 +++++++++++++----------
 1 file changed, 13 insertions(+), 10 deletions(-)

diff --git a/trace2/tr2_tgt_normal.c b/trace2/tr2_tgt_normal.c
index 213724d5cb..438ed05a40 100644
--- a/trace2/tr2_tgt_normal.c
+++ b/trace2/tr2_tgt_normal.c
@@ -87,7 +87,7 @@ static void fn_start_fl(const char *file, int line,
 	struct strbuf buf_payload = STRBUF_INIT;
 
 	strbuf_addstr(&buf_payload, "start ");
-	sq_quote_argv_pretty(&buf_payload, argv);
+	sq_append_quote_argv_pretty(&buf_payload, argv);
 	normal_io_write_fl(file, line, &buf_payload);
 	strbuf_release(&buf_payload);
 }
@@ -186,8 +186,8 @@ static void fn_alias_fl(const char *file, int line, const char *alias,
 {
 	struct strbuf buf_payload = STRBUF_INIT;
 
-	strbuf_addf(&buf_payload, "alias %s ->", alias);
-	sq_quote_argv_pretty(&buf_payload, argv);
+	strbuf_addf(&buf_payload, "alias %s -> ", alias);
+	sq_append_quote_argv_pretty(&buf_payload, argv);
 	normal_io_write_fl(file, line, &buf_payload);
 	strbuf_release(&buf_payload);
 }
@@ -198,12 +198,12 @@ static void fn_child_start_fl(const char *file, int line,
 {
 	struct strbuf buf_payload = STRBUF_INIT;
 
-	strbuf_addf(&buf_payload, "child_start[%d] ", cmd->trace2_child_id);
+	strbuf_addf(&buf_payload, "child_start[%d]", cmd->trace2_child_id);
 
 	if (cmd->dir) {
-		strbuf_addstr(&buf_payload, " cd");
+		strbuf_addstr(&buf_payload, " cd ");
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
+	sq_append_quote_argv_pretty(&buf_payload, cmd->argv);
 
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
+	sq_append_quote_argv_pretty(&buf_payload, argv);
 	normal_io_write_fl(file, line, &buf_payload);
 	strbuf_release(&buf_payload);
 }
-- 
gitgitgadget

