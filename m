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
	by dcvr.yhbt.net (Postfix) with ESMTP id 26B1A1F731
	for <e@80x24.org>; Thu,  8 Aug 2019 14:19:06 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2403835AbfHHOTF (ORCPT <rfc822;e@80x24.org>);
        Thu, 8 Aug 2019 10:19:05 -0400
Received: from mail-wr1-f67.google.com ([209.85.221.67]:39032 "EHLO
        mail-wr1-f67.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1733035AbfHHOTD (ORCPT <rfc822;git@vger.kernel.org>);
        Thu, 8 Aug 2019 10:19:03 -0400
Received: by mail-wr1-f67.google.com with SMTP id t16so4990219wra.6
        for <git@vger.kernel.org>; Thu, 08 Aug 2019 07:19:02 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=date:message-id:in-reply-to:references:from:subject:fcc
         :content-transfer-encoding:mime-version:to:cc;
        bh=AMRj4RdGeKffECVj5c+t5qwJAsKJ92hhns5QybcLZDU=;
        b=lF5mG+5xuWlFoX3rQWR7r1F/VKcYipToTtei/V17LBhjFHaOZeXJ/9fuKtJaXnMoUg
         u6Fwi453zPLbFWTt/hpCmuFvbhgGPv6HTocpIsTwQdKfP/impScQznrN7fVuZ0gPzZj5
         DyojeKGxppN44C7d7fu2QmSim1SgN7fc9pSgI1rLhX4gKSwCf4eZKokCwRomcoGr7lVC
         a0mnwdsY/8H7F3zbH5kEVV82YvU+jXqF64tKUBhns3Y90oXRtZZSPToqzV12uY0PuPPh
         IUVYV0PXXQANxCFk58jspFQsoUvg3qWowSvx6uHdUBqLSHWz3vDilZLrU1MxjRvVL+Hk
         nmXQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:message-id:in-reply-to:references:from
         :subject:fcc:content-transfer-encoding:mime-version:to:cc;
        bh=AMRj4RdGeKffECVj5c+t5qwJAsKJ92hhns5QybcLZDU=;
        b=ptyvVCqaMk7j/4URlvm7sYHKsu2Gelh6bZ9hxrsXP/ES3CzhVaxsi1IeACXUuv1a1M
         4Jp+Ic9s26N6hR6x2ESrDeAA2XvEUAGlbxBzgMjddF93YBL+RJgixdt3LHywsdh9N9Io
         luKho0WUB1U8KAaekywuv6sl4A7Pc+v6Fw8Im+Q8pshqBtKMSw2hH3VSaDcjEJzRA4Ro
         XLXkxZ/AyP3WrQLEt2/FVc3OleraiFD633Pseyl2gGQGT5WANBJKO53c2UKI3xZA9lGr
         mKRsUvLl7EdEOQ1sQriBXMaCzWpNSLP+OOVJwyWSXRsYHWzDL7f2287e5FLIkhdqetrP
         c7og==
X-Gm-Message-State: APjAAAUZqcNjGV0rG4or0wAyVSn4Y1vTa250CMSV0Dq8m+ZjEdM5s4xL
        MBDHUUCQpZ41j4bj545noEBdCOo3
X-Google-Smtp-Source: APXvYqz5B3w2EZonxL364BtOQVBKRcf9tty0Wwz88LMJBF4UOM5S/aVqSm0PuI+O4QpmWov5qQaw0Q==
X-Received: by 2002:a5d:4e06:: with SMTP id p6mr17940976wrt.336.1565273941970;
        Thu, 08 Aug 2019 07:19:01 -0700 (PDT)
Received: from [127.0.0.1] ([13.74.141.28])
        by smtp.gmail.com with ESMTPSA id a19sm9895585wra.2.2019.08.08.07.19.01
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Thu, 08 Aug 2019 07:19:01 -0700 (PDT)
Date:   Thu, 08 Aug 2019 07:19:01 -0700 (PDT)
X-Google-Original-Date: Thu, 08 Aug 2019 14:18:54 GMT
Message-Id: <09dff12a7dfe2219feab85b3fe611aa5c4196375.1565273938.git.gitgitgadget@gmail.com>
In-Reply-To: <pull.298.v2.git.gitgitgadget@gmail.com>
References: <pull.298.git.gitgitgadget@gmail.com>
        <pull.298.v2.git.gitgitgadget@gmail.com>
From:   "Jeff Hostetler via GitGitGadget" <gitgitgadget@gmail.com>
Subject: [PATCH v2 3/7] trace2: remove dead code in maybe_add_string_va()
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

Remove an unnecessary "if" block in maybe_add_string_va().

Commit "ad006fe419e trace2: NULL is not allowed for va_list"
changed "if (fmt && *fmt && ap)" to just "if (fmt && *fmt)"
because it isn't safe to treat 'ap' as a pointer.  This made
the "if" block following it unnecessary.

Signed-off-by: Jeff Hostetler <jeffhost@microsoft.com>
---
 trace2/tr2_tgt_event.c  | 5 -----
 trace2/tr2_tgt_normal.c | 5 -----
 trace2/tr2_tgt_perf.c   | 5 -----
 3 files changed, 15 deletions(-)

diff --git a/trace2/tr2_tgt_event.c b/trace2/tr2_tgt_event.c
index c2852d1bd2..9bcac20d1b 100644
--- a/trace2/tr2_tgt_event.c
+++ b/trace2/tr2_tgt_event.c
@@ -205,11 +205,6 @@ static void maybe_add_string_va(struct json_writer *jw, const char *field_name,
 		strbuf_release(&buf);
 		return;
 	}
-
-	if (fmt && *fmt) {
-		jw_object_string(jw, field_name, fmt);
-		return;
-	}
 }
 
 static void fn_error_va_fl(const char *file, int line, const char *fmt,
diff --git a/trace2/tr2_tgt_normal.c b/trace2/tr2_tgt_normal.c
index 00b116d797..47a1882557 100644
--- a/trace2/tr2_tgt_normal.c
+++ b/trace2/tr2_tgt_normal.c
@@ -135,11 +135,6 @@ static void maybe_append_string_va(struct strbuf *buf, const char *fmt,
 		va_end(copy_ap);
 		return;
 	}
-
-	if (fmt && *fmt) {
-		strbuf_addstr(buf, fmt);
-		return;
-	}
 }
 
 static void fn_error_va_fl(const char *file, int line, const char *fmt,
diff --git a/trace2/tr2_tgt_perf.c b/trace2/tr2_tgt_perf.c
index fb845cb627..8e52395de2 100644
--- a/trace2/tr2_tgt_perf.c
+++ b/trace2/tr2_tgt_perf.c
@@ -239,11 +239,6 @@ static void maybe_append_string_va(struct strbuf *buf, const char *fmt,
 		va_end(copy_ap);
 		return;
 	}
-
-	if (fmt && *fmt) {
-		strbuf_addstr(buf, fmt);
-		return;
-	}
 }
 
 static void fn_error_va_fl(const char *file, int line, const char *fmt,
-- 
gitgitgadget

