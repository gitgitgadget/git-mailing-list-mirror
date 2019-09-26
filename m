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
	by dcvr.yhbt.net (Postfix) with ESMTP id 094441F463
	for <e@80x24.org>; Thu, 26 Sep 2019 08:30:26 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729127AbfIZIaZ (ORCPT <rfc822;e@80x24.org>);
        Thu, 26 Sep 2019 04:30:25 -0400
Received: from mail-lj1-f177.google.com ([209.85.208.177]:42576 "EHLO
        mail-lj1-f177.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727529AbfIZIaV (ORCPT <rfc822;git@vger.kernel.org>);
        Thu, 26 Sep 2019 04:30:21 -0400
Received: by mail-lj1-f177.google.com with SMTP id y23so1210366lje.9
        for <git@vger.kernel.org>; Thu, 26 Sep 2019 01:30:19 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=date:message-id:in-reply-to:references:from:subject:fcc
         :content-transfer-encoding:mime-version:to:cc;
        bh=uc1FRuQv1blFb9Pgjg/gjq1hKALg3HS9Tf2+tLI+NHg=;
        b=fY0q3eobDgtfmRipds/xbX1JRJSUuFz+b7F9aLapwKZctaIEtBJgFd2aa3TvoFprMg
         oJOwhmwYzxHwz4SnqM00gulZ9RTvtG7j9hk3mBIADtH9N1AaZYA9X3QmLHAL+aOjcHrm
         Sg2BJtcUjqQ6s9RzgUesbw0nlABj2+1YDeeS6RT3Oxr7ViDSY1h7NZa4twHZy1SuNPuU
         m2Rw6LZs8GKh2Wk7CLTvmiXOdOvEtNvxax62vPUowU+0lKGh0q4wBPqPlAkDfMMdbdCZ
         iEITuhA8di+RKz3V634NYuIpd17eKMs/Skjb2cAFWILPnjSYFDKRxG3WmyT+FrbONaW3
         eBNQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:message-id:in-reply-to:references:from
         :subject:fcc:content-transfer-encoding:mime-version:to:cc;
        bh=uc1FRuQv1blFb9Pgjg/gjq1hKALg3HS9Tf2+tLI+NHg=;
        b=Ukok4vuO148UMlrUUuuPYHnZTVOYVSDzkYXYi+gzSf28r6jiESLpaECvM/S4248Bse
         lOoq4qWSyvtd0PxmaKrajLSdxhRKADddRGdvgY9L1wYCKS2DMQ8rnn8dkWmH9Vi2GGSS
         LjdGz15dIDttCZsKi4XeE1UitmySdkUxFGH9kAvQGIWNLl1tXoKxfrkp7gfmdVtj7ktv
         L6vmvrbBMiyX+mfJZf4w1O3dWgFAKHzSpcdhVKnSJ5rlzbiTG/7QEQt3P6X95UqjEQcQ
         ZSfTCn1fLNHREPVejRazJgwxYn9AZes33289OUNO3LcAO6bY1wXQqWLbBcSRam1k+Uap
         8ozw==
X-Gm-Message-State: APjAAAWKr0nbjynskwNRNS94mlYUG7gVxTsnPFrHHuRucXd7PSeRakA2
        5HuvSMa1ZsPCCU4u441tMAd2FHVz
X-Google-Smtp-Source: APXvYqx432WSk2YTFlPe6XK7kGFkG8lieLPEZ8KGlRwUQyuSAmJWSGHdN4saFKQP9p2wYpIekbVmOg==
X-Received: by 2002:a2e:9d16:: with SMTP id t22mr1462059lji.207.1569486619088;
        Thu, 26 Sep 2019 01:30:19 -0700 (PDT)
Received: from [127.0.0.1] ([13.74.141.28])
        by smtp.gmail.com with ESMTPSA id k15sm351954ljg.65.2019.09.26.01.30.18
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Thu, 26 Sep 2019 01:30:18 -0700 (PDT)
Date:   Thu, 26 Sep 2019 01:30:18 -0700 (PDT)
X-Google-Original-Date: Thu, 26 Sep 2019 08:30:01 GMT
Message-Id: <f7d5d1a1bce8dd783914b4b5406abdae61440517.1569486607.git.gitgitgadget@gmail.com>
In-Reply-To: <pull.288.git.gitgitgadget@gmail.com>
References: <pull.288.git.gitgitgadget@gmail.com>
From:   "Johannes Schindelin via GitGitGadget" <gitgitgadget@gmail.com>
Subject: [PATCH 08/13] vcxproj: only copy `git-remote-http.exe` once it was
 built
Fcc:    Sent
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
MIME-Version: 1.0
To:     git@vger.kernel.org
Cc:     Junio C Hamano <gitster@pobox.com>,
        Johannes Schindelin <johannes.schindelin@gmx.de>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

From: Johannes Schindelin <johannes.schindelin@gmx.de>

In b18ae14a8f6 (vcxproj: also link-or-copy builtins, 2019-07-29), we
started to copy or hard-link the built-ins as a post-build step of the
`git` project.

At the same time, we tried to copy or hard-link `git-remote-http.exe`,
but it is quite possible that it was not built at that time.

Let's move that latter task into a post-install step of the
`git-remote-http` project instead.

Signed-off-by: Johannes Schindelin <johannes.schindelin@gmx.de>
---
 config.mak.uname                           | 10 +++++++---
 contrib/buildsystems/Generators/Vcxproj.pm |  3 +++
 2 files changed, 10 insertions(+), 3 deletions(-)

diff --git a/config.mak.uname b/config.mak.uname
index db7f06b95f..701aad62b1 100644
--- a/config.mak.uname
+++ b/config.mak.uname
@@ -703,20 +703,24 @@ vcxproj:
 	perl contrib/buildsystems/generate -g Vcxproj
 	git add -f git.sln {*,*/lib,t/helper/*}/*.vcxproj
 
-	# Generate the LinkOrCopyBuiltins.targets file
+	# Generate the LinkOrCopyBuiltins.targets and LinkOrCopyRemoteHttp.targets file
 	(echo '<Project xmlns="http://schemas.microsoft.com/developer/msbuild/2003">' && \
 	 echo '  <Target Name="CopyBuiltins_AfterBuild" AfterTargets="AfterBuild">' && \
 	 for name in $(BUILT_INS);\
 	 do \
 	   echo '    <Copy SourceFiles="$$(OutDir)\git.exe" DestinationFiles="$$(OutDir)\'"$$name"'" SkipUnchangedFiles="true" UseHardlinksIfPossible="true" />'; \
 	 done && \
+	 echo '  </Target>' && \
+	 echo '</Project>') >git/LinkOrCopyBuiltins.targets
+	(echo '<Project xmlns="http://schemas.microsoft.com/developer/msbuild/2003">' && \
+	 echo '  <Target Name="CopyBuiltins_AfterBuild" AfterTargets="AfterBuild">' && \
 	 for name in $(REMOTE_CURL_ALIASES); \
 	 do \
 	   echo '    <Copy SourceFiles="$$(OutDir)\'"$(REMOTE_CURL_PRIMARY)"'" DestinationFiles="$$(OutDir)\'"$$name"'" SkipUnchangedFiles="true" UseHardlinksIfPossible="true" />'; \
 	 done && \
 	 echo '  </Target>' && \
-	 echo '</Project>') >git/LinkOrCopyBuiltins.targets
-	git add -f git/LinkOrCopyBuiltins.targets
+	 echo '</Project>') >git-remote-http/LinkOrCopyRemoteHttp.targets
+	git add -f git/LinkOrCopyBuiltins.targets git-remote-http/LinkOrCopyRemoteHttp.targets
 
 	# Add command-list.h
 	$(MAKE) MSVC=1 SKIP_VCPKG=1 prefix=/mingw64 command-list.h
diff --git a/contrib/buildsystems/Generators/Vcxproj.pm b/contrib/buildsystems/Generators/Vcxproj.pm
index 576ccabe1d..868b787855 100644
--- a/contrib/buildsystems/Generators/Vcxproj.pm
+++ b/contrib/buildsystems/Generators/Vcxproj.pm
@@ -277,6 +277,9 @@ sub createProject {
     if ($target eq 'git') {
       print F "  <Import Project=\"LinkOrCopyBuiltins.targets\" />\n";
     }
+    if ($target eq 'git-remote-http') {
+      print F "  <Import Project=\"LinkOrCopyRemoteHttp.targets\" />\n";
+    }
     print F << "EOM";
 </Project>
 EOM
-- 
gitgitgadget

