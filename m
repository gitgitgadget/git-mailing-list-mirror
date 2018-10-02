Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.1 (2015-04-28) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-3.9 required=3.0 tests=AWL,BAYES_00,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,RCVD_IN_DNSWL_HI
	shortcircuit=no autolearn=ham autolearn_force=no version=3.4.1
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id E50131F453
	for <e@80x24.org>; Tue,  2 Oct 2018 14:27:28 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727385AbeJBVLG (ORCPT <rfc822;e@80x24.org>);
        Tue, 2 Oct 2018 17:11:06 -0400
Received: from cloud.peff.net ([104.130.231.41]:38502 "HELO cloud.peff.net"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with SMTP
        id S1726118AbeJBVLG (ORCPT <rfc822;git@vger.kernel.org>);
        Tue, 2 Oct 2018 17:11:06 -0400
Received: (qmail 32567 invoked by uid 109); 2 Oct 2018 14:27:27 -0000
Received: from Unknown (HELO peff.net) (10.0.1.2)
 by cloud.peff.net (qpsmtpd/0.94) with SMTP; Tue, 02 Oct 2018 14:27:27 +0000
Authentication-Results: cloud.peff.net; auth=none
Received: (qmail 28547 invoked by uid 111); 2 Oct 2018 14:26:51 -0000
Received: from sigill.intra.peff.net (HELO sigill.intra.peff.net) (10.0.0.7)
 by peff.net (qpsmtpd/0.94) with (ECDHE-RSA-AES256-GCM-SHA384 encrypted) SMTP; Tue, 02 Oct 2018 10:26:51 -0400
Authentication-Results: peff.net; auth=none
Received: by sigill.intra.peff.net (sSMTP sendmail emulation); Tue, 02 Oct 2018 10:27:25 -0400
Date:   Tue, 2 Oct 2018 10:27:25 -0400
From:   Jeff King <peff@peff.net>
To:     Jose Gisbert <jose.gisbert@live.com>
Cc:     "git@vger.kernel.org" <git@vger.kernel.org>
Subject: Re: Using git svn rebase at quarantine environment or a feasible
 alternative to synchronize git and svn repositories
Message-ID: <20181002142725.GB24375@sigill.intra.peff.net>
References: <VI1PR0902MB2223EA3FC0ACE7E9AFB7A6ACE2EF0@VI1PR0902MB2223.eurprd09.prod.outlook.com>
 <20181001145344.GA26349@sigill.intra.peff.net>
 <VI1PR0902MB2223AB8C9A721478E82449FEE2E80@VI1PR0902MB2223.eurprd09.prod.outlook.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <VI1PR0902MB2223AB8C9A721478E82449FEE2E80@VI1PR0902MB2223.eurprd09.prod.outlook.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

On Tue, Oct 02, 2018 at 10:28:38AM +0000, Jose Gisbert wrote:

> Moreover, assuming that solution #1 will generally work and the facts that:
> 
> - I think it would be possible to us to recover from a corrupted repository
>   somehow easily. Couldn't we, for instance, reset from a failed push and try
>   it again?

Yes, I think that would generally allow you to recover (it just may
require some manual fiddling by the admin).

> - the chances of corrupting the svn repository, our reference here, seem small
>   because git svn dcommit is the last operation in the chain and is only
>   performed when everything else went ok
> - we are a small team and git is not our main CVS, so we can stop pushing to
>   git while we fix the repository
> 
> I'm more inclined to apply this solution. Maybe I'm being too much optimistic
> with my assumptions.

I think your analysis of the risk seems pretty accurate. I make no
promises, of course. :)

-Peff
