Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.1 (2015-04-28) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-3.7 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,RCVD_IN_DNSWL_HI
	shortcircuit=no autolearn=ham autolearn_force=no version=3.4.1
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 67DDF1F453
	for <e@80x24.org>; Wed, 19 Sep 2018 16:30:59 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1732681AbeISWJh (ORCPT <rfc822;e@80x24.org>);
        Wed, 19 Sep 2018 18:09:37 -0400
Received: from mail-lj1-f196.google.com ([209.85.208.196]:46616 "EHLO
        mail-lj1-f196.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1732659AbeISWJh (ORCPT <rfc822;git@vger.kernel.org>);
        Wed, 19 Sep 2018 18:09:37 -0400
Received: by mail-lj1-f196.google.com with SMTP id 203-v6so5625699ljj.13
        for <git@vger.kernel.org>; Wed, 19 Sep 2018 09:30:56 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=V4K3K0g48BsJ4ew7Olxosx+FwmQQJqKLdtcHiw20Heo=;
        b=lehz7dUkfQioIDdSK0/BFZpgCXGYv9ffmsqaQ6jMrSqvIF5wpyVFAgYJYHXcExDecY
         R4yBv3sIGkmyhYnanBJ4iKOC2Af4UdFi1PKkDXyqSc5rSL2b7zqtwTroz0VMz8iOp8IA
         QrI8clwg4T0B37E/MMSdJ7R8J+SadeGMfMERxBe38tmBgzyPUUqZD5hWGoDb3DEyyRLb
         CKA+PTEW6hnRxxBv0up2Uw8WFoM7VM1ZfY8FyWy2RdJ+QxWKhk5SSGppKtvgP3oD2Sgl
         k+mcGmLABjbzayJvTcAnGsT1YceTQMTQFj5nvGZbgJCxclnz0QKmBiFXR0AkRbWI5K7e
         ACyg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=V4K3K0g48BsJ4ew7Olxosx+FwmQQJqKLdtcHiw20Heo=;
        b=f8+fDehwvFzzxQOiEBQmQXPC04DP2kK2FMxJigkFJPtnoj7IeqEER0i4lEEee40p5n
         MHde2at5y6TXZdHeTaVjkaHxI/ug89cWJlGfc6x3eZ+QXEUZK/uYmxa7EPp5V7eXFqn8
         uDELOWmGnr+cyygVyBJOakTbD5O01GXB5pa6Q/UWZ1WOVielZpo98mJfmUetp7zZaKE1
         COUEOIz7bZcjn3pjRym/B0O0kUzkcS4Ggn86pOUsJJqTB5ZwXaX7bA0zFd/msriyHIbD
         rbTD6YTBShpNd/gdBPf7e8R+8gDt6ZzGQgZprzjZqYzh/E1rwfxlQD7qV0brUlDxZcVM
         iNpQ==
X-Gm-Message-State: APzg51A/68WiNDKSBfHF7fpd/+BEOpYD8huRc2jID34wJmyXUVB9DtRV
        sq6UXaivUYhXR6Az04MGZOVccsV2
X-Google-Smtp-Source: ANB0VdZsuJz17slUdQh0YCG8V4jiylII4cl65tMYCEXc4ZIIwUhN29+x29QuBhvP6uugS8WnkL9zeQ==
X-Received: by 2002:a2e:9854:: with SMTP id e20-v6mr1866838ljj.143.1537374654887;
        Wed, 19 Sep 2018 09:30:54 -0700 (PDT)
Received: from localhost.localdomain (31-211-229-121.customers.ownit.se. [31.211.229.121])
        by smtp.gmail.com with ESMTPSA id x8-v6sm3903594lji.53.2018.09.19.09.30.53
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-SHA bits=128/128);
        Wed, 19 Sep 2018 09:30:53 -0700 (PDT)
From:   =?UTF-8?q?Martin=20=C3=85gren?= <martin.agren@gmail.com>
To:     git@vger.kernel.org
Cc:     Derrick Stolee <stolee@gmail.com>
Subject: [PATCH 4/4] git-commit-graph.txt: refer to the "commit graph file" without dash
Date:   Wed, 19 Sep 2018 18:30:35 +0200
Message-Id: <fc81147ea42e382a3197c850830fe2142eda148e.1537374062.git.martin.agren@gmail.com>
X-Mailer: git-send-email 2.19.0.216.g2d3b1c576c
In-Reply-To: <cover.1537374062.git.martin.agren@gmail.com>
References: <cover.1537374062.git.martin.agren@gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

The command is `git commit-graph`, but the file it processes is the
"commit graph file" without a dash. We have a few references to the
"commit-graph file", though. Fix them.

Signed-off-by: Martin Ågren <martin.agren@gmail.com>
---
 Documentation/git-commit-graph.txt | 6 +++---
 1 file changed, 3 insertions(+), 3 deletions(-)

diff --git a/Documentation/git-commit-graph.txt b/Documentation/git-commit-graph.txt
index 55f63d47d9..dd0a53736f 100644
--- a/Documentation/git-commit-graph.txt
+++ b/Documentation/git-commit-graph.txt
@@ -50,7 +50,7 @@ commits starting at all refs. (Cannot be combined with `--stdin-commits`
 or `--stdin-packs`.)
 +
 With the `--append` option, include all commits that are present in the
-existing commit-graph file.
+existing commit graph file.
 
 'read'::
 
@@ -59,7 +59,7 @@ Used for debugging purposes.
 
 'verify'::
 
-Read the commit-graph file and verify its contents against the object
+Read the commit graph file and verify its contents against the object
 database. Used to check for corrupted data.
 
 
@@ -93,7 +93,7 @@ $ git show-ref -s | git commit-graph write --stdin-commits
 $ git rev-parse HEAD | git commit-graph write --stdin-commits --append
 ------------------------------------------------
 
-* Read basic information from the commit-graph file.
+* Read basic information from the commit graph file.
 +
 ------------------------------------------------
 $ git commit-graph read
-- 
2.19.0.216.g2d3b1c576c

