Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.2 (2018-09-13) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-4.0 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,RCVD_IN_DNSWL_HI
	shortcircuit=no autolearn=ham autolearn_force=no version=3.4.2
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 74B9A20A1E
	for <e@80x24.org>; Mon, 10 Dec 2018 16:42:46 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727081AbeLJQmp (ORCPT <rfc822;e@80x24.org>);
        Mon, 10 Dec 2018 11:42:45 -0500
Received: from mail-pg1-f193.google.com ([209.85.215.193]:42747 "EHLO
        mail-pg1-f193.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726324AbeLJQmo (ORCPT <rfc822;git@vger.kernel.org>);
        Mon, 10 Dec 2018 11:42:44 -0500
Received: by mail-pg1-f193.google.com with SMTP id d72so5207490pga.9
        for <git@vger.kernel.org>; Mon, 10 Dec 2018 08:42:43 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=date:message-id:in-reply-to:references:from:subject:fcc
         :content-transfer-encoding:mime-version:to:cc;
        bh=aLCmeJILac5nyqonbwT1acf2FFSAn5nVl5CRTaaC4tQ=;
        b=n+tQ1PTFOQtFHsWbsosHMruI8vFf1ePf/zoBwPiLubAj4UumHC+Q0OWkVJH+9t5BE+
         xP1TPxLQHCDfUhjnClLvmW4QtQzCxxBQd6ORZnBvOnw7A7PFPjcR9+dgWn6uI0y7M3QH
         8MGigZcCjTwkIgztXn+M4akYKSjYutTLNLxq2qEM3KNSIjw78iBnCF40pTTlvHijOIVO
         t2t3QoD31WpSZv7xO4O45e9R0kJfmZj6AleytLFkeSzHOVnPST5Cia+yoW9D50Z6ryNK
         /l/kxjbQHhwQraWyr25eSBhcAyc8TJgeRTiBbAQb4a4so3LBtEcrDzYbOjPP0q0Bi9gI
         BgWQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:message-id:in-reply-to:references:from
         :subject:fcc:content-transfer-encoding:mime-version:to:cc;
        bh=aLCmeJILac5nyqonbwT1acf2FFSAn5nVl5CRTaaC4tQ=;
        b=UFAl2thSN6MjjieXIw/mxVsQANs5u7lH36NV+lnjrZLz93hB92XQ5v8ah6jH/jOFwx
         RsCWYJS6yIWZL4QdURGwcuAsLZZBKd+dJcZXxCEGirKUXJw4Ig9wvi0Vel5gIsnnpqe8
         VAONPiM5uK3AID3Z2WryUJZ3vARTNsz6VRYFn0yexQvqBJ2NSayro0LLsLIlbQ3ENThJ
         cb+W9EANjGY2ql0Hb1R0wmkGO667qYyi3ObKlz9r2d5jw/wK6gZSGKDL2OiaYC2l9A7R
         Km0WmRQnzEE6QGJ+CEa3/itcyDRxdxL8PutkWvmMWbshZBykA/gccNzcJBGLzpPZ6sk9
         c0Ew==
X-Gm-Message-State: AA+aEWbC6sFVmbEtAgRfypdJgbBL/o1u1JMB6fh6+bjyvq5ETA1rer2M
        1SbIXmp9aWJB6ES0FSWj5tyWNgMX
X-Google-Smtp-Source: AFSGD/Vx+xDl6JgrtohIcKOTq4suxQMHxYH63nSJQONfEtM1hp3hFG4bpwnt4iKOifSu/ZQabecAJg==
X-Received: by 2002:a63:db48:: with SMTP id x8mr11107566pgi.365.1544460162560;
        Mon, 10 Dec 2018 08:42:42 -0800 (PST)
Received: from [127.0.0.1] ([40.112.139.188])
        by smtp.gmail.com with ESMTPSA id g26sm15109173pfh.61.2018.12.10.08.42.41
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Mon, 10 Dec 2018 08:42:42 -0800 (PST)
Date:   Mon, 10 Dec 2018 08:42:42 -0800 (PST)
X-Google-Original-Date: Mon, 10 Dec 2018 16:42:33 GMT
Message-Id: <60617681f7daee2a94ff23f91b09b02d58fbc3df.1544460159.git.gitgitgadget@gmail.com>
In-Reply-To: <pull.89.v3.git.gitgitgadget@gmail.com>
References: <pull.89.v2.git.gitgitgadget@gmail.com>
        <pull.89.v3.git.gitgitgadget@gmail.com>
From:   "Derrick Stolee via GitGitGadget" <gitgitgadget@gmail.com>
Subject: [PATCH v3 1/6] revision: add mark_tree_uninteresting_sparse
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

