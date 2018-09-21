Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.1 (2015-04-28) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-3.7 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,RCVD_IN_DNSWL_HI
	shortcircuit=no autolearn=ham autolearn_force=no version=3.4.1
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id ADE261F453
	for <e@80x24.org>; Fri, 21 Sep 2018 17:39:32 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2390960AbeIUX30 (ORCPT <rfc822;e@80x24.org>);
        Fri, 21 Sep 2018 19:29:26 -0400
Received: from mail-pl1-f196.google.com ([209.85.214.196]:34947 "EHLO
        mail-pl1-f196.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S2389545AbeIUX3Z (ORCPT <rfc822;git@vger.kernel.org>);
        Fri, 21 Sep 2018 19:29:25 -0400
Received: by mail-pl1-f196.google.com with SMTP id g2-v6so6267192plo.2
        for <git@vger.kernel.org>; Fri, 21 Sep 2018 10:39:30 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=date:message-id:in-reply-to:references:from:subject:fcc
         :content-transfer-encoding:mime-version:to:cc;
        bh=DIlKSMnygAmhqJbkFGN9kloLOOTraPA2YoTYIEIHZic=;
        b=T7BOP77yxqbO8IkY+mOJ6GHHYKLzDDzVPq+m32rV7I+PzaPCjXaSLi+K8CWOGIevz+
         03uWNACCyccis8HcFMvpp3fPpzwQ/lr026o0rZqKfaxbAAxkipromp6qC0eN6zsMRXdE
         /HIemhuOefb/E0bs9ze1/tCvrhFWu8U5W53VBG2c/Qn0BzS9hCmVg+psTexKCLRTZKeH
         PUJorGtrJ+SpG2QfddODDIO+P8AcU+kgXiR8VhHFz7VXH6BieV1J+0/q6DpbeUuhVv1l
         eC6RAPXYR/zkvF4zNjRg5FDYPbnUYV3yVnMGt2CtBiUbpsdF3IS5TUELKbPF/m5t3ks9
         ELgg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:message-id:in-reply-to:references:from
         :subject:fcc:content-transfer-encoding:mime-version:to:cc;
        bh=DIlKSMnygAmhqJbkFGN9kloLOOTraPA2YoTYIEIHZic=;
        b=GUr5oyYgvyNwcYWiiJZLIjMCEDCMzA58/CfqN3mkPqV5hggJ23SER8UJl+0+N/5H6e
         A9LZYwBTAfqTJlR5BqLmlpxF4BhsJTqkxhkf3FOcNmSZgp5L0uKVyzO6AcnTMyEZfXf7
         7bUd4SQ6qWsHmBtZY0VOleI4y/BTRpfZiD4j19iQ2DYHNQx314c2rpYynI9eGMYefeHM
         3uI51pBxhfYXqAD2dJwpz8QNyYB9CrFH6WxZJ2zfpZemCwmFT4chg5gCgeUYyyW1/1E7
         XVF/NqaPtcR4yz9tBVdEIfLSInGG/gMmIWnwYQVe3hExTu+Hgnqk6F0+Y3Tb2D9w1R9D
         WWpA==
X-Gm-Message-State: APzg51AfASyHMT8aSWUZR2mTnAeK4XexPpIVLAN7vyBqa+ijd34cuYZt
        9PS7Rffr5SJiwiHZaIenoGCJAdWe
X-Google-Smtp-Source: ANB0VdY+0nYv3ENjir2PlAVH4rsBMWqemMrzRL960ltsIRncVLFdWnQ6rmSsO/aOQL2L4iP6w0ARrA==
X-Received: by 2002:a17:902:ac86:: with SMTP id h6-v6mr8209308plr.103.1537551570061;
        Fri, 21 Sep 2018 10:39:30 -0700 (PDT)
Received: from [127.0.0.1] ([40.112.142.204])
        by smtp.gmail.com with ESMTPSA id j15-v6sm33175540pfn.52.2018.09.21.10.39.28
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Fri, 21 Sep 2018 10:39:29 -0700 (PDT)
Date:   Fri, 21 Sep 2018 10:39:29 -0700 (PDT)
X-Google-Original-Date: Fri, 21 Sep 2018 17:39:18 GMT
Message-Id: <b2a1ade148bc5ef175338ba116bd33b6b5e8d386.1537551564.git.gitgitgadget@gmail.com>
In-Reply-To: <pull.25.v3.git.gitgitgadget@gmail.com>
References: <pull.25.v2.git.gitgitgadget@gmail.com>
        <pull.25.v3.git.gitgitgadget@gmail.com>
From:   "Derrick Stolee via GitGitGadget" <gitgitgadget@gmail.com>
Subject: [PATCH v3 2/7] test-reach: add run_three_modes method
Fcc:    Sent
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
MIME-Version: 1.0
To:     git@vger.kernel.org
Cc:     peff@peff.net, Junio C Hamano <gitster@pobox.com>,
        Derrick Stolee <dstolee@microsoft.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

From: Derrick Stolee <dstolee@microsoft.com>

The 'test_three_modes' method assumes we are using the 'test-tool
reach' command for our test. However, we may want to use the data
shape of our commit graph and the three modes (no commit-graph,
full commit-graph, partial commit-graph) for other git commands.

Split test_three_modes to be a simple translation on a more general
run_three_modes method that executes the given command and tests
the actual output to the expected output.

Signed-off-by: Derrick Stolee <dstolee@microsoft.com>
---
 t/t6600-test-reach.sh | 12 ++++++++----
 1 file changed, 8 insertions(+), 4 deletions(-)

diff --git a/t/t6600-test-reach.sh b/t/t6600-test-reach.sh
index d139a00d1d..9d65b8b946 100755
--- a/t/t6600-test-reach.sh
+++ b/t/t6600-test-reach.sh
@@ -53,18 +53,22 @@ test_expect_success 'setup' '
 	git config core.commitGraph true
 '
 
-test_three_modes () {
+run_three_modes () {
 	test_when_finished rm -rf .git/objects/info/commit-graph &&
-	test-tool reach $1 <input >actual &&
+	"$@" <input >actual &&
 	test_cmp expect actual &&
 	cp commit-graph-full .git/objects/info/commit-graph &&
-	test-tool reach $1 <input >actual &&
+	"$@" <input >actual &&
 	test_cmp expect actual &&
 	cp commit-graph-half .git/objects/info/commit-graph &&
-	test-tool reach $1 <input >actual &&
+	"$@" <input >actual &&
 	test_cmp expect actual
 }
 
+test_three_modes () {
+	run_three_modes test-tool reach "$@"
+}
+
 test_expect_success 'ref_newer:miss' '
 	cat >input <<-\EOF &&
 	A:commit-5-7
-- 
gitgitgadget

