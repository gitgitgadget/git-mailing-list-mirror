Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id EDB01C433EF
	for <git@archiver.kernel.org>; Tue,  4 Jan 2022 23:17:08 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S236267AbiADXRI (ORCPT <rfc822;git@archiver.kernel.org>);
        Tue, 4 Jan 2022 18:17:08 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:35118 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S236274AbiADXRH (ORCPT <rfc822;git@vger.kernel.org>);
        Tue, 4 Jan 2022 18:17:07 -0500
Received: from mail-wm1-x336.google.com (mail-wm1-x336.google.com [IPv6:2a00:1450:4864:20::336])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 6828EC061784
        for <git@vger.kernel.org>; Tue,  4 Jan 2022 15:17:07 -0800 (PST)
Received: by mail-wm1-x336.google.com with SMTP id v10-20020a05600c214a00b00345e59928eeso680714wml.0
        for <git@vger.kernel.org>; Tue, 04 Jan 2022 15:17:07 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=message-id:from:date:subject:fcc:content-transfer-encoding
         :mime-version:to:cc;
        bh=ITURD0AkeT2WHOKsyqO0hm2qNib55C9Xxc3gjQbX9Hc=;
        b=ZJgbQeBu3k4ex9dL3avoXW4ugc/e/RcNzq6XRKxi/Y40GhIXCj0nPLlKuhu743KN4l
         uMManqTGFm9r1giStl4rG3cnri3o7mjIm+nMuRukDAIAtpQpUBAdaHuJ33eeFjVtE69C
         SsF2b/zOtXN75OVXEicUy6XXA6oOlMPY8ttT78n1CO2FCvzKdZTZunlnzrYEyIFwO2iN
         Cdnf3weyaRfijU+8LvnUGPVz9fBd+5kJ6rkBvDakRoP37gALAgmrlBsrArHJLWeX/vrj
         rk0Al2CkQtMMVfyY+A7ioRO9/zfx1RgmZlyuKEwitZXsqAowl60jScaRaFRHyIcG6WGn
         fWVg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:message-id:from:date:subject:fcc
         :content-transfer-encoding:mime-version:to:cc;
        bh=ITURD0AkeT2WHOKsyqO0hm2qNib55C9Xxc3gjQbX9Hc=;
        b=Lpkeg0lXVq4b6pULhGbtPCKOT9Qgbj34bXKbxV6zyGpTnVE35p9El4Fc+GoUcVd7DZ
         /PA6A6RI/hJPFZW9I9eNFCdL5bpGR9M6f9quvzrZOT8BOXDfq7HPR3b0ZM6IaDsVa+C/
         s66vd+Jj6PD07jbWGe7idxelYmG2WuH/sCI/+NNRVo+pXl5EMp1UQLt3ths0o/bw7QkT
         4L8O7bAl2RMqvV0fjSTWkCxZ8MRi98lOdIZucp1T/zYhJ9/qp+ufRiH8Z3Th+XMYdfQO
         dBF9hVeU5qvX1y8knWhtXk8gL4phHV6mB8AuzXM40/fz1RhQMEpQ2mrSbV+KUoP0/l5h
         XPug==
X-Gm-Message-State: AOAM5319VYVumHJ3BRevnTKUHvGAcYHkUf7ctNY5FWUO+rzjlOCERWYw
        oH7HAkPVoxfpe4LRmyBzp3G6MYmazrI=
X-Google-Smtp-Source: ABdhPJxl9MzeRS8mcpXwweYOIErUug1w209DgRGMXN+Z2z6akvqLHkThIta8tLbRFoXIeSg+dAhFJQ==
X-Received: by 2002:a1c:2093:: with SMTP id g141mr468310wmg.146.1641338225767;
        Tue, 04 Jan 2022 15:17:05 -0800 (PST)
Received: from [127.0.0.1] ([13.74.141.28])
        by smtp.gmail.com with ESMTPSA id s22sm817420wmc.1.2022.01.04.15.17.05
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 04 Jan 2022 15:17:05 -0800 (PST)
Message-Id: <pull.1110.git.1641338224631.gitgitgadget@gmail.com>
From:   "Marc Strapetz via GitGitGadget" <gitgitgadget@gmail.com>
Date:   Tue, 04 Jan 2022 23:17:04 +0000
Subject: [PATCH] t/README: fix typo
Fcc:    Sent
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
MIME-Version: 1.0
To:     git@vger.kernel.org
Cc:     Marc Strapetz <marc.strapetz@syntevo.com>,
        Marc Strapetz <marc.strapetz@syntevo.com>
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

From: Marc Strapetz <marc.strapetz@syntevo.com>

Signed-off-by: Marc Strapetz <marc.strapetz@syntevo.com>
---
    t/README: fix typo

Published-As: https://github.com/gitgitgadget/git/releases/tag/pr-1110%2Fmstrap%2Ffeature%2FREADME-typo-v1
Fetch-It-Via: git fetch https://github.com/gitgitgadget/git pr-1110/mstrap/feature/README-typo-v1
Pull-Request: https://github.com/gitgitgadget/git/pull/1110

 t/README | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/t/README b/t/README
index 2353a4c5e13..f48e0542cdc 100644
--- a/t/README
+++ b/t/README
@@ -466,7 +466,7 @@ explicitly providing repositories when accessing submodule objects is
 complete or needs to be abandoned for whatever reason (in which case the
 migrated codepaths still retain their performance benefits).
 
-GIT_TEST_REQUIRE_PREREQ=<list> allows specifying a space speparated list of
+GIT_TEST_REQUIRE_PREREQ=<list> allows specifying a space separated list of
 prereqs that are required to succeed. If a prereq in this list is triggered by
 a test and then fails then the whole test run will abort. This can help to make
 sure the expected tests are executed and not silently skipped when their

base-commit: dcc0cd074f0c639a0df20461a301af6d45bd582e
-- 
gitgitgadget
