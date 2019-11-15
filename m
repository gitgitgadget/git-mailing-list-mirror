Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.2 (2018-09-13) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-3.9 required=3.0 tests=AWL,BAYES_00,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,RCVD_IN_DNSWL_HI,
	SPF_HELO_NONE,SPF_NONE shortcircuit=no autolearn=ham
	autolearn_force=no version=3.4.2
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id E163D1F4B5
	for <e@80x24.org>; Fri, 15 Nov 2019 08:16:16 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726605AbfKOIQP (ORCPT <rfc822;e@80x24.org>);
        Fri, 15 Nov 2019 03:16:15 -0500
Received: from cloud.peff.net ([104.130.231.41]:48200 "HELO cloud.peff.net"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with SMTP
        id S1726182AbfKOIQP (ORCPT <rfc822;git@vger.kernel.org>);
        Fri, 15 Nov 2019 03:16:15 -0500
Received: (qmail 26873 invoked by uid 109); 15 Nov 2019 08:16:14 -0000
Received: from Unknown (HELO peff.net) (10.0.1.2)
 by cloud.peff.net (qpsmtpd/0.94) with SMTP; Fri, 15 Nov 2019 08:16:14 +0000
Authentication-Results: cloud.peff.net; auth=none
Received: (qmail 11337 invoked by uid 111); 15 Nov 2019 08:19:51 -0000
Received: from sigill.intra.peff.net (HELO sigill.intra.peff.net) (10.0.0.7)
 by peff.net (qpsmtpd/0.94) with (TLS_AES_256_GCM_SHA384 encrypted) ESMTPS; Fri, 15 Nov 2019 03:19:51 -0500
Authentication-Results: peff.net; auth=none
Date:   Fri, 15 Nov 2019 03:16:14 -0500
From:   Jeff King <peff@peff.net>
To:     Junio C Hamano <gitster@pobox.com>
Cc:     Thomas Braun <thomas.braun@virtuell-zuhause.de>,
        Bryan Turner <bturner@atlassian.com>,
        Git Users <git@vger.kernel.org>
Subject: Re: rev-list and "ambiguous" IDs
Message-ID: <20191115081614.GA27149@sigill.intra.peff.net>
References: <CAGyf7-EXOUWYUZXmww2+NyD1OuWEG18n221MPojVSCCu=19JNA@mail.gmail.com>
 <20191114055906.GA10643@sigill.intra.peff.net>
 <ab4dcc9c-4416-aef8-c8c4-38bb5ec97990@virtuell-zuhause.de>
 <xmqqa78x918e.fsf@gitster-ct.c.googlers.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <xmqqa78x918e.fsf@gitster-ct.c.googlers.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

On Fri, Nov 15, 2019 at 02:07:13PM +0900, Junio C Hamano wrote:

> Thomas Braun <thomas.braun@virtuell-zuhause.de> writes:
> 
> > Just out of curiosity: Is there a use case for inspecting non-commit
> > objects with git log?
> 
> I do not think there is (rev-list is a different story, given that
> you can pass --objects), and it probably is not too difficult to
> teach "git log" and friends that they only want commit-ish.

I think you already did; see my other reply. ;)

-Peff
