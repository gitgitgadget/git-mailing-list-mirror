Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.1 (2015-04-28) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-3.7 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,RCVD_IN_DNSWL_HI
	shortcircuit=no autolearn=ham autolearn_force=no version=3.4.1
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 092691F453
	for <e@80x24.org>; Fri, 21 Sep 2018 17:39:31 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2390906AbeIUX3X (ORCPT <rfc822;e@80x24.org>);
        Fri, 21 Sep 2018 19:29:23 -0400
Received: from mail-pg1-f194.google.com ([209.85.215.194]:35205 "EHLO
        mail-pg1-f194.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S2390833AbeIUX3X (ORCPT <rfc822;git@vger.kernel.org>);
        Fri, 21 Sep 2018 19:29:23 -0400
Received: by mail-pg1-f194.google.com with SMTP id 205-v6so5423035pgd.2
        for <git@vger.kernel.org>; Fri, 21 Sep 2018 10:39:28 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=date:message-id:in-reply-to:references:from:subject:fcc
         :content-transfer-encoding:mime-version:to:cc;
        bh=5Xvh+x7mf8IjvYdaa2nzn3tNY/sYjD0sxDy6lgWWb8o=;
        b=hnRpGkp0q4dhQHpItIB8YGPlWuuyYpVz/0aKY2q1Pd2K5FUmdkO/Tt0OWQz29V5sQK
         5Ytp8lNNGHSn7JAy8uFUV96V+NauhnFeavDzmvFeyMSi7QNw4BsSVpvO2fwwsK3lFCR/
         UAtUCqyoJyJNb8TAzgTbx6JiYiFcjb8pOXAD1aMwJ4+NOkC2kbUMSNWq2FzQikN4s7SJ
         ED0R36eHHSD7MO0zNO9Ep24wajkBi/0R7toIIAGhqu/fXE7H1IHeBCc0b7NN2LR9/mEY
         7Q0EfBgAR975SZtoI33cHbv0upVtknnHuZXPQw/kq9MZRd2DLpb3bw43FHJUYUsx7gSf
         HJaQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:message-id:in-reply-to:references:from
         :subject:fcc:content-transfer-encoding:mime-version:to:cc;
        bh=5Xvh+x7mf8IjvYdaa2nzn3tNY/sYjD0sxDy6lgWWb8o=;
        b=lpSON/Uf1a35uoL96AhdA/M9QsUiQOl9v+YefaYvxPbZ5PXZtQiUFN+7IAoh0XZci5
         7al7R9eLPFkihSC/R2hJTanQ0k0sv0cosDCAlzZiisYglN5qTecRoBpCFG7k7hHg4TLF
         jc6D82j+ecfD35vrZFuuBaPvqlh/BDKizJDyozWOmyPSPs04DGW6n6mDJya4mzo4sIHL
         y1bfEZfGiO7wmGSiEpEuRUBs7nddo+ljrJMfDSECbUrgJB06I+WecQzzA1NDlqHrdwvn
         eBG4ltn+dAuapjyjhysVn/GTMzh9WG/gd/JV+p2HPE3hhWEVeA2IMz/5g+qWdhCALJIS
         Fzfg==
X-Gm-Message-State: APzg51D3RqwTDpJn4F7yW3gTSt/F9hFUGKpj+dsNmcY9J+BnoM99kKlv
        ynhEznSME6hYTt0x4Hq4HBlqD5AW
X-Google-Smtp-Source: ANB0VdaaNCI8ybPvF8oLmIhQYI/vb7TJZyWvBPOm0yAZk5CL1orfcBsCPjWv3992TNMNbztY0Os0eg==
X-Received: by 2002:a62:4299:: with SMTP id h25-v6mr47114393pfd.73.1537551567261;
        Fri, 21 Sep 2018 10:39:27 -0700 (PDT)
Received: from [127.0.0.1] ([40.112.142.204])
        by smtp.gmail.com with ESMTPSA id f19-v6sm12135711pga.38.2018.09.21.10.39.25
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Fri, 21 Sep 2018 10:39:26 -0700 (PDT)
Date:   Fri, 21 Sep 2018 10:39:26 -0700 (PDT)
X-Google-Original-Date: Fri, 21 Sep 2018 17:39:16 GMT
Message-Id: <pull.25.v3.git.gitgitgadget@gmail.com>
In-Reply-To: <pull.25.v2.git.gitgitgadget@gmail.com>
References: <pull.25.v2.git.gitgitgadget@gmail.com>
From:   "Derrick Stolee via GitGitGadget" <gitgitgadget@gmail.com>
Subject: [PATCH v3 0/7] Use generation numbers for --topo-order
Fcc:    Sent
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
MIME-Version: 1.0
To:     git@vger.kernel.org
Cc:     peff@peff.net, Junio C Hamano <gitster@pobox.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

This patch series performs a decently-sized refactoring of the revision-walk
machinery. Well, "refactoring" is probably the wrong word, as I don't
actually remove the old code. Instead, when we see certain options in the
'rev_info' struct, we redirect the commit-walk logic to a new set of methods
that distribute the workload differently. By using generation numbers in the
commit-graph, we can significantly improve 'git log --graph' commands (and
the underlying 'git rev-list --topo-order').

On the Linux repository, I got the following performance results when
comparing to the previous version with or without a commit-graph:

Test: git rev-list --topo-order -100 HEAD
HEAD~1, no commit-graph: 6.80 s
HEAD~1, w/ commit-graph: 0.77 s
  HEAD, w/ commit-graph: 0.02 s

Test: git rev-list --topo-order -100 HEAD -- tools
HEAD~1, no commit-graph: 9.63 s
HEAD~1, w/ commit-graph: 6.06 s
  HEAD, w/ commit-graph: 0.06 s

If you want to read this series but are unfamiliar with the commit-graph and
generation numbers, then I recommend reading 
Documentation/technical/commit-graph.txt or a blob post [1] I wrote on the
subject. In particular, the three-part walk described in "revision.c:
refactor basic topo-order logic" is present (but underexplained) as an
animated PNG [2].

Since revision.c is an incredibly important (and old) portion of the
codebase -- and because there are so many orthogonal options in 'struct
rev_info' -- I consider this submission to be "RFC quality". That is, I am
not confident that I am not missing anything, or that my solution is the
best it can be. I did merge this branch with ds/commit-graph-with-grafts and
the "DO-NOT-MERGE: write and read commit-graph always" commit that computes
a commit-graph with every 'git commit' command. The test suite passed with
that change, available on GitHub [3]. To ensure that I cover at least the
case I think are interesting, I added tests to t6600-test-reach.sh to verify
the walks report the correct results for the three cases there (no
commit-graph, full commit-graph, and a partial commit-graph so the walk
starts at GENERATION_NUMBER_INFINITY).

One notable case that is not included in this series is the case of a
history comparison such as 'git rev-list --topo-order A..B'. The existing
code in limit_list() has ways to cut the walk short when all pending commits
are UNINTERESTING. Since this code depends on commit_list instead of the
prio_queue we are using here, I chose to leave it untouched for now. We can
revisit it in a separate series later. Since handle_commit() turns on
revs->limited when a commit is UNINTERESTING, we do not hit the new code in
this case. Removing this 'revs->limited = 1;' line yields correct results,
but the performance is worse.

This series was based on ds/reachable, but is now based on 'master' to not
conflict with 182070 "commit: use timestamp_t for author_date_slab". There
is a small conflict with md/filter-trees, because it renamed a flag in
revisions.h in the line before I add new flags. Hopefully this conflict is
not too difficult to resolve.

Changes in V3: I added a new patch that updates the tab-alignment for flags
in revision.h before adding new ones (Thanks, Ævar!). Also, I squashed the
recommended changes to run_three_modes and test_three_modes from Szeder and
Junio. Thanks!

Thanks, -Stolee

[1] 
https://blogs.msdn.microsoft.com/devops/2018/07/09/supercharging-the-git-commit-graph-iii-generations/
Supercharging the Git Commit Graph III: Generations and Graph Algorithms

[2] 
https://msdnshared.blob.core.windows.net/media/2018/06/commit-graph-topo-order-b-a.png
Animation showing three-part walk

[3] https://github.com/derrickstolee/git/tree/topo-order/testA branch
containing this series along with commits to compute commit-graph in entire
test suite.

Cc: avarab@gmail.comCc: szeder.dev@gmail.com

Derrick Stolee (7):
  prio-queue: add 'peek' operation
  test-reach: add run_three_modes method
  test-reach: add rev-list tests
  revision.c: begin refactoring --topo-order logic
  commit/revisions: bookkeeping before refactoring
  revision.h: add whitespace in flag definitions
  revision.c: refactor basic topo-order logic

 commit.c                   |  11 +-
 commit.h                   |   8 ++
 object.h                   |   4 +-
 prio-queue.c               |   9 ++
 prio-queue.h               |   6 +
 revision.c                 | 232 ++++++++++++++++++++++++++++++++++++-
 revision.h                 |  34 +++---
 t/helper/test-prio-queue.c |  10 +-
 t/t6600-test-reach.sh      |  96 ++++++++++++++-
 9 files changed, 374 insertions(+), 36 deletions(-)


base-commit: 2d3b1c576c85b7f5db1f418907af00ab88e0c303
Published-As: https://github.com/gitgitgadget/git/releases/tags/pr-25%2Fderrickstolee%2Ftopo-order%2Fprogress-v3
Fetch-It-Via: git fetch https://github.com/gitgitgadget/git pr-25/derrickstolee/topo-order/progress-v3
Pull-Request: https://github.com/gitgitgadget/git/pull/25

Range-diff vs v2:

 1:  cc1ec4c270 = 1:  cc1ec4c270 prio-queue: add 'peek' operation
 2:  404c918608 ! 2:  b2a1ade148 test-reach: add run_three_modes method
     @@ -11,10 +11,6 @@
          run_three_modes method that executes the given command and tests
          the actual output to the expected output.
      
     -    While inspecting this code, I realized that the final test for
     -    'commit_contains --tag' is silently dropping the '--tag' argument.
     -    It should be quoted to include both.
     -
          Signed-off-by: Derrick Stolee <dstolee@microsoft.com>
      
      diff --git a/t/t6600-test-reach.sh b/t/t6600-test-reach.sh
     @@ -28,31 +24,22 @@
      +run_three_modes () {
       	test_when_finished rm -rf .git/objects/info/commit-graph &&
      -	test-tool reach $1 <input >actual &&
     -+	$1 <input >actual &&
     ++	"$@" <input >actual &&
       	test_cmp expect actual &&
       	cp commit-graph-full .git/objects/info/commit-graph &&
      -	test-tool reach $1 <input >actual &&
     -+	$1 <input >actual &&
     ++	"$@" <input >actual &&
       	test_cmp expect actual &&
       	cp commit-graph-half .git/objects/info/commit-graph &&
      -	test-tool reach $1 <input >actual &&
     -+	$1 <input >actual &&
     ++	"$@" <input >actual &&
       	test_cmp expect actual
       }
       
      +test_three_modes () {
     -+	run_three_modes "test-tool reach $1"
     ++	run_three_modes test-tool reach "$@"
      +}
      +
       test_expect_success 'ref_newer:miss' '
       	cat >input <<-\EOF &&
       	A:commit-5-7
     -@@
     - 	EOF
     - 	echo "commit_contains(_,A,X,_):1" >expect &&
     - 	test_three_modes commit_contains &&
     --	test_three_modes commit_contains --tag
     -+	test_three_modes "commit_contains --tag"
     - '
     - 
     - test_expect_success 'commit_contains:miss' '
 3:  30dee58c61 ! 3:  b0ceb96076 test-reach: add rev-list tests
     @@ -30,7 +30,7 @@
      +		commit-6-2 commit-5-2 commit-4-2 commit-3-2 commit-2-2 commit-1-2 \
      +		commit-6-1 commit-5-1 commit-4-1 commit-3-1 commit-2-1 commit-1-1 \
      +	>expect &&
     -+	run_three_modes "git rev-list --topo-order commit-6-6"
     ++	run_three_modes git rev-list --topo-order commit-6-6
      +'
      +
      +test_expect_success 'rev-list: first-parent topo-order' '
     @@ -42,7 +42,7 @@
      +		commit-6-2 \
      +		commit-6-1 commit-5-1 commit-4-1 commit-3-1 commit-2-1 commit-1-1 \
      +	>expect &&
     -+	run_three_modes "git rev-list --first-parent --topo-order commit-6-6"
     ++	run_three_modes git rev-list --first-parent --topo-order commit-6-6
      +'
      +
      +test_expect_success 'rev-list: range topo-order' '
     @@ -54,7 +54,7 @@
      +		commit-6-2 commit-5-2 commit-4-2 \
      +		commit-6-1 commit-5-1 commit-4-1 \
      +	>expect &&
     -+	run_three_modes "git rev-list --topo-order commit-3-3..commit-6-6"
     ++	run_three_modes git rev-list --topo-order commit-3-3..commit-6-6
      +'
      +
      +test_expect_success 'rev-list: range topo-order' '
     @@ -66,7 +66,7 @@
      +		commit-6-2 commit-5-2 commit-4-2 \
      +		commit-6-1 commit-5-1 commit-4-1 \
      +	>expect &&
     -+	run_three_modes "git rev-list --topo-order commit-3-8..commit-6-6"
     ++	run_three_modes git rev-list --topo-order commit-3-8..commit-6-6
      +'
      +
      +test_expect_success 'rev-list: first-parent range topo-order' '
     @@ -78,7 +78,7 @@
      +		commit-6-2 \
      +		commit-6-1 commit-5-1 commit-4-1 \
      +	>expect &&
     -+	run_three_modes "git rev-list --first-parent --topo-order commit-3-8..commit-6-6"
     ++	run_three_modes git rev-list --first-parent --topo-order commit-3-8..commit-6-6
      +'
      +
      +test_expect_success 'rev-list: ancestry-path topo-order' '
     @@ -88,7 +88,7 @@
      +		commit-6-4 commit-5-4 commit-4-4 commit-3-4 \
      +		commit-6-3 commit-5-3 commit-4-3 \
      +	>expect &&
     -+	run_three_modes "git rev-list --topo-order --ancestry-path commit-3-3..commit-6-6"
     ++	run_three_modes git rev-list --topo-order --ancestry-path commit-3-3..commit-6-6
      +'
      +
      +test_expect_success 'rev-list: symmetric difference topo-order' '
     @@ -102,7 +102,7 @@
      +		commit-3-8 commit-2-8 commit-1-8 \
      +		commit-3-7 commit-2-7 commit-1-7 \
      +	>expect &&
     -+	run_three_modes "git rev-list --topo-order commit-3-8...commit-6-6"
     ++	run_three_modes git rev-list --topo-order commit-3-8...commit-6-6
      +'
      +
       test_done
 4:  a74ae13d4e = 4:  fd1a0ab7cd revision.c: begin refactoring --topo-order logic
 5:  0e64fc144c = 5:  e86f304082 commit/revisions: bookkeeping before refactoring
 -:  ---------- > 6:  fa6d5ef152 revision.h: add whitespace in flag definitions
 6:  3b185ac3b1 ! 7:  020b2f50c5 revision.c: refactor basic topo-order logic
     @@ -404,11 +404,11 @@
      --- a/revision.h
      +++ b/revision.h
      @@
     - #define USER_GIVEN	(1u<<25) /* given directly by the user */
     - #define TRACK_LINEAR	(1u<<26)
     - #define ALL_REV_FLAGS	(((1u<<11)-1) | USER_GIVEN | TRACK_LINEAR)
     -+#define TOPO_WALK_EXPLORED (1u<<27)
     -+#define TOPO_WALK_INDEGREE (1u<<28)
     + #define USER_GIVEN		(1u<<25) /* given directly by the user */
     + #define TRACK_LINEAR		(1u<<26)
     + #define ALL_REV_FLAGS		(((1u<<11)-1) | USER_GIVEN | TRACK_LINEAR)
     ++#define TOPO_WALK_EXPLORED	(1u<<27)
     ++#define TOPO_WALK_INDEGREE	(1u<<28)
       
       #define DECORATE_SHORT_REFS	1
       #define DECORATE_FULL_REFS	2

-- 
gitgitgadget
