Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-3.6 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_HI,RP_MATCHES_RCVD
	shortcircuit=no autolearn=ham autolearn_force=no version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id EC9172023D
	for <e@80x24.org>; Fri,  3 Mar 2017 11:58:14 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1751856AbdCCL6N (ORCPT <rfc822;e@80x24.org>);
        Fri, 3 Mar 2017 06:58:13 -0500
Received: from mail-pf0-f194.google.com ([209.85.192.194]:34642 "EHLO
        mail-pf0-f194.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1751427AbdCCL5t (ORCPT <rfc822;git@vger.kernel.org>);
        Fri, 3 Mar 2017 06:57:49 -0500
Received: by mail-pf0-f194.google.com with SMTP id x66so9718388pfb.1
        for <git@vger.kernel.org>; Fri, 03 Mar 2017 03:57:49 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=date:from:to:cc:subject:message-id:mime-version:content-disposition
         :user-agent;
        bh=Io+/DvYTpLSdKwBFK5xwdMtkkYC9wmSMpCywCEJFzgQ=;
        b=EuChaHTkcJk14dE/kgPkAg+EkzLv1U2IWpk3Zs9PHHJFpHUeWKINMc+HrceTCx8orB
         Cl/3+q0nYzyBsbzutakNJDJ6syZXLEb9OIX6f7Td+CvLtnktVJiU8Mve920GpcXzCoHJ
         MI+W/XOnmrSlU8mZro4RhA3mLykBKtJ4suUEaYARZkirRh9gu3RrfSgwD/fS6jIACQEQ
         OM03xIz4GtLRNH+eDyS2gBo0pjGGPnYO2zT+yhFL6RM5d4d1PeLoWFc4+1mOkx7pJeEi
         df2wsaVQDFmOZUmSmOqN8et84ldgAote2Y633MpVKoxfsLefjXb+aLXuQEV3Yd2Cf1Q5
         RyqA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:mime-version
         :content-disposition:user-agent;
        bh=Io+/DvYTpLSdKwBFK5xwdMtkkYC9wmSMpCywCEJFzgQ=;
        b=WE3dTfvPWtQdG5SH5Eg85UP6QzNen2awsSQN6b00Wi+19oo9ZxhRj37Wa/f60hm/Ay
         haOdYlh6b0EsVuL3NVbcAox30SNhV2PI7b3IcmbkPaJIh8eZVGZxj49BGWXb/72xzeKV
         /kIbUp3DPsuFFJXPHBTUR12TjVfPNRTyJwryIoRqjtujmuduQr59S1Zhl9hUH2tsGxxm
         Vo0nkyH+D55s/TkuwveEUfcoxlFaX1wvhhYlqd5NfmfhCusgGm+mE9eVltvrqFdNH5+m
         X6cK28Q76GKWELiGTWRmoMlIF3/QUYOc2nhA1F6vHTd0HaPg+wdxm3OkzI4zOhzp1zSL
         WzJA==
X-Gm-Message-State: AMke39nABNJ3JCRxFFT7Qv9K/o1svQdVseDxng8JH17CGoDog68b2iOwj8O/JMcfBcSNrw==
X-Received: by 10.98.11.9 with SMTP id t9mr2977073pfi.123.1488542268603;
        Fri, 03 Mar 2017 03:57:48 -0800 (PST)
Received: from arch-attack.localdomain (c-50-152-192-15.hsd1.ca.comcast.net. [50.152.192.15])
        by smtp.gmail.com with ESMTPSA id h25sm16309068pfk.119.2017.03.03.03.57.47
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Fri, 03 Mar 2017 03:57:48 -0800 (PST)
Date:   Fri, 3 Mar 2017 03:57:46 -0800
From:   Denton Liu <liu.denton@gmail.com>
To:     git@vger.kernel.org
Cc:     davvid@gmail.com, Johannes.Schindelin@gmx.de
Subject: [PATCH 2/3] Add gui completions for difftool
Message-ID: <20170303115746.GA13218@arch-attack.localdomain>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
User-Agent: Mutt/1.8.0 (2017-02-23)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Signed-off-by: Denton Liu <liu.denton@gmail.com>
---
 contrib/completion/git-completion.bash | 3 ++-
 1 file changed, 2 insertions(+), 1 deletion(-)

diff --git a/contrib/completion/git-completion.bash b/contrib/completion/git-completion.bash
index d5f3b9aeb..c94e38a3a 100644
--- a/contrib/completion/git-completion.bash
+++ b/contrib/completion/git-completion.bash
@@ -1277,7 +1277,7 @@ _git_difftool ()
 			--base --ours --theirs
 			--no-renames --diff-filter= --find-copies-harder
 			--relative --ignore-submodules
-			--tool="
+			--tool= --gui"
 		return
 		;;
 	esac
@@ -2207,6 +2207,7 @@ _git_config ()
 		diff.submodule
 		diff.suppressBlankEmpty
 		diff.tool
+		diff.guitool
 		diff.wordRegex
 		diff.algorithm
 		difftool.
-- 
2.12.0.1.g5415fdfc5.dirty

