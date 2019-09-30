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
	by dcvr.yhbt.net (Postfix) with ESMTP id C92441F463
	for <e@80x24.org>; Mon, 30 Sep 2019 09:55:48 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1730654AbfI3Jzs (ORCPT <rfc822;e@80x24.org>);
        Mon, 30 Sep 2019 05:55:48 -0400
Received: from mail-wm1-f65.google.com ([209.85.128.65]:38218 "EHLO
        mail-wm1-f65.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1730613AbfI3Jzi (ORCPT <rfc822;git@vger.kernel.org>);
        Mon, 30 Sep 2019 05:55:38 -0400
Received: by mail-wm1-f65.google.com with SMTP id 3so11987946wmi.3
        for <git@vger.kernel.org>; Mon, 30 Sep 2019 02:55:37 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=date:message-id:in-reply-to:references:from:subject:fcc
         :content-transfer-encoding:mime-version:to:cc;
        bh=uc1FRuQv1blFb9Pgjg/gjq1hKALg3HS9Tf2+tLI+NHg=;
        b=K5iAnRmEUYoEevgJzdLUgwUt+xCNfmNK/aror2V855t5X2OEZxU7D8bavr+LOXf1jm
         72Wg3tVof8SCl7c5/v8wTvin3e09Gzis35sAKb06f8P4LmXdPuXs7C4eDDr5B3/s9WYh
         GqzN1xVvPyM9nn8qRZM1VrMUF7+dAQhMwLqJwmXHmxYJqcAXWFhruJlIEF5WAkV6GXoi
         y0ji9BB2AbP/p2IVgZE9OH5awnaA7TjblH6oTuBKhl84rVWPMovVuNdIdlvqOBNTLBRd
         zrM6IQspV9Pyemhl36tebQdU9tiILbG5Up6/RebKzfMlDbCBowNMOPaOSJwu7cLfwyvY
         rSEw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:message-id:in-reply-to:references:from
         :subject:fcc:content-transfer-encoding:mime-version:to:cc;
        bh=uc1FRuQv1blFb9Pgjg/gjq1hKALg3HS9Tf2+tLI+NHg=;
        b=DAup7fAqnHubt/sOgQ+DRPv9szkZ+KggRdqmJrhbsSU9GRqf0YjTJ0Vn5iyyWXrWHI
         fF5gx7SOU0b9rLxaJM1XF/vVnj1qO+1QUO0jrS0W/Ld3+owOzo6erd+MZhzukKhw/FhE
         t1l8rI+TX985ESPeDGk42BUqgkvxETYhLyGMeS5QQ3ztO+ETdz1yoUwbLAkhyPmcsWzW
         SrLSpc5FLuSk1zZLBWB91u53LqnwuzHw4Kmt8OmdBGFcm67XBjbXfr7hCuW+70M1IwE/
         9HwLKarLw5rDNWinsZwzHOvh/ZERL39LNXs1wwk0Vv4+Ws/7BT/a98I5FYe4hh3FNgxf
         H56A==
X-Gm-Message-State: APjAAAX4lwBTrwX1ipQkftGJdW+9KlN9wm1WXUuIjdgV/n0E8V2FElof
        o23abDsYgBifwRyf2X27g9eu35K/
X-Google-Smtp-Source: APXvYqww/6drOKLu7h3tdIdCFbT5P0hSywZMUg/+OKxsCOMIqWybX0vVIL6UCtxf5kfVb4DrExPBCg==
X-Received: by 2002:a1c:1b14:: with SMTP id b20mr15244903wmb.122.1569837336539;
        Mon, 30 Sep 2019 02:55:36 -0700 (PDT)
Received: from [127.0.0.1] ([13.74.141.28])
        by smtp.gmail.com with ESMTPSA id r18sm13441953wme.48.2019.09.30.02.55.36
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Mon, 30 Sep 2019 02:55:36 -0700 (PDT)
Date:   Mon, 30 Sep 2019 02:55:36 -0700 (PDT)
X-Google-Original-Date: Mon, 30 Sep 2019 09:55:24 GMT
Message-Id: <582b299634f2ffe1cf81aea3ef1a4625ccd6e893.1569837329.git.gitgitgadget@gmail.com>
In-Reply-To: <pull.288.v2.git.gitgitgadget@gmail.com>
References: <pull.288.git.gitgitgadget@gmail.com>
        <pull.288.v2.git.gitgitgadget@gmail.com>
From:   "Johannes Schindelin via GitGitGadget" <gitgitgadget@gmail.com>
Subject: [PATCH v2 08/13] vcxproj: only copy `git-remote-http.exe` once it was
 built
Fcc:    Sent
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
MIME-Version: 1.0
To:     git@vger.kernel.org
Cc:     Denton Liu <liu.denton@gmail.com>,
        Johannes Schindelin <johannes.schindelin@gmx.de>,
        Junio C Hamano <gitster@pobox.com>,
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

