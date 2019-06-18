Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.2 (2018-09-13) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-4.0 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,RCVD_IN_DNSWL_HI,
	SPF_HELO_NONE,SPF_NONE shortcircuit=no autolearn=ham
	autolearn_force=no version=3.4.2
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id D0FAE1F609
	for <e@80x24.org>; Tue, 18 Jun 2019 18:14:46 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1730350AbfFRSOl (ORCPT <rfc822;e@80x24.org>);
        Tue, 18 Jun 2019 14:14:41 -0400
Received: from mail-ed1-f68.google.com ([209.85.208.68]:40990 "EHLO
        mail-ed1-f68.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1730335AbfFRSOh (ORCPT <rfc822;git@vger.kernel.org>);
        Tue, 18 Jun 2019 14:14:37 -0400
Received: by mail-ed1-f68.google.com with SMTP id p15so23017183eds.8
        for <git@vger.kernel.org>; Tue, 18 Jun 2019 11:14:36 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=date:message-id:in-reply-to:references:from:subject:fcc
         :content-transfer-encoding:mime-version:to:cc;
        bh=hIi9l0byLwN4GcFQhxtlx5k7npFpNleBgyEOn32RhlE=;
        b=lISLA9VJoGnQT2NmWx6Fq6oco7ynz6xYHNYAqiJ5wHmXwfDgaCjmqP+pcxqnR/3nkJ
         SdmFyPDz/P/lGU4DiqUGk5o1XsSYQlx/2Z2ANqjWb+jBrA39maJ9Vq5AZclu7xp2eXVr
         5ovqIEr68bYI/YZBoqjXbvEXsNplY1NONGbNBq1GI8UOm0qsV8hJOWy7Qd1hrJSBN4g8
         8b0W7xb1cwIq6f/AF7VFA7ySZA/0VxQ/gWKO0xTjIOpH16vSoHWUPfftU+3AFFIdBc6I
         rTJwTjrKvmNNlre9KrVq6dAFJaJuEGlliV1s4m8k5Xa7GZj0feIWMywfKPbRonE5R/ET
         3AtQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:message-id:in-reply-to:references:from
         :subject:fcc:content-transfer-encoding:mime-version:to:cc;
        bh=hIi9l0byLwN4GcFQhxtlx5k7npFpNleBgyEOn32RhlE=;
        b=VO5Gmzq0EPzb0tHi33rRIsnWDdJEoSix08TqzhrXFYxQb3QOZre+41djHuXU9BSKf7
         BxlcD/vxMbfHV4kDhLoeDc1ABsAn4T7lb++oLaIBQkutLlTvXMFpRXc6rn63g0nAVILu
         UHJK/w1qyEdAOcAuj1jQWQFFGR1ZebXoG5O+sFUJxniqIWvZGXVb+G6rNDgT1ipx1C8a
         p5OZsMEKBQeZstGqaO1hPWJFnOAO/JTfAfgIRxI4vYK0Z2WjT1RMMm56zONmO6GMGpGw
         t4r4v6YshAcW43rOCowz+nLYSvjJpqeK5tXfYcTlgQDz0W7eqNZoLx1LvH3HBApoEVGK
         eBng==
X-Gm-Message-State: APjAAAWtXXmtT+Y2Iq10NzprJg3Wzp8vQ9tUYcnPvHHCp+tSuLc51tBT
        gc0/dymKnaHRT4RLAQAII+m9bIbu
X-Google-Smtp-Source: APXvYqxuEKpUAiJ6J215ddPvGosoeHf8ti9cr6s3fKOs5kizVtLyqX77VI+WbscqVb0R8C4jmQczzw==
X-Received: by 2002:a50:8dcb:: with SMTP id s11mr64716351edh.144.1560881675760;
        Tue, 18 Jun 2019 11:14:35 -0700 (PDT)
Received: from [127.0.0.1] ([13.74.141.28])
        by smtp.gmail.com with ESMTPSA id o31sm5041020edb.66.2019.06.18.11.14.35
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Tue, 18 Jun 2019 11:14:35 -0700 (PDT)
Date:   Tue, 18 Jun 2019 11:14:35 -0700 (PDT)
X-Google-Original-Date: Tue, 18 Jun 2019 18:14:18 GMT
Message-Id: <be4b83fdaf75b6a8e139f78c8db405585fe6627d.1560881661.git.gitgitgadget@gmail.com>
In-Reply-To: <pull.184.v6.git.gitgitgadget@gmail.com>
References: <pull.184.v5.git.gitgitgadget@gmail.com>
        <pull.184.v6.git.gitgitgadget@gmail.com>
From:   "Derrick Stolee via GitGitGadget" <gitgitgadget@gmail.com>
Subject: [PATCH v6 16/18] commit-graph: test --split across alternate without
 --split
Fcc:    Sent
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
MIME-Version: 1.0
To:     git@vger.kernel.org
Cc:     peff@peff.net, avarab@gmail.com, git@jeffhostetler.com,
        jrnieder@google.com, steadmon@google.com,
        johannes.schindelin@gmx.de, philipoakley@iee.org,
        Junio C Hamano <gitster@pobox.com>,
        Derrick Stolee <dstolee@microsoft.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

From: Derrick Stolee <dstolee@microsoft.com>

We allow sharing commit-graph files across alternates. When we are
writing a split commit-graph, we allow adding tip graph files that
are not in the alternate, but include commits from our local repo.

However, if our alternate is not using the split commit-graph format,
its file is at .git/objects/info/commit-graph and we are trying to
write files in .git/objects/info/commit-graphs/graph-{hash}.graph.

We already have logic to ensure we do not merge across alternate
boundaries, but we also cannot have a commit-graph chain to our
alternate if uses the old filename structure.

Create a test that verifies we create a new split commit-graph
with only one level and we do not modify the existing commit-graph
in the alternate.

Signed-off-by: Derrick Stolee <dstolee@microsoft.com>
---
 t/t5324-split-commit-graph.sh | 15 +++++++++++++++
 1 file changed, 15 insertions(+)

diff --git a/t/t5324-split-commit-graph.sh b/t/t5324-split-commit-graph.sh
index 704def70bb..130f2baf44 100755
--- a/t/t5324-split-commit-graph.sh
+++ b/t/t5324-split-commit-graph.sh
@@ -301,4 +301,19 @@ test_expect_success 'add octopus merge' '
 
 graph_git_behavior 'graph exists' merge/octopus commits/12
 
+test_expect_success 'split across alternate where alternate is not split' '
+	git commit-graph write --reachable &&
+	test_path_is_file .git/objects/info/commit-graph &&
+	cp .git/objects/info/commit-graph . &&
+	git clone --no-hardlinks . alt-split &&
+	(
+		cd alt-split &&
+		echo "$(pwd)"/../.git/objects >.git/objects/info/alternates &&
+		test_commit 18 &&
+		git commit-graph write --reachable --split &&
+		test_line_count = 1 $graphdir/commit-graph-chain
+	) &&
+	test_cmp commit-graph .git/objects/info/commit-graph
+'
+
 test_done
-- 
gitgitgadget

