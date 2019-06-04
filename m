Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.2 (2018-09-13) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-4.0 required=3.0 tests=AWL,BAYES_00,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,RCVD_IN_DNSWL_HI,
	SPF_HELO_NONE,SPF_NONE shortcircuit=no autolearn=ham
	autolearn_force=no version=3.4.2
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 897021F462
	for <e@80x24.org>; Tue,  4 Jun 2019 14:35:56 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727737AbfFDOfz (ORCPT <rfc822;e@80x24.org>);
        Tue, 4 Jun 2019 10:35:55 -0400
Received: from cloud.peff.net ([104.130.231.41]:45910 "HELO cloud.peff.net"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with SMTP
        id S1727182AbfFDOfz (ORCPT <rfc822;git@vger.kernel.org>);
        Tue, 4 Jun 2019 10:35:55 -0400
Received: (qmail 22495 invoked by uid 109); 4 Jun 2019 14:35:55 -0000
Received: from Unknown (HELO peff.net) (10.0.1.2)
 by cloud.peff.net (qpsmtpd/0.94) with SMTP; Tue, 04 Jun 2019 14:35:55 +0000
Authentication-Results: cloud.peff.net; auth=none
Received: (qmail 14588 invoked by uid 111); 4 Jun 2019 14:36:39 -0000
Received: from sigill.intra.peff.net (HELO sigill.intra.peff.net) (10.0.0.7)
 by peff.net (qpsmtpd/0.94) with (ECDHE-RSA-AES256-GCM-SHA384 encrypted) SMTP; Tue, 04 Jun 2019 10:36:39 -0400
Authentication-Results: peff.net; auth=none
Received: by sigill.intra.peff.net (sSMTP sendmail emulation); Tue, 04 Jun 2019 10:35:53 -0400
Date:   Tue, 4 Jun 2019 10:35:53 -0400
From:   Jeff King <peff@peff.net>
To:     Felipe Contreras <felipe.contreras@gmail.com>
Cc:     git@vger.kernel.org, Junio C Hamano <gitster@pobox.com>
Subject: Re: [RFC/PATCH 0/5] Fix fetch regression with transport helpers
Message-ID: <20190604143553.GD10598@sigill.intra.peff.net>
References: <20190604021330.16130-1-felipe.contreras@gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <20190604021330.16130-1-felipe.contreras@gmail.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

On Mon, Jun 03, 2019 at 09:13:25PM -0500, Felipe Contreras wrote:

> I noticed a regression with running tests for git-remote-hg; can't seem to be
> able to fetch tags.
> 
> Probably all remote helpers that use the import method are affected, if not
> all.
> 
> The following patches are meant to test for the issue, fix it, and get some
> cleanups.
> 
> I'm not exactly sure the solution is the one we want, but hopefull it gives an
> idea as to what is needed.

It looks good to me. Thanks for fixing this.

The breakage is in v2.20, so I don't think this needs to be rushed into
v2.22 (which is already at -rc3). But it should probably go to 'maint'
sooner rather than later.

-Peff
