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
	by dcvr.yhbt.net (Postfix) with ESMTP id 932651F4C0
	for <e@80x24.org>; Wed, 16 Oct 2019 19:35:54 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2394326AbfJPTfx (ORCPT <rfc822;e@80x24.org>);
        Wed, 16 Oct 2019 15:35:53 -0400
Received: from mail-wr1-f48.google.com ([209.85.221.48]:45800 "EHLO
        mail-wr1-f48.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S2389320AbfJPTfx (ORCPT <rfc822;git@vger.kernel.org>);
        Wed, 16 Oct 2019 15:35:53 -0400
Received: by mail-wr1-f48.google.com with SMTP id r5so29329877wrm.12
        for <git@vger.kernel.org>; Wed, 16 Oct 2019 12:35:50 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=message-id:in-reply-to:references:from:date:subject:fcc
         :content-transfer-encoding:mime-version:to:cc;
        bh=yeuwwHy9bcnuUBgUQianHbQgmiIL+Vetw3rRVtZZqt0=;
        b=dUx3bMZFA3TbrYdfwd1tgFVjzbdir3kdOsw4VmAouG1PDRxL9nPhEiamP0JMS0IM3y
         nzIQTWgNlAZ7v3EzKSEp0M+VO/b4JBdqTEa6k4TvZIDX9sfLYY70xm4Dx7RIM2OJJLk3
         HnzUPFhP7ScRwsUSSKMFq/W7zeMi7FwZHZu8QND0TrjCQwYUY1DFdPBjhh9LPiTKJDWl
         Z5oO5xKcOcRw/Waran+3W2SwBdbkTXyTCjEne9O1lpf1LAoeEiKV8xGzbaSC+1AxsoqP
         bVHNfCI09AVpkAqC6kzSnzqAmqYl9RmtUAEL1fR+P2nEjjlRuy9kHKbDLkVfhQeLjODX
         Ochw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:message-id:in-reply-to:references:from:date
         :subject:fcc:content-transfer-encoding:mime-version:to:cc;
        bh=yeuwwHy9bcnuUBgUQianHbQgmiIL+Vetw3rRVtZZqt0=;
        b=HwRC5UlMKcPdycq7zf+53yfl2mzZ3HlfWE9I/UZAYzXM62V6vKmnJPJJLCo57SPGCp
         BcCUR30g+zF4UM+7LHr6Qymygw96uVrWf8p2i5G5legVBLrBF+i5S0PeePuaCA0Ogn1x
         fuk+sczibPlnVUUqvR16bR4ZXAq4O0RaOagjeos0uBUMNLEcFweUDz7fPhX5jexey8Oe
         h0orvusARdnplakK3aKWM91mQgYE2rtSIAJzwqHaaKJw0a784DFtPXoZ1fnNd19Zbc7b
         YZF2jaEXsKK+hbexyVnbQxZdYlyIYYuY1AWlWG3tLHJY4BpB1jDHnZTAuHvKge9PZ0Vi
         NftQ==
X-Gm-Message-State: APjAAAX6IB4EM04lRNN1RCeZFih07ndNhV/QQ/ZFKcvwQ4i2/0LVTZ2Y
        Tmt5DPFN1ShqnA02GQyE8f7W7aIR
X-Google-Smtp-Source: APXvYqwvz93DBCeRD0qvGzD39AVu+71exEbLkrX/89OCxeQ5mxmMwSc0+oCXHLXGbqInx/xguAdcng==
X-Received: by 2002:adf:f0cc:: with SMTP id x12mr4137583wro.326.1571254549762;
        Wed, 16 Oct 2019 12:35:49 -0700 (PDT)
Received: from [127.0.0.1] ([13.74.141.28])
        by smtp.gmail.com with ESMTPSA id b144sm3604366wmb.3.2019.10.16.12.35.49
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Wed, 16 Oct 2019 12:35:49 -0700 (PDT)
Message-Id: <85ca71fadaa7390a32218d3a5553c83d60c06a7f.1571254547.git.gitgitgadget@gmail.com>
In-Reply-To: <pull.404.git.1571254547.gitgitgadget@gmail.com>
References: <pull.404.git.1571254547.gitgitgadget@gmail.com>
From:   "William Baker via GitGitGadget" <gitgitgadget@gmail.com>
Date:   Wed, 16 Oct 2019 19:35:47 +0000
Subject: [PATCH 1/1] t7519-status-fsmonitor: improve comments
Fcc:    Sent
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
MIME-Version: 1.0
To:     git@vger.kernel.org
Cc:     williamtbakeremail@gmail.com, stolee@gmail.com,
        Johannes.Schindelin@gmx.de, jeffhost@microsoft.com,
        Junio C Hamano <gitster@pobox.com>,
        William Baker <William.Baker@microsoft.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

From: William Baker <William.Baker@microsoft.com>

The comments for the staging/unstaging test did not accurately
describe the scenario being tested.  It is not essential that
the test files being staged/unstaged appear at the end of the
index.  All that is required is that the test files are not
flagged with CE_FSMONITOR_VALID and have a position in the
index greater than the number of entries in the index after
unstaging.

The comment for this test has been updated to be more
accurate with respect to the scenario that's being tested.

Signed-off-by: William Baker <William.Baker@microsoft.com>
---
 t/t7519-status-fsmonitor.sh | 8 +++++---
 1 file changed, 5 insertions(+), 3 deletions(-)

diff --git a/t/t7519-status-fsmonitor.sh b/t/t7519-status-fsmonitor.sh
index d8df990972..997d5fb349 100755
--- a/t/t7519-status-fsmonitor.sh
+++ b/t/t7519-status-fsmonitor.sh
@@ -354,9 +354,11 @@ test_expect_success 'discard_index() also discards fsmonitor info' '
 	test_cmp expect actual
 '
 
-# Test staging/unstaging files that appear at the end of the index.  Test
-# file names begin with 'z' so that they are sorted to the end of the index.
-test_expect_success 'status succeeds after staging/unstaging ' '
+# Test unstaging entries that:
+#  - Are not flagged with CE_FSMONITOR_VALID
+#  - Have a position in the index >= the number of entries present in the index
+#    after unstaging.
+test_expect_success 'status succeeds after staging/unstaging' '
 	test_create_repo fsmonitor-stage-unstage &&
 	(
 		cd fsmonitor-stage-unstage &&
-- 
gitgitgadget
