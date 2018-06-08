Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.1 (2015-04-28) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-3.8 required=3.0 tests=AWL,BAYES_00,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,RCVD_IN_DNSWL_HI
	shortcircuit=no autolearn=ham autolearn_force=no version=3.4.1
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 391C11F517
	for <e@80x24.org>; Fri,  8 Jun 2018 06:27:26 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1752694AbeFHG1Y (ORCPT <rfc822;e@80x24.org>);
        Fri, 8 Jun 2018 02:27:24 -0400
Received: from titan.plasma.xg8.de ([85.10.203.189]:41348 "EHLO
        titan.PLASMA.Xg8.DE" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1751181AbeFHG1W (ORCPT <rfc822;git@vger.kernel.org>);
        Fri, 8 Jun 2018 02:27:22 -0400
Received: from titan.PLASMA.Xg8.DE (localhost [127.0.0.1])
        by titan.PLASMA.Xg8.DE (8.15.2/8.15.2) with ESMTPS id w586RAfg022434
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NO);
        Fri, 8 Jun 2018 08:27:10 +0200
Received: (from uucp@localhost)
        by titan.PLASMA.Xg8.DE (8.15.2/8.15.2/Submit) with UUCP id w586RAkQ022433;
        Fri, 8 Jun 2018 08:27:10 +0200
Received: from helen.PLASMA.Xg8.DE (localhost.localdomain [127.0.0.1])
        by helen.PLASMA.Xg8.DE (8.15.2/8.15.2) with ESMTP id w586Qws2009575;
        Fri, 8 Jun 2018 08:26:58 +0200
Received: (from rtc@localhost)
        by helen.PLASMA.Xg8.DE (8.15.2/8.15.2/Submit) id w586Qv7h009574;
        Fri, 8 Jun 2018 08:26:57 +0200
Date:   Fri, 8 Jun 2018 08:26:57 +0200
From:   Peter Backes <rtc@helen.PLASMA.Xg8.DE>
To:     "Theodore Y. Ts'o" <tytso@mit.edu>
Cc:     David Lang <david@lang.hm>, Philip Oakley <philipoakley@iee.org>,
        =?iso-8859-1?Q?=C6var_Arnfj=F6r=F0?= Bjarmason <avarab@gmail.com>,
        Git Mailing List <git@vger.kernel.org>
Subject: Re: GDPR compliance best practices?
Message-ID: <20180608062657.GB9383@helen.PLASMA.Xg8.DE>
References: <20180603141801.GA8898@helen.PLASMA.Xg8.DE>
 <6BE308009FFA4CCDB5B3B47C2AC53E20@PhilipOakley>
 <20180603174617.GA10900@helen.PLASMA.Xg8.DE>
 <alpine.DEB.2.02.1806061831340.7659@nftneq.ynat.uz>
 <20180607063225.GA28343@helen.PLASMA.Xg8.DE>
 <3EF5AC29192A4D179B6D8689ECB991CC@PhilipOakley>
 <20180607223442.GA5322@helen.PLASMA.Xg8.DE>
 <alpine.DEB.2.02.1806071535510.27871@nftneq.ynat.uz>
 <20180607232128.GA5879@helen.PLASMA.Xg8.DE>
 <20180608025313.GA12749@thunk.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20180608025313.GA12749@thunk.org>
User-Agent: Mutt/1.9.1 (2017-09-22)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

On Thu, Jun 07, 2018 at 10:53:13PM -0400, Theodore Y. Ts'o wrote:
> The problem is you've left undefined who is "you"?  With an open
> source project, anyone who has contributed to open source project has
> a copyright interest.  That hobbyist in German who submitted a patch?
> They have a copyright interest.  That US Company based in Redmond,
> Washington?  They own a copyright interest.  Huawei in China?  They
> have a copyright interest.
> 
> So there is no "privately".  And "you" numbers in the thousands and
> thousands of copyright holders of portions of the open source code.

Of course there is "privately". Every single one of those who have the 
author information can keep it, privately, for themselves. But those 
that have received a request to be forgotten must not keep publishing 
it on the Internet for download or distribute it to others.

> And of course, that's the other thing you seem to fundamentally not
> understand about how git works.  Every developer in the world working
> on that open source project has their own copy.  There is
> fundamentally no way that you can expunge that information from every
> single git repository in the world.

The misunderstanding is on your side.

If you run a website where the world can access a repository, you are 
responsible for obeying the GDPR with respect to that repository. If 
you receive a request to be forgotten, you have to make sure you stop 
publishing that author's identity as part of the repository.

You do NOT need to

- delete it from a private copy you have
- care about others who publish that data
- or even make sure the data is deleted from private copies others may 
have, even if the number of copies is in the thousands.

In practical terms, if someone wishes to exercise his right to be 
forgotten, he will usually send the request to the maintainer and stop 
him from distributing the information, and perhaps to a third party he 
might use as a platform for publication, such as github.

Best wishes
Peter

-- 
Peter Backes, rtc@helen.PLASMA.Xg8.DE
