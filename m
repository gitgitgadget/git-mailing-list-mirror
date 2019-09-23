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
	by dcvr.yhbt.net (Postfix) with ESMTP id 4CA371F463
	for <e@80x24.org>; Mon, 23 Sep 2019 08:28:39 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2393787AbfIWI2i (ORCPT <rfc822;e@80x24.org>);
        Mon, 23 Sep 2019 04:28:38 -0400
Received: from mail-wr1-f68.google.com ([209.85.221.68]:36419 "EHLO
        mail-wr1-f68.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S2392225AbfIWI2i (ORCPT <rfc822;git@vger.kernel.org>);
        Mon, 23 Sep 2019 04:28:38 -0400
Received: by mail-wr1-f68.google.com with SMTP id y19so12879438wrd.3
        for <git@vger.kernel.org>; Mon, 23 Sep 2019 01:28:36 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=date:message-id:in-reply-to:references:from:subject:fcc
         :content-transfer-encoding:mime-version:to:cc;
        bh=cLOJPBGHQeoP3VsScz52IA7p2fUAq65mbDvCQBrzHjQ=;
        b=SWpirlaet0wg8MjV56XUDnnetSnsvQz5mavRyJBGwsL9hxlQSFBSXXyBj/zO+sT6CO
         3nFS1s6qKFwUCj+T2xz9bpgAkeSMdP2HkOMwJzXDhN27tbPf++6ZrEfwKXHLEFZMjnTa
         raHnOHfoVmQEnU5zfiSXMd08rhzzAv6//gPr6BQiswzvQc5MuWdv9/5moXplEBW6RYPw
         3X03v4td1p8Yy125ur5PFJ5Sj4GK0dZ21eKxmUtMZVbt9+mClyDpdlb+iGXGnxHWufTd
         njHUqqgD/RsP4p1P1L/rRvhRmhUFaq75RgPcYvagBsdiNWs6ZEIMojMsblk7BRSmaFBc
         ok1w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:message-id:in-reply-to:references:from
         :subject:fcc:content-transfer-encoding:mime-version:to:cc;
        bh=cLOJPBGHQeoP3VsScz52IA7p2fUAq65mbDvCQBrzHjQ=;
        b=pg3lrjyqRdmEJxeDBURP7DqrlOht/Rhn+k38zvyVHyt76FhkzXXJaPGNgZ7VUoBoBF
         Ij5w5KclemYqZxuaoDWS2ijbwRburxif7nF4N9zQkHO934EWae29yzIWOQyvSyUqtDG0
         vRCvK0YzFalZAZlRPR0iiVKcYAANAv8hOjz7GEVz56K0B0duVrlD3YliyBcdqLqC0qYh
         VXNCdDS2PbKMEoF5zsNxmyakYfuLL8j1AjKVluznVxwc0ERDIbCHSzl9ionIFsQKI9S4
         v8LLUe84Dzy31zUf/KMAFBLFBnvUCexzKdL1zHDVz5K0CMo+/6bOXQTQqS1dXFYRnvm+
         vTBQ==
X-Gm-Message-State: APjAAAXqRFyOd2z5TQpEsQsg/8kLQquufrJyl7uUMJGSRKjeSHw/ViAL
        kezk/hBlyOfnRzOdDoSPCpPUX+1D
X-Google-Smtp-Source: APXvYqwKxUMRnveU4ur276PyNUwNiqynmTbVrIDLCycL5ACJKfJWC0kwNmbqvZtAXIV2KLSWXMG6Cg==
X-Received: by 2002:adf:e5c2:: with SMTP id a2mr20035601wrn.320.1569227316019;
        Mon, 23 Sep 2019 01:28:36 -0700 (PDT)
Received: from [127.0.0.1] ([13.74.141.28])
        by smtp.gmail.com with ESMTPSA id n17sm9535568wrp.37.2019.09.23.01.28.35
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Mon, 23 Sep 2019 01:28:35 -0700 (PDT)
Date:   Mon, 23 Sep 2019 01:28:35 -0700 (PDT)
X-Google-Original-Date: Mon, 23 Sep 2019 08:28:33 GMT
Message-Id: <525669b3b38ed57d6d4f188dfe0bb8fe10b63749.1569227313.git.gitgitgadget@gmail.com>
In-Reply-To: <pull.348.git.gitgitgadget@gmail.com>
References: <pull.348.git.gitgitgadget@gmail.com>
From:   "Alexandr Miloslavskiy via GitGitGadget" <gitgitgadget@gmail.com>
Subject: [PATCH 1/1] contrib/buildsystems: fix Visual Studio Debug
 configuration
Fcc:    Sent
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
MIME-Version: 1.0
To:     git@vger.kernel.org
Cc:     Junio C Hamano <gitster@pobox.com>,
        Alexandr Miloslavskiy <alexandr.miloslavskiy@syntevo.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

From: Alexandr Miloslavskiy <alexandr.miloslavskiy@syntevo.com>

Even though Debug configuration builds, the resulting build is incorrect
in a subtle way: it mixes up Debug and Release binaries, which in turn
causes hard-to-predict bugs.

In my case, when git calls iconv library, iconv sets 'errno' and git
then tests it, but in Debug and Release CRT those 'errno' are different
memory locations.

This patch addresses 3 connected bugs:
1) Typo in '\(Configuration)'. As a result, Debug configuration
   condition is always false and Release path is taken instead.
