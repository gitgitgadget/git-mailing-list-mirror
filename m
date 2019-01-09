Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.2 (2018-09-13) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-4.3 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,RCVD_IN_DNSWL_HI
	shortcircuit=no autolearn=ham autolearn_force=no version=3.4.2
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 0AEBD211B4
	for <e@80x24.org>; Wed,  9 Jan 2019 15:21:26 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1732269AbfAIPVZ (ORCPT <rfc822;e@80x24.org>);
        Wed, 9 Jan 2019 10:21:25 -0500
Received: from mail-wr1-f67.google.com ([209.85.221.67]:38965 "EHLO
        mail-wr1-f67.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1732258AbfAIPVV (ORCPT <rfc822;git@vger.kernel.org>);
        Wed, 9 Jan 2019 10:21:21 -0500
Received: by mail-wr1-f67.google.com with SMTP id t27so8051102wra.6
        for <git@vger.kernel.org>; Wed, 09 Jan 2019 07:21:20 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=date:message-id:in-reply-to:references:from:subject:fcc
         :content-transfer-encoding:mime-version:to:cc;
        bh=7nN4WtxexoRYPeBoe8vKx0sS2QFXL9I8dsli/Vvh5Hs=;
        b=eZya2QC4Je1BFEeQaAueBGD0pHKNeVsN/Q7ZDIxB1M1+paN+UM+FRkKYpQ3o8AfS4M
         rIcEn24jffA6pl0X4XX0VfUBCM1B99h/6HkxZ+FOVeWdeSzVLlWBwzwrGVgMwedntUyS
         HBRAZs02Fb/xnAffOXjDb8HFJfVZfLzIZgOoEukVopegL2QOY9Dh/5U8Q5NcDHBH3qHd
         jy3kozJFPKdkPptYw4IC/Ho22I2HgvGUNvQkuR+Tl5pWb8ETsPzF7Y14x2LHBzVtfcWr
         s5mrjag8FWB2NE6vropJmLSBot4jRfRncqf46sEL91UFxG8kgUEUICXU9LcbOykIALX1
         +C6Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:message-id:in-reply-to:references:from
         :subject:fcc:content-transfer-encoding:mime-version:to:cc;
        bh=7nN4WtxexoRYPeBoe8vKx0sS2QFXL9I8dsli/Vvh5Hs=;
        b=nNwA+TjrAUVBWzUHJlTidUKhrdanvcxvwT1GrjjSDBLjTHFNPyTE99RIH10c7v1aEW
         tGwYLr34yCn2HqfE4rAYIIx07u0aqtzDP/9Zfe79T3pP/aCFCLnw2w1U75e/4MsouBoi
         q/7/w26Yqxdr01X4Tr81wcK51uOG0dkrof6GO0yFogYp+urh9l+vqkrO40bl6THi/Qyj
         e3dePPYA+hzyxpDRX58+EwPwQk6ubDhTWt18fvyD5YepgTo7JclDgv6knUBR9qZ0Uimj
         nSRiNR7wJ1p6wCxjpGO92QSZiYSk7rlkfC80svW8D3XSU05UrTwACFBqCDsTZObYdD+M
         1sLg==
X-Gm-Message-State: AJcUukepX592BYpuZCH1ryuWN0Q8Td6fGl3QFqk1sGOJ62jqZlxrtDsC
        RIuQndymdpA1WELmDN8So+5wGi9G
X-Google-Smtp-Source: ALg8bN51Q+J/j3nr11OmKSH6bGnFbs9hEaAQib5fzs0UJ9mxfAhyIC7hOIlxWQfMTwT2Ehqqs25vvA==
X-Received: by 2002:adf:84e4:: with SMTP id 91mr5401635wrg.237.1547047279882;
        Wed, 09 Jan 2019 07:21:19 -0800 (PST)
Received: from [127.0.0.1] ([13.74.141.28])
        by smtp.gmail.com with ESMTPSA id x15sm54393116wrs.27.2019.01.09.07.21.19
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Wed, 09 Jan 2019 07:21:19 -0800 (PST)
Date:   Wed, 09 Jan 2019 07:21:19 -0800 (PST)
X-Google-Original-Date: Wed, 09 Jan 2019 15:21:09 GMT
Message-Id: <b97fb35ba995a3688cbac752ded2bd785188edfb.1547047269.git.gitgitgadget@gmail.com>
In-Reply-To: <pull.92.v3.git.gitgitgadget@gmail.com>
References: <pull.92.v2.git.gitgitgadget@gmail.com>
        <pull.92.v3.git.gitgitgadget@gmail.com>
From:   "Derrick Stolee via GitGitGadget" <gitgitgadget@gmail.com>
Subject: [PATCH v3 9/9] multi-pack-index: test expire while adding packs
Fcc:    Sent
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
MIME-Version: 1.0
To:     git@vger.kernel.org
Cc:     sbeller@google.com, peff@peff.net, jrnieder@gmail.com,
        avarab@gmail.com, Junio C Hamano <gitster@pobox.com>,
        Derrick Stolee <dstolee@microsoft.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

From: Derrick Stolee <dstolee@microsoft.com>

During development of the multi-pack-index expire subcommand, a
version went out that improperly computed the pack order if a new
pack was introduced while other packs were being removed. Part of
the subtlety of the bug involved the new pack being placed before
other packs that already existed in the multi-pack-index.

Add a test to t5319-multi-pack-index.sh that catches this issue.
The test adds new packs that cause another pack to be expired, and
creates new packs that are lexicographically sorted before and
after the existing packs.

Signed-off-by: Derrick Stolee <dstolee@microsoft.com>
---
 t/t5319-multi-pack-index.sh | 32 ++++++++++++++++++++++++++++++++
 1 file changed, 32 insertions(+)

diff --git a/t/t5319-multi-pack-index.sh b/t/t5319-multi-pack-index.sh
index 99afb5ec51..1213549d25 100755
--- a/t/t5319-multi-pack-index.sh
+++ b/t/t5319-multi-pack-index.sh
@@ -449,4 +449,36 @@ test_expect_success 'expire removes repacked packs' '
 	)
 '
 
+test_expect_success 'expire works when adding new packs' '
+	(
+		cd dup &&
+		git pack-objects --revs .git/objects/pack/pack-combined <<-EOF &&
+		refs/heads/A
+		^refs/heads/B
+		EOF
+		git pack-objects --revs .git/objects/pack/pack-combined <<-EOF &&
+		refs/heads/B
+		^refs/heads/C
+		EOF
+		git pack-objects --revs .git/objects/pack/pack-combined <<-EOF &&
+		refs/heads/C
+		^refs/heads/D
+		EOF
+		git multi-pack-index write &&
+		git pack-objects --revs .git/objects/pack/a-pack <<-EOF &&
+		refs/heads/D
+		^refs/heads/E
+		EOF
+		git multi-pack-index write &&
+		git pack-objects --revs .git/objects/pack/z-pack <<-EOF &&
+		refs/heads/E
+		EOF
+		git multi-pack-index expire &&
+		ls .git/objects/pack/ | grep idx >expect &&
+		test-tool read-midx .git/objects | grep idx >actual &&
+		test_cmp expect actual &&
+		git multi-pack-index verify
+	)
+'
+
 test_done
-- 
gitgitgadget
