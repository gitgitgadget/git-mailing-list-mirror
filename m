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
	by dcvr.yhbt.net (Postfix) with ESMTP id 96E631F731
	for <e@80x24.org>; Thu,  8 Aug 2019 14:19:11 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2403832AbfHHOTE (ORCPT <rfc822;e@80x24.org>);
        Thu, 8 Aug 2019 10:19:04 -0400
Received: from mail-wr1-f67.google.com ([209.85.221.67]:36744 "EHLO
        mail-wr1-f67.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1732438AbfHHOTD (ORCPT <rfc822;git@vger.kernel.org>);
        Thu, 8 Aug 2019 10:19:03 -0400
Received: by mail-wr1-f67.google.com with SMTP id r3so1377374wrt.3
        for <git@vger.kernel.org>; Thu, 08 Aug 2019 07:19:01 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=date:message-id:in-reply-to:references:from:subject:fcc
         :content-transfer-encoding:mime-version:to:cc;
        bh=qactH6NGLKS36jenwYSX3VNJA3yZ7TcKZEALDn+R0jQ=;
        b=Wt6mX97G8c137tPQm5ZzGrfoLns0p7TsgUMUwB/CeKRji/wz1btyAdZyjI+R5fWEi2
         tGNoLJHpqcrrGUQv167B1jXuL/5xbTv2xFlL4nf5Wj6huGQeuDXWxF/4qzHXo9VeZMHe
         cLbvaMWbzjOcz1+agnj2nmdhTgKyehFpwTYDVWWOgHojaxi8k/j1c9pmyrrO5rKVt6Q1
         8Gy4e/BKnapruGxq6cRemdDVFVd8lUcCB/3F5bs72WYNsrrGvfGVd28GdSwhDSCuiyVT
         YQVjMTiUEqzA+27D2qgjVxp1A0h0J+WUxx/ikS4oXZts5Ey2THleC8+rb74wnE994Mdn
         buYw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:message-id:in-reply-to:references:from
         :subject:fcc:content-transfer-encoding:mime-version:to:cc;
        bh=qactH6NGLKS36jenwYSX3VNJA3yZ7TcKZEALDn+R0jQ=;
        b=HV1xahshX/gsmTlfceSjE2qjRr/7XEiyhm0VPDVV2WMFGZoDdcqowrasfAE7739Z4t
         IP92mDySfz64hp0N853l8niNB8R0mzq1e944WP/nO+iEqcc+/xctGfH6VsbgBhcQWzPe
         FUC6s/+e9U8uspDU/dSmFPLEHWfrQJCN8LhxS1RLpaS4fz9EEmFRmywPJy2phU/hCv9v
         ssJGfIkJ/z15q3ObUKl/EhHTqaLhNElVvL/a4auIDD7cqNN5WyO7HsHnG9K9JCkr4p3O
         BOxFqZArlMJJyhg4tTuJjW//qsRQPrhnC2entQsNYlqCH062fwj1dSBLdYwLzeA5LG1S
         ha9A==
X-Gm-Message-State: APjAAAULDdbL1WLmJgoADrheIq3usi4gF5koF24uOLdF0dnRvhv0P0Ue
        snQA7hWcmUDbaJ7fDwzjUqRqOfkx
X-Google-Smtp-Source: APXvYqwFIXJtfl2N7DqqHmFY3Y6DWMvKmal9oM7gBR1yMQUhp+AzcH6L+HWZacvbey4LMgfYvARgEQ==
X-Received: by 2002:a5d:664a:: with SMTP id f10mr2825941wrw.90.1565273941221;
        Thu, 08 Aug 2019 07:19:01 -0700 (PDT)
Received: from [127.0.0.1] ([13.74.141.28])
        by smtp.gmail.com with ESMTPSA id s25sm1746784wmc.21.2019.08.08.07.19.00
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Thu, 08 Aug 2019 07:19:00 -0700 (PDT)
Date:   Thu, 08 Aug 2019 07:19:00 -0700 (PDT)
X-Google-Original-Date: Thu, 08 Aug 2019 14:18:53 GMT
Message-Id: <db3509971281bbaadf2003c3b3fa3058ca5f9ab0.1565273938.git.gitgitgadget@gmail.com>
In-Reply-To: <pull.298.v2.git.gitgitgadget@gmail.com>
References: <pull.298.git.gitgitgadget@gmail.com>
        <pull.298.v2.git.gitgitgadget@gmail.com>
From:   "Jeff Hostetler via GitGitGadget" <gitgitgadget@gmail.com>
Subject: [PATCH v2 2/7] trace2: trim whitespace in region messages in perf
 target format
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

Avoid unecessary trailing whitespace in "region_enter" and "region_leave"
messages in perf target format.

Signed-off-by: Jeff Hostetler <jeffhost@microsoft.com>
---
 trace2/tr2_tgt_perf.c | 14 ++++++++++----
 1 file changed, 10 insertions(+), 4 deletions(-)

diff --git a/trace2/tr2_tgt_perf.c b/trace2/tr2_tgt_perf.c
index 4a9d99218b..fb845cb627 100644
--- a/trace2/tr2_tgt_perf.c
+++ b/trace2/tr2_tgt_perf.c
@@ -452,8 +452,11 @@ static void fn_region_enter_printf_va_fl(const char *file, int line,
 	struct strbuf buf_payload = STRBUF_INIT;
 
 	if (label)
-		strbuf_addf(&buf_payload, "label:%s ", label);
-	maybe_append_string_va(&buf_payload, fmt, ap);
+		strbuf_addf(&buf_payload, "label:%s", label);
+	if (fmt && *fmt) {
+		strbuf_addch(&buf_payload, ' ');
+		maybe_append_string_va(&buf_payload, fmt, ap);
+	}
 
 	perf_io_write_fl(file, line, event_name, repo, &us_elapsed_absolute,
 			 NULL, category, &buf_payload);
@@ -469,8 +472,11 @@ static void fn_region_leave_printf_va_fl(
 	struct strbuf buf_payload = STRBUF_INIT;
 
 	if (label)
-		strbuf_addf(&buf_payload, "label:%s ", label);
-	maybe_append_string_va(&buf_payload, fmt, ap);
+		strbuf_addf(&buf_payload, "label:%s", label);
+	if (fmt && *fmt) {
+		strbuf_addch(&buf_payload, ' ' );
+		maybe_append_string_va(&buf_payload, fmt, ap);
+	}
 
 	perf_io_write_fl(file, line, event_name, repo, &us_elapsed_absolute,
 			 &us_elapsed_region, category, &buf_payload);
-- 
gitgitgadget

