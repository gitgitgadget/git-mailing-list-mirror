Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.1 (2015-04-28) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-3.2 required=3.0 tests=AWL,BAYES_00,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,RCVD_IN_BL_SPAMCOP_NET,
	RCVD_IN_DNSWL_HI shortcircuit=no autolearn=no autolearn_force=no version=3.4.1
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 9F3AC1F404
	for <e@80x24.org>; Wed,  5 Sep 2018 17:25:20 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727704AbeIEV41 (ORCPT <rfc822;e@80x24.org>);
        Wed, 5 Sep 2018 17:56:27 -0400
Received: from fed1rmfepo101.cox.net ([68.230.241.143]:60739 "EHLO
        fed1rmfepo101.cox.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727397AbeIEV41 (ORCPT <rfc822;git@vger.kernel.org>);
        Wed, 5 Sep 2018 17:56:27 -0400
Received: from fed1rmimpo209.cox.net ([68.230.241.160])
          by fed1rmfepo101.cox.net
          (InterMail vM.8.01.05.28 201-2260-151-171-20160122) with ESMTP
          id <20180905172518.XWDR4101.fed1rmfepo101.cox.net@fed1rmimpo209.cox.net>
          for <git@vger.kernel.org>; Wed, 5 Sep 2018 13:25:18 -0400
Received: from thunderbird.smith.home ([68.2.114.239])
        by fed1rmimpo209.cox.net with cox
        id XtRH1y00U59yGBo01tRHNR; Wed, 05 Sep 2018 13:25:17 -0400
X-CT-Class: Clean
X-CT-Score: 0.00
X-CT-RefID: str=0001.0A09020D.5B90117E.0015,ss=1,re=0.000,recu=0.000,reip=0.000,cl=1,cld=1,fgs=0
X-CT-Spam: 0
X-Authority-Analysis: v=2.2 cv=FPJr/6gs c=1 sm=1 tr=0
 a=BlDZPKRk22kUaIvSBqmi8w==:117 a=BlDZPKRk22kUaIvSBqmi8w==:17
 a=kj9zAlcOel0A:10 a=x7bEGLp0ZPQA:10 a=JBFolyDoGHsA:10 a=WDhBSedXqNQA:10
 a=5rxgeBVgAAAA:8 a=kviXuzpPAAAA:8 a=5AwYZ_PvJRdiVvDQAIoA:9 a=CjuIK1q_8ugA:10
 a=PwKx63F5tFurRwaNxrlG:22 a=qrIFiuKZe2vaD64auk6j:22
X-CM-Score: 0.00
Authentication-Results: cox.net; auth=pass (LOGIN) smtp.auth=ischis2@cox.net
Received: from thunderbird.localnet (localhost [127.0.0.1])
        by thunderbird.smith.home (Postfix) with ESMTP id 506AD29A007E;
        Wed,  5 Sep 2018 10:25:17 -0700 (MST)
From:   Stephen & Linda Smith <ischis2@cox.net>
To:     Junio C Hamano <gitster@pobox.com>,
        Git Mailing List <git@vger.kernel.org>
Subject: How to handle patch series conflicts
Date:   Wed, 05 Sep 2018 10:25:17 -0700
Message-ID: <32028230.38oFsPliiV@thunderbird>
Organization: Personal
In-Reply-To: <2293750.yp9BkL5mAn@thunderbird>
References: <CACsJy8B1UDN26tWPvOtixSBiFF6bYP2BtK2n1u4W-tWdVeKK1A@mail.gmail.com> <2293750.yp9BkL5mAn@thunderbird>
MIME-Version: 1.0
Content-Transfer-Encoding: 7Bit
Content-Type: text/plain; charset="us-ascii"
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Junio -

On Tuesday, September 4, 2018 10:27:26 AM MST Junio C Hamano wrote:
> > t7500-commit.sh
> > t7501-commit.sh
> > t7502-commit.sh
> > t7509-commit.sh
> 
> These seem to have organically grown and it is very likely that ones
> later introduced were added more from laziness.

How does the project prefer to handle patches that conflict.  Renaming t7501-
commit.sh will conflict with a patch set that I submitted over the weekend 
[1].  Should I treat them as totally separate? 

On Tuesday, September 4, 2018 3:36:11 PM MST Junio C Hamano wrote:
> * sl/commit-dry-run-with-short-output-fix (2018-07-30) 4 commits
>  . commit: fix exit code when doing a dry run
>  . wt-status: teach wt_status_collect about merges in progress
>  . wt-status: rename commitable to committable
>  . t7501: add coverage for flags which imply dry runs

I noted that this patch set is similar to the one that I just submitted.  Are 
you thinking of not using mine (in which case I will drop it)?  If not I will 
add a patch to fix the committable spelling[2] and re-roll.

[1] https://public-inbox.org/git/20180901235256.4260-1-ischis2@cox.net/



