Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.2 (2018-09-13) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-2.7 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,RCVD_IN_DNSWL_HI,
	SPF_HELO_NONE,SPF_NONE,UNWANTED_LANGUAGE_BODY shortcircuit=no
	autolearn=ham autolearn_force=no version=3.4.2
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id E296E1F731
	for <e@80x24.org>; Wed, 31 Jul 2019 20:04:35 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729866AbfGaUEe (ORCPT <rfc822;e@80x24.org>);
        Wed, 31 Jul 2019 16:04:34 -0400
Received: from mail-wm1-f67.google.com ([209.85.128.67]:50487 "EHLO
        mail-wm1-f67.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726594AbfGaUEc (ORCPT <rfc822;git@vger.kernel.org>);
        Wed, 31 Jul 2019 16:04:32 -0400
Received: by mail-wm1-f67.google.com with SMTP id v15so62123806wml.0
        for <git@vger.kernel.org>; Wed, 31 Jul 2019 13:04:31 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=date:message-id:in-reply-to:references:from:subject:fcc
         :content-transfer-encoding:mime-version:to:cc;
        bh=fU2YTV3tS1WRDa7rqGLLVfd9jousdMjYO1z/6TtoaTQ=;
        b=hGRWeDc5YlnP75MJznxNUcQUf699vl95l25snOKSXcmsOtwXeQ4gugoS+mewoR46r5
         9jsZ1F2rrFgBFn3xCOol+ivd5N/zAcjNf4A56JYy5bLgcxrVK1U3hWzl5M1lH25VIZaL
         +g0DsYNhlKnmkggAtHQ/L+KXua8PD6k39RddKz/0ERSbr2wQGfzxfUXG/Uy0wpH/k0ui
         qhcjlS2c+ehrBe5oCqSxyLXbbZQiLl145I4kQ7nVTwL700KVpfJsopL4LCmTjHEg0tnc
         UB8F9gm8ULkYyIqeo6Tv/wChI9/jJSLBOJ1qEJicJMig6U7ZUtJH4L2tA+di/ExcPRBs
         0EDw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:message-id:in-reply-to:references:from
         :subject:fcc:content-transfer-encoding:mime-version:to:cc;
        bh=fU2YTV3tS1WRDa7rqGLLVfd9jousdMjYO1z/6TtoaTQ=;
        b=fwzaQdhEuqsfFet6uWjUfdBzkFluSNbCBOUlnSPpy6+WkiEHHvvkXRWbgRBrClQhCb
         QPwk69Q4w64ZNQPsndNtnieDo3MT9Fyx69gktTKq3S8tv92rorOVsyQSMU9R4sSiXdOf
         2VzziD87hKbiHZgnrLeRioOiiolZeJxMohDy9RFm2+xOHPLQJSwFWH92MkMxvTpqdpo9
         VUyxGevjpW/qsZb0mKYLWFuX5DUdy95Hf6mciiifiSpCfAgMYE4iF52nOKd6o34T2HL2
         Xfrv/ShyAf7SrAwMVBirTnFqjgy039VuqR9YEmdAUUr2YIDDdseBJqAsNk9bPO35G25L
         fjzw==
X-Gm-Message-State: APjAAAUA4mbDPJx66qu0ocEbJDq5sunAp9R4AZsnKYI0SUcG3Dqu0Q7W
        eLTnvd098duSbKCrx9i0f6Ii8vtf
X-Google-Smtp-Source: APXvYqxpvFa4IsxQcdam9bE8EhA9fFqRth6kstdZrWLomjPV6W4pprDpL2KBLZ3O++wqVJAagCxDCw==
X-Received: by 2002:a1c:4e14:: with SMTP id g20mr36057041wmh.3.1564603470609;
        Wed, 31 Jul 2019 13:04:30 -0700 (PDT)
Received: from [127.0.0.1] ([13.74.141.28])
        by smtp.gmail.com with ESMTPSA id o20sm175125481wrh.8.2019.07.31.13.04.30
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Wed, 31 Jul 2019 13:04:30 -0700 (PDT)
Date:   Wed, 31 Jul 2019 13:04:30 -0700 (PDT)
X-Google-Original-Date: Wed, 31 Jul 2019 20:04:27 GMT
Message-Id: <d2f7cf390853e72a6116eb54084ae4a38b6d8aba.1564603467.git.gitgitgadget@gmail.com>
In-Reply-To: <pull.298.git.gitgitgadget@gmail.com>
References: <pull.298.git.gitgitgadget@gmail.com>
From:   "Jeff Hostetler via GitGitGadget" <gitgitgadget@gmail.com>
Subject: [PATCH 3/3] trace2: trim whitespace in region messages in perf target
 format
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

Trim trailing whitespace in "region_enter" and "region_leave"
messages in perf target format.

Signed-off-by: Jeff Hostetler <jeffhost@microsoft.com>
---
 trace2/tr2_tgt_perf.c | 2 ++
 1 file changed, 2 insertions(+)

diff --git a/trace2/tr2_tgt_perf.c b/trace2/tr2_tgt_perf.c
index ed4e708f28..3c7ffbeb8a 100644
--- a/trace2/tr2_tgt_perf.c
+++ b/trace2/tr2_tgt_perf.c
@@ -455,6 +455,7 @@ static void fn_region_enter_printf_va_fl(const char *file, int line,
 	if (label)
 		strbuf_addf(&buf_payload, "label:%s ", label);
 	maybe_append_string_va(&buf_payload, fmt, ap);
+	strbuf_rtrim(&buf_payload);
 
 	perf_io_write_fl(file, line, event_name, repo, &us_elapsed_absolute,
 			 NULL, category, &buf_payload);
@@ -472,6 +473,7 @@ static void fn_region_leave_printf_va_fl(
 	if (label)
 		strbuf_addf(&buf_payload, "label:%s ", label);
 	maybe_append_string_va(&buf_payload, fmt, ap);
+	strbuf_rtrim(&buf_payload);
 
 	perf_io_write_fl(file, line, event_name, repo, &us_elapsed_absolute,
 			 &us_elapsed_region, category, &buf_payload);
-- 
gitgitgadget
