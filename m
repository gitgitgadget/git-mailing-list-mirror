Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.1 (2015-04-28) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-3.9 required=3.0 tests=AWL,BAYES_00,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,RCVD_IN_DNSWL_HI
	shortcircuit=no autolearn=ham autolearn_force=no version=3.4.1
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 25CE61F453
	for <e@80x24.org>; Tue, 23 Oct 2018 03:53:44 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727075AbeJWMPL (ORCPT <rfc822;e@80x24.org>);
        Tue, 23 Oct 2018 08:15:11 -0400
Received: from fed1rmfepo202.cox.net ([68.230.241.147]:46256 "EHLO
        fed1rmfepo202.cox.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726438AbeJWMPL (ORCPT <rfc822;git@vger.kernel.org>);
        Tue, 23 Oct 2018 08:15:11 -0400
Received: from fed1rmimpo110.cox.net ([68.230.241.159])
          by fed1rmfepo202.cox.net
          (InterMail vM.8.01.05.28 201-2260-151-171-20160122) with ESMTP
          id <20181023035342.FEID21918.fed1rmfepo202.cox.net@fed1rmimpo110.cox.net>
          for <git@vger.kernel.org>; Mon, 22 Oct 2018 23:53:42 -0400
Received: from thunderbird.smith.home ([68.2.114.239])
        by fed1rmimpo110.cox.net with cox
        id qrth1y00B59yGBo01rthmQ; Mon, 22 Oct 2018 23:53:42 -0400
X-CT-Class: Clean
X-CT-Score: 0.00
X-CT-RefID: str=0001.0A090207.5BCE9B46.000E,ss=1,re=0.000,recu=0.000,reip=0.000,cl=1,cld=1,fgs=0
X-CT-Spam: 0
X-Authority-Analysis: v=2.3 cv=f4j8+96M c=1 sm=1 tr=0
 a=BlDZPKRk22kUaIvSBqmi8w==:117 a=BlDZPKRk22kUaIvSBqmi8w==:17
 a=smKx5t2vBNcA:10 a=WDhBSedXqNQA:10 a=yZ_tukbHLhDn6nwp3z4A:9
X-CM-Score: 0.00
Authentication-Results: cox.net; auth=pass (LOGIN) smtp.auth=ischis2@cox.net
Received: from thunderbird.smith.home (localhost [127.0.0.1])
        by thunderbird.smith.home (Postfix) with ESMTP id 7448B29A00E6
        for <git@vger.kernel.org>; Mon, 22 Oct 2018 20:53:41 -0700 (MST)
From:   "Stephen P. Smith" <ischis2@cox.net>
To:     git@vger.kernel.org
Subject: [PATCH 0/5] Commit test name clean-up
Date:   Mon, 22 Oct 2018 20:53:36 -0700
Message-Id: <20181023035341.15398-1-ischis2@cox.net>
X-Mailer: git-send-email 2.19.0
In-Reply-To: <xmqqwos19nr5.fsf@gitster-ct.c.googlers.com>
References: <xmqqwos19nr5.fsf@gitster-ct.c.googlers.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Several tests did not comply with the documented test naming standard.

The patch series was held off until updates to t7501 was merged to the
master branch.

Stephen P. Smith (5):
  t2000: rename and combine checkout clash tests
  t7509: cleanup description and filename
  t7502: rename commit test script to comply with naming convention
  t7500: rename commit tests script to comply with naming convention
  t7501: rename commit test to comply with naming convention

 t/t2000-checkout-cache-clash.sh               |  60 --------
 t/t2000-conflict-when-checking-files-out.sh   | 135 ++++++++++++++++++
 t/t2001-checkout-cache-clash.sh               |  85 -----------
 ...> t7500-commit-template-squash-signoff.sh} |   2 +-
 ....sh => t7501-commit-basic-funtionality.sh} |   0
 ...02-commit.sh => t7502-commit-porcelain.sh} |   0
 ...9-commit.sh => t7509-commit-authorship.sh} |   2 +-
 7 files changed, 137 insertions(+), 147 deletions(-)
 delete mode 100755 t/t2000-checkout-cache-clash.sh
 create mode 100755 t/t2000-conflict-when-checking-files-out.sh
 delete mode 100755 t/t2001-checkout-cache-clash.sh
 rename t/{t7500-commit.sh => t7500-commit-template-squash-signoff.sh} (99%)
 rename t/{t7501-commit.sh => t7501-commit-basic-funtionality.sh} (100%)
 rename t/{t7502-commit.sh => t7502-commit-porcelain.sh} (100%)
 rename t/{t7509-commit.sh => t7509-commit-authorship.sh} (98%)

-- 
2.19.0

