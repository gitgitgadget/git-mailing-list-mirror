Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.1 (2015-04-28) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-3.8 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,RCVD_IN_DNSWL_HI
	shortcircuit=no autolearn=ham autolearn_force=no version=3.4.1
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 0E3B91F404
	for <e@80x24.org>; Tue, 11 Sep 2018 20:21:10 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727441AbeILBWF (ORCPT <rfc822;e@80x24.org>);
        Tue, 11 Sep 2018 21:22:05 -0400
Received: from mail-pf1-f176.google.com ([209.85.210.176]:38664 "EHLO
        mail-pf1-f176.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726850AbeILBWE (ORCPT <rfc822;git@vger.kernel.org>);
        Tue, 11 Sep 2018 21:22:04 -0400
Received: by mail-pf1-f176.google.com with SMTP id x17-v6so12786108pfh.5
        for <git@vger.kernel.org>; Tue, 11 Sep 2018 13:21:08 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=date:message-id:in-reply-to:references:from:subject:fcc
         :content-transfer-encoding:mime-version:to:cc;
        bh=5AK3r4V2RGs4FVs0/N2OeXCpH9rLcNj66csHNJ2y8pM=;
        b=N5QPF1DoBKNlZOtEb8wuj4QwG0QOW9SvPZppTFEj8ok46NXzegBl6NvHB3rtWaYCuf
         H7Q28mxXuFJS5g6fmK47vomr1nt13kqUI5YLMvkAWUEmY/nlpqZt+HE1M0IZ936aIJWl
         32Ubu3WxtJHocVwE/eXWccvUU21bAmJlS0jFjhzeV8Xs3OxtIMwmpBGn4+2itG/5D3Vt
         vKiXMRSBsfY1ZHDhzvwujfE7jPxFdYptaT7xfhvw7zK54lS9XY8gw6j6H0bdHRLAHGbJ
         mOApj1+HDKw3wEkXdBPkJI3aB0gGii2JLQvbYsf4p2tZK218aPD9ec73Vq7sWisxXQ8h
         tVZw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:message-id:in-reply-to:references:from
         :subject:fcc:content-transfer-encoding:mime-version:to:cc;
        bh=5AK3r4V2RGs4FVs0/N2OeXCpH9rLcNj66csHNJ2y8pM=;
        b=Ctq4k9dEwHa9FFDDAebYW6gaGE/Y8MwJhJarbvCIJoaY6s1tCReVGrGXTc0MkJJRnK
         g1HbC23nFZpxxLyq4mMQK+y9dTKAzd9c+Eb/Z1yn55wDM+fwtuFWPUxO8+0RFIAvvwTl
         KFSKiS9O6qfe2lUoXL0aoniVG9FAv2+HR1202UY2Ac23CY00Z0fTJSJj5hNLWzM+lcGV
         vD7EQmVfGEhqg8Ad3cjwNlIeNrNJbjV/UGBst8rGQ/t8+MUbcc0bUU4s6TdWuYwv2UA/
         1LcmvygJP4/6OViAlHgdyHr8vSUy3EGeMkyNPXNpL1j8tE3cNZwbcxLq/IQXFxp/GoKL
         aRWg==
X-Gm-Message-State: APzg51Bd87dATSz0A1SZ/FaV1LaPufO7opuFim10l8/NGJ985zKaDwZN
        J9PQzcIuGJstUneXcHqVPJ2k+a0K
X-Google-Smtp-Source: ANB0VdbhixRdW0hiIrr/OE7NpT2YEAkv1iQsL2Dv2D4P+l5fAuYx2lA8q2D9+kJJhzmQtEOJn1H6hA==
X-Received: by 2002:a62:8704:: with SMTP id i4-v6mr31166964pfe.62.1536697267523;
        Tue, 11 Sep 2018 13:21:07 -0700 (PDT)
Received: from [127.0.0.1] ([40.112.142.204])
        by smtp.gmail.com with ESMTPSA id f87-v6sm52416041pfh.168.2018.09.11.13.21.05
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Tue, 11 Sep 2018 13:21:06 -0700 (PDT)
Date:   Tue, 11 Sep 2018 13:21:06 -0700 (PDT)
X-Google-Original-Date: Tue, 11 Sep 2018 20:21:02 GMT
Message-Id: <58347a962438852be0d37c3957686ea5000b2dbd.1536697263.git.gitgitgadget@gmail.com>
In-Reply-To: <pull.37.git.gitgitgadget@gmail.com>
References: <pull.37.git.gitgitgadget@gmail.com>
From:   "Derrick Stolee via GitGitGadget" <gitgitgadget@gmail.com>
Subject: [PATCH 1/1] t3206-range-diff.sh: cover single-patch case
Fcc:    Sent
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
MIME-Version: 1.0
To:     git@vger.kernel.org
Cc:     Junio C Hamano <gitster@pobox.com>,
        Derrick Stolee <dstolee@microsoft.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

From: Derrick Stolee <dstolee@microsoft.com>

The commit 40ce4160 "format-patch: allow --range-diff to apply to
a lone-patch" added the ability to see a range-diff as commentary
after the commit message of a single patch series (i.e. [PATCH]
instead of [PATCH X/N]). However, this functionality was not
covered by a test case.

Add a simple test case that checks that a range-diff is written as
commentary to the patch.

Signed-off-by: Derrick Stolee <dstolee@microsoft.com>
---
 t/t3206-range-diff.sh | 5 +++++
 1 file changed, 5 insertions(+)

diff --git a/t/t3206-range-diff.sh b/t/t3206-range-diff.sh
index 3d7a2d8a4d..05ef3263d2 100755
--- a/t/t3206-range-diff.sh
+++ b/t/t3206-range-diff.sh
@@ -154,4 +154,9 @@ do
 	'
 done
 
+test_expect_success 'format-patch --range-diff as commentary' '
+	git format-patch --stdout --range-diff=HEAD~1 HEAD~1 >actual &&
+	grep -A 1 -e "\-\-\-" actual | grep "Range-diff:"
+'
+
 test_done
-- 
gitgitgadget
