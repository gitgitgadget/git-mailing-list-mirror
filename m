Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.2 (2018-09-13) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-4.2 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,RCVD_IN_DNSWL_HI,
	SPF_HELO_NONE,SPF_NONE shortcircuit=no autolearn=ham
	autolearn_force=no version=3.4.2
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 35FA81F462
	for <e@80x24.org>; Sat,  8 Jun 2019 14:42:46 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727059AbfFHOmp (ORCPT <rfc822;e@80x24.org>);
        Sat, 8 Jun 2019 10:42:45 -0400
Received: from mail-ed1-f65.google.com ([209.85.208.65]:39070 "EHLO
        mail-ed1-f65.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727009AbfFHOmo (ORCPT <rfc822;git@vger.kernel.org>);
        Sat, 8 Jun 2019 10:42:44 -0400
Received: by mail-ed1-f65.google.com with SMTP id m10so6897918edv.6
        for <git@vger.kernel.org>; Sat, 08 Jun 2019 07:42:43 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=date:message-id:in-reply-to:references:from:subject:fcc
         :content-transfer-encoding:mime-version:to:cc;
        bh=gREBJCeQMGVgeHgGcaXrLJ7H//aCBlb5shp2yoVzdKc=;
        b=SLl+xj/voPvfSrOxOJ87b5St25R6YwgV6e2ikUStDnze3qwidUsdweomikJXg1GUyC
         kn2jdiJhRxG3pLPbw5Q+7f7GzU3fapQIniDKVc3IIUPG3YgY9YIL865zKEvY/LCS6KZN
         DYLJwLiFDZs3u/WYCOe0qkGHvpn1em3L6xE2mHWtqfgOOOlVx06eCPu/3e9DkvwN/Fr6
         3VxN079yW02DydipCex7SS3/x4FLeuHVpftzuCnjC9uDfkJSxaVkFg0e7CgtFeLhjqEK
         hbNQO7IYdKSXxoWlt7BhS8Alyet5EG/Ej0bmU3QtEZS2Su/kPIRgJeS6PF9Lw4NE6wMU
         Fe4w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:message-id:in-reply-to:references:from
         :subject:fcc:content-transfer-encoding:mime-version:to:cc;
        bh=gREBJCeQMGVgeHgGcaXrLJ7H//aCBlb5shp2yoVzdKc=;
        b=AwA5VHHzzTNtRCSVmB2TCQA1CrURm69EhLZPPh31jm8XnjT7/9Yty971DyUuoRgADa
         iQ4VGy5iA5umfOr4rlocIx9sjwirjPrng1T+LGve3y7/81DOT2BP+bTEqvZc3mCG1+kU
         hBeu1Q+6MicQKC24iGupcjrF+lGzyAJYBEAQSKgBBuBRmaXBCSI74K9Xroa+06IMUO7M
         tkHyN87pu6CEivOiNz/lVMm62+DgAYXvcaizUTHXk7rj8q8Iqt8adQWzGJ2jDum2IhHq
         fHpNyU3ljS1qP3IcntNKxvtw06izSuvK6cGmasI7eUqRgiFknGDpTxladfk50X8f9719
         5VGw==
X-Gm-Message-State: APjAAAXn4CmtP6wpvc9DRPsGagMwa9QubJ7EJEWEwgbIGOShpcz1gCgA
        NZlxRsvYLwp5v85tSlgYjCel68kW
X-Google-Smtp-Source: APXvYqyIpBCHA2lzUlZgZEbPmFTi20SXEs0fLu+yucT5ApdcFIjyDHLSmbKJsMCRXKUmpKrlZFSGzg==
X-Received: by 2002:a50:87a8:: with SMTP id a37mr12813148eda.197.1560004962941;
        Sat, 08 Jun 2019 07:42:42 -0700 (PDT)
Received: from [127.0.0.1] ([13.74.141.28])
        by smtp.gmail.com with ESMTPSA id l6sm1192678edk.8.2019.06.08.07.42.42
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Sat, 08 Jun 2019 07:42:42 -0700 (PDT)
Date:   Sat, 08 Jun 2019 07:42:42 -0700 (PDT)
X-Google-Original-Date: Sat, 08 Jun 2019 14:42:40 GMT
Message-Id: <4ac75dd3635e39f9faa67fb1e88897663e3dc6cd.1560004960.git.gitgitgadget@gmail.com>
In-Reply-To: <pull.142.git.gitgitgadget@gmail.com>
References: <pull.142.git.gitgitgadget@gmail.com>
From:   "Jeff Hostetler via GitGitGadget" <gitgitgadget@gmail.com>
Subject: [PATCH 1/1] diffcore-rename: speed up register_rename_src
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

Teach register_rename_src() to see if new file pair
can simply be appended to the rename_src[] array before
performing the binary search to find the proper insertion
point.

This is a performance optimization.  This routine is called
during run_diff_files in status and the caller is iterating
over the sorted index, so we should expect to be able to
append in the normal case.  The existing insert logic is
preserved so we don't have to assume that, but simply take
advantage of it if possible.

Signed-off-by: Jeff Hostetler <jeffhost@microsoft.com>
Signed-off-by: Johannes Schindelin <johannes.schindelin@gmx.de>
---
 diffcore-rename.c | 13 +++++++++++++
 1 file changed, 13 insertions(+)

diff --git a/diffcore-rename.c b/diffcore-rename.c
index 07bd34b631..5bfc5f6c22 100644
--- a/diffcore-rename.c
+++ b/diffcore-rename.c
@@ -82,6 +82,18 @@ static struct diff_rename_src *register_rename_src(struct diff_filepair *p)
 
 	first = 0;
 	last = rename_src_nr;
+
+	if (last > 0) {
+		struct diff_rename_src *src = &(rename_src[last-1]);
+		int cmp = strcmp(one->path, src->p->one->path);
+		if (!cmp)
+			return src;
+		if (cmp > 0) {
+			first = last;
+			goto append_it;
+		}
+	}
+
 	while (last > first) {
 		int next = (last + first) >> 1;
 		struct diff_rename_src *src = &(rename_src[next]);
@@ -95,6 +107,7 @@ static struct diff_rename_src *register_rename_src(struct diff_filepair *p)
 		first = next+1;
 	}
 
+append_it:
 	/* insert to make it at "first" */
 	ALLOC_GROW(rename_src, rename_src_nr + 1, rename_src_alloc);
 	rename_src_nr++;
-- 
gitgitgadget
