Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.2 (2018-09-13) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-4.1 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,RCVD_IN_DNSWL_HI
	shortcircuit=no autolearn=ham autolearn_force=no version=3.4.2
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 0683F20248
	for <e@80x24.org>; Fri,  8 Mar 2019 09:58:08 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726465AbfCHJ6H (ORCPT <rfc822;e@80x24.org>);
        Fri, 8 Mar 2019 04:58:07 -0500
Received: from mail-pg1-f193.google.com ([209.85.215.193]:39548 "EHLO
        mail-pg1-f193.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726249AbfCHJ6G (ORCPT <rfc822;git@vger.kernel.org>);
        Fri, 8 Mar 2019 04:58:06 -0500
Received: by mail-pg1-f193.google.com with SMTP id h8so13754960pgp.6
        for <git@vger.kernel.org>; Fri, 08 Mar 2019 01:58:06 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=oY4m1rDywqrzKL3MclyC4FP+Qqwi+3WY55Y+/4HlDYA=;
        b=N/kse91ayZHS9tIafrR9/GNNICec5XE1SFHfbrQ/CkNUlZSJ/Y2SV4TSUhbRCWBKCu
         +ufZW/jsYmj/iShEyV8PdmsERJDkLLiMjFworPQm8og4dwc9e9cOMQmxITBGvNanjG7r
         LdYWoZhY26YXJ5lqFE1lppbXOXQnBVvfrmYFx+41DdxjQhaWjqCjbS/CvdAvduTEUwx2
         RkTH6Ys5exoVII6xTBg6O4Skep6fnzmX/Sq7bUWMjS/DM40sedyCB7Gk2e/DsSJ+29ZI
         5mMSuJYN7Dq11mXFqM9qIqvcMz9G0pVCh0wpIlunmB3Vvve9as+iJx8fh08uIbTMMMmN
         5GAg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=oY4m1rDywqrzKL3MclyC4FP+Qqwi+3WY55Y+/4HlDYA=;
        b=XJ7QwWxsLsIxbEArhw30UDgS3sBi9eTG3sNtrtBCOsZWQHwH9Nxnh3id2KPOURehwF
         DEnq8ImAKcjBieMwYcZqgI6Y900lUFtyG46ujUTXdzvoo/4s9juGMgdUU3KISp21mpMW
         9aj9C5JjCXSXZ507FWDVAhcmSu8vYAG0ajqc+K0A53AyvI31RxeRnS+HKi5FDXT7ZgE2
         RQT1fSeaLnVvB2wtJbthUjqcakYOp/H1yZet7Tse0KRMrwlVfTnvmGG4GXarpsMNBsx8
         ljCaU19pDr4ipmHFuFwp4zMUDu2cPmiyp+gC23lV9cpn4qLADylUdjcwrKEUCo3jaMmh
         nz3Q==
X-Gm-Message-State: APjAAAXh3UHhp+/lQTPIje6mPUcJRlh4bxZ0CjYPEQbT42K07+0x51iL
        8yK9F2xinm8GuTytmQ8FEEPd1R6X
X-Google-Smtp-Source: APXvYqwuVen2XFrvg7kDEIjo/MMkBAozAjUJXlCmI/EyPN2Xfzgk7IZrcDsCDQMM6NoodMo29YW61Q==
X-Received: by 2002:a65:6149:: with SMTP id o9mr15827930pgv.315.1552039085270;
        Fri, 08 Mar 2019 01:58:05 -0800 (PST)
Received: from ash ([171.226.148.85])
        by smtp.gmail.com with ESMTPSA id k27sm9405863pgb.70.2019.03.08.01.58.02
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Fri, 08 Mar 2019 01:58:04 -0800 (PST)
Received: by ash (sSMTP sendmail emulation); Fri, 08 Mar 2019 16:57:59 +0700
From:   =?UTF-8?q?Nguy=E1=BB=85n=20Th=C3=A1i=20Ng=E1=BB=8Dc=20Duy?= 
        <pclouds@gmail.com>
To:     pclouds@gmail.com
Cc:     git@vger.kernel.org, gitster@pobox.com, sunshine@sunshineco.com,
        szeder.dev@gmail.com
Subject: [PATCH v3 01/21] git-checkout.txt: spell out --no-option
Date:   Fri,  8 Mar 2019 16:57:32 +0700
Message-Id: <20190308095752.8574-2-pclouds@gmail.com>
X-Mailer: git-send-email 2.21.0.rc1.337.gdf7f8d0522
In-Reply-To: <20190308095752.8574-1-pclouds@gmail.com>
References: <20190208090401.14793-1-pclouds@gmail.com>
 <20190308095752.8574-1-pclouds@gmail.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

It's easier to search for and also less cryptic.
---
 Documentation/git-checkout.txt | 11 +++++++----
 1 file changed, 7 insertions(+), 4 deletions(-)

diff --git a/Documentation/git-checkout.txt b/Documentation/git-checkout.txt
index f179b43732..99c8c0dc0f 100644
--- a/Documentation/git-checkout.txt
+++ b/Documentation/git-checkout.txt
@@ -118,7 +118,8 @@ OPTIONS
 --quiet::
 	Quiet, suppress feedback messages.
 
---[no-]progress::
+--progress::
+--no-progress::
 	Progress status is reported on the standard error stream
 	by default when it is attached to a terminal, unless `--quiet`
 	is specified. This flag enables progress reporting even if not
@@ -262,7 +263,7 @@ edits from your current working tree. See the ``Interactive Mode''
 section of linkgit:git-add[1] to learn how to operate the `--patch` mode.
 +
 Note that this option uses the no overlay mode by default (see also
-`--[no-]overlay`), and currently doesn't support overlay mode.
+`--overlay`), and currently doesn't support overlay mode.
 
 --ignore-other-worktrees::
 	`git checkout` refuses when the wanted ref is already checked
@@ -270,7 +271,8 @@ Note that this option uses the no overlay mode by default (see also
 	out anyway. In other words, the ref can be held by more than one
 	worktree.
 
---[no-]recurse-submodules::
+--recurse-submodules::
+--no-recurse-submodules::
 	Using --recurse-submodules will update the content of all initialized
 	submodules according to the commit recorded in the superproject. If
 	local modifications in a submodule would be overwritten the checkout
@@ -283,7 +285,8 @@ Note that this option uses the no overlay mode by default (see also
 	Do not attempt to create a branch if a remote tracking branch
 	of the same name exists.
 
---[no-]overlay::
+--overlay::
+--no-overlay::
 	In the default overlay mode, `git checkout` never
 	removes files from the index or the working tree.  When
 	specifying `--no-overlay`, files that appear in the index and
-- 
2.21.0.rc1.337.gdf7f8d0522

