Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-3.9 required=3.0 tests=AWL,BAYES_00,
	HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_HI,RP_MATCHES_RCVD
	shortcircuit=no autolearn=ham autolearn_force=no version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 341F720964
	for <e@80x24.org>; Tue,  4 Apr 2017 20:21:38 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1753929AbdDDUTf (ORCPT <rfc822;e@80x24.org>);
        Tue, 4 Apr 2017 16:19:35 -0400
Received: from cloud.peff.net ([104.130.231.41]:56668 "EHLO cloud.peff.net"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1752213AbdDDUS3 (ORCPT <rfc822;git@vger.kernel.org>);
        Tue, 4 Apr 2017 16:18:29 -0400
Received: (qmail 30701 invoked by uid 109); 4 Apr 2017 20:18:28 -0000
Received: from Unknown (HELO peff.net) (10.0.1.2)
    by cloud.peff.net (qpsmtpd/0.84) with SMTP; Tue, 04 Apr 2017 20:18:28 +0000
Received: (qmail 9086 invoked by uid 111); 4 Apr 2017 20:18:46 -0000
Received: from sigill.intra.peff.net (HELO sigill.intra.peff.net) (10.0.0.7)
    by peff.net (qpsmtpd/0.84) with SMTP; Tue, 04 Apr 2017 16:18:46 -0400
Received: by sigill.intra.peff.net (sSMTP sendmail emulation); Tue, 04 Apr 2017 16:18:26 -0400
Date:   Tue, 4 Apr 2017 16:18:26 -0400
From:   Jeff King <peff@peff.net>
To:     Jeff Hostetler <git@jeffhostetler.com>
Cc:     =?utf-8?B?w4Z2YXIgQXJuZmrDtnLDsA==?= Bjarmason <avarab@gmail.com>,
        Git Mailing List <git@vger.kernel.org>,
        Junio C Hamano <gitster@pobox.com>,
        Jeff Hostetler <jeffhost@microsoft.com>
Subject: Re: [PATCH v4 2/4] fsck: force core.checksumindex=1
Message-ID: <20170404201826.j6yczm6hvksasj4m@sigill.intra.peff.net>
References: <20170403185306.36164-1-git@jeffhostetler.com>
 <20170403185306.36164-3-git@jeffhostetler.com>
 <CACBZZX7DFuLia8RzB908EG7+oWQiFGkFEq14bzT77A75msM98Q@mail.gmail.com>
 <20170404022945.nmadthjzovmjplyb@sigill.intra.peff.net>
 <CACBZZX50+Mpj-GY11KNmh+BkNkWCX3OZjHFQ3iK8c8Hib90_Xg@mail.gmail.com>
 <9abad913-66a6-f537-af77-8878c428b192@jeffhostetler.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <9abad913-66a6-f537-af77-8878c428b192@jeffhostetler.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

On Tue, Apr 04, 2017 at 09:13:33AM -0400, Jeff Hostetler wrote:

> > But yeah, another way to resolve this is to get rid of the config
> > option altogether, or document in git-config.txt that
> > core.checksumIndex is obeyed by everything except git-fsck.
> 
> If there's no objections then, I'll just remove the config
> setting and keep the force_ global for fsck.

That makes the most sense to me. It doesn't fill the "remain careful by
default, and we can flip the config later" criterion that Junio set out.
But I really just don't think "careful" here is buying us anything.

-Peff
