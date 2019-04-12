Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.2 (2018-09-13) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-4.1 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,RCVD_IN_DNSWL_HI
	shortcircuit=no autolearn=ham autolearn_force=no version=3.4.2
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 4B4BC20248
	for <e@80x24.org>; Fri, 12 Apr 2019 09:37:31 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726912AbfDLJha (ORCPT <rfc822;e@80x24.org>);
        Fri, 12 Apr 2019 05:37:30 -0400
Received: from mail-ed1-f67.google.com ([209.85.208.67]:44297 "EHLO
        mail-ed1-f67.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726709AbfDLJhX (ORCPT <rfc822;git@vger.kernel.org>);
        Fri, 12 Apr 2019 05:37:23 -0400
Received: by mail-ed1-f67.google.com with SMTP id d11so7732505edp.11
        for <git@vger.kernel.org>; Fri, 12 Apr 2019 02:37:22 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=date:message-id:in-reply-to:references:from:subject:fcc
         :content-transfer-encoding:mime-version:to:cc;
        bh=Vwnvz2KiiTfEUjy+0TI9zX00UK2D7BQp/26Y5Y1Hfg8=;
        b=ONxGCu1QXR0BgwFFPNx+R/4XbYQvx7r+wTQeXsCRhHO0wjIXThk7efDPk/Ec2jVelh
         1xP1O9pKnGO2+aX6uASdWJcU2dvuG4y8BBlOHDyNA9RNhOoxuDStBRJL2CBBRhUVC1C8
         xlNOMzyv982Tvt/BgyrW9wT+mAtW/cpN3fm9WXtSlEZfU1AYxGURjkqPjRdekTWM9xOw
         gJKuDQW776B5PMrUHFTtw9ChVBvYGEGB+34u78OSKtjhIeafXMJC158d2yY8ta3ekZRo
         bXGXNN25qtk99QsKGMQXKBjpYxfEyxHa4+0jNhWgv0cjsXSz29v8c3mVemWQ5E5KNCaT
         EyvQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:message-id:in-reply-to:references:from
         :subject:fcc:content-transfer-encoding:mime-version:to:cc;
        bh=Vwnvz2KiiTfEUjy+0TI9zX00UK2D7BQp/26Y5Y1Hfg8=;
        b=Yt2UYOSMpzDxBULYo61I7zxsOxvPIqkhHQ1+LjLiwXBkVORSDmN19vjDo8HCI5yenA
         ooNGsBH/e42pytJNOJOjmiPOB8/TorHKjMgkf95Gg8Vfsarxzj9fT6yEHcjtxyaM12w2
         TJKZH7FNOUxHwuXh6pN66xD+LqBmpnr7Xcz5lhjjMjdZLl52aVJO6rG8hdzNziXykp4G
         qIElbWY6hJBIFiTEiuxfaRgKaYl1f30nvcf9Bs3wdhXd3PddxZCRKBiZftZTXm/xkzWu
         ExW71YfSaHF3w7vpnmmkYi2YE1+iQSofsbNqG6rkItdOPw6KhJ8AZfh8+nmqTGL0A9SJ
         WG4w==
X-Gm-Message-State: APjAAAVzeoSD3p4BbTbJUSqcuQEsOngY/ZTwpH7xicdEGxxet873+vXV
        5Z7JdyLYX0LWVRGtoy7C1y5++BVv
X-Google-Smtp-Source: APXvYqxZsUBawJkOr3Y12ldeuHvYsj7ZAzG/5F+SBuPjQ5TatAiN7KJKCByQySwM3CcmqI9lCfAMkA==
X-Received: by 2002:aa7:d39a:: with SMTP id x26mr12727141edq.48.1555061841346;
        Fri, 12 Apr 2019 02:37:21 -0700 (PDT)
Received: from [127.0.0.1] ([13.74.141.28])
        by smtp.gmail.com with ESMTPSA id n64sm1024104edc.82.2019.04.12.02.37.20
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Fri, 12 Apr 2019 02:37:20 -0700 (PDT)
Date:   Fri, 12 Apr 2019 02:37:20 -0700 (PDT)
X-Google-Original-Date: Fri, 12 Apr 2019 09:37:12 GMT
Message-Id: <7d8f6a2ee6295b9817566853e1cfeca16b144b30.1555061837.git.gitgitgadget@gmail.com>
In-Reply-To: <pull.167.v2.git.gitgitgadget@gmail.com>
References: <pull.167.git.gitgitgadget@gmail.com>
        <pull.167.v2.git.gitgitgadget@gmail.com>
From:   "Johannes Schindelin via GitGitGadget" <gitgitgadget@gmail.com>
Subject: [PATCH v2 3/8] t7810: do not abbreviate `--no-exclude-standard` nor
 `--invert-match`
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

This script used abbreviated options, which is unnecessarily fragile.

Signed-off-by: Johannes Schindelin <johannes.schindelin@gmx.de>
---
 t/t7810-grep.sh | 16 ++++++++--------
 1 file changed, 8 insertions(+), 8 deletions(-)

diff --git a/t/t7810-grep.sh b/t/t7810-grep.sh
index 43aa4161cf..2e1bb61b41 100755
--- a/t/t7810-grep.sh
+++ b/t/t7810-grep.sh
@@ -119,33 +119,33 @@ do
 		test_cmp expected actual
 	'
 
-	test_expect_success "grep -w $L (with --column, --invert)" '
+	test_expect_success "grep -w $L (with --column, --invert-match)" '
 		{
 			echo ${HC}file:1:foo mmap bar
 			echo ${HC}file:1:foo_mmap bar
 			echo ${HC}file:1:foo_mmap bar mmap
 			echo ${HC}file:1:foo mmap bar_mmap
 		} >expected &&
-		git grep --column --invert -w -e baz $H -- file >actual &&
+		git grep --column --invert-match -w -e baz $H -- file >actual &&
 		test_cmp expected actual
 	'
 
-	test_expect_success "grep $L (with --column, --invert, extended OR)" '
+	test_expect_success "grep $L (with --column, --invert-match, extended OR)" '
 		{
 			echo ${HC}hello_world:6:HeLLo_world
 		} >expected &&
-		git grep --column --invert -e ll --or --not -e _ $H -- hello_world \
+		git grep --column --invert-match -e ll --or --not -e _ $H -- hello_world \
 			>actual &&
 		test_cmp expected actual
 	'
 
-	test_expect_success "grep $L (with --column, --invert, extended AND)" '
+	test_expect_success "grep $L (with --column, --invert-match, extended AND)" '
 		{
 			echo ${HC}hello_world:3:Hello world
 			echo ${HC}hello_world:3:Hello_world
 			echo ${HC}hello_world:6:HeLLo_world
 		} >expected &&
-		git grep --column --invert --not -e _ --and --not -e ll $H -- hello_world \
+		git grep --column --invert-match --not -e _ --and --not -e ll $H -- hello_world \
 			>actual &&
 		test_cmp expected actual
 	'
@@ -1010,7 +1010,7 @@ test_expect_success 'outside of git repository' '
 			echo ".gitignore:.*o*" &&
 			cat ../expect.full
 		} >../expect.with.ignored &&
-		git grep --no-index --no-exclude o >../actual.full &&
+		git grep --no-index --no-exclude-standard o >../actual.full &&
 		test_cmp ../expect.with.ignored ../actual.full
 	)
 '
@@ -1051,7 +1051,7 @@ test_expect_success 'outside of git repository with fallbackToNoIndex' '
 			echo ".gitignore:.*o*" &&
 			cat ../expect.full
 		} >../expect.with.ignored &&
-		git -c grep.fallbackToNoIndex grep --no-exclude o >../actual.full &&
+		git -c grep.fallbackToNoIndex grep --no-exclude-standard o >../actual.full &&
 		test_cmp ../expect.with.ignored ../actual.full
 	)
 '
-- 
gitgitgadget

