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
	by dcvr.yhbt.net (Postfix) with ESMTP id B36FF1F463
	for <e@80x24.org>; Mon, 23 Sep 2019 08:33:27 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2392596AbfIWId0 (ORCPT <rfc822;e@80x24.org>);
        Mon, 23 Sep 2019 04:33:26 -0400
Received: from mail-wr1-f68.google.com ([209.85.221.68]:43276 "EHLO
        mail-wr1-f68.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S2390680AbfIWIdZ (ORCPT <rfc822;git@vger.kernel.org>);
        Mon, 23 Sep 2019 04:33:25 -0400
Received: by mail-wr1-f68.google.com with SMTP id q17so12866560wrx.10
        for <git@vger.kernel.org>; Mon, 23 Sep 2019 01:33:23 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=date:message-id:in-reply-to:references:from:subject:fcc
         :content-transfer-encoding:mime-version:to:cc;
        bh=cqbjFdas5iAFxs9Qje7GsOGHGSNrZCQXW8lY5D5fQg4=;
        b=dNts3gIe30XlXyl4Prkf/kCvz9jGhUHhRpE4t+36K++VHWqOfYVRfGWKYaav8u+v7F
         BWrWQAystPtGFRhwxnpzS353KiJkL/ZVQCVmQhy0R9doNXyT2QPpUvirj7TXNC6ZzB/C
         skaJizYYzuhVtAcSjJ7lcfVm2WnHKrhw19ZDU8inT7O8b71xYdhkT3uEm15lIhdb0dzm
         spZg9AAIoWIUaIgeptt6I36p76dwQh+CRqxdfqGa+HBtAmKEZvP17Jqolm3jp90sHD59
         /Go1sGG8dWIVSPaUqkiza1Ml0QungHB+RV/xPqjB+Nm5u+Raelhc0DajSllHeE+aCGPN
         n03w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:message-id:in-reply-to:references:from
         :subject:fcc:content-transfer-encoding:mime-version:to:cc;
        bh=cqbjFdas5iAFxs9Qje7GsOGHGSNrZCQXW8lY5D5fQg4=;
        b=ti/YMjIZyNSgdls6qMJDuZo27RuC4cP9ZPMJXtno/cbJb69ISvdfEarVEN/vzpPqZ5
         sys2En95XzenN5GF4u8MEedDVm9iYNwMCt0SWe/3c4/xW3Q3XmRC9+TVGl7zQE/BKIWZ
         dXXmHVJZBkKSlvHW89TenBQ4xb6qt4JAmLjR2BGqoASpd6LEwzIzlrFTPZE6l8/zjbB1
         ugI89TW5IWB6Q/6ByvH/W2CgJqJDfxoPbS9Vas/sA8Zm++ho+D9Q8j47YNoezcbPGr7b
         mDhRibBfaVL3jZyLNDCT++QWd9eJZVqJdh/XRkNIVyBtvCrRXWSrKS4yIsLKYpK3XBup
         5hpA==
X-Gm-Message-State: APjAAAVZw8EcY2J+g76RiBGB2UBnobIrbUPg4GA1Jv+Uwfhr7U/osMtQ
        5v2PdZ+NA6EU45HXDCy9I9qoBcic
X-Google-Smtp-Source: APXvYqxqgJS7tfktj8LZ0z0urUoVscsVbxY1rOYZycQBnfVk7yw2wAqktdRDJmQar1mVasGRS4CyrA==
X-Received: by 2002:a5d:6302:: with SMTP id i2mr9549926wru.249.1569227603325;
        Mon, 23 Sep 2019 01:33:23 -0700 (PDT)
Received: from [127.0.0.1] ([13.74.141.28])
        by smtp.gmail.com with ESMTPSA id d9sm13508110wrf.62.2019.09.23.01.33.22
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Mon, 23 Sep 2019 01:33:22 -0700 (PDT)
Date:   Mon, 23 Sep 2019 01:33:22 -0700 (PDT)
X-Google-Original-Date: Mon, 23 Sep 2019 08:33:20 GMT
Message-Id: <fe850a8cd597e48bf023f7a3b025fe497f9d6153.1569227601.git.gitgitgadget@gmail.com>
In-Reply-To: <pull.347.git.gitgitgadget@gmail.com>
References: <pull.347.git.gitgitgadget@gmail.com>
From:   "Alexandr Miloslavskiy via GitGitGadget" <gitgitgadget@gmail.com>
Subject: [PATCH 1/2] t0028: fix test for UTF-16-LE-BOM
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

According to its name, the test its designed for UTF-16-LE-BOM.
However, possibly due to copy&paste oversight, it was using UTF-32 file.

While the test succeeds (probably interprets extra \x00\x00 as embedded
zero), I myself had an unrelated problem which caused the test to fail.
When analyzing the 	failure I was quite puzzled by the fact that the
test is obviously bugged. And it seems that I'm not alone:
https://public-inbox.org/git/CAH8yC8kSakS807d4jc_BtcUJOrcVT4No37AXSz=jePxhw-o9Dg@mail.gmail.com/T/#u

This fix changes the test to follow its original intention.

Signed-off-by: Alexandr Miloslavskiy <alexandr.miloslavskiy@syntevo.com>
---
 t/t0028-working-tree-encoding.sh | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/t/t0028-working-tree-encoding.sh b/t/t0028-working-tree-encoding.sh
index 1090e650ed..5493cf3ca9 100755
--- a/t/t0028-working-tree-encoding.sh
+++ b/t/t0028-working-tree-encoding.sh
@@ -40,7 +40,7 @@ test_expect_success 'setup test files' '
 	printf "$text" | write_utf16 >test.utf16.raw &&
 	printf "$text" | write_utf32 >test.utf32.raw &&
 	printf "\377\376"                         >test.utf16lebom.raw &&
-	printf "$text" | iconv -f UTF-8 -t UTF-32LE >>test.utf16lebom.raw &&
+	printf "$text" | iconv -f UTF-8 -t UTF-16LE >>test.utf16lebom.raw &&
 
 	# Line ending tests
 	printf "one\ntwo\nthree\n" >lf.utf8.raw &&
-- 
gitgitgadget

