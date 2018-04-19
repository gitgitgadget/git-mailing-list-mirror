Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-4.2 required=3.0 tests=AWL,BAYES_00,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,RCVD_IN_DNSWL_HI
	shortcircuit=no autolearn=ham autolearn_force=no version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 80F9F1F404
	for <e@80x24.org>; Thu, 19 Apr 2018 17:50:31 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1753228AbeDSRu2 (ORCPT <rfc822;e@80x24.org>);
        Thu, 19 Apr 2018 13:50:28 -0400
Received: from bsmtp7.bon.at ([213.33.87.19]:29442 "EHLO bsmtp7.bon.at"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1752887AbeDSRu1 (ORCPT <rfc822;git@vger.kernel.org>);
        Thu, 19 Apr 2018 13:50:27 -0400
Received: from dx.site (unknown [93.83.142.38])
        by bsmtp7.bon.at (Postfix) with ESMTPSA id 40RmjZ0TSVz5tlB;
        Thu, 19 Apr 2018 19:50:25 +0200 (CEST)
Received: from [IPv6:::1] (localhost [IPv6:::1])
        by dx.site (Postfix) with ESMTP id A6A5B11A;
        Thu, 19 Apr 2018 19:50:24 +0200 (CEST)
To:     Junio C Hamano <gitster@pobox.com>
Cc:     Git Mailing List <git@vger.kernel.org>
From:   Johannes Sixt <j6t@kdbg.org>
Subject: squash! Merge branch 'ps/test-chmtime-get'
Message-ID: <cb9ae7a4-88eb-9f74-1596-d24ed2dd4371@kdbg.org>
Date:   Thu, 19 Apr 2018 19:50:24 +0200
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:52.0) Gecko/20100101
 Thunderbird/52.7.0
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Junio,

you may want to squash this into your merge commit of branch
ps/test-chmtime-get (today it is fa57c0871fc9)

-- Hannes

diff --git a/t/helper/test-chmtime.c b/t/helper/test-chmtime.c
index daeddc1cbc..aa22af48c2 100644
--- a/t/helper/test-chmtime.c
+++ b/t/helper/test-chmtime.c
@@ -25,7 +25,7 @@
  *
  * To print only the mtime use --get:
  *
- *	test-chmtime --get file
+ *	test-tool chmtime --get file
  *
  * To set the mtime to current time:
  *
@@ -33,7 +33,7 @@
  *
  * To set the file mtime offset to +1 and print the new value:
  *
- *	test-chmtime --get +1 file
+ *	test-tool chmtime --get +1 file
  *
  */
 #include "test-tool.h"
