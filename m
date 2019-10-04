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
	by dcvr.yhbt.net (Postfix) with ESMTP id 49BFC1F4BD
	for <e@80x24.org>; Fri,  4 Oct 2019 15:09:38 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2389739AbfJDPJh (ORCPT <rfc822;e@80x24.org>);
        Fri, 4 Oct 2019 11:09:37 -0400
Received: from mail-wr1-f66.google.com ([209.85.221.66]:34259 "EHLO
        mail-wr1-f66.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S2389570AbfJDPJf (ORCPT <rfc822;git@vger.kernel.org>);
        Fri, 4 Oct 2019 11:09:35 -0400
Received: by mail-wr1-f66.google.com with SMTP id j11so1879524wrp.1
        for <git@vger.kernel.org>; Fri, 04 Oct 2019 08:09:34 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=date:message-id:in-reply-to:references:from:subject:fcc
         :content-transfer-encoding:mime-version:to:cc;
        bh=BFyAjQnd1YVfz2Ku67xIMyrmgwG0vlKeKxSQ3lSdH1M=;
        b=dJt8jWnpGQnIHh8eSdPfyXCH1rkMb6vW4+o1jxjJyqGH67M54UulgaMILTsii6R2Gr
         b+TGWH9cnaCsOlQpKWg59js6er5YfG8I/PhUN5zuagJh6AzXiY3NzIEZmRCSjYQSs9eX
         yS7mkC3VSq3Ld9qbDG4/bAp8H4GZ6AlXbGa6fW8iGdn9McLxKIt2tVNPbqoNo48RLMy3
         GZcq+SaKMUmzczdFYiRWizJE9UDUlxSZ1sIQXl7i8j/axKsDDoZHA4zkHiNSQEMrRLq2
         ZTuJGTmyH3bKYSS2hAApIFbgs+WJlWCgY0ODB8mtYHbgLx9/A9I4jZbQ1wuMvH2RpNRO
         IelA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:message-id:in-reply-to:references:from
         :subject:fcc:content-transfer-encoding:mime-version:to:cc;
        bh=BFyAjQnd1YVfz2Ku67xIMyrmgwG0vlKeKxSQ3lSdH1M=;
        b=mXR47EfQiZhUDTkWG/KTUDvOGllRgq/d0rZ4dwBlLxEMfkiZlnQDCdX8XKunSWXT8u
         XU7uwURJFtD2gy42F7TD3jnXITeU0m3oJFyuMyuYqvb/lKRJCTjOadSJ7bBga7lkX1XZ
         2EUDAt06nn+MVaZfJF0k8JMnAkC3eL708ZmDOpDcGprq7m+ETs7bQbonuX2a836OD0RZ
         Fmxskj7w0PDAZErlf6qSmqKEnxoGRDitS+ja9OE3xwxFbzi3jht/SvQaAiyS871QB3dD
         984D84Or9vtLBPPNYrDC3RVHI8C52WhKwvCILdSnAUm5JOLtJGPelHn4TLEJSGxTWfFR
         JhOg==
X-Gm-Message-State: APjAAAUqM0SaIO2p3jtiMMqqZEvaNtbgXOdQ1QSijaleRrJf/yfB6QdX
        Z7Yh0Zz1QKiN9SVw/v+tkFq4XqUL
X-Google-Smtp-Source: APXvYqzZMIH530qCAmUCk9ann0EiHh4Ej5t3YLO8KL2ABmBu15dcrSnzpoBuET7YOnpDZvBUKcd27w==
X-Received: by 2002:a5d:4102:: with SMTP id l2mr12657496wrp.348.1570201773187;
        Fri, 04 Oct 2019 08:09:33 -0700 (PDT)
Received: from [127.0.0.1] ([13.74.141.28])
        by smtp.gmail.com with ESMTPSA id r12sm7214416wrq.88.2019.10.04.08.09.32
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Fri, 04 Oct 2019 08:09:32 -0700 (PDT)
Date:   Fri, 04 Oct 2019 08:09:32 -0700 (PDT)
X-Google-Original-Date: Fri, 04 Oct 2019 15:09:18 GMT
Message-Id: <e6e60b3c2b878d90b96c227c10f432375051144e.1570201763.git.gitgitgadget@gmail.com>
In-Reply-To: <pull.288.v3.git.gitgitgadget@gmail.com>
References: <pull.288.v2.git.gitgitgadget@gmail.com>
        <pull.288.v3.git.gitgitgadget@gmail.com>
From:   "Johannes Schindelin via GitGitGadget" <gitgitgadget@gmail.com>
Subject: [PATCH v3 09/13] vcxproj: include more generated files
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

