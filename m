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
	by dcvr.yhbt.net (Postfix) with ESMTP id 0AC591F463
	for <e@80x24.org>; Thu, 26 Sep 2019 17:46:25 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727793AbfIZRqY (ORCPT <rfc822;e@80x24.org>);
        Thu, 26 Sep 2019 13:46:24 -0400
Received: from mail-lj1-f179.google.com ([209.85.208.179]:37497 "EHLO
        mail-lj1-f179.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727707AbfIZRqX (ORCPT <rfc822;git@vger.kernel.org>);
        Thu, 26 Sep 2019 13:46:23 -0400
Received: by mail-lj1-f179.google.com with SMTP id l21so3087561lje.4
        for <git@vger.kernel.org>; Thu, 26 Sep 2019 10:46:21 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=date:message-id:in-reply-to:references:from:subject:mime-version
         :content-transfer-encoding:fcc:to:cc;
        bh=zdftzjU2pTIarBIrt4egyad/Hcdq+xDZQ1/Jrd4YMhY=;
        b=RCrcH7u45AtgS+ZoWDMTRVzgxrhTMNN6hLZjKLSeqMobOD+raYVOIJHvO8dPEHRo23
         6uC4H+IGONPPL2HNFEI/d60FpqLFzMetxBxMtd1qYDPf4CqjzSXZR75Pd2SoFuC+IQOj
         a70M8wCguHDMwpKopNYnJZxFriGSTUWh5wmhjvRKZ36ZsliFdO/j0KvHJdQUF0DRjOWE
         9rAPoIn+dP24hhLGevYtl/ZIn+eKYIOVwqn52KuEiU8sI6jj1zTyd20rw2bon3j3KX83
         o1bV31Nt9Wi0bPgZ7wVIl1bzp6Ms21pMBfRGbS7wjnIpZ+J35YfKzjnmxLkVME+JUaxw
         jNMA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:message-id:in-reply-to:references:from
         :subject:mime-version:content-transfer-encoding:fcc:to:cc;
        bh=zdftzjU2pTIarBIrt4egyad/Hcdq+xDZQ1/Jrd4YMhY=;
        b=IoEe7JgfDMNK9+2Fj8w5eCxTiwGotBgMTLiZ1E9t/F9m/bg9Jd48KXpcN5+NuTRINp
         STmNX7XimU8ygE31tljwLWAiPwg9dM42WSq2dMs/c4/3ugdSO8QYZl9QBRJiGyL5FAW1
         DqEU7NZua350GPxV5EUpWT/MTR/RbRdCEWgKB+ECok7K+G2ZDFayB8SxVJYi2IN+7z36
         snC3eUiph2im3zaoJ5t2oHlmt/FxiGAFYPvrhEq8dRA3KZlYi1yTA/Rg9+bNJSXJIM8d
         WPoY4IuZ3c6L504ejtU/zoHbXv2kY6LyNYpOHV6DpqRRWT04P9cN8XDZYa4jsB4ZBGRh
         tT/w==
X-Gm-Message-State: APjAAAW0wR4SrBzAU3yci8yyhmMLLm57+fTdWg80LpSbPPIORXqcTfNJ
        qODjRHb7MkouG08YJbMyBUXXVQEP
X-Google-Smtp-Source: APXvYqw/sTtpfo+JYInWQEiDH3ezADPoFzANxme5kcoi1Xq7m9NlaHx0FgXBiKll9hdNBKZG3jWtog==
X-Received: by 2002:a2e:9584:: with SMTP id w4mr3519794ljh.145.1569519980340;
        Thu, 26 Sep 2019 10:46:20 -0700 (PDT)
Received: from [127.0.0.1] ([13.74.141.28])
        by smtp.gmail.com with ESMTPSA id 3sm637534ljs.20.2019.09.26.10.46.19
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Thu, 26 Sep 2019 10:46:19 -0700 (PDT)
Date:   Thu, 26 Sep 2019 10:46:19 -0700 (PDT)
X-Google-Original-Date: Thu, 26 Sep 2019 17:46:17 GMT
Message-Id: <414cf2c89876fe122ee18f8d6533f083c2f65654.1569519977.git.gitgitgadget@gmail.com>
In-Reply-To: <pull.360.git.gitgitgadget@gmail.com>
References: <pull.360.git.gitgitgadget@gmail.com>
From:   "Thomas Klaeger via GitGitGadget" <gitgitgadget@gmail.com>
Subject: [PATCH 1/1] git-gui (Windows): use git-bash.exe if it is available
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Fcc:    Sent
To:     git@vger.kernel.org
Cc:     Pratyush Yadav <me@yadavpratyush.com>,
        Johannes Schindelin <johannes.schindelin@gmx.de>,
        Junio C Hamano <gitster@pobox.com>,
        Thomas Klaeger <thklaeger@gmail.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

From: Thomas Klaeger <thklaeger@gmail.com>

Git for Windows 2.x ships with an executable that starts the Git Bash
with all the environment variables and what not properly set up. It is
also adjusted according to the Terminal emulator option chosen when
installing Git for Windows (while `bash.exe --login -i` would always
launch with Windows' default console).

So let's use that executable (usually C:\Program Files\Git\git-bash.exe)
instead of `bash.exe --login -i` if its presence was detected.

This fixes https://github.com/git-for-windows/git/issues/490

Signed-off-by: Thomas Kläger <thomas.klaeger@10a.ch>
Signed-off-by: Johannes Schindelin <johannes.schindelin@gmx.de>
---
 git-gui.sh | 12 ++++++++++--
 1 file changed, 10 insertions(+), 2 deletions(-)

diff --git a/git-gui.sh b/git-gui.sh
index f9b323abff..5a1bfd736e 100755
--- a/git-gui.sh
+++ b/git-gui.sh
@@ -2700,10 +2700,18 @@ if {![is_bare]} {
 }
 
 if {[is_Windows]} {
+	# Use /git-bash.exe if available
+	set normalized [file normalize $::argv0]
+	regsub "/mingw../libexec/git-core/git-gui$" \
+		$normalized "/git-bash.exe" cmdLine
+	if {$cmdLine != $normalized && [file exists $cmdLine]} {
+		set cmdLine [list "Git Bash" $cmdLine &]
+	} else {
+		set cmdLine [list "Git Bash" bash --login -l &]
+	}
 	.mbar.repository add command \
 		-label [mc "Git Bash"] \
-		-command {eval exec [auto_execok start] \
-					  [list "Git Bash" bash --login -l &]}
+		-command {eval exec [auto_execok start] $cmdLine}
 }
 
 if {[is_Windows] || ![is_bare]} {
-- 
gitgitgadget
