Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.2 (2018-09-13) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-4.1 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,RCVD_IN_DNSWL_HI
	shortcircuit=no autolearn=ham autolearn_force=no version=3.4.2
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id BDEB720248
	for <e@80x24.org>; Fri, 12 Apr 2019 09:37:27 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726902AbfDLJh1 (ORCPT <rfc822;e@80x24.org>);
        Fri, 12 Apr 2019 05:37:27 -0400
Received: from mail-ed1-f68.google.com ([209.85.208.68]:34604 "EHLO
        mail-ed1-f68.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726874AbfDLJhZ (ORCPT <rfc822;git@vger.kernel.org>);
        Fri, 12 Apr 2019 05:37:25 -0400
Received: by mail-ed1-f68.google.com with SMTP id x14so7781445eds.1
        for <git@vger.kernel.org>; Fri, 12 Apr 2019 02:37:24 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=date:message-id:in-reply-to:references:from:subject:fcc
         :content-transfer-encoding:mime-version:to:cc;
        bh=iE6cCDC3FJHr9ipm1qLoB/McdwT/thW5o2IT6HMvOlk=;
        b=LEY3gKjAalkjGoNKptYGAuPp2biF4V0Uv/t6qGUToGhdWxWgFdzwaW43vOvrItxMNk
         cvYtZosL8+PsET1RRaK2lwqaOGG2XH/jmEafEZ40tpPF4qvhr2mlnMjXNNLB9bqyhQF/
         0WufMx87M2O1A/MtIjPcp3HdgncBgZ+DJFuThfnMin/9tQZSOrK1yOzIS0R9y1uPSfBc
         uTsSy7v7eYbDClh79UJXzAbaESf61W9JIQ/uq3bRu8maVSjqEVNzINIoaeffzx+yUyut
         ELEOF0IYb1iFsauvfufMrYRvc5K+viLVUhkD+kC/InR9it1V8y3n/EN3HmRRsSflxLa3
         twKA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:message-id:in-reply-to:references:from
         :subject:fcc:content-transfer-encoding:mime-version:to:cc;
        bh=iE6cCDC3FJHr9ipm1qLoB/McdwT/thW5o2IT6HMvOlk=;
        b=TEwu4nYLgfTNjVZN69rflth2b06FHxnQW0Ny8PXJdP2wI1DVFRriNyNI28Pg6QSiAg
         OBNPVMfH3ZbY7YTES67K8lAXW9jeNRHAEjh9KD3f9p5VnBw015ySlvIGzYTJRRw7+ZzQ
         lx7TNf+SxA78RZC4QD+F6BHv8kY54/w3/mTxaLd7JFHeBWtca889dl5XtY7wkpTzMXoa
         tdYieKlo1JREKIdx9Otx66KyEuc/hI8Gp2EkqO04NKHGQQvcx7StpX5S1jHEn//CQfkw
         pCcJq3YmY24UdF2eDEw3ugmF6bQTLyr/dR8QRn15dd0uthIongiWAFZGyPt9u4gzPGeL
         8Fuw==
X-Gm-Message-State: APjAAAXf9HjJM+fqCclOCHg04ozEb5lz2DWDOu9/AlGAiKUIgXoG2gOC
        LU9Neq56IU2Gm8gM2yNa6aZczBUM
X-Google-Smtp-Source: APXvYqzhgVhdcMpok0FbmcY0mcOOvL8ZcxXipeYnpEpB7NafiY22YVpf+lrPKZLtE4fXHALItLld3g==
X-Received: by 2002:a17:906:1ed7:: with SMTP id m23mr30799534ejj.198.1555061843635;
        Fri, 12 Apr 2019 02:37:23 -0700 (PDT)
Received: from [127.0.0.1] ([13.74.141.28])
        by smtp.gmail.com with ESMTPSA id o58sm8570660edc.74.2019.04.12.02.37.23
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Fri, 12 Apr 2019 02:37:23 -0700 (PDT)
Date:   Fri, 12 Apr 2019 02:37:23 -0700 (PDT)
X-Google-Original-Date: Fri, 12 Apr 2019 09:37:15 GMT
Message-Id: <531450c00dfe517748d9ad0bc77b9871c45042aa.1555061837.git.gitgitgadget@gmail.com>
In-Reply-To: <pull.167.v2.git.gitgitgadget@gmail.com>
References: <pull.167.git.gitgitgadget@gmail.com>
        <pull.167.v2.git.gitgitgadget@gmail.com>
From:   "Johannes Schindelin via GitGitGadget" <gitgitgadget@gmail.com>
Subject: [PATCH v2 6/8] tests (status): spell out the `--find-renames` option
 in full
Fcc:    Sent
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
MIME-Version: 1.0
To:     git@vger.kernel.org
Cc:     Denton Liu <liu.denton@gmail.com>,
        =?UTF-8?Q?=C3=86var_Arnfj=C3=B6r=C3=B0?= Bjarmason 
        <avarab@gmail.com>, Junio C Hamano <gitster@pobox.com>,
        Johannes Schindelin <johannes.schindelin@gmx.de>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

From: Johannes Schindelin <johannes.schindelin@gmx.de>

To avoid future ambiguities, we really want to use full option names in
the test suite. `t7525-status-rename.sh` used an abbreviated form of the
`--find-renames` option, though, so let's change that.

Signed-off-by: Johannes Schindelin <johannes.schindelin@gmx.de>
---
 t/t7525-status-rename.sh | 8 ++++----
 1 file changed, 4 insertions(+), 4 deletions(-)

diff --git a/t/t7525-status-rename.sh b/t/t7525-status-rename.sh
index ef8b1b3078..a62736dce0 100755
--- a/t/t7525-status-rename.sh
+++ b/t/t7525-status-rename.sh
@@ -84,7 +84,7 @@ test_expect_success 'status score=100%' '
 	test_i18ngrep "deleted:" actual &&
 	test_i18ngrep "new file:" actual &&
 
-	git status --find-rename=100% >actual &&
+	git status --find-renames=100% >actual &&
 	test_i18ngrep "deleted:" actual &&
 	test_i18ngrep "new file:" actual
 '
@@ -93,11 +93,11 @@ test_expect_success 'status score=01%' '
 	git status -M=01% >actual &&
 	test_i18ngrep "renamed:" actual &&
 
-	git status --find-rename=01% >actual &&
+	git status --find-renames=01% >actual &&
 	test_i18ngrep "renamed:" actual
 '
 
-test_expect_success 'copies not overridden by find-rename' '
+test_expect_success 'copies not overridden by find-renames' '
 	cp renamed copy &&
 	git add copy &&
 
@@ -105,7 +105,7 @@ test_expect_success 'copies not overridden by find-rename' '
 	test_i18ngrep "copied:" actual &&
 	test_i18ngrep "renamed:" actual &&
 
-	git -c status.renames=copies status --find-rename=01% >actual &&
+	git -c status.renames=copies status --find-renames=01% >actual &&
 	test_i18ngrep "copied:" actual &&
 	test_i18ngrep "renamed:" actual
 '
-- 
gitgitgadget

