Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.2 (2018-09-13) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-3.3 required=3.0 tests=AWL,BAYES_00,BODY_8BITS,
	DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,
	FREEMAIL_FROM,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,
	RCVD_IN_DNSWL_HI,SPF_HELO_NONE,SPF_NONE shortcircuit=no autolearn=ham
	autolearn_force=no version=3.4.2
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id E64941F464
	for <e@80x24.org>; Mon, 23 Sep 2019 10:04:23 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2407627AbfIWKEX (ORCPT <rfc822;e@80x24.org>);
        Mon, 23 Sep 2019 06:04:23 -0400
Received: from mail-wm1-f66.google.com ([209.85.128.66]:35341 "EHLO
        mail-wm1-f66.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S2406837AbfIWKEW (ORCPT <rfc822;git@vger.kernel.org>);
        Mon, 23 Sep 2019 06:04:22 -0400
Received: by mail-wm1-f66.google.com with SMTP id y21so8602455wmi.0
        for <git@vger.kernel.org>; Mon, 23 Sep 2019 03:04:21 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=date:message-id:in-reply-to:references:from:subject:fcc
         :content-transfer-encoding:mime-version:to:cc;
        bh=stbWo9RCfPeujJ9kOQ2CfIq+snWvntoSqePPwb6tozo=;
        b=dWms+wr0ngxSTsQbz55+u2g3peqbA4V6Y126BPnUEdJ1PSE8BwNtRGZjprHELn/ndS
         yUHZYCHmgntxwYTtqicTuKa9yOkT/hRGpXpUU4US9O6WTsbJo0bTbOnQn7ETXDk4Mqwl
         +21TTi8xvFW+9bBiHXlEwSlzlaGek9gXW6il47lu8EDRwbXD02lCFzZT79GE0oQyAhj7
         6dDKD0PFs3fJ2kywsxcUyNQmCULrFR7t9X78MFexTgZL94tv8f7a8iy8Ijw0HR6/DQOE
         iVhk2v9c4FzPsQxTv1zOP2KQ0nyxcwGj07Crq7VTMMEu2fxfn30EwGJM2VFq2uBe+VP0
         snNQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:message-id:in-reply-to:references:from
         :subject:fcc:content-transfer-encoding:mime-version:to:cc;
        bh=stbWo9RCfPeujJ9kOQ2CfIq+snWvntoSqePPwb6tozo=;
        b=Ii31hvUAQHfuGeBVeQ0X0YHZM7TakAxQYkfv8/t0m5E1T+vJRnvuEUMMXvR+mBgVC9
         2HrdWw7MbjNm+KgWcaY5+tY1ef0Soj7ve4b17qlci1lS+y6OI0cDH17CTD13vol7JDrf
         dFkVg1eDufKoYoGjSUFYBApCk+1gg0cX1M7miWZ6x9qul+lYklkInLBnslnCyrb+ELcK
         OO6TuhzSC9/WzakkhOwmz6jD1MHkZQAYDEeLRqmpvQ7Ih1VHrzLDo2vqw/jIYOrueFbm
         4sAEwU4JsPgxYQ5CcG+dVV6mqtDX/5F7paXkskzP7CZrbD024Km5F//bsVSDWdFn4jtR
         mmlg==
X-Gm-Message-State: APjAAAUTuetmJivFmUXhJ8LefbDjgtsHPHQF02u1rpj4PHM3Iw9YBQ7Z
        AHVcstRZINW2840Uvy1+xys4BRXL
X-Google-Smtp-Source: APXvYqx0QbSpMR/z6qwNKAMCStlWCYXralHmBvxZAfQWUK4VxwAfWr9qkj2bRrbzvgQhnIkBIVAGJw==
X-Received: by 2002:a1c:7914:: with SMTP id l20mr13144063wme.155.1569233060431;
        Mon, 23 Sep 2019 03:04:20 -0700 (PDT)
Received: from [127.0.0.1] ([13.74.141.28])
        by smtp.gmail.com with ESMTPSA id j1sm16431162wrg.24.2019.09.23.03.04.19
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Mon, 23 Sep 2019 03:04:19 -0700 (PDT)
Date:   Mon, 23 Sep 2019 03:04:19 -0700 (PDT)
X-Google-Original-Date: Mon, 23 Sep 2019 10:04:17 GMT
Message-Id: <40e54cf5ce74d1404187e31c94644df29134b4ff.1569233057.git.gitgitgadget@gmail.com>
In-Reply-To: <pull.347.v2.git.gitgitgadget@gmail.com>
References: <pull.347.git.gitgitgadget@gmail.com>
        <pull.347.v2.git.gitgitgadget@gmail.com>
From:   "Alexandr Miloslavskiy via GitGitGadget" <gitgitgadget@gmail.com>
Subject: [PATCH v2 2/2] t0028: add more tests
Fcc:    Sent
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
MIME-Version: 1.0
To:     git@vger.kernel.org
Cc:     Junio C Hamano <gitster@pobox.com>,
        Alexandr Miloslavskiy <alexandr.miloslavskiy@syntevo.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

From: Alexandr Miloslavskiy <alexandr.miloslavskiy@syntevo.com>

After I discovered that UTF-16-LE-BOM test was bugged and still
succeeded, I decided that better tests are required. Possibly the best
option here is to compare git results against hardcoded ground truth.

The new tests also cover more interesting chars where (ANSI != UTF-8).

Signed-off-by: Alexandr Miloslavskiy <alexandr.miloslavskiy@syntevo.com>
---
 t/t0028-working-tree-encoding.sh | 39 ++++++++++++++++++++++++++++++++
 1 file changed, 39 insertions(+)

diff --git a/t/t0028-working-tree-encoding.sh b/t/t0028-working-tree-encoding.sh
index 5493cf3ca9..d0dd5dd0ea 100755
--- a/t/t0028-working-tree-encoding.sh
+++ b/t/t0028-working-tree-encoding.sh
@@ -280,4 +280,43 @@ test_expect_success ICONV_SHIFT_JIS 'check roundtrip encoding' '
 	git reset
 '
 
+# $1: checkout encoding
+# $2: test string
+# $3: binary test string in checkout encoding
+test_commit_utf8_checkout_other () {
+	encoding="$1"
+	orig_string="$2"
+	expect_bytes="$3"
+	
+	test_expect_success "Commit utf-8, checkout ${encoding}" '
+		test_when_finished "git checkout HEAD -- .gitattributes" &&
+		
+		test_ext="commit_utf8_checkout_${encoding}" &&
+		test_file="test.${test_ext}" &&
+		
+		# Commit as utf-8
+		echo "*.${test_ext} text working-tree-encoding=utf-8" >.gitattributes &&
+		printf "${orig_string}" >"${test_file}" &&
+		git add "${test_file}" &&
+		git commit -m "Test data" &&
+
+		# Checkout in tested encoding
+		rm "${test_file}" &&
+		echo "*.${test_ext} text working-tree-encoding=${encoding}" >.gitattributes &&
+		git checkout HEAD -- "${test_file}" &&
+		
+		# Test
+		printf "${expect_bytes}" > "${test_file}.raw" &&
+		test_cmp_bin "${test_file}.raw" "${test_file}"
+	'
+}
+
+test_commit_utf8_checkout_other "UTF-8"        "Test Тест" "\124\145\163\164\040\320\242\320\265\321\201\321\202"
+test_commit_utf8_checkout_other "UTF-16LE"     "Test Тест" "\124\000\145\000\163\000\164\000\040\000\042\004\065\004\101\004\102\004"
+test_commit_utf8_checkout_other "UTF-16BE"     "Test Тест" "\000\124\000\145\000\163\000\164\000\040\004\042\004\065\004\101\004\102"
+test_commit_utf8_checkout_other "UTF-16LE-BOM" "Test Тест" "\377\376\124\000\145\000\163\000\164\000\040\000\042\004\065\004\101\004\102\004"
+test_commit_utf8_checkout_other "UTF-16BE-BOM" "Test Тест" "\376\377\000\124\000\145\000\163\000\164\000\040\004\042\004\065\004\101\004\102"
+test_commit_utf8_checkout_other "UTF-32LE"     "Test Тест" "\124\000\000\000\145\000\000\000\163\000\000\000\164\000\000\000\040\000\000\000\042\004\000\000\065\004\000\000\101\004\000\000\102\004\000\000"
+test_commit_utf8_checkout_other "UTF-32BE"     "Test Тест" "\000\000\000\124\000\000\000\145\000\000\000\163\000\000\000\164\000\000\000\040\000\000\004\042\000\000\004\065\000\000\004\101\000\000\004\102"
+
 test_done
-- 
gitgitgadget
