Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-5.8 required=3.0 tests=BAYES_00,DKIM_ADSP_CUSTOM_MED,
	FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,HEADER_FROM_DIFFERENT_DOMAINS,
	RCVD_IN_DNSWL_HI,RP_MATCHES_RCVD shortcircuit=no autolearn=ham
	autolearn_force=no version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 173AB1F4F8
	for <e@80x24.org>; Wed,  5 Oct 2016 14:54:59 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1754598AbcJEOyu (ORCPT <rfc822;e@80x24.org>);
        Wed, 5 Oct 2016 10:54:50 -0400
Received: from mail.javad.com ([54.86.164.124]:43257 "EHLO mail.javad.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1754412AbcJEOyh (ORCPT <rfc822;git@vger.kernel.org>);
        Wed, 5 Oct 2016 10:54:37 -0400
Received: from localhost6.localdomain6 (unknown [89.175.180.246])
        by mail.javad.com (Postfix) with ESMTPSA id 33822633DF;
        Wed,  5 Oct 2016 14:46:29 +0000 (UTC)
Received: from localhost6.localdomain6 (localhost.localdomain [127.0.0.1])
        by localhost6.localdomain6 (8.14.4/8.14.4) with ESMTP id u95EkRBl020683;
        Wed, 5 Oct 2016 17:46:27 +0300
Received: (from osv@localhost)
        by localhost6.localdomain6 (8.14.4/8.14.4/Submit) id u95EkRKC020680;
        Wed, 5 Oct 2016 17:46:27 +0300
From:   sorganov@gmail.com
To:     git@vger.kernel.org
Cc:     gitster@pobox.com, Sergey Organov <sorganov@gmail.com>
Subject: [PATCH 4/6] Documentation/git-merge.txt: improve short description in NAME
Date:   Wed,  5 Oct 2016 17:46:22 +0300
Message-Id: <a33dd3ec3da0dc2dad72ed85edd29ff01f898831.1475678515.git.sorganov@gmail.com>
X-Mailer: git-send-email 2.10.0.1.g57b01a3
In-Reply-To: <cover.1475678515.git.sorganov@gmail.com>
References: <cover.1475678515.git.sorganov@gmail.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

From: Sergey Organov <sorganov@gmail.com>

Old description not only raised the question of why the tool is called
git-merge rather than git-join, but "join histories" also sounds like
very simple operation, something like what "git-merge -s ours" does.

Signed-off-by: Sergey Organov <sorganov@gmail.com>
---
 Documentation/git-merge.txt | 3 ++-
 1 file changed, 2 insertions(+), 1 deletion(-)

diff --git a/Documentation/git-merge.txt b/Documentation/git-merge.txt
index 216d2f4..cc0329d 100644
--- a/Documentation/git-merge.txt
+++ b/Documentation/git-merge.txt
@@ -3,7 +3,8 @@ git-merge(1)
 
 NAME
 ----
-git-merge - Join two or more development histories together
+
+git-merge - Merge one or more branches to the current branch
 
 
 SYNOPSIS
-- 
2.10.0.1.g57b01a3

