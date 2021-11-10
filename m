Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 3380DC433F5
	for <git@archiver.kernel.org>; Wed, 10 Nov 2021 06:41:35 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 05AC96117A
	for <git@archiver.kernel.org>; Wed, 10 Nov 2021 06:41:34 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230175AbhKJGoV (ORCPT <rfc822;git@archiver.kernel.org>);
        Wed, 10 Nov 2021 01:44:21 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:48238 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230037AbhKJGoU (ORCPT <rfc822;git@vger.kernel.org>);
        Wed, 10 Nov 2021 01:44:20 -0500
Received: from mail-wm1-x334.google.com (mail-wm1-x334.google.com [IPv6:2a00:1450:4864:20::334])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 2DD92C061764
        for <git@vger.kernel.org>; Tue,  9 Nov 2021 22:41:33 -0800 (PST)
Received: by mail-wm1-x334.google.com with SMTP id o4-20020a1c7504000000b0032cab7473caso2913920wmc.1
        for <git@vger.kernel.org>; Tue, 09 Nov 2021 22:41:33 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=message-id:from:date:subject:fcc:content-transfer-encoding
         :mime-version:to:cc;
        bh=4Sys+KTMixKS9ssomEfp+R6IfRM5QWgVs/e9nYdI6aw=;
        b=TfXroR05mPOQCLSnPv1T2bVJb4XAJzboq6rwvZwkGOdqtm8lcQQLyiT27ykIa+e5zW
         gXBsAN8MYvDB/rwlnerK4Xgw1pSNqFImoYNEkNQEA43IsyFy/9fzPY3Kh1gXL5aLq44K
         kIbtWck7h4D0yxHkwGppLL3p9h83miHYhwFCU3q7yXZt+jeSU7FyRnrK3YQOYnns5dnU
         nNmvCpJ1zxsb6ytm99TUbZY8IUIUYSUgSkIIm4/DqwpHoYq/wjOwi4wsoBY70mR7psYo
         NmIZjmT6+ZWARsVp/TYOQfIf11ATR/VwtMeBpfyyHIl0H/Ytuo126gGrghoaw7gw6hqk
         08pg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:message-id:from:date:subject:fcc
         :content-transfer-encoding:mime-version:to:cc;
        bh=4Sys+KTMixKS9ssomEfp+R6IfRM5QWgVs/e9nYdI6aw=;
        b=M4MInXaRxF0AXTLoaSnRTbvRIW94gCiW3kQAMEuLA36jq1GMfcqe2LX8yJfx6D6v5T
         XcRBhxk+7G+K2VDB9/R+2fk7xZ6thWSJB08n/Muu7xusMe3SMHQAqCjuQacLNtqBKCOd
         X3KAsU2Tr4RSg+23izKsWD3IRM7BGLYrRvYbdab6nuSbIxD52Fas4gcLa+Z7q2lLSVhF
         voz0UHDyDLi80Uit1HorMUNIr3SiSympOrqpoHANc8i+mfKTpwu2Di77t7yFSX6G8nAH
         6+RRiY8n8YNbDZe9z8ZlwkTL3GSJFv+DPKqwiySNchV+OeXVTVuIINj0Cgf16ECnEW4W
         1vlg==
X-Gm-Message-State: AOAM530MRwPF7zsfBCf6w4tfOHh+R9JZbfDCUcIK/llMMJuENopDu+YG
        NjLMLR7BMoPuAyRtoSpEmvsSX+lvisA=
X-Google-Smtp-Source: ABdhPJy0w6qwFz3nY8ujgGGRTOgJvZXex4+jn55eHPvfjH4ri788XmwlHtiqrXu/LIgCqNypH6QQ3A==
X-Received: by 2002:a05:600c:6d2:: with SMTP id b18mr14553254wmn.98.1636526491480;
        Tue, 09 Nov 2021 22:41:31 -0800 (PST)
Received: from [127.0.0.1] ([13.74.141.28])
        by smtp.gmail.com with ESMTPSA id 126sm4497790wmz.28.2021.11.09.22.41.31
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 09 Nov 2021 22:41:31 -0800 (PST)
Message-Id: <pull.1073.git.1636526490570.gitgitgadget@gmail.com>
From:   "Johannes Schindelin via GitGitGadget" <gitgitgadget@gmail.com>
Date:   Wed, 10 Nov 2021 06:41:30 +0000
Subject: [PATCH] RelNotes: fix a couple of typos for the upcoming release
Fcc:    Sent
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
MIME-Version: 1.0
To:     git@vger.kernel.org
Cc:     Johannes Schindelin <johannes.schindelin@gmx.de>,
        Johannes Schindelin <johannes.schindelin@gmx.de>
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

From: Johannes Schindelin <johannes.schindelin@gmx.de>

Signed-off-by: Johannes Schindelin <johannes.schindelin@gmx.de>
---
    RelNotes: fix a couple of typos for the upcoming release
    
    I noticed one of them while reviewing the Git for Windows rebase, and
    decided to give VS Code with cSpell a whirl.
    
    Note: cSpell pointed out more words it deems not to be English, such as
    docfix and leakfix and segfaulted. I was on the fence, but figured that
    those are "Git speak", so I left them alone.

Published-As: https://github.com/gitgitgadget/git/releases/tag/pr-1073%2Fdscho%2Ffix-relnotes-typos-v1
Fetch-It-Via: git fetch https://github.com/gitgitgadget/git pr-1073/dscho/fix-relnotes-typos-v1
Pull-Request: https://github.com/gitgitgadget/git/pull/1073

 Documentation/RelNotes/2.34.0.txt | 4 ++--
 1 file changed, 2 insertions(+), 2 deletions(-)

diff --git a/Documentation/RelNotes/2.34.0.txt b/Documentation/RelNotes/2.34.0.txt
index effab2ea4b2..e9de4d457b5 100644
--- a/Documentation/RelNotes/2.34.0.txt
+++ b/Documentation/RelNotes/2.34.0.txt
@@ -182,7 +182,7 @@ Performance, Internal Implementation, Development Support etc.
  * Prevent "make sparse" from running for the source files that
    haven't been modified.
 
- * The codepath to write a new version of .midx multi-pack index files
+ * The code path to write a new version of .midx multi-pack index files
    has learned to release the mmaped memory holding the current
    version of .midx before removing them from the disk, as some
    platforms do not allow removal of a file that still has mapping.
@@ -405,7 +405,7 @@ Fixes since v2.33
    (merge 47bfdfb3fd ar/fix-git-pull-no-verify later to maint).
 
  * One CI task based on Fedora image noticed a not-quite-kosher
-   consturct recently, which has been corrected.
+   construct recently, which has been corrected.
    (merge 4b540cf913 vd/pthread-setspecific-g11-fix later to maint).
 
  * Other code cleanup, docfix, build fix, etc.

base-commit: 6c220937e2b26d85920bf2d38ff2464a0d57fd6b
-- 
gitgitgadget
