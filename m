Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.2 (2018-09-13) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-4.2 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,RCVD_IN_DNSWL_HI,
	SPF_HELO_NONE,SPF_NONE shortcircuit=no autolearn=ham
	autolearn_force=no version=3.4.2
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 087F01F609
	for <e@80x24.org>; Fri,  7 Jun 2019 18:38:42 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1731918AbfFGSik (ORCPT <rfc822;e@80x24.org>);
        Fri, 7 Jun 2019 14:38:40 -0400
Received: from mail-ed1-f66.google.com ([209.85.208.66]:37472 "EHLO
        mail-ed1-f66.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1731904AbfFGSie (ORCPT <rfc822;git@vger.kernel.org>);
        Fri, 7 Jun 2019 14:38:34 -0400
Received: by mail-ed1-f66.google.com with SMTP id w13so4363918eds.4
        for <git@vger.kernel.org>; Fri, 07 Jun 2019 11:38:34 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=date:message-id:in-reply-to:references:from:subject:fcc
         :content-transfer-encoding:mime-version:to:cc;
        bh=hIi9l0byLwN4GcFQhxtlx5k7npFpNleBgyEOn32RhlE=;
        b=OkM15TmWMbJFSWPZljY7kUEYoL5PupG1Y8+kY9w5Iui8HkLg86hjoE2wIVOTOz8JB9
         ZElu4xOCp+7Xty5t03kqAkfMRUeUMvFoiAW33nYD8u8UYMbZtXdO6TLaoqz+7Xi9fopT
         mn4HzV31Pjt1plKuXleFKVuP/N+AHjoCdDgYL/M2XPuiFpZ6dUhhLHEOV7KXIzFbPGnI
         0FdZ4219hxXHZ+6pM6/NwwDLuHBzf8dDQsE9Gv1HCnAoczYdIrW+ZwYXhjejGt4bfIVc
         oyb4lQ0au5WlqxhI1kLKKOpQ21PXfuRw16ChbB4ZyXXWtfOiOVQQnjFbgCE7cDVuyUQJ
         xGkQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:message-id:in-reply-to:references:from
         :subject:fcc:content-transfer-encoding:mime-version:to:cc;
        bh=hIi9l0byLwN4GcFQhxtlx5k7npFpNleBgyEOn32RhlE=;
        b=GliVTN5D+KuTGwn7ouZAQuduqvYs5efCdGanC5V6uC5wqkuHyxrSOaa3kHuuaYT7fi
         WhXo21vytv6eUYxZETfDOD46PsTFrpRokJzUOak3sfak1F7ygCIhy8DiACaoZezyNRgN
         1pWXkqdl++fLj+JqB2ENDlFyjkZevbt1BwD+gu6hgkI7crOl46vOiWeJTIdpocXWcKYC
         vN7QovA25QFZGJxmIXOGLSt3dOhqqUQRRnNvTEKqPworcS/A1OOEjkDIuxK4fy+Z2OYv
         6CsSwQq8b5STZeVmxVXtdNq4Dj8zSHyNPLH83nWC0RyUri84MsgkS5EJ1cTZf1OvAC+E
         42fQ==
X-Gm-Message-State: APjAAAXwjX9aoPMYUN+FHsFlrnOP/IfcwzvsIKu6nRUjnGH/kX7sR+Rd
        0DkEbmkM5ontT0o3oW9uHQ4kGX9A
X-Google-Smtp-Source: APXvYqwfV+Jd2HjQ+KYla1NhtI86/00OeyVU3qMVR6hECP5TmCzxC3w3Fo+YO5tUYiFYM3Z1SAUw7A==
X-Received: by 2002:a50:913c:: with SMTP id e57mr8692250eda.257.1559932713448;
        Fri, 07 Jun 2019 11:38:33 -0700 (PDT)
Received: from [127.0.0.1] ([13.74.141.28])
        by smtp.gmail.com with ESMTPSA id e10sm500618ejx.89.2019.06.07.11.38.32
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Fri, 07 Jun 2019 11:38:33 -0700 (PDT)
Date:   Fri, 07 Jun 2019 11:38:33 -0700 (PDT)
X-Google-Original-Date: Fri, 07 Jun 2019 18:38:19 GMT
Message-Id: <84a3ff7c61a27bab2d7f01267f09b314fb292d57.1559932699.git.gitgitgadget@gmail.com>
In-Reply-To: <pull.184.v5.git.gitgitgadget@gmail.com>
References: <pull.184.v4.git.gitgitgadget@gmail.com>
        <pull.184.v5.git.gitgitgadget@gmail.com>
From:   "Derrick Stolee via GitGitGadget" <gitgitgadget@gmail.com>
Subject: [PATCH v5 16/16] commit-graph: test --split across alternate without
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
