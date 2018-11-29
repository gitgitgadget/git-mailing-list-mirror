Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.2 (2018-09-13) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-3.9 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,RCVD_IN_DNSWL_HI
	shortcircuit=no autolearn=ham autolearn_force=no version=3.4.2
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 611D4211B3
	for <e@80x24.org>; Thu, 29 Nov 2018 14:51:39 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1732503AbeK3B3f (ORCPT <rfc822;e@80x24.org>);
        Thu, 29 Nov 2018 20:29:35 -0500
Received: from mail-pg1-f193.google.com ([209.85.215.193]:45399 "EHLO
        mail-pg1-f193.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1732472AbeK3B3e (ORCPT <rfc822;git@vger.kernel.org>);
        Thu, 29 Nov 2018 20:29:34 -0500
Received: by mail-pg1-f193.google.com with SMTP id y4so988977pgc.12
        for <git@vger.kernel.org>; Thu, 29 Nov 2018 06:24:03 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=date:message-id:in-reply-to:references:from:subject:fcc
         :content-transfer-encoding:mime-version:to:cc;
        bh=aLCmeJILac5nyqonbwT1acf2FFSAn5nVl5CRTaaC4tQ=;
        b=eadi5DXb/S6xyLaVm7rcxf1aLc9Ho6o5r1bpnHICJJZKAhNQ3XZqNIC29C1FLukWTF
         3A6DD48VCz2pvmUXMsyB9t62CTJMiDrfrAGCja4Cy8g62V3Ee6z2+S7HfH4QqlmLF3uN
         VFhTRsRDyfJXxKNhu4RFb66k3j5Dfz0S4eAJE/tlWrlUZIRv2LOGBDDRkSCAeKzueT5k
         /cCfqBJWmNa0vRy+ivcRYVcQ3IUimJVq1ND+Iqcxr5BeTqk5F7vuwkhsD/6O6M/2K4sy
         kPj/iUuUzM9t5NDA4vkNWdWZUANJMvw1vPcL9exAIArZ90HZbb9JrP7rjNqTI2cwEHXk
         ziYQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:message-id:in-reply-to:references:from
         :subject:fcc:content-transfer-encoding:mime-version:to:cc;
        bh=aLCmeJILac5nyqonbwT1acf2FFSAn5nVl5CRTaaC4tQ=;
        b=AEGeVfk6zcPzwwagnK4IiDyjy7iMW2WKe700Qn2dt/A2uYFCqRt/VMlRl0rChzZ3xU
         rKY84EDAWy5BR8lINEk0bWfE2xEwVG3O3R8AlWVD6I/6YlhfGwJdSy1/T3NiUn0BhlCo
         KdoNYXmJ7I3omAO5bO8fAGNQ9QCCyvOSbSEUDdfHSRFU5Q6tETe1jZy+ElU9EqPGvvYp
         DCChuUChSIsE7LFK3VvikdY4cJdxEepiHNfiBb5ZIAQQGIbLW/OYDcIbZz6HVR1cIomn
         p/5hb4qFvmZnkrCXzRKcewfp3qaDebw5Mcni2bcCcChLpytTke+DwfjCToLHcJ2/coAa
         jJ5w==
X-Gm-Message-State: AA+aEWYye9NDDi6FDMLyix4pror//GDJ8AFOq2F5MFtc855+TONy4nzQ
        HXf7wlnxHb7VdoU7CfNCKH5d7xiC
X-Google-Smtp-Source: AFSGD/Vq9a8B8Zhm/ujukiViWC2vVJEyknykiKfz5bYovwMvX5hplWoXs1PIArb9v85l1zfUSrKr6g==
X-Received: by 2002:a63:c303:: with SMTP id c3mr1421500pgd.268.1543501442381;
        Thu, 29 Nov 2018 06:24:02 -0800 (PST)
Received: from [127.0.0.1] ([40.112.139.188])
        by smtp.gmail.com with ESMTPSA id k137sm6542313pfd.56.2018.11.29.06.24.01
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Thu, 29 Nov 2018 06:24:01 -0800 (PST)
Date:   Thu, 29 Nov 2018 06:24:01 -0800 (PST)
X-Google-Original-Date: Thu, 29 Nov 2018 14:23:53 GMT
Message-Id: <60617681f7daee2a94ff23f91b09b02d58fbc3df.1543501438.git.gitgitgadget@gmail.com>
In-Reply-To: <pull.89.v2.git.gitgitgadget@gmail.com>
References: <pull.89.git.gitgitgadget@gmail.com>
        <pull.89.v2.git.gitgitgadget@gmail.com>
From:   "Derrick Stolee via GitGitGadget" <gitgitgadget@gmail.com>
Subject: [PATCH v2 1/6] revision: add mark_tree_uninteresting_sparse
Fcc:    Sent
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
MIME-Version: 1.0
To:     git@vger.kernel.org
Cc:     peff@peff.net, avarab@gmail.com, jrnieder@gmail.com,
        Junio C Hamano <gitster@pobox.com>,
        Derrick Stolee <dstolee@microsoft.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

From: Derrick Stolee <dstolee@microsoft.com>

In preparation for a new algorithm that walks fewer trees when
creating a pack from a set of revisions, create a method that
takes an oidset of tree oids and marks reachable objects as
UNINTERESTING.

The current implementation uses the existing
mark_tree_uninteresting to recursively walk the trees and blobs.
This will walk the same number of trees as the old mechanism.

There is one new assumption in this approach: we are also given
the oids of the interesting trees. This implementation does not
use those trees at the moment, but we will use them in a later
rewrite of this method.

Signed-off-by: Derrick Stolee <dstolee@microsoft.com>
---
 revision.c | 22 ++++++++++++++++++++++
 revision.h |  2 ++
 2 files changed, 24 insertions(+)

diff --git a/revision.c b/revision.c
index 13e0519c02..3a62c7c187 100644
--- a/revision.c
+++ b/revision.c
@@ -99,6 +99,28 @@ void mark_tree_uninteresting(struct repository *r, struct tree *tree)
 	mark_tree_contents_uninteresting(r, tree);
 }
 
