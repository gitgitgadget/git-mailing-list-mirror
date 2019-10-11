Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.2 (2018-09-13) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-4.0 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,RCVD_IN_DNSWL_HI,
	SPF_HELO_NONE,SPF_NONE shortcircuit=no autolearn=ham
	autolearn_force=no version=3.4.2
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 2C35B1F4C0
	for <e@80x24.org>; Fri, 11 Oct 2019 17:54:34 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728719AbfJKRyd (ORCPT <rfc822;e@80x24.org>);
        Fri, 11 Oct 2019 13:54:33 -0400
Received: from mail-wm1-f66.google.com ([209.85.128.66]:36230 "EHLO
        mail-wm1-f66.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1728714AbfJKRyc (ORCPT <rfc822;git@vger.kernel.org>);
        Fri, 11 Oct 2019 13:54:32 -0400
Received: by mail-wm1-f66.google.com with SMTP id m18so11036056wmc.1
        for <git@vger.kernel.org>; Fri, 11 Oct 2019 10:54:30 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=date:message-id:in-reply-to:references:from:subject:fcc
         :content-transfer-encoding:mime-version:to:cc;
        bh=PV1qrtu1vHrExJ+47fiIQ6+ePWu/oa/dR0ACXGKXfaU=;
        b=BQbBCSqS3o7drdXpcjALLFjg7oxo6mirpiqWAECTI817o0WjN84teqCxg5WHLjrJay
         +48+w5QXmXtMPVy3PWEpcn87pHOnJ+SohyVq3Ee1VeaU/4JE88WCufw+QbxF+0ooNvce
         SswM2Dln+e7VjNHl17DCelszd5bOKWpbCHH6A6kB4shaxDO6Wrtz11s5BzJeR0jPjmfe
         54DCTEqfmbhjLR5KeU3Lpog//3bk3XWdKKNx93HvPnHEpZ6eouy4bGTy64e01gElnia1
         29hO0Fm9YSwh2RONGC1/imVRIaqWbEF25wRb+9PDqJx4hP1SDLR374JJPxYofQHXAOP9
         s0qw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:message-id:in-reply-to:references:from
         :subject:fcc:content-transfer-encoding:mime-version:to:cc;
        bh=PV1qrtu1vHrExJ+47fiIQ6+ePWu/oa/dR0ACXGKXfaU=;
        b=qBV/Z+NFvq1VK3TFiHGh96z1Jsn3T6CwM77So/YJIe4twpuz3dKo1FEjOo/IZoqIVh
         hSCFVTVF9FgAJMA8BXdN8O5CzHszeyL7iPDXAZFfat34AzqUGqMS1BJmOFDD0uleGi2E
         D2jQC64RjzGoRFFvWjCt/J/cpC5y1zyvSr8oH+G9Fax5S3HkRK8ItVR7EJz8m9sQAW9h
         nJQeH88ZLLXwOvZ6KQh3gljyNdV08H2jquI+5aVD9QcvPUGh3ypoeEokpfAQt3FXivId
         n5fS2R6A0Y+o8tgj10WNyCH2ymx9bAQSGLsMgxs9IV4W12IadiXRAKTPkn93kP6cJLEc
         NMHA==
X-Gm-Message-State: APjAAAWUJBH24aUyO3z9lkTJGu9ZUXxemZMzr7RevRDSLgCD1R8E/j8A
        fW1gL1Y5nyqI/Cm7Oh/C8BCQIPQV
X-Google-Smtp-Source: APXvYqyvxnxl4hw1hGojJue8i7oSlLB2lzfdR5UMXY5wLQYM3L4ls+0blGUxpKwnBnHzetRjbwKQDg==
X-Received: by 2002:a05:600c:305:: with SMTP id q5mr4110993wmd.67.1570816469332;
        Fri, 11 Oct 2019 10:54:29 -0700 (PDT)
Received: from [127.0.0.1] ([13.74.141.28])
        by smtp.gmail.com with ESMTPSA id o70sm12996538wme.29.2019.10.11.10.54.28
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Fri, 11 Oct 2019 10:54:28 -0700 (PDT)
Date:   Fri, 11 Oct 2019 10:54:28 -0700 (PDT)
X-Google-Original-Date: Fri, 11 Oct 2019 17:54:27 GMT
Message-Id: <3f994f3b9a49c42bb8b605459817e54479327dc7.1570816467.git.gitgitgadget@gmail.com>
In-Reply-To: <pull.367.v2.git.gitgitgadget@gmail.com>
References: <pull.367.git.gitgitgadget@gmail.com>
        <pull.367.v2.git.gitgitgadget@gmail.com>
From:   "Maxim Belsky via GitGitGadget" <gitgitgadget@gmail.com>
Subject: [PATCH v2 1/1] doc: Change zsh git completion file name
Fcc:    Sent
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
MIME-Version: 1.0
To:     git@vger.kernel.org
Cc:     Max Belsky <public.belsky@gmail.com>,
        Junio C Hamano <gitster@pobox.com>,
        Maxim Belsky <public.belsky@gmail.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

From: Maxim Belsky <public.belsky@gmail.com>

The original comment does not describe type of ~/.zsh/_git explicitly
and zsh does not warn or fail if a user create it as a dictionary.
So unexperienced users could be misled by the original comment.

There is a small update to clarify it.

Signed-off-by: Maxim Belsky <public.belsky@gmail.com>
Helped-by: Johannes Schindelin <Johannes.Schindelin@gmx.de>
Helped-by: Junio C Hamano <gitster@pobox.com>
---
 contrib/completion/git-completion.zsh | 5 +++--
 1 file changed, 3 insertions(+), 2 deletions(-)

diff --git a/contrib/completion/git-completion.zsh b/contrib/completion/git-completion.zsh
index 886bf95d1f..eef4eff53d 100644
--- a/contrib/completion/git-completion.zsh
+++ b/contrib/completion/git-completion.zsh
@@ -11,8 +11,9 @@
 #
 #  zstyle ':completion:*:*:git:*' script ~/.git-completion.zsh
 #
-# The recommended way to install this script is to copy to '~/.zsh/_git', and
-# then add the following to your ~/.zshrc file:
+# The recommended way to install this script is to make a copy of it in
+# ~/.zsh/ directory as ~/.zsh/git-completion.zsh and then add the following
+# to your ~/.zshrc file:
 #
 #  fpath=(~/.zsh $fpath)
 
-- 
gitgitgadget
