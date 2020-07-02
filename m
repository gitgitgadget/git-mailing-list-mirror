Return-Path: <SRS0=gkpi=AN=vger.kernel.org=git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-4.0 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT
	autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 35A17C433DF
	for <git@archiver.kernel.org>; Thu,  2 Jul 2020 08:13:49 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 1AFCB20772
	for <git@archiver.kernel.org>; Thu,  2 Jul 2020 08:13:49 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728188AbgGBINs (ORCPT <rfc822;git@archiver.kernel.org>);
        Thu, 2 Jul 2020 04:13:48 -0400
Received: from smtp01.domein-it.com ([92.48.232.134]:41899 "EHLO
        smtp01.domein-it.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725379AbgGBINr (ORCPT <rfc822;git@vger.kernel.org>);
        Thu, 2 Jul 2020 04:13:47 -0400
Received: by smtp01.domein-it.com (Postfix, from userid 1000)
        id 8E60B8086996; Thu,  2 Jul 2020 10:13:42 +0200 (CEST)
Received: from ferret.domein-it.nl (ferret.domein-it.nl [84.244.139.72])
        by smtp01.domein-it.com (Postfix) with ESMTP id 4B7488086983;
        Thu,  2 Jul 2020 10:13:41 +0200 (CEST)
Received: from 80-112-22-40.cable.dynamic.v4.ziggo.nl ([80.112.22.40]:51758 helo=ben.dynamic.ziggo.nl)
        by ferret.domein-it.nl with esmtpa (Exim 4.93)
        (envelope-from <ben@wijen.net>)
        id 1jquLh-0000G0-7Y; Thu, 02 Jul 2020 10:13:37 +0200
From:   Ben Wijen <ben@wijen.net>
To:     Eric Sunshine <sunshine@sunshineco.com>
Cc:     Git List <git@vger.kernel.org>, Ben Wijen <ben@wijen.net>
Subject: [PATCH v2 0/1] git clone: don't clone into non-empty directory 
Date:   Thu,  2 Jul 2020 10:13:34 +0200
Message-Id: <20200702081335.16786-1-ben@wijen.net>
X-Mailer: git-send-email 2.27.0
In-Reply-To: <CAPig+cS6XnUK9MQL68_yoR9Gve4_itmawsd_0-yJr3S5=3-zPQ@mail.gmail.com>
References: <CAPig+cS6XnUK9MQL68_yoR9Gve4_itmawsd_0-yJr3S5=3-zPQ@mail.gmail.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Domein-IT-MailScanner-Information: Please contact the ISP for more information
X-Domein-IT-MailScanner-ID: 1jquLh-0000G0-7Y
X-Domein-IT-MailScanner: Not scanned: please contact your Internet E-Mail Service Provider for details
X-Domein-IT-MailScanner-SpamCheck: 
X-Domein-IT-MailScanner-From: ben@wijen.net
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Eric, thank you for your review.

With this update I have:
* rebased (and squashed) on master
* included your proposals for the test
* changed "destination path..." to "repository path..."


Ben...

Ben Wijen (1):
  git clone: don't clone into non-empty directory

 builtin/clone.c  | 12 ++++++++++--
 t/t5601-clone.sh |  4 +++-
 2 files changed, 13 insertions(+), 3 deletions(-)

-- 
2.27.0

