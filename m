Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.1 (2015-04-28) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-3.9 required=3.0 tests=AWL,BAYES_00,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,RCVD_IN_DNSWL_HI
	shortcircuit=no autolearn=ham autolearn_force=no version=3.4.1
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id A53FC1F404
	for <e@80x24.org>; Thu,  6 Sep 2018 04:17:33 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1725880AbeIFIu7 (ORCPT <rfc822;e@80x24.org>);
        Thu, 6 Sep 2018 04:50:59 -0400
Received: from fed1rmfepo101.cox.net ([68.230.241.143]:56655 "EHLO
        fed1rmfepo101.cox.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725781AbeIFIu6 (ORCPT <rfc822;git@vger.kernel.org>);
        Thu, 6 Sep 2018 04:50:58 -0400
Received: from fed1rmimpo110.cox.net ([68.230.241.159])
          by fed1rmfepo101.cox.net
          (InterMail vM.8.01.05.28 201-2260-151-171-20160122) with ESMTP
          id <20180906041730.GXEO4101.fed1rmfepo101.cox.net@fed1rmimpo110.cox.net>
          for <git@vger.kernel.org>; Thu, 6 Sep 2018 00:17:30 -0400
Received: from thunderbird.smith.home ([68.2.114.239])
        by fed1rmimpo110.cox.net with cox
        id Y4HV1y00q59yGBo014HWho; Thu, 06 Sep 2018 00:17:30 -0400
X-CT-Class: Clean
X-CT-Score: 0.00
X-CT-RefID: str=0001.0A09020F.5B90AA5A.0024,ss=1,re=0.000,recu=0.000,reip=0.000,cl=1,cld=1,fgs=0
X-CT-Spam: 0
X-Authority-Analysis: v=2.2 cv=Zc1tDodA c=1 sm=1 tr=0
 a=BlDZPKRk22kUaIvSBqmi8w==:117 a=BlDZPKRk22kUaIvSBqmi8w==:17
 a=kj9zAlcOel0A:10 a=x7bEGLp0ZPQA:10 a=JBFolyDoGHsA:10 a=WDhBSedXqNQA:10
 a=5rxgeBVgAAAA:8 a=Nu4vIYkew0tqBuS6P3oA:9 a=CjuIK1q_8ugA:10
 a=PwKx63F5tFurRwaNxrlG:22
X-CM-Score: 0.00
Authentication-Results: cox.net; auth=pass (LOGIN) smtp.auth=ischis2@cox.net
Received: from thunderbird.localnet (localhost [127.0.0.1])
        by thunderbird.smith.home (Postfix) with ESMTP id A608129A00F6
        for <git@vger.kernel.org>; Wed,  5 Sep 2018 21:17:29 -0700 (MST)
From:   Stephen & Linda Smith <ischis2@cox.net>
To:     git@vger.kernel.org
Subject: Mailsplit
Date:   Wed, 05 Sep 2018 21:17:29 -0700
Message-ID: <6663238.U5hdlisbr1@thunderbird>
Organization: Personal
MIME-Version: 1.0
Content-Transfer-Encoding: 7Bit
Content-Type: text/plain; charset="us-ascii"
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

I thought I would use "git mailsplit" to split a mbox file (which downloaded 
from public inbox) so that I could attemp to resurrect a patch series for from 
a year ago.  

The motivation is that I downloaded the series [1] and applied to a tag from 
about the time period that the patch was sent out [2].  

The "git am -3 patch.mbox  quit 2/3 of the way though.   I resolved the fix. 
and ran "git am --continue" which didn't apply the rest of the patches in the 
mbox.

So two questions:
1)  why would git version 2.18.0 not appear to continue applying the patches.   

2) where do I find the command "git mailsplit".   The onlything in my 
installed tree is:

	$ find  /usr/local/ -name '*mailsplit*'
	/usr/local/share/doc/git-doc/git-mailsplit.txt
	/usr/local/share/doc/git-doc/git-mailsplit.html
	/usr/local/share/man/man1/git-mailsplit.1
	/usr/local/libexec/git-core/git-mailsplit

sps

[1] https://public-inbox.org/git/1502914591-26215-1-git-send-email-martin@mail.zuhause/

[2] I wanted to make sure that I could apply back then before attempting to 
either apply to the latest git version or rebase to the latest git version. 



