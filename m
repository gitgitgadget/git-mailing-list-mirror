Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.2 (2018-09-13) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-4.0 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,RCVD_IN_DNSWL_HI
	shortcircuit=no autolearn=ham autolearn_force=no version=3.4.2
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 80F3D1F461
	for <e@80x24.org>; Sun,  5 May 2019 16:24:39 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727719AbfEEQYi (ORCPT <rfc822;e@80x24.org>);
        Sun, 5 May 2019 12:24:38 -0400
Received: from mail-io1-f68.google.com ([209.85.166.68]:45485 "EHLO
        mail-io1-f68.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726524AbfEEQYh (ORCPT <rfc822;git@vger.kernel.org>);
        Sun, 5 May 2019 12:24:37 -0400
Received: by mail-io1-f68.google.com with SMTP id b3so3452579iob.12
        for <git@vger.kernel.org>; Sun, 05 May 2019 09:24:37 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=date:from:to:subject:message-id:references:mime-version
         :content-disposition:in-reply-to:user-agent;
        bh=CnrW+La4eX3HzQvomWyUA7+FYmydTRAfymlwknQqwvg=;
        b=MevF5D4+k4wF0Unh3vJBy/b7CIwyA3MDnzJ8dWJD9EDO+work6bndjhBnyurltAVZR
         p2RnTH3ryOaxK8L74qnCKS6nCQFpss/E/XxT1CbomFeyjDJ9U2U6zdmxwwQxFWlkxyFg
         ZALzZzuk/XNdsqpcm0qgZ/S352hnmgMTvyGNPa1fbPVsVW9H5WbGPECCkUCSh0k0EE0A
         HsTDi5oe94PN2QtTNF3UuCi17M5s+HXzaj/YlUtHNSaoq/kqGl+4gAGaDGfVCdPhWlRq
         eu5MWO7Ld7Q6bZpoANyyz12V9wEXv5++boA/aV5rpAMxgHfvyvW40dbRfdBaKBl05oNl
         LDdw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:subject:message-id:references
         :mime-version:content-disposition:in-reply-to:user-agent;
        bh=CnrW+La4eX3HzQvomWyUA7+FYmydTRAfymlwknQqwvg=;
        b=piHJk6AQlFCFHItj36dlI/nvX/vFy/Jp0MHHG5Mwb8gpjofQgXICOMV0jqUb3AYWeD
         Ud3BrXrypiCr5gsXwEHFt7quKuqk8KGONNrjLOKteKZUY2pr135KKrrErAEFjwQFEo/o
         bT9P0xcXHXe5/qv3QRjTLWUP2/GeZedG64oQRK/YjV0a/XuGGfq+fkrq0Khkw2VM1Egq
         hqGSxhjwXLceBgHuyor5Nfe8ePDsVzSfNvoCUHf/Lr8wfkmKNKLMMBk3DIXCP4bePu26
         lUGdl+CSkw6mmYe2e8b9iNZgytkCo4XSka8UhFFhfkzM9eAEANB1tPCOtsFgVVftusNT
         pGTw==
X-Gm-Message-State: APjAAAVG4v7OLtd2JvPyOLH5zSSecdlYm6Ld1I+fWFTgxyqO2ULDohcS
        NTfUReY9O++bgOY3ClDX3MSQB9Ui
X-Google-Smtp-Source: APXvYqyxEAzljjUkv71Uc8dIM0Uy0VbronHjB2V3y7LizmuR2wda+CskkMmkrHoev7JL1Ew5butYng==
X-Received: by 2002:a6b:bb82:: with SMTP id l124mr14923830iof.252.1557073476693;
        Sun, 05 May 2019 09:24:36 -0700 (PDT)
Received: from archbookpro.localdomain ([199.119.233.193])
        by smtp.gmail.com with ESMTPSA id n199sm3156314iod.54.2019.05.05.09.24.35
        for <git@vger.kernel.org>
        (version=TLS1_3 cipher=AEAD-AES256-GCM-SHA384 bits=256/256);
        Sun, 05 May 2019 09:24:35 -0700 (PDT)
Date:   Sun, 5 May 2019 12:24:33 -0400
From:   Denton Liu <liu.denton@gmail.com>
To:     Git Mailing List <git@vger.kernel.org>
Subject: [PATCH 2/7] Doc: add more detail for git-format-patch
Message-ID: <f0d972bf8fb6575550fef2fb9a94702c0ad69dea.1557072929.git.liu.denton@gmail.com>
References: <cover.1557072929.git.liu.denton@gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <cover.1557072929.git.liu.denton@gmail.com>
User-Agent: Mutt/1.11.4 (2019-03-13)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

In git-format-patch.txt, we were missing some key user information.
First of all, using the `--to` and `--cc` options don't override
`format.to` and `format.cc` variables, respectively. They add on to each
other. Document this.

In addition, document the special value of `--base=auto`.

Finally, while we're at it, surround option arguments with <>.

Signed-off-by: Denton Liu <liu.denton@gmail.com>
---
 Documentation/git-format-patch.txt | 17 +++++++++++------
 1 file changed, 11 insertions(+), 6 deletions(-)

diff --git a/Documentation/git-format-patch.txt b/Documentation/git-format-patch.txt
index 1af85d404f..7b71d4e2ed 100644
--- a/Documentation/git-format-patch.txt
+++ b/Documentation/git-format-patch.txt
@@ -17,9 +17,9 @@ SYNOPSIS
 		   [--signature-file=<file>]
 		   [-n | --numbered | -N | --no-numbered]
 		   [--start-number <n>] [--numbered-files]
-		   [--in-reply-to=Message-Id] [--suffix=.<sfx>]
+		   [--in-reply-to=<Message-Id>] [--suffix=.<sfx>]
 		   [--ignore-if-in-upstream]
-		   [--rfc] [--subject-prefix=Subject-Prefix]
+		   [--rfc] [--subject-prefix=<Subject-Prefix>]
 		   [(--reroll-count|-v) <n>]
 		   [--to=<email>] [--cc=<email>]
 		   [--[no-]cover-letter] [--quiet] [--notes[=<ref>]]
@@ -158,7 +158,7 @@ Beware that the default for 'git send-email' is to thread emails
 itself.  If you want `git format-patch` to take care of threading, you
 will want to ensure that threading is disabled for `git send-email`.
 
---in-reply-to=Message-Id::
+--in-reply-to=<Message-Id>::
 	Make the first mail (or all the mails with `--no-thread`) appear as a
 	reply to the given Message-Id, which avoids breaking threads to
 	provide a new patch series.
@@ -192,13 +192,17 @@ will want to ensure that threading is disabled for `git send-email`.
 
 --to=<email>::
 	Add a `To:` header to the email headers. This is in addition
-	to any configured headers, and may be used multiple times.
+	to any configured headers, and may be used multiple times. The
+	emails given will be used along with any emails given by
+	`format.to` configurations.
 	The negated form `--no-to` discards all `To:` headers added so
 	far (from config or command line).
 
 --cc=<email>::
 	Add a `Cc:` header to the email headers. This is in addition
-	to any configured headers, and may be used multiple times.
+	to any configured headers, and may be used multiple times. The
+	emails given will be used along with any emails given by
+	`format.cc` configurations.
 	The negated form `--no-cc` discards all `Cc:` headers added so
 	far (from config or command line).
 
@@ -309,7 +313,8 @@ you can use `--suffix=-patch` to get `0001-description-of-my-change-patch`.
 --base=<commit>::
 	Record the base tree information to identify the state the
 	patch series applies to.  See the BASE TREE INFORMATION section
-	below for details.
+	below for details. If <commit> is equal to "auto", a base commit
+	is automatically chosen.
 
 --root::
 	Treat the revision argument as a <revision range>, even if it
-- 
2.21.0.1049.geb646f7864

