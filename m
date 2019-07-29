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
	by dcvr.yhbt.net (Postfix) with ESMTP id 26D921F462
	for <e@80x24.org>; Mon, 29 Jul 2019 20:08:31 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1730286AbfG2UI3 (ORCPT <rfc822;e@80x24.org>);
        Mon, 29 Jul 2019 16:08:29 -0400
Received: from mail-wr1-f68.google.com ([209.85.221.68]:39878 "EHLO
        mail-wr1-f68.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1730278AbfG2UIQ (ORCPT <rfc822;git@vger.kernel.org>);
        Mon, 29 Jul 2019 16:08:16 -0400
Received: by mail-wr1-f68.google.com with SMTP id x4so10041202wrt.6
        for <git@vger.kernel.org>; Mon, 29 Jul 2019 13:08:14 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=date:message-id:in-reply-to:references:from:subject:fcc
         :content-transfer-encoding:mime-version:to:cc;
        bh=um4OkzmWG0Id/TA2oihc6iR1UWKLZFKWAWBZpj5ZC58=;
        b=pqZxPiAAPATURC9QbVkEILhfq35Oj0q1Hr0IVYLCT7Re4OP/6WdWAjZpl7WIrNuInG
         /vHj4mSn1nQsbyzMxZxg8JPKdtREZNKaA17krfERxQFD+8mNeSv70InIvrnYZ6/T1CQK
         u/W1bxIvAtSnPafLe9MEhcFPRmFb7vqwyfOaGCCBYKpqrADvxGDDUj89vILHvxKw4aVP
         Gt3RaYLkOgRAf0QFQLTGHVO3IHySM3EvaDa7CfpJcdD51eplR7Di+3K+NI+MBx5pQj+l
         mLBMi93QtvgHeAOT7Y1u++u5VpQig35om0VXRTm4kvjEEea2kOPakIKvhnIgCj2dXh1z
         JhEw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:message-id:in-reply-to:references:from
         :subject:fcc:content-transfer-encoding:mime-version:to:cc;
        bh=um4OkzmWG0Id/TA2oihc6iR1UWKLZFKWAWBZpj5ZC58=;
        b=C37qdcPvvgJJmtWRjwSv6jdEILFFJzbGAxZiGIs97Nl+8vLEzKZVitUpyMnLfXcti1
         OJ6GQ7r08YQaLcDmDeZuUmQDwnPP/7WlpcfmuAP1v0CCyjYAE3r0P8Iknh8HAkKmRZGB
         KrCZP6APvZ3xNSUw8Gn9TZo+RvmmKTSri8L7uAECJGjxFZUAtPNbvjO3l3xjKsWirEtu
         P4n8eiIJMOsyjAQsKJrgT9u2xPyONF5zDh2vf17dvOABiVHvWSCJ+79bBE1nFRsug9EY
         t7Posh0roQG4Qxsg9tQdx5w5E9ffsop2+z4VVaAl7SzEfX6sSZmluXeStjbKC/+oKbw/
         SU0w==
X-Gm-Message-State: APjAAAWTvEbQs2VA1I/+L69ADbN1oGYJPj6QSJ29iVYIp7xnpIAhAIEO
        l4lIARRFp2HfGN3+QYinB9+n9+tI
X-Google-Smtp-Source: APXvYqyo8DSfZyFCd6/SIVGC5NZhZbDLUg1us9+v20xb7KCeGrZWo/Q/Dv9GFyQbbVatfALB2N3MHg==
X-Received: by 2002:adf:cd84:: with SMTP id q4mr45299394wrj.232.1564430894290;
        Mon, 29 Jul 2019 13:08:14 -0700 (PDT)
Received: from [127.0.0.1] ([13.74.141.28])
        by smtp.gmail.com with ESMTPSA id c3sm67314256wrx.19.2019.07.29.13.08.13
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Mon, 29 Jul 2019 13:08:13 -0700 (PDT)
Date:   Mon, 29 Jul 2019 13:08:13 -0700 (PDT)
X-Google-Original-Date: Mon, 29 Jul 2019 20:07:55 GMT
Message-Id: <4dbbe3f4a20be45902d2a37238524a52ce7d98c3.1564430879.git.gitgitgadget@gmail.com>
In-Reply-To: <pull.287.v2.git.gitgitgadget@gmail.com>
References: <pull.287.git.gitgitgadget@gmail.com>
        <pull.287.v2.git.gitgitgadget@gmail.com>
From:   "Johannes Schindelin via GitGitGadget" <gitgitgadget@gmail.com>
Subject: [PATCH v2 19/23] vcxproj: also link-or-copy builtins
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
index e65d78e16d..576ccabe1d 100644
--- a/contrib/buildsystems/Generators/Vcxproj.pm
+++ b/contrib/buildsystems/Generators/Vcxproj.pm
@@ -274,6 +274,9 @@ sub createProject {
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

