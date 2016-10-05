Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-5.8 required=3.0 tests=AWL,BAYES_00,
	DKIM_ADSP_CUSTOM_MED,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_HI,RP_MATCHES_RCVD
	shortcircuit=no autolearn=ham autolearn_force=no version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id E15BD20987
	for <e@80x24.org>; Wed,  5 Oct 2016 14:54:58 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1754594AbcJEOyp (ORCPT <rfc822;e@80x24.org>);
        Wed, 5 Oct 2016 10:54:45 -0400
Received: from mail.javad.com ([54.86.164.124]:43263 "EHLO mail.javad.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1754558AbcJEOyi (ORCPT <rfc822;git@vger.kernel.org>);
        Wed, 5 Oct 2016 10:54:38 -0400
Received: from localhost6.localdomain6 (unknown [89.175.180.246])
        by mail.javad.com (Postfix) with ESMTPSA id D50F8633DC;
        Wed,  5 Oct 2016 14:46:28 +0000 (UTC)
Received: from localhost6.localdomain6 (localhost.localdomain [127.0.0.1])
        by localhost6.localdomain6 (8.14.4/8.14.4) with ESMTP id u95EkRkV020665;
        Wed, 5 Oct 2016 17:46:27 +0300
Received: (from osv@localhost)
        by localhost6.localdomain6 (8.14.4/8.14.4/Submit) id u95EkRjq020662;
        Wed, 5 Oct 2016 17:46:27 +0300
From:   sorganov@gmail.com
To:     git@vger.kernel.org
Cc:     gitster@pobox.com, Sergey Organov <sorganov@gmail.com>
Subject: [PATCH 1/6] git-merge: clarify "usage" by adding "-m <msg>"
Date:   Wed,  5 Oct 2016 17:46:19 +0300
Message-Id: <773a11751c91c31a05c967ade902b0c8279aab56.1475678515.git.sorganov@gmail.com>
X-Mailer: git-send-email 2.10.0.1.g57b01a3
In-Reply-To: <cover.1475678515.git.sorganov@gmail.com>
References: <cover.1475678515.git.sorganov@gmail.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

From: Sergey Organov <sorganov@gmail.com>

"-m <msg>" is one of essential distinctions between obsolete
invocation form and the recent one. Add it to the "usage" returned by
'git merge -h' for more clarity.

Signed-off-by: Sergey Organov <sorganov@gmail.com>
---
 builtin/merge.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/builtin/merge.c b/builtin/merge.c
index a8b57c7..0e367ba 100644
--- a/builtin/merge.c
+++ b/builtin/merge.c
@@ -43,7 +43,7 @@ struct strategy {
 };
 
 static const char * const builtin_merge_usage[] = {
-	N_("git merge [<options>] [<commit>...]"),
+	N_("git merge [<options>] [-m <msg>] [<commit>...]"),
 	N_("git merge [<options>] <msg> HEAD <commit>"),
 	N_("git merge --abort"),
 	NULL
-- 
2.10.0.1.g57b01a3

