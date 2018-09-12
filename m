Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.1 (2015-04-28) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-3.9 required=3.0 tests=AWL,BAYES_00,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,RCVD_IN_DNSWL_HI
	shortcircuit=no autolearn=ham autolearn_force=no version=3.4.1
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 1BDD31F404
	for <e@80x24.org>; Wed, 12 Sep 2018 02:36:40 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728126AbeILHiu (ORCPT <rfc822;e@80x24.org>);
        Wed, 12 Sep 2018 03:38:50 -0400
Received: from fed1rmfepo202.cox.net ([68.230.241.147]:49328 "EHLO
        fed1rmfepo202.cox.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726686AbeILHiu (ORCPT <rfc822;git@vger.kernel.org>);
        Wed, 12 Sep 2018 03:38:50 -0400
Received: from fed1rmimpo110.cox.net ([68.230.241.159])
          by fed1rmfepo202.cox.net
          (InterMail vM.8.01.05.28 201-2260-151-171-20160122) with ESMTP
          id <20180912023637.JXWL21918.fed1rmfepo202.cox.net@fed1rmimpo110.cox.net>
          for <git@vger.kernel.org>; Tue, 11 Sep 2018 22:36:37 -0400
Received: from thunderbird.smith.home ([68.2.114.239])
        by fed1rmimpo110.cox.net with cox
        id aScc1y00959yGBo01SccU7; Tue, 11 Sep 2018 22:36:37 -0400
X-CT-Class: Clean
X-CT-Score: 0.00
X-CT-RefID: str=0001.0A09020C.5B987BB5.0058,ss=1,re=0.000,recu=0.000,reip=0.000,cl=1,cld=1,fgs=0
X-CT-Spam: 0
X-Authority-Analysis: v=2.2 cv=bqM8PASi c=1 sm=1 tr=0
 a=BlDZPKRk22kUaIvSBqmi8w==:117 a=BlDZPKRk22kUaIvSBqmi8w==:17
 a=kj9zAlcOel0A:10 a=x7bEGLp0ZPQA:10 a=JBFolyDoGHsA:10 a=WDhBSedXqNQA:10
 a=5rxgeBVgAAAA:8 a=kviXuzpPAAAA:8 a=G1USvYAXLwlu9Q_dhrIA:9 a=CjuIK1q_8ugA:10
 a=PwKx63F5tFurRwaNxrlG:22 a=qrIFiuKZe2vaD64auk6j:22
X-CM-Score: 0.00
Authentication-Results: cox.net; auth=pass (LOGIN) smtp.auth=ischis2@cox.net
Received: from thunderbird.localnet (localhost [127.0.0.1])
        by thunderbird.smith.home (Postfix) with ESMTP id 15CE229A012D;
        Tue, 11 Sep 2018 19:36:36 -0700 (MST)
From:   Stephen & Linda Smith <ischis2@cox.net>
To:     Junio C Hamano <gitster@pobox.com>
Cc:     git@vger.kernel.org
Subject: Re: What's cooking in git.git (Sep 2018, #02; Tue, 11)
Date:   Tue, 11 Sep 2018 19:36:35 -0700
Message-ID: <8951536.UanLVthjk7@thunderbird>
Organization: Personal
MIME-Version: 1.0
Content-Transfer-Encoding: 7Bit
Content-Type: text/plain; charset="us-ascii"
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

On Tuesday, September 11, 2018 3:20:19 PM MST Junio C Hamano wrote:
> 
> * jc/wt-status-state-cleanup (2018-09-07) 1 commit
>  - WIP: roll wt_status_state into wt_status and populate in the collect
> phase (this branch uses ss/wt-status-committable.)
> 
> * ss/wt-status-committable (2018-09-07) 4 commits
>  - wt-status.c: set the committable flag in the collect phase
>  - t7501: add test of "commit --dry-run --short"
>  - wt-status: rename commitable to committable
>  - wt-status.c: move has_unmerged earlier in the file
>  (this branch is used by jc/wt-status-state-cleanup.)
> 

I note that the jc/wt-status-state-cleanup branch is a patch "for illustration 
purposes only" [1].

I was about to update that patch to start dealing with the free() function 
calls, but noted you added the patch.  Do you want me to take that patch and 
continue on?  Or does someone else have something in progress?

sps

[1] https://public-inbox.org/git/20180906005329.11277-1-ischis2@cox.net/T/
#m3554b678d23fd8d7bc702d83667bebacdf02d8aa




