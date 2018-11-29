Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.2 (2018-09-13) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-11.6 required=3.0 tests=AWL,BAYES_00,DKIMWL_WL_MED,
	DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,RCVD_IN_DNSWL_HI,USER_IN_DEF_DKIM_WL
	shortcircuit=no autolearn=ham autolearn_force=no version=3.4.2
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 490491F609
	for <e@80x24.org>; Thu, 29 Nov 2018 00:28:03 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726956AbeK2Lb2 (ORCPT <rfc822;e@80x24.org>);
        Thu, 29 Nov 2018 06:31:28 -0500
Received: from mail-qt1-f202.google.com ([209.85.160.202]:51766 "EHLO
        mail-qt1-f202.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726668AbeK2Lb2 (ORCPT <rfc822;git@vger.kernel.org>);
        Thu, 29 Nov 2018 06:31:28 -0500
Received: by mail-qt1-f202.google.com with SMTP id n39so152158qtn.18
        for <git@vger.kernel.org>; Wed, 28 Nov 2018 16:28:01 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20161025;
        h=date:message-id:mime-version:subject:from:to:cc;
        bh=PRLjJzdshoYDeDEDWn6Vj/f/JRX3xTBr/4Z+9tSGhwI=;
        b=X9wVqgwuwRJC2qJaDx776R7JXagJ2ry9crvzNgjv8OyK1T1QiGlArScVUYctsm1PxE
         v4ikJmuWNwlSnty3u6lVIPNnCBB+ABXEo7qDeVuWiWFYavLUmFbtXP3VprQnmJ6GvSJF
         yc4zSHH+SbobQyg2Ru2fMhJPZlPgmVLvAUXtP5jLHgS/dpABNtJ/juifr1zOJcHUqqGD
         YEghL5R09K3d7oYtbnY3I18K6mG5jHPCRIgKBF7LpMoUqjCfcd1/HSApD4oVl+N3FcYS
         yAR5JyMfpk32J2jy1Uz2Q+ppCAWl4nLi2/29dwv54t5DEqEEHm0E9+Z0zJQdEN0daKGu
         LuAA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:message-id:mime-version:subject:from:to:cc;
        bh=PRLjJzdshoYDeDEDWn6Vj/f/JRX3xTBr/4Z+9tSGhwI=;
        b=flJufxaKPB6mfQXgQ1mylhc3UW1Hx84rp9HhJGX2qnGEl7GxuJq/uCgO0QqJIPg1xc
         k71QOjKyyJxqZsiZtbWMl2YmeNCWp3NhHuZkAwkiPebbUZRP8MtAClNIG1+k6VAM8Uvw
         ZJta7iccerEP0UEouEcQ/Xy+f1/ylD8oGXpYcWmSONpPRg6S7Yv5/QXWi2/A5XigUn5+
         lj9XCi+jHCNTjnulelCfopA712Y0BV92ryv5voB8Oexr09t1iEsTRCSs67RDO8J6qpCu
         NwqydndnSb/UV0RiqC68mRVXTncN/cu6qZw+UjMpbftTFrgRCXARAKvqNUBChuYCCkHB
         z3gg==
X-Gm-Message-State: AA+aEWaPUUZiYYtOCiWyM/gleHkbS0xN4cHv64oYPF5qupWYauN0WlDB
        za2K+Pw1TznNvUzJuPkErj2zIBn7ztT0rMLfoQ8ZusdzvD+FLgA3oZP7/c5HP624AmApb5Dg607
        pYP8KUet1jMq2xNH7EhsWA0dtTU+9zclVWHNBkDPi1cZAG56OyvEwTJ3jcc1W
X-Google-Smtp-Source: AFSGD/XahFdVkIKJs2xzRsi4QVb/kn/hg0WY/sP1oAFIF87DReYuCRcptTMdYVJsPdlIgutSgMU2juTEJ7fo
X-Received: by 2002:a0c:9901:: with SMTP id h1mr5401931qvd.14.1543451280995;
 Wed, 28 Nov 2018 16:28:00 -0800 (PST)
Date:   Wed, 28 Nov 2018 16:27:47 -0800
Message-Id: <20181129002756.167615-1-sbeller@google.com>
Mime-Version: 1.0
X-Mailer: git-send-email 2.20.0.rc1.387.gf8505762e3-goog
Subject: [PATCHv2 0/9] Resending sb/submodule-recursive-fetch-gets-the-tip
From:   Stefan Beller <sbeller@google.com>
To:     git@vger.kernel.org
Cc:     jonathantanmy@google.com, Stefan Beller <sbeller@google.com>
Content-Type: text/plain; charset="UTF-8"
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

This is a resend of sb/submodule-recursive-fetch-gets-the-tip,
with all feedback addressed. As it took some time, I'll send it
without range-diff, but would ask for full review.

I plan on resending after the next release as this got delayed quite a bit,
which is why I also rebased it to master.

Thanks,
Stefan

Previous round:
https://public-inbox.org/git/20181016181327.107186-1-sbeller@google.com/

Stefan Beller (9):
  sha1-array: provide oid_array_filter
  submodule.c: fix indentation
  submodule.c: sort changed_submodule_names before searching it
  submodule.c: tighten scope of changed_submodule_names struct
  submodule: store OIDs in changed_submodule_names
  repository: repo_submodule_init to take a submodule struct
  submodule: migrate get_next_submodule to use repository structs
  submodule.c: fetch in submodules git directory instead of in worktree
  fetch: try fetching submodules if needed objects were not fetched

 Documentation/technical/api-oid-array.txt    |   5 +
 builtin/fetch.c                              |  11 +-
 builtin/grep.c                               |  17 +-
 builtin/ls-files.c                           |  12 +-
 builtin/submodule--helper.c                  |   2 +-
 repository.c                                 |  27 +-
 repository.h                                 |  12 +-
 sha1-array.c                                 |  17 ++
 sha1-array.h                                 |   3 +
 submodule.c                                  | 284 ++++++++++++++++---
 t/helper/test-submodule-nested-repo-config.c |   8 +-
 t/t5526-fetch-submodules.sh                  |  86 ++++++
 12 files changed, 395 insertions(+), 89 deletions(-)

-- 
2.20.0.rc1.387.gf8505762e3-goog

