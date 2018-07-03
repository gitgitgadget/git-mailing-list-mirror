Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.1 (2015-04-28) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-3.8 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,RCVD_IN_DNSWL_HI
	shortcircuit=no autolearn=ham autolearn_force=no version=3.4.1
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 8CE8E1F516
	for <e@80x24.org>; Tue,  3 Jul 2018 03:58:48 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1753844AbeGCD6o (ORCPT <rfc822;e@80x24.org>);
        Mon, 2 Jul 2018 23:58:44 -0400
Received: from mail-yb0-f196.google.com ([209.85.213.196]:35116 "EHLO
        mail-yb0-f196.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1753823AbeGCD6i (ORCPT <rfc822;git@vger.kernel.org>);
        Mon, 2 Jul 2018 23:58:38 -0400
Received: by mail-yb0-f196.google.com with SMTP id x15-v6so209088ybm.2
        for <git@vger.kernel.org>; Mon, 02 Jul 2018 20:58:38 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id:in-reply-to:references;
        bh=RqjbftbTieIV90GZk1AANhOjf1STA+hxsUehCnCMLTU=;
        b=j8ZNUAwJ8v+3wxCwjJFXxWqie16ZOCzGhX+QO1AZWjrXtQ8SE3azur2lmuBvRo+++M
         LnIX1G4E+LOFxzdNOsoWpjkxb7ZwmOin5ZgschZlhQ+lPArn7O4QOCm/0M9g3rrbQ265
         WkqH+4DS4U1b48S+9lfNaB67EWlGZDbyxcXyHusZiHSLymcfGuFEPi2+mn11wcO0wVVo
         jIMNYluesjy2Ek08PynzukXAAIqObILlhNdqlsVZ5g2wz2bKSnNJtlC0HpQpayknjhdL
         bOIkyy6dno7b/o/nRhjNamXyXUPsOU1hvUYSrxyN8leRHuAi9fR7jBdENCqpgVGyKiAC
         9a8w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references;
        bh=RqjbftbTieIV90GZk1AANhOjf1STA+hxsUehCnCMLTU=;
        b=OzhpZJhAT0lXLxJDR2SLpEm7+Epim8fQOQntzDdCEzDtQ5Owx63bE0SivkOdTEEAGM
         iIAxjr/lP3BbJPGlyCDPR3E3jgz709hDTUOm8iQJuWuBoVqCAj8OiU40q+91nZVVsyOF
         ++eZnkFMJskXbL7WYTDE7qdZaup85v7IBwogv3o8dyrrd708c4lyv/saUXhUKPBeXaCg
         bC8aCSaNGb5aJ92x8Wppa7GRQ+oa2fm7Isi1nBAdOJnQbh5x5cxIe3eQ6bmwAAA1SgiU
         yo6zb4tfuYhlz4PG6ymEKmljUmUCm8zS2ik5JG0ZayYQ7JPdjBq2RZcy6NAtfvAnqO0B
         kWng==
X-Gm-Message-State: APt69E1WV2dV0eGmCCVnyZHbxAito96JaDVrG+qZPhR+G+PlATO90LJ6
        5yoGgF34+JVJIvzy7nYiZgundv4U
X-Google-Smtp-Source: AAOMgpfJ3P71y++k2TTX9LDyJ3TUOmuhsVg0UBNY3phytx8zypwal8PKlCHA+r+fsAAoaUXqygS5Yw==
X-Received: by 2002:a25:6ec3:: with SMTP id j186-v6mr9895670ybc.490.1530590317989;
        Mon, 02 Jul 2018 20:58:37 -0700 (PDT)
Received: from localhost.localdomain ([70.63.112.210])
        by smtp.gmail.com with ESMTPSA id q131-v6sm97262ywq.8.2018.07.02.20.58.37
        (version=TLS1_2 cipher=ECDHE-RSA-CHACHA20-POLY1305 bits=256/256);
        Mon, 02 Jul 2018 20:58:37 -0700 (PDT)
From:   Joshua Nelson <jyn514@gmail.com>
To:     git@vger.kernel.org
Cc:     Joshua Nelson <jyn514@gmail.com>
Subject: [PATCH 3/3] ls-tree: add unit tests for arguments
Date:   Mon,  2 Jul 2018 23:58:02 -0400
Message-Id: <20180703035802.24060-3-jyn514@gmail.com>
X-Mailer: git-send-email 2.18.GIT
In-Reply-To: <20180703035802.24060-1-jyn514@gmail.com>
References: <20180703035802.24060-1-jyn514@gmail.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Signed-off-by: Joshua Nelson <jyn514@gmail.com>
---
 t/t3104-ls-tree-optional-args.sh | 43 ++++++++++++++++++++++++++++++++
 1 file changed, 43 insertions(+)
 create mode 100644 t/t3104-ls-tree-optional-args.sh

diff --git t/t3104-ls-tree-optional-args.sh t/t3104-ls-tree-optional-args.sh
new file mode 100644
index 000000000..5917563a7
--- /dev/null
+++ t/t3104-ls-tree-optional-args.sh
@@ -0,0 +1,43 @@
+#!/bin/sh
+
+test_description='ls-tree test (optional args)
+
+This test tries to run git-ls-tree with various combinations of options.'
+
+. ./test-lib.sh
+
+test_expect_success 'initial setup' '
+echo hi > test && cp test test2 && git add test test2 && git commit -m initial'
+
+# cat appends newlines after every file
+test_expect_success 'succeed when given no args' 'git ls-tree'
+
+test_expect_success 'succeed when given only --' 'git ls-tree'
+
+test_expect_success 'add second commit' '
+echo hi > test3 && git add test3 && git commit -m "commit 2"'
+
+test_expect_success 'succeed when given revision' '
+git ls-tree HEAD~1'
+
+test_expect_success 'succeed when given revision and --' '
+git ls-tree HEAD~1 --'
+
+test_expect_success 'succeed when given -- and file' '
+git ls-tree -- test3'
+
+test_expect_success 'do nothing when given bad files' '
+git ls-tree -- bad_files'
+
+test_expect_success 'succeed when given file from past revision' '
+git ls-tree HEAD~1 test'
+
+test_expect_success 'succeed when given only file' 'git ls-tree test'
+
+test_expect_success 'raise error when given bad args' '
+test_must_fail  git ls-tree HEAD HEAD --'
+
+test_expect_success 'raise error when given bad revision' '
+test_must_fail git ls-tree bad_revision --'
+
+test_done
-- 
2.18.GIT

