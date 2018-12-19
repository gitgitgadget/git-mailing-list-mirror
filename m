Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.2 (2018-09-13) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-2.9 required=3.0 tests=BAYES_00,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,
	RCVD_IN_BL_SPAMCOP_NET,RCVD_IN_DNSWL_HI shortcircuit=no autolearn=ham
	autolearn_force=no version=3.4.2
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id B849B1F405
	for <e@80x24.org>; Wed, 19 Dec 2018 18:09:38 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729061AbeLSSJg (ORCPT <rfc822;e@80x24.org>);
        Wed, 19 Dec 2018 13:09:36 -0500
Received: from fed1rmfepo203.cox.net ([68.230.241.148]:58312 "EHLO
        fed1rmfepo203.cox.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1728205AbeLSSJg (ORCPT <rfc822;git@vger.kernel.org>);
        Wed, 19 Dec 2018 13:09:36 -0500
Received: from fed1rmimpo306.cox.net ([68.230.241.174])
          by fed1rmfepo203.cox.net
          (InterMail vM.8.01.05.28 201-2260-151-171-20160122) with ESMTP
          id <20181219180934.FNWD4163.fed1rmfepo203.cox.net@fed1rmimpo306.cox.net>
          for <git@vger.kernel.org>; Wed, 19 Dec 2018 13:09:34 -0500
Received: from thunderbird.localnet (localhost [127.0.0.1])
        by thunderbird.smith.home (Postfix) with ESMTP id 46D18B8432D;
        Wed, 19 Dec 2018 11:09:34 -0700 (MST)
X-CT-Class: Clean
X-CT-Score: 0.00
X-CT-RefID: str=0001.0A090204.5C1A895E.0087,ss=1,re=0.000,recu=0.000,reip=0.000,cl=1,cld=1,fgs=0
X-CT-Spam: 0
X-Authority-Analysis: v=2.3 cv=U+om8tju c=1 sm=1 tr=0
 a=BlDZPKRk22kUaIvSBqmi8w==:117 a=BlDZPKRk22kUaIvSBqmi8w==:17
 a=kj9zAlcOel0A:10 a=2ur7OfE09M0A:10 a=aulWLQ49AAAA:20
 a=rrMFMnvoY8t3upsH7g4A:9 a=CjuIK1q_8ugA:10
X-CM-Score: 0.00
Authentication-Results: cox.net; auth=pass (LOGIN) smtp.auth=ischis2@cox.net
From:   "Stephen P. Smith" <ischis2@cox.net>
To:     Johannes Schindelin <Johannes.Schindelin@gmx.de>
Cc:     =?utf-8?B?0JjQstCw0L0g0JzQvtCz0LjRiA==?= <ivan.mogish@playrix.com>,
        git@vger.kernel.org,
        =?utf-8?B?0JTQvNC40YLRgNC40Lkg0K/QutC+0LLQu9C10LI=?= 
        <yakovlev@playrix.com>
Subject: Re: Git hooks don't run while commiting in worktree via git-gui
Date:   Wed, 19 Dec 2018 11:09:34 -0700
Message-ID: <49862352.x4qs2Yizgb@thunderbird>
Organization: Personal
In-Reply-To: <nycvar.QRO.7.76.6.1812182254250.43@tvgsbejvaqbjf.bet>
References: <CACu3VMWJ_otp2D6Tu_2adq=J2wcj0nsYhsW5oWxmbidb3afuyg@mail.gmail.com> <nycvar.QRO.7.76.6.1812182254250.43@tvgsbejvaqbjf.bet>
MIME-Version: 1.0
Content-Transfer-Encoding: 7Bit
Content-Type: text/plain; charset="us-ascii"
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

On Tuesday, December 18, 2018 2:56:43 PM MST Johannes Schindelin wrote:
> Sounds like you need https://github.com/git-for-windows/git/pull/1757
> (we do not currently have a responsive maintainer for Git GUI,
> unfortunately, otherwise this patch would have made it into an official
> Git version already).

Are you talking about the version that is shipped with git for windows or the 
version that is shipped with the main (Junio's) version?   

Too bad I only get bits and pieces of time to contribute




