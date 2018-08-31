Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.1 (2015-04-28) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-3.9 required=3.0 tests=AWL,BAYES_00,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,RCVD_IN_DNSWL_HI
	shortcircuit=no autolearn=ham autolearn_force=no version=3.4.1
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 123CA1F404
	for <e@80x24.org>; Fri, 31 Aug 2018 17:58:54 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727359AbeHaWH2 convert rfc822-to-8bit (ORCPT
        <rfc822;e@80x24.org>); Fri, 31 Aug 2018 18:07:28 -0400
Received: from fed1rmfepo102.cox.net ([68.230.241.144]:60105 "EHLO
        fed1rmfepo102.cox.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727248AbeHaWH2 (ORCPT <rfc822;git@vger.kernel.org>);
        Fri, 31 Aug 2018 18:07:28 -0400
Received: from fed1rmimpo306.cox.net ([68.230.241.174])
          by fed1rmfepo102.cox.net
          (InterMail vM.8.01.05.28 201-2260-151-171-20160122) with ESMTP
          id <20180831175849.IPXY4225.fed1rmfepo102.cox.net@fed1rmimpo306.cox.net>
          for <git@vger.kernel.org>; Fri, 31 Aug 2018 13:58:49 -0400
Received: from thunderbird.smith.home ([68.2.114.239])
        by fed1rmimpo306.cox.net with cox
        id Vtyp1y00159yGBo01typr0; Fri, 31 Aug 2018 13:58:49 -0400
X-CT-Class: Clean
X-CT-Score: 0.00
X-CT-RefID: str=0001.0A09020E.5B8981D9.0030,ss=1,re=0.000,recu=0.000,reip=0.000,cl=1,cld=1,fgs=0
X-CT-Spam: 0
X-Authority-Analysis: v=2.2 cv=Ip1uSP3g c=1 sm=1 tr=0
 a=BlDZPKRk22kUaIvSBqmi8w==:117 a=BlDZPKRk22kUaIvSBqmi8w==:17
 a=8nJEP1OIZ-IA:10 a=x7bEGLp0ZPQA:10 a=dapMudl6Dx4A:10 a=pGLkceISAAAA:8
 a=XYaOJQm_yPJp8iriU8MA:9 a=wPNLvfGTeEIA:10
X-CM-Score: 0.00
Authentication-Results: cox.net; auth=pass (LOGIN) smtp.auth=ischis2@cox.net
Received: from thunderbird.localnet (localhost [127.0.0.1])
        by thunderbird.smith.home (Postfix) with ESMTP id C83CE29A00EF;
        Fri, 31 Aug 2018 10:58:48 -0700 (MST)
From:   Stephen & Linda Smith <ischis2@cox.net>
To:     Junio C Hamano <gitster@pobox.com>
Cc:     =?ISO-8859-1?Q?=C6var_Arnfj=F6r=F0?= Bjarmason <avarab@gmail.com>,
        Git Mailing List <git@vger.kernel.org>
Subject: Re: [PATCH 2/3] Add test for commit --dry-run --short.
Date:   Fri, 31 Aug 2018 10:58:48 -0700
Message-ID: <3509994.v5Zsi5rRYD@thunderbird>
Organization: Personal
References: <20180831053921.8083-1-ischis2@cox.net> <87bm9jc8cq.fsf@evledraar.gmail.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8BIT
Content-Type: text/plain; charset="iso-8859-1"
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

On Friday, August 31, 2018 9:26:02 AM MST Junio C Hamano wrote:
> Ævar Arnfjörð Bjarmason <avarab@gmail.com> writes:
> > 
> > Ditto my comment on 1/3 on this. I.e. this changes the failing tests in
> > this series from 2 to 3.
> 
> Correct.  Thanks for helping Stephen on this topic.

I wasn't sure how this situation was normally handled.  I will update when I 
re-roll changes for wt-status.c.




