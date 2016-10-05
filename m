Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-5.8 required=3.0 tests=BAYES_00,DKIM_ADSP_CUSTOM_MED,
	FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,HEADER_FROM_DIFFERENT_DOMAINS,
	RCVD_IN_DNSWL_HI,RP_MATCHES_RCVD shortcircuit=no autolearn=ham
	autolearn_force=no version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 30A911F4F8
	for <e@80x24.org>; Wed,  5 Oct 2016 14:54:41 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1754570AbcJEOyj (ORCPT <rfc822;e@80x24.org>);
        Wed, 5 Oct 2016 10:54:39 -0400
Received: from mail.javad.com ([54.86.164.124]:43255 "EHLO mail.javad.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1754328AbcJEOyh (ORCPT <rfc822;git@vger.kernel.org>);
        Wed, 5 Oct 2016 10:54:37 -0400
Received: from localhost6.localdomain6 (unknown [89.175.180.246])
        by mail.javad.com (Postfix) with ESMTPSA id F0F51633DD;
        Wed,  5 Oct 2016 14:46:28 +0000 (UTC)
Received: from localhost6.localdomain6 (localhost.localdomain [127.0.0.1])
        by localhost6.localdomain6 (8.14.4/8.14.4) with ESMTP id u95EkRaf020671;
        Wed, 5 Oct 2016 17:46:27 +0300
Received: (from osv@localhost)
        by localhost6.localdomain6 (8.14.4/8.14.4/Submit) id u95EkRCB020668;
        Wed, 5 Oct 2016 17:46:27 +0300
From:   sorganov@gmail.com
To:     git@vger.kernel.org
Cc:     gitster@pobox.com, Sergey Organov <sorganov@gmail.com>
Subject: [PATCH 2/6] Documentation/git-merge.txt: remove list of options from SYNOPSIS
Date:   Wed,  5 Oct 2016 17:46:20 +0300
Message-Id: <fa4e150ab54f9a01b4b7ca496dfe514d5e106ff6.1475678515.git.sorganov@gmail.com>
X-Mailer: git-send-email 2.10.0.1.g57b01a3
In-Reply-To: <cover.1475678515.git.sorganov@gmail.com>
References: <cover.1475678515.git.sorganov@gmail.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

From: Sergey Organov <sorganov@gmail.com>

This partial list of option is confusing as it lacks a lot of
available options. It also clutters the SYNOPSIS making differences
between forms of invocation less clear.

Signed-off-by: Sergey Organov <sorganov@gmail.com>
---
 Documentation/git-merge.txt | 5 +----
 1 file changed, 1 insertion(+), 4 deletions(-)

diff --git a/Documentation/git-merge.txt b/Documentation/git-merge.txt
index b758d55..90342eb 100644
--- a/Documentation/git-merge.txt
+++ b/Documentation/git-merge.txt
@@ -9,10 +9,7 @@ git-merge - Join two or more development histories together
 SYNOPSIS
 --------
 [verse]
-'git merge' [-n] [--stat] [--no-commit] [--squash] [--[no-]edit]
-	[-s <strategy>] [-X <strategy-option>] [-S[<keyid>]]
-	[--[no-]allow-unrelated-histories]
-	[--[no-]rerere-autoupdate] [-m <msg>] [<commit>...]
+'git merge' [options] [-m <msg>] [<commit>...]
 'git merge' <msg> HEAD <commit>...
 'git merge' --abort
 
-- 
2.10.0.1.g57b01a3

