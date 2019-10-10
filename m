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
	by dcvr.yhbt.net (Postfix) with ESMTP id 08BAE1F4BD
	for <e@80x24.org>; Thu, 10 Oct 2019 16:56:57 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726290AbfJJQ44 (ORCPT <rfc822;e@80x24.org>);
        Thu, 10 Oct 2019 12:56:56 -0400
Received: from mail-wm1-f67.google.com ([209.85.128.67]:40456 "EHLO
        mail-wm1-f67.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726038AbfJJQ44 (ORCPT <rfc822;git@vger.kernel.org>);
        Thu, 10 Oct 2019 12:56:56 -0400
Received: by mail-wm1-f67.google.com with SMTP id b24so7530303wmj.5
        for <git@vger.kernel.org>; Thu, 10 Oct 2019 09:56:54 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=date:message-id:in-reply-to:references:from:subject:fcc
         :content-transfer-encoding:mime-version:to:cc;
        bh=KgPwuFJnqYtIb+qYqOMbG0M0kszYy3D1t/Qm+NDMXTc=;
        b=CPYi+w3+SO5YLpWZ464WWLaxghp1mM6iuU02iGM9Ar+596HC7v0QK4FdQt1/AyTugu
         kS5bxUPJhaBGKuZEpFD2H9j2G2YV4umuccC1VREsLCe0jF4Jj6j++cNBJdoyfGb/GmfM
         8WubAk+ekRtcd2v084UARE+MDStZyb/StD+wnOQsPO99nI/F/9HlHsRejvPTvvEHiyEo
         O96RMGZ3wpxrFEI8YsSi1Rb39WPOfqWn/d7moZPHzlhbB5g3ev7iqY6mneYTV+KA5Aw3
         V4bwsVdrKTNCNlYwYN8Ifw7CboZtfLRkHA0lxiHC9giaqvl0iNw+gPP3GdRKEk8sCSeS
         6JZQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:message-id:in-reply-to:references:from
         :subject:fcc:content-transfer-encoding:mime-version:to:cc;
        bh=KgPwuFJnqYtIb+qYqOMbG0M0kszYy3D1t/Qm+NDMXTc=;
        b=XKdjva3iEW/YxCgujzuRIVa7HgjYAU1L04TV62U0KSHrOM3vBLtjOmnvEgu4k6Hn/y
         ogqZ9Dyk7dG+9qjT3Vhz/NDnQX6adijiZWl5fXUf+NEjmZ0l+qrmB03VciWbSnVtWho3
         G5hThrucN68X2BeOiEGS9rjWU76lCwS6eO4U01vyAaiconqKLRwPz8ezOXcgN2/UeARb
         ZVt7xJuGz29+GVjAXJNT7dc+pi2t90/tXRARh8tnzHk/yV/GtllOBgr+vgdgXjF37hvF
         dluJAzIV1YBPkNHxnSxdIQ1Vb/p1DVWFWPAUdntREL7twEUATuPRhQUFAYlgv92Ae6Sn
         i8Kg==
X-Gm-Message-State: APjAAAWX70XCJMPT1CjJCMl74o+bkJNAGgRb0X49dSLn8EQe5nNI8y25
        3ASvhhMfdYNr3FpxVJLhU1GTEuyU
X-Google-Smtp-Source: APXvYqwTOy7iP96GuvYP/0IbjvLK33IQHS3fYQlG8olb2CM5rgDW470WqjoyJIh4ZqUId4EGePHVBQ==
X-Received: by 2002:a05:600c:2293:: with SMTP id 19mr8898004wmf.26.1570726613894;
        Thu, 10 Oct 2019 09:56:53 -0700 (PDT)
Received: from [127.0.0.1] ([13.74.141.28])
        by smtp.gmail.com with ESMTPSA id r7sm5250968wrt.28.2019.10.10.09.56.53
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Thu, 10 Oct 2019 09:56:53 -0700 (PDT)
Date:   Thu, 10 Oct 2019 09:56:53 -0700 (PDT)
X-Google-Original-Date: Thu, 10 Oct 2019 16:56:51 GMT
Message-Id: <ae00e1e3932b3364da68fa66e2ec5fbcce124bdc.1570726611.git.gitgitgadget@gmail.com>
In-Reply-To: <pull.367.git.gitgitgadget@gmail.com>
References: <pull.367.git.gitgitgadget@gmail.com>
From:   "Maxim Belsky via GitGitGadget" <gitgitgadget@gmail.com>
Subject: [PATCH 1/1] doc: Change zsh git completion file name
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

Signed-off-by: Maxim Belsky <public.belsky@gmail.com>
---
 contrib/completion/git-completion.zsh | 5 +++--
 1 file changed, 3 insertions(+), 2 deletions(-)

diff --git a/contrib/completion/git-completion.zsh b/contrib/completion/git-completion.zsh
index 886bf95d1f..c0eca3ff25 100644
--- a/contrib/completion/git-completion.zsh
+++ b/contrib/completion/git-completion.zsh
@@ -11,8 +11,9 @@
 #
 #  zstyle ':completion:*:*:git:*' script ~/.git-completion.zsh
 #
-# The recommended way to install this script is to copy to '~/.zsh/_git', and
-# then add the following to your ~/.zshrc file:
+# The recommended way to install this script is to copy to
+# '~/.zsh/.git-completion.zsh', and then add the following to your ~/.zshrc
+# file:
 #
 #  fpath=(~/.zsh $fpath)
 
-- 
gitgitgadget
