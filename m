Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.1 (2015-04-28) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-3.7 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,RCVD_IN_DNSWL_HI
	shortcircuit=no autolearn=ham autolearn_force=no version=3.4.1
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 5B71C1F453
	for <e@80x24.org>; Wed, 19 Sep 2018 16:30:55 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1732674AbeISWJe (ORCPT <rfc822;e@80x24.org>);
        Wed, 19 Sep 2018 18:09:34 -0400
Received: from mail-lj1-f194.google.com ([209.85.208.194]:44141 "EHLO
        mail-lj1-f194.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1732659AbeISWJd (ORCPT <rfc822;git@vger.kernel.org>);
        Wed, 19 Sep 2018 18:09:33 -0400
Received: by mail-lj1-f194.google.com with SMTP id q127-v6so5621989ljq.11
        for <git@vger.kernel.org>; Wed, 19 Sep 2018 09:30:53 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=JMSZh0xXztCWUGVaGy8PdDFVMdqmaIFMYEP0+hp5XvY=;
        b=Eq43gexUO6yEsIQgOErxJ48CW/eP7Ys6lqK02fgspkcC/3cVx6f8qRchkJ5R0O/pKQ
         deLWx0KuVvLupSxsmvDf6iLLhhkfdAFIOTcTWIdMsPpYni36ayrz4K3iGmhd9fQTkH05
         LvIR6Y2ZClqx2CvfGFUKRENM9zz03BWqVKCwHgXZGdabHp1q6sEN+MM63U2lITSpr9ES
         fLjmYaF/Wr+QPGXmKr8tnp6PcLMlr10H0ZJdUMvC2rGyPcP8RhxHq3QUMlWvYJOeQ/Nq
         RRZb2rZueKox79wrVBxjqG0ctCZ3OS0H8Iu6OxxYAkgvGFr8eS0zW75A15gTVrIhwGYs
         TdNg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=JMSZh0xXztCWUGVaGy8PdDFVMdqmaIFMYEP0+hp5XvY=;
        b=YZFdtWER7//CQ8pI48y1VzBv1uhvzN/6RrAt+LTxZ68qiHRWXmMcEUNQ7wweocwqfY
         XFQBWpV6vyLtLEOXeviyNNJ5mP58HOcIM/9+w99IkdV/bHVokWaj996MTBIfXKBJ9oF8
         dWOfnnaZb7sU10qgAzk0fgCAvPTR/1GrKzGEybVM+cf21bibnWkTfta9DAUdmpAjEuMK
         EfFVQ8Uw40S1j90ARQ464cCcfrWic/O0lfpCLrO4e5wEyMyAeh6njDqPscCsQuaaKdBe
         ycEzEHvR3Mx8631G/CAyDHPsqTkxfXzlgCzWPdjN9JyRdrynizC6V0p5i1oKqb6jzyTy
         mMEA==
X-Gm-Message-State: APzg51DQb4BEKCJwy26p3R84C5M3bxGSUzibNVhG18rn3S/T6T0+3Ybi
        bSs8xQFDtII9SMKveqFi+LK0b+vk
X-Google-Smtp-Source: ANB0VdYlG7iJLUZble5jZ0HxemTnUcBdBI6FPXncZY38FOH8dWOwZZYu7aQdEcH7WTi9cUiv4/xFcA==
X-Received: by 2002:a2e:29da:: with SMTP id p87-v6mr21463460ljp.12.1537374651914;
        Wed, 19 Sep 2018 09:30:51 -0700 (PDT)
Received: from localhost.localdomain (31-211-229-121.customers.ownit.se. [31.211.229.121])
        by smtp.gmail.com with ESMTPSA id x8-v6sm3903594lji.53.2018.09.19.09.30.50
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-SHA bits=128/128);
        Wed, 19 Sep 2018 09:30:50 -0700 (PDT)
From:   =?UTF-8?q?Martin=20=C3=85gren?= <martin.agren@gmail.com>
To:     git@vger.kernel.org
Cc:     Derrick Stolee <stolee@gmail.com>
Subject: [PATCH 3/4] git-commit-graph.txt: refer to "*commit* graph file"
Date:   Wed, 19 Sep 2018 18:30:34 +0200
Message-Id: <65f42c947aa2b392075740673a5dc889fd6e64e6.1537374062.git.martin.agren@gmail.com>
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

This document sometimes refers to the "commit graph file" as just "the
graph file". This saves a couple of words here and there at the risk of
confusion. In particular, the documentation for `git commit-graph read`
appears to suggest that there are indeed different types of graph files.

Let's just write out the full name everywhere.

The full name, by the way, is not the "commit-graph file" with a dash,
cf. the synopsis. Use the dashless form. (The next commit will fix the
remaining few instances of the "commit-graph file" in this document.)

Signed-off-by: Martin Ågren <martin.agren@gmail.com>
---
 Documentation/git-commit-graph.txt | 14 +++++++-------
 1 file changed, 7 insertions(+), 7 deletions(-)

diff --git a/Documentation/git-commit-graph.txt b/Documentation/git-commit-graph.txt
index 6ac610f016..55f63d47d9 100644
--- a/Documentation/git-commit-graph.txt
+++ b/Documentation/git-commit-graph.txt
@@ -54,8 +54,8 @@ existing commit-graph file.
 
 'read'::
 
-Read a graph file given by the commit-graph file and output basic
-details about the graph file. Used for debugging purposes.
+Read the commit graph file and output basic details about it.
+Used for debugging purposes.
 
 'verify'::
 
@@ -73,21 +73,21 @@ EXAMPLES
 $ git commit-graph write
 ------------------------------------------------
 
-* Write a graph file, extending the current graph file using commits
-  in `<pack-index>`.
+* Write a commit graph file, extending the current commit graph file
+  using commits in `<pack-index>`.
 +
 ------------------------------------------------
 $ echo <pack-index> | git commit-graph write --stdin-packs
 ------------------------------------------------
 
-* Write a graph file containing all reachable commits.
+* Write a commit graph file containing all reachable commits.
 +
 ------------------------------------------------
 $ git show-ref -s | git commit-graph write --stdin-commits
 ------------------------------------------------
 
-* Write a graph file containing all commits in the current
-  commit-graph file along with those reachable from `HEAD`.
+* Write a commit graph file containing all commits in the current
+  commit graph file along with those reachable from `HEAD`.
 +
 ------------------------------------------------
 $ git rev-parse HEAD | git commit-graph write --stdin-commits --append
-- 
2.19.0.216.g2d3b1c576c

