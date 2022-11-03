Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 03F2FC4332F
	for <git@archiver.kernel.org>; Thu,  3 Nov 2022 10:26:41 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231295AbiKCK0j (ORCPT <rfc822;git@archiver.kernel.org>);
        Thu, 3 Nov 2022 06:26:39 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:49666 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229539AbiKCK0i (ORCPT <rfc822;git@vger.kernel.org>);
        Thu, 3 Nov 2022 06:26:38 -0400
Received: from mail-wm1-x332.google.com (mail-wm1-x332.google.com [IPv6:2a00:1450:4864:20::332])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 261F61056A
        for <git@vger.kernel.org>; Thu,  3 Nov 2022 03:26:37 -0700 (PDT)
Received: by mail-wm1-x332.google.com with SMTP id 5so834676wmo.1
        for <git@vger.kernel.org>; Thu, 03 Nov 2022 03:26:37 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=cc:to:mime-version:content-transfer-encoding:fcc:subject:date:from
         :message-id:from:to:cc:subject:date:message-id:reply-to;
        bh=u/jTM2UvuMr4mPwriit2v01W7yIY+2YW2AhaUtHq3so=;
        b=BspbJFr1R//kEYtRgcF0cVrFa1+3jZeg71sncwHudzyNbZtvzYn1rH/ijizt45TRpF
         95oL4PQwycPdFYdIG3tZU5l64de0SZcJkhLx8MA/21ZL5eGgedtrl2flA87ztK9+J7vB
         PpFCiqZlEuswLpuPcNN5a6U9FVMM5sxBmiYSz7sfBTZtPNxobCzwAhkWUB2vLrsIoRRs
         Q/TLDUAs6Bcl+NstZldub451mZctGlxy0S7MIJNwCGhHgFPsHAz6U6JftvSYCZRmcFwB
         Y/70UGie9zKsWqkB9ABYHIfJEBXA5N4Tx7oh+7SmHo0OWhUJR6mqhQHwRekriWvCVzXU
         j1Dg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=cc:to:mime-version:content-transfer-encoding:fcc:subject:date:from
         :message-id:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=u/jTM2UvuMr4mPwriit2v01W7yIY+2YW2AhaUtHq3so=;
        b=WQ3dNUAwsAoQEe5/AcQOhn7wjP01N06gLvAO//SstN+0EUfgp9KHGtpqxwCpEUStoh
         /bU55Iwuih2AFrRFq8iWs/YNvhDguj6HRIxbQ4bB2ieLGtdlQijVtIFcWEWXhmnOy12u
         lIpm0lAvLbMvOstjPNBB2SeMSWfbAKdF4UqUvDi5/cfRTMXM0hLTP9ydTW27xhcuKtKm
         75YniKavm1PrDx4fWZfzKiqTEUjwyk9MvZiLHY/b1/S6pvB7BjbnspuFdhFB4AL5l4Z2
         FsZkqvdImDoq3JJ2y4WY0LyBLHQduAvW5ZbUVWHlzBXapwAIk6SUIuikAH989le9UdF7
         A11g==
X-Gm-Message-State: ACrzQf0GQk9CpdUAnT2E/gKCaTiYpEAoAoquiomtMgnNlTVs4NOqui07
        oWtcfJ0NTd9itoA0vMET26CXMHKNuHc=
X-Google-Smtp-Source: AMsMyM6AWpoUS0Ce6MDZRzGdfFM38KgHCDaMiH4H4CaZFCNKPz2r19XGykySu4UugusLNEbT3TXdjw==
X-Received: by 2002:a1c:27c6:0:b0:3c2:e6df:c79b with SMTP id n189-20020a1c27c6000000b003c2e6dfc79bmr28264069wmn.14.1667471195334;
        Thu, 03 Nov 2022 03:26:35 -0700 (PDT)
Received: from [127.0.0.1] ([13.74.141.28])
        by smtp.gmail.com with ESMTPSA id z18-20020a5d44d2000000b002365254ea42sm538726wrr.1.2022.11.03.03.26.34
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 03 Nov 2022 03:26:34 -0700 (PDT)
Message-Id: <pull.1401.git.1667471194097.gitgitgadget@gmail.com>
From:   "James via GitGitGadget" <gitgitgadget@gmail.com>
Date:   Thu, 03 Nov 2022 10:26:33 +0000
Subject: [PATCH] documentation: update git-submodule documentation
Fcc:    Sent
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
MIME-Version: 1.0
To:     git@vger.kernel.org
Cc:     James <jdm12989@gmail.com>, James <jdm12989@gmail.com>
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

From: James <jdm12989@gmail.com>

Removes reference to custom code execution which is called out by
gitmodules as not allowed.

Signed-off-by: James <jdm12989@gmail.com>
---
    Update git-submodule.txt
    
    Remove info about custom commands being allowed in the submodule update
    command to align with the gitmodules docs which states "For security
    reasons, the !command form is not accepted here."

Published-As: https://github.com/gitgitgadget/git/releases/tag/pr-1401%2FEnochPrime%2Fsubmodule-docs-v1
Fetch-It-Via: git fetch https://github.com/gitgitgadget/git pr-1401/EnochPrime/submodule-docs-v1
Pull-Request: https://github.com/gitgitgadget/git/pull/1401

 Documentation/git-submodule.txt | 6 ------
 1 file changed, 6 deletions(-)

diff --git a/Documentation/git-submodule.txt b/Documentation/git-submodule.txt
index 4d3ab6b9f92..b40ac72f753 100644
--- a/Documentation/git-submodule.txt
+++ b/Documentation/git-submodule.txt
@@ -163,12 +163,6 @@ checked out in the submodule.
 The following 'update' procedures are only available via the
 `submodule.<name>.update` configuration variable:
 
-	custom command;; arbitrary shell command that takes a single
-	    argument (the sha1 of the commit recorded in the
-	    superproject) is executed. When `submodule.<name>.update`
-	    is set to '!command', the remainder after the exclamation mark
-	    is the custom command.
-
 	none;; the submodule is not updated.
 
 If the submodule is not yet initialized, and you just want to use the

base-commit: c03801e19cb8ab36e9c0d17ff3d5e0c3b0f24193
-- 
gitgitgadget
