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
	by dcvr.yhbt.net (Postfix) with ESMTP id 6EB741F463
	for <e@80x24.org>; Mon, 23 Sep 2019 08:33:28 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2404845AbfIWId1 (ORCPT <rfc822;e@80x24.org>);
        Mon, 23 Sep 2019 04:33:27 -0400
Received: from mail-wm1-f65.google.com ([209.85.128.65]:33164 "EHLO
        mail-wm1-f65.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S2391785AbfIWId0 (ORCPT <rfc822;git@vger.kernel.org>);
        Mon, 23 Sep 2019 04:33:26 -0400
Received: by mail-wm1-f65.google.com with SMTP id r17so14416359wme.0
        for <git@vger.kernel.org>; Mon, 23 Sep 2019 01:33:24 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=date:message-id:in-reply-to:references:from:subject:fcc
         :content-transfer-encoding:mime-version:to:cc;
        bh=stbWo9RCfPeujJ9kOQ2CfIq+snWvntoSqePPwb6tozo=;
        b=ZUKD6ZtLimrzgmN/FJHXcvZUBKrm23A5/lEsMPV7KUYPKVFkfNzcTX28iVGFcnbZ9d
         UG0zn9Jo5KW6C9CLFGa2GDI2fT9Px1w4XC6915MuTarFljENzowkeKuU8RJuSzG9JGFU
         EWApaEZ5iQSSf4ZGULaWEjehcOeSaw9g1I4bqOo85S5vvUM8hQC0Yzi7KBkz60ynLmh6
         7SPpaey+KlNeDSO9ZZc2rM4+IMehw9WjzmeOHjyTL71WvdKDbsxO3NLM1PNpKEykprH/
         +r+2SFDDyi0+pjqOkAKeccI7WVFnxrnMfZ+GHk+U4TI4zmF8rtq3pduOXNMD6dWZy0U6
         UoZA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:message-id:in-reply-to:references:from
         :subject:fcc:content-transfer-encoding:mime-version:to:cc;
        bh=stbWo9RCfPeujJ9kOQ2CfIq+snWvntoSqePPwb6tozo=;
        b=lICoauCN+q/XAw9Q9+I7ozWj5MvUTr7/asVtXBYmq9g7F3a9AD1qcNwFZ/ZH4iW01P
         LUf7wV53kWL2zjSGNkHp4EyclQonAnpCkZXwdCZYrkjrdXqfFSSHHTbeaL+n1qKYWbiV
         ATt5X/P1JNFrOxh7mOfeA51/yCSa298xBxl+6CGKqPN7cDSgX3YtXbqJun5l77JUZ0RG
         ++HbwaRRKfqgi4iZmBQd+10xUFStYORrLe/jOWA0qAJnovnI8sLJG8cDOUCSEh4nlx29
         nTmbQ2uTiAfRuM8nykk6ZPxXsOVdWiQgtqZjg/Q3krKr9qE03MVwgQbebRs78Wah7YnO
         10RQ==
X-Gm-Message-State: APjAAAWP2jfpfEQlkU7gTsnINgaHJiJ5XW1Lapb17zu95jQilWk3wlSm
        vJQvlGSHCPLhSy77xmMD20eZvrI/
X-Google-Smtp-Source: APXvYqwHJtK/vFC3ewkmBFiogMAP3TQYnOp6fdSKswLsKEfL3C7zjlNXPjZDUdw88UiuXlra228hWQ==
X-Received: by 2002:a1c:a942:: with SMTP id s63mr12782440wme.152.1569227603957;
        Mon, 23 Sep 2019 01:33:23 -0700 (PDT)
Received: from [127.0.0.1] ([13.74.141.28])
        by smtp.gmail.com with ESMTPSA id g73sm16214617wme.10.2019.09.23.01.33.23
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Mon, 23 Sep 2019 01:33:23 -0700 (PDT)
Date:   Mon, 23 Sep 2019 01:33:23 -0700 (PDT)
X-Google-Original-Date: Mon, 23 Sep 2019 08:33:21 GMT
Message-Id: <d5f6f00a516180d9ae4a0ed1cceecec8ef1b6b88.1569227601.git.gitgitgadget@gmail.com>
In-Reply-To: <pull.347.git.gitgitgadget@gmail.com>
References: <pull.347.git.gitgitgadget@gmail.com>
From:   "Alexandr Miloslavskiy via GitGitGadget" <gitgitgadget@gmail.com>
Subject: [PATCH 2/2] t0028: add more tests
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
