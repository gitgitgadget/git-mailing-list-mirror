Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 5D859C4332F
	for <git@archiver.kernel.org>; Mon, 19 Dec 2022 14:12:50 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231871AbiLSOMt (ORCPT <rfc822;git@archiver.kernel.org>);
        Mon, 19 Dec 2022 09:12:49 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:55794 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231344AbiLSOMr (ORCPT <rfc822;git@vger.kernel.org>);
        Mon, 19 Dec 2022 09:12:47 -0500
Received: from mail-wr1-x42f.google.com (mail-wr1-x42f.google.com [IPv6:2a00:1450:4864:20::42f])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 7891164D7
        for <git@vger.kernel.org>; Mon, 19 Dec 2022 06:12:46 -0800 (PST)
Received: by mail-wr1-x42f.google.com with SMTP id h10so8763945wrx.3
        for <git@vger.kernel.org>; Mon, 19 Dec 2022 06:12:46 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=cc:to:mime-version:content-transfer-encoding:fcc:subject:date:from
         :message-id:from:to:cc:subject:date:message-id:reply-to;
        bh=4r6YnCTH6Xe8GPWFDApClR9NZO4XWcsNCY12Yd8bjPA=;
        b=P8m3W0YcdgvsZGitFPx0kBJ0zI8zKgB09Zaqkn0dhvYcHRqqxJmDR4o7hK/MhShtwx
         udgDqbNoU4lWW6+xVs4Ky/jYEcZEprGyhfOUZZSZfvm97nO96+tshanWCM1elcHkK2YB
         852Fg+ewv57VCCCHCZogkkSaUxH+br8XqhxQr75VjiTmlC67lP76QCEnJw30qn5Q7dnn
         fgcoPdpXnsSCFMuFg0DmxSv5YK2cX3zVWcqr3qAkOI2v/+1hXZyyj4oXW2qVD56jnmcm
         1k0ChaAc0lc4rgU4lPDkZVXZhRMM/nveTWTIDibDLvpWMDP4SD5nS1NY5wCphfGvKADc
         MgQA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=cc:to:mime-version:content-transfer-encoding:fcc:subject:date:from
         :message-id:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=4r6YnCTH6Xe8GPWFDApClR9NZO4XWcsNCY12Yd8bjPA=;
        b=fKEJQ9LUj+Dp9dGy8TuccwFaOaHpvbOoQmzDUrpY0aAXqFqWCuQg9iYptC/zsn8rP/
         KBlnKosa6KtE16RzfDEk4C9UKKdNHJ2ZVjHQ4EqInK6ZaPA74Q/8ZdPbx/V0bojK7ZUW
         N7bd+zQqxPombC9hOqKxIID22n1j53it7z2v/kbsOn1Zh7JuCiaRAytHSChdZCkD+e8Y
         DiUZfxNLg9JNtDFBQVIUxr8G/0tB7Qemtvd7Ny1hR6yj8CPGixJHFK8tQaDqtLzHbTy4
         qjEvwbRXFGY3vqfh26E+nuN4sdUShwpoh+PFOaAWXtg3xFVz1ZVC5xeSB4zGcIMf1lRS
         67EA==
X-Gm-Message-State: ANoB5plIK4wH9a1QbyRgIYuEx+v8Kbc/xCEGvkqOEYXvUJ/UfKfETp8V
        W8FYqDkvijGy2dkYlAoUiIpzUL+xvEA=
X-Google-Smtp-Source: AA0mqf5Hg9qW0LuxCnPAHfuSRM+gs8jySntmcO5nouXWQFaM0KD8zHBiHcLrOZTl57zTh2seTr7eTA==
X-Received: by 2002:a5d:4f92:0:b0:242:4c00:f544 with SMTP id d18-20020a5d4f92000000b002424c00f544mr27476302wru.45.1671459164597;
        Mon, 19 Dec 2022 06:12:44 -0800 (PST)
Received: from [127.0.0.1] ([13.74.141.28])
        by smtp.gmail.com with ESMTPSA id m2-20020a5d4a02000000b0022ae0965a8asm10203490wrq.24.2022.12.19.06.12.44
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 19 Dec 2022 06:12:44 -0800 (PST)
Message-Id: <pull.1401.git.git.1671459163559.gitgitgadget@gmail.com>
From:   "Rose via GitGitGadget" <gitgitgadget@gmail.com>
Date:   Mon, 19 Dec 2022 14:12:43 +0000
Subject: [PATCH] Remove redundant double exclamation points
Fcc:    Sent
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
MIME-Version: 1.0
To:     git@vger.kernel.org
Cc:     Rose <83477269+AtariDreams@users.noreply.github.com>,
        Seija Kijin <doremylover123@gmail.com>
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

From: Seija Kijin <doremylover123@gmail.com>

S_ISDIR is a macro that involves a "==" comparison.

This means the !! is redundant and not needed.

Signed-off-by: Seija Kijin <doremylover123@gmail.com>
---
    Remove redundant double exclamation points
    
    S_ISDIR is a macro that involves a "==" comparison.
    
    This means the !! is redundant and not needed.
    
    Signed-off-by: Seija Kijin doremylover123@gmail.com

Published-As: https://github.com/gitgitgadget/git/releases/tag/pr-git-1401%2FAtariDreams%2FIS_DIR-v1
Fetch-It-Via: git fetch https://github.com/gitgitgadget/git pr-git-1401/AtariDreams/IS_DIR-v1
Pull-Request: https://github.com/git/git/pull/1401

 tree-walk.c | 9 ++++-----
 1 file changed, 4 insertions(+), 5 deletions(-)

diff --git a/tree-walk.c b/tree-walk.c
index 74f4d710e8f..6b51d27ccb2 100644
--- a/tree-walk.c
+++ b/tree-walk.c
@@ -1040,9 +1040,9 @@ static enum interesting do_match(struct index_state *istate,
 		    ps->max_depth == -1)
 			return all_entries_interesting;
 		return within_depth(base->buf + base_offset, baselen,
-				    !!S_ISDIR(entry->mode),
-				    ps->max_depth) ?
-			entry_interesting : entry_not_interesting;
+				    S_ISDIR(entry->mode), ps->max_depth) ?
+			       entry_interesting :
+			       entry_not_interesting;
 	}
 
 	pathlen = tree_entry_len(entry);
@@ -1073,8 +1073,7 @@ static enum interesting do_match(struct index_state *istate,
 
 			if (within_depth(base_str + matchlen + 1,
 					 baselen - matchlen - 1,
-					 !!S_ISDIR(entry->mode),
-					 ps->max_depth))
+					 S_ISDIR(entry->mode), ps->max_depth))
 				goto interesting;
 			else
 				return entry_not_interesting;

base-commit: 7c2ef319c52c4997256f5807564523dfd4acdfc7
-- 
gitgitgadget
