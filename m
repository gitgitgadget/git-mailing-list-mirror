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
	by dcvr.yhbt.net (Postfix) with ESMTP id DAFE81F462
	for <e@80x24.org>; Wed, 22 May 2019 19:53:25 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1731875AbfEVTxZ (ORCPT <rfc822;e@80x24.org>);
        Wed, 22 May 2019 15:53:25 -0400
Received: from mail-ed1-f68.google.com ([209.85.208.68]:34089 "EHLO
        mail-ed1-f68.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1731879AbfEVTxY (ORCPT <rfc822;git@vger.kernel.org>);
        Wed, 22 May 2019 15:53:24 -0400
Received: by mail-ed1-f68.google.com with SMTP id p27so5535902eda.1
        for <git@vger.kernel.org>; Wed, 22 May 2019 12:53:23 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=date:message-id:in-reply-to:references:from:subject:fcc
         :content-transfer-encoding:mime-version:to:cc;
        bh=K4hI5VzyEmN0pp2bYyiizZjGrxQByJ3B5DXoRbPUeiA=;
        b=Klr6RqfsHpcFmTSUsu6IrNMOKKZnZ0dDOaKS7pxSzGspeLB6ml3PyQ3vOtpTO3WyIv
         mp1yyBVv5/RcrolUhYA7kyUEpVlVnAKHBP4RzZzwAKzzP2F5D3JACwUW32t/d8AM28lR
         NKfd3pkQVseiihMTE1Lq9pE8SbWu5OhzNY8b9G9lhqCHnwDcwXyuu/glmBnb4CZ23bA9
         9MRYWkDAH8xNRrcJEvutLCIkh10zVi6n1BMUBU761eJiehTXaIhEm1WuX1SYYOZ6ZBdF
         aF2ICVhqr5e38E0/4sQdEWJ3L0MZkSha7tLVJHnBkkfm73X39870M/Uap2h/Jt3t47Xy
         wfaw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:message-id:in-reply-to:references:from
         :subject:fcc:content-transfer-encoding:mime-version:to:cc;
        bh=K4hI5VzyEmN0pp2bYyiizZjGrxQByJ3B5DXoRbPUeiA=;
        b=C9LqabjwfqaE4sq2kCqyBZop5Fx/pjgAFo4ci6dXEgWg22Mx44hTOYgi6MJQ2d8YHd
         VoYKoBFmE7B89iTiZ0LGydNzuDyG8SfV7NfoYgtR2rTpDSiY3XXxVWa/NZmKTzMZaQlK
         c5ydgOSUKMeBQhONwAKjWgCc5qZj5HPYjG00EaNUPCSTwxU6RylnGqbjEDWW30YWehxS
         PmQ06ilUNHnXRbBndePAUMN2h7JXSDyocravrhQ8lQIy3Y3rJPamnBBgz0IiuynTqO+Q
         zRwtCgOPCfGEZyJAbeQPuJxluR0jDIw3fjuoYB9XGAoXe3b1hrzZgt1d+1b6JFQpzO6j
         LAkA==
X-Gm-Message-State: APjAAAUhNG1DCGerz9Hh0upf9VpTaWS69PlPJ/n7lQjhi/7+tiBYrKOd
        O+aEny+uB3weqXwvcDteVOUD/C4s
X-Google-Smtp-Source: APXvYqz/xP9Mv5/wgBepQbm0lSplcT+XwyyPUKH9kvqytB2d75dfyNXgr3lF71ffRuUJRpFOFkZt2g==
X-Received: by 2002:a17:906:391b:: with SMTP id f27mr70737017eje.258.1558554803102;
        Wed, 22 May 2019 12:53:23 -0700 (PDT)
Received: from [127.0.0.1] ([13.74.141.28])
        by smtp.gmail.com with ESMTPSA id r2sm2538957ejz.80.2019.05.22.12.53.22
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Wed, 22 May 2019 12:53:22 -0700 (PDT)
Date:   Wed, 22 May 2019 12:53:22 -0700 (PDT)
X-Google-Original-Date: Wed, 22 May 2019 19:53:10 GMT
Message-Id: <a423afbfdd4d5591bdef83c4603b2d8de5e64e21.1558554800.git.gitgitgadget@gmail.com>
In-Reply-To: <pull.184.v2.git.gitgitgadget@gmail.com>
References: <pull.184.git.gitgitgadget@gmail.com>
        <pull.184.v2.git.gitgitgadget@gmail.com>
From:   "Derrick Stolee via GitGitGadget" <gitgitgadget@gmail.com>
Subject: [PATCH v2 01/11] commit-graph: document commit-graph chains
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

