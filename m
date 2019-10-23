Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.2 (2018-09-13) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-3.9 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,RCVD_IN_DNSWL_HI,
	SPF_HELO_NONE,SPF_NONE shortcircuit=no autolearn=ham
	autolearn_force=no version=3.4.2
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 2AE1F1F4C0
	for <e@80x24.org>; Wed, 23 Oct 2019 00:29:39 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1732240AbfJWA3i (ORCPT <rfc822;e@80x24.org>);
        Tue, 22 Oct 2019 20:29:38 -0400
Received: from mail-wr1-f68.google.com ([209.85.221.68]:33092 "EHLO
        mail-wr1-f68.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727898AbfJWA3h (ORCPT <rfc822;git@vger.kernel.org>);
        Tue, 22 Oct 2019 20:29:37 -0400
Received: by mail-wr1-f68.google.com with SMTP id s1so11247921wro.0
        for <git@vger.kernel.org>; Tue, 22 Oct 2019 17:29:37 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=message-id:from:date:subject:fcc:content-transfer-encoding
         :mime-version:to:cc;
        bh=8K6sYwHWYovm4/5kWcMn3YluZoR6BoXV2x6L6dELfXU=;
        b=GBgK0wF47CSiPm+UGRO3ljuuO73Q892l1wNMCQ1w0eBJ0DqqYLmp7EQ9x++5nyRAeE
         6gk32e9vS0SygvT4dLwpt3C6u6fLTIRY4SV0jLPc1NQEsMO2FPiuL5Tyx5iBJ06CKPma
         Riw3eOCtBuQWnvwaxVkcDo+WQpNaaykEVwoyxreJUwe/3URKz5hAuPer0Pukn5XUg4qV
         Sj5aEbH1NLLzhzsSC+PkhI9kqiqFkrjeSVTH6h5OyKQhBjO6lpoJaNBBoFhlvvGkjxm4
         KF1zMp46pTM+CIeg47EehcpxgUDfT2vg7p0YYrlxY5ZvqqP7hsryta0rFOqtRasXXlMF
         qqbw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:message-id:from:date:subject:fcc
         :content-transfer-encoding:mime-version:to:cc;
        bh=8K6sYwHWYovm4/5kWcMn3YluZoR6BoXV2x6L6dELfXU=;
        b=fOkg7q72JQ/dC776RcRnnloEnMXUonQsiiiqmcDJXjACP/qEaaR4dZQMHFKCnqpb4C
         O4X6StW/ayJcXTJVNZK40Koyoiwyypt+bYdSx5DctLtyiF6aNq2AOpMUbYK0Ua4Eeh5q
         7dYEdrxriYbS9ULaPWI0ges7yUgZGNJLf4vTiEmtGNuv6uY4SO1v5puHGNLYFTaJKxz8
         nUBcQ60pxI+v5swc5RFCESqH5wh4NSINlS5Dn/sim38ihPw53cjD7RXH+DPEjtsCNJ0A
         LEi95swe23ya2GkRmxs64mtCODGG9M26Z5I3Heo9facEIrg4G9SME5doiZwhJkiNvtLn
         Csuw==
X-Gm-Message-State: APjAAAUXaWXVKHCgjlfg0bCKpcyaqdO7RhfhFTtX+pMWLh5hqy2Nxqsq
        8vdXrIYzYXaB2hbNpyR3yQq+1GAK
X-Google-Smtp-Source: APXvYqzMSG6xHvQomFIp922nVSSuEH/YSF0y9GQOmdcgUxUGcr3C15JCQ14tt9+S2rzbuwHKx2FAkA==
X-Received: by 2002:adf:fcd1:: with SMTP id f17mr6108413wrs.82.1571790576309;
        Tue, 22 Oct 2019 17:29:36 -0700 (PDT)
Received: from [127.0.0.1] ([13.74.141.28])
        by smtp.gmail.com with ESMTPSA id f20sm136610wmj.39.2019.10.22.17.29.35
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Tue, 22 Oct 2019 17:29:35 -0700 (PDT)
Message-Id: <pull.418.git.1571790574.gitgitgadget@gmail.com>
From:   "Elijah Newren via GitGitGadget" <gitgitgadget@gmail.com>
Date:   Wed, 23 Oct 2019 00:29:33 +0000
Subject: [PATCH 0/1] Thyme two ficks sum Documentaton tyops and speling erors!
Fcc:    Sent
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
MIME-Version: 1.0
To:     git@vger.kernel.org
Cc:     Junio C Hamano <gitster@pobox.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

We have a number of typos and spelling errors that I spotted under
Documentation/.

It'd be nice if someone could double check that I placed the missing right
parenthesis correctly in Documentation/technical/api-trace2.txt. Also, not
sure if folks would be happy or unhappy with me un-splitting a word in
commit-graph.txt.

Elijah Newren (1):
  Documentation: fix a bunch of typos, both old and new

 Documentation/CodingGuidelines                     |  2 +-
 Documentation/RelNotes/1.7.0.2.txt                 |  2 +-
 Documentation/RelNotes/1.7.10.4.txt                |  2 +-
 Documentation/RelNotes/1.7.12.3.txt                |  2 +-
 Documentation/RelNotes/1.7.5.3.txt                 |  2 +-
 Documentation/RelNotes/1.8.0.txt                   |  2 +-
 Documentation/RelNotes/2.1.3.txt                   |  2 +-
 Documentation/RelNotes/2.10.0.txt                  |  2 +-
 Documentation/RelNotes/2.10.2.txt                  |  2 +-
 Documentation/RelNotes/2.11.1.txt                  |  2 +-
 Documentation/RelNotes/2.12.0.txt                  |  2 +-
 Documentation/RelNotes/2.13.3.txt                  |  4 ++--
 Documentation/RelNotes/2.14.0.txt                  |  4 ++--
 Documentation/RelNotes/2.16.0.txt                  |  2 +-
 Documentation/RelNotes/2.16.3.txt                  |  2 +-
 Documentation/RelNotes/2.17.0.txt                  |  2 +-
 Documentation/RelNotes/2.18.0.txt                  |  2 +-
 Documentation/RelNotes/2.19.0.txt                  |  2 +-
 Documentation/RelNotes/2.24.0.txt                  |  2 +-
 Documentation/RelNotes/2.3.3.txt                   |  2 +-
 Documentation/RelNotes/2.3.7.txt                   |  2 +-
 Documentation/RelNotes/2.4.3.txt                   |  2 +-
 Documentation/RelNotes/2.8.0.txt                   |  2 +-
 Documentation/RelNotes/2.9.3.txt                   |  2 +-
 Documentation/config/tag.txt                       |  2 +-
 Documentation/git-bisect-lk2009.txt                |  2 +-
 Documentation/git-check-attr.txt                   |  2 +-
 Documentation/git-check-ignore.txt                 |  2 +-
 Documentation/git-filter-branch.txt                |  2 +-
 Documentation/git-range-diff.txt                   |  2 +-
 Documentation/git-tag.txt                          |  2 +-
 Documentation/gitattributes.txt                    |  2 +-
 Documentation/gitmodules.txt                       |  2 +-
 Documentation/technical/api-trace2.txt             | 14 +++++++-------
 Documentation/technical/commit-graph.txt           | 12 ++++++------
 .../technical/hash-function-transition.txt         |  2 +-
 Documentation/technical/index-format.txt           |  4 ++--
 Documentation/technical/partial-clone.txt          |  2 +-
 Documentation/technical/protocol-v2.txt            |  2 +-
 Documentation/technical/rerere.txt                 |  2 +-
 40 files changed, 54 insertions(+), 54 deletions(-)


base-commit: d966095db01190a2196e31195ea6fa0c722aa732
Published-As: https://github.com/gitgitgadget/git/releases/tag/pr-418%2Fnewren%2Ftypo-fixes-v1
Fetch-It-Via: git fetch https://github.com/gitgitgadget/git pr-418/newren/typo-fixes-v1
Pull-Request: https://github.com/gitgitgadget/git/pull/418
-- 
gitgitgadget
