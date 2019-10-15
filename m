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
	by dcvr.yhbt.net (Postfix) with ESMTP id 884AD1F4C0
	for <e@80x24.org>; Tue, 15 Oct 2019 18:48:20 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728915AbfJOSsS (ORCPT <rfc822;e@80x24.org>);
        Tue, 15 Oct 2019 14:48:18 -0400
Received: from mail-wm1-f67.google.com ([209.85.128.67]:52482 "EHLO
        mail-wm1-f67.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726144AbfJOSsS (ORCPT <rfc822;git@vger.kernel.org>);
        Tue, 15 Oct 2019 14:48:18 -0400
Received: by mail-wm1-f67.google.com with SMTP id r19so186871wmh.2
        for <git@vger.kernel.org>; Tue, 15 Oct 2019 11:48:17 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=message-id:in-reply-to:references:from:date:subject:mime-version
         :content-transfer-encoding:fcc:to:cc;
        bh=88gHHwmjWhDrBsBBSNyMtJ1JMTDZP99ITHJrxQFUvQQ=;
        b=YMLiNmGlG+SilCG/k+VFjHdd2fXA/UpfgzlXqkn2eir2CBsWwZHLWus3M2P4fvyx8f
         dUn9rF0r4w7P0ckDIZ0xppaqg1ZIyouOSEIt9+0m0b/twBRuL0jPrHErj7H0svMrEy79
         XsUFVxaJUEtCMLH6eatyjyNiFp7lEdE+GxPO8cf1GnvPJiDCin+ZzJcSplRIbMhZeNLu
         QgzQ2K0LXZ6ghdo3atCIALZMgMflgfOwAO+3cddB5QqZ8QIKFMwF291rnhp8vLOUHdRH
         FxOUhPo+5VzQ53OM7S9km41Ss84NoMn033vgA6svfygaWlG6AKGsdpXuWNwQ78Owju8n
         3UZA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:message-id:in-reply-to:references:from:date
         :subject:mime-version:content-transfer-encoding:fcc:to:cc;
        bh=88gHHwmjWhDrBsBBSNyMtJ1JMTDZP99ITHJrxQFUvQQ=;
        b=J5ijk5ITe79Bq7iFFb6QViqGvfbQ0iCwql3xQYyjffoiPjYwwqlHaQmudb/BbSlddx
         Dznk/RizmRlbZWHgXMydgGBPeMMi/tT7zNEEOKTUtBV9HU1DG68dlBOAk7C3Qd90/SgB
         JhsIxbgc78weWoT+2fZkgMF8CD/+JGCT6sgm43Yi2EMkh5hwUadWL39xKO4IGRb2iRnY
         RrXF/0LIrvAZemqnixX5br2wTMmQXFYjVMCRu+qWjf9H7Wl8UPgS4JiaEBD2uRsuJA9k
         6GXTY6dYLdzXvylehlDn7CGYHwRWpXA4oOHLQ4KJbhdGFWBRqvNCerhgUcVmfrHCxaqI
         oiMQ==
X-Gm-Message-State: APjAAAUp9GutkUzNcv2C53sd6l8SducGU36t0pDO2gBp7StCzQvKqnwK
        NaBTtcF6KWndTwOhvgp4qb5yOKmM
X-Google-Smtp-Source: APXvYqwW2lke4BKWzSCSsTVWxJx+NV8QLKeUhsc40mEW1/5qEZ4yX3HcC+OtgW8++nT2n4FPNd2O4w==
X-Received: by 2002:a7b:cf05:: with SMTP id l5mr19964406wmg.119.1571165296296;
        Tue, 15 Oct 2019 11:48:16 -0700 (PDT)
Received: from [127.0.0.1] ([13.74.141.28])
        by smtp.gmail.com with ESMTPSA id w5sm21293015wrs.34.2019.10.15.11.48.15
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Tue, 15 Oct 2019 11:48:15 -0700 (PDT)
Message-Id: <7919addea85597c3c910a09cbc1d931c6f71c544.1571165293.git.gitgitgadget@gmail.com>
In-Reply-To: <pull.367.v3.git.1571165293.gitgitgadget@gmail.com>
References: <pull.367.v2.git.gitgitgadget@gmail.com>
        <pull.367.v3.git.1571165293.gitgitgadget@gmail.com>
From:   "Maxim Belsky via GitGitGadget" <gitgitgadget@gmail.com>
Date:   Tue, 15 Oct 2019 18:48:13 +0000
Subject: [PATCH v3 1/1] doc: Change zsh git completion file name
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Fcc:    Sent
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

Helped-by: Johannes Schindelin <Johannes.Schindelin@gmx.de>
Helped-by: Junio C Hamano <gitster@pobox.com>
Helped-by: SZEDER Gábor <szeder.dev@gmail.com>
Signed-off-by: Maxim Belsky <public.belsky@gmail.com>
---
 contrib/completion/git-completion.zsh | 5 +++--
 1 file changed, 3 insertions(+), 2 deletions(-)

diff --git a/contrib/completion/git-completion.zsh b/contrib/completion/git-completion.zsh
index 886bf95d1f..b480e3f316 100644
--- a/contrib/completion/git-completion.zsh
+++ b/contrib/completion/git-completion.zsh
@@ -11,8 +11,9 @@
 #
 #  zstyle ':completion:*:*:git:*' script ~/.git-completion.zsh
 #
-# The recommended way to install this script is to copy to '~/.zsh/_git', and
-# then add the following to your ~/.zshrc file:
+# The recommended way to install this script is to make a copy of it in
+# '~/.zsh/' directory as '~/.zsh/_git' and then add the following to your
+# ~/.zshrc file:
 #
 #  fpath=(~/.zsh $fpath)
 
-- 
gitgitgadget
