Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-3.4 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_HI,RP_MATCHES_RCVD
	shortcircuit=no autolearn=ham autolearn_force=no version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 9E78520133
	for <e@80x24.org>; Fri,  3 Mar 2017 14:39:34 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1751663AbdCCOjc (ORCPT <rfc822;e@80x24.org>);
        Fri, 3 Mar 2017 09:39:32 -0500
Received: from mail-pf0-f195.google.com ([209.85.192.195]:32834 "EHLO
        mail-pf0-f195.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1751365AbdCCOjb (ORCPT <rfc822;git@vger.kernel.org>);
        Fri, 3 Mar 2017 09:39:31 -0500
Received: by mail-pf0-f195.google.com with SMTP id e66so4426163pfe.0
        for <git@vger.kernel.org>; Fri, 03 Mar 2017 06:38:02 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=date:from:to:cc:subject:message-id:mime-version:content-disposition
         :user-agent;
        bh=H/Xo3vQz/e/Tg3mFayWd6bWimcGI3EowQsRI2dEof60=;
        b=UyH6AskYU+YtP99IPcgLEK+Rf3it6okNjoau8LO6B/rQmseqsNOBAghVc2qbbJOiPx
         sjxOCS6x0OKn74mmWWRmYHNhqgTV7IgN+ZdEY0fltHY9acwVM58szbVzGJXrK2fpZnwi
         459E26NcRDQRzH/dgFX0ycdtBJKNE93+FUmDop5QetmEQWcUomGyf88FA1Y98XIkf+JQ
         BsVJpgtezQBC53jlxTYPtD6m51QyGOO/I1EY2T5E/UIv08Sq8MRGvlf/zqTvJfeMhbzg
         CwIevZwkgowDkXRwIuZZGX92H7bkYG1GfVK9U1xxfO1UtMwuFUf8rjSw0vO6e/aRfDt6
         j4Bg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:mime-version
         :content-disposition:user-agent;
        bh=H/Xo3vQz/e/Tg3mFayWd6bWimcGI3EowQsRI2dEof60=;
        b=CxvU+QFocqgm7tYO6vfkwhlME8e4GXFFmdegVORQAVAXQRNpY4GR33dphmdi3SyGkR
         rX6T/TVWglkIvRuJS5SvSZSEBreJeaFe7c57QM+5PvrYOnSh/7N/KmizqSPRR875+yzt
         u/GHwrzAd6FMt89EL36RDoDCF+/vp0BIfajpJc7s2+1VE3xYSpRoDRmOFRA8X6TaRBpK
         F7qVGgHWEgWbDxRKOnVwEvRtal0yIu033Q7YSSn7J2+cJZZXiE+3h6kq0c1K96YuiaDl
         3+svziHw4L0bvJF7Wwdnh0fCMPlNeSbtYu7nlwsmWfTJvw2INBwP5DRnznpIpUfZlbzb
         q6wA==
X-Gm-Message-State: AMke39mUedDhEOsj0Es21ooflTYKDy2RdGd3xCqLCa/h/eDwWUos34pmT/m8S4fOHmlJZA==
X-Received: by 10.98.160.84 with SMTP id r81mr3599568pfe.71.1488548440882;
        Fri, 03 Mar 2017 05:40:40 -0800 (PST)
Received: from arch-attack.localdomain (c-50-152-192-15.hsd1.ca.comcast.net. [50.152.192.15])
        by smtp.gmail.com with ESMTPSA id i15sm23697521pfj.0.2017.03.03.05.40.40
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Fri, 03 Mar 2017 05:40:40 -0800 (PST)
Date:   Fri, 3 Mar 2017 05:40:38 -0800
From:   Denton Liu <liu.denton@gmail.com>
To:     git@vger.kernel.org
Cc:     davvid@gmail.com, Johannes.Schindelin@gmx.de
Subject: [PATCH v2 4/5] Add guitool completions for diff and mergetools
Message-ID: <20170303134038.GA6274@arch-attack.localdomain>
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
 contrib/completion/git-completion.bash | 6 ++++--
 1 file changed, 4 insertions(+), 2 deletions(-)

diff --git a/contrib/completion/git-completion.bash b/contrib/completion/git-completion.bash
index 41ee52991..c94e38a3a 100644
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
@@ -1584,7 +1584,7 @@ _git_mergetool ()
 		return
 		;;
 	--*)
-		__gitcomp "--tool= --prompt --no-prompt"
+		__gitcomp "--tool= --prompt --no-prompt --gui"
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
@@ -2308,6 +2309,7 @@ _git_config ()
 		merge.renormalize
 		merge.stat
 		merge.tool
+		merge.guitool
 		merge.verbosity
 		mergetool.
 		mergetool.keepBackup
-- 
2.12.0.5.gfbc750a84

