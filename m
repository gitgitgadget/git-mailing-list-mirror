Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.1 (2015-04-28) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-3.8 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,RCVD_IN_DNSWL_HI
	shortcircuit=no autolearn=ham autolearn_force=no version=3.4.1
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id A8BD51F404
	for <e@80x24.org>; Mon, 27 Aug 2018 20:41:27 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727433AbeH1A3i (ORCPT <rfc822;e@80x24.org>);
        Mon, 27 Aug 2018 20:29:38 -0400
Received: from mail-pf1-f194.google.com ([209.85.210.194]:45765 "EHLO
        mail-pf1-f194.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726994AbeH1A3i (ORCPT <rfc822;git@vger.kernel.org>);
        Mon, 27 Aug 2018 20:29:38 -0400
Received: by mail-pf1-f194.google.com with SMTP id i26-v6so106382pfo.12
        for <git@vger.kernel.org>; Mon, 27 Aug 2018 13:41:25 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=date:message-id:in-reply-to:references:from:subject:fcc
         :content-transfer-encoding:mime-version:to:cc;
        bh=QcshJYbErKPtRZt/cFP+z4bKvfLxODsQO0mhl0dPlSA=;
        b=osSqDoi1+sJFoNqhJBMqF2HtRbn7AH6r0V7mrrr1+5MtDs+HGhUaqqOf0myuAVX1AI
         dWIrrspaDEIcdPCvB6WDnTUVXvqr0YCToyLj5WfB9SoXGDq9Hk2zHI3dQX9xWDUou8JW
         PdbOjN2Zfur+c5fNRwUhpOFQt/kmEH4MkIB594peWnSE2BY6tIITCzmGHYHBQ7PJT16A
         7xIh6j6Bi/kXfyKlva4fcnIcvQhCJG0XNe/8L2q7kIReuFcl5crzqSuc1Y3lyTsmZugy
         Qkw+1flAK3wFuR1klfHbqmA3gS2fluY9O4jw+r5V/0yXYaAerWLZQ1MjDNbusCdbvgFK
         QkVQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:message-id:in-reply-to:references:from
         :subject:fcc:content-transfer-encoding:mime-version:to:cc;
        bh=QcshJYbErKPtRZt/cFP+z4bKvfLxODsQO0mhl0dPlSA=;
        b=B/qZcqqzeZvEL7pQXV/8A3RpTGdEz+rWuF/7T13RorK5eJR5SYpgjr5IoN4pUuBhN3
         BWVpGDGr52SqDEb7t84RoJXHlUObJvVy55CrnXfJyA0QvNyWv/prMRLFUgOMwWxle9oZ
         1yvpqBj+9Mq8OHsLHSV4XcE3VFaYov9KruOcVXvOABjPYEIF7TEXZtW7HsEH7VXtLQqs
         6iE76XE2E4kEUKy77OXonf84psUpMryd/akz8ifuKa/Unsgfs/ZugdF/wSTX56lf5xGu
         bLvk9NuR9mIPCq6LC9cAMibIQ/ZZRfH8nIcc0OnP8BZp3yCjuYXnNrjF23Jrgd/nJE2P
         Pr2w==
X-Gm-Message-State: APzg51B9XoSwx85nbuDSEdchAHMw9pAiOtFU7Iq01MGWEe3drAmeJftE
        tzPX46lrGsTpTsrkRPaeCKEERzvC
X-Google-Smtp-Source: ANB0VdZToXKbaSkLWhKP3iKoi5GAV/JEm/4kfzP98bIl5dGc7qfs3RMAJvTllUwZjsO4Dmmj4aIkAw==
X-Received: by 2002:a62:5543:: with SMTP id j64-v6mr15679036pfb.188.1535402485160;
        Mon, 27 Aug 2018 13:41:25 -0700 (PDT)
Received: from [127.0.0.1] ([40.112.142.204])
        by smtp.gmail.com with ESMTPSA id k5-v6sm313272pfj.30.2018.08.27.13.41.24
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Mon, 27 Aug 2018 13:41:24 -0700 (PDT)
Date:   Mon, 27 Aug 2018 13:41:24 -0700 (PDT)
X-Google-Original-Date: Mon, 27 Aug 2018 20:41:15 GMT
Message-Id: <9628396af1d3ba24c6c13c57b4aa6e0c659a324c.1535402479.git.gitgitgadget@gmail.com>
In-Reply-To: <pull.25.git.gitgitgadget@gmail.com>
References: <pull.25.git.gitgitgadget@gmail.com>
From:   "Derrick Stolee via GitGitGadget" <gitgitgadget@gmail.com>
Subject: [PATCH 2/6] test-reach: add run_three_modes method
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

The 'test_three_modes' method assumes we are using the 'test-tool
reach' command for our test. However, we may want to use the data
shape of our commit graph and the three modes (no commit-graph,
full commit-graph, partial commit-graph) for other git commands.

Split test_three_modes to be a simple translation on a more general
run_three_modes method that executes the given command and tests
the actual output to the expected output.

While inspecting this code, I realized that the final test for
'commit_contains --tag' is silently dropping the '--tag' argument.
It should be quoted to include both.

Signed-off-by: Derrick Stolee <dstolee@microsoft.com>
---
 t/t6600-test-reach.sh | 14 +++++++++-----
 1 file changed, 9 insertions(+), 5 deletions(-)

diff --git a/t/t6600-test-reach.sh b/t/t6600-test-reach.sh
index d139a00d1d..1b18e12a4e 100755
--- a/t/t6600-test-reach.sh
+++ b/t/t6600-test-reach.sh
@@ -53,18 +53,22 @@ test_expect_success 'setup' '
 	git config core.commitGraph true
 '
 
-test_three_modes () {
+run_three_modes () {
 	test_when_finished rm -rf .git/objects/info/commit-graph &&
-	test-tool reach $1 <input >actual &&
+	$1 <input >actual &&
 	test_cmp expect actual &&
 	cp commit-graph-full .git/objects/info/commit-graph &&
-	test-tool reach $1 <input >actual &&
+	$1 <input >actual &&
 	test_cmp expect actual &&
 	cp commit-graph-half .git/objects/info/commit-graph &&
-	test-tool reach $1 <input >actual &&
+	$1 <input >actual &&
 	test_cmp expect actual
 }
 
+test_three_modes () {
+	run_three_modes "test-tool reach $1"
+}
+
 test_expect_success 'ref_newer:miss' '
 	cat >input <<-\EOF &&
 	A:commit-5-7
@@ -219,7 +223,7 @@ test_expect_success 'commit_contains:hit' '
 	EOF
 	echo "commit_contains(_,A,X,_):1" >expect &&
 	test_three_modes commit_contains &&
-	test_three_modes commit_contains --tag
+	test_three_modes "commit_contains --tag"
 '
 
 test_expect_success 'commit_contains:miss' '
-- 
gitgitgadget

