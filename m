Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.2 (2018-09-13) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-4.0 required=3.0 tests=AWL,BAYES_00,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,RCVD_IN_DNSWL_HI
	shortcircuit=no autolearn=ham autolearn_force=no version=3.4.2
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id D63211F453
	for <e@80x24.org>; Wed, 30 Jan 2019 12:44:48 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727050AbfA3Mor (ORCPT <rfc822;e@80x24.org>);
        Wed, 30 Jan 2019 07:44:47 -0500
Received: from cloud.peff.net ([104.130.231.41]:54890 "HELO cloud.peff.net"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with SMTP
        id S1725768AbfA3Mor (ORCPT <rfc822;git@vger.kernel.org>);
        Wed, 30 Jan 2019 07:44:47 -0500
Received: (qmail 1548 invoked by uid 109); 30 Jan 2019 12:44:47 -0000
Received: from Unknown (HELO peff.net) (10.0.1.2)
 by cloud.peff.net (qpsmtpd/0.94) with SMTP; Wed, 30 Jan 2019 12:44:47 +0000
Authentication-Results: cloud.peff.net; auth=none
Received: (qmail 16307 invoked by uid 111); 30 Jan 2019 12:44:53 -0000
Received: from Unknown (HELO sigill.intra.peff.net) (10.0.1.7)
 by peff.net (qpsmtpd/0.94) with (ECDHE-RSA-AES256-GCM-SHA384 encrypted) SMTP; Wed, 30 Jan 2019 07:44:53 -0500
Authentication-Results: peff.net; auth=none
Received: by sigill.intra.peff.net (sSMTP sendmail emulation); Wed, 30 Jan 2019 07:44:42 -0500
Date:   Wed, 30 Jan 2019 07:44:42 -0500
From:   Jeff King <peff@peff.net>
To:     Sebastian Staudt <koraktor@gmail.com>
Cc:     Eric Sunshine <sunshine@sunshineco.com>,
        Git Mailing List <git@vger.kernel.org>,
        Junio C Hamano <gitster@pobox.com>,
        Duy Nguyen <pclouds@gmail.com>
Subject: Re: [PATCH v3 2/3] Setup working tree in describe
Message-ID: <20190130124441.GB2273@sigill.intra.peff.net>
References: <20190129051859.12830-1-koraktor@gmail.com>
 <20190129051859.12830-2-koraktor@gmail.com>
 <20190129131151.GB22211@sigill.intra.peff.net>
 <CAPig+cRUCmaiYqKG6ON==g1sFph-hz6nK5fTYc-9w2JaNFmdLA@mail.gmail.com>
 <20190129223529.GB1895@sigill.intra.peff.net>
 <CA+xP2Sa9mSaBaYgY4LiAwaqX_YN75NV0qA=sTy0D6X1q=SjQeg@mail.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <CA+xP2Sa9mSaBaYgY4LiAwaqX_YN75NV0qA=sTy0D6X1q=SjQeg@mail.gmail.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

On Wed, Jan 30, 2019 at 11:31:15AM +0100, Sebastian Staudt wrote:

> > Yeah, my reasoning was that we handed off to diff-index, so if it
> > doesn't work, then it has its own bug. ;) But I agree it is probably
> > better to just be explicit.
> 
> Thanks for that valuable feedback.
> Is there some trailer like "Co-authored-commit-message-by:"? ;)

We often say "Helped-by", but I am OK with or without that in this case.
To me, making suggestions like this is all just part of review. :)

-Peff
