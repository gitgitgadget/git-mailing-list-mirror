Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.2 (2018-09-13) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-3.9 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,RCVD_IN_DNSWL_HI,
	SPF_HELO_NONE,SPF_NONE shortcircuit=no autolearn=ham
	autolearn_force=no version=3.4.2
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 5AE0F1F4B5
	for <e@80x24.org>; Tue, 19 Nov 2019 16:49:04 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728419AbfKSQtD (ORCPT <rfc822;e@80x24.org>);
        Tue, 19 Nov 2019 11:49:03 -0500
Received: from mail-wm1-f66.google.com ([209.85.128.66]:36246 "EHLO
        mail-wm1-f66.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1728353AbfKSQtC (ORCPT <rfc822;git@vger.kernel.org>);
        Tue, 19 Nov 2019 11:49:02 -0500
Received: by mail-wm1-f66.google.com with SMTP id c22so4540627wmd.1
        for <git@vger.kernel.org>; Tue, 19 Nov 2019 08:49:01 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=message-id:in-reply-to:references:from:date:subject:fcc
         :content-transfer-encoding:mime-version:to:cc;
        bh=jFwdsXIw10GWaJMKJTmYGPbaQki7xSpz/S6SI98raT0=;
        b=eLDjodH7rQMbR9PNdeLYJwnxRNQyGPOjkST1omy6TTK49jKcwyPG2R4m/uy9ChbvvX
         Ca1TCsT8zFeoAbakC0uw7oW80/u7KuwdKjp5Etmdo1Lp9vC7qhogAdDuXiv3Zjz2KfZb
         Fz2xhO86Zw+J7St/9TWwQmYAgyM12mUVqDMU1mg8tu88V4tuu3nU1yQLGw0Ulnak/DUE
         1jN0+neUKyMZvjAKQcaRXXigZXz+YO0P25lWUxh7wKM0JpPcHZ2Z31GHhHV5etlvobqI
         7cFEh5QQK4L6JV5P6cuAbo0cwbxCcebakuOT6nMOBmVd96RrSlTNn/UyUjk0IrjP6Uri
         HpAw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:message-id:in-reply-to:references:from:date
         :subject:fcc:content-transfer-encoding:mime-version:to:cc;
        bh=jFwdsXIw10GWaJMKJTmYGPbaQki7xSpz/S6SI98raT0=;
        b=CoDuQ18HWM3tx33hZPkayf9sxP7djcoW58i5CWaRnQ+ba0xvqGgunmbMDS5Bge8X88
         s5+66zkVhQWSJYrpiE2Z+MCz73OZgR2PfL36qmiOMuV2pcvRR3HWogw0A00zl1iLdbXZ
         mxx+5TyYAWZis9x+LN4jrbtMFR7Kj/Ke6gzoEPHwt/FSlBwEvcVeC0hrwh9tIItkIoYB
         T08DYEfYveioyYse3QRGAjht17z6uNdaXuvFOLdPn0iuOLte9wv6QGTr/BKcK4GqIcBa
         kWjwEFYyQkxzdUl/L273DILgG7h7i3Q9/Ei4gejb2lepc8D5HiIbZgIP+PMPRysTFG6G
         6lWg==
X-Gm-Message-State: APjAAAWuiaP0Ztovkamfnms7iawK2oZrLhtDsDoZzHqOxWMfG1B1a/YL
        h2gCbgdNMEsaBx32HZWrfAiQgYLH/nQ=
X-Google-Smtp-Source: APXvYqyswOz7iCJCybpHr2/0XxOoN4GhWkj4NkY48DX/059k/pNunrrnFEnnXMweFkRh6gJjY7S9SQ==
X-Received: by 2002:a1c:2dd0:: with SMTP id t199mr6692705wmt.58.1574182140649;
        Tue, 19 Nov 2019 08:49:00 -0800 (PST)
Received: from [127.0.0.1] ([13.74.141.28])
        by smtp.gmail.com with ESMTPSA id j66sm3447075wma.19.2019.11.19.08.49.00
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Tue, 19 Nov 2019 08:49:00 -0800 (PST)
Message-Id: <0b79797e772b25c6caa22bd9761837062e7265de.1574182135.git.gitgitgadget@gmail.com>
In-Reply-To: <pull.445.v3.git.1574182135.gitgitgadget@gmail.com>
References: <pull.445.v2.git.1573055478.gitgitgadget@gmail.com>
        <pull.445.v3.git.1574182135.gitgitgadget@gmail.com>
From:   "Alexandr Miloslavskiy via GitGitGadget" <gitgitgadget@gmail.com>
Date:   Tue, 19 Nov 2019 16:48:54 +0000
Subject: [PATCH v3 5/6] doc: commit: synchronize <pathspec> description
Fcc:    Sent
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
MIME-Version: 1.0
To:     git@vger.kernel.org
Cc:     Alexandr Miloslavskiy <alexandr.miloslavskiy@syntevo.com>,
        Junio C Hamano <gitster@pobox.com>,
        Alexandr Miloslavskiy <alexandr.miloslavskiy@syntevo.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

From: Alexandr Miloslavskiy <alexandr.miloslavskiy@syntevo.com>

`git add` shows an example of good writing, follow it.
This also better disambiguates <file>... header.

Signed-off-by: Alexandr Miloslavskiy <alexandr.miloslavskiy@syntevo.com>
---
 Documentation/git-commit.txt | 15 ++++++++-------
 1 file changed, 8 insertions(+), 7 deletions(-)

diff --git a/Documentation/git-commit.txt b/Documentation/git-commit.txt
index afa7b75a23..a0c44978ee 100644
--- a/Documentation/git-commit.txt
+++ b/Documentation/git-commit.txt
@@ -13,7 +13,7 @@ SYNOPSIS
 	   [-F <file> | -m <msg>] [--reset-author] [--allow-empty]
 	   [--allow-empty-message] [--no-verify] [-e] [--author=<author>]
 	   [--date=<date>] [--cleanup=<mode>] [--[no-]status]
-	   [-i | -o] [-S[<keyid>]] [--] [<file>...]
+	   [-i | -o] [-S[<keyid>]] [--] [<pathspec>...]
 
 DESCRIPTION
 -----------
@@ -345,12 +345,13 @@ changes to tracked files.
 \--::
 	Do not interpret any more arguments as options.
 
-<file>...::
-	When files are given on the command line, the command
-	commits the contents of the named files, without
-	recording the changes already staged.  The contents of
-	these files are also staged for the next commit on top
-	of what have been staged before.
+<pathspec>...::
+	When pathspec is given on the command line, commit the contents of
+	the files that match the pathspec without recording the changes
+	already added to the index. The contents of these files are also
+	staged for the next commit on top of what have been staged before.
++
+For more details, see the 'pathspec' entry in linkgit:gitglossary[7].
 
 :git-commit: 1
 include::date-formats.txt[]
-- 
gitgitgadget

