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
	by dcvr.yhbt.net (Postfix) with ESMTP id 89EA51F454
	for <e@80x24.org>; Tue,  5 Nov 2019 23:13:06 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729509AbfKEXNF (ORCPT <rfc822;e@80x24.org>);
        Tue, 5 Nov 2019 18:13:05 -0500
Received: from mail-wm1-f45.google.com ([209.85.128.45]:37346 "EHLO
        mail-wm1-f45.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726820AbfKEXNF (ORCPT <rfc822;git@vger.kernel.org>);
        Tue, 5 Nov 2019 18:13:05 -0500
Received: by mail-wm1-f45.google.com with SMTP id q130so1243520wme.2
        for <git@vger.kernel.org>; Tue, 05 Nov 2019 15:13:04 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=message-id:in-reply-to:references:from:date:subject:fcc
         :content-transfer-encoding:mime-version:to:cc;
        bh=AfSG5UOyUphC2WnQchbkgDMvfeEMUO2Obbmj7Bm6lJw=;
        b=kQPZ0jZFdMwaIjLnSBKaW/EDZ380NSrRn0LnZqix57xur2MdPcGp4IljPZC6h0Jhqf
         8YD9oL2e6K7HbbdPNpF5ui7drXl0QhhgV6DTY/YFAbBc6/jXJZhz9r9P/5mjQBBuP3vX
         7ui1XYrIzcIQRfOFCw1GZZ4sCzbEXIRYArpezNs2kPX0DSWoHWfjKj1NPATVVqG2LhZR
         /RbYRTqZg2PtBawmSkFZOvB6Xfl6oyd5rsl3tsRZlNoQpsmmym1rz4blW3lgAVVs0aDC
         00ycweO66V6djP1HEgvMtSNraEN66+yh+nxTtH3yvdLPUOz/OJ+r9CF03Ra23uL6sYqB
         LLeg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:message-id:in-reply-to:references:from:date
         :subject:fcc:content-transfer-encoding:mime-version:to:cc;
        bh=AfSG5UOyUphC2WnQchbkgDMvfeEMUO2Obbmj7Bm6lJw=;
        b=UqnmwVeku3IDu8o5c6qR1R5PUUhFRzWiPHUPErTeYs2TYRAHcBgJcx6UM9IgZNZ8iY
         8cpGEuPxV8lG+XwcGjVzMuXRR0Bdku4GxlI9fkw7Xgt0qQoUHOsX+8+5GrJ+tvPvR2uH
         UyVBuaNjXAbQOKC8+87nOmI1AcBOFnPTzhIEbNRIW6LK+fOCmG6KVKtaoLmVHBx0zVOD
         lCCBmEQuaQrGn4G0m2xxwpnyZFBteNvBH/piV9gloWpuPnL8pQ2BH6TMhDsVlX5mRc7Z
         9yv9z7N4/GFaboXE1BqVxOxES+UyPr4VfeuTBap/WW7lb9jJWJA64ltt9iEqXHa4KKZA
         RgRA==
X-Gm-Message-State: APjAAAXRbwB2CPnw9B2enWmrNm6uQgmzWMQkgxpiI2opLiAHbMjXJ7xC
        Cwg7g8ssN7W+YUXJEITKXSIAWl5V
X-Google-Smtp-Source: APXvYqxipr0P67Jalxd9+4kUWIBAOKHWdKv9cTUJte+aBo+CuX+6yr5j2qKGFA//hzl5h+dUDQ6ONw==
X-Received: by 2002:a05:600c:2549:: with SMTP id e9mr1092900wma.177.1572995583405;
        Tue, 05 Nov 2019 15:13:03 -0800 (PST)
Received: from [127.0.0.1] ([13.74.141.28])
        by smtp.gmail.com with ESMTPSA id 4sm1050805wmd.33.2019.11.05.15.13.02
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Tue, 05 Nov 2019 15:13:03 -0800 (PST)
Message-Id: <51df6661f772b08eef709fcc36ba11a158ba6fad.1572995581.git.gitgitgadget@gmail.com>
In-Reply-To: <pull.447.git.1572995581.gitgitgadget@gmail.com>
References: <pull.447.git.1572995581.gitgitgadget@gmail.com>
From:   "naiduv via GitGitGadget" <gitgitgadget@gmail.com>
Date:   Tue, 05 Nov 2019 23:13:01 +0000
Subject: [PATCH 1/1] Improve unpack trees error text
Fcc:    Sent
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
MIME-Version: 1.0
To:     git@vger.kernel.org
Cc:     Junio C Hamano <gitster@pobox.com>, naiduv <naiduvenkat@gmail.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

From: naiduv <naiduvenkat@gmail.com>

Signed-off-by: naiduv <naiduvenkat@gmail.com>
---
 t/t7110-reset-merge.sh | 4 ++--
 unpack-trees.c         | 4 ++--
 2 files changed, 4 insertions(+), 4 deletions(-)

diff --git a/t/t7110-reset-merge.sh b/t/t7110-reset-merge.sh
index a82a07a04a..9b2298bfb3 100755
--- a/t/t7110-reset-merge.sh
+++ b/t/t7110-reset-merge.sh
@@ -173,7 +173,7 @@ test_expect_success 'reset --merge fails with changes in file it touches' '
     sed -e "s/line 1/changed line 1/" <file1 >file3 &&
     mv file3 file1 &&
     test_must_fail git reset --merge HEAD^ 2>err.log &&
-    grep file1 err.log | grep "not uptodate"
+    grep file1 err.log | grep "not up to date"
 '
 
 # The next test will test the following:
@@ -189,7 +189,7 @@ test_expect_success 'reset --keep fails with changes in file it touches' '
     sed -e "s/line 1/changed line 1/" <file1 >file3 &&
     mv file3 file1 &&
     test_must_fail git reset --keep HEAD^ 2>err.log &&
-    grep file1 err.log | grep "not uptodate"
+    grep file1 err.log | grep "not up to date"
 '
 
 test_expect_success 'setup 3 different branches' '
diff --git a/unpack-trees.c b/unpack-trees.c
index 33ea7810d8..74c348d40e 100644
--- a/unpack-trees.c
+++ b/unpack-trees.c
@@ -29,7 +29,7 @@ static const char *unpack_plumbing_errors[NB_UNPACK_TREES_ERROR_TYPES] = {
 	"Entry '%s' would be overwritten by merge. Cannot merge.",
 
 	/* ERROR_NOT_UPTODATE_FILE */
-	"Entry '%s' not uptodate. Cannot merge.",
+	"Entry '%s' is not up to date. Cannot merge.",
 
 	/* ERROR_NOT_UPTODATE_DIR */
 	"Updating '%s' would lose untracked files in it",
@@ -44,7 +44,7 @@ static const char *unpack_plumbing_errors[NB_UNPACK_TREES_ERROR_TYPES] = {
 	"Entry '%s' overlaps with '%s'.  Cannot bind.",
 
 	/* ERROR_SPARSE_NOT_UPTODATE_FILE */
-	"Entry '%s' not uptodate. Cannot update sparse checkout.",
+	"Entry '%s' is not up to date. Cannot update sparse checkout.",
 
 	/* ERROR_WOULD_LOSE_ORPHANED_OVERWRITTEN */
 	"Working tree file '%s' would be overwritten by sparse checkout update.",
-- 
gitgitgadget
