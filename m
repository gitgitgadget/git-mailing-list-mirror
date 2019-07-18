Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.2 (2018-09-13) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-4.1 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,RCVD_IN_DNSWL_HI,
	SPF_HELO_NONE,SPF_NONE shortcircuit=no autolearn=ham
	autolearn_force=no version=3.4.2
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 2F5901F461
	for <e@80x24.org>; Thu, 18 Jul 2019 13:19:33 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2390585AbfGRNTc (ORCPT <rfc822;e@80x24.org>);
        Thu, 18 Jul 2019 09:19:32 -0400
Received: from mail-wr1-f66.google.com ([209.85.221.66]:35598 "EHLO
        mail-wr1-f66.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S2390498AbfGRNTP (ORCPT <rfc822;git@vger.kernel.org>);
        Thu, 18 Jul 2019 09:19:15 -0400
Received: by mail-wr1-f66.google.com with SMTP id y4so28695402wrm.2
        for <git@vger.kernel.org>; Thu, 18 Jul 2019 06:19:14 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=date:message-id:in-reply-to:references:from:subject:fcc
         :content-transfer-encoding:mime-version:to:cc;
        bh=aXe9EIRDefNaQtmt5Ie/2gp0jjIY/w2vx+N62wojQGE=;
        b=JgCH7tfboi4QDnXhxM04O90LShi5an2yB2TT4OW2uorO8Sf9fE3BTCT153/Sl9j1Yz
         o+XZQJltUp76fNTyGVom9AQqYRpG/Q6rCZKYCXTINIZiPXcb6yFZCxbiQPEZfqEaZg0i
         dnE3SuNrjqt5rzJzNkrhMtOGVOX+DBYpoSPOfhmpniujBaTeWyCntQV7qlko8vycYt+P
         Kx4gsOrfePzkb6oQpqZwN0mwx+Vddajq6WbMjGB+L47bbO1BDqsYsfkrSBxYwM+PoPKH
         VB+B2TI6fO6pOOCDDiKyNgUHPQtko4Kg++yTSrFWW3nzc93yI6BLx3bOaw7CkiJQFvad
         V2LA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:message-id:in-reply-to:references:from
         :subject:fcc:content-transfer-encoding:mime-version:to:cc;
        bh=aXe9EIRDefNaQtmt5Ie/2gp0jjIY/w2vx+N62wojQGE=;
        b=USp7yuzqlGsv8gzyZC0TaIubJWL8EnxLJLtef79eWlhXPNPLGX/9hPi9WpZ8RO/csG
         CJHSIpeiimRr+FtlSejXLqMhdylFJ9fTmlncSUQi75uYdeJ+jN9pDAHZenLwdzeHbj1N
         Kl+hbHOUFCOmXvCOjmA+WqLfPAXyOjvKl2Hjd3dM/ZHyyEktz92DxE2V5DTz7/ML1LIa
         JA9BpsfYdA7/BIUz78jv405zOMIVIINLv4P7A35d0ocLC/+8DztPH45kBbYwHt/ySDU9
         6BxSmyqIIhAFEP8ESV+RCpeUl2dZnAJm3/ehttOxfDdKhjK+7ae0QvXfpgmpYysE7QVQ
         0KrA==
X-Gm-Message-State: APjAAAUckatE3KpbHDaGVBSwHWlwf1TEF7gQfb1OdYArP8WaD7GjE8zn
        tmKn8A4JsP/CijTCOsD4gAiWZ6Sp
X-Google-Smtp-Source: APXvYqzS0+2EG+JzcpqasJW2gxUe1BjeAW6478U+uMBB/Z2K2Gq2hPBMy3eOq8PmyU4qBlA0n13+GQ==
X-Received: by 2002:a5d:514f:: with SMTP id u15mr50594566wrt.183.1563455953851;
        Thu, 18 Jul 2019 06:19:13 -0700 (PDT)
Received: from [127.0.0.1] ([13.74.141.28])
        by smtp.gmail.com with ESMTPSA id t6sm27080502wmb.29.2019.07.18.06.19.13
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Thu, 18 Jul 2019 06:19:13 -0700 (PDT)
Date:   Thu, 18 Jul 2019 06:19:13 -0700 (PDT)
X-Google-Original-Date: Thu, 18 Jul 2019 13:18:54 GMT
Message-Id: <33bed9a7a6b3ac16108e90463d695dcb49d39720.1563455939.git.gitgitgadget@gmail.com>
In-Reply-To: <pull.287.git.gitgitgadget@gmail.com>
References: <pull.287.git.gitgitgadget@gmail.com>
From:   "Johannes Schindelin via GitGitGadget" <gitgitgadget@gmail.com>
Subject: [PATCH 19/24] vcxproj: also link-or-copy builtins
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

The default location for `.exe` files linked by Visual Studio depends on
the mode (debug vs release) and the architecture. Meaning: after a full
build, there is a `git.exe` in the top-level directory, but none of the
built-ins are linked..

When running a test script in Git Bash, it therefore would pick up the
wrong, say, `git-receive-pack.exe`: the one installed at the same time
as the Git Bash.

Absolutely not what we want. We want to have confidence that our test
covers the MSVC-built Git executables, and not some random stuff.

Signed-off-by: Johannes Schindelin <johannes.schindelin@gmx.de>
---
 config.mak.uname                           | 15 +++++++++++++++
 contrib/buildsystems/Generators/Vcxproj.pm |  3 +++
 2 files changed, 18 insertions(+)

diff --git a/config.mak.uname b/config.mak.uname
index 6d0ed923b8..db7f06b95f 100644
--- a/config.mak.uname
+++ b/config.mak.uname
@@ -703,6 +703,21 @@ vcxproj:
 	perl contrib/buildsystems/generate -g Vcxproj
 	git add -f git.sln {*,*/lib,t/helper/*}/*.vcxproj
 
+	# Generate the LinkOrCopyBuiltins.targets file
+	(echo '<Project xmlns="http://schemas.microsoft.com/developer/msbuild/2003">' && \
+	 echo '  <Target Name="CopyBuiltins_AfterBuild" AfterTargets="AfterBuild">' && \
+	 for name in $(BUILT_INS);\
+	 do \
+	   echo '    <Copy SourceFiles="$$(OutDir)\git.exe" DestinationFiles="$$(OutDir)\'"$$name"'" SkipUnchangedFiles="true" UseHardlinksIfPossible="true" />'; \
+	 done && \
+	 for name in $(REMOTE_CURL_ALIASES); \
+	 do \
+	   echo '    <Copy SourceFiles="$$(OutDir)\'"$(REMOTE_CURL_PRIMARY)"'" DestinationFiles="$$(OutDir)\'"$$name"'" SkipUnchangedFiles="true" UseHardlinksIfPossible="true" />'; \
+	 done && \
+	 echo '  </Target>' && \
+	 echo '</Project>') >git/LinkOrCopyBuiltins.targets
+	git add -f git/LinkOrCopyBuiltins.targets
+
 	# Add command-list.h
 	$(MAKE) MSVC=1 SKIP_VCPKG=1 prefix=/mingw64 command-list.h
 	git add -f command-list.h
diff --git a/contrib/buildsystems/Generators/Vcxproj.pm b/contrib/buildsystems/Generators/Vcxproj.pm
index 9e7ed24912..4b02524b10 100644
--- a/contrib/buildsystems/Generators/Vcxproj.pm
+++ b/contrib/buildsystems/Generators/Vcxproj.pm
@@ -273,6 +273,9 @@ sub createProject {
   </Target>
 EOM
     }
+    if ($target eq 'git') {
+      print F "  <Import Project=\"LinkOrCopyBuiltins.targets\" />\n";
+    }
     print F << "EOM";
 </Project>
 EOM
-- 
gitgitgadget

