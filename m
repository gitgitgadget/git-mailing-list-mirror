Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.1 (2015-04-28) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-3.2 required=3.0 tests=AWL,BAYES_00,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,RCVD_IN_BL_SPAMCOP_NET,
	RCVD_IN_DNSWL_HI shortcircuit=no autolearn=no autolearn_force=no version=3.4.1
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 7CE791F404
	for <e@80x24.org>; Wed, 12 Sep 2018 11:39:37 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726798AbeILQno (ORCPT <rfc822;e@80x24.org>);
        Wed, 12 Sep 2018 12:43:44 -0400
Received: from fed1rmfepo202.cox.net ([68.230.241.147]:60512 "EHLO
        fed1rmfepo202.cox.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726082AbeILQno (ORCPT <rfc822;git@vger.kernel.org>);
        Wed, 12 Sep 2018 12:43:44 -0400
Received: from fed1rmimpo210.cox.net ([68.230.241.161])
          by fed1rmfepo202.cox.net
          (InterMail vM.8.01.05.28 201-2260-151-171-20160122) with ESMTP
          id <20180912113935.SMJB21918.fed1rmfepo202.cox.net@fed1rmimpo210.cox.net>
          for <git@vger.kernel.org>; Wed, 12 Sep 2018 07:39:35 -0400
Received: from thunderbird.smith.home ([68.2.114.239])
        by fed1rmimpo210.cox.net with cox
        id abfa1y00A59yGBo01bfbl2; Wed, 12 Sep 2018 07:39:35 -0400
X-CT-Class: Clean
X-CT-Score: 0.00
X-CT-RefID: str=0001.0A090204.5B98FAF7.0017,ss=1,re=0.000,recu=0.000,reip=0.000,cl=1,cld=1,fgs=0
X-CT-Spam: 0
X-Authority-Analysis: v=2.2 cv=a/tAzQaF c=1 sm=1 tr=0
 a=BlDZPKRk22kUaIvSBqmi8w==:117 a=BlDZPKRk22kUaIvSBqmi8w==:17
 a=kj9zAlcOel0A:10 a=x7bEGLp0ZPQA:10 a=JBFolyDoGHsA:10 a=WDhBSedXqNQA:10
 a=kviXuzpPAAAA:8 a=Brt9VVemBZF0AkLEbroA:9 a=CjuIK1q_8ugA:10
 a=qrIFiuKZe2vaD64auk6j:22
X-CM-Score: 0.00
Authentication-Results: cox.net; auth=pass (LOGIN) smtp.auth=ischis2@cox.net
Received: from thunderbird.localnet (localhost [127.0.0.1])
        by thunderbird.smith.home (Postfix) with ESMTP id 8C39329A0075;
        Wed, 12 Sep 2018 04:39:34 -0700 (MST)
From:   Stephen & Linda Smith <ischis2@cox.net>
To:     Junio C Hamano <gitster@pobox.com>
Cc:     git@vger.kernel.org
Subject: Re: What's cooking in git.git (Sep 2018, #02; Tue, 11)
Date:   Wed, 12 Sep 2018 04:39:34 -0700
Message-ID: <8849662.cxaaR4pK4i@thunderbird>
Organization: Personal
References: <8951536.UanLVthjk7@thunderbird>
MIME-Version: 1.0
Content-Transfer-Encoding: 7Bit
Content-Type: text/plain; charset="us-ascii"
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

On Wednesday, September 12, 2018 12:13:23 AM MST Junio C Hamano wrote:
> Stephen & Linda Smith <ischis2@cox.net> writes:
> > On Tuesday, September 11, 2018 3:20:19 PM MST Junio C Hamano wrote:
> >> * jc/wt-status-state-cleanup (2018-09-07) 1 commit
> >> 
> >>  - WIP: roll wt_status_state into wt_status and populate in the collect
> >> 
> >> phase (this branch uses ss/wt-status-committable.)
> >> 
> >> * ss/wt-status-committable (2018-09-07) 4 commits
> >> 
> >>  - wt-status.c: set the committable flag in the collect phase
> >>  - t7501: add test of "commit --dry-run --short"
> >>  - wt-status: rename commitable to committable
> >>  - wt-status.c: move has_unmerged earlier in the file
> >>  (this branch is used by jc/wt-status-state-cleanup.)
> > 
> > I note that the jc/wt-status-state-cleanup branch is a patch "for
> > illustration purposes only" [1].
> > 
> > I was about to update that patch to start dealing with the free() function
> > calls, but noted you added the patch.  Do you want me to take that patch
> > and continue on?  Or does someone else have something in progress?
> 
> I do not plan to.  
Ok ... from the wording I wasn't sure if there wasn't another developer 
working this.  I will pick up that patch and continue.

> In general, anything that is only in 'pu' is a
> fair game---when a better alternative appears, or a discussion leads
> to a conclusion that a change is unneeded, they are replaced and/or
> discarded.  Just think of them as being kept slightly better record
> of existence than merely being in the list archive, nothing more.

Thanks that confirmed my reading of the Documentation/gitworkflows.txt.



