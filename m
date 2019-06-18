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
	by dcvr.yhbt.net (Postfix) with ESMTP id 7D72F1F462
	for <e@80x24.org>; Tue, 18 Jun 2019 12:24:17 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729215AbfFRMYN (ORCPT <rfc822;e@80x24.org>);
        Tue, 18 Jun 2019 08:24:13 -0400
Received: from mail-ed1-f68.google.com ([209.85.208.68]:34288 "EHLO
        mail-ed1-f68.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725913AbfFRMYJ (ORCPT <rfc822;git@vger.kernel.org>);
        Tue, 18 Jun 2019 08:24:09 -0400
Received: by mail-ed1-f68.google.com with SMTP id s49so21513318edb.1
        for <git@vger.kernel.org>; Tue, 18 Jun 2019 05:24:08 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=date:message-id:in-reply-to:references:from:subject:fcc
         :content-transfer-encoding:mime-version:to:cc;
        bh=Lh8M4uuq6uxeqs7vyPbvNZQipnmzq/wt454JVAsQ5bo=;
        b=MGDYrtoWyzzRoZPnkIjPmaqf5tbD30avdyMMFf5GmGqr3tXbeBiEqvBJdthi8bLi1G
         M9/buV0hh2swhxvtsld40ahepDM/3pPZyHS5CFQiASMXuZZxxWCK6c5WztEpKHj+b+Sg
         +4FqXKo6uuphQOQULgi4+GZfgqOttvBT4Kpm6KB/ZvnrY1c8puFuDWJ6eHP0vC4dh2I6
         xm/4aSN8i1rQ6vgeYc2Bi2KEkCiQaHtzkjtv9IR5exhRpg1peBltnJevLUMePNzCTh4J
         /j5M76cvXA7cKoWT9XfcFWve8xfqpxz6di3diWvKYfNpPAFFLbuUkJdObAiyW8yw+SbP
         o5sA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:message-id:in-reply-to:references:from
         :subject:fcc:content-transfer-encoding:mime-version:to:cc;
        bh=Lh8M4uuq6uxeqs7vyPbvNZQipnmzq/wt454JVAsQ5bo=;
        b=Q9q01/BritJt6zDdC6otF67XKtPJ2XHjA9RUu/m5HS7TdnVau7UlOfr1Gk1SXLZQqX
         /vaTsyDJX5iKFiJGooHq5/fSnE4sBMYKjkBGGnDmhvHa9QQFAdNobJwcKaqDk7YXz+Ay
         A1FWP+CQbjdG1nt17ijUiRAUSPMTgFHHZc2QIg27YmySGd/Yn93B6yA/bHDmJTxrKTtn
         4uRD7aB9pqNHe0Z94Yy18l8qozN7ICxm51GMkZZ6o/FDSm4niyWbCLN6G5DKVEMURbL6
         3zvIwolHzsFsXuicgppQKgu3SQ9dFtdTm7pvBK+gm50KU10ZCVqPjB4qG3infX+YcZao
         0hbw==
X-Gm-Message-State: APjAAAXkChX99vYJxrywSA9FVmof09j9+mFsMZbUhufHO+iC5Yw6BJ0v
        3RVRdxwKVGjgKBz9tLE/cOakOwv5
X-Google-Smtp-Source: APXvYqwcw2+M/qC1nx/Qq5m9+ANp3gMQ/RWR7ipQ3GtcF5MTID3C/+qGZSp9xEZs/Hxj4XKKeK0Raw==
X-Received: by 2002:a50:9441:: with SMTP id q1mr97499491eda.41.1560860647675;
        Tue, 18 Jun 2019 05:24:07 -0700 (PDT)
Received: from [127.0.0.1] ([13.74.141.28])
        by smtp.gmail.com with ESMTPSA id z22sm4690357edz.6.2019.06.18.05.24.07
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Tue, 18 Jun 2019 05:24:07 -0700 (PDT)
Date:   Tue, 18 Jun 2019 05:24:07 -0700 (PDT)
X-Google-Original-Date: Tue, 18 Jun 2019 12:23:54 GMT
Message-Id: <0c7f5479bf6d88597a376d446a0673bf5d84a500.1560860634.git.gitgitgadget@gmail.com>
In-Reply-To: <pull.149.git.gitgitgadget@gmail.com>
References: <pull.149.git.gitgitgadget@gmail.com>
From:   "Jeff Hostetler via GitGitGadget" <gitgitgadget@gmail.com>
Subject: [PATCH 17/17] msvc: ignore .dll and incremental compile output
Fcc:    Sent
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
MIME-Version: 1.0
To:     git@vger.kernel.org
Cc:     Junio C Hamano <gitster@pobox.com>,
        Jeff Hostetler <jeffhost@microsoft.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

From: Jeff Hostetler <jeffhost@microsoft.com>

Ignore .dll files copied into the top-level directory.
Ignore MSVC incremental compiler output files.

Signed-off-by: Jeff Hostetler <jeffhost@microsoft.com>
Signed-off-by: Johannes Schindelin <johannes.schindelin@gmx.de>
---
 .gitignore | 5 +++++
 1 file changed, 5 insertions(+)

diff --git a/.gitignore b/.gitignore
index 2374f77a1a..ba0e52c4d1 100644
--- a/.gitignore
+++ b/.gitignore
@@ -226,6 +226,11 @@
 *.user
 *.idb
 *.pdb
+*.ilk
+*.iobj
+*.ipdb
+*.dll
+.vs/
 /Debug/
 /Release/
 *.dSYM
-- 
gitgitgadget
