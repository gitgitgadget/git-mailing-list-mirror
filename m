Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id E9DAEE92FC1
	for <git@archiver.kernel.org>; Thu,  5 Oct 2023 21:01:35 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230375AbjJEVBe (ORCPT <rfc822;git@archiver.kernel.org>);
        Thu, 5 Oct 2023 17:01:34 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:44870 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230029AbjJEVBb (ORCPT <rfc822;git@vger.kernel.org>);
        Thu, 5 Oct 2023 17:01:31 -0400
Received: from cloud.peff.net (cloud.peff.net [104.130.231.41])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id BB61193
        for <git@vger.kernel.org>; Thu,  5 Oct 2023 14:01:30 -0700 (PDT)
Received: (qmail 26808 invoked by uid 109); 5 Oct 2023 21:01:30 -0000
Received: from Unknown (HELO peff.net) (10.0.1.2)
 by cloud.peff.net (qpsmtpd/0.94) with ESMTP; Thu, 05 Oct 2023 21:01:30 +0000
Authentication-Results: cloud.peff.net; auth=none
Received: (qmail 29174 invoked by uid 111); 5 Oct 2023 21:01:27 -0000
Received: from coredump.intra.peff.net (HELO coredump.intra.peff.net) (10.0.0.2)
 by peff.net (qpsmtpd/0.94) with (TLS_AES_256_GCM_SHA384 encrypted) ESMTPS; Thu, 05 Oct 2023 17:01:27 -0400
Authentication-Results: peff.net; auth=none
Date:   Thu, 5 Oct 2023 17:01:25 -0400
From:   Jeff King <peff@peff.net>
To:     =?utf-8?B?xaB0xJtww6FuIE7Em21lYw==?= <stepnem@smrk.net>
Cc:     git@vger.kernel.org, avarab@gmail.com
Subject: Re: [PATCH] doc/cat-file: clarify description regarding various
 command forms
Message-ID: <20231005210125.GA981206@coredump.intra.peff.net>
References: <20231003082513.3003520-1-stepnem@smrk.net>
 <20231003200659.GC1562@coredump.intra.peff.net>
 <20231005132018+0200.47596-stepnem@smrk.net>
 <20231005171827.GC975921@coredump.intra.peff.net>
 <20231005194852+0200.262756-stepnem@smrk.net>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <20231005194852+0200.262756-stepnem@smrk.net>
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

On Thu, Oct 05, 2023 at 07:48:52PM +0200, Štěpán Němec wrote:

> > Yeah, I think that is a big improvement over the status quo. I might
> > also be worth starting with a single-sentence overview of what is common
> > to both modes. Something like:
> >
> >   Output the contents or details of one or more objects. [...]
> 
> I thought about that when proposing the rewrite, but feel that it would
> again just duplicate what's said elsewhere, in this case even before,
> not after, in the very first line of the man page:
> 
>     git-cat-file - Provide content or type and size information for
>     repository objects

Ah, true, I was thinking that the DESCRIPTION section would be the first
thing users would read, but I didn't notice the headline. I agree that
what it says is probably sufficient (though arguably "type and size" is
slightly inaccurate there; I said "details" in my proposed text but
maybe that is too vague).

> >   This command can operate in two modes, depending on whether an
> >   option from the --batch family is specified.
> >
> >   In non-batch mode, the command provides information on a single object
> >   given on the command line.
>     ^^^^^
> Any particular reason you prefer "given" to "named"?  However absurd a
> notion of giving an actual object on the command line might seem, to me
> "named" is better in that it leaves no room for such misinterpretation.
> And the <object> description in OPTIONS talks about "ways to spell
> object names", building on the same concept.

Nope, I didn't even do that replacement consciously (I was just fleshing
out my example, and ended up deciding nothing else needed to be
changed). So "named" is fine by me.

Thanks.

-Peff
