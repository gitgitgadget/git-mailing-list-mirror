Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.2 (2018-09-13) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-4.3 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,RCVD_IN_DNSWL_HI
	shortcircuit=no autolearn=ham autolearn_force=no version=3.4.2
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 14A811F62E
	for <e@80x24.org>; Wed, 16 Jan 2019 18:26:14 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728723AbfAPS0N (ORCPT <rfc822;e@80x24.org>);
        Wed, 16 Jan 2019 13:26:13 -0500
Received: from mail-ed1-f65.google.com ([209.85.208.65]:44800 "EHLO
        mail-ed1-f65.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1728671AbfAPS0A (ORCPT <rfc822;git@vger.kernel.org>);
        Wed, 16 Jan 2019 13:26:00 -0500
Received: by mail-ed1-f65.google.com with SMTP id y56so6195051edd.11
        for <git@vger.kernel.org>; Wed, 16 Jan 2019 10:25:59 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=date:message-id:in-reply-to:references:from:subject:fcc
         :content-transfer-encoding:mime-version:to:cc;
        bh=sKqpJiddQsIhJyLblShqc1itnXeinOHQo+qEu4z8V7Y=;
        b=X1SQZdpuIknBCUofEzSvDf26T2KqEb3vfN8lYoFzabbVLPQF3iiKEhjEx274927p6P
         ODXvGozwSEUpor9rxOp2r/IFpbhPagmm98j5rJBHsw7jIY29f9JUb5Dpn+lHb14/7BKq
         BCCO308f1OmhSHlppltPZr7kH8i4mJTjMVcSkSSdq7QAqbouL0WjUhQXokr1C267E/TL
         EQN1TcgVLoG9RFurdPMeuDMFubWRV6sYgT0w+BdBTflx3fGoae+GRpdED1MHiuM6RIBz
         8Dbo45eYDx5Gs/+37N6hiqYbUGAeT7TGx2fkxrfbY9sEglwEjE3O5gNG+lEOyHrPBBgL
         yPFw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:message-id:in-reply-to:references:from
         :subject:fcc:content-transfer-encoding:mime-version:to:cc;
        bh=sKqpJiddQsIhJyLblShqc1itnXeinOHQo+qEu4z8V7Y=;
        b=pBIdhJ2tI5f2liUUiFFV5vJRVXHX9L01slBNiv/kDq+Up1xurILS5QnEUJSTXU/1yr
         Ab03WiiMe6HBXo4nDKShzxLOtJlII9xxtOpoYXTW7tB4xzbB7BNC9pGIw9x9ZI+nDx8O
         UdryjvM2pJ8EFcf19+lWCqgRGUYjmb3F+xPMPW8KJ7RtmD6b345FlEyxptuOAfGLtaMX
         F58o/opLTr/Xc8KSgyiJ0rOxeFWU5cDUWbwm2aiPcZFWIYh8DOi0Pb79IIMV7TTzySgz
         KHKt/D+ynctsAGqRGL0R8GlV8OS1THqpDIZjE7/3D5u5csLxb8jMcbab76Wdl9vqG6g7
         Xk6w==
X-Gm-Message-State: AJcUukfucFZ3myOnJb/a7lSjiGGf74rGsM+uBp5HRQ1JV4YQWlW9QxuF
        0tL6xhILgBtp2KKlT/CdjHYnJys4
X-Google-Smtp-Source: ALg8bN4UFtTxvd9/Zs5IoFcORXQTjiHJlH6OaVcOMU11cSQC4q0FECxzq/T3b6AF99QoiyhAFwMMWg==
X-Received: by 2002:a50:ad0b:: with SMTP id y11mr8228601edc.113.1547663158582;
        Wed, 16 Jan 2019 10:25:58 -0800 (PST)
Received: from [127.0.0.1] ([13.74.141.28])
        by smtp.gmail.com with ESMTPSA id n10sm5597101edq.33.2019.01.16.10.25.57
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Wed, 16 Jan 2019 10:25:58 -0800 (PST)
Date:   Wed, 16 Jan 2019 10:25:58 -0800 (PST)
X-Google-Original-Date: Wed, 16 Jan 2019 18:25:51 GMT
Message-Id: <02ef702884df2ad96be25486837b4009fb997c97.1547663156.git.gitgitgadget@gmail.com>
In-Reply-To: <pull.89.v5.git.gitgitgadget@gmail.com>
References: <pull.89.v4.git.gitgitgadget@gmail.com>
        <pull.89.v5.git.gitgitgadget@gmail.com>
From:   "Derrick Stolee via GitGitGadget" <gitgitgadget@gmail.com>
Subject: [PATCH v5 1/5] revision: add mark_tree_uninteresting_sparse
Fcc:    Sent
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
MIME-Version: 1.0
To:     git@vger.kernel.org
Cc:     peff@peff.net, avarab@gmail.com, jrnieder@gmail.com,
        ramsay@ramsayjones.plus.com, Junio C Hamano <gitster@pobox.com>,
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
This will walk the same number of trees as the old mechanism. To
ensure that mark_tree_uninteresting walks the tree, we need to
remove the UNINTERESTING flag before calling the method. This
implementation will be replaced entirely in a later commit.

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
index 13e0519c02..60421f3a10 100644
--- a/revision.c
+++ b/revision.c
@@ -99,6 +99,31 @@ void mark_tree_uninteresting(struct repository *r, struct tree *tree)
 	mark_tree_contents_uninteresting(r, tree);
 }
 
+void mark_trees_uninteresting_sparse(struct repository *r,
+				     struct oidset *trees)
+{
+	struct object_id *oid;
+	struct oidset_iter iter;
+
+	oidset_iter_init(trees, &iter);
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
index 7987bfcd2e..df684701b9 100644
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
+void mark_trees_uninteresting_sparse(struct repository *r, struct oidset *trees);
 
 void show_object_with_name(FILE *, struct object *, const char *);
 
-- 
gitgitgadget

