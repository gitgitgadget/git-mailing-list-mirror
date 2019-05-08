Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.2 (2018-09-13) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-4.1 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,RCVD_IN_DNSWL_HI
	shortcircuit=no autolearn=ham autolearn_force=no version=3.4.2
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 925CE1F45F
	for <e@80x24.org>; Wed,  8 May 2019 15:54:06 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727803AbfEHPyC (ORCPT <rfc822;e@80x24.org>);
        Wed, 8 May 2019 11:54:02 -0400
Received: from mail-ed1-f68.google.com ([209.85.208.68]:38586 "EHLO
        mail-ed1-f68.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727789AbfEHPyB (ORCPT <rfc822;git@vger.kernel.org>);
        Wed, 8 May 2019 11:54:01 -0400
Received: by mail-ed1-f68.google.com with SMTP id w11so22544593edl.5
        for <git@vger.kernel.org>; Wed, 08 May 2019 08:53:58 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=date:message-id:in-reply-to:references:from:subject:fcc
         :content-transfer-encoding:mime-version:to:cc;
        bh=u4ixA6cL4d6UOdjV2bQFXULdiUyUn8K4peeX3N9fqwk=;
        b=Qi5DJWsJMaKBnFLH2sksurZ3DWzBGgkG7SuI7Xrx16Bphpwi3FBTP1Hpge5JmEnIs0
         K4Oo3nAgqX9xrT7FZChMQPcZr+LSoLnJNPkvFAJxIzggeamOeS4kIZyM19frJMCgHsDt
         91mlfopgAGPPAteR2G+lQAoLmXY9CRt0YMFaQjE8nh7SHQBazKKK6DAnFuq/WYKQwXXZ
         sNVNfgTL9fB4+I5Qek6SRRzPtJiKLhbbYFlU+k70DqMP4F5fXVvStTJLDdRYDNUN+Q+h
         ZIy8GU8i/ltCt2rVS22/DV4in3JuKCfZWjZHNLlk+YgMQK7xpT9zEEKED62NNI8N4qyn
         Y+Bg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:message-id:in-reply-to:references:from
         :subject:fcc:content-transfer-encoding:mime-version:to:cc;
        bh=u4ixA6cL4d6UOdjV2bQFXULdiUyUn8K4peeX3N9fqwk=;
        b=NM8uXN/uGCKq2NkgYOCB2QwQmcSHQqDB/LU+ktfN376d53WJNwr8qFZAO4mJC5yHqA
         Kg/uYDAxz69KtvPP/vZsUlGJV65t8iS0Esh+F/Pu8pNvIdAemCZ2rhDijZaP6T+OE6eK
         zKA9LZEApnkBoYYYHw4axEuhxTfTgixZfJ0apLLxTJDXyuQnYJxnIbL4h/wPgk/TLVJW
         23ujqRh5ZjGeUqoMGlJwB9E87cOECM0FDtGYbdtJTUbc5ofrzTbG1qqZ46pVyfKgGCyX
         B2bVrrrgeMWPT62IkpBR4KLgtUqKNPLTyxQ8FQKrakUdf9CmCsLdKInaoq5SQPm2QTmC
         9oaQ==
X-Gm-Message-State: APjAAAWNX6C3dhA0tnqUOntZK7D5+dFbOFwNKFjD7FKCRdnONNVHq4fU
        tJ6AhLlWnJhYnPa+Kgs1EiOpbsJdrSg=
X-Google-Smtp-Source: APXvYqyG3ehoc1ztMQ0fvpckm47Z2BHcBFxg3NR9zupv5v9rvULpKIaGXK2eLW7UjXgd7wvYPdaUpQ==
X-Received: by 2002:a50:b19a:: with SMTP id m26mr40826616edd.243.1557330838001;
        Wed, 08 May 2019 08:53:58 -0700 (PDT)
Received: from [127.0.0.1] ([13.74.141.28])
        by smtp.gmail.com with ESMTPSA id c9sm1573336ejb.82.2019.05.08.08.53.57
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Wed, 08 May 2019 08:53:57 -0700 (PDT)
Date:   Wed, 08 May 2019 08:53:57 -0700 (PDT)
X-Google-Original-Date: Wed, 08 May 2019 15:53:41 GMT
Message-Id: <7bbe8d9150a623ea684c94d129eda1607dd32a79.1557330827.git.gitgitgadget@gmail.com>
In-Reply-To: <pull.184.git.gitgitgadget@gmail.com>
References: <pull.184.git.gitgitgadget@gmail.com>
From:   "Derrick Stolee via GitGitGadget" <gitgitgadget@gmail.com>
Subject: [PATCH 12/17] Documentation: describe split commit-graphs
Fcc:    Sent
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
MIME-Version: 1.0
To:     git@vger.kernel.org
Cc:     peff@peff.net, avarab@gmail.com, git@jeffhostetler.com,
        jrnieder@google.com, steadmon@google.com,
        Junio C Hamano <gitster@pobox.com>,
        Derrick Stolee <dstolee@microsoft.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

From: Derrick Stolee <dstolee@microsoft.com>

The design for the split commit-graphs uses file names to force
a "stack" of commit-graph files. This allows incremental writes
without updating the file format.

Signed-off-by: Derrick Stolee <dstolee@microsoft.com>
---
 Documentation/technical/commit-graph.txt | 142 +++++++++++++++++++++++
 1 file changed, 142 insertions(+)

diff --git a/Documentation/technical/commit-graph.txt b/Documentation/technical/commit-graph.txt
index fb53341d5e..ca1661d2d8 100644
--- a/Documentation/technical/commit-graph.txt
+++ b/Documentation/technical/commit-graph.txt
@@ -127,6 +127,148 @@ Design Details
   helpful for these clones, anyway. The commit-graph will not be read or
   written when shallow commits are present.
 
+Split Commit Graphs
+-------------------
+
+Typically, repos grow with near-constant velocity (commits per day). Over
+time, the number of commits added by a fetch operation is much smaller than
+the number of commits in the full history. The split commit-graph feature
+allows for fast writes of new commit data without rewriting the entire
+commit history -- at least, most of the time.
+
+## File Layout
+
+A split commit-graph uses multiple files, and we use a fixed naming
+convention to organize these files. The base commit-graph file is the
+same: `$OBJDIR/info/commit-graph`. The rest of the commit-graph files have
+the format `$OBJDIR/info/commit-graphs/commit-graph-<N>` where N is a
+positive integer. The integers must start at 1 and grow sequentially
+to form a stack of files.
+
+Each `commit-graph-<N>` file has the same format as the `commit-graph`
+file, including a lexicographic list of commit ids. The only difference
+is that this list is considered to be concatenated to the list from
+the lower commit-graphs. As an example, consider this diagram of three
+files:
+
+ +-----------------------+
+ |  commit-graph-2       |
+ +-----------------------+
+	  |
+ +-----------------------+
+ |                       |
+ |  commit-graph-1       |
+ |                       |
+ +-----------------------+
+	  |
+ +-----------------------+
+ |                       |
+ |                       |
+ |                       |
+ |  commit-graph         |
+ |                       |
+ |                       |
+ |                       |
+ +-----------------------+
+
+Let X0 be the number of commits in `commit-graph`, X1 be the number
+of commits in commit-graph-1, and X2 be the number of commits in
+commit-graph-2. If a commit appears in position i in `commit-graph-2`,
+then we interpret this as being the commit in position (X0 + X1 + i),
+and that will be used as its "graph position". The commits in
+commit-graph-2 use these positions to refer to their parents, which
+may be in commit-graph-1 or commit-graph. We can navigate to an
+arbitrary commit in position j by checking its containment in the
+intervals [0, X0), [X0, X0 + X1), [X0 + X1, X0 + X1 + X2).
+
+When Git reads from these files, it starts by acquiring a read handle
+on the `commit-graph` file. On success, it continues acquiring read
+handles on the `commit-graph-<N>` files in increasing order. This
+order is important for how we replace the files.
+
+## Merging commit-graph files
+
+If we only added a `commit-graph-<N>` file on every write, we would
+run into a linear search problem through many commit-graph files.
+Instead, we use a merge strategy to decide when the stack should
+collapse some number of levels.
+
+The diagram below shows such a collapse. As a set of new commits
+are added, it is determined by the merge strategy that the files
+should collapse to `commit-graph-1`. Thus, the new commits, the
+commits in `commit-graph-2` and the commits in `commit-graph-1`
+should be combined into a new `commit-graph-1` file.
+
+			    +---------------------+
+			    |                     |
+			    |    (new commits)    |
+			    |                     |
+			    +---------------------+
+			    |                     |
+ +-----------------------+  +---------------------+
+ |  commit-graph-2       |->|                     |
+ +-----------------------+  +---------------------+
+	  |                 |                     |
+ +-----------------------+  +---------------------+
+ |                       |  |                     |
+ |  commit-graph-1       |->|                     |
+ |                       |  |                     |
+ +-----------------------+  +---------------------+
+	  |                   commit-graph-1.lock
+ +-----------------------+
+ |                       |
+ |                       |
+ |                       |
+ |  commit-graph         |
+ |                       |
+ |                       |
+ |                       |
+ +-----------------------+
+
+During this process, the commits to write are combined, sorted
+and we write the contents to the `commit-graph-1.lock` file.
+When the file is flushed and ready to swap to `commit-graph-1`,
+we first unlink the files above our target file. This unlinking
+is done from the top of the stack, the reverse direction that
+another process would use to read the stack.
+
+During this time window, another process trying to read the
+commit-graph stack could read `commit-graph-1` before the swap
+but try to read `commit-graph-2` after it is unlinked. That
+process would then believe that this stack is complete, but
+will miss out on the performance benefits of the commits in
+`commit-graph-2`. For this reason, the stack above the
+`commit-graph` file should be small.
+
+## Merge Strategy
+
+When writing a set of commits that do not exist in the
+commit-graph stack of height N, we default to creating
+a new file at level N + 1. We then decide to merge
+with the Nth level if one of two conditions hold:
+
+  1. The expected file size for level N + 1 is at
+     least half the file size for level N.
+
+  2. Level N + 1 contains more than MAX_SPLIT_COMMITS
+     commits (64,0000 commits).
+
+This decision cascades down the levels: when we
+merge a level we create a new set of commits that
+then compares to the next level.
+
+The first condition bounds the number of levels
+to be logarithmic in the total number of commits.
+The second condition bounds the total number of
+commits in a `commit-graph-N` file and not in
+the `commit-graph` file, preventing significant
+performance issues when the stack merges and another
+process only partially reads the previous stack.
+
+The merge strategy values (2 for the size multiple,
+64,000 for the maximum number of commits) could be
+extracted into config settings for full flexibility.
+
 Related Links
 -------------
 [0] https://bugs.chromium.org/p/git/issues/detail?id=8
-- 
gitgitgadget

