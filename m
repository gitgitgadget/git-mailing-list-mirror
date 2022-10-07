Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id DC683C433F5
	for <git@archiver.kernel.org>; Fri,  7 Oct 2022 11:17:35 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229514AbiJGLRf (ORCPT <rfc822;git@archiver.kernel.org>);
        Fri, 7 Oct 2022 07:17:35 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:38220 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229534AbiJGLRe (ORCPT <rfc822;git@vger.kernel.org>);
        Fri, 7 Oct 2022 07:17:34 -0400
Received: from mail-wr1-x431.google.com (mail-wr1-x431.google.com [IPv6:2a00:1450:4864:20::431])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 0EA43AE225
        for <git@vger.kernel.org>; Fri,  7 Oct 2022 04:17:32 -0700 (PDT)
Received: by mail-wr1-x431.google.com with SMTP id bk15so6759151wrb.13
        for <git@vger.kernel.org>; Fri, 07 Oct 2022 04:17:32 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=cc:to:mime-version:content-transfer-encoding:fcc:subject:date:from
         :message-id:from:to:cc:subject:date:message-id:reply-to;
        bh=PmIdsRWhispHZ9GxmN/koo+LKhUpAjprHCZ2WNMkxts=;
        b=K+169+rDXc+PcoZvXjpPAH0U51wLJfWHffDJL3zTqhXQyxGJr7LoesA3gZPV7xA3SW
         yybNGOJcTT3mHfdLgtQF0WxWThp1/wJDd7UkqV68lWfs36cfTn+vcmTIARStQ4+/2fal
         p7e15qc/2pIj8HpVxTwgG5F85AcXaExtGwgNpLlEeyLnaowMJ4dhwY3wSZJ+nQgf8Hk7
         ihIuFhLkY5eHNcdsB5JN3YpifoohcicdjF+Hvy2Du6uP9R7fXKKOjsHl2Ok4Zti1P32O
         6j6UVSuIeVDWMyTZiMlJqYF5SNRJaYpQlU3CxXXfpeh1fPNzMggkyb4jfon13TXcCUiR
         WS2g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=cc:to:mime-version:content-transfer-encoding:fcc:subject:date:from
         :message-id:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=PmIdsRWhispHZ9GxmN/koo+LKhUpAjprHCZ2WNMkxts=;
        b=LdtMUo5CRpt6h19GfOanWe58jIAL9H+84ayPHZUhVxE32vbA+0AFG6Oe6AsZxulzfk
         CgWjmCEcswkBZbord8pto+zTaJYMiNTKKfCbb7c3og2kMcup2n4x4lric1qyuSiWf82J
         LVL1luNf8GLEjMd/MfgCviSkGIdPOrAo3nIXxjaNMorJMbtYe9wWmGBo2Xe3dHV6vSzq
         MBj6cjINP6AihajJitBb1rh4Sbp3+uRxAIAnFV5W8a66tnEEdiZP0F+21vD4N/Mf3Kvw
         Wgr8O2QK4J5jj3aHP577CWRERCq6Tyvi1++DTkX0MX9mHcjfKcwyBrIxjxnrznDqoEnd
         lSDw==
X-Gm-Message-State: ACrzQf2xe8J9+egSRjitkh2oSaSO9Kjgl8R5VDIUqfMYdQp86uKepNkM
        1blyoTfDhCy/C6z/Q+ukZ6Rv0rQoaEM=
X-Google-Smtp-Source: AMsMyM6GxQglXLxs0hw77UfmvCWFxXIOVBIOjKxi1tCQeOfPJAI7rUEWnDZUaDLkN/4yDx8rcGjclQ==
X-Received: by 2002:a5d:4a4e:0:b0:22e:64a6:7a52 with SMTP id v14-20020a5d4a4e000000b0022e64a67a52mr2880086wrs.333.1665141450887;
        Fri, 07 Oct 2022 04:17:30 -0700 (PDT)
Received: from [127.0.0.1] ([13.74.141.28])
        by smtp.gmail.com with ESMTPSA id i15-20020adffdcf000000b00223b8168b15sm1792042wrs.66.2022.10.07.04.17.30
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 07 Oct 2022 04:17:30 -0700 (PDT)
Message-Id: <pull.1376.git.1665141449621.gitgitgadget@gmail.com>
From:   "Michael Schindler via GitGitGadget" <gitgitgadget@gmail.com>
Date:   Fri, 07 Oct 2022 11:17:29 +0000
Subject: [PATCH] Update kdiff3 install location
Fcc:    Sent
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
MIME-Version: 1.0
To:     git@vger.kernel.org
Cc:     Michael Schindler <michael@compressconsult.com>,
        Michael Schindler <michael@compressconsult.com>
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

From: Michael Schindler <michael@compressconsult.com>

newer versions of kdiff3 for windows install the executable for windows
in a /bin subfolder.
This change changes the place where the executable is searched to the new
location if not found in %PATH%

fetch a recent windows version from https://download.kde.org/stable/kdiff3/
to see.

Signed-off-by: Michael Schindler <michael.schindler@allianz.at>
---
    Update kdiff3
    
    newer versions of kdiff3 for windows install the executable for windows
    in a bin subfolder. This change changes the place where the executable
    is searched to the new location if not found in %PATH%
    
    fetch a recent windows version from
    https://download.kde.org/stable/kdiff3/ to see.

Published-As: https://github.com/gitgitgadget/git/releases/tag/pr-1376%2Fmichaelcompressconsult%2Fkdiff3_win_moved-v1
Fetch-It-Via: git fetch https://github.com/gitgitgadget/git pr-1376/michaelcompressconsult/kdiff3_win_moved-v1
Pull-Request: https://github.com/gitgitgadget/git/pull/1376

 mergetools/kdiff3 | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/mergetools/kdiff3 b/mergetools/kdiff3
index ee8b3a0570e..c26a9573815 100644
--- a/mergetools/kdiff3
+++ b/mergetools/kdiff3
@@ -39,6 +39,6 @@ translate_merge_tool_path() {
 	then
 		echo kdiff3
 	else
-		mergetool_find_win32_cmd "kdiff3.exe" "Kdiff3"
+		mergetool_find_win32_cmd "kdiff3.exe" "Kdiff3/bin"
 	fi
 }

base-commit: 3dcec76d9df911ed8321007b1d197c1a206dc164
-- 
gitgitgadget
