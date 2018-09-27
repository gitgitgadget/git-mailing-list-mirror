Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.1 (2015-04-28) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-3.8 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,RCVD_IN_DNSWL_HI
	shortcircuit=no autolearn=ham autolearn_force=no version=3.4.1
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 2DEE41F453
	for <e@80x24.org>; Thu, 27 Sep 2018 19:12:48 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728729AbeI1Bcb (ORCPT <rfc822;e@80x24.org>);
        Thu, 27 Sep 2018 21:32:31 -0400
Received: from mail-lj1-f195.google.com ([209.85.208.195]:33351 "EHLO
        mail-lj1-f195.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1728500AbeI1Bca (ORCPT <rfc822;git@vger.kernel.org>);
        Thu, 27 Sep 2018 21:32:30 -0400
Received: by mail-lj1-f195.google.com with SMTP id l19-v6so3541664ljb.0
        for <git@vger.kernel.org>; Thu, 27 Sep 2018 12:12:45 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=BYp368BDaaopBicc4/f1CJmNtkArAaZnpIlapJUV+7o=;
        b=hcKXkn6nGu7PP52zGkKu1DST4W2H57ebsf2Fwjh43JrPWnLlqmWYzXYR8wDhJkIN6h
         T4inNOfnquyMSWroCoPkaW6CzvK7US65sBrWjssvJgP+eIl9PEHu6Kra+H2dcpfPy3Ba
         22l4faLzMhjyrEivWZOt95ttYe95DFUVHX/yUzqXMDrmP29RI180TuokSFBbC4cxVoss
         zOcpcrzX5cRMk+uk/Br6uQiv6likGuBlR0OTAgcbuvMIvq25o4rpnuNBQOHbyHdBJLKJ
         QrddxcG8Sch6/K14g66TvAa7EBS2NOBYydXsd0wl2B1PdBDHYOz1941umfdcgtDWNPHx
         k80Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=BYp368BDaaopBicc4/f1CJmNtkArAaZnpIlapJUV+7o=;
        b=tXC3DSKilDCmpZRGkNwXQJs1NjWHlrl8FsZLaPIY6U/YyuyOCzDYaSvdZ6V5VGe8Fp
         EamKhADcj7cTuNqVISmUdkWT5s8hguBgG4XHvTC+sciyNmQazdFqIqfsq80BToIrKOCx
         wCa3VKh6/Q+RkT4J6KJggcPblXXVu/iK8Nbi7eNnj2/Q5U8KVbkuugB2lCRp5Uay4OEU
         pKWbHSEi12j4met331Tt+9j8Zx5/HR8BHrGlV7nZogrvKknln7iFBQ7d6u0XAX+e+XWx
         AToJqb7I10BqtGyQ1wuENinUSe2UyPD3lF0wwvyjF9ofHtMK4XlHQ5pcU0ahFbdLclW/
         E6BA==
X-Gm-Message-State: ABuFfoilmMTithj71KlvG/KMhNNwXKo7ZcRc5AJ/Ig0atu7BuuXSFcrK
        nbNakfFYLFgYX25dkaDzl/pebtVv
X-Google-Smtp-Source: ACcGV62uEO8/J8npep1W2LqSg73fow9oG7Z1gmY+iZOkGXMfCYEcsRzgwIN1h9Whn1qChe1kHFFR/A==
X-Received: by 2002:a2e:5215:: with SMTP id g21-v6mr6586878ljb.144.1538075564177;
        Thu, 27 Sep 2018 12:12:44 -0700 (PDT)
Received: from localhost.localdomain (31-211-229-121.customers.ownit.se. [31.211.229.121])
        by smtp.gmail.com with ESMTPSA id r79-v6sm561673ljb.84.2018.09.27.12.12.43
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-SHA bits=128/128);
        Thu, 27 Sep 2018 12:12:43 -0700 (PDT)
From:   =?UTF-8?q?Martin=20=C3=85gren?= <martin.agren@gmail.com>
To:     git@vger.kernel.org
Cc:     Derrick Stolee <stolee@gmail.com>
Subject: [PATCH v2 3/4] git-commit-graph.txt: refer to "*commit*-graph file"
Date:   Thu, 27 Sep 2018 21:12:21 +0200
Message-Id: <759bc886d84e3b38d48e3fce7956a517f9055462.1538075326.git.martin.agren@gmail.com>
X-Mailer: git-send-email 2.19.0.216.g2d3b1c576c
In-Reply-To: <cover.1538075326.git.martin.agren@gmail.com>
References: <6b1cb43e-a1a8-921f-cd66-3697609854e0@gmail.com> <cover.1538075326.git.martin.agren@gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

This document sometimes refers to the "commit-graph file" as just "the
graph file". This saves a couple of words here and there at the risk of
confusion. In particular, the documentation for `git commit-graph read`
appears to suggest that there are indeed different types of graph files.

Let's just write out the full name everywhere.

The full name, by the way, is not the dash-less "commit graph file".
Use the dashed form. (The next commit will fix the remaining few
instances of the "commit graph file" in this document.)

Signed-off-by: Martin Ågren <martin.agren@gmail.com>
---
 Documentation/git-commit-graph.txt | 12 ++++++------
 1 file changed, 6 insertions(+), 6 deletions(-)

diff --git a/Documentation/git-commit-graph.txt b/Documentation/git-commit-graph.txt
index 6ac610f016..f33330a171 100644
--- a/Documentation/git-commit-graph.txt
+++ b/Documentation/git-commit-graph.txt
@@ -54,8 +54,8 @@ existing commit-graph file.
 
 'read'::
 
-Read a graph file given by the commit-graph file and output basic
-details about the graph file. Used for debugging purposes.
+Read the commit-graph file and output basic details about it.
+Used for debugging purposes.
 
 'verify'::
 
@@ -73,20 +73,20 @@ EXAMPLES
 $ git commit-graph write
 ------------------------------------------------
 
-* Write a graph file, extending the current graph file using commits
-  in `<pack-index>`.
+* Write a commit-graph file, extending the current commit-graph file
+  using commits in `<pack-index>`.
 +
 ------------------------------------------------
 $ echo <pack-index> | git commit-graph write --stdin-packs
 ------------------------------------------------
 
-* Write a graph file containing all reachable commits.
+* Write a commit-graph file containing all reachable commits.
 +
 ------------------------------------------------
 $ git show-ref -s | git commit-graph write --stdin-commits
 ------------------------------------------------
 
-* Write a graph file containing all commits in the current
+* Write a commit-graph file containing all commits in the current
   commit-graph file along with those reachable from `HEAD`.
 +
 ------------------------------------------------
-- 
2.19.0.216.g2d3b1c576c

