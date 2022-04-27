Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 4253DC433EF
	for <git@archiver.kernel.org>; Wed, 27 Apr 2022 19:12:45 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232918AbiD0TPy (ORCPT <rfc822;git@archiver.kernel.org>);
        Wed, 27 Apr 2022 15:15:54 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:35172 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S234198AbiD0TOM (ORCPT <rfc822;git@vger.kernel.org>);
        Wed, 27 Apr 2022 15:14:12 -0400
Received: from mail-wr1-x42d.google.com (mail-wr1-x42d.google.com [IPv6:2a00:1450:4864:20::42d])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id CE10C90CE8
        for <git@vger.kernel.org>; Wed, 27 Apr 2022 12:04:56 -0700 (PDT)
Received: by mail-wr1-x42d.google.com with SMTP id q23so3810243wra.1
        for <git@vger.kernel.org>; Wed, 27 Apr 2022 12:04:56 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=message-id:in-reply-to:references:from:date:subject:fcc
         :content-transfer-encoding:mime-version:to:cc;
        bh=Z4W7EAoVPs/ZMACArphfVx1fvyrbGn1Y9FuVBcQgB6M=;
        b=K163+bZtq15VXeGlSbkYfd8QWRrKaWmeQFjgEZvibwig83RT+Q0nVWWmGwUCzWxqe+
         bi6bTaCQFFQjV9swhEyMT95wjurjjZfnEsl7mEi+IsE24sPkujxV0CUf+O01Xdv71B8x
         /tZONIYFaGTJsbvUAxSIOwh/aleDQGd1LzRiGNrlK4HSKQYFHwziQkoLZUn8RBeGuYCH
         MjHU6Zya5NXUYH8mwhY/PkC17exZq9C2lgiAVIgYOxPUPIgLgA7Q5zpzOKp5kX2et8mP
         2ngSHF+CyAZnKlTDEojAOa7bZbdXkI1VVM/mJFtuBP6RY89B7hjeapItl9+0jbzJ9BkU
         aPGQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:message-id:in-reply-to:references:from:date
         :subject:fcc:content-transfer-encoding:mime-version:to:cc;
        bh=Z4W7EAoVPs/ZMACArphfVx1fvyrbGn1Y9FuVBcQgB6M=;
        b=PZBIHfUtoUFTpSPBk2o8+j9lDySKswS2kcXnHZWauiVtl2ngrlFBgOiPItBydLlt3T
         uRXu4N7LIT/1hgaOdtsbhmSxwuAXe6Qiv6vl9lwB3tsWh/Pi6wKntYfQ+0Ka6Csb+kSM
         MA5vMjIXktM49rCGrqJd3NhxmvRck+hPfkqwdkeU49t9lb6KhKfGLlKF5ufimJN1woiH
         N7ocGbF+7rz5FO7q7j2tc4xVkgRASbI0jh34oeo0IjUG3qsnc0t1PfvBnOr0RiDBvBkJ
         IQzUkctwgN/YxFM7QvEsYRJ86aTXH+bfZt9cvHYWCfsnlNQ4C3ihRexL+oaahxMYM808
         RYxA==
X-Gm-Message-State: AOAM533dTvO0fIVgRQlb9BOHtbvalbWfK4KFU1WqLRsQepmWd/zbE54Q
        +6RTLO3E3mHUTHinIbJ3OdU9KgUHDi0=
X-Google-Smtp-Source: ABdhPJz2jOt/tCWeoWyl4mknkDBMGOUA3bGWXOCNMTMYO5np9VNKxxuHbwu7THvZNU8LFQHmFGToNg==
X-Received: by 2002:adf:ded0:0:b0:20a:f070:6bb0 with SMTP id i16-20020adfded0000000b0020af0706bb0mr3549150wrn.208.1651086295144;
        Wed, 27 Apr 2022 12:04:55 -0700 (PDT)
Received: from [127.0.0.1] ([13.74.141.28])
        by smtp.gmail.com with ESMTPSA id m1-20020a1ca301000000b003929c4bf250sm2216041wme.13.2022.04.27.12.04.54
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 27 Apr 2022 12:04:54 -0700 (PDT)
Message-Id: <2f6ecbf260135efc2a7ad09564cf6c64ed6d6f0d.1651086288.git.gitgitgadget@gmail.com>
In-Reply-To: <pull.1226.git.1651086288.gitgitgadget@gmail.com>
References: <pull.1226.git.1651086288.gitgitgadget@gmail.com>
From:   "Philippe Blain via GitGitGadget" <gitgitgadget@gmail.com>
Date:   Wed, 27 Apr 2022 19:04:48 +0000
Subject: [PATCH 3/3] MyFirstContribution: drop PR description for GGG
 single-patch contributions
Fcc:    Sent
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
MIME-Version: 1.0
To:     git@vger.kernel.org
Cc:     Emily Shaffer <emilyshaffer@google.com>,
        Johannes Schindelin <Johannes.Schindelin@gmx.de>,
        Philippe Blain <levraiphilippeblain@gmail.com>,
        Philippe Blain <levraiphilippeblain@gmail.com>
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

From: Philippe Blain <levraiphilippeblain@gmail.com>

By default, GitHub prefills the PR description using the commit message
for single-commit PRs. This results in a duplicate commit message below
the three-dash line if the contributor does not empty out the PR
description before submitting, which adds noise for reviewers.

Add a note to that effect in MyFirstContribution.txt.

This partly addresses:
https://github.com/gitgitgadget/gitgitgadget/issues/340

Signed-off-by: Philippe Blain <levraiphilippeblain@gmail.com>
---
 Documentation/MyFirstContribution.txt | 8 ++++++++
 1 file changed, 8 insertions(+)

diff --git a/Documentation/MyFirstContribution.txt b/Documentation/MyFirstContribution.txt
index 96da32f7cef..2ce51d8c82e 100644
--- a/Documentation/MyFirstContribution.txt
+++ b/Documentation/MyFirstContribution.txt
@@ -821,6 +821,14 @@ Adding the 'psuh' command
 Your PR's description will used as the body of the cover letter.
 include::MyFirstContribution-coverletter.txt[]
 
+NOTE: For single-patch contributions, your commit message should already be
+meaningful and explain at a high level the purpose (what is happening and why)
+of your patch, so you usually do not need any additional context. In that case,
+remove the PR description that GitHub automatically generates from your commit
+message (your PR description should be empty). If you do need to supply even
+more context, you can do so in that space and it will be appended to the email
+that GitGitGadget will send, separately from your commit message.
+
 When you're happy, submit your pull request.
 
 [[run-ci-ggg]]
-- 
gitgitgadget
