Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-5.8 required=3.0 tests=BAYES_00,DKIM_ADSP_CUSTOM_MED,
	FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,HEADER_FROM_DIFFERENT_DOMAINS,
	RCVD_IN_DNSWL_HI,RP_MATCHES_RCVD shortcircuit=no autolearn=ham
	autolearn_force=no version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id A37071F4F8
	for <e@80x24.org>; Wed,  5 Oct 2016 14:54:58 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1754567AbcJEOyi (ORCPT <rfc822;e@80x24.org>);
        Wed, 5 Oct 2016 10:54:38 -0400
Received: from mail.javad.com ([54.86.164.124]:43256 "EHLO mail.javad.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1754207AbcJEOyh (ORCPT <rfc822;git@vger.kernel.org>);
        Wed, 5 Oct 2016 10:54:37 -0400
Received: from localhost6.localdomain6 (unknown [89.175.180.246])
        by mail.javad.com (Postfix) with ESMTPSA id 168AE633DE;
        Wed,  5 Oct 2016 14:46:28 +0000 (UTC)
Received: from localhost6.localdomain6 (localhost.localdomain [127.0.0.1])
        by localhost6.localdomain6 (8.14.4/8.14.4) with ESMTP id u95EkRnd020677;
        Wed, 5 Oct 2016 17:46:27 +0300
Received: (from osv@localhost)
        by localhost6.localdomain6 (8.14.4/8.14.4/Submit) id u95EkRhx020674;
        Wed, 5 Oct 2016 17:46:27 +0300
From:   sorganov@gmail.com
To:     git@vger.kernel.org
Cc:     gitster@pobox.com, Sergey Organov <sorganov@gmail.com>
Subject: [PATCH 3/6] Documentation/git-merge.txt: fix SYNOPSIS of obsolete form to include options
Date:   Wed,  5 Oct 2016 17:46:21 +0300
Message-Id: <daa9f1869b6c35b1b74ee9b43c4862439af42483.1475678515.git.sorganov@gmail.com>
X-Mailer: git-send-email 2.10.0.1.g57b01a3
In-Reply-To: <cover.1475678515.git.sorganov@gmail.com>
References: <cover.1475678515.git.sorganov@gmail.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

From: Sergey Organov <sorganov@gmail.com>

Signed-off-by: Sergey Organov <sorganov@gmail.com>
---
 Documentation/git-merge.txt | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/Documentation/git-merge.txt b/Documentation/git-merge.txt
index 90342eb..216d2f4 100644
--- a/Documentation/git-merge.txt
+++ b/Documentation/git-merge.txt
@@ -10,7 +10,7 @@ SYNOPSIS
 --------
 [verse]
 'git merge' [options] [-m <msg>] [<commit>...]
-'git merge' <msg> HEAD <commit>...
+'git merge' [options] <msg> HEAD <commit>...
 'git merge' --abort
 
 DESCRIPTION
-- 
2.10.0.1.g57b01a3

