Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.1 (2015-04-28) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-3.8 required=3.0 tests=AWL,BAYES_00,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,RCVD_IN_DNSWL_HI
	shortcircuit=no autolearn=ham autolearn_force=no version=3.4.1
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 902AA1F517
	for <e@80x24.org>; Fri,  8 Jun 2018 06:27:22 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1752693AbeFHG1V (ORCPT <rfc822;e@80x24.org>);
        Fri, 8 Jun 2018 02:27:21 -0400
Received: from titan.plasma.xg8.de ([85.10.203.189]:41344 "EHLO
        titan.PLASMA.Xg8.DE" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1751181AbeFHG1U (ORCPT <rfc822;git@vger.kernel.org>);
        Fri, 8 Jun 2018 02:27:20 -0400
Received: from titan.PLASMA.Xg8.DE (localhost [127.0.0.1])
        by titan.PLASMA.Xg8.DE (8.15.2/8.15.2) with ESMTPS id w586RAkB022430
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NO);
        Fri, 8 Jun 2018 08:27:10 +0200
Received: (from uucp@localhost)
        by titan.PLASMA.Xg8.DE (8.15.2/8.15.2/Submit) with UUCP id w586RAce022429;
        Fri, 8 Jun 2018 08:27:10 +0200
Received: from helen.PLASMA.Xg8.DE (localhost.localdomain [127.0.0.1])
        by helen.PLASMA.Xg8.DE (8.15.2/8.15.2) with ESMTP id w586GvPC009482;
        Fri, 8 Jun 2018 08:16:57 +0200
Received: (from rtc@localhost)
        by helen.PLASMA.Xg8.DE (8.15.2/8.15.2/Submit) id w586Gulp009481;
        Fri, 8 Jun 2018 08:16:56 +0200
Date:   Fri, 8 Jun 2018 08:16:56 +0200
From:   Peter Backes <rtc@helen.PLASMA.Xg8.DE>
To:     David Lang <david@lang.hm>
Cc:     Philip Oakley <philipoakley@iee.org>,
        =?iso-8859-1?Q?=C6var_Arnfj=F6r=F0?= Bjarmason <avarab@gmail.com>,
        Git Mailing List <git@vger.kernel.org>
Subject: Re: GDPR compliance best practices?
Message-ID: <20180608061656.GA9383@helen.PLASMA.Xg8.DE>
References: <20180603141801.GA8898@helen.PLASMA.Xg8.DE>
 <6BE308009FFA4CCDB5B3B47C2AC53E20@PhilipOakley>
 <20180603174617.GA10900@helen.PLASMA.Xg8.DE>
 <alpine.DEB.2.02.1806061831340.7659@nftneq.ynat.uz>
 <20180607063225.GA28343@helen.PLASMA.Xg8.DE>
 <3EF5AC29192A4D179B6D8689ECB991CC@PhilipOakley>
 <20180607223442.GA5322@helen.PLASMA.Xg8.DE>
 <alpine.DEB.2.02.1806071535510.27871@nftneq.ynat.uz>
 <20180607232128.GA5879@helen.PLASMA.Xg8.DE>
 <alpine.DEB.2.02.1806071651310.27871@nftneq.ynat.uz>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <alpine.DEB.2.02.1806071651310.27871@nftneq.ynat.uz>
User-Agent: Mutt/1.9.1 (2017-09-22)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

On Thu, Jun 07, 2018 at 04:53:16PM -0700, David Lang wrote:
> the license is granted to the world, so the world has an interest in it.

Certainly, but you need to have overriding legitimate grounds. An 
interest is not enough for justification. You have to weight your 
interests against those of the subject.

> Unless you are going to argue that the GDPR outlawed open source 
> development.

No it certainly did not and I don't see how it could.

All the GDPR arguably demands is that the author's identity is deleted 
from a public repository if he wishes so.

Just assume it was a CVS repo. Then removal would not be any issue at 
all. It is a technical speciality of git that makes the removal so 
intricate to implement, which is not at all an intrinsic property of 
open source development.

> you are the one arguing that the GDPR prohibits Git from storing and
> revealing this license granting data, not me.

It prohibits publishing, and only after a request to be forgotten. It 
does not prohibit storing your private copy.

Best wishes
Peter

-- 
Peter Backes, rtc@helen.PLASMA.Xg8.DE
