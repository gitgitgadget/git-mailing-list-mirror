Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id F0479C433F5
	for <git@archiver.kernel.org>; Sun, 20 Mar 2022 21:54:58 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1343755AbiCTV4U (ORCPT <rfc822;git@archiver.kernel.org>);
        Sun, 20 Mar 2022 17:56:20 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:60884 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S235433AbiCTV4T (ORCPT <rfc822;git@vger.kernel.org>);
        Sun, 20 Mar 2022 17:56:19 -0400
Received: from mail-wr1-x432.google.com (mail-wr1-x432.google.com [IPv6:2a00:1450:4864:20::432])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 69BA8E018
        for <git@vger.kernel.org>; Sun, 20 Mar 2022 14:54:55 -0700 (PDT)
Received: by mail-wr1-x432.google.com with SMTP id j18so8827314wrd.6
        for <git@vger.kernel.org>; Sun, 20 Mar 2022 14:54:55 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=message-id:from:date:subject:mime-version:content-transfer-encoding
         :fcc:to:cc;
        bh=2VQIUcJjxBm2WIITr9xGDUde+bM8jKJQmAvntAlJyKI=;
        b=OcgvHhSBHK+CFGxWVjwnA7W2lZWufYQJWmKNDDAUrwBTq7y2xekBprp0N0oXV3dRsg
         xzxAZO6FFIgMcfdtYq/+/JwAFxuF7HeCys6Ha+H2NQxQ3wOcX6KVRwC4egtBfJAWrFQ2
         oCSRT+Gbwx79hgudSLfpEqC4M71Hjs6YxauzWYE0PtWdcrYiY1p1bBzhflEN+rnqS/+O
         KcJJ5p0tFBw7zHirw2VlULkH5FnQU6IiwDLTU2g2+ilaVT2qqLvGgW1/AXtfMs5Dsq9g
         LTB4SV4GC1zUWza2BOER/NpBnSrzC+1NISbIUwCUE4H/EbLIY5IKLgFk/Z6TMTaElFjA
         BTDg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:message-id:from:date:subject:mime-version
         :content-transfer-encoding:fcc:to:cc;
        bh=2VQIUcJjxBm2WIITr9xGDUde+bM8jKJQmAvntAlJyKI=;
        b=PRkibuOm4b0AthCYfvRBn3plkdaU/xoWl8B+V8bIf4IC3Nfk9WkNVQPBgCJNDmzcmn
         gulFIBDIHpFmuF2nwQ90jBGP8T7bp7Zi6QNrwNt9j8t2XpugX9m2GEFNd2Yo4meS13Ug
         R8FWRep1iVfokAV+92WSdoDIiOP5bcH/irdWm7n9AWyNmw/02PgJHhH4+4yj67h6uizy
         xiNLPy5/AR3t/f4YeBc+ETcyXBs/3Vx4R4Vs8shKV4R/Cq7V8DihRETYPe2LMIvazaL4
         TxCjmgy45wyHkW7niEeEy4XglVGdQ0w8ZFleLjt/Y4e1rIyWFm3SlLV0TiLABUaA5YaO
         LimA==
X-Gm-Message-State: AOAM5315JXKCeSUXnehVpEb6WeqSF9bsi46ayjNeFwMUo/UNOeiWYXxe
        1iJVXK9D7jy6YIpIEnnAyUlSoU7wgyc=
X-Google-Smtp-Source: ABdhPJzqVEE+T1EdHNoRkXkWPMqjq75Vcu/Df0yClM/z8ZXlDtmUqzejEdpz8xIng5k1EGQSwWXHWQ==
X-Received: by 2002:a5d:6405:0:b0:204:1ef:56e8 with SMTP id z5-20020a5d6405000000b0020401ef56e8mr6295862wru.677.1647813293698;
        Sun, 20 Mar 2022 14:54:53 -0700 (PDT)
Received: from [127.0.0.1] ([13.74.141.28])
        by smtp.gmail.com with ESMTPSA id g3-20020a5d64e3000000b00203d9264605sm12150098wri.25.2022.03.20.14.54.52
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sun, 20 Mar 2022 14:54:53 -0700 (PDT)
Message-Id: <pull.1181.git.1647813291.gitgitgadget@gmail.com>
From:   "=?UTF-8?Q?Jean-No=C3=ABl?= Avila via GitGitGadget" 
        <gitgitgadget@gmail.com>
Date:   Sun, 20 Mar 2022 21:54:44 +0000
Subject: [PATCH 0/7] More i18n fixes
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Fcc:    Sent
To:     git@vger.kernel.org
Cc:     =?UTF-8?Q?Jean-No=C3=ABl?= Avila <jn.avila@free.fr>
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

This is another i18n PR (and hopefully the last for a while).

As usual, the intent is kept the same: curbing the number of strings to
translate, remove constant, error prone parts out of the way, trying in some
sense to "put a precedent" so that the template strings can be reused later.

This series has also a RFC status: can "bad argument" messages be merged
with unrecognized argument?

Bagas Sanjaya (1):
  sequencer: factor GIT_AUTHOR_* from message strings

Jean-Noël Avila (6):
  i18n: factorize generic failure messages
  i18n: factorize "bad argument" messages
  i18n: factorize "Server does not support foo" messages
  i18n: factorize "foo does not take arguments" messages
  i18n: factorize read-cache error messages
  i18n: factorize unrecognized options arguments messages

 add-patch.c                     |  4 ++--
 builtin/am.c                    |  2 +-
 builtin/bisect--helper.c        |  2 +-
 builtin/commit-graph.c          |  2 +-
 builtin/config.c                |  2 +-
 builtin/env--helper.c           |  2 +-
 builtin/gc.c                    |  8 ++++----
 builtin/merge.c                 |  6 +++---
 builtin/revert.c                |  4 ++--
 contrib/scalar/scalar.c         |  2 +-
 diff.c                          |  4 ++--
 fetch-pack.c                    |  8 ++++----
 read-cache.c                    |  8 ++++----
 ref-filter.c                    |  8 ++++----
 remote-curl.c                   |  2 +-
 sequencer.c                     | 12 ++++++------
 setup.c                         |  4 ++--
 submodule.c                     |  2 +-
 t/t3510-cherry-pick-sequence.sh |  8 ++++----
 t/t6436-merge-overwrite.sh      |  2 +-
 20 files changed, 46 insertions(+), 46 deletions(-)


base-commit: 74cc1aa55f30ed76424a0e7226ab519aa6265061
Published-As: https://github.com/gitgitgadget/git/releases/tag/pr-1181%2Fjnavila%2Fmore_i18n_fixes-v1
Fetch-It-Via: git fetch https://github.com/gitgitgadget/git pr-1181/jnavila/more_i18n_fixes-v1
Pull-Request: https://github.com/gitgitgadget/git/pull/1181
-- 
gitgitgadget
