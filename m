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
	by dcvr.yhbt.net (Postfix) with ESMTP id 46A6F1F463
	for <e@80x24.org>; Mon, 30 Sep 2019 09:55:49 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1730652AbfI3Jzr (ORCPT <rfc822;e@80x24.org>);
        Mon, 30 Sep 2019 05:55:47 -0400
Received: from mail-wm1-f65.google.com ([209.85.128.65]:51909 "EHLO
        mail-wm1-f65.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1730585AbfI3Jzj (ORCPT <rfc822;git@vger.kernel.org>);
        Mon, 30 Sep 2019 05:55:39 -0400
Received: by mail-wm1-f65.google.com with SMTP id 7so12644366wme.1
        for <git@vger.kernel.org>; Mon, 30 Sep 2019 02:55:38 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=date:message-id:in-reply-to:references:from:subject:fcc
         :content-transfer-encoding:mime-version:to:cc;
        bh=BFyAjQnd1YVfz2Ku67xIMyrmgwG0vlKeKxSQ3lSdH1M=;
        b=QYECFhulFRAGq7AzT4h07VU+FHZiWxxdqTjtfUDOaVpWBDEQFytQCgB2E151MhJ+9f
         qHw6J7970E1ioiTMG5rQFDjgcVjstgXVg7zSa1RZ6zWrS6qUbxEFd34jleI7ztX1IXQP
         yDJHkJHYeRIyGGEKyEWlDTA+eVGX6TbMb2Jmvp7BEgL9pLXDB85fiuBoeZRO73QMKN62
         mDZF4p1IzVUuH0R0NbT0p5XoBRAjU8ozUQS/hAuMwVz5rop8nRtKuXG/UbexJVvdZ7WM
         z2r/ATo0lG4B1WXHgQxiKUvA+NoOrqx7m6x3NEgadQ3mtRZz4ShJSi7E2lOVN4hcL2Qj
         xDmg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:message-id:in-reply-to:references:from
         :subject:fcc:content-transfer-encoding:mime-version:to:cc;
        bh=BFyAjQnd1YVfz2Ku67xIMyrmgwG0vlKeKxSQ3lSdH1M=;
        b=U90JqCHmqIIHh9MzyV+WnkyazPu8/TNFt/v9GQv1ZKgvx71yQER4/3t1Jkh6evNagb
         a85LkG8Vkd9mRVPmtu3AElEti1p1HsrEmU+bMIMHiwFnIt6CBSSr5hTGITBRORnGRKim
         lGOjkDrocg1fToEtp0wmCRHBE0g5JOsipHA3DzTunRJiO9tzCrpmxLv+FRlS8xrGILxI
         rHyt82qT0wo33DQopDA1q7zXAnWnnTPQKEnCMHkW2FFCQQfqJGDHfh8RzVHACTEEZrMT
         x3EMUOPnuriVZWyjz5JkXfTgZWyFBtF9BiigjMY0xnKAoGM3Aj65w+W2A+F9hl7Fjl6S
         at+A==
X-Gm-Message-State: APjAAAWxMFr6FyQSHfG2StujMDtx3JjxABz9lQwe7/XogsONsPIJIXcm
        r0V4mI2HVnMiCk6Xvtkyiluf8Feb
X-Google-Smtp-Source: APXvYqyFyMqX7oVw77t6ft+h7+PMbCU9xJvcLlImK84VTtmIv21UGEESgKIoEUoZVcswUNBrfVHVNQ==
X-Received: by 2002:a7b:cf38:: with SMTP id m24mr14892154wmg.24.1569837337331;
        Mon, 30 Sep 2019 02:55:37 -0700 (PDT)
Received: from [127.0.0.1] ([13.74.141.28])
        by smtp.gmail.com with ESMTPSA id x16sm9016792wrl.32.2019.09.30.02.55.36
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Mon, 30 Sep 2019 02:55:36 -0700 (PDT)
Date:   Mon, 30 Sep 2019 02:55:36 -0700 (PDT)
X-Google-Original-Date: Mon, 30 Sep 2019 09:55:25 GMT
Message-Id: <38ccf999e786a4abfda1f88301c224b75baade6c.1569837330.git.gitgitgadget@gmail.com>
In-Reply-To: <pull.288.v2.git.gitgitgadget@gmail.com>
References: <pull.288.git.gitgitgadget@gmail.com>
        <pull.288.v2.git.gitgitgadget@gmail.com>
From:   "Johannes Schindelin via GitGitGadget" <gitgitgadget@gmail.com>
Subject: [PATCH v2 09/13] vcxproj: include more generated files
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

