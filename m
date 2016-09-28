Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-5.7 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_HI,RCVD_IN_SORBS_SPAM,
	RP_MATCHES_RCVD shortcircuit=no autolearn=ham autolearn_force=no version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id AF731207EC
	for <e@80x24.org>; Wed, 28 Sep 2016 11:44:11 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1753026AbcI1LoF (ORCPT <rfc822;e@80x24.org>);
        Wed, 28 Sep 2016 07:44:05 -0400
Received: from mail-pa0-f65.google.com ([209.85.220.65]:34157 "EHLO
        mail-pa0-f65.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1753050AbcI1LoD (ORCPT <rfc822;git@vger.kernel.org>);
        Wed, 28 Sep 2016 07:44:03 -0400
Received: by mail-pa0-f65.google.com with SMTP id r9so1323228paz.1
        for <git@vger.kernel.org>; Wed, 28 Sep 2016 04:44:03 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20120113;
        h=from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=UoBnFCHGonSrkVpw5dhLZQIbW1oWlxRrD0Mn/JZAtY0=;
        b=TQz/OQtnPeUyF2IB4g7a8mdDnLXH+x1SGXRejtfnKbkFviqkzTW2DAUk/K4EQ5KjKr
         JHYwbNxsuHk2dmonrFrZf5AxvMdMml3Kqe8mm7ieQGi4xFfiATuwd7cYV7Rbeb7zzye7
         wvmtpxY/yrqn6TO+WnmSXVbB76QHuo1HblFRGlqtphpgukPKKjRHvqQvCay4Pvg5R0NY
         GBl4hB5r8n8ETZXznYhoaH1TdhILkMJHUrQHszSLaK/Z2w+w0LEWySHxXiZp5Iu9dc2C
         Ge3T2izEAjfI0yBnfN+06SXLLSpvEJuk1VWhEr+qtPt0z1Z1a3o2JSAcubT0yW+pCl3M
         lPBQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20130820;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=UoBnFCHGonSrkVpw5dhLZQIbW1oWlxRrD0Mn/JZAtY0=;
        b=FngNn6SiezOBCinwVnkESL3NhkWPqs0LtOBove4lrZI+ODlObbGUJVSzamG+0+sPyQ
         pq1i3JyIfRBzgd12Nn79zqgapwyHd4eGJRCYG2M7S2TDAPkDtbP5WB6KTfhDnrsInnYN
         85Q9dFiE8sLpdndiaZirsHFDOJiKkuW0dltg8pOwKFojjt7Ewk01JyrXy96CiNIu5RHO
         q+T3WtgkmeAnKUrZ7QLhfvT7qN5ImqTvnpYjbyHtY+0NKFYxUWwXoG6MKxaCB6GMPco8
         /wICKeaLqQxg8gyA5WHeYHsr0hvq60uP6ziUzvSfmD14Bl0czXEE+jDHhi9TE7NoHjNd
         0r5w==
X-Gm-Message-State: AE9vXwMG3q/858BXWB0W4C+Glf4WeqbJm9bojSigMc89WPYU+oJ28v9q3mx8AlpDJHW2tQ==
X-Received: by 10.66.10.102 with SMTP id h6mr56565351pab.112.1475063042732;
        Wed, 28 Sep 2016 04:44:02 -0700 (PDT)
Received: from ash ([115.76.130.63])
        by smtp.gmail.com with ESMTPSA id yg10sm12078887pab.8.2016.09.28.04.43.59
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Wed, 28 Sep 2016 04:44:02 -0700 (PDT)
Received: by ash (sSMTP sendmail emulation); Wed, 28 Sep 2016 18:43:55 +0700
From:   =?UTF-8?q?Nguy=E1=BB=85n=20Th=C3=A1i=20Ng=E1=BB=8Dc=20Duy?= 
        <pclouds@gmail.com>
To:     git@vger.kernel.org
Cc:     Junio C Hamano <gitster@pobox.com>,
        =?UTF-8?q?Nguy=E1=BB=85n=20Th=C3=A1i=20Ng=E1=BB=8Dc=20Duy?= 
        <pclouds@gmail.com>
Subject: [PATCH 0/3] i-t-a entries in git-status, and git-commit
Date:   Wed, 28 Sep 2016 18:43:45 +0700
Message-Id: <20160928114348.1470-1-pclouds@gmail.com>
X-Mailer: git-send-email 2.8.2.524.g6ff3d78
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Let's see if I can get the first commit graduated before it turns two
years old. Six months to go! This series is about some oddities of
intent-to-add entries (aka "git add -N"):

1) An ita entry in git-status shows that it's added in the index
   (compared to worktree) as a file change, not new file addition. And
   it shows the entry added to HEAD as an empty version. This is due
   to an implementation detail that i-t-a entries are registered in
   the index as empty blobs with a special flag.

2) When you do a "git commit" with no changes whatsoever, but you
   happen to have some ita entries registered, git-commit does not
   recognize the resulting commit would be empty and should be caught,
   unless --allow-empty is given. This has been reported several times.

3) Same symptom as 2) but with initial commit (diff code is not used
   for detecting empty commits this time). If you only have ita
   entries in the index by the time you make an initial commit, you'll
   create an empty commit even if --allow-empty is not specified.

1) and 2) are fixed by changing the position of ita entries in diff
code. ita entries should be seen as a new file when compared between
worktree and HEAD, and no change when compared between index and HEAD.

Some previous commit made this move globally and was reverted because
it could have dangerous unseen side effects, especially in merge code.
Now we are moving slowly towards that (first patch), this time we try
to handle case by case (e.g. index_differs_from in the second patch).

3) could be handled pretty easily once you know the problem. This is
the third patch.

Nguyễn Thái Ngọc Duy (3):
  Resurrect "diff-lib.c: adjust position of i-t-a entries in diff"
  diff-lib.c: enable --shift-ita in index_differs_from()
  commit: don't be fooled by ita entries when creating initial commit

 Documentation/diff-options.txt |  7 +++++++
 builtin/commit.c               | 11 ++++++++---
 cache.h                        |  1 +
 diff-lib.c                     | 13 +++++++++++++
 diff.c                         |  2 ++
 diff.h                         |  1 +
 read-cache.c                   | 10 ++++++++++
 sequencer.c                    |  5 +++--
 t/t2203-add-intent.sh          | 41 +++++++++++++++++++++++++++++++++++++++--
 t/t7064-wtstatus-pv2.sh        |  4 ++--
 wt-status.c                    |  7 ++++++-
 11 files changed, 92 insertions(+), 10 deletions(-)

-- 
2.8.2.524.g6ff3d78

