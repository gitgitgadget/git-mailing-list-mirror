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
	by dcvr.yhbt.net (Postfix) with ESMTP id 42B2E1F463
	for <e@80x24.org>; Thu, 26 Sep 2019 08:30:28 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729092AbfIZIaY (ORCPT <rfc822;e@80x24.org>);
        Thu, 26 Sep 2019 04:30:24 -0400
Received: from mail-lj1-f193.google.com ([209.85.208.193]:38402 "EHLO
        mail-lj1-f193.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1728638AbfIZIaW (ORCPT <rfc822;git@vger.kernel.org>);
        Thu, 26 Sep 2019 04:30:22 -0400
Received: by mail-lj1-f193.google.com with SMTP id b20so1232850ljj.5
        for <git@vger.kernel.org>; Thu, 26 Sep 2019 01:30:21 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=date:message-id:in-reply-to:references:from:subject:fcc
         :content-transfer-encoding:mime-version:to:cc;
        bh=BFyAjQnd1YVfz2Ku67xIMyrmgwG0vlKeKxSQ3lSdH1M=;
        b=QHaf/zpB5j9ml/Wr78i/OZ9IyJWckNfDuxOo4MdDGv+x4LO2lJP/dboV5cwAQmFavA
         Q3tvakkQdIjbqHA3WGNLlZaH0r9akbo9OFx+VkFc2L8s6CYmI8cVh0Fc486e2zNe1E6/
         9UfyIJUfqBPVmb68+3IhPbodKuqkNIV8+9zs2P/426GNv0hBWgzUj4RhC6xlDk4F8omb
         YDrHF0EyXr9ObcQI7MX2wQL3vjzO3zLRQ9+bx/Efv9sEdebFT4OxQqzKM7GPgHENj6+3
         vTN6GPhXtLhT0uyF7wVBFo/Y88QZLi8vY9Ja9+YJ3gUA40ZKBW77NMyD+DYKTnuAGD4X
         IA2g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:message-id:in-reply-to:references:from
         :subject:fcc:content-transfer-encoding:mime-version:to:cc;
        bh=BFyAjQnd1YVfz2Ku67xIMyrmgwG0vlKeKxSQ3lSdH1M=;
        b=jQmKAZTijyY5kZ19BhQyxuHdfttPx5H57ZDAvskJi7Iv9NN4NNktsHUjZdKP5tgIt+
         ymWVA48EJvSaTFMuGLUBObPbtu0SdTKzkqulD4Mp1dTkA6ym7wKer8j5xuIPitUUiU1u
         et9YtgtueqPXlB07MwA14RYicgJHi1GPgS5TnQByuhFRNMLOPEHlrLP4NcX6mNxjjhZB
         RsKIkBKkNQFopZxwWHw2nFHlMwIYuP2vHVBBs72HmeV0ictDVwmb1Mng7Bu8oh6OXwq+
         KLmpvHRsDI6EF3xmvx40wU5oesQG2s5zjwhJt1IxJWmyiNoFGLTeCChqf3zpd1j1kVOE
         vP4w==
X-Gm-Message-State: APjAAAX9ARWcA5NVieEaOJF9D7fHUFXpzWTGqF413pc5MMNL/i8afmcV
        zHyVaY7ij/E3YUovP0m2k8qn11fz
X-Google-Smtp-Source: APXvYqyUgz0MQfHLJrrJ3MPwqb8pGLOEIbeLMKVIZnJDGXaBQyRbqLMwZ/Q4T2JpHfor4Pd+q7F92w==
X-Received: by 2002:a2e:a17b:: with SMTP id u27mr1698002ljl.65.1569486620481;
        Thu, 26 Sep 2019 01:30:20 -0700 (PDT)
Received: from [127.0.0.1] ([13.74.141.28])
        by smtp.gmail.com with ESMTPSA id n3sm381655lfl.62.2019.09.26.01.30.19
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Thu, 26 Sep 2019 01:30:20 -0700 (PDT)
Date:   Thu, 26 Sep 2019 01:30:20 -0700 (PDT)
X-Google-Original-Date: Thu, 26 Sep 2019 08:30:02 GMT
Message-Id: <6adfc63e98b481c25dc45ed96caeaeb20a70f9fa.1569486607.git.gitgitgadget@gmail.com>
In-Reply-To: <pull.288.git.gitgitgadget@gmail.com>
References: <pull.288.git.gitgitgadget@gmail.com>
From:   "Johannes Schindelin via GitGitGadget" <gitgitgadget@gmail.com>
Subject: [PATCH 09/13] vcxproj: include more generated files
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

In the CI builds, we bundle all generated files into a so-called
artifacts `.tar` file, so that the test phase can fan out into multiple
parallel builds.

This patch makes sure that all files are included in the `vcxproj`
target which are needed for that artifacts `.tar` file.

Signed-off-by: Johannes Schindelin <johannes.schindelin@gmx.de>
---
 config.mak.uname | 9 ++++++---
 1 file changed, 6 insertions(+), 3 deletions(-)

diff --git a/config.mak.uname b/config.mak.uname
index 701aad62b1..cc8efd95b1 100644
--- a/config.mak.uname
+++ b/config.mak.uname
@@ -728,11 +728,10 @@ vcxproj:
 
 	# Add scripts
 	rm -f perl/perl.mak
-	$(MAKE) MSVC=1 SKIP_VCPKG=1 prefix=/mingw64 \
-		$(SCRIPT_LIB) $(SCRIPT_SH_GEN) $(SCRIPT_PERL_GEN)
+	$(MAKE) MSVC=1 SKIP_VCPKG=1 prefix=/mingw64 $(SCRIPT_LIB) $(SCRIPTS)
 	# Strip out the sane tool path, needed only for building
 	sed -i '/^git_broken_path_fix ".*/d' git-sh-setup
-	git add -f $(SCRIPT_LIB) $(SCRIPT_SH_GEN) $(SCRIPT_PERL_GEN)
+	git add -f $(SCRIPT_LIB) $(SCRIPTS)
 
 	# Add Perl module
 	$(MAKE) $(LIB_PERL_GEN)
@@ -762,6 +761,10 @@ vcxproj:
 	$(MAKE) -C templates
 	git add -f templates/boilerplates.made templates/blt/
 
+	# Add the translated messages
+	make MSVC=1 SKIP_VCPKG=1 prefix=/mingw64 $(MOFILES)
+	git add -f $(MOFILES)
+
 	# Add build options
 	$(MAKE) MSVC=1 SKIP_VCPKG=1 prefix=/mingw64 GIT-BUILD-OPTIONS
 	git add -f GIT-BUILD-OPTIONS
-- 
gitgitgadget

