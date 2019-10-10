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
	by dcvr.yhbt.net (Postfix) with ESMTP id 273771F4BD
	for <e@80x24.org>; Thu, 10 Oct 2019 10:06:45 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2388021AbfJJKGo (ORCPT <rfc822;e@80x24.org>);
        Thu, 10 Oct 2019 06:06:44 -0400
Received: from mail-wm1-f67.google.com ([209.85.128.67]:37222 "EHLO
        mail-wm1-f67.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S2387460AbfJJKGo (ORCPT <rfc822;git@vger.kernel.org>);
        Thu, 10 Oct 2019 06:06:44 -0400
Received: by mail-wm1-f67.google.com with SMTP id f22so6116881wmc.2
        for <git@vger.kernel.org>; Thu, 10 Oct 2019 03:06:42 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=date:message-id:in-reply-to:references:from:subject:fcc
         :content-transfer-encoding:mime-version:to:cc;
        bh=/DPFvaZWJ/NC5cjfDtzM1vqLJmKfZNGDZ0wt+iIQg9c=;
        b=grauLSiD+HwbeC+JgJdOG3ApokkzqL0yyz0pmtPPgQFSvIjXEqt3KlnSwM/CS+990l
         RxXMxyfUGOCWGHnioa4sfNiw6z8GYcpw6C+c39eVBb6559KlCpSTRE+9p1RAEehQ3CQS
         YU3eaSdWZrB8kFsofRpGSYNbWQmpbQXZbJdsiSS0skU3glX67899efpQFXDTFrp0JYdv
         SWYYo96t5eUaYmdE4BkIxxZfa3azByTxIp1HNFSH+Gk64G7pOyWLIHJV6p7tnExGr+j7
         0s31UmFfHuyojjvBkZFRJQEXZZQ8v/hGtNmHMqPmumq17nFoNbeI0ed+y8cOFVpB6eJw
         Zmmg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:message-id:in-reply-to:references:from
         :subject:fcc:content-transfer-encoding:mime-version:to:cc;
        bh=/DPFvaZWJ/NC5cjfDtzM1vqLJmKfZNGDZ0wt+iIQg9c=;
        b=LqwHpwrNWRdPyqcmmwlzTarYgg/PQGEw9hUEM3jbJM8PQ8svX0Z0UXgxtACk4QwPak
         erilchEWZtQ5Bh8F8KT6KHdsNzlz/MdgQ1HsfvxIADjysk2bYrHbkVKM/9PYzreTigH/
         0jVvaMCYFdMegcvRQHqCpZ+IahUpVcoG4qTDO/axJBuRJakYV7K7MR/F4IDygOH3Wnxs
         2iLQjNyZJjKSP8l4oUgYUIGqKoofdCCibMDjhmlq00k6ClmDa4gSwtXHye/7ZFGgpO9v
         B/IV2gjwau4wq86vQelr+nQusG7n99EnIPTRIS8rgiyqm17DQ24bRVSxe06+BYnZJash
         5JgQ==
X-Gm-Message-State: APjAAAWaWPbbI0wTrpmcOB9l2dgWxIl1ZxCnTZVaL4oVenWXRP6DmZQ2
        3sXITX+3cATSUMVe+ZerzhAIvKqp
X-Google-Smtp-Source: APXvYqxFIrbz+mxkTXkthQ3i9I8gm+dXuCBVACSg9dCOAi8HjPljbu7cZdhJj0mIgZBwyoyzjd9u9Q==
X-Received: by 2002:a7b:c098:: with SMTP id r24mr7142925wmh.8.1570702002119;
        Thu, 10 Oct 2019 03:06:42 -0700 (PDT)
Received: from [127.0.0.1] ([13.74.141.28])
        by smtp.gmail.com with ESMTPSA id f3sm5403454wrq.53.2019.10.10.03.06.41
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Thu, 10 Oct 2019 03:06:41 -0700 (PDT)
Date:   Thu, 10 Oct 2019 03:06:41 -0700 (PDT)
X-Google-Original-Date: Thu, 10 Oct 2019 10:06:40 GMT
Message-Id: <572c7d0c51ffc68dc4603752d05fa7a418dbdd71.1570702000.git.gitgitgadget@gmail.com>
In-Reply-To: <pull.384.git.gitgitgadget@gmail.com>
References: <pull.384.git.gitgitgadget@gmail.com>
From:   "Johannes Schindelin via GitGitGadget" <gitgitgadget@gmail.com>
Subject: [PATCH 1/1] doc(stash): clarify the description of `save`
Fcc:    Sent
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
MIME-Version: 1.0
To:     git@vger.kernel.org
Cc:     Johannes Schindelin <johannes.schindelin@gmx.de>,
        Junio C Hamano <gitster@pobox.com>,
        Johannes Schindelin <johannes.schindelin@gmx.de>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

From: Johannes Schindelin <johannes.schindelin@gmx.de>

The original phrasing of this paragraph made at least one person stumble
over the word "from" (thinking that it was a typo and "from" was
intended), and other readers chimed in, agreeing that it was confusing:
https://public-inbox.org/git/0102016b8d597569-c1f6cfdc-cb45-4428-8737-cb1bc30655d8-000000@eu-west-1.amazonses.com/#t

Let's rewrite that paragraph for clarity.

Inspired-by-a-patch-by: Catalin Criste <cris_linu_w@yahoo.com>
Signed-off-by: Johannes Schindelin <johannes.schindelin@gmx.de>
---
 Documentation/git-stash.txt | 5 +++--
 1 file changed, 3 insertions(+), 2 deletions(-)

diff --git a/Documentation/git-stash.txt b/Documentation/git-stash.txt
index 8fbe12c66c..53e1a1205d 100644
--- a/Documentation/git-stash.txt
+++ b/Documentation/git-stash.txt
@@ -87,8 +87,9 @@ The `--patch` option implies `--keep-index`.  You can use
 save [-p|--patch] [-k|--[no-]keep-index] [-u|--include-untracked] [-a|--all] [-q|--quiet] [<message>]::
 
 	This option is deprecated in favour of 'git stash push'.  It
-	differs from "stash push" in that it cannot take pathspecs,
-	and any non-option arguments form the message.
+	differs from "stash push" in that it cannot take pathspecs.
+	Instead, all non-option arguments are concatenated to form the stash
+	message.
 
 list [<options>]::
 
-- 
gitgitgadget
