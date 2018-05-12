Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-3.5 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,RCVD_IN_DNSWL_HI
	shortcircuit=no autolearn=ham autolearn_force=no version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 224D21F42D
	for <e@80x24.org>; Sat, 12 May 2018 08:00:37 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1750772AbeELIAe (ORCPT <rfc822;e@80x24.org>);
        Sat, 12 May 2018 04:00:34 -0400
Received: from mail-lf0-f66.google.com ([209.85.215.66]:34077 "EHLO
        mail-lf0-f66.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1750722AbeELIAd (ORCPT <rfc822;git@vger.kernel.org>);
        Sat, 12 May 2018 04:00:33 -0400
Received: by mail-lf0-f66.google.com with SMTP id r25-v6so11061836lfd.1
        for <git@vger.kernel.org>; Sat, 12 May 2018 01:00:33 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=qgyw38QcAGxOD2Q3lrCRYdsppGYMm1Vf9Y3Bred6xlA=;
        b=hN9aNqGv9965gAPUc8wcAF66c4hiVZk7Gv9IGLdjj1uMl/tlAOfNHM6xW2qF0VVTQ9
         PQq/Y+PIMEiZOyq/1aIw1e+Tkj7CAbBL12iVhLCwnCIEaQhKBDIGfZg5g0sPbIJzFU5A
         CbD51uCypmwnCWjrHlbm6caGHM7l/B5yHjgxgjSXqg6dvyBgK7CpTvhrPtyH2dMI+nhy
         mj951SHOJL9EAlBZ1RQ/bCofnHyFKNemQV5vLUhsmwaU/JEThdW4ZTf0nYR5Xr+POHhq
         VA1kqn+CR50vZ1u54h4Tj6MY20GGuEdZRehCmd0pztPPGmgBgdHJxUH7eFxwaiJNjSJ1
         NzBQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=qgyw38QcAGxOD2Q3lrCRYdsppGYMm1Vf9Y3Bred6xlA=;
        b=WS7oiMEljHL7WGqTug4kO30pUo6Y5Rp/J/nr42zBlqVOBJjsGy/AupNbP3HOwgVPgc
         tz5CjFqQ9ERfZuRZXZirXvAjIw4VfnIqch7OkwsmybwoKAO/2HxsS7wtYxp88Trx1GTO
         cFPXJUcyeKtt05833CqDwdw7hJWp8Kq4pUXJDIC2IIOgXW05ol7dMbA6/NieLr4ARu7y
         NM+AN6wH8qM5bGAywPNF1IfafSTQvXpiagBUuvTCNBtHTISll+xMRnUeCuhSM4Wq6MzX
         9mxnqEUO6+8SEITzGeezGntU7GBf3kFLZgN3aoJlS3NQQhIiDruL+iHIEYiPPiSGrDff
         pIyA==
X-Gm-Message-State: ALKqPwd62V9s1NL0bQVegnUd/kddtyx/qAjwpaWHdNDvXmBDtH8wfHNp
        7l+cZBvKw5sYbE6zjdVMTL9yFQ==
X-Google-Smtp-Source: AB8JxZpJ1uc1e7yCU8xjN519Y3SLyc5C0SUZxmHrZsNbAgpwj09iSuYIuKcLzWDEUxdjKW862Yw1oA==
X-Received: by 2002:a19:1256:: with SMTP id h83-v6mr3624170lfi.86.1526112031969;
        Sat, 12 May 2018 01:00:31 -0700 (PDT)
Received: from localhost.localdomain (c80-216-12-205.bredband.comhem.se. [80.216.12.205])
        by smtp.gmail.com with ESMTPSA id i20-v6sm1055369lfe.69.2018.05.12.01.00.30
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Sat, 12 May 2018 01:00:31 -0700 (PDT)
From:   =?UTF-8?q?Nguy=E1=BB=85n=20Th=C3=A1i=20Ng=E1=BB=8Dc=20Duy?= 
        <pclouds@gmail.com>
To:     git@vger.kernel.org
Cc:     =?UTF-8?q?Nguy=E1=BB=85n=20Th=C3=A1i=20Ng=E1=BB=8Dc=20Duy?= 
        <pclouds@gmail.com>
Subject: [PATCH 00/12] Die commit->util, die!
Date:   Sat, 12 May 2018 10:00:16 +0200
Message-Id: <20180512080028.29611-1-pclouds@gmail.com>
X-Mailer: git-send-email 2.17.0.705.g3525833791
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

There's not much to write here. It's basically a copy from 12/12:

This 'util' pointer can be used for many different purposes,
controlled in different ways. Some are not even contained in a command
code, but buried deep in common code with no clue who will use it and
how. For example, if revs.show_source is set, then it's used for
storing path name, but if you happen to call get_merge_parent() then
some 'util' may end up storing another thing.

The move to using commit-slab gives us a much better picture of how
some piece of data is associated with a commit and what for. Since
nobody uses 'util' pointer anymore, we can retire it so that nobody will
abuse it again. commit-slab will be the way forward for associating
data to a commit.

As a side benefit, this shrinks struct commit by 8 bytes (on 64-bit
architecture) which should help reduce memory usage for reachability
test a bit. This is also what commit-slab is invented for [1].

[1] 96c4f4a370 (commit: allow associating auxiliary info on-demand -
2013-04-09)

Nguyễn Thái Ngọc Duy (12):
  blame: use commit-slab for blame suspects instead of commit->util
  describe: use commit-slab for commit names instead of commit->util
  shallow.c: use commit-slab for commit depth instead of commit->util
  sequencer.c: use commit-slab to mark seen commits
  sequencer.c: use commit-slab to associate todo items to commits
  revision.c: use commit-slab for show_source
  bisect.c: use commit-slab for commit weight instead of commit->util
  name-rev: use commit-slab for rev-name instead of commit->util
  show-branch: use commit-slab for commit-name instead of commit->util
  log: use commit-slab in prepare_bases() instead of commit->util
  merge: use commit-slab in merge remote desc instead of commit->util
  commit.h: delete 'util' field in struct commit

 bisect.c              | 12 +++++++++---
 blame.c               | 42 +++++++++++++++++++++++++++++++-----------
 blame.h               |  2 ++
 builtin/blame.c       |  2 +-
 builtin/describe.c    | 16 +++++++++++++---
 builtin/fast-export.c | 14 +++++++++-----
 builtin/log.c         | 17 +++++++++++++----
 builtin/merge.c       | 25 +++++++++++++------------
 builtin/name-rev.c    | 23 ++++++++++++++++++++---
 builtin/show-branch.c | 39 +++++++++++++++++++++++++++------------
 commit.c              | 12 ++++++++++--
 commit.h              |  8 ++++++--
 log-tree.c            |  8 ++++++--
 merge-recursive.c     |  8 +++++---
 revision.c            | 17 +++++++++++++----
 revision.h            |  5 ++++-
 sequencer.c           | 24 ++++++++++++++++++------
 shallow.c             | 37 +++++++++++++++++++++++++------------
 18 files changed, 225 insertions(+), 86 deletions(-)

-- 
2.17.0.705.g3525833791

