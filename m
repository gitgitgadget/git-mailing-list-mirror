Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.2 (2018-09-13) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-3.9 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,RCVD_IN_DNSWL_HI,
	SPF_HELO_NONE,SPF_NONE shortcircuit=no autolearn=ham
	autolearn_force=no version=3.4.2
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id EE2461F4C0
	for <e@80x24.org>; Fri, 25 Oct 2019 15:23:33 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2440674AbfJYPXd (ORCPT <rfc822;e@80x24.org>);
        Fri, 25 Oct 2019 11:23:33 -0400
Received: from mail-wr1-f42.google.com ([209.85.221.42]:36674 "EHLO
        mail-wr1-f42.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1731333AbfJYPXc (ORCPT <rfc822;git@vger.kernel.org>);
        Fri, 25 Oct 2019 11:23:32 -0400
Received: by mail-wr1-f42.google.com with SMTP id w18so2809363wrt.3
        for <git@vger.kernel.org>; Fri, 25 Oct 2019 08:23:30 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=message-id:in-reply-to:references:from:date:subject:fcc
         :content-transfer-encoding:mime-version:to:cc;
        bh=ujKxVGynczY4ABWs8fZ0lkuNrUBD3aj+g2NriNOdiyU=;
        b=D734yqr8vAvaBGnbazYnRAj5PjqHibuaYZ+rwUi5cHP4X/nNbF6bnvl1cU1fbLCUKS
         3kt3WhCyQYL9sbPDSpNRpmi4sGYZ5zK5udj0WJHcQU9tMw4dPNPFMOBytwx7JEfcCbqv
         JbsYw4WIG055b4X6jmkjoSkYRWsXteXFSstV9rD7F+u+lUpw6rydjOdmcEL+qhEEA5rk
         g45PTSUXV8NPeDzfKHyXq4fBIK1qLwKk9tAWRO+MHW5mIMOEAl/5OwTG7RnGDgNDPMxc
         ZtsMHUK66EBllVUstV0LY4TLcF4BcjLsXUXlQWpH+r2OlSlj/PnbVXrVD4itHj3eh72O
         kdSg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:message-id:in-reply-to:references:from:date
         :subject:fcc:content-transfer-encoding:mime-version:to:cc;
        bh=ujKxVGynczY4ABWs8fZ0lkuNrUBD3aj+g2NriNOdiyU=;
        b=fvAZh3xQw4oD3gevEW9OJy8CGqnS6/EafwDhKvbX+Z2iiVZNoKG8db+wALJW8z5JIA
         Lup9cnK88fkx0/78ggmGHYrduKQrNX4CRyvePXT9/bC3zYXiZTV6QnPWo912hv+IwZI2
         XlF11NwWwdE4TH2mwTwv3nW93c4f2y3qdIvDpfwdqs3XthtqvaIZzNPkQcrk8UgydwRE
         aBtvhCFRuSijXMGiil6GeDKcIy8Ixlt5FrpptKt8Q/6p/ThQc3nnoi8wlfpmT3Q//dQN
         W9KKHE/PnFP+JSVf2Pkuej5F7F03t1TT9O6xRG/DjEtHIh7E/cwPvTpMX8kM/YEQfdwO
         0Gww==
X-Gm-Message-State: APjAAAXOyc45ousQ+Ak+EoQ2z/a4LjlOGzYdwnS9R4W2ghPeSb+3/4d4
        vyzp1GplK568uCGJCBzHpUP2tCBQ
X-Google-Smtp-Source: APXvYqy9BmwPbYR6COWLiJrpclNExPv0B/hIQwnIDLZ2JZjE6YhizzOAt5x+3Mwbt3Bla41jtwyxBQ==
X-Received: by 2002:a5d:46c6:: with SMTP id g6mr3397099wrs.331.1572017009923;
        Fri, 25 Oct 2019 08:23:29 -0700 (PDT)
Received: from [127.0.0.1] ([13.74.141.28])
        by smtp.gmail.com with ESMTPSA id t10sm2650976wrw.23.2019.10.25.08.23.29
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Fri, 25 Oct 2019 08:23:29 -0700 (PDT)
Message-Id: <609c7c5047719a619ba22425dafc6ecd105e2cda.1572017008.git.gitgitgadget@gmail.com>
In-Reply-To: <pull.424.git.1572017008.gitgitgadget@gmail.com>
References: <pull.424.git.1572017008.gitgitgadget@gmail.com>
From:   "Utsav Shah via GitGitGadget" <gitgitgadget@gmail.com>
Date:   Fri, 25 Oct 2019 15:23:28 +0000
Subject: [PATCH 1/1] unpack-trees: skip lstat based on fsmonitor
Fcc:    Sent
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
MIME-Version: 1.0
To:     git@vger.kernel.org
Cc:     Utsav Shah <ukshah2@illinois.edu>,
        Junio C Hamano <gitster@pobox.com>,
        Utsav Shah <utsav@dropbox.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

From: Utsav Shah <utsav@dropbox.com>

git stash runs git reset --hard as its final step, which can be fairly slow on a large repository.
This change lets us skip that if fsmonitor thinks those files aren't modified.

git stash goes from ~8s -> 2s on my repository after this change.

Signed-off-by: Utsav Shah <utsav@dropbox.com>
---
 unpack-trees.c | 3 ++-
 1 file changed, 2 insertions(+), 1 deletion(-)

diff --git a/unpack-trees.c b/unpack-trees.c
index 33ea7810d8..5d07a2d0ea 100644
--- a/unpack-trees.c
+++ b/unpack-trees.c
@@ -2384,7 +2384,8 @@ int oneway_merge(const struct cache_entry * const *src,
 
 	if (old && same(old, a)) {
 		int update = 0;
-		if (o->reset && o->update && !ce_uptodate(old) && !ce_skip_worktree(old)) {
+		if (o->reset && o->update && !ce_uptodate(old) && !ce_skip_worktree(old) &&
+		    !(old->ce_flags & CE_FSMONITOR_VALID)) {
 			struct stat st;
 			if (lstat(old->name, &st) ||
 			    ie_match_stat(o->src_index, old, &st, CE_MATCH_IGNORE_VALID|CE_MATCH_IGNORE_SKIP_WORKTREE))
-- 
gitgitgadget
