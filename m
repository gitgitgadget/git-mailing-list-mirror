Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.1 (2015-04-28) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-4.0 required=3.0 tests=BAYES_00,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,RCVD_IN_DNSWL_HI
	shortcircuit=no autolearn=ham autolearn_force=no version=3.4.1
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id E3FE41F516
	for <e@80x24.org>; Wed, 27 Jun 2018 09:07:46 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S933872AbeF0JHo convert rfc822-to-8bit (ORCPT
        <rfc822;e@80x24.org>); Wed, 27 Jun 2018 05:07:44 -0400
Received: from mx2.excelsior.ru ([80.66.89.230]:14118 "EHLO mx2.excelsior.ru"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S932187AbeF0JHm (ORCPT <rfc822;git@vger.kernel.org>);
        Wed, 27 Jun 2018 05:07:42 -0400
X-Greylist: delayed 581 seconds by postgrey-1.27 at vger.kernel.org; Wed, 27 Jun 2018 05:07:42 EDT
Received: from mx2.excelsior (localhost [127.0.0.1])
        by mx2.excelsior.ru (Postfix) with ESMTP id 3837BB828;
        Wed, 27 Jun 2018 16:57:49 +0800 (KRAST)
Received: from mx2.excelsior.ru ([127.0.0.1])
        by mx2.excelsior (mx2.excelsior.ru [127.0.0.1]) (amavisd-new, port 10024)
        with ESMTP id NhF9H4zP9j79; Wed, 27 Jun 2018 16:57:43 +0800 (KRAST)
Received: from mail.excelsior (mail.excelsior [192.168.0.2])
        by mx2.excelsior.ru (Postfix) with ESMTP;
        Wed, 27 Jun 2018 16:57:43 +0800 (KRAST)
content-class: urn:content-classes:message
MIME-Version: 1.0
Content-Type: text/plain;
        charset="us-ascii"
Content-Transfer-Encoding: 8BIT
X-MimeOLE: Produced By Microsoft Exchange V6.0.6603.0
Subject: [PATCH] rebase: fix documentation formatting
Date:   Wed, 27 Jun 2018 15:57:43 +0700
Message-ID: <DE671AEE06C994438C1F64DBF4C85FA753C1D3@mail.excelsior>
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
Thread-Topic: [PATCH] rebase: fix documentation formatting
Thread-Index: AdQN9OhzIdtTzIIwThO25Rk+bvOYew==
From:   "Vladimir Parfinenko" <vparfinenko@excelsior-usa.com>
To:     <git@vger.kernel.org>
Cc:     <johannes.schindelin@gmx.de>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Last sections are squashed into non-formatted block after adding
"REBASING MERGES".
To reproduce the error see bottom of page:
https://git-scm.com/docs/git-rebase

Signed-off-by: Vladimir Parfinenko <vparfinenko@excelsior-usa.com>
---
 Documentation/git-rebase.txt | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/Documentation/git-rebase.txt b/Documentation/git-rebase.txt
index bd5ecff98..6fe98165d 100644
--- a/Documentation/git-rebase.txt
+++ b/Documentation/git-rebase.txt
@@ -804,7 +804,7 @@ The ripple effect of a "hard case" recovery is
especially bad:
 case" recovery too!

 REBASING MERGES
------------------
+---------------

 The interactive rebase command was originally designed to handle
 individual patch series. As such, it makes sense to exclude merge
--
2.18.0.windows.1

