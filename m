Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.2 (2018-09-13) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-4.2 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,RCVD_IN_DNSWL_HI,
	SPF_HELO_NONE,SPF_NONE shortcircuit=no autolearn=ham
	autolearn_force=no version=3.4.2
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 57CA01F462
	for <e@80x24.org>; Fri,  7 Jun 2019 18:38:25 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1731757AbfFGSiY (ORCPT <rfc822;e@80x24.org>);
        Fri, 7 Jun 2019 14:38:24 -0400
Received: from mail-ed1-f65.google.com ([209.85.208.65]:38631 "EHLO
        mail-ed1-f65.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1730205AbfFGSiX (ORCPT <rfc822;git@vger.kernel.org>);
        Fri, 7 Jun 2019 14:38:23 -0400
Received: by mail-ed1-f65.google.com with SMTP id g13so4346162edu.5
        for <git@vger.kernel.org>; Fri, 07 Jun 2019 11:38:22 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=date:message-id:in-reply-to:references:from:subject:fcc
         :content-transfer-encoding:mime-version:to:cc;
        bh=K4hI5VzyEmN0pp2bYyiizZjGrxQByJ3B5DXoRbPUeiA=;
        b=mlUOpY45ulRzhgv27VE90x4ysOkyz1e+Wxntp4CEUEDOyPMkEIfYLaUjjRXrrGfOib
         J9178MAJhqHEgOTovXImfhczlcaX0TSbnVwzsLso/ounv4CmpEAQF00lx+OBnMZPGCUm
         +pkuVNS6s4wO3JAhsL2CXlWfpkEZEL+DB7BeDMYpuKSS4g3aPtnyTSdvk2aO0vWZi97z
         +It3hpizlUouENW7/FryZEVF5mIAYzz/NxDtuXhmMaWp6qbpXW9fjehwnf1EgflTRfH2
         V0ZXTXsXio6wCzptx2KU73udecv/5jvY84HItlsz/bB7Y47sCE3sBqX4qaPrT8sXudfS
         oJfA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:message-id:in-reply-to:references:from
         :subject:fcc:content-transfer-encoding:mime-version:to:cc;
        bh=K4hI5VzyEmN0pp2bYyiizZjGrxQByJ3B5DXoRbPUeiA=;
        b=fYuDbd+Rz+fOLXBjh6o7HTf09/KZ1OtPKITzh1Ao8JyZtXanKP6WNJpzI7tszHX5Ya
         Ek++YFeir3sLjRr6Cc8QysASCbNxXnTMT11IQUvomJjivrTIK2ahTmJODvmW+0q0eD1W
         kuZl2GZEHqNxR9D1eVOIa4IVsahmA0ItWenbZnmr4u++beNLTJUNeAinTX+AOX0JxqJ4
         QNQiIwKDYSoaPD9SSmUAQMTM9xUDdqXACeFwCqIdOwVC6eILXCTtCZoK6zyyw6btoxJ4
         ppHdlFieOw6b0iL9Tkbd+/+asyFyiqhHX/l5x/QHdx5V1RsmwGzWsSUpVQe5/iVqEVbP
         1oEg==
X-Gm-Message-State: APjAAAXIbL3pDx+fT51yLPF32iE37gf8WVk+cf18/9VEAPUr3faWdhtO
        F+PChfL6pMW3B36yDzpCqxm04iQ2
X-Google-Smtp-Source: APXvYqwvIfB9nMtaDME2vIh4pKqdh+BCPb7XrbxzapLKjZKWBr3uNB2u86R7ByTrlu5fquBJBL8swQ==
X-Received: by 2002:a17:906:7cd2:: with SMTP id h18mr16194866ejp.267.1559932701836;
        Fri, 07 Jun 2019 11:38:21 -0700 (PDT)
Received: from [127.0.0.1] ([13.74.141.28])
        by smtp.gmail.com with ESMTPSA id 93sm717988edk.84.2019.06.07.11.38.21
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Fri, 07 Jun 2019 11:38:21 -0700 (PDT)
Date:   Fri, 07 Jun 2019 11:38:21 -0700 (PDT)
X-Google-Original-Date: Fri, 07 Jun 2019 18:38:04 GMT
Message-Id: <7a0bfaaa6d81cbfdfe3f46307de6231e98ef9ec9.1559932699.git.gitgitgadget@gmail.com>
In-Reply-To: <pull.184.v5.git.gitgitgadget@gmail.com>
References: <pull.184.v4.git.gitgitgadget@gmail.com>
        <pull.184.v5.git.gitgitgadget@gmail.com>
From:   "Derrick Stolee via GitGitGadget" <gitgitgadget@gmail.com>
Subject: [PATCH v5 01/16] commit-graph: document commit-graph chains
Fcc:    Sent
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
MIME-Version: 1.0
To:     git@vger.kernel.org
Cc:     peff@peff.net, avarab@gmail.com, git@jeffhostetler.com,
        jrnieder@google.com, steadmon@google.com,
        johannes.schindelin@gmx.de, philipoakley@iee.org,
        Junio C Hamano <gitster@pobox.com>,
        Derrick Stolee <dstolee@microsoft.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

From: Derrick Stolee <dstolee@microsoft.com>

Add a basic description of commit-graph chains. More details about the
feature will be added as we add functionality. This introduction gives a
high-level overview to the goals of the feature and the basic layout of
commit-graph chains.

Signed-off-by: Derrick Stolee <dstolee@microsoft.com>
---
 Documentation/technical/commit-graph.txt | 59 ++++++++++++++++++++++++
 1 file changed, 59 insertions(+)

diff --git a/Documentation/technical/commit-graph.txt b/Documentation/technical/commit-graph.txt
index fb53341d5e..1dca3bd8fe 100644
--- a/Documentation/technical/commit-graph.txt
+++ b/Documentation/technical/commit-graph.txt
@@ -127,6 +127,65 @@ Design Details
   helpful for these clones, anyway. The commit-graph will not be read or
   written when shallow commits are present.
 
+Commit Graphs Chains
+--------------------
+
+Typically, repos grow with near-constant velocity (commits per day). Over time,
+the number of commits added by a fetch operation is much smaller than the
+number of commits in the full history. By creating a "chain" of commit-graphs,
+we enable fast writes of new commit data without rewriting the entire commit
+history -- at least, most of the time.
+
+## File Layout
+
+A commit-graph chain uses multiple files, and we use a fixed naming convention
+to organize these files. Each commit-graph file has a name
+`$OBJDIR/info/commit-graphs/graph-{hash}.graph` where `{hash}` is the hex-
+valued hash stored in the footer of that file (which is a hash of the file's
+contents before that hash). For a chain of commit-graph files, a plain-text
+file at `$OBJDIR/info/commit-graphs/commit-graph-chain` contains the
+hashes for the files in order from "lowest" to "highest".
+
+For example, if the `commit-graph-chain` file contains the lines
+
+```
+	{hash0}
+	{hash1}
+	{hash2}
+```
+
+then the commit-graph chain looks like the following diagram:
+
+ +-----------------------+
+ |  graph-{hash2}.graph  |
+ +-----------------------+
+	  |
+ +-----------------------+
+ |                       |
+ |  graph-{hash1}.graph  |
+ |                       |
+ +-----------------------+
+	  |
+ +-----------------------+
+ |                       |
+ |                       |
+ |                       |
+ |  graph-{hash0}.graph  |
+ |                       |
+ |                       |
+ |                       |
+ +-----------------------+
+
+Let X0 be the number of commits in `graph-{hash0}.graph`, X1 be the number of
+commits in `graph-{hash1}.graph`, and X2 be the number of commits in
+`graph-{hash2}.graph`. If a commit appears in position i in `graph-{hash2}.graph`,
+then we interpret this as being the commit in position (X0 + X1 + i), and that
+will be used as its "graph position". The commits in `graph-{hash2}.graph` use these
+positions to refer to their parents, which may be in `graph-{hash1}.graph` or
+`graph-{hash0}.graph`. We can navigate to an arbitrary commit in position j by checking
+its containment in the intervals [0, X0), [X0, X0 + X1), [X0 + X1, X0 + X1 +
+X2).
+
 Related Links
 -------------
 [0] https://bugs.chromium.org/p/git/issues/detail?id=8
-- 
gitgitgadget

