Return-Path: <SRS0=RnkD=D3=vger.kernel.org=git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-5.2 required=3.0 tests=BAYES_00,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,
	UNPARSEABLE_RELAY,USER_AGENT_SANE_1 autolearn=no autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 2DE49C433E7
	for <git@archiver.kernel.org>; Tue, 20 Oct 2020 07:05:53 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id CDB9F2237B
	for <git@archiver.kernel.org>; Tue, 20 Oct 2020 07:05:52 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2404827AbgJTHFv (ORCPT <rfc822;git@archiver.kernel.org>);
        Tue, 20 Oct 2020 03:05:51 -0400
Received: from smtp2207-205.mail.aliyun.com ([121.197.207.205]:59317 "EHLO
        smtp2207-205.mail.aliyun.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S2404800AbgJTHFu (ORCPT
        <rfc822;git@vger.kernel.org>); Tue, 20 Oct 2020 03:05:50 -0400
X-Alimail-AntiSpam: AC=CONTINUE;BC=0.242138|-1;CH=green;DM=|CONTINUE|false|;DS=CONTINUE|ham_enroll_verification|0.0876748-0.010615-0.90171;FP=0|0|0|0|0|-1|-1|-1;HT=ay29a033018047202;MF=fuyao@allwinnertech.com;NM=1;PH=DS;RN=2;RT=2;SR=0;TI=SMTPD_---.IlrzxQ3_1603177548;
Received: from localhost(mailfrom:fuyao@allwinnertech.com fp:SMTPD_---.IlrzxQ3_1603177548)
          by smtp.aliyun-inc.com(10.147.42.16);
          Tue, 20 Oct 2020 15:05:48 +0800
Date:   Tue, 20 Oct 2020 15:05:47 +0800
From:   fuyao <fuyao@allwinnertech.com>
To:     git@vger.kernel.org
Cc:     =?utf-8?B?6buE6Ie754Kc?= <huangzhenwei@allwinnertech.com>
Subject: Is cover letter can save changes?
Message-ID: <20201020070547.GI9517@g8Exdroid64>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
User-Agent: Mutt/1.12.1 (2019-06-15)
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Hi:
   i have question about format-patch.

   when use git format-patch with --cover-letter, we add information
   in the cover letter. and then, i must send patch with -v2, the
   information in the cover letter is lost in the v2 patch.

   i found git notes can note things, but it add in patch not
   cover letter. is some operate can do to save in cover letter.

   and the git note record with commit, when amend it can lost note,
   is the rewrite error?
-- 
Nimflorie frostades seda!
