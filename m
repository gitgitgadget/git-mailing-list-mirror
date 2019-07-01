Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.2 (2018-09-13) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-3.1 required=3.0 tests=AWL,BAYES_00,
	DKIM_ADSP_CUSTOM_MED,DKIM_INVALID,DKIM_SIGNED,
	FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,RCVD_IN_DNSWL_HI,SPF_HELO_NONE,SPF_NONE,URIBL_SBL,
	URIBL_SBL_A shortcircuit=no autolearn=ham autolearn_force=no
	version=3.4.2
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 667781F461
	for <e@80x24.org>; Mon,  1 Jul 2019 13:16:23 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728527AbfGANQW (ORCPT <rfc822;e@80x24.org>);
        Mon, 1 Jul 2019 09:16:22 -0400
Received: from mail-ed1-f66.google.com ([209.85.208.66]:37151 "EHLO
        mail-ed1-f66.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1728096AbfGANQV (ORCPT <rfc822;git@vger.kernel.org>);
        Mon, 1 Jul 2019 09:16:21 -0400
Received: by mail-ed1-f66.google.com with SMTP id w13so23519719eds.4
        for <git@vger.kernel.org>; Mon, 01 Jul 2019 06:16:20 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=date:message-id:in-reply-to:references:from:subject:fcc
         :content-transfer-encoding:mime-version:to:cc;
        bh=o/uovGRdUVU/yKFZJ6v4mAF4qJEd9UIHftHGNoGnrsQ=;
        b=qvJ5X2vnEJRoxiSeyfwfUu93uPqxeUdDfRtgDWBFqvfOjJK0/stWdMwQGVwqnAp4BD
         pVnYDjpqjpKkZkjCmr5o8BndU+oznb5qLha3/SnDnleWIMCFQVpfTZ2o43G5KQLg9uo8
         iW9LEq1qY+/a2twExkTs/jYzrvtBZXxSsPUXCxnCpS8jXA1tP/Mhn/N3w16BIKnzOz3E
         myeAZHUsRI8hRzoQZjg6qhC89w30uxljR8w/cNdeXLVhrE849WVyR0A8vCzK3Xw/5OXJ
         /MfXlxnhxNdYd3JVnrm7PxkCENztAKud995SPpw9V8iW146ZwaJTe5XEL9LuXTCa0EWE
         F2mg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:message-id:in-reply-to:references:from
         :subject:fcc:content-transfer-encoding:mime-version:to:cc;
        bh=o/uovGRdUVU/yKFZJ6v4mAF4qJEd9UIHftHGNoGnrsQ=;
        b=IOvSkTAc7e6YBl8wMTDm614zt0drTLNbSCK2mCENvKLJXAmBKYgo8b6EROh8bx5vSY
         HBKms0K3dIsUU5aDTSMVjhCfHUOqnJahiVS8EbXVt81myOTbugTvshVhEKUCFeGPpa6u
         P/vut34SNx3nRW+XSFSKNVhC0lKax7RszFBVayyIbB4PZ4zTOG3O6nk/mLxaams06bzi
         z0qypX0ICuqjtlGtgo0CQQdfVRP3GhPNFuWx+Nkv6dOfCuYVLZngLLsQ1274+wLNIf17
         qFEINMVSKebYK6CqdF3XOTssrf/pt7ENWFPCi4Zo9bxZpmqTQBleq/un/FqIOvhu28EM
         9eVw==
X-Gm-Message-State: APjAAAVQF2eYWojUaOFJtaWuBKw56L3Le1eD1IY9SLcGFi1SH5up4CDY
        q4kEu+YRBMaWpdXXG8KtKrLMO7LF
X-Google-Smtp-Source: APXvYqzm3IzqZir+QU6VexjOxrYkcSKdUqTDOMpKymFzcknH4bFddJbjhYaVmGEl2WEMEr+43bNPMA==
X-Received: by 2002:a17:906:eb93:: with SMTP id mh19mr22615539ejb.42.1561986980216;
        Mon, 01 Jul 2019 06:16:20 -0700 (PDT)
Received: from [127.0.0.1] ([13.74.141.28])
        by smtp.gmail.com with ESMTPSA id k3sm3439036edi.14.2019.07.01.06.16.19
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Mon, 01 Jul 2019 06:16:19 -0700 (PDT)
Date:   Mon, 01 Jul 2019 06:16:19 -0700 (PDT)
X-Google-Original-Date: Mon, 01 Jul 2019 13:16:18 GMT
Message-Id: <fec75453eb3e4c286f84c538c142c3da02f75826.1561986978.git.gitgitgadget@gmail.com>
In-Reply-To: <pull.280.git.gitgitgadget@gmail.com>
References: <pull.280.git.gitgitgadget@gmail.com>
From:   "Derrick Stolee via GitGitGadget" <gitgitgadget@gmail.com>
Subject: [PATCH 1/1] t5319: use 'test-tool path-utils' instead of 'ls -l'
Fcc:    Sent
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
MIME-Version: 1.0
To:     git@vger.kernel.org
Cc:     peff@peff.net, Johannes.Schindelin@gmx.de, j6t@kdbg.org,
        sunshine@sunshineco.com, szeder.dev@gmail.com,
        Junio C Hamano <gitster@pobox.com>,
        Derrick Stolee <dstolee@microsoft.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

From: Derrick Stolee <dstolee@microsoft.com>

Using 'ls -l' and parsing the columns to find file sizes is
problematic when the platform could report the owner as a name
with spaces. Instead, use the 'test-tool path-utils file-size'
command to list only the sizes.

Reported-by: Johannes Sixt <j6t@kdbg.org>
Helped-by: Johannes Schindelin <Johannes.Schindelin@gmx.de>
Signed-off-by: Derrick Stolee <dstolee@microsoft.com>
---
 t/t5319-multi-pack-index.sh | 4 ++--
 1 file changed, 2 insertions(+), 2 deletions(-)

diff --git a/t/t5319-multi-pack-index.sh b/t/t5319-multi-pack-index.sh
index 79bfaeafa9..c72ca04399 100755
--- a/t/t5319-multi-pack-index.sh
+++ b/t/t5319-multi-pack-index.sh
@@ -443,7 +443,7 @@ test_expect_success 'repack with minimum size does not alter existing packs' '
 		touch -m -t 201901010002 .git/objects/pack/pack-B* &&
 		touch -m -t 201901010003 .git/objects/pack/pack-A* &&
 		ls .git/objects/pack >expect &&
-		MINSIZE=$(ls -l .git/objects/pack/*pack | awk "{print \$5;}" | sort -n | head -n 1) &&
+		MINSIZE=$(test-tool path-utils file-size .git/objects/pack/*pack | sort -n | head -n 1) &&
 		git multi-pack-index repack --batch-size=$MINSIZE &&
 		ls .git/objects/pack >actual &&
 		test_cmp expect actual
@@ -455,7 +455,7 @@ test_expect_success 'repack creates a new pack' '
 		cd dup &&
 		ls .git/objects/pack/*idx >idx-list &&
 		test_line_count = 5 idx-list &&
-		THIRD_SMALLEST_SIZE=$(ls -l .git/objects/pack/*pack | awk "{print \$5;}" | sort -n | head -n 3 | tail -n 1) &&
+		THIRD_SMALLEST_SIZE=$(test-tool path-utils file-size .git/objects/pack/*pack | sort -n | head -n 3 | tail -n 1) &&
 		BATCH_SIZE=$(($THIRD_SMALLEST_SIZE + 1)) &&
 		git multi-pack-index repack --batch-size=$BATCH_SIZE &&
 		ls .git/objects/pack/*idx >idx-list &&
-- 
gitgitgadget
