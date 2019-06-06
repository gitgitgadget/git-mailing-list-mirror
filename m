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
	by dcvr.yhbt.net (Postfix) with ESMTP id 8C5781F462
	for <e@80x24.org>; Thu,  6 Jun 2019 14:15:36 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727482AbfFFOPc (ORCPT <rfc822;e@80x24.org>);
        Thu, 6 Jun 2019 10:15:32 -0400
Received: from mail-ed1-f67.google.com ([209.85.208.67]:34193 "EHLO
        mail-ed1-f67.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727176AbfFFOPc (ORCPT <rfc822;git@vger.kernel.org>);
        Thu, 6 Jun 2019 10:15:32 -0400
Received: by mail-ed1-f67.google.com with SMTP id c26so3602079edt.1
        for <git@vger.kernel.org>; Thu, 06 Jun 2019 07:15:31 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=date:message-id:in-reply-to:references:from:subject:fcc
         :content-transfer-encoding:mime-version:to:cc;
        bh=K4hI5VzyEmN0pp2bYyiizZjGrxQByJ3B5DXoRbPUeiA=;
        b=JmgUW8+JrGc4+Mm32BmlmReWvW5ar67G88jJEzjyCOHWDngl/0SZ5fy2S5pUNpp+N4
         1/BTzVkm+/8rEHooSO0s8jwHx/GLYwb8qrkxw/ag32JFyQqD1jilAwZKAfbs0w36rAix
         6bqbZRJxfCydlDCvoDLaJOc2RLpkGcN3inggItuy8PA37lLMzEqOyQzLrQon8pRAhkzW
         D/kLfH5ni/6JkHO8Zjfv08qiARJ+DAWIs/BXmEW7DcE0c6X+TzCEAiU8DEJSEhVntbm9
         xIZjjgN97GtxhrLiBY1LrHXCwo8nWTZLPkwJ+P7glWcnmZ4gMPefqiYz3IqxJrt9YsaG
         OCBQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:message-id:in-reply-to:references:from
         :subject:fcc:content-transfer-encoding:mime-version:to:cc;
        bh=K4hI5VzyEmN0pp2bYyiizZjGrxQByJ3B5DXoRbPUeiA=;
        b=KWxlP9DophiVNLnjsLzITS2ch+qxcT3jQQCGvxpQufl+gDMajwaq5xaOTmoPhy8tKw
         NwpHO0KlrlKFFItjzG8zaZ4MjGeWJUgzPbbDEJ6MpQVliyw4ghMH0h7TJhHgbFos9I4y
         eJUqNVu60G8gO545GmwpTzYdynV3O0Lv9VoYYoBWchVQJmBR/HbLC1JMZoAiCcWJwjGt
         JqZjtNJvuK0Pz9kJwSX8G1Ie/whiIRFHSOLmHdzEN7pPSxDxhDoDtdJKyQxfcfDJhb+h
         IDZUKvcQt/ptRxIScodtqOUCnGjlQWDvFskQsDKrnVm3xyEYHJ+iFGluhypkx7zLo32d
         i+BQ==
X-Gm-Message-State: APjAAAXOW+6HTh2wO2335vWo7t8mLYVZyqJHKbildtQiW8hxnmcftMk9
        SqmPrZUcBKxo+Y5uV19QUzlAhFEx
X-Google-Smtp-Source: APXvYqwL59yFgRLCmNVldrRW9ApHi37CUB18HAz8UwnzPGS11f6HHBIKSCqNu6tgjomTBKtwhC3Rdw==
X-Received: by 2002:a50:ba09:: with SMTP id g9mr31524710edc.172.1559830530277;
        Thu, 06 Jun 2019 07:15:30 -0700 (PDT)
Received: from [127.0.0.1] ([13.74.141.28])
        by smtp.gmail.com with ESMTPSA id y6sm359524eju.4.2019.06.06.07.15.29
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Thu, 06 Jun 2019 07:15:29 -0700 (PDT)
Date:   Thu, 06 Jun 2019 07:15:29 -0700 (PDT)
X-Google-Original-Date: Thu, 06 Jun 2019 14:15:14 GMT
Message-Id: <b184919255bfc9e0d57e1a5ca12fb76957879c61.1559830527.git.gitgitgadget@gmail.com>
In-Reply-To: <pull.184.v4.git.gitgitgadget@gmail.com>
References: <pull.184.v3.git.gitgitgadget@gmail.com>
        <pull.184.v4.git.gitgitgadget@gmail.com>
From:   "Derrick Stolee via GitGitGadget" <gitgitgadget@gmail.com>
Subject: [PATCH v4 01/14] commit-graph: document commit-graph chains
Fcc:    Sent
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
MIME-Version: 1.0
To:     git@vger.kernel.org
Cc:     peff@peff.net, avarab@gmail.com, git@jeffhostetler.com,
        jrnieder@google.com, steadmon@google.com,
        johannes.schindelin@gmx.de, Junio C Hamano <gitster@pobox.com>,
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

