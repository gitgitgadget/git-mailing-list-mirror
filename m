Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 7C335C433EF
	for <git@archiver.kernel.org>; Sat,  2 Oct 2021 18:44:15 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 4EB4B61B30
	for <git@archiver.kernel.org>; Sat,  2 Oct 2021 18:44:15 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233867AbhJBSqA (ORCPT <rfc822;git@archiver.kernel.org>);
        Sat, 2 Oct 2021 14:46:00 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:36046 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233776AbhJBSp7 (ORCPT <rfc822;git@vger.kernel.org>);
        Sat, 2 Oct 2021 14:45:59 -0400
Received: from mail-wm1-x336.google.com (mail-wm1-x336.google.com [IPv6:2a00:1450:4864:20::336])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 8FC37C0613EC
        for <git@vger.kernel.org>; Sat,  2 Oct 2021 11:44:13 -0700 (PDT)
Received: by mail-wm1-x336.google.com with SMTP id b192so9702238wmb.2
        for <git@vger.kernel.org>; Sat, 02 Oct 2021 11:44:13 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=from:to:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=QlMNoG6f6mAJkUMUTL7sNCtq2gU6uSdUsTRfgj6KFB0=;
        b=bhiKGnu8tPkt5ssG5lUy0IFWpc2CuQMf5qIsvt8KjKZ7GMkwOsAmgGF8l7GEEcqpVF
         WqvMTSsK+RdZBgeHGAeonNvYsD6PRtuBjf8bQr3O0m9rpB6Ccfjrxh/n0GcqRYnFGWKn
         Y4oaCAOj13QhDSuqzHqYFe82/M63vldcWkuNQwYV8rCTqm5uwdLGciMcYNUqHYOCOXfP
         UBnS7cgjHsH57wRYywKYK8qAskEYxzP+T3a7aeEuL4lORyf3Ajsc9bjia01qisjTv1In
         roNcQJoe4iU0Z2dLeBMmpn4MNGjyftis6XXKJSs+nwBZuUkEjVBeHwFQ0LaQzW4u+9Bn
         th6A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:from:to:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=QlMNoG6f6mAJkUMUTL7sNCtq2gU6uSdUsTRfgj6KFB0=;
        b=olbrLsKR4GBsfrbQz3r9lnoWd13WWvwstWmftVfM18bjS+ZUlyw4/9BIYEEN7ENyci
         4+T0S3K0TTHEGSrpMu6VDqubiuRJiHbxje5fmrAYzrXuXuDRfcxfXekmLrU2LYdfJWIU
         40Jl2vPBrp76VLmh6TwFgBhOhyaSFaTVYUbFAE/sW5vKvV6vKjquHQROPzefN2j1zEbv
         ZPbNvDDE4hYB0koF7O1Xu61cr8WZndbzoXjx1GH0AHzujyZ02RVO+6TgPvQqrS0a5fI5
         GKOiS1JdTpsUfq4TtuixjQ++he8gHQRyRBNXEgUYQxGFvtSgnLiiPSYf9hRa9of4ihXq
         81GQ==
X-Gm-Message-State: AOAM533G+WctjLd/o27xWTJhPPqBc9EmYFqT8DPf7TNXNPR9KrJKdwud
        K4I6SNW2cjyvV46xZEISVmF8QclvLcXn5g==
X-Google-Smtp-Source: ABdhPJzSuZEgGfM2h/g1ln+oKhb73npqvB7FhUo28lsac/sLpi87Z7pJcpuI+HfAE+mduRIDB+tnHA==
X-Received: by 2002:a05:600c:358d:: with SMTP id p13mr10568602wmq.71.1633200251801;
        Sat, 02 Oct 2021 11:44:11 -0700 (PDT)
Received: from localhost.localdomain ([154.13.1.35])
        by smtp.gmail.com with ESMTPSA id o1sm10379552wmq.26.2021.10.02.11.44.10
        for <git@vger.kernel.org>
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sat, 02 Oct 2021 11:44:11 -0700 (PDT)
From:   Andrei Rybak <rybak.a.v@gmail.com>
To:     git@vger.kernel.org
Subject: [PATCH v1 0/3] Typofixes
Date:   Sat,  2 Oct 2021 20:44:04 +0200
Message-Id: <20211002184407.117282-1-rybak.a.v@gmail.com>
X-Mailer: git-send-email 2.33.0
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Here are three patches for fixes in spelling and punctuation.

Andrei Rybak (3):
  *: spell Latin abbreviations correctly
  *: fix spelling typos
  difftool: add space after full stop in comments

 Documentation/config.txt                       |  2 +-
 Documentation/config/commitgraph.txt           |  2 +-
 Documentation/config/mergetool.txt             |  2 +-
 Documentation/git-describe.txt                 |  2 +-
 Documentation/git-format-patch.txt             |  2 +-
 Documentation/git-mktag.txt                    |  2 +-
 Documentation/git-tag.txt                      |  2 +-
 Documentation/git.txt                          |  2 +-
 .../technical/commit-graph-format.txt          |  2 +-
 Documentation/technical/commit-graph.txt       |  4 ++--
 .../technical/remembering-renames.txt          |  2 +-
 bloom.h                                        |  2 +-
 builtin/difftool.c                             |  4 ++--
 builtin/help.c                                 |  2 +-
 builtin/name-rev.c                             |  2 +-
 cbtree.c                                       |  2 +-
 commit-graph.h                                 |  2 +-
 compat/precompose_utf8.c                       |  2 +-
 compat/regex/regcomp.c                         |  2 +-
 compat/simple-ipc/ipc-unix-socket.c            |  2 +-
 contrib/coccinelle/README                      |  2 +-
 .../diff-highlight/t/t9400-diff-highlight.sh   |  2 +-
 contrib/subtree/todo                           |  4 ++--
 convert.c                                      |  2 +-
 diffcore-rename.c                              |  2 +-
 git-instaweb.sh                                |  2 +-
 git-p4.py                                      | 10 +++++-----
 merge-ort.c                                    |  6 +++---
 midx.c                                         |  2 +-
 perl/Git/I18N.pm                               |  2 +-
 rebase.c                                       |  2 +-
 run-command.h                                  |  2 +-
 sideband.c                                     |  2 +-
 t/t0000-basic.sh                               |  4 ++--
 t/t0021-conversion.sh                          |  4 ++--
 t/t0021/rot13-filter.pl                        |  2 +-
 t/t1407-worktree-ref-store.sh                  |  2 +-
 t/t2082-parallel-checkout-attributes.sh        |  2 +-
 t/t3431-rebase-fork-point.sh                   |  2 +-
 t/t5411/test-0034-report-ft.sh                 |  2 +-
 t/t5411/test-0035-report-ft--porcelain.sh      |  2 +-
 t/t5531-deep-submodule-push.sh                 |  2 +-
 t/t6404-recursive-merge.sh                     |  2 +-
 t/t7064-wtstatus-pv2.sh                        |  2 +-
 t/t7601-merge-pull-config.sh                   |  2 +-
 t/t8009-blame-vs-topicbranches.sh              |  2 +-
 t/t9150/svk-merge.dump                         | 10 +++++-----
 t/t9151/svn-mergeinfo.dump                     | 18 +++++++++---------
 trace2/tr2_tls.h                               |  2 +-
 transport.c                                    |  6 +++---
 50 files changed, 75 insertions(+), 75 deletions(-)

-- 
2.33.0

