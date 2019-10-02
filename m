Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.2 (2018-09-13) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-4.0 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,RCVD_IN_DNSWL_HI,
	SPF_HELO_NONE,SPF_NONE shortcircuit=no autolearn=ham
	autolearn_force=no version=3.4.2
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 3331F1F4BD
	for <e@80x24.org>; Wed,  2 Oct 2019 18:05:19 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728714AbfJBSFS (ORCPT <rfc822;e@80x24.org>);
        Wed, 2 Oct 2019 14:05:18 -0400
Received: from mail-wm1-f52.google.com ([209.85.128.52]:40259 "EHLO
        mail-wm1-f52.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727721AbfJBSFQ (ORCPT <rfc822;git@vger.kernel.org>);
        Wed, 2 Oct 2019 14:05:16 -0400
Received: by mail-wm1-f52.google.com with SMTP id b24so7874852wmj.5
        for <git@vger.kernel.org>; Wed, 02 Oct 2019 11:05:14 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=date:message-id:in-reply-to:references:from:subject:mime-version
         :content-transfer-encoding:fcc:to:cc;
        bh=yhmWjhK0PdeuDwseK+qIidm6Jgn3YWsQdtLuqXyeKv0=;
        b=XHbu/o3LakFeFhbmYvo5Kt7wB9RY4lVKqCQ3K4b8l38ggEp0h9iPHxbHQd3pormi/z
         /z8MRr/4zBJlXRQ0AhVDIRcBIA58109p194MPonaz8nt7e1oMeuUDl35XcVbZdB1Xq4P
         kV50AT8McjXyfkkh7t9Y7JsMalrB6vGI58zB8D0BL381Y2dzYfCJ59mHlajtwe9U0g9v
         TleNFhA+c8oSKwdyew1MAD+MijSSIHVqxtBi1SK63NIXVOK9jj2wc9RXkWeEM4eCSVs8
         s4rKM0buJuBM0BNeLEUvnPNeSEkMjXX1iTfdLAWAgPCb19Sp2Nz1j3j/ffdhc+ukPuGo
         fpiw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:message-id:in-reply-to:references:from
         :subject:mime-version:content-transfer-encoding:fcc:to:cc;
        bh=yhmWjhK0PdeuDwseK+qIidm6Jgn3YWsQdtLuqXyeKv0=;
        b=lsnLrjtfJ+kvDf9z9HtvHxUPFs6hpcLjIfa7uSPZ540SZVXNhtMJBwWxsngx7l606R
         73H2xIQKQzrK+KffrVJzJor03pWtdBQiyB/UvKabyMSbMEFXDKJQttzEZcwqqwBr3u8E
         0i4M7E7w/s2lrEVOlW2wur9Le7kDe9G9xGJfUwS6YQov/ceqvTHyUbqm7X7QG76+m56a
         z+ntFUasGpg83rYnnl7wFSoBwPltfCG3uIAY13qBU+v6+e99DB6wSjJx9MG4tdWk0B32
         Yp0amZhLhQ3lsC6O5Ldz2iS7q38wwWgX8sCz+BUcSi/+I/JgCqqB/G/x9BOmAN0koJj/
         hRdg==
X-Gm-Message-State: APjAAAW8CskbBwC1wI9EDjnJrJXR+DqCB/7qZYfUbJ1bcI5sNUba26nm
        P84cjuOe+S3U+OYqESQaDI890B75
X-Google-Smtp-Source: APXvYqzqO9+uQ20KexYhPDr+tAyP/gj/Ic0AHthixhOew8lST0jxr83z5NTNze49ml9q1EuDQA6OBQ==
X-Received: by 2002:a7b:c0d9:: with SMTP id s25mr3610783wmh.74.1570039513948;
        Wed, 02 Oct 2019 11:05:13 -0700 (PDT)
Received: from [127.0.0.1] ([13.74.141.28])
        by smtp.gmail.com with ESMTPSA id m18sm62808wrg.97.2019.10.02.11.05.13
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Wed, 02 Oct 2019 11:05:13 -0700 (PDT)
Date:   Wed, 02 Oct 2019 11:05:13 -0700 (PDT)
X-Google-Original-Date: Wed, 02 Oct 2019 18:05:11 GMT
Message-Id: <1f84f92846bc14d21aa7339c8baa0f9bb710b17d.1570039511.git.gitgitgadget@gmail.com>
In-Reply-To: <pull.373.git.gitgitgadget@gmail.com>
References: <pull.373.git.gitgitgadget@gmail.com>
From:   "Johannes Schindelin via GitGitGadget" <gitgitgadget@gmail.com>
Subject: [PATCH 1/1] range-diff: internally force `diff.noprefix=false`
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Fcc:    Sent
To:     git@vger.kernel.org
Cc:     Johannes Schindelin <johannes.schindelin@gmx.de>,
        Junio C Hamano <gitster@pobox.com>,
        Johannes Schindelin <johannes.schindelin@gmx.de>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

From: Johannes Schindelin <johannes.schindelin@gmx.de>

When parsing the diffs, `range-diff` expects to see the prefixes `a/`
and `b/` in the diff headers.

These prefixes can be forced off via the config setting
`diff.noprefix=true`. As `range-diff` is not prepared for that
situation, this will cause a segmentation fault.

Let's avoid that by forcing `diff.noprefix=false` just for that all to
`git log` that generates the diffs that `range-diff` wants to parse.

Noticed-by: Michal Suchánek <msuchanek@suse.de>
Signed-off-by: Johannes Schindelin <johannes.schindelin@gmx.de>
---
 range-diff.c          | 3 ++-
 t/t3206-range-diff.sh | 4 ++++
 2 files changed, 6 insertions(+), 1 deletion(-)

diff --git a/range-diff.c b/range-diff.c
index ba1e9a4265..8cc348b4cb 100644
--- a/range-diff.c
+++ b/range-diff.c
@@ -50,7 +50,8 @@ static int read_patches(const char *range, struct string_list *list)
 	int offset, len;
 	size_t size;
 
-	argv_array_pushl(&cp.args, "log", "--no-color", "-p", "--no-merges",
+	argv_array_pushl(&cp.args, "-c", "diff.noprefix=false",
+			"log", "--no-color", "-p", "--no-merges",
 			"--reverse", "--date-order", "--decorate=no",
 			/*
 			 * Choose indicators that are not used anywhere
diff --git a/t/t3206-range-diff.sh b/t/t3206-range-diff.sh
index 0120f769f1..64b66f2094 100755
--- a/t/t3206-range-diff.sh
+++ b/t/t3206-range-diff.sh
@@ -461,4 +461,8 @@ test_expect_success 'format-patch --range-diff as commentary' '
 	grep "> 1: .* new message" 0001-*
 '
 
+test_expect_success 'range-diff overrides diff.noprefix internally' '
+	git -c diff.noprefix=true range-diff HEAD^...
+'
+
 test_done
-- 
gitgitgadget
