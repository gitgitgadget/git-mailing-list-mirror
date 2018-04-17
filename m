Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-3.3 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,RCVD_IN_DNSWL_HI
	shortcircuit=no autolearn=ham autolearn_force=no version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id A37391F404
	for <e@80x24.org>; Tue, 17 Apr 2018 19:16:04 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1752651AbeDQTQC (ORCPT <rfc822;e@80x24.org>);
        Tue, 17 Apr 2018 15:16:02 -0400
Received: from mail-wr0-f193.google.com ([209.85.128.193]:41100 "EHLO
        mail-wr0-f193.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1752699AbeDQTP4 (ORCPT <rfc822;git@vger.kernel.org>);
        Tue, 17 Apr 2018 15:15:56 -0400
Received: by mail-wr0-f193.google.com with SMTP id v24so21419696wra.8
        for <git@vger.kernel.org>; Tue, 17 Apr 2018 12:15:55 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=95P6vmGIT1aR10bmBkHqLaGyNKW9Z2uHU9Tb9UoPD8E=;
        b=St/qE229liBSN7+mGEPJqfhapLjYorswVOifnt2wsF0YBjTqKlPu8kd3nlctgtAKDI
         1x47rCh5I5Aqkhe/rubkvnRJ6/0+k/lwrxxbEXON3Dl34iLAOcKpO530oLeFAjyLWBhA
         kPK+nv2M0u17g8U1CtRIPBApHqaBhXeVAHvtDpvnx1Q0vZnBPZHQ71GDaZc2tiB1/Q8v
         IJwleKSFCPMLP4uxepq7TLwOwBYz1hYyBn9Yp/JKewkxbLCTw9HEj/CSgZ3UWfG7m9Ae
         Qm6cCuzBHrPpb0Ac8+FcOFXQCAOwYoqtW9WdTCg6X61ajmeyH0BBvrhLXpMMCXKjcOkn
         Z6Xw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=95P6vmGIT1aR10bmBkHqLaGyNKW9Z2uHU9Tb9UoPD8E=;
        b=sAe4zrlA2cya/sG4c6+HctD5spW4F18EGaxk2SJXh/Y6ixA3gFehCU3eaiA6ZIcuvv
         7XKxYaHkinyVtP4qJbOeOMgzhpdwS40pfkjOqCwY4pfrC3WZbKeq/jp9MYmzrzBvsJiU
         Cm8d1ad14mLtBlq5xgWRc8t/GIeFYrIFezowbdxrZnHxI/G8rV9QCNRnQGG8jnTMtLS3
         t8moAzfMteuFGo4isORG+AaJuvYcjpXrdlShz2L+JcH3F3gwB9nmVi3LPMJdNkT6fsUo
         sxoXD5y2cSM2Icx4lSIwX8hk4dFbWWG4rj35kTE5snvXhNZWBi7KKxmdDY+zaFEIG6t4
         wD7w==
X-Gm-Message-State: ALQs6tBcDuWZVg6mVWloW3mW4ljzXIhkcBvCXqB8ro9zdxt72qz4E1PJ
        by9pnw/v/CaaeT5/KPBo+0dmmv/9
X-Google-Smtp-Source: AIpwx4/WhlVgUhw8IJdmwdMYUz6JvZadKu9D7vYjTW0Nb4/DeFWNXYOup3kpGfGJHzeoE7Cv+DogFw==
X-Received: by 10.223.153.37 with SMTP id x34mr2644158wrb.29.1523992554589;
        Tue, 17 Apr 2018 12:15:54 -0700 (PDT)
Received: from localhost.localdomain ([2a02:aa16:5782:c100:c938:fbb7:46f8:2405])
        by smtp.gmail.com with ESMTPSA id m62sm2745398wmc.41.2018.04.17.12.15.53
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-SHA bits=128/128);
        Tue, 17 Apr 2018 12:15:53 -0700 (PDT)
