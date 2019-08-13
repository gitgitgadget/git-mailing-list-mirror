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
	by dcvr.yhbt.net (Postfix) with ESMTP id 533B41F45A
	for <e@80x24.org>; Tue, 13 Aug 2019 18:37:48 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728412AbfHMShr (ORCPT <rfc822;e@80x24.org>);
        Tue, 13 Aug 2019 14:37:47 -0400
Received: from mail-wr1-f66.google.com ([209.85.221.66]:40047 "EHLO
        mail-wr1-f66.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1728363AbfHMShr (ORCPT <rfc822;git@vger.kernel.org>);
        Tue, 13 Aug 2019 14:37:47 -0400
Received: by mail-wr1-f66.google.com with SMTP id c3so426878wrd.7
        for <git@vger.kernel.org>; Tue, 13 Aug 2019 11:37:46 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=date:message-id:in-reply-to:references:from:subject:fcc
         :content-transfer-encoding:mime-version:to:cc;
        bh=krnDBHf0EbEvKLRiZYau2yMUcmmqV5IofU0yXyWONxA=;
        b=k4hDEdWgxzRat3u4dRDIcrfIGInYsO2atHmBGuSrO/z6ExMr2MlRbBSUeDETZG4EHh
         PVBaCCWJG+QK3Oy0UOc1nhe5w8zQB1RvYjaylu2pXH1Sjcjc2Z7fSSNUwKLXzottZlmC
         QsggYlQx4ih3m3nkuV9Vx51+Sm7ovU7n4cHvUZWfyV2+bR5+TRjLAFrxGx+hT67NPZeC
         fGOESZuzFRPWcxZg+VYC0iiY+54mepkcgCy5Mbs//ltAT1iJH0pvFIHB0lz+pnJqQNpm
         a6tflVFWN9jkTwMP9MQqPQlsD5LrGgi86YJI3Y1PnwFeq6TUpmWfER4r61eL7MtXzcXU
         e7ow==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:message-id:in-reply-to:references:from
         :subject:fcc:content-transfer-encoding:mime-version:to:cc;
        bh=krnDBHf0EbEvKLRiZYau2yMUcmmqV5IofU0yXyWONxA=;
        b=E3jqTlnvulNCzYa70mAFn2BZJEUMnRoJvvji9+eKMr3w/iCcZziR37yur9DgrVHx1H
         Mf23zF7TozZImeEmGiNVvgdf+YRE1vzYnkdIdhgP7mPNFCSY5M7rEtUHXhFfWrIBo8nP
         dhFT7BEmgDNOiJouBtihNiFUKeuDHjfg+Xzzn1vw1ft0R6kzD8Gja4S4B+ja53ImfFGn
         nx6H8/O6kE+KiqwtKW/1VJq97UwsGNrMEbeaaCM+/BiPqpMnE8fjj/Xyjfkd30rge/zM
         16ugUsP2yGhbiG5cHna7mxal2b+64NZi16L0G5I7cJeBN6XpRKamNKx7lffT+mb80/Mb
         piIw==
X-Gm-Message-State: APjAAAVdEkWf51FwpWDTYSJ6FJjX9XXolhbEeeZ/FJwH57R+MQVw7J7b
        QVkAE/7uHT00126S4QanItBxpFW9
X-Google-Smtp-Source: APXvYqx7sjjMEwcRBzDEz5oKyBC85tBH8etW3IOm7UFgKU6WpAxugUKSl7HXHYhO3Di8e8yh62PMiw==
X-Received: by 2002:adf:dec8:: with SMTP id i8mr6521075wrn.217.1565721465472;
        Tue, 13 Aug 2019 11:37:45 -0700 (PDT)
Received: from [127.0.0.1] ([13.74.141.28])
        by smtp.gmail.com with ESMTPSA id g2sm3739820wru.27.2019.08.13.11.37.44
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Tue, 13 Aug 2019 11:37:45 -0700 (PDT)
Date:   Tue, 13 Aug 2019 11:37:45 -0700 (PDT)
X-Google-Original-Date: Tue, 13 Aug 2019 18:37:37 GMT
Message-Id: <6bf3584a60aea5dac84c50674e0a1db01116f920.1565721461.git.gitgitgadget@gmail.com>
In-Reply-To: <pull.292.v4.git.gitgitgadget@gmail.com>
References: <pull.292.v3.git.gitgitgadget@gmail.com>
        <pull.292.v4.git.gitgitgadget@gmail.com>
From:   "Derrick Stolee via GitGitGadget" <gitgitgadget@gmail.com>
Subject: [PATCH v4 2/6] t6501: use 'git gc' in quiet mode
Fcc:    Sent
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
MIME-Version: 1.0
To:     git@vger.kernel.org
Cc:     Johannes.Schindelin@gmx.de, peff@peff.net, jnareb@gmail.com,
        pclouds@gmail.com, carenas@gmail.com, avarab@gmail.com,
        Junio C Hamano <gitster@pobox.com>,
        Derrick Stolee <dstolee@microsoft.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

From: Derrick Stolee <dstolee@microsoft.com>

t6501-freshen-objects.sh sends the standard error from
'git gc' to a file and verifies that it is empty. This
is intended as a way to ensure no warnings are written
during the operation. However, as the commit-graph is
added as a step to 'git gc', its progress will appear
in the output.

Pass the '-q' argument to avoid a failing test case
when progress is written.

Signed-off-by: Derrick Stolee <dstolee@microsoft.com>
---
 t/t6501-freshen-objects.sh | 6 +++---
 1 file changed, 3 insertions(+), 3 deletions(-)

diff --git a/t/t6501-freshen-objects.sh b/t/t6501-freshen-objects.sh
index 033871ee5f..f30b4849b6 100755
--- a/t/t6501-freshen-objects.sh
+++ b/t/t6501-freshen-objects.sh
@@ -137,7 +137,7 @@ test_expect_success 'do not complain about existing broken links (commit)' '
 	some message
 	EOF
 	commit=$(git hash-object -t commit -w broken-commit) &&
-	git gc 2>stderr &&
+	git gc -q 2>stderr &&
 	verbose git cat-file -e $commit &&
 	test_must_be_empty stderr
 '
@@ -147,7 +147,7 @@ test_expect_success 'do not complain about existing broken links (tree)' '
 	100644 blob 0000000000000000000000000000000000000003	foo
 	EOF
 	tree=$(git mktree --missing <broken-tree) &&
-	git gc 2>stderr &&
+	git gc -q 2>stderr &&
 	git cat-file -e $tree &&
 	test_must_be_empty stderr
 '
@@ -162,7 +162,7 @@ test_expect_success 'do not complain about existing broken links (tag)' '
 	this is a broken tag
 	EOF
 	tag=$(git hash-object -t tag -w broken-tag) &&
-	git gc 2>stderr &&
+	git gc -q 2>stderr &&
 	git cat-file -e $tag &&
 	test_must_be_empty stderr
 '
-- 
gitgitgadget

