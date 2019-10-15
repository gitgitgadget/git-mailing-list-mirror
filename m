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
	by dcvr.yhbt.net (Postfix) with ESMTP id 17C3C1F4C0
	for <e@80x24.org>; Tue, 15 Oct 2019 23:41:20 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2388062AbfJOXlR (ORCPT <rfc822;e@80x24.org>);
        Tue, 15 Oct 2019 19:41:17 -0400
Received: from mail-wr1-f67.google.com ([209.85.221.67]:46219 "EHLO
        mail-wr1-f67.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S2388049AbfJOXlP (ORCPT <rfc822;git@vger.kernel.org>);
        Tue, 15 Oct 2019 19:41:15 -0400
Received: by mail-wr1-f67.google.com with SMTP id o18so25745145wrv.13
        for <git@vger.kernel.org>; Tue, 15 Oct 2019 16:41:12 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=message-id:in-reply-to:references:from:date:subject:fcc
         :content-transfer-encoding:mime-version:to:cc;
        bh=Z58UUK9zGq2a+qFVs6BqdNlFfOWi4CvsYdZWz2yJUqo=;
        b=FMPJt55Xh4e119G++5qIy5htsrWDI+sUF3UWz8eVYG0TQ2UbAAclQx5Rf2Up4cAPe/
         UQVYP2TangGmEAs83p0HaSbJJuHs0pnPLHblO1nXGyrqOr1md1OYGNlWbj7PdaqsMoat
         rRZrkW2n2W4lQKwiyA0JH753gCBX43ccMzd60cmKvOPDOUj9L6cC/XNeKPBZEnHOzxCY
         1D7bhxGcmyIbAldN1n/FVVSpX3BROApRUsvQAiB1JlS6kW2xvmL77EfJGzhau+dMif2N
         Rj8QaKYV63v3P/kIM2LEx2efas4y/6iSXmgsg+AdyWH0sW2Y+aXksAtZyMsF4g3c/43i
         wmjQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:message-id:in-reply-to:references:from:date
         :subject:fcc:content-transfer-encoding:mime-version:to:cc;
        bh=Z58UUK9zGq2a+qFVs6BqdNlFfOWi4CvsYdZWz2yJUqo=;
        b=L5F0E6PHVrTV0iSBQajG8WEoqDZPLCntkoUCmJst0zGQP3hazWG0oTfRn6aY14U9LR
         HDCgkNxPU44OsqZxk6enun2t2eEQGDOsJdccjrJdqAmlBZA4l6ZkeJp+tIRjJwfHiA16
         BLKKJ3elUYnowphNoJFnwN6LGEbBbjMMYI69lL//ORBH1dyshwVWnmqm0K4qyLNTnpXh
         snEIBRM6tIAI6Ewnd0k46nj4TtxiqB9rtY9Dwa+TQT+BLnZmuTrfXCdfieVX4tfmeHsa
         QqfHyq9sbo8cvGmXpXtfnV1eMMWPyI9UHY7YX7jfP1a4YyLcrO3XBJkgupxnICfkY9q/
         kTOw==
X-Gm-Message-State: APjAAAXjuUANfLDb1biVX5aPX3ahHvTI81NQOgLrul4RrKJgCxLUz7CM
        oV9L+CwcTWHan3YDpOrHAP+zzAiw
X-Google-Smtp-Source: APXvYqwoox+TPs3ljlNDZX7UhKda0E+NygxAnKKkU0aNFfxgjkspRCwh257TjBIKKYcUVsPGkdXU7w==
X-Received: by 2002:a5d:6745:: with SMTP id l5mr38256wrw.51.1571182871792;
        Tue, 15 Oct 2019 16:41:11 -0700 (PDT)
Received: from [127.0.0.1] ([13.74.141.28])
        by smtp.gmail.com with ESMTPSA id r65sm598828wmr.9.2019.10.15.16.41.11
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Tue, 15 Oct 2019 16:41:11 -0700 (PDT)
Message-Id: <51495be940a571c9f0ca501f668dde641e023ab3.1571182864.git.gitgitgadget@gmail.com>
In-Reply-To: <pull.383.v2.git.1571182864.gitgitgadget@gmail.com>
References: <pull.383.git.gitgitgadget@gmail.com>
        <pull.383.v2.git.1571182864.gitgitgadget@gmail.com>
From:   "James Coglan via GitGitGadget" <gitgitgadget@gmail.com>
Date:   Tue, 15 Oct 2019 23:40:58 +0000
Subject: [PATCH v2 07/13] graph: example of graph output that can be
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

