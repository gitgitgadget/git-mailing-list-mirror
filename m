Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.2 (2018-09-13) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-4.2 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FROM,MAILING_LIST_MULTI,
	RCVD_IN_DNSWL_HI shortcircuit=no autolearn=ham autolearn_force=no
	version=3.4.2
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id DD2F41F405
	for <e@80x24.org>; Thu, 20 Dec 2018 19:45:00 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2389148AbeLTTo7 (ORCPT <rfc822;e@80x24.org>);
        Thu, 20 Dec 2018 14:44:59 -0500
Received: from mail-wm1-f65.google.com ([209.85.128.65]:51570 "EHLO
        mail-wm1-f65.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1729246AbeLTTo7 (ORCPT <rfc822;git@vger.kernel.org>);
        Thu, 20 Dec 2018 14:44:59 -0500
Received: by mail-wm1-f65.google.com with SMTP id b11so3255129wmj.1
        for <git@vger.kernel.org>; Thu, 20 Dec 2018 11:44:57 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=xDSWjKd21WaMX58/5uJjvAzuGhFStRiXxCB1dAbcSv4=;
        b=rotkJZg21CnJrPque8nISZ4c84Ph9bPf5jUwV0I2WGJE8hH8Zbzberr6Z+ra5+a738
         SufLcWZEd5+A6VHIFwC4liPIsQXewm9eTBynvH8a0lHkyRRZolE0oPkjRFpRmBTl9iiA
         5egXRCZNF/RQIvMmOYFF1KxUszdJRDAmQQON0FG0cQE1pcZVyfJ0Xqjope6CVQhHbfcq
         qExU5eL8dH6eWnflO6v3bDkBRzZXzOns5ld1XK9kj1KU2GOU+Z0HLY+wu5R8/odqrDAh
         TAyRXh+2YWUyydyjexqc43kKaIpBcN21aOy+4tA3/jLVJktmIcb10Muw4qE0lw47D0VV
         Fp3Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=xDSWjKd21WaMX58/5uJjvAzuGhFStRiXxCB1dAbcSv4=;
        b=XIV9+7Lx0Pib9UPPsd9UvOqHdhkfWV5l7xmmxk7ROIAbqLDx5y/fB3mwVaygi7JB7T
         66MZFkdhckYhiu+HgTxjBMvH1CHi67b0mJP3DMmu4b/FdRMdEOdKrakMFRNy16aHi3zW
         nAnWxS2aF4xbfwmQYt9qDXR48BGW2nZVOuQokd3glWLRRbw+06+urh0WqUAybCpL6NVi
         ORE/AagR0kqjitFJ1gX40HRhhNMB7Q5dvFUIyRiT4JLpfUqDO/m8h/MvE83nh3Boy3Pe
         FO+7Aq3G2IpZBOXXWXtITZZmsU4bbVNPf66PNd8q+kEFCatorYOgVJtuMMGSUhPAjbNy
         rLGA==
X-Gm-Message-State: AA+aEWYdblm88dHS2HCFvZg67GfMgcgP1Uhg2w4Uw+6z8TDnX9r1XCcv
        Hz2fo2E7uNV4zYMGEwNWNtdlb5SJj4o=
X-Google-Smtp-Source: AFSGD/XOrOOsuAEziSUVyT60P1miDuMq5wfTsAealQJBtQDcpWESVsErg1FqtKt9+OfPLc3pxu+nFg==
X-Received: by 2002:a1c:c58d:: with SMTP id v135mr16794wmf.88.1545335097102;
        Thu, 20 Dec 2018 11:44:57 -0800 (PST)
Received: from sebi-laptop.tendawifi.com ([188.24.227.76])
        by smtp.gmail.com with ESMTPSA id j129sm7587267wmb.39.2018.12.20.11.44.56
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Thu, 20 Dec 2018 11:44:56 -0800 (PST)
From:   Paul-Sebastian Ungureanu <ungureanupaulsebastian@gmail.com>
To:     git@vger.kernel.org
Cc:     t.gummerer@gmail.com, Johannes.Schindelin@gmx.de
Subject: [PATCH v12 09/26] stash: mention options in `show` synopsis
Date:   Thu, 20 Dec 2018 21:44:25 +0200
Message-Id: <1e187c54fcb13555e463c5b6f910b4bc13974e3e.1545331726.git.ungureanupaulsebastian@gmail.com>
X-Mailer: git-send-email 2.20.1.336.g43b67505b2.dirty
In-Reply-To: <cover.1545331726.git.ungureanupaulsebastian@gmail.com>
References: <cover.1545331726.git.ungureanupaulsebastian@gmail.com>
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
2.20.1.441.g764a526393

