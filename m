Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.2 (2018-09-13) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-4.0 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,RCVD_IN_DNSWL_HI
	shortcircuit=no autolearn=ham autolearn_force=no version=3.4.2
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 5320F20A1E
	for <e@80x24.org>; Fri, 14 Dec 2018 21:22:21 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1730878AbeLNVWS (ORCPT <rfc822;e@80x24.org>);
        Fri, 14 Dec 2018 16:22:18 -0500
Received: from mail-pl1-f196.google.com ([209.85.214.196]:41463 "EHLO
        mail-pl1-f196.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1730757AbeLNVWS (ORCPT <rfc822;git@vger.kernel.org>);
        Fri, 14 Dec 2018 16:22:18 -0500
Received: by mail-pl1-f196.google.com with SMTP id u6so3268257plm.8
        for <git@vger.kernel.org>; Fri, 14 Dec 2018 13:22:18 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=date:message-id:in-reply-to:references:from:subject:fcc
         :content-transfer-encoding:mime-version:to:cc;
        bh=smeXURi/u0iK79nW/TraNNVKmeWz4ffKO/q0cymuqXU=;
        b=Z+9/DwmG9cRp/9vy4C8cm60tKZiPI/KJN4f2Uc4ECnx0wPAbPBksIAZXD1zYQFiVbl
         gZ2jlSzhen/xX62v225Lf4FdxpBFbVHWy262i/uF+l7A/5Pgxwwq7W2rWMWRVx1j3kOR
         zQhe7sog/pwBFDhCh4McrV0GSMgeNNyVOQIMPi5ktiD3bsC9XfDFdL+Vix10MG0obIAy
         gU6dmsbRbKN3ecksvpCwHYgoPtQFscplyhUHf9QUP6+tQxoihD0wN9vXaf8Jny8tPI10
         IIUNsNUE265+EyeWyYZr0luqvninPxBlcaSKjzvmpHEesFNFJMxZbYr8+pnLOJUHWUzb
         J1lg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:message-id:in-reply-to:references:from
         :subject:fcc:content-transfer-encoding:mime-version:to:cc;
        bh=smeXURi/u0iK79nW/TraNNVKmeWz4ffKO/q0cymuqXU=;
        b=aWhZzHE2tEzbG72eOb2plFVLXhHphN0mBR/XqIWYBS2O0G69Hcl2eOQxt2zWhGtpmp
         G7Q6TdJywmel9v6uoo27CjRrq0oTC9VqJOmpXk/Ni7InlUB6+x5kmj61FaqWrPMVo6Wj
         6Wjmf9wDJcCvUDB1ZIcwDffBluawdvk8Yml5K76pV5ybxrJxAekU4//ImaKQEiJdo59g
         PJLkTJ2mbKXULd0X2LnXOaX2L7MCUV5hI1o+QWhAlHqqWBH47cgGTYWXBg8Z9mOoa/Qq
         BHz+gCnz4GeS0ILjdAAVVHcF7WO8tF6mNmWJNI1oXmcchS/xP9aOXW+av+SGdOAM3pQm
         Zb8A==
X-Gm-Message-State: AA+aEWb1M+a0cxY7r7fxYhpOybB2vxUQCCTHdFMm7LaIBZ+wU2YOiFws
        Fb6ZyHyZHqkQQdUJBHwCwN4xyVKe
X-Google-Smtp-Source: AFSGD/UgDY5nKMk66RyZ1EDI1DBadYkOyeqbOzEJYqjHIXcE2KqrOFciencsNWLjiNjqByIhDMHr1w==
X-Received: by 2002:a17:902:584:: with SMTP id f4mr4503907plf.28.1544822537695;
        Fri, 14 Dec 2018 13:22:17 -0800 (PST)
Received: from [127.0.0.1] ([40.112.142.204])
        by smtp.gmail.com with ESMTPSA id f13sm7496224pfa.132.2018.12.14.13.22.16
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Fri, 14 Dec 2018 13:22:17 -0800 (PST)
Date:   Fri, 14 Dec 2018 13:22:17 -0800 (PST)
X-Google-Original-Date: Fri, 14 Dec 2018 21:22:07 GMT
Message-Id: <817e30a287e12ce8e94ce41fcb969dd8ae53b9ce.1544822533.git.gitgitgadget@gmail.com>
In-Reply-To: <pull.89.v4.git.gitgitgadget@gmail.com>
References: <pull.89.v3.git.gitgitgadget@gmail.com>
        <pull.89.v4.git.gitgitgadget@gmail.com>
From:   "Derrick Stolee via GitGitGadget" <gitgitgadget@gmail.com>
Subject: [PATCH v4 1/6] revision: add mark_tree_uninteresting_sparse
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
 revision.c | 25 +++++++++++++++++++++++++
 revision.h |  2 ++
 2 files changed, 27 insertions(+)

diff --git a/revision.c b/revision.c
index 13e0519c02..f9eb6400f1 100644
--- a/revision.c
+++ b/revision.c
@@ -99,6 +99,31 @@ void mark_tree_uninteresting(struct repository *r, struct tree *tree)
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
+		if (!tree)
+			continue;
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

