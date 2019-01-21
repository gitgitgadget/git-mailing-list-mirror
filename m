Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.2 (2018-09-13) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-3.1 required=3.0 tests=AWL,BAYES_00,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,
	RCVD_IN_BL_SPAMCOP_NET,RCVD_IN_DNSWL_HI shortcircuit=no autolearn=ham
	autolearn_force=no version=3.4.2
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 11D081F453
	for <e@80x24.org>; Mon, 21 Jan 2019 07:13:52 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728273AbfAUHNu (ORCPT <rfc822;e@80x24.org>);
        Mon, 21 Jan 2019 02:13:50 -0500
Received: from fed1rmfepi102.cox.net ([68.230.241.133]:43375 "EHLO
        fed1rmfepi102.cox.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727600AbfAUHNK (ORCPT <rfc822;git@vger.kernel.org>);
        Mon, 21 Jan 2019 02:13:10 -0500
Received: from fed1rmimpo110.cox.net ([68.230.241.159])
          by fed1rmfepo201.cox.net
          (InterMail vM.8.01.05.28 201-2260-151-171-20160122) with ESMTP
          id <20190121053113.YCBP4108.fed1rmfepo201.cox.net@fed1rmimpo110.cox.net>
          for <git@vger.kernel.org>; Mon, 21 Jan 2019 00:31:13 -0500
Received: from thunderbird.smith.home (localhost [127.0.0.1])
        by thunderbird.smith.home (Postfix) with ESMTP id 9FE25B822FF;
        Sun, 20 Jan 2019 22:31:12 -0700 (MST)
X-CT-Class: Clean
X-CT-Score: 0.00
X-CT-RefID: str=0001.0A090206.5C455921.0024,ss=1,re=0.000,recu=0.000,reip=0.000,cl=1,cld=1,fgs=0
X-CT-Spam: 0
X-Authority-Analysis: v=2.3 cv=QvfqIm6d c=1 sm=1 tr=0
 a=BlDZPKRk22kUaIvSBqmi8w==:117 a=BlDZPKRk22kUaIvSBqmi8w==:17
 a=3JhidrIBZZsA:10 a=WDhBSedXqNQA:10 a=ltCLdVDSFtViIcOt-c4A:9
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
Subject: [PATCH v3 0/5] Re-roll of 'human' date format patch set
Date:   Sun, 20 Jan 2019 22:31:07 -0700
Message-Id: <20190121053112.4736-1-ischis2@cox.net>
X-Mailer: git-send-email 2.20.1.2.gb21ebb671b
In-Reply-To: <20190118061805.19086-1-ischis2@cox.net>
References: <20190118061805.19086-1-ischis2@cox.net>
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
  Replace the proposed 'auto' mode with 'auto:'
  Add 'human' date format documentation
  Add `human` format to test-tool
  Add `human` date format tests.

 Documentation/git-log.txt          |   4 +
 Documentation/rev-list-options.txt |   7 ++
 builtin/blame.c                    |   4 +
 cache.h                            |   3 +
 date.c                             | 148 ++++++++++++++++++++++++-----
 t/helper/test-date.c               |  11 +++
 t/t0006-date.sh                    |  18 ++++
 7 files changed, 173 insertions(+), 22 deletions(-)

-- 
2.20.1.2.gb21ebb671b

