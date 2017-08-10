Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-3.7 required=3.0 tests=AWL,BAYES_00,
	HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_HI,RP_MATCHES_RCVD
	shortcircuit=no autolearn=ham autolearn_force=no version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 2423F1F667
	for <e@80x24.org>; Thu, 10 Aug 2017 23:17:11 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1753406AbdHJXRJ (ORCPT <rfc822;e@80x24.org>);
        Thu, 10 Aug 2017 19:17:09 -0400
Received: from cloud.peff.net ([104.130.231.41]:35552 "HELO cloud.peff.net"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with SMTP
        id S1753400AbdHJXRI (ORCPT <rfc822;git@vger.kernel.org>);
        Thu, 10 Aug 2017 19:17:08 -0400
Received: (qmail 2054 invoked by uid 109); 10 Aug 2017 23:17:08 -0000
Received: from Unknown (HELO peff.net) (10.0.1.2)
 by cloud.peff.net (qpsmtpd/0.94) with SMTP; Thu, 10 Aug 2017 23:17:08 +0000
Authentication-Results: cloud.peff.net; auth=none
Received: (qmail 11690 invoked by uid 111); 10 Aug 2017 23:17:31 -0000
Received: from sigill.intra.peff.net (HELO sigill.intra.peff.net) (10.0.0.7)
 by peff.net (qpsmtpd/0.94) with SMTP; Thu, 10 Aug 2017 19:17:31 -0400
Authentication-Results: peff.net; auth=none
Received: by sigill.intra.peff.net (sSMTP sendmail emulation); Thu, 10 Aug 2017 19:17:06 -0400
Date:   Thu, 10 Aug 2017 19:17:06 -0400
From:   Jeff King <peff@peff.net>
To:     Junio C Hamano <gitster@pobox.com>
Cc:     Kevin Willford <kcwillford@gmail.com>, git@vger.kernel.org,
        Kevin Willford <kewillf@microsoft.com>
Subject: Re: [PATCH v2 0/2] Add progress for format-patch and rebase
Message-ID: <20170810231706.vixs6wms5cpwwsab@sigill.intra.peff.net>
References: <20170531150427.7820-1-kewillf@microsoft.com>
 <20170810183256.12668-1-kewillf@microsoft.com>
 <xmqqbmnn11kw.fsf@gitster.mtv.corp.google.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <xmqqbmnn11kw.fsf@gitster.mtv.corp.google.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

On Thu, Aug 10, 2017 at 03:48:31PM -0700, Junio C Hamano wrote:

> Kevin Willford <kcwillford@gmail.com> writes:
> 
> > Changes since last patch:
> > 1. Use start_progress_delay so progress isn't shown if generating
> >    the patches is fast enough
> > 2. Updated to have text of "Generating patches"
> > 3. Only show progress when the --progress flag is passed
> > 4. In the rebase script check stderr and the quiet option is not
> >    set before propagating the progress flag to format-patch
> >
> > Kevin Willford (2):
> >   format-patch: have progress option while generating patches
> >   rebase: turn on progress option by default for format-patch
> 
> Do you have a pointer to the previous discussion handy (if you do
> not, that is OK---I think I can dig the list archive myself)?

https://public-inbox.org/git/20170531150427.7820-1-kewillf@microsoft.com/

is what I turned up.

Overall this version looks good to me, and addresses all of the previous
points. I have two minor points which I'll make inline.

-Peff
