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
	by dcvr.yhbt.net (Postfix) with ESMTP id D783B1F4C0
	for <e@80x24.org>; Tue, 15 Oct 2019 23:48:13 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2387990AbfJOXsK (ORCPT <rfc822;e@80x24.org>);
        Tue, 15 Oct 2019 19:48:10 -0400
Received: from mail-wm1-f66.google.com ([209.85.128.66]:53179 "EHLO
        mail-wm1-f66.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1728457AbfJOXsJ (ORCPT <rfc822;git@vger.kernel.org>);
        Tue, 15 Oct 2019 19:48:09 -0400
Received: by mail-wm1-f66.google.com with SMTP id r19so837520wmh.2
        for <git@vger.kernel.org>; Tue, 15 Oct 2019 16:48:08 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=message-id:in-reply-to:references:from:date:subject:fcc
         :content-transfer-encoding:mime-version:to:cc;
        bh=OAQtWYLP5laFlqAR9gQuZZTsICRLnyxjNMyajopwvYE=;
        b=kmeTeoOjxn74CQXZappInMoCJEvDw2m5tvCfG/p2yZU6bh/0XM/LK1TtgbrktyBHzk
         odK/VakrlX8nLUV70nDm8a5rLEV1KIDnJs0J/yvhcstkUZcpuCYOAF3iKeUZhps2bbuu
         ypd85EaSgyXTLsFiGgkZRq2CLyNKEldY3O4SHsgx2/yTrggl/xgGplczTVRS+FCNONT8
         3Iv1GHX4yxhmVqVXFRmEBlJVprl8f4uFAiDoT9w4iVz+M5UQoVqqwMTrh1yijDy8sTG4
         MXJXOcbO34d6WYSg1bE4jV7jH8Oj1CJJdnvlJdScdua15q11RvaOknYCC5n1DzDkx3gr
         45Sg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:message-id:in-reply-to:references:from:date
         :subject:fcc:content-transfer-encoding:mime-version:to:cc;
        bh=OAQtWYLP5laFlqAR9gQuZZTsICRLnyxjNMyajopwvYE=;
        b=C38ZW6sMSgMGycDtIN/lup0T0Ziv8VFWvvbKmOIybRiZ/N/G7yvk1O/ssymLjgKd3o
         Sx2NynwVnK8DrckFHGWxZ+dieD8H2xfyd8BMxfIdho5df/g7Wi63rPMol5BiSzw4jlHe
         Q83F4oxLMq5mtDHTz8kKFOukhwo0lsQlqTUEVMvx9LoiE+58mdbZ6E/q67yGW96B+yav
         BpAn/qKCU3WthLV0zIui+ZThgIGqKDy63CStG/B6HaWeZxjCGWaTIIwn6vGI+D4yFnhy
         95L4DVII7GaUOxxRsektOWO2MZDXlVJXWI8O7ZvUk1f1k0GR6tCpJ2YTOD74WVW0Ztwy
         Vzzw==
X-Gm-Message-State: APjAAAWIFxWvsaPymhHvvhX9QD1Uib8Knv45lCn3c0PBmSBo8razhTfh
        L67y9f20lMGVEtktz1STiO2oFAKD
X-Google-Smtp-Source: APXvYqwBN/DZHsSbm1hufOblFAL8vHVohGcrHUL6MwDYBI7kUV9Ab+IZ8WammX6+Gk7n1HW8y6buKg==
X-Received: by 2002:a1c:9e07:: with SMTP id h7mr800045wme.96.1571183287453;
        Tue, 15 Oct 2019 16:48:07 -0700 (PDT)
Received: from [127.0.0.1] ([13.74.141.28])
        by smtp.gmail.com with ESMTPSA id u10sm610314wmm.0.2019.10.15.16.48.06
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Tue, 15 Oct 2019 16:48:06 -0700 (PDT)
Message-Id: <631ee3cecb68d9f776d4a8fb30c1bca70797ba14.1571183279.git.gitgitgadget@gmail.com>
In-Reply-To: <pull.383.v3.git.1571183279.gitgitgadget@gmail.com>
References: <pull.383.v2.git.1571182864.gitgitgadget@gmail.com>
        <pull.383.v3.git.1571183279.gitgitgadget@gmail.com>
From:   "James Coglan via GitGitGadget" <gitgitgadget@gmail.com>
Date:   Tue, 15 Oct 2019 23:47:53 +0000
Subject: [PATCH v3 07/13] graph: example of graph output that can be
 simplified
Fcc:    Sent
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
MIME-Version: 1.0
To:     git@vger.kernel.org
Cc:     Junio C Hamano <gitster@pobox.com>,
        James Coglan <jcoglan@gmail.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

From: James Coglan <jcoglan@gmail.com>

The commits following this one introduce a series of improvements to the
layout of graphs, tidying up a few edge cases, namely:

- merge whose first parent fuses with an existing column to the left
- merge whose last parent fuses with its immediate neighbor on the right
- edges that collapse to the left above and below a commit line

This test case exemplifies these cases and provides a motivating example
of the kind of history I'm aiming to clear up.

The first parent of merge E is the same as the parent of H, so those
edges fuse together.

        * H
        |
        | *-.   E
        | |\ \
        |/ / /
        |
        * B

We can "skew" the display of this merge so that it doesn't introduce
additional columns that immediately collapse:

        * H
        |
        | *   E
        |/|\
        |
        * B

The last parent of E is D, the same as the parent of F which is the edge
to the right of the merge.

            * F
            |
             \
          *-. \   E
          |\ \ \
         / / / /
            | /
            |/
            * D

The two edges leading to D could be fused sooner: rather than expanding
the F edge around the merge and then letting the edges collapse, the F
edge could fuse with the E edge in the post-merge line:

            * F
            |
             \
          *-. | E
          |\ \|
         / / /
            |
            * D

If this is combined with the "skew" effect above, we get a much cleaner
graph display for these edges:

            * F
            |
          * | E
         /|\|
            |
            * D

Finally, the edge leading from C to A appears jagged as it passes
through the commit line for B:

        | * | C
        | |/
        * | B
        |/
        * A

This can be smoothed out so that such edges are easier to read:

        | * | C
        | |/
        * / B
        |/
        * A

Signed-off-by: James Coglan <jcoglan@gmail.com>
---
 t/t4215-log-skewed-merges.sh | 43 ++++++++++++++++++++++++++++++++++++
 1 file changed, 43 insertions(+)
 create mode 100755 t/t4215-log-skewed-merges.sh

diff --git a/t/t4215-log-skewed-merges.sh b/t/t4215-log-skewed-merges.sh
new file mode 100755
index 0000000000..4582ba066a
--- /dev/null
+++ b/t/t4215-log-skewed-merges.sh
@@ -0,0 +1,43 @@
+#!/bin/sh
+
+test_description='git log --graph of skewed merges'
+
+. ./test-lib.sh
+
+test_expect_success 'log --graph with merge fusing with its left and right neighbors' '
+	cat >expect <<-\EOF &&
+	*   H
+	|\
+	| *   G
+	| |\
+	| | * F
+	| | |
+	| |  \
+	| *-. \   E
+	| |\ \ \
+	|/ / / /
+	| | | /
+	| | |/
+	| | * D
+	| * | C
+	| |/
+	* | B
+	|/
+	* A
+	EOF
+
+	git checkout --orphan _p &&
+	test_commit A &&
+	test_commit B &&
+	git checkout -b _q @^ && test_commit C &&
+	git checkout -b _r @^ && test_commit D &&
+	git checkout _p && git merge --no-ff _q _r -m E &&
+	git checkout _r && test_commit F &&
+	git checkout _p && git merge --no-ff _r -m G &&
+	git checkout @^^ && git merge --no-ff _p -m H &&
+
+	git log --graph --pretty=tformat:%s | sed "s/ *$//" >actual &&
+	test_cmp expect actual
+'
+
+test_done
-- 
gitgitgadget

