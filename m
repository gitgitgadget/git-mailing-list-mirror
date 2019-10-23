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
	by dcvr.yhbt.net (Postfix) with ESMTP id 9B7DE1F4C1
	for <e@80x24.org>; Wed, 23 Oct 2019 13:01:40 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2404476AbfJWNBk (ORCPT <rfc822;e@80x24.org>);
        Wed, 23 Oct 2019 09:01:40 -0400
Received: from mail-wr1-f68.google.com ([209.85.221.68]:36656 "EHLO
        mail-wr1-f68.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S2390642AbfJWNBj (ORCPT <rfc822;git@vger.kernel.org>);
        Wed, 23 Oct 2019 09:01:39 -0400
Received: by mail-wr1-f68.google.com with SMTP id w18so21457144wrt.3
        for <git@vger.kernel.org>; Wed, 23 Oct 2019 06:01:38 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=message-id:in-reply-to:references:from:date:subject:mime-version
         :content-transfer-encoding:fcc:to:cc;
        bh=kIoKI9i6M1MKBz1vzvr/UHwuMgGANw7yPGcx+8fiUgI=;
        b=AxKKnVWKKkSFl79gX4uFVG5Z+CxB9+gLFtR+USjwQHVfB8zdUe3AQYcHJb/KamqEdQ
         TBC33ZFoNYyiFgo1JM6JzbyPgaMyJm4Wz8NxiiI0vJyyOYB5x0i/QaimvXG+4yWyvJJT
         qkUrtLTCIUVRseht9TxARefelS1P3KeyFpsoezsXvxvUbNw0c+m1xjpGyQNMv229JQ80
         15cnXsBNpWhLHf5CruGUFNej4zw8/ELsUDa8CRITKR0LATHV1FawbhuimOouw/H29USE
         b4PFLaorxOujFcskrXlJLMBg6fbgPPBZH2G13GTM8iVK2IGwvWE7ybYyMzG9JQ9Dfjlv
         0/7g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:message-id:in-reply-to:references:from:date
         :subject:mime-version:content-transfer-encoding:fcc:to:cc;
        bh=kIoKI9i6M1MKBz1vzvr/UHwuMgGANw7yPGcx+8fiUgI=;
        b=t+w45p0oaeKV1O1ArsSWZz7XPeIrQPO+nuM8464PMDTzEW8auGCeoPRcjA/1xdvteQ
         Yvs99AEHSYJERudJi9ERBRVOcJK3Y9sb0rXlNSzqo9Q2xiJ+vjmZwgJ76Axz5/RwUoeJ
         3enylm699EoCXKWDp0xOEJxKV2ZgTpwpeN7KUr3bjWJXmc/tooNs/p2c01N0ngteo0+0
         vN9XgFTdBGufXurzD4S7EfKbRz/IOZTmG8QxySLAmaK4YMgRzWAAjdJOLfJ/eO2X+z4r
         18VFJsV/+MgTOl7Akk9/jnVoF9/yOmssoKRygqD6MROjhFl18c93yNWLnHb+LZe5mE9J
         acbg==
X-Gm-Message-State: APjAAAXVH4ETI3U4wybLPTLbwn+mz4UcJqv1FdxMpefDHGgOD3HirE9I
        F3lSLteTkCu/TpYHzbQRFYiALIK2
X-Google-Smtp-Source: APXvYqyu0OgxD/l8QAXwDK1d5Vxrh8PVBP2FMcCNudUs/GSdjS3X8geyOtW2Q6nfCVPX9f1jSzUlTg==
X-Received: by 2002:adf:f4ca:: with SMTP id h10mr6528880wrp.166.1571835697231;
        Wed, 23 Oct 2019 06:01:37 -0700 (PDT)
Received: from [127.0.0.1] ([13.74.141.28])
        by smtp.gmail.com with ESMTPSA id e3sm19761251wme.39.2019.10.23.06.01.36
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Wed, 23 Oct 2019 06:01:36 -0700 (PDT)
Message-Id: <6ac0a05746df8ac3b1dd788f525b2620bc4d9a08.1571835695.git.gitgitgadget@gmail.com>
In-Reply-To: <pull.415.v2.git.1571835695.gitgitgadget@gmail.com>
References: <pull.415.git.1571765335.gitgitgadget@gmail.com>
        <pull.415.v2.git.1571835695.gitgitgadget@gmail.com>
From:   "Derrick Stolee via GitGitGadget" <gitgitgadget@gmail.com>
Date:   Wed, 23 Oct 2019 13:01:34 +0000
Subject: [PATCH v2 1/2] t5510-fetch.sh: demonstrate fetch.writeCommitGraph bug
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Fcc:    Sent
To:     git@vger.kernel.org
Cc:     johannes.schindelin@gmx.de, peff@peff.net, szeder.dev@gmail.com,
        Derrick Stolee <dstolee@microsoft.com>,
        Junio C Hamano <gitster@pobox.com>,
        Derrick Stolee <dstolee@microsoft.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

From: Derrick Stolee <dstolee@microsoft.com>

While dogfooding, Johannes found a bug in the fetch.writeCommitGraph
config behavior. His example initially happened during a clone with
--recurse-submodules, we found that this happens with the first fetch
after cloning a repository that contains a submodule:

	$ git clone <url> test
	$ cd test
	$ git -c fetch.writeCommitGraph=true fetch origin
	Computing commit graph generation numbers: 100% (12/12), done.
	BUG: commit-graph.c:886: missing parent <hash1> for commit <hash2>
	Aborted (core dumped)

In the repo I had cloned, there were really 60 commits to scan, but
only 12 were in the list to write when calling
compute_generation_numbers(). A commit in the list expects to see a
parent, but that parent is not in the list.

A follow-up will fix the bug, but first we create a test that
demonstrates the problem.

I used "test_expect_failure" for the entire test instead of
"test_must_fail" only on the command that I expect to fail. This is
because the BUG() returns an exit code so test_must_fail complains.

Helped-by: Jeff King <peff@peff.net>
Helped-by: Johannes Schindelin <johannes.schindelin@gmx.de>
Helped-by: Szeder Gábor <szeder.dev@gmail.com>
Signed-off-by: Derrick Stolee <dstolee@microsoft.com>
---
 t/t5510-fetch.sh | 17 +++++++++++++++++
 1 file changed, 17 insertions(+)

diff --git a/t/t5510-fetch.sh b/t/t5510-fetch.sh
index ecabbe1616..e8ae3af0b6 100755
--- a/t/t5510-fetch.sh
+++ b/t/t5510-fetch.sh
@@ -583,6 +583,23 @@ test_expect_success 'fetch.writeCommitGraph' '
 	)
 '
 
+test_expect_failure 'fetch.writeCommitGraph with submodules' '
+	pwd="$(pwd)" &&
+	git clone dups super &&
+	(
+		cd super &&
+		git submodule add "file://$pwd/three" &&
+		git commit -m "add submodule"
+	) &&
+	git clone "super" writeError &&
+	(
+		cd writeError &&
+		test_path_is_missing .git/objects/info/commit-graphs/commit-graph-chain &&
+		git -c fetch.writeCommitGraph=true fetch origin &&
+		test_path_is_file .git/objects/info/commit-graphs/commit-graph-chain
+	)
+'
+
 # configured prune tests
 
 set_config_tristate () {
-- 
gitgitgadget

