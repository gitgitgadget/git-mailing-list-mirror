Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.2 (2018-09-13) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-4.3 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,RCVD_IN_DNSWL_HI
	shortcircuit=no autolearn=ham autolearn_force=no version=3.4.2
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 5BDA51F453
	for <e@80x24.org>; Mon, 21 Jan 2019 09:13:52 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727587AbfAUJNu (ORCPT <rfc822;e@80x24.org>);
        Mon, 21 Jan 2019 04:13:50 -0500
Received: from mail-ed1-f67.google.com ([209.85.208.67]:43218 "EHLO
        mail-ed1-f67.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727589AbfAUJNt (ORCPT <rfc822;git@vger.kernel.org>);
        Mon, 21 Jan 2019 04:13:49 -0500
Received: by mail-ed1-f67.google.com with SMTP id f9so15943746eds.10
        for <git@vger.kernel.org>; Mon, 21 Jan 2019 01:13:47 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=date:message-id:in-reply-to:references:from:subject:fcc
         :content-transfer-encoding:mime-version:to:cc;
        bh=Eiglx/ZyLaUkVeXKBevUQCRjAV8+UqPW2VxjNNLfegc=;
        b=OnJWvQmLMmrEHVF8kFk5aARb7xShyD9bGHiXVDccGnWCyPmL/IKqcuthjelsdwDDgs
         QnQu7DrM0DG+YCvObn0e3bfmkySaccs1rBf63pX2w809AOde4Z0DRv7TKAiuOVHqutDA
         H9cF0MeG9wWF25VQHlD2oFtnz9pvrhVo8zKlJaRy1LT4qSZx14FSlDo929XY7rqVgyHj
         MJCVkF9Szgvmphh1ENZRfREV9+FeUpQ+SQS3FYGnZaBy6pfxRir/v60icEEsVBFgRHsg
         2aXNrLRVZo+C3qROpoQnDGpXtKICDchAIAkto6x65OBLuV2E/ZUKHvDq1zO9KXvBSUu9
         5sRQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:message-id:in-reply-to:references:from
         :subject:fcc:content-transfer-encoding:mime-version:to:cc;
        bh=Eiglx/ZyLaUkVeXKBevUQCRjAV8+UqPW2VxjNNLfegc=;
        b=HVIQ5MA1tRGJRXqMbU0JoqTvw+rJiUA73+5vQ/Vk+md2JuTm9cJ2YfoO8OMMFOdYPA
         jgBCxUKYg+R0UI5MjeJO7qbYLDsdtHRSRY5WPwOX7x8wHJx7DGdDfmUcbnMohML/FKhz
         Yx2y1TdyryuK0wBzbdoUqwOLkumLjXDFiR7zJwcqgY32+dboNFDq5HBtUd7gpTB9CbZC
         gi636YwOpHErCs8MdDeelQ6lyUV6P1GbfE0Wlfp5IhBlSDGtruhyp6npJVUbHwLvfGgE
         mFD1RspzoUDRZ1ms3eIS73Z/4EpohDmTXtSHQ0sqIX2mHTjlibXCjcc++lCuZPgyhrot
         7bkw==
X-Gm-Message-State: AJcUukd6LHK565HrtdBKQsqjyP40MoTpYEFBtEOY96oqOMv+9w0Gxwsp
        Y9F0isGmKzg64YVCKfGngsuNYp9g
X-Google-Smtp-Source: ALg8bN4drJ9rggGdMZQ5qzf1M7lINKXpUVL9RYhu3KZMsJYooDbl7Xh3+5F3DT9TkzDdvG6mvfWFtQ==
X-Received: by 2002:a17:906:b1b:: with SMTP id u27-v6mr23740801ejg.67.1548062027106;
        Mon, 21 Jan 2019 01:13:47 -0800 (PST)
Received: from [127.0.0.1] ([13.74.141.28])
        by smtp.gmail.com with ESMTPSA id 24sm9082516eds.97.2019.01.21.01.13.46
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Mon, 21 Jan 2019 01:13:46 -0800 (PST)
Date:   Mon, 21 Jan 2019 01:13:46 -0800 (PST)
X-Google-Original-Date: Mon, 21 Jan 2019 09:13:39 GMT
Message-Id: <b9a1a7e37a477e978f19cbcc9b41f80519de54da.1548062019.git.gitgitgadget@gmail.com>
In-Reply-To: <pull.103.v3.git.gitgitgadget@gmail.com>
References: <pull.103.v2.git.gitgitgadget@gmail.com>
        <pull.103.v3.git.gitgitgadget@gmail.com>
From:   "Slavica Djukic via GitGitGadget" <gitgitgadget@gmail.com>
Subject: [PATCH v3 7/7] add--interactive.perl: use add--helper --show-help for
 help_cmd
Fcc:    Sent
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
MIME-Version: 1.0
To:     git@vger.kernel.org
Cc:     Phillip Wood <phillip.wood@dunelm.org.uk>,
        Junio C Hamano <gitster@pobox.com>,
        Slavica Djukic <slawica92@hotmail.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

From: Slavica Djukic <slawica92@hotmail.com>

Change help_cmd sub in git-add--interactive.perl to use
show-help command from builtin add--helper.

Signed-off-by: Slavica Djukic <slawica92@hotmail.com>
---
 git-add--interactive.perl | 11 +----------
 1 file changed, 1 insertion(+), 10 deletions(-)

diff --git a/git-add--interactive.perl b/git-add--interactive.perl
index a6536f9cf3..32ee729a58 100755
--- a/git-add--interactive.perl
+++ b/git-add--interactive.perl
@@ -1717,16 +1717,7 @@ sub quit_cmd {
 }
 
 sub help_cmd {
-# TRANSLATORS: please do not translate the command names
-# 'status', 'update', 'revert', etc.
-	print colored $help_color, __ <<'EOF' ;
-status        - show paths with changes
-update        - add working tree state to the staged set of changes
-revert        - revert staged set of changes back to the HEAD version
-patch         - pick hunks and update selectively
-diff          - view diff between HEAD and index
-add untracked - add contents of untracked files to the staged set of changes
-EOF
+	system(qw(git add--helper --show-help));
 }
 
 sub process_args {
-- 
gitgitgadget
