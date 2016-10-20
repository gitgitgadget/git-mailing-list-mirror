Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-4.1 required=3.0 tests=AWL,BAYES_00,
	HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_HI,RP_MATCHES_RCVD
	shortcircuit=no autolearn=ham autolearn_force=no version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id B7FD01F4F8
	for <e@80x24.org>; Thu, 20 Oct 2016 21:39:09 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1754097AbcJTVjH (ORCPT <rfc822;e@80x24.org>);
        Thu, 20 Oct 2016 17:39:07 -0400
Received: from cloud.peff.net ([104.130.231.41]:60271 "EHLO cloud.peff.net"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1752385AbcJTVjG (ORCPT <rfc822;git@vger.kernel.org>);
        Thu, 20 Oct 2016 17:39:06 -0400
Received: (qmail 4186 invoked by uid 109); 20 Oct 2016 21:39:06 -0000
Received: from Unknown (HELO peff.net) (10.0.1.2)
    by cloud.peff.net (qpsmtpd/0.84) with SMTP; Thu, 20 Oct 2016 21:39:06 +0000
Received: (qmail 30221 invoked by uid 111); 20 Oct 2016 21:39:28 -0000
Received: from sigill.intra.peff.net (HELO sigill.intra.peff.net) (10.0.0.7)
    by peff.net (qpsmtpd/0.84) with SMTP; Thu, 20 Oct 2016 17:39:28 -0400
Received: by sigill.intra.peff.net (sSMTP sendmail emulation); Thu, 20 Oct 2016 17:39:04 -0400
Date:   Thu, 20 Oct 2016 17:39:04 -0400
From:   Jeff King <peff@peff.net>
To:     Santiago Torres <santiago@nyu.edu>
Cc:     git@vger.kernel.org, gitster@pobox.com, sunshine@sunshineco.com,
        walters@verbum.org, Lukas Puehringer <luk.puehringer@gmail.com>
Subject: Re: [PATCH 2/2] tag: send fully qualified refnames to
 verify_tag_and_format
Message-ID: <20161020213904.vfvqqvtow4hycdmx@sigill.intra.peff.net>
References: <20161019203520.zevkb75at2nrogdm@sigill.intra.peff.net>
 <20161019203943.epjxnfci7vcqg4xv@sigill.intra.peff.net>
 <20161020165700.qwgli5mbya3d7nzz@LykOS.localdomain>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <20161020165700.qwgli5mbya3d7nzz@LykOS.localdomain>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

On Thu, Oct 20, 2016 at 12:57:01PM -0400, Santiago Torres wrote:

> > I think you'd really just squash the various bits of this into your
> > series at the right spots, though I don't mind it on top, either.
> > 
> > The big question is to what degree we should care about the verify-tag
> > case. I don't think it's any worse off with this change than it is with
> > your series (its "kind" becomes "OTHER", but I don't think that is
> > actually used for display at all; the name remains the same). I'd be OK
> > with leaving it like this, as a known bug, until get_sha1_with_context()
> > learns to tell us about the ref. It's an unhandled corner case in a
> > brand-new feature, not a regression in an existing one.
> 
> I see now, I think I can sprinkle some of these changes on 2/7 then. The
> rest should be doing 4/7 and 5/7. Does this sound ok?

Yep, that sounds about right.

-Peff