+void mark_trees_uninteresting_sparse(struct repository *r,
+				     struct oidset *set)
+{
+	struct object_id *oid;
+	struct oidset_iter iter;
+
+	oidset_iter_init(set, &iter);
+	while ((oid = oidset_iter_next(&iter))) {
+		struct tree *tree = lookup_tree(r, oid);
+
+		if (tree->object.flags & UNINTERESTING) {
+			/*
+			 * Remove the flag so the next call
+			 * is not a no-op. The flag is added
+			 * in mark_tree_unintersting().
+			 */
+			tree->object.flags ^= UNINTERESTING;
+			mark_tree_uninteresting(r, tree);
+		}
+	}
+}
+
 struct commit_stack {
 	struct commit **items;
 	size_t nr, alloc;
diff --git a/revision.h b/revision.h
index 7987bfcd2e..f828e91ae9 100644
--- a/revision.h
+++ b/revision.h
@@ -67,6 +67,7 @@ struct rev_cmdline_info {
 #define REVISION_WALK_NO_WALK_SORTED 1
 #define REVISION_WALK_NO_WALK_UNSORTED 2
 
+struct oidset;
 struct topo_walk_info;
 
 struct rev_info {
@@ -327,6 +328,7 @@ void put_revision_mark(const struct rev_info *revs,
 
 void mark_parents_uninteresting(struct commit *commit);
 void mark_tree_uninteresting(struct repository *r, struct tree *tree);
+void mark_trees_uninteresting_sparse(struct repository *r, struct oidset *set);
 
 void show_object_with_name(FILE *, struct object *, const char *);
 
-- 
gitgitgadget

