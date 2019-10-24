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
	by dcvr.yhbt.net (Postfix) with ESMTP id 7C0A91F4C0
	for <e@80x24.org>; Thu, 24 Oct 2019 13:40:48 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2393669AbfJXNkr (ORCPT <rfc822;e@80x24.org>);
        Thu, 24 Oct 2019 09:40:47 -0400
Received: from mail-wm1-f68.google.com ([209.85.128.68]:55106 "EHLO
        mail-wm1-f68.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S2393663AbfJXNkq (ORCPT <rfc822;git@vger.kernel.org>);
        Thu, 24 Oct 2019 09:40:46 -0400
Received: by mail-wm1-f68.google.com with SMTP id g7so2895096wmk.4
        for <git@vger.kernel.org>; Thu, 24 Oct 2019 06:40:45 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=message-id:in-reply-to:references:from:date:subject:mime-version
         :content-transfer-encoding:fcc:to:cc;
        bh=5Po/WZ9hyNuSgO/SbboUye7G7Zv+SpgD+Frj76lOOSg=;
        b=nbQwuyXjk1WCDp6YfdHPPA3+j7BjXMZNGULXUnfDNmsIPz0HaTjmE3SBKTU4xugci6
         NuFLca3/8okVDILh6s3CiGSUWY7IFO5LfIJc30MyPGkyH/M6Ly+QmKIKkR0GGeIcHdth
         eoKvBYSvGoNWPTm4qbVGOi8nOfXFyjIlmhMouliZnX+Afr6pcbKYvyqw/duGZ4m9yD9f
         w8+B0Vg7o8MRdyiOjXJYjyvj3dbJqKtr+qNHRBVtzkaDbaE4lAPo1kiTuD3NMLwqW/yF
         3e1SmHwT+hdwee8T1a1SdfxIgG9bvSMkj9pVfZCtHtI8IFfVpk+TtWsK20m4FTrWCXl3
         HplQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:message-id:in-reply-to:references:from:date
         :subject:mime-version:content-transfer-encoding:fcc:to:cc;
        bh=5Po/WZ9hyNuSgO/SbboUye7G7Zv+SpgD+Frj76lOOSg=;
        b=Qn9fAVL/+D4mRU4RwrV0aekfSFGf7Po9ru03RWUYjnUXfb8TtCZjvNo8aDXc0jbI4w
         5xbE6jQdU/Cjl9qjFQuLPi5165Ec3k9F8PNLdFWvuaI4pIGjaKNciiR1ukooWLezQevm
         +5lHsuCY9m1DagmgSYRRSTt691KDjFDEitdcDWwiPxYIO8fXHYmFZptdWAGNhZlFYXMN
         BehRbiZ64bgTqIej5kunCqJsT4OkqJDBn64T+7C+LYqK3P/b7oSWjus0mi+qiKvK0yHj
         WkN8UY5H/89gTGdgyZn5SqrsdW0INEFggW5R7tx25of5aNe8TRFcMYc+yGM2Rt4YFa42
         huUg==
X-Gm-Message-State: APjAAAXJ2qlDYYE4kWVxoOsDmIDxQLUd5MVjVHMsCOuf6zJ67NX+c0B/
        aloZO5Tttgq0fIORIvC5+/yF49KK
X-Google-Smtp-Source: APXvYqyRriVZBOZ7j3kooPsEDabMhpKgkb0EEXFxYHmtQEuGG1cP2EDtg+wN98Pbl7hVEeNEvG2jiA==
X-Received: by 2002:a1c:f00a:: with SMTP id a10mr5267911wmb.89.1571924445115;
        Thu, 24 Oct 2019 06:40:45 -0700 (PDT)
Received: from [127.0.0.1] ([13.74.141.28])
        by smtp.gmail.com with ESMTPSA id f204sm1832163wmf.32.2019.10.24.06.40.44
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Thu, 24 Oct 2019 06:40:44 -0700 (PDT)
Message-Id: <81501084713c129327d150c66779505ca4f1b271.1571924442.git.gitgitgadget@gmail.com>
In-Reply-To: <pull.415.v4.git.1571924442.gitgitgadget@gmail.com>
References: <pull.415.v3.git.1571919488.gitgitgadget@gmail.com>
        <pull.415.v4.git.1571924442.gitgitgadget@gmail.com>
From:   "Derrick Stolee via GitGitGadget" <gitgitgadget@gmail.com>
Date:   Thu, 24 Oct 2019 13:40:41 +0000
Subject: [PATCH v4 1/2] t5510-fetch.sh: demonstrate fetch.writeCommitGraph bug
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
demonstrates the problem. This test must be careful about an existing
commit-graph file, since GIT_TEST_COMMIT_GRAPH=1 will cause the repo we
are cloning to already have one. This then prevents the incremtnal
commit-graph write during the first 'git fetch'.

Helped-by: Jeff King <peff@peff.net>
Helped-by: Johannes Schindelin <johannes.schindelin@gmx.de>
Helped-by: Szeder Gábor <szeder.dev@gmail.com>
Signed-off-by: Derrick Stolee <dstolee@microsoft.com>
---
 t/t5510-fetch.sh | 16 ++++++++++++++++
 1 file changed, 16 insertions(+)

diff --git a/t/t5510-fetch.sh b/t/t5510-fetch.sh
index ecabbe1616..195781ce8d 100755
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
+		rm -rf .git/objects/info &&
+		git -c fetch.writeCommitGraph=true fetch origin &&
+		test_path_is_file .git/objects/info/commit-graphs/commit-graph-chain
+	)
+'
+
 # configured prune tests
 
 set_config_tristate () {
-- 
gitgitgadget

