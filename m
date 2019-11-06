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
	by dcvr.yhbt.net (Postfix) with ESMTP id E44641F454
	for <e@80x24.org>; Wed,  6 Nov 2019 15:51:30 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1731957AbfKFPv0 (ORCPT <rfc822;e@80x24.org>);
        Wed, 6 Nov 2019 10:51:26 -0500
Received: from mail-wm1-f65.google.com ([209.85.128.65]:35953 "EHLO
        mail-wm1-f65.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1729021AbfKFPvZ (ORCPT <rfc822;git@vger.kernel.org>);
        Wed, 6 Nov 2019 10:51:25 -0500
Received: by mail-wm1-f65.google.com with SMTP id c22so3974970wmd.1
        for <git@vger.kernel.org>; Wed, 06 Nov 2019 07:51:23 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=message-id:in-reply-to:references:from:date:subject:fcc
         :content-transfer-encoding:mime-version:to:cc;
        bh=RRNHaoGxe6eBBfNch1ZwKlaup2UOYMeLEiymJFb8b/E=;
        b=OJDoZVnXvwA/KM+5jcOuu5Atj1im1KE43X3j1hZwxQlVrmdxWohwDLYZOBhvNGiku+
         GvUWPBuS11/5Dw/IDK3W4rq+Fjn2HmJUw9Osyb92RuR4xWmQkNZg/v5nyvt8b770hTon
         ShLTZNUZluhqANXn32CyMDpXMQ3rVmuJ7G/ojBkm2EzqLT0ZiuQfwQtavgVSJYrBt+BQ
         QmTA1y2EXFpVLYuyKwS3wStGNA2Dp4ZhSz0dMKBq0geV0xno79FaFIDSCGYnKCT+SjKP
         3ieZhooB93nwAhKxKJ/9cXQARKOL33fFE4ALRXykmuMlGCX3yQtOrb8pg1GDu4mk1wxj
         mGmQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:message-id:in-reply-to:references:from:date
         :subject:fcc:content-transfer-encoding:mime-version:to:cc;
        bh=RRNHaoGxe6eBBfNch1ZwKlaup2UOYMeLEiymJFb8b/E=;
        b=C62AWoE9cKj8oc3IYNLWDle3w4HeGpHgj9U87WYcYPFIa1PAJNhBB9JU08g5yUF4bU
         Ut8C3KtzutblfZVoK/cudkjRmXEE49yngM47htZuTbZimoLuA2SF870lz6BHVcriJLz/
         8ufGs10HxlPRihc/amD5EuSw/BkavCU7c2ltj38nUAQ8J3/X27r76Q2mYhSEuiHLKuVt
         wkAQ70U1tiYJpT0RnO0taJvJMoLekeH1HPYUBz08Br0QovtTl1NsOW5Yq/o9WHkcRNwJ
         61c/Ur1ZjyR5bviA9f5btTt8XM6quxSEa/NAMu0uxury9A5ikgD0jjYKjFHI1tTL0Fsn
         7ZPQ==
X-Gm-Message-State: APjAAAV5tkqVXkRWF4Yupb+StO0oP5C5wL6X7B23hj5YkJwGW2Mj/d0V
        bWOnOk0tmMPdl3icFXNjSrcPY+4F
X-Google-Smtp-Source: APXvYqy67/YMBudM2E6zXhrH0SPpHCP57IMa7PfwLXDu5IEcR4brq3Ih5DkXE/0/F5EGtOUJC8NHUA==
X-Received: by 2002:a05:600c:2253:: with SMTP id a19mr3137032wmm.97.1573055483272;
        Wed, 06 Nov 2019 07:51:23 -0800 (PST)
Received: from [127.0.0.1] ([13.74.141.28])
        by smtp.gmail.com with ESMTPSA id v10sm3530493wmg.48.2019.11.06.07.51.22
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Wed, 06 Nov 2019 07:51:22 -0800 (PST)
Message-Id: <20c4495fd31110c56cca84385bee6d1ab4a6f33e.1573055478.git.gitgitgadget@gmail.com>
In-Reply-To: <pull.445.v2.git.1573055478.gitgitgadget@gmail.com>
References: <pull.445.git.1572895605.gitgitgadget@gmail.com>
        <pull.445.v2.git.1573055478.gitgitgadget@gmail.com>
From:   "Alexandr Miloslavskiy via GitGitGadget" <gitgitgadget@gmail.com>
Date:   Wed, 06 Nov 2019 15:51:17 +0000
Subject: [PATCH v2 5/6] doc: commit: unify <pathspec> description
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

Synchronize it to `git add`, which has a pretty good description.
This also better disambiguates <file>... header.

Signed-off-by: Alexandr Miloslavskiy <alexandr.miloslavskiy@syntevo.com>
---
 Documentation/git-commit.txt | 16 +++++++++-------
 1 file changed, 9 insertions(+), 7 deletions(-)

diff --git a/Documentation/git-commit.txt b/Documentation/git-commit.txt
index afa7b75a23..915c212a0d 100644
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
@@ -345,12 +345,14 @@ changes to tracked files.
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
+For more details about the <pathspec> syntax, see the 'pathspec' entry
+in linkgit:gitglossary[7].
 
 :git-commit: 1
 include::date-formats.txt[]
-- 
gitgitgadget

