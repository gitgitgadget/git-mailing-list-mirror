Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.2 (2018-09-13) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-3.8 required=3.0 tests=AWL,BAYES_00,
	DKIM_ADSP_CUSTOM_MED,DKIM_INVALID,DKIM_SIGNED,
	FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,RCVD_IN_DNSWL_HI,SPF_HELO_NONE,SPF_NONE
	shortcircuit=no autolearn=ham autolearn_force=no version=3.4.2
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id E9BC11F4C0
	for <e@80x24.org>; Wed, 23 Oct 2019 13:01:40 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2404375AbfJWNBj (ORCPT <rfc822;e@80x24.org>);
        Wed, 23 Oct 2019 09:01:39 -0400
Received: from mail-wr1-f66.google.com ([209.85.221.66]:46271 "EHLO
        mail-wr1-f66.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S2390489AbfJWNBj (ORCPT <rfc822;git@vger.kernel.org>);
        Wed, 23 Oct 2019 09:01:39 -0400
Received: by mail-wr1-f66.google.com with SMTP id n15so11207517wrw.13
        for <git@vger.kernel.org>; Wed, 23 Oct 2019 06:01:37 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=message-id:in-reply-to:references:from:date:subject:mime-version
         :content-transfer-encoding:fcc:to:cc;
        bh=YIJeOYegRuHf722oz4nOWUpvagIVmZaGVbxgm81WVUQ=;
        b=nqIWq3c/QLOdtq5MIoAUkFN6udPbwdu4tY0Eo/Jwaj8Cyl5Iy2yYSBgfYe4aCxTti7
         YSI72yhgHnnvV7+tIjwnE5r15oZ4xg+UyM0if5PbZBSWnwopfGMtCQcnYFsm17DzXEcY
         dO+Uv3UudtAvoVd/QlzJMrZDyWN3rBizElE0wEHInODx1fv2RxbNHEteqSnm0tpQIm1i
         Y9seBDiiNlQLrgC/DriKKwGdfLYsRK1lzEzf1bAfjfV+DYu0DbnNiwtQjedhnL6tvZ+5
         Jbh8FtQbk4tadC4JDCXaAliDzsp13F1DpSX1xYo9y3NV0L5QMQE9rZx82CTZGsLXdU++
         rrAQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:message-id:in-reply-to:references:from:date
         :subject:mime-version:content-transfer-encoding:fcc:to:cc;
        bh=YIJeOYegRuHf722oz4nOWUpvagIVmZaGVbxgm81WVUQ=;
        b=nmOxbU3TCUc+yUFVA3Qiw5GCkipKlGFLfXLLAPVoZqsxsULer+7RuqdyAC1sXL0dY7
         cQohzhTJCTEYakN9ypX9TYUWNNMt6ygR7HAyDPVd/KVb9idtu2mEu4wMwkwzKI5v/hvU
         jmMc4RPrESUQY3n5B0rItlFBrjd57SiT19NU0rIxyUd80g7KI03Fusr8jigTCLX56JMJ
         GAufVMyzlIQP9L7uw8tZVHcG2OIASFTzM53ML+G91t28bwNlG5n91z6SgOjun+HkeFbY
         6YMA05gPlPGv2Z/6fu9LVoZgm6WEAWM0JhJMk8Yg3C33NTEiSVovvv1odKBpGn20j+TT
         BSVw==
X-Gm-Message-State: APjAAAUStGWmGJu5bijBQU+lXDBAZJviZA+v8edq48GYZLHPFxr5o9nz
        PDptIO3VXfLw/wKA+0AA0HYRQJvN
X-Google-Smtp-Source: APXvYqztd/JJoZbqqO0U2RBPS/u0zG9rLAYUZPRRDJ+6RH6QPA1qj3Co1UgGeBgYEnCNRkAtce6WlA==
X-Received: by 2002:a05:6000:1621:: with SMTP id v1mr8831931wrb.62.1571835696237;
        Wed, 23 Oct 2019 06:01:36 -0700 (PDT)
Received: from [127.0.0.1] ([13.74.141.28])
        by smtp.gmail.com with ESMTPSA id o25sm13056782wro.21.2019.10.23.06.01.35
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Wed, 23 Oct 2019 06:01:35 -0700 (PDT)
Message-Id: <pull.415.v2.git.1571835695.gitgitgadget@gmail.com>
In-Reply-To: <pull.415.git.1571765335.gitgitgadget@gmail.com>
References: <pull.415.git.1571765335.gitgitgadget@gmail.com>
From:   "Derrick Stolee via GitGitGadget" <gitgitgadget@gmail.com>
Date:   Wed, 23 Oct 2019 13:01:33 +0000
Subject: [PATCH v2 0/2] [v2.24.0-rc0 BUG] fetch.writeCommitGraph fails on first fetch
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Fcc:    Sent
To:     git@vger.kernel.org
Cc:     johannes.schindelin@gmx.de, peff@peff.net, szeder.dev@gmail.com,
        Derrick Stolee <dstolee@microsoft.com>,
        Junio C Hamano <gitster@pobox.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

UPDATE for V2: We now know the full repro, and a test is added. Thanks
Szeder and Peff for your insights!

While dogfooding, Johannes found a bug in the fetch.writeCommitGraph config
behavior. While his example initially happened during a clone with
--recurse-submodules, (UPDATE) and the submodule is important, but
--recurse-submodules is not:

$ git clone <url> test
$ cd test
$ git -c fetch.writeCommitGraph=true fetch origin
Computing commit graph generation numbers: 100% (12/12), done.
BUG: commit-graph.c:886: missing parent <hash1> for commit <hash2>
Aborted (core dumped)

In the repo I had cloned, there were really 60 commits to scan, but only 12
were in the list to write when calling compute_generation_numbers(). A
commit in the list expects to see a parent, but that parent is not in the
list. The simple example I used for my testing was 
https://github.com/derrickstolee/numbers. Thie repo HAS A SUBMODULE, I just
forgot. Sorry for derailing the investigation somewhat.

The details above are the start of the commit message for [PATCH 1/2],
including a test that fails when fetching after cloning a repo with a
submodule.

In [PATCH 2/2], I actually have the fix. I tried to include as much detail
as I could for how I investigated the problem and why I think this is the
right solution. I added details that have come from the on-list discussion,
including what the submodule code is doing and why REACHABLE is no longer
used in commit-reach.c.

Thanks, -Stolee

Derrick Stolee (2):
  t5510-fetch.sh: demonstrate fetch.writeCommitGraph bug
  commit-graph: fix writing first commit-graph during fetch

 commit-graph.c   | 11 +++++++----
 commit-reach.c   |  1 -
 object.h         |  3 ++-
 t/t5510-fetch.sh | 17 +++++++++++++++++
 4 files changed, 26 insertions(+), 6 deletions(-)


base-commit: d966095db01190a2196e31195ea6fa0c722aa732
Published-As: https://github.com/gitgitgadget/git/releases/tag/pr-415%2Fderrickstolee%2Ffetch-first-write-fail-v2
Fetch-It-Via: git fetch https://github.com/gitgitgadget/git pr-415/derrickstolee/fetch-first-write-fail-v2
Pull-Request: https://github.com/gitgitgadget/git/pull/415

Range-diff vs v1:

 -:  ---------- > 1:  6ac0a05746 t5510-fetch.sh: demonstrate fetch.writeCommitGraph bug
 1:  a1e5280d4b ! 2:  ca59b118f1 commit-graph: fix writing first commit-graph during fetch
     @@ -2,10 +2,13 @@
      
          commit-graph: fix writing first commit-graph during fetch
      
     -    While dogfooding, Johannes found a bug in the fetch.writeCommitGraph
     -    config behavior. While his example initially happened during a clone
     -    with --recurse-submodules, we found that it is actually a problem with
     -    the first fetch after a new clone and no existing commit-graph file:
     +    The previous commit includes a failing test for an issue around
     +    fetch.writeCommitGraph and fetching in a repo with a submodule. Here, we
     +    fix that bug and set the test to "test_expect_success".
     +
     +    The prolem arises with this set of commands when the remote repo at
     +    <url> has a submodule. Note that --recurse-submodules is not needed to
     +    demonstrate the bug.
      
                  $ git clone <url> test
                  $ cd test
     @@ -14,12 +17,7 @@
                  BUG: commit-graph.c:886: missing parent <hash1> for commit <hash2>
                  Aborted (core dumped)
      
     -    In the repo I had cloned, there were really 60 commits to scan, but
     -    only 12 were in the list to write when calling
     -    compute_generation_numbers(). A commit in the list expects to see a
     -    parent, but that parent is not in the list.
     -
     -    As an initial test, I converted the code in builtin/fetch.c that calls
     +    As an initial fix, I converted the code in builtin/fetch.c that calls
          write_commit_graph_reachable() to instead launch a "git commit-graph
          write --reachable --split" process. That code worked, but is not how we
          want the feature to work long-term.
     @@ -60,20 +58,28 @@
          flag inside close_reachable(), but the tips did not have the flag, so
          that did nothing.
      
     +    It turns out that the calculate_changed_submodule_paths() method is at
     +    fault. Thanks, Peff, for pointing out this detail! More specifically,
     +    for each submodule, the collect_changed_submodules() runs a revision
     +    walk to essentially do file-history on the list of submodules. That
     +    revision walk marks commits UNININTERESTING if they are simiplified away
     +    by not changing the submodule.
     +
          Instead, I finally arrived on the conclusion that I should use a flag
          that is not used in any other part of the code. In commit-reach.c, a
          number of flags were defined for commit walk algorithms. The REACHABLE
          flag seemed like it made the most sense, and it seems it was not
     -    actually used in the file.
     +    actually used in the file. The REACHABLE flag was used in early versions
     +    of commit-reach.c, but was removed by 4fbcca4 (commit-reach: make
     +    can_all_from_reach... linear, 2018-07-20).
      
          Add the REACHABLE flag to commit-graph.c and use it instead of
          UNINTERESTING in close_reachable(). This fixes the bug in manual
          testing.
      
     -    I have failed to produce a test using the file:// protocol that
     -    demonstrates this bug.
     -
          Reported-by: Johannes Schindelin <johannes.schindelin@gmx.de>
     +    Helped-by: Jeff King <peff@peff.net>
     +    Helped-by: Szeder Gábor <szeder.dev@gmail.com>
          Signed-off-by: Derrick Stolee <dstolee@microsoft.com>
      
       diff --git a/commit-graph.c b/commit-graph.c
     @@ -147,3 +153,16 @@
        * sha1-name.c:                                              20
        * list-objects-filter.c:                                      21
        * builtin/fsck.c:           0--3
     +
     + diff --git a/t/t5510-fetch.sh b/t/t5510-fetch.sh
     + --- a/t/t5510-fetch.sh
     + +++ b/t/t5510-fetch.sh
     +@@
     + 	)
     + '
     + 
     +-test_expect_failure 'fetch.writeCommitGraph with submodules' '
     ++test_expect_success 'fetch.writeCommitGraph with submodules' '
     + 	pwd="$(pwd)" &&
     + 	git clone dups super &&
     + 	(

-- 
gitgitgadget
