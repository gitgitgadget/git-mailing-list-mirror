Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.1 (2015-04-28) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-3.8 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,RCVD_IN_DNSWL_HI
	shortcircuit=no autolearn=ham autolearn_force=no version=3.4.1
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id C74701F404
	for <e@80x24.org>; Wed, 29 Aug 2018 12:49:05 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728075AbeH2Qpv (ORCPT <rfc822;e@80x24.org>);
        Wed, 29 Aug 2018 12:45:51 -0400
Received: from mail-pl1-f178.google.com ([209.85.214.178]:37270 "EHLO
        mail-pl1-f178.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727254AbeH2Qpu (ORCPT <rfc822;git@vger.kernel.org>);
        Wed, 29 Aug 2018 12:45:50 -0400
Received: by mail-pl1-f178.google.com with SMTP id d12-v6so2253605pls.4
        for <git@vger.kernel.org>; Wed, 29 Aug 2018 05:49:04 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=date:message-id:in-reply-to:references:from:subject:fcc
         :content-transfer-encoding:mime-version:to:cc;
        bh=Nv9M3makGbU77XKg+aA9K/nPHQ8M982pfnK7D5rELOs=;
        b=PzqUHbZS/Ftzg5H2E8MeqeuLT8ch1B6lAQ+k0tGIHEI/SdDW4L0MtEUUZbcFAkhnXK
         qEz/a+Gj9moTCjEYMjnyRcRqutKB2pod0A5Y/FBz8KA7IhGx6yx9/f9RIaH6j9DEvIjw
         iCPt0LS7SsWwMPaHLjHXNW9WZDb67ztjqnAdCpDVD5ZRnBRDm9/7AcUj7pfYPElG/YYG
         CsDM3+4zQfqSlMEPQo1kdj0u5VBlTYidXzZ7I6eTiDDMizLK0rNj0Wck+XUUHBCPH3pQ
         /ApkD70tPE4GmZs6X6LjB1wvOra94rpFw1oU17aNy8TqFjTAbIV8dLxXsgsMm2qnLvkR
         Y60g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:message-id:in-reply-to:references:from
         :subject:fcc:content-transfer-encoding:mime-version:to:cc;
        bh=Nv9M3makGbU77XKg+aA9K/nPHQ8M982pfnK7D5rELOs=;
        b=pl9vvDK8RZ3t+rVtQ4bNKn7RiE8Cxbt5De5spYfOKWHel7l5cgr+aoxH+zFit37r+Z
         6Y/QnciBU9DNHLAbruDy1O/GoIX3rmF61t/9Qi/y+cr+sFi95mVOWNPVZAKCAfbQzMxy
         Oig7H0O0DHC2irMdycPNMC5G7ZKdBY9Ycbi7xkFPOeT837lDJ5/E8lTtyTNxMCssFKuU
         vAuXMSK8oHDwV+WMdE9FvFtqm17TZ5DBSt3MjweNqc5veJY8q0R2xrgTi6qzi6MWsN1G
         PEGsseedwGc2fw5lB7cIucNA3Dq2hjf+Ek9HksL6W1XDfzQ22Z+dfRqN3HhJ+CLR8zwe
         nb+A==
X-Gm-Message-State: APzg51Bo1g/Tu6HWbeVJlAYOiePzce+IQg6VtTU7yzh94ejhAjbbQTuE
        dHEsimNZFREtviQBJc0z2x7rMa8l
X-Google-Smtp-Source: ANB0VdZ7Pywu7sR4jWmMlLzfnGLMLFU+miZ5XdXUPt4MMfRg05aSyCmJS6rFFrOf7BkNZRJPlIyzOQ==
X-Received: by 2002:a17:902:b089:: with SMTP id p9-v6mr5111058plr.254.1535546943398;
        Wed, 29 Aug 2018 05:49:03 -0700 (PDT)
Received: from [127.0.0.1] ([40.112.142.204])
        by smtp.gmail.com with ESMTPSA id 3-v6sm8444376pfq.10.2018.08.29.05.49.01
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Wed, 29 Aug 2018 05:49:02 -0700 (PDT)
Date:   Wed, 29 Aug 2018 05:49:02 -0700 (PDT)
X-Google-Original-Date: Wed, 29 Aug 2018 12:48:59 GMT
Message-Id: <pull.26.v2.git.gitgitgadget@gmail.com>
In-Reply-To: <pull.26.git.gitgitgadget@gmail.com>
References: <pull.26.git.gitgitgadget@gmail.com>
From:   "Derrick Stolee via GitGitGadget" <gitgitgadget@gmail.com>
Subject: [PATCH v2 0/1] Define GIT_TEST_COMMIT_GRAPH for commit-graph test coverage
Fcc:    Sent
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
MIME-Version: 1.0
To:     git@vger.kernel.org
Cc:     pclouds@gmail.com, Junio C Hamano <gitster@pobox.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

The commit-graph (and multi-pack-index) features are optional data
structures that can make Git operations faster. Since they are optional, we
do not enable them in most Git tests. The commit-graph is tested in
t5318-commit-graph.sh (and t6600-test-reach.sh in ds/reachable), but that
one script cannot cover the data shapes present in the rest of the test
suite.

This patch introduces a new test environment variable, GIT_TEST_COMMIT_GRAPH
. Similar to GIT_TEST_SPLIT_INDEX, it enables the commit-graph and writes it
with every git commit command. Thanks, Duy, for pointing out this direction
[1].

A few tests needed to be modified. These are the same tests that were
mentioned in my previous example patch [2]. Thanks, Eric, for providing the
correct way to override the settings [3].

When this merges down, I'll create a CI build in VSTS that runs the test
suite with this option enabled.

Thanks, -Stolee

[1] 
https://public-inbox.org/git/CACsJy8CKnXVJYkKM_W=N=Vq-TVXf+YCqZP_uP7B-dN_6xddB=g@mail.gmail.com/
Re: [PATCH 0/9] multi-pack-index cleanups (Discussing test environment
variables)

[2] 
https://public-inbox.org/git/20180718152244.45513-1-dstolee@microsoft.com/
[PATCH] DO-NOT-MERGE: write and read commit-graph always

[3] 
https://public-inbox.org/git/CAPig+cSjanDi=jV75PdzYpAjwVgd4Suh3UyvY+Vy7yeHAuY8RA@mail.gmail.com/

Based-On: ds/commit-graph-with-grafts Cc: jnareb@gmail.comCc: 
sbeller@google.comCc: sunshine@sunshineco.com

Derrick Stolee (1):
  commit-graph: define GIT_TEST_COMMIT_GRAPH

 builtin/commit.c                    | 4 ++++
 commit-graph.c                      | 5 +++--
 commit-graph.h                      | 2 ++
 t/README                            | 4 ++++
 t/t0410-partial-clone.sh            | 2 +-
 t/t5307-pack-missing-commit.sh      | 4 ++--
 t/t6011-rev-list-with-bad-commit.sh | 7 +++----
 t/t6024-recursive-merge.sh          | 6 +++---
 8 files changed, 22 insertions(+), 12 deletions(-)


base-commit: 829a321569d8e8f2c582aef9f0c990df976ab842
Published-As: https://github.com/gitgitgadget/git/releases/tags/pr-26%2Fderrickstolee%2Fshallow%2Ftest-v2
Fetch-It-Via: git fetch https://github.com/gitgitgadget/git pr-26/derrickstolee/shallow/test-v2
Pull-Request: https://github.com/gitgitgadget/git/pull/26

Range-diff vs v1:

 1:  85d02ac8d8 ! 1:  4ff6695c7e commit-graph: define GIT_TEST_COMMIT_GRAPH
     @@ -23,6 +23,7 @@
          merge-base algorithm picking one of two ambiguous merge-bases, and
          the commit-graph feature changes which merge-base is picked.
      
     +    Helped-by: Eric Sunshine <sunshine@sunshineco.com>
          Signed-off-by: Derrick Stolee <dstolee@microsoft.com>
      
      diff --git a/builtin/commit.c b/builtin/commit.c
     @@ -112,18 +113,12 @@
       
       test_expect_success 'rev-list notices corruption (1)' '
      -	test_must_fail git rev-list HEAD
     -+	(
     -+		GIT_TEST_COMMIT_GRAPH=0 &&
     -+		test_must_fail git rev-list HEAD
     -+	)
     ++	test_must_fail env GIT_TEST_COMMIT_GRAPH=0 git rev-list HEAD
       '
       
       test_expect_success 'rev-list notices corruption (2)' '
      -	test_must_fail git rev-list --objects HEAD
     -+	(
     -+		GIT_TEST_COMMIT_GRAPH=0 &&
     -+		test_must_fail git rev-list --objects HEAD
     -+	)
     ++	test_must_fail env GIT_TEST_COMMIT_GRAPH=0 git rev-list --objects HEAD
       '
       
       test_expect_success 'pack-objects notices corruption' '
     @@ -140,10 +135,7 @@
      -   test_must_fail git rev-list --all > /dev/null
      -   '
      +test_expect_success 'rev-list should fail' '
     -+	(
     -+		GIT_TEST_COMMIT_GRAPH=0 &&
     -+		test_must_fail git rev-list --all > /dev/null
     -+	)
     ++	test_must_fail env GIT_TEST_COMMIT_GRAPH=0 git rev-list --all > /dev/null
      +'
       
       test_expect_success 'git repack _MUST_ fail' \
     @@ -160,10 +152,7 @@
      -	test_must_fail git merge -m final G
      -"
      +test_expect_success 'combined merge conflicts' '
     -+	(
     -+		GIT_TEST_COMMIT_GRAPH=0 &&
     -+		test_must_fail git merge -m final G
     -+	)
     ++	test_must_fail env GIT_TEST_COMMIT_GRAPH=0 git merge -m final G
      +'
       
       cat > expect << EOF

-- 
gitgitgadget
