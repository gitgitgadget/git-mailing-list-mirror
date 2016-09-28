Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-5.4 required=3.0 tests=AWL,BAYES_00,
	HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_HI,RP_MATCHES_RCVD
	shortcircuit=no autolearn=ham autolearn_force=no version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 13E1C207EC
	for <e@80x24.org>; Wed, 28 Sep 2016 06:41:56 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1750727AbcI1Gly (ORCPT <rfc822;e@80x24.org>);
        Wed, 28 Sep 2016 02:41:54 -0400
Received: from cloud.peff.net ([104.130.231.41]:49274 "EHLO cloud.peff.net"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1750719AbcI1Glx (ORCPT <rfc822;git@vger.kernel.org>);
        Wed, 28 Sep 2016 02:41:53 -0400
Received: (qmail 13224 invoked by uid 109); 28 Sep 2016 06:41:51 -0000
Received: from Unknown (HELO peff.net) (10.0.1.2)
    by cloud.peff.net (qpsmtpd/0.84) with SMTP; Wed, 28 Sep 2016 06:41:51 +0000
Received: (qmail 22773 invoked by uid 111); 28 Sep 2016 06:42:07 -0000
Received: from sigill.intra.peff.net (HELO sigill.intra.peff.net) (10.0.0.7)
    by peff.net (qpsmtpd/0.84) with SMTP; Wed, 28 Sep 2016 02:42:07 -0400
Received: by sigill.intra.peff.net (sSMTP sendmail emulation); Wed, 28 Sep 2016 02:41:50 -0400
Date:   Wed, 28 Sep 2016 02:41:50 -0400
From:   Jeff King <peff@peff.net>
To:     "Eric S. Raymond" <esr@thyrsus.com>
Cc:     git@vger.kernel.org
Subject: Re: [PATCH 3/3] docs/cvs-migration: mention cvsimport caveats
Message-ID: <20160928064149.m3j5z5tr4zopet5h@sigill.intra.peff.net>
References: <20160922072350.ivjrfuedodd2rezn@sigill.intra.peff.net>
 <20160922072628.rs47hfiowtobw46s@sigill.intra.peff.net>
 <20160922131526.GB6320@thyrsus.com>
 <20160923035601.f5czdieouzvm3ptz@sigill.intra.peff.net>
 <20160928001108.GA9120@thyrsus.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <20160928001108.GA9120@thyrsus.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

On Tue, Sep 27, 2016 at 08:11:08PM -0400, Eric S. Raymond wrote:

> Jeff King <peff@peff.net>:
> >               I am not qualified to write on the current state of
> > the art in CVS importing.
> 
> I *am* qualified; cvs-fast-export has had a lot of work put into it by
> myself and others over the last five years.

I, for one, would be fine if you wanted to send a patch updating
Documentation/gitcvs-migration.txt to describe cvs-fast-export rather
than cvsimport. I think it would probably even be fine if it mostly just
pointed to an existing guide and said "use this".

-Peff
