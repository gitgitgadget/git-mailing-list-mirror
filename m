Return-Path: <SRS0=24D7=6H=vger.kernel.org=git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.8 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id B3324C54FCB
	for <git@archiver.kernel.org>; Thu, 23 Apr 2020 21:04:12 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 8AB8220656
	for <git@archiver.kernel.org>; Thu, 23 Apr 2020 21:04:12 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726071AbgDWVEL (ORCPT <rfc822;git@archiver.kernel.org>);
        Thu, 23 Apr 2020 17:04:11 -0400
Received: from cloud.peff.net ([104.130.231.41]:37856 "HELO cloud.peff.net"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with SMTP
        id S1725877AbgDWVEL (ORCPT <rfc822;git@vger.kernel.org>);
        Thu, 23 Apr 2020 17:04:11 -0400
Received: (qmail 17859 invoked by uid 109); 23 Apr 2020 21:04:11 -0000
Received: from Unknown (HELO peff.net) (10.0.1.2)
 by cloud.peff.net (qpsmtpd/0.94) with SMTP; Thu, 23 Apr 2020 21:04:11 +0000
Authentication-Results: cloud.peff.net; auth=none
Received: (qmail 13516 invoked by uid 111); 23 Apr 2020 21:15:20 -0000
Received: from coredump.intra.peff.net (HELO sigill.intra.peff.net) (10.0.0.2)
 by peff.net (qpsmtpd/0.94) with (TLS_AES_256_GCM_SHA384 encrypted) ESMTPS; Thu, 23 Apr 2020 17:15:20 -0400
Authentication-Results: peff.net; auth=none
Date:   Thu, 23 Apr 2020 17:04:09 -0400
From:   Jeff King <peff@peff.net>
To:     Taylor Blau <me@ttaylorr.com>
Cc:     git@vger.kernel.org, Garima Singh <garima.singh@microsoft.com>,
        Derrick Stolee <dstolee@microsoft.com>
Subject: Re: [PATCH 1/2] test-bloom: fix some whitespace issues
Message-ID: <20200423210409.GB1635761@coredump.intra.peff.net>
References: <20200423205851.GA1633985@coredump.intra.peff.net>
 <20200423205907.GA1634224@coredump.intra.peff.net>
 <20200423210155.GA46862@syl.local>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <20200423210155.GA46862@syl.local>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

On Thu, Apr 23, 2020 at 03:01:55PM -0600, Taylor Blau wrote:

> On Thu, Apr 23, 2020 at 04:59:07PM -0400, Jeff King wrote:
> > Signed-off-by: Jeff King <peff@peff.net>
> > ---
> >  t/helper/test-bloom.c | 10 +++++-----
> >  1 file changed, 5 insertions(+), 5 deletions(-)
> >
> > diff --git a/t/helper/test-bloom.c b/t/helper/test-bloom.c
> > index ce412664ba..f9c0ce2bae 100644
> > --- a/t/helper/test-bloom.c
> > +++ b/t/helper/test-bloom.c
> > @@ -27,7 +27,7 @@ static void print_bloom_filter(struct bloom_filter *filter) {
> >  	}
> >  	printf("Filter_Length:%d\n", (int)filter->len);
> >  	printf("Filter_Data:");
> > -	for (i = 0; i < filter->len; i++){
> > +	for (i = 0; i < filter->len; i++) {
> 
> Thanks for fixing the spacing, but I wonder if these braces should be
> here at all. Since the body is one line long, maybe this should just be:
> 
>   for (i = 0; i < filter->len; i++)
>     printf("%02x|", filter->data[i]);

I have to admit that I don't care either way, and I think we spend too
much time quibbling about braces or not-braces. It was really the bad
indentation that I cared about most.

-Peff
