Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.2 (2018-09-13) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-3.8 required=3.0 tests=AWL,BAYES_00,
	DKIM_ADSP_CUSTOM_MED,DKIM_INVALID,DKIM_SIGNED,
	FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,RCVD_IN_DNSWL_HI,SPF_HELO_NONE,SPF_NONE
	shortcircuit=no autolearn=ham autolearn_force=no version=3.4.2
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 91FAD1F4C0
	for <e@80x24.org>; Mon, 21 Oct 2019 18:40:11 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729994AbfJUSkK (ORCPT <rfc822;e@80x24.org>);
        Mon, 21 Oct 2019 14:40:10 -0400
Received: from mail-wr1-f66.google.com ([209.85.221.66]:34015 "EHLO
        mail-wr1-f66.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1729461AbfJUSkJ (ORCPT <rfc822;git@vger.kernel.org>);
        Mon, 21 Oct 2019 14:40:09 -0400
Received: by mail-wr1-f66.google.com with SMTP id t16so10024544wrr.1
        for <git@vger.kernel.org>; Mon, 21 Oct 2019 11:40:08 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=message-id:in-reply-to:references:from:date:subject:fcc
         :content-transfer-encoding:mime-version:to:cc;
        bh=WUpeJMgyy8fKbeOw6Sq7AaWXprsMCft/2VGzHfaDTDE=;
        b=QLmUA4vlp1avtnR2BnvptDxpoObyW9o77qqDQt6aJ2jt5GzWldiaQkzi9Dmbk8AK4h
         8jc7E7usETTSUqKo2MLWu3cNqesUkc427urtAE3Mp+fCAov2QqUP9e+NPRGbs7X5NasX
         wcTDtCed4YO2z2XWh8tYGzqOfT453qXn88W269s49AknxDC4+IB3lpfsScKUTtDGJI8f
         LrlfoLKK4X19Uf1droM7iQ28yXPQn7ePvLyHVr1bcw6KadhOUSQWoepJn5DRT7HurxWt
         CEK6bjjC5OcCDYcfhTGeKNUCXDaa2mas36zrwK8f83QrVfVpPiOuOlN+AKHKYZhgFQm7
         XdSQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:message-id:in-reply-to:references:from:date
         :subject:fcc:content-transfer-encoding:mime-version:to:cc;
        bh=WUpeJMgyy8fKbeOw6Sq7AaWXprsMCft/2VGzHfaDTDE=;
        b=nk/WkoKncVoKN7c+Ik1JZ9gb2n4fnIxVsTwYp19UNGlFiy6xeLQrBRCf1MZRDTQ4yt
         CSvgsBfLdHfguonMy7vgfd9iiavOQt1JYOtaIAVYI4lfXjkqK0MgmujYzl5m46jIP7hr
         s8ulBqhKtlv7e4xqn1N7nas8ETcLzRJPyJI/m1CND0k1q3vAS3LQN6W1azjoZhT/9kFq
         mIyiMHw+ckitwxhrBcHMb0HjQ7ee3q+puWzy7IOqe16E5HRJO8TdZv3itS6W9b6M7Aa6
         LM+JhntKgG2ap/r7deVRAcGPP5zgaIXvhNPUIsNl+1dQRzf7YbpWAIlXAIJjBWMhf5gd
         4C8g==
X-Gm-Message-State: APjAAAXQU7EtMaTL9PwkIZ0XsedPgJVtVakrYbhz0WJ2FVGJAkGwyee2
        ZDT/xroKnAnWDe0otmE23GtPzyu2
X-Google-Smtp-Source: APXvYqxuNpM+U53+qRKlQhvgkw8dV3Ze+wXM3OMh7fm892LQeuiyefSsA6NR7+HGJ8hUk6hYjYyUCg==
X-Received: by 2002:adf:bad3:: with SMTP id w19mr23052344wrg.17.1571683208037;
        Mon, 21 Oct 2019 11:40:08 -0700 (PDT)
Received: from [127.0.0.1] ([13.74.141.28])
        by smtp.gmail.com with ESMTPSA id b196sm8161324wmd.24.2019.10.21.11.40.07
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Mon, 21 Oct 2019 11:40:07 -0700 (PDT)
Message-Id: <d6ae4e1c54b50d33571ce0529da43ba1d41a630e.1571683203.git.gitgitgadget@gmail.com>
In-Reply-To: <pull.337.v4.git.1571683203.gitgitgadget@gmail.com>
References: <pull.337.v3.git.gitgitgadget@gmail.com>
        <pull.337.v4.git.1571683203.gitgitgadget@gmail.com>
From:   "William Baker via GitGitGadget" <gitgitgadget@gmail.com>
Date:   Mon, 21 Oct 2019 18:40:02 +0000
Subject: [PATCH v4 5/6] midx: honor the MIDX_PROGRESS flag in midx_repack
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
index 35bdc5f72c..b5f7f1c54a 100644
--- a/midx.c
+++ b/midx.c
@@ -1373,6 +1373,12 @@ int midx_repack(struct repository *r, const char *object_dir, size_t batch_size,
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

