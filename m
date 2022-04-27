Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id D0AFBC433F5
	for <git@archiver.kernel.org>; Wed, 27 Apr 2022 19:13:02 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233105AbiD0TQL (ORCPT <rfc822;git@archiver.kernel.org>);
        Wed, 27 Apr 2022 15:16:11 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:33910 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S234040AbiD0TOK (ORCPT <rfc822;git@vger.kernel.org>);
        Wed, 27 Apr 2022 15:14:10 -0400
Received: from mail-wr1-x42b.google.com (mail-wr1-x42b.google.com [IPv6:2a00:1450:4864:20::42b])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id EEE618F19E
        for <git@vger.kernel.org>; Wed, 27 Apr 2022 12:04:52 -0700 (PDT)
Received: by mail-wr1-x42b.google.com with SMTP id u3so3799030wrg.3
        for <git@vger.kernel.org>; Wed, 27 Apr 2022 12:04:52 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=message-id:from:date:subject:fcc:content-transfer-encoding
         :mime-version:to:cc;
        bh=Bm790JkeeQyHg83gXVYERiH7duFeN1h1xrOxJmhGpVw=;
        b=ScnaZyP2o0l2j1yXEcxSWviR/US+c7B9YLe74YNmBXh1GrV/0DD/XVKE1hMHJR+icV
         Q32SUA8OiZD0a1+miY0BKZZJbERgnHCOkC+kvMBC04wCT92OSYRHb2p8pbs5K12T7MnV
         V8L16mF/DHYsfPOzrTKvhbJ8HDdKMWrFZiyz+WUATwjMDAhjoa+odSFx0D+31rWjnDAd
         x/dcC/Z29umoGSDytdjnSI8tT6R1eoGLdYwXz9T4KFjn4m/iLhLpNQC4H6Tqu0J8y9Bl
         sY/ttla0rFKO9D6Jq61LTuw1Erv8Br4fzk5/1/wB1C65J7n0ZpsP2hlX5tHCVJkORDGI
         L2aw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:message-id:from:date:subject:fcc
         :content-transfer-encoding:mime-version:to:cc;
        bh=Bm790JkeeQyHg83gXVYERiH7duFeN1h1xrOxJmhGpVw=;
        b=cy0OlFL4bpTcF5Nw46d1lSz+JJzzvBJKhK+H6aHEpYIu8x0r2ITbxkV4IgcafV+D/d
         8uJkelVAK9tvOC1b5GwgxyObU28rj98CPH1WnImKTw1ghSOorgDpa4QUFi5KbE+bi7lm
         NTd6oxWvbsG/bnrzu6D/16Wmv7irg7G2+EKYJKgc6EJLjkhWeA2vOAl0K66r1Dz2MORD
         j0MMMK2NqhWcbJFuhDSatQdXYhoIABIwHIxQdkXFtn4ARuBJnqHACBGf50N40yVOp0Hd
         rrwScT7MO261SAOxTcYUKWIxMm3UH1v4BGyPkI38MyrdIsYVM0LcGRWAw+LF2xmuHsrw
         tWmQ==
X-Gm-Message-State: AOAM532t0a5h9kiN44yknmSRtp2AXezrevvq96odm1a+vRm3N5dlSEMh
        a1dJdbnRBB3sAAiTcAt++3BeG92YmrQ=
X-Google-Smtp-Source: ABdhPJy5wnhTtKzJbCFH0+XJ/jQnIImKxPgIBVVxtSswv9l34S/oG2jB3HkaZFSPbPx8wxWzTJOqmw==
X-Received: by 2002:a05:6000:1545:b0:20a:f3d3:65ed with SMTP id 5-20020a056000154500b0020af3d365edmr1308540wry.327.1651086291094;
        Wed, 27 Apr 2022 12:04:51 -0700 (PDT)
Received: from [127.0.0.1] ([13.74.141.28])
        by smtp.gmail.com with ESMTPSA id v188-20020a1cacc5000000b0038e9c60f0e7sm2194499wme.28.2022.04.27.12.04.49
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 27 Apr 2022 12:04:49 -0700 (PDT)
Message-Id: <pull.1226.git.1651086288.gitgitgadget@gmail.com>
From:   "Philippe Blain via GitGitGadget" <gitgitgadget@gmail.com>
Date:   Wed, 27 Apr 2022 19:04:45 +0000
Subject: [PATCH 0/3] Improve MyFirstContribution's GitGitGadget section
Fcc:    Sent
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
MIME-Version: 1.0
To:     git@vger.kernel.org
Cc:     Emily Shaffer <emilyshaffer@google.com>,
        Johannes Schindelin <Johannes.Schindelin@gmx.de>,
        Philippe Blain <levraiphilippeblain@gmail.com>
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Two small improvements to the MyFirstContribution tutorial:

 * Describe the purpose of the cover letter in that section also, and give
   an example just as in the 'git send-email' section
 * Instruct contributors to drop the GitHub-generated PR description for
   single patch contributions.

Philippe Blain (3):
  MyFirstContribution: move cover letter description to a separate file
  MyFirstContribution: also explain cover letter in GitGitGadget section
  MyFirstContribution: drop PR description for GGG single-patch
    contributions

 .../MyFirstContribution-coverletter.txt       | 18 ++++++++
 Documentation/MyFirstContribution.txt         | 45 ++++++++++---------
 2 files changed, 42 insertions(+), 21 deletions(-)
 create mode 100644 Documentation/MyFirstContribution-coverletter.txt


base-commit: 6cd33dceed60949e2dbc32e3f0f5e67c4c882e1e
Published-As: https://github.com/gitgitgadget/git/releases/tag/pr-1226%2Fphil-blain%2Fmyfirst-contrib-single-patch-ggg-v1
Fetch-It-Via: git fetch https://github.com/gitgitgadget/git pr-1226/phil-blain/myfirst-contrib-single-patch-ggg-v1
Pull-Request: https://github.com/gitgitgadget/git/pull/1226
-- 
gitgitgadget
