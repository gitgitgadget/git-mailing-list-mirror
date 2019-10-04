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
	by dcvr.yhbt.net (Postfix) with ESMTP id 0C2DB1F4BD
	for <e@80x24.org>; Fri,  4 Oct 2019 15:09:36 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2389727AbfJDPJe (ORCPT <rfc822;e@80x24.org>);
        Fri, 4 Oct 2019 11:09:34 -0400
Received: from mail-wm1-f68.google.com ([209.85.128.68]:34847 "EHLO
        mail-wm1-f68.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S2389721AbfJDPJe (ORCPT <rfc822;git@vger.kernel.org>);
        Fri, 4 Oct 2019 11:09:34 -0400
Received: by mail-wm1-f68.google.com with SMTP id y21so6260052wmi.0
        for <git@vger.kernel.org>; Fri, 04 Oct 2019 08:09:33 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=date:message-id:in-reply-to:references:from:subject:fcc
         :content-transfer-encoding:mime-version:to:cc;
        bh=uc1FRuQv1blFb9Pgjg/gjq1hKALg3HS9Tf2+tLI+NHg=;
        b=QDbgzERuvB+FCc4CBvYBkcZtEZ9b8BV2TCE/Io6xR7fxS8B8mll2oKiP8Urhj/36t1
         3QY2LBJk1fBC59XMaOvsqaGYmq00GTbZ5DLxiv/8sxVMiqbJUhznUm7kngWwqN+pwdpk
         YFsX0qZBOuj/bxbn2OP7N+OOomv1FPAJDOGmtl/1BcEUPkJR87I8a6E4IS0UAwQS3fNt
         LBKrtoA7wEyCMto/ENe4SITxkkhSn0qfzJdjFuCscn/IuG/CXllZ1JQ7X8YnCz1zqOQp
         euvRTD5cacAqhHQainYKH5Pc9IF+kIjE2zrPtSqQyrjJ5NqmmccRVn/PbejfYaf1XcKs
         JNvw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:message-id:in-reply-to:references:from
         :subject:fcc:content-transfer-encoding:mime-version:to:cc;
        bh=uc1FRuQv1blFb9Pgjg/gjq1hKALg3HS9Tf2+tLI+NHg=;
        b=Lm9xpjD4SJBHEzntn2aJY96oj1VCkxPd7McJTXyW0g0CYUMKuOnzHLy3ygdRlXt3Vw
         sXioG47GBZ4iOWmgYhSgamQ9uQ0fEMJwSWCZZZU3PhDW+3UgTj6JvseTqHCSIt4nafiB
         UIlo7/Gr8ZHk4U2AmPdkYQvRRwWCeYy/VAf5qdrt66YH4QOcy3yA7au8wh0HD8I36+dw
         afP4Ba/GT8/frPZJ6wnvH2RhCcEVEMFCs6J7acOLAd7Dkw+ARrEcli9ct3mf1AIpjDOh
         m6mbVFs6qDKsnX0w/xxoX5pEN3kxQjpIDniS3ly8lStOTiqWP3dIRq4ap/Zt30Jtkmsl
         FNlA==
X-Gm-Message-State: APjAAAU+PK47vbySkYTw+kxv4tVu56soaOcH/Fgp8rkD/qSTbHVz/LA4
        QkKlPZaIjPADIhfINgoIhqdE7Cwe
X-Google-Smtp-Source: APXvYqynV+iiBEBRg21Ierf/nYZciI3mwF7igSwGgHfA/BQHDTcrrk8ruOqQ4n1vV3PAc6sfiU1YEw==
X-Received: by 2002:a1c:49d4:: with SMTP id w203mr10539062wma.132.1570201772372;
        Fri, 04 Oct 2019 08:09:32 -0700 (PDT)
Received: from [127.0.0.1] ([13.74.141.28])
        by smtp.gmail.com with ESMTPSA id i5sm6816124wmd.21.2019.10.04.08.09.31
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Fri, 04 Oct 2019 08:09:31 -0700 (PDT)
Date:   Fri, 04 Oct 2019 08:09:31 -0700 (PDT)
X-Google-Original-Date: Fri, 04 Oct 2019 15:09:17 GMT
Message-Id: <cca891450df4eddaa1cb73e4aaa70c444f2531d2.1570201763.git.gitgitgadget@gmail.com>
In-Reply-To: <pull.288.v3.git.gitgitgadget@gmail.com>
References: <pull.288.v2.git.gitgitgadget@gmail.com>
        <pull.288.v3.git.gitgitgadget@gmail.com>
From:   "Johannes Schindelin via GitGitGadget" <gitgitgadget@gmail.com>
Subject: [PATCH v3 08/13] vcxproj: only copy `git-remote-http.exe` once it was
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

