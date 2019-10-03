Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.2 (2018-09-13) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-3.9 required=3.0 tests=AWL,BAYES_00,
	DKIM_ADSP_CUSTOM_MED,DKIM_INVALID,DKIM_SIGNED,
	FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,RCVD_IN_DNSWL_HI,SPF_HELO_NONE,SPF_NONE
	shortcircuit=no autolearn=ham autolearn_force=no version=3.4.2
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 9976C1F4BD
	for <e@80x24.org>; Thu,  3 Oct 2019 17:53:38 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1730102AbfJCRxi (ORCPT <rfc822;e@80x24.org>);
        Thu, 3 Oct 2019 13:53:38 -0400
Received: from mail-wr1-f65.google.com ([209.85.221.65]:41227 "EHLO
        mail-wr1-f65.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1729950AbfJCRxh (ORCPT <rfc822;git@vger.kernel.org>);
        Thu, 3 Oct 2019 13:53:37 -0400
Received: by mail-wr1-f65.google.com with SMTP id q9so3690822wrm.8
        for <git@vger.kernel.org>; Thu, 03 Oct 2019 10:53:36 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=date:message-id:in-reply-to:references:from:subject:fcc
         :content-transfer-encoding:mime-version:to:cc;
        bh=ZwHh1TXxNf4aJSygXUzG4Bkm6lKqtN1MsdRGkinduGg=;
        b=mS2XxV9QzgQpRcxrlnJtnHMh/vSgRQkXSWopaJMn+dl1xKWNhhyZLYXj0Q74HqU5my
         yAXxCUIggCcvxbSyg/q5dM9SSvrUvQvnOFi9rSdehptmq5j5X5c+kdm5aVtMWtuCGnYh
         WLQEihIF+UOTXwtlKHDtnUNuId9ZceCH1Iltl74/HQ2hN3avwZM4L8VL/D2ZEUoweI6l
         PSmdivNIei7wowQgAFxKASAWkl+q3pSd90bxzKmYGF9LnwbQJASTCDBBxMLWDxsmFDTh
         Als3eumjSCRgI9LrkZkKlMurmrP3mE2ACKSS8K5A1FM3XDnNwrIqym89b0mk883yPDM7
         oWpg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:message-id:in-reply-to:references:from
         :subject:fcc:content-transfer-encoding:mime-version:to:cc;
        bh=ZwHh1TXxNf4aJSygXUzG4Bkm6lKqtN1MsdRGkinduGg=;
        b=NXY7NaWUP5z93bZMrUjqCzsLy8n0OYkIJAnCUorhGJDdmThlVqZE7dKMkJIjVR1NqC
         geZVCWz34B8jY7dY85VTxAtNA89hdnZwzYxkan73+SsXgN0XAjio6qPhzc4Q9megnuGv
         C/HB2ElNCfWvgy3OHzStt1DGXiLCpom0s21e67r/YrkSV4Jb9W9lNsjZAYfvAozAiJR1
         H0J0Z4Z2IZifD00h/G3J1HwrglExV7Y+r7OrxNn23JqdlGUnCvuvfAdCbjLOn8PI+I1v
         jFGNeS1jG0dQMxsbqX7OEC9isy60FeKdF+cyMxGbjYHibwkwO+ZVVprmC4OE1vmzAKHE
         mzAQ==
X-Gm-Message-State: APjAAAVbSk/5ojcgROb0C/bYUaF8ctIX8xatrDNuEQJbILjUGh9NwjA3
        GFbxTS5vcinuAYF3vmOP4VoNz4wL
X-Google-Smtp-Source: APXvYqzXc3FTnQKii67D/LMnunlNCVdzL0RLUD0vvaZWiDrTTab5/JroDKwHOFnjuqoDlUXRHwBanw==
X-Received: by 2002:a5d:4491:: with SMTP id j17mr7778890wrq.257.1570125215752;
        Thu, 03 Oct 2019 10:53:35 -0700 (PDT)
Received: from [127.0.0.1] ([13.74.141.28])
        by smtp.gmail.com with ESMTPSA id c9sm4023351wrt.7.2019.10.03.10.53.35
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Thu, 03 Oct 2019 10:53:35 -0700 (PDT)
Date:   Thu, 03 Oct 2019 10:53:35 -0700 (PDT)
X-Google-Original-Date: Thu, 03 Oct 2019 17:53:28 GMT
Message-Id: <7566090769eb74b2c9c99ab1455fb84c9215be16.1570125210.git.gitgitgadget@gmail.com>
In-Reply-To: <pull.337.v3.git.gitgitgadget@gmail.com>
References: <pull.337.v2.git.gitgitgadget@gmail.com>
        <pull.337.v3.git.gitgitgadget@gmail.com>
From:   "William Baker via GitGitGadget" <gitgitgadget@gmail.com>
Subject: [PATCH v3 5/6] midx: honor the MIDX_PROGRESS flag in midx_repack
Fcc:    Sent
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
MIME-Version: 1.0
To:     git@vger.kernel.org
Cc:     williamtbakeremail@gmail.com, stolee@gmail.com,
        jeffhost@microsoft.com, Junio C Hamano <gitster@pobox.com>,
        William Baker <William.Baker@microsoft.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

From: William Baker <William.Baker@microsoft.com>

Update midx_repack to only display progress when
the MIDX_PROGRESS flag is set.

Signed-off-by: William Baker <William.Baker@microsoft.com>
---
 midx.c | 6 ++++++
 1 file changed, 6 insertions(+)

diff --git a/midx.c b/midx.c
index ced5898bbf..1c5ddeb007 100644
--- a/midx.c
+++ b/midx.c
@@ -1374,6 +1374,12 @@ int midx_repack(struct repository *r, const char *object_dir, size_t batch_size,
 	strbuf_addstr(&base_name, object_dir);
 	strbuf_addstr(&base_name, "/pack/pack");
 	argv_array_push(&cmd.args, base_name.buf);
+
+	if (flags & MIDX_PROGRESS)
+		argv_array_push(&cmd.args, "--progress");
+	else
+		argv_array_push(&cmd.args, "-q");
+
 	strbuf_release(&base_name);
 
 	cmd.git_cmd = 1;
-- 
gitgitgadget