2) Regexp that replaced 'zlib.lib' with 'zlibd.lib' was only affecting
   the first occurrence. However, some projects have it listed twice.
   Previously this bug was hidden, because Debug path was never taken.
   I decided that avoiding double -lz in makefile is fragile and I'd
   better replace all occurrences instead.
3) In Debug, 'libcurl-d.lib' should be used instead of 'libcurl.lib'.
   Previously this bug was hidden, because Debug path was never taken.

Signed-off-by: Alexandr Miloslavskiy <alexandr.miloslavskiy@syntevo.com>
---
 contrib/buildsystems/Generators/Vcxproj.pm | 15 ++++++++-------
 1 file changed, 8 insertions(+), 7 deletions(-)

diff --git a/contrib/buildsystems/Generators/Vcxproj.pm b/contrib/buildsystems/Generators/Vcxproj.pm
index 576ccabe1d..7b1e277eca 100644
--- a/contrib/buildsystems/Generators/Vcxproj.pm
+++ b/contrib/buildsystems/Generators/Vcxproj.pm
@@ -79,7 +79,8 @@ sub createProject {
     if (!$static_library) {
       $libs_release = join(";", sort(grep /^(?!libgit\.lib|xdiff\/lib\.lib|vcs-svn\/lib\.lib)/, @{$$build_structure{"$prefix${name}_LIBS"}}));
       $libs_debug = $libs_release;
-      $libs_debug =~ s/zlib\.lib/zlibd\.lib/;
+      $libs_debug =~ s/zlib\.lib/zlibd\.lib/g;
+      $libs_debug =~ s/libcurl\.lib/libcurl-d\.lib/g;
     }
 
     $defines =~ s/-D//g;
@@ -119,13 +120,13 @@ sub createProject {
     <VCPKGArch Condition="'\$(Platform)'=='Win32'">x86-windows</VCPKGArch>
     <VCPKGArch Condition="'\$(Platform)'!='Win32'">x64-windows</VCPKGArch>
     <VCPKGArchDirectory>$cdup\\compat\\vcbuild\\vcpkg\\installed\\\$(VCPKGArch)</VCPKGArchDirectory>
-    <VCPKGBinDirectory Condition="'\(Configuration)'=='Debug'">\$(VCPKGArchDirectory)\\debug\\bin</VCPKGBinDirectory>
-    <VCPKGLibDirectory Condition="'\(Configuration)'=='Debug'">\$(VCPKGArchDirectory)\\debug\\lib</VCPKGLibDirectory>
-    <VCPKGBinDirectory Condition="'\(Configuration)'!='Debug'">\$(VCPKGArchDirectory)\\bin</VCPKGBinDirectory>
-    <VCPKGLibDirectory Condition="'\(Configuration)'!='Debug'">\$(VCPKGArchDirectory)\\lib</VCPKGLibDirectory>
+    <VCPKGBinDirectory Condition="'\$(Configuration)'=='Debug'">\$(VCPKGArchDirectory)\\debug\\bin</VCPKGBinDirectory>
+    <VCPKGLibDirectory Condition="'\$(Configuration)'=='Debug'">\$(VCPKGArchDirectory)\\debug\\lib</VCPKGLibDirectory>
+    <VCPKGBinDirectory Condition="'\$(Configuration)'!='Debug'">\$(VCPKGArchDirectory)\\bin</VCPKGBinDirectory>
+    <VCPKGLibDirectory Condition="'\$(Configuration)'!='Debug'">\$(VCPKGArchDirectory)\\lib</VCPKGLibDirectory>
     <VCPKGIncludeDirectory>\$(VCPKGArchDirectory)\\include</VCPKGIncludeDirectory>
-    <VCPKGLibs Condition="'\(Configuration)'=='Debug'">$libs_debug</VCPKGLibs>
-    <VCPKGLibs Condition="'\(Configuration)'!='Debug'">$libs_release</VCPKGLibs>
+    <VCPKGLibs Condition="'\$(Configuration)'=='Debug'">$libs_debug</VCPKGLibs>
+    <VCPKGLibs Condition="'\$(Configuration)'!='Debug'">$libs_release</VCPKGLibs>
   </PropertyGroup>
   <Import Project="\$(VCTargetsPath)\\Microsoft.Cpp.Default.props" />
   <PropertyGroup Condition="'\$(Configuration)'=='Debug'" Label="Configuration">
-- 
gitgitgadget
