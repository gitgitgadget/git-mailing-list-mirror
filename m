Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.2 (2018-09-13) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-3.7 required=3.0 tests=AWL,BAYES_00,
	DKIM_ADSP_CUSTOM_MED,DKIM_INVALID,DKIM_SIGNED,
	FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,RCVD_IN_DNSWL_HI,SPF_HELO_NONE,SPF_NONE
	shortcircuit=no autolearn=ham autolearn_force=no version=3.4.2
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 17E291F4C0
	for <e@80x24.org>; Thu, 24 Oct 2019 12:18:14 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2439654AbfJXMSN (ORCPT <rfc822;e@80x24.org>);
        Thu, 24 Oct 2019 08:18:13 -0400
Received: from mail-wm1-f68.google.com ([209.85.128.68]:53639 "EHLO
        mail-wm1-f68.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S2439650AbfJXMSM (ORCPT <rfc822;git@vger.kernel.org>);
        Thu, 24 Oct 2019 08:18:12 -0400
Received: by mail-wm1-f68.google.com with SMTP id n7so1764334wmc.3
        for <git@vger.kernel.org>; Thu, 24 Oct 2019 05:18:11 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=message-id:in-reply-to:references:from:date:subject:mime-version
         :content-transfer-encoding:fcc:to:cc;
        bh=15Hi4NJ84XV6Tw3ZknSKqapkwWagksbQOHzXb4cBZSc=;
        b=By2qdjYqgcRu9gq9ED3hcYpM+9W7eGwks03PqUFI5qzcIdipcjYtZA9nVdj9KS466h
         udqbp3IpH+B2HlzySeSqH/y4hbnU6oBzyuuIddjb/BUvNvBtNwEqNb3SgsoAqcPPC/Q6
         bBUixNw7rKVwzvH3fRbwbD7r65VHmUPVNhic/qSeq0iit+IIdDeDlXA4TixybxYxQ/Dv
         59tV0BsEe7/dKYUj7kbTY9+QPa3Agy0v3bUp3fy6JiyxXdFqt2lTvXVDKJi/B0F+uyVo
         UP9pT1/QJKg1o/DGxP4/qXxWPAKEFGMi2rWNGeXQFolvyc1an0LksJbFsCPPI17/Qy6i
         qn5A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:message-id:in-reply-to:references:from:date
         :subject:mime-version:content-transfer-encoding:fcc:to:cc;
        bh=15Hi4NJ84XV6Tw3ZknSKqapkwWagksbQOHzXb4cBZSc=;
        b=j8h6r/O6K12KlwN32/i5xr5UaltWdtvWmEq21wM93sw+AgHqTYkk5yqCS1UPPKy+Zr
         pSSB/YdF4sE2PiF+4eZKn4Y+L/YkA1q+3QW8i5lyqLP0PPMYG1WDqjWj7sgkGYIsNR/y
         jxETzWeB1a8tqjp87JnLeIK4A3QdwLP4OPV68yyswk4HHq2kekbS75UMVR0QLihjlzIq
         /TrYo5NWColuW7qhKn8geJRErNw/W1Xre60tqkk5jJUNrtjGHWFKGeDufOm9mmUmwz1i
         K2gJZ0RkNADVTRPxgfIZl8BVHznyHHQVCpszVZQcpOXMPHOBiRA1J0YOzm5tnCPV1V9u
         EDIA==
X-Gm-Message-State: APjAAAXpmgTYRjcFFS/qXSS6QRZa4rWTQTpX2+0W5gFWfsHLiqF7IQji
        3vozFMz9obDAChNP1WFtt8m90pwb
X-Google-Smtp-Source: APXvYqzZin02AlBcKRfzUTRyC8YEY0+VU2r84mDn0nyQEni7RguBd+Qo3BM7pD0WeF0CcRXCj/VO8g==
X-Received: by 2002:a1c:720a:: with SMTP id n10mr4588513wmc.20.1571919490566;
        Thu, 24 Oct 2019 05:18:10 -0700 (PDT)
Received: from [127.0.0.1] ([13.74.141.28])
        by smtp.gmail.com with ESMTPSA id x8sm25101021wrr.43.2019.10.24.05.18.10
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Thu, 24 Oct 2019 05:18:10 -0700 (PDT)
Message-Id: <ce53b5a7bfeffa8e676cdb7ba17f0f5176ae3567.1571919488.git.gitgitgadget@gmail.com>
In-Reply-To: <pull.415.v3.git.1571919488.gitgitgadget@gmail.com>
References: <pull.415.v2.git.1571835695.gitgitgadget@gmail.com>
        <pull.415.v3.git.1571919488.gitgitgadget@gmail.com>
From:   "Derrick Stolee via GitGitGadget" <gitgitgadget@gmail.com>
Date:   Thu, 24 Oct 2019 12:18:07 +0000
Subject: [PATCH v3 1/2] t5510-fetch.sh: demonstrate fetch.writeCommitGraph bug
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

Helped-by: Jeff King <peff@peff.net>
Helped-by: Johannes Schindelin <johannes.schindelin@gmx.de>
Helped-by: Szeder Gábor <szeder.dev@gmail.com>
Signed-off-by: Derrick Stolee <dstolee@microsoft.com>
---
 t/t5510-fetch.sh | 16 ++++++++++++++++
 1 file changed, 16 insertions(+)

diff --git a/t/t5510-fetch.sh b/t/t5510-fetch.sh
index ecabbe1616..cc76e1ce50 100755
--- a/t/t5510-fetch.sh
+++ b/t/t5510-fetch.sh
@@ -583,6 +583,22 @@ test_expect_success 'fetch.writeCommitGraph' '
 	)
 '
 
+test_expect_failure 'fetch.writeCommitGraph with submodules' '
+	git clone dups super &&
+	(
+		cd super &&
+		git submodule add "file://$TRASH_DIRECTORY/three" &&
+		git commit -m "add submodule"
+	) &&
+	git clone "super" super-clone &&
+	(
+		cd super-clone &&
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