From:   =?UTF-8?q?Martin=20=C3=85gren?= <martin.agren@gmail.com>
To:     git@vger.kernel.org
Cc:     Jeff King <peff@peff.net>
Subject: [PATCH 2/4] doc: convert [\--] to [--]
Date:   Tue, 17 Apr 2018 21:15:27 +0200
Message-Id: <7a9c99617b0cc03897bf1f02a21a14ee6509cf81.1523991648.git.martin.agren@gmail.com>
X-Mailer: git-send-email 2.17.0.252.gfe0a9eaf31
In-Reply-To: <cover.1523991648.git.martin.agren@gmail.com>
References: <CAN0heSru4-VoCTxZ6OHU_jdTs0__xvRmd45Dd0H3L8apMKkW6w@mail.gmail.com> <cover.1523991648.git.martin.agren@gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Commit 1c262bb7b (doc: convert \--option to --option, 2015-05-13)
explains that we used to need to write \--option to play well with older
versions of AsciiDoc, but that we do not support such versions anymore
anyway, and that Asciidoctor literally renders \--.

With [\--], which is used to denote the optional separator between
revisions and paths, Asciidoctor renders the backslash literally.
Change all [\--] to [--]. This changes nothing for AsciiDoc version
8.6.9, but is an improvement for Asciidoctor version 1.5.4.

We use double-dashes in several list entries (\--::). In my testing, it
appears that we do need to use the backslash there, so leave those.

Signed-off-by: Martin Ågren <martin.agren@gmail.com>
---
 Documentation/git-log.txt      | 4 ++--
 Documentation/git-shortlog.txt | 4 ++--
 Documentation/gitk.txt         | 2 +-
 3 files changed, 5 insertions(+), 5 deletions(-)

diff --git a/Documentation/git-log.txt b/Documentation/git-log.txt
index 5437f8b0f0..be2f10b70b 100644
--- a/Documentation/git-log.txt
+++ b/Documentation/git-log.txt
@@ -9,7 +9,7 @@ git-log - Show commit logs
 SYNOPSIS
 --------
 [verse]
-'git log' [<options>] [<revision range>] [[\--] <path>...]
+'git log' [<options>] [<revision range>] [[--] <path>...]
 
 DESCRIPTION
 -----------
@@ -90,7 +90,7 @@ include::line-range-format.txt[]
 	ways to spell <revision range>, see the 'Specifying Ranges'
 	section of linkgit:gitrevisions[7].
 
-[\--] <path>...::
+[--] <path>...::
 	Show only commits that are enough to explain how the files
 	that match the specified paths came to be.  See 'History
 	Simplification' below for details and other simplification
diff --git a/Documentation/git-shortlog.txt b/Documentation/git-shortlog.txt
index 5e35ea18ac..00a22152a2 100644
--- a/Documentation/git-shortlog.txt
+++ b/Documentation/git-shortlog.txt
@@ -8,7 +8,7 @@ git-shortlog - Summarize 'git log' output
 SYNOPSIS
 --------
 [verse]
-'git shortlog' [<options>] [<revision range>] [[\--] <path>...]
+'git shortlog' [<options>] [<revision range>] [[--] <path>...]
 git log --pretty=short | 'git shortlog' [<options>]
 
 DESCRIPTION
@@ -69,7 +69,7 @@ them.
 	ways to spell <revision range>, see the "Specifying Ranges"
 	section of linkgit:gitrevisions[7].
 
-[\--] <path>...::
+[--] <path>...::
 	Consider only commits that are enough to explain how the files
 	that match the specified paths came to be.
 +
diff --git a/Documentation/gitk.txt b/Documentation/gitk.txt
index ca96c281d1..244cd01493 100644
--- a/Documentation/gitk.txt
+++ b/Documentation/gitk.txt
@@ -8,7 +8,7 @@ gitk - The Git repository browser
 SYNOPSIS
 --------
 [verse]
-'gitk' [<options>] [<revision range>] [\--] [<path>...]
+'gitk' [<options>] [<revision range>] [--] [<path>...]
 
 DESCRIPTION
 -----------
-- 
2.17.0.252.gfe0a9eaf31

