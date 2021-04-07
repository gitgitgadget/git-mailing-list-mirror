Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-3.8 required=3.0 tests=BAYES_00,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS
	autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 35883C433ED
	for <git@archiver.kernel.org>; Wed,  7 Apr 2021 20:24:45 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id DB1F56100A
	for <git@archiver.kernel.org>; Wed,  7 Apr 2021 20:24:44 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1356085AbhDGUYt (ORCPT <rfc822;git@archiver.kernel.org>);
        Wed, 7 Apr 2021 16:24:49 -0400
Received: from cloud.peff.net ([104.130.231.41]:43702 "EHLO cloud.peff.net"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1356193AbhDGUYR (ORCPT <rfc822;git@vger.kernel.org>);
        Wed, 7 Apr 2021 16:24:17 -0400
Received: (qmail 17729 invoked by uid 109); 7 Apr 2021 20:24:07 -0000
Received: from Unknown (HELO peff.net) (10.0.1.2)
 by cloud.peff.net (qpsmtpd/0.94) with ESMTP; Wed, 07 Apr 2021 20:24:07 +0000
Authentication-Results: cloud.peff.net; auth=none
Received: (qmail 22682 invoked by uid 111); 7 Apr 2021 20:24:07 -0000
Received: from coredump.intra.peff.net (HELO sigill.intra.peff.net) (10.0.0.2)
 by peff.net (qpsmtpd/0.94) with (TLS_AES_256_GCM_SHA384 encrypted) ESMTPS; Wed, 07 Apr 2021 16:24:07 -0400
Authentication-Results: peff.net; auth=none
Date:   Wed, 7 Apr 2021 16:24:06 -0400
From:   Jeff King <peff@peff.net>
To:     Junio C Hamano <gitster@pobox.com>
Cc:     Bagas Sanjaya <bagasdotme@gmail.com>, git@vger.kernel.org
Subject: Re: Reviewed-by given by celebrities (no subject matter expertise on
 Git development)
Message-ID: <YG4U5phu1uXZe6Tn@coredump.intra.peff.net>
References: <345a7b27-8ee4-4b64-0340-40b002a25d1f@gmail.com>
 <xmqqeefqzsvz.fsf@gitster.g>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <xmqqeefqzsvz.fsf@gitster.g>
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

On Sat, Apr 03, 2021 at 07:27:12PM -0700, Junio C Hamano wrote:

> Bagas Sanjaya <bagasdotme@gmail.com> writes:
> 
> > Junio, what will you do in such situation above (celebrities reviewing
> > patches and giving Reviewed-by despite of lack of subject matter
> > expertise)?
> 
> I find the scenario highly unlikely, and I do not see the point of
> wasting my time on a trick question, thinking about what I would do
> in a scenario that is not realistic, so I was tempted to ignore this
> message.  If you have something you really want to ask, ask it
> directly instead.
> 
> But I'll make it an exception this case, since you are relatively
> new.
> 
> I do not think the celebrity status of a person who sends a
> Reviewed-by matters.  What matters aroud here is the quality of
> review that comes with "Reviewed-by".
> 
> Just a "Reviewed-by" without comments would most likely not count at
> all, unless the perceived competence and expertise the reviewer
> possesses in the area is reasonably high.
> 
> The "perceived" is a rather important word here.  It does not matter
> how good one actually is.  One must have had demonstrated one's
> competence and expertise on the list sufficiently to earn trust by
> other readers on the list for one's "Reviewed-by" to really count.
> 
> "I read the patch with fine toothed comb, I found it very well done,
> I have nothing else to add.", coming from somebody who is KNOWN to
> know the area the patch touches well, would mean a lot.  When the
> same statement was given by somebody who hasn't earned the trust of
> the collective mind on the list, regardless of the celebrity status,
> would mean a lot less.

I don't usually post "me too" responses, since they are usually just
noise. But I could not resist it here, for two reasons:

  - this is such a nicely written summary of what "Reviewed-by" means in
    our project that I think it deserves some praise. :)

  - because it is ultimately about "what does Reviewed-by mean within
    the Git project", there is some small value in having another
    project member say "yes, that is exactly what I expect from it,
    too"

-Peff
