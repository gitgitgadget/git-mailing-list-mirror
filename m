Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.2 (2018-09-13) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-3.2 required=3.0 tests=AWL,BAYES_00,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,
	RCVD_IN_BL_SPAMCOP_NET,RCVD_IN_DNSWL_HI shortcircuit=no autolearn=ham
	autolearn_force=no version=3.4.2
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id AC1A51F453
	for <e@80x24.org>; Fri, 18 Jan 2019 06:18:16 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727162AbfARGSI (ORCPT <rfc822;e@80x24.org>);
        Fri, 18 Jan 2019 01:18:08 -0500
Received: from fed1rmfepo202.cox.net ([68.230.241.147]:43594 "EHLO
        fed1rmfepo202.cox.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727081AbfARGSI (ORCPT <rfc822;git@vger.kernel.org>);
        Fri, 18 Jan 2019 01:18:08 -0500
Received: from fed1rmimpo305.cox.net ([68.230.241.173])
          by fed1rmfepo202.cox.net
          (InterMail vM.8.01.05.28 201-2260-151-171-20160122) with ESMTP
          id <20190118061807.YME4175.fed1rmfepo202.cox.net@fed1rmimpo305.cox.net>
          for <git@vger.kernel.org>; Fri, 18 Jan 2019 01:18:07 -0500
Received: from thunderbird.smith.home (localhost [127.0.0.1])
        by thunderbird.smith.home (Postfix) with ESMTP id 370CEB823FF;
        Thu, 17 Jan 2019 23:18:06 -0700 (MST)
X-CT-Class: Clean
X-CT-Score: 0.00
X-CT-RefID: str=0001.0A090204.5C416F9E.004E,ss=1,re=0.000,recu=0.000,reip=0.000,cl=1,cld=1,fgs=0
X-CT-Spam: 0
X-Authority-Analysis: v=2.3 cv=St8kF8G0 c=1 sm=1 tr=0
 a=BlDZPKRk22kUaIvSBqmi8w==:117 a=BlDZPKRk22kUaIvSBqmi8w==:17
 a=3JhidrIBZZsA:10 a=rLqZHZ4hS2wHbGYHrjMA:9
X-CM-Score: 0.00
Authentication-Results: cox.net; auth=pass (LOGIN) smtp.auth=ischis2@cox.net
From:   "Stephen P. Smith" <ischis2@cox.net>
To:     git@vger.kernel.org
Cc:     Linus Torvalds <torvalds@linux-foundation.org>,
        Junio C Hamano <gitster@pobox.com>,
        =?UTF-8?q?=C3=86var=20Arnfj=C3=B6r=C3=B0=20Bjarmason?= 
        <avarab@gmail.com>, Jeff King <peff@peff.net>,
        Philip Oakley <philipoakley@iee.org>,
        Johannes Sixt <j6t@kdbg.org>
Subject: [PATCH v2 0/5] Re-roll of 'human' date format patch set
Date:   Thu, 17 Jan 2019 23:18:00 -0700
Message-Id: <20190118061805.19086-1-ischis2@cox.net>
X-Mailer: git-send-email 2.20.1.2.gb21ebb671b
In-Reply-To: <20181231003150.8031-1-ischis2@cox.net>
References: <20181231003150.8031-1-ischis2@cox.net>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Reworked documentation and tests for the previously submitted patch set. 


Linus Torvalds (1):
  Add 'human' date format

Stephen P. Smith (4):
  Remove the proposed use of auto as secondary way to specify human
  Add 'human' date format documentation
  Add `human` format to test-tool
  Add `human` date format tests.

 Documentation/git-log.txt          |   4 +
 Documentation/rev-list-options.txt |   6 ++
 builtin/blame.c                    |   4 +
 cache.h                            |   3 +
 date.c                             | 153 +++++++++++++++++++++++++----
 t/helper/test-date.c               |  15 +++
 t/t0006-date.sh                    |  20 ++++
 7 files changed, 185 insertions(+), 20 deletions(-)

-- 
2.20.1.2.gb21ebb671b

