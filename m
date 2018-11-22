Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.2 (2018-09-13) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-3.9 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,RCVD_IN_DNSWL_HI
	shortcircuit=no autolearn=ham autolearn_force=no version=3.4.2
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id D904A1F87F
	for <e@80x24.org>; Thu, 22 Nov 2018 23:06:25 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2439026AbeKWJsB (ORCPT <rfc822;e@80x24.org>);
        Fri, 23 Nov 2018 04:48:01 -0500
Received: from mail-wm1-f68.google.com ([209.85.128.68]:34195 "EHLO
        mail-wm1-f68.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S2439013AbeKWJsA (ORCPT <rfc822;git@vger.kernel.org>);
        Fri, 23 Nov 2018 04:48:00 -0500
Received: by mail-wm1-f68.google.com with SMTP id y185so6435205wmd.1
        for <git@vger.kernel.org>; Thu, 22 Nov 2018 15:06:20 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=TOL1w0BjCkT9kGjHI9tWKDJF2SRfghtPQI9KHJZm1iE=;
        b=THPMQ8tmArQwusydQHneaQXrhVJHE8CMNm9ZgdbXBvmhYmcgUlakkMvY4ka332+Rgf
         Rhf2vy71paVjmdCtjPzx9r7bqJYdu3fL9pGcidAtBeD2oNQakeA6+1ic2zAJevM2i9Ck
         nDo4vtcx0ycf8NA3EYQ3kTZs6ZhV/NQ95UwmUHHuzL49Q9/tga34x2X7d0/CKlhGbK3A
         D7YkOpI/XV2Nf4S7RaO9efwTJRpi8kJtMoOuLFmMy9x6NMkBJXqs1z09fZxAoRm1r74i
         59BlfEPALL3ntLiuGDP9RlWGD5p2cZ9uh/5e2WLfldobwoqfb1FiFu8z+S4UStDdR1rJ
         f8Fg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=TOL1w0BjCkT9kGjHI9tWKDJF2SRfghtPQI9KHJZm1iE=;
        b=EQ6Ids526TLq9t6kYLBE4fOni2QA0S5nNVi8iLIHQf3p+KD3dGoEog9cEhrq3EW77n
         nBqCI+6lqvc9iCwhZnczmmhr0+TINo1kTS/BgQOanky6YPvn2gMvjdhGlJB8tHgmtw3u
         bIj3zvb+wYfXiY4ST74HZYqIrbepNWsVTHhjCgc8D36Fw8+JWBKwOUWV8piuj7hnxc3L
         FQ/VW5ueg0N96ehK36z2rWk2LbhR/9qJdc43uV/vdG9A8aEOTjitkKGllRo1aVRSkfZZ
         0RUKiGyquMNu2KS1iIsSsKMW0jL7NufHFpCXiZEdEmwV/hcWmn+VjMOnk3g591chXmHf
         asLQ==
X-Gm-Message-State: AA+aEWbDOnc/z1TANNW3MsZ7N2NJuBhKyjAog9+UWQthST5ZxmaRhTiB
        WKEJACjwO0VH0Xh72FDc2MCt/gBh
X-Google-Smtp-Source: AFSGD/UYskqImvVcKOPMoKqaP1hzwTuIcrDV7Ym0Iyy1gUoqg5NtAOAUKiM/fEHrL7Ag6fb5SbgA9A==
X-Received: by 2002:a1c:8b42:: with SMTP id n63mr10946512wmd.38.1542927979470;
        Thu, 22 Nov 2018 15:06:19 -0800 (PST)
Received: from localhost.localdomain ([91.250.255.197])
        by smtp.gmail.com with ESMTPSA id v5sm11099670wrr.11.2018.11.22.15.06.18
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Thu, 22 Nov 2018 15:06:18 -0800 (PST)
From:   Paul-Sebastian Ungureanu <ungureanupaulsebastian@gmail.com>
To:     git@vger.kernel.org
Cc:     t.gummerer@gmail.com
Subject: [PATCH v11 08/22] stash: mention options in `show` synopsis
Date:   Fri, 23 Nov 2018 01:05:28 +0200
Message-Id: <4af795c07883b1e103a8999f4cbe32bd2db0cead.1542925164.git.ungureanupaulsebastian@gmail.com>
X-Mailer: git-send-email 2.19.1.878.g0482332a22
In-Reply-To: <cover.1542925164.git.ungureanupaulsebastian@gmail.com>
References: <cover.1542925164.git.ungureanupaulsebastian@gmail.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Mention in the documentation, that `show` accepts any
option known to `git diff`.

Signed-off-by: Paul-Sebastian Ungureanu <ungureanupaulsebastian@gmail.com>
---
 Documentation/git-stash.txt | 4 ++--
 1 file changed, 2 insertions(+), 2 deletions(-)

diff --git a/Documentation/git-stash.txt b/Documentation/git-stash.txt
index 7ef8c47911..e31ea7d303 100644
--- a/Documentation/git-stash.txt
+++ b/Documentation/git-stash.txt
@@ -9,7 +9,7 @@ SYNOPSIS
 --------
 [verse]
 'git stash' list [<options>]
-'git stash' show [<stash>]
+'git stash' show [<options>] [<stash>]
 'git stash' drop [-q|--quiet] [<stash>]
 'git stash' ( pop | apply ) [--index] [-q|--quiet] [<stash>]
 'git stash' branch <branchname> [<stash>]
@@ -106,7 +106,7 @@ stash@{1}: On master: 9cc0589... Add git-stash
 The command takes options applicable to the 'git log'
 command to control what is shown and how. See linkgit:git-log[1].
 
-show [<stash>]::
+show [<options>] [<stash>]::
 
 	Show the changes recorded in the stash entry as a diff between the
 	stashed contents and the commit back when the stash entry was first
-- 
2.19.1.878.g0482332a22

