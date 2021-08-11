Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-3.8 required=3.0 tests=BAYES_00,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS
	autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 8E3F7C4338F
	for <git@archiver.kernel.org>; Wed, 11 Aug 2021 20:30:38 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 696B56054F
	for <git@archiver.kernel.org>; Wed, 11 Aug 2021 20:30:38 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231481AbhHKUbB (ORCPT <rfc822;git@archiver.kernel.org>);
        Wed, 11 Aug 2021 16:31:01 -0400
Received: from cloud.peff.net ([104.130.231.41]:44640 "EHLO cloud.peff.net"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S230270AbhHKUbB (ORCPT <rfc822;git@vger.kernel.org>);
        Wed, 11 Aug 2021 16:31:01 -0400
Received: (qmail 22870 invoked by uid 109); 11 Aug 2021 20:30:37 -0000
Received: from Unknown (HELO peff.net) (10.0.1.2)
 by cloud.peff.net (qpsmtpd/0.94) with ESMTP; Wed, 11 Aug 2021 20:30:37 +0000
Authentication-Results: cloud.peff.net; auth=none
Received: (qmail 14430 invoked by uid 111); 11 Aug 2021 20:30:37 -0000
Received: from coredump.intra.peff.net (HELO sigill.intra.peff.net) (10.0.0.2)
 by peff.net (qpsmtpd/0.94) with (TLS_AES_256_GCM_SHA384 encrypted) ESMTPS; Wed, 11 Aug 2021 16:30:37 -0400
Authentication-Results: peff.net; auth=none
Date:   Wed, 11 Aug 2021 16:30:36 -0400
From:   Jeff King <peff@peff.net>
To:     Felipe Contreras <felipe.contreras@gmail.com>
Cc:     Junio C Hamano <gitster@pobox.com>,
        Bagas Sanjaya <bagasdotme@gmail.com>, git@vger.kernel.org,
        Jonathan Nieder <jrnieder@gmail.com>,
        Matthieu Moy <git@matthieu-moy.fr>,
        Michael J Gruber <git@grubix.eu>
Subject: Re: [PATCH 6/7] stage: add 'diff' subcommand
Message-ID: <YRQzbPpk23dVqP+g@coredump.intra.peff.net>
References: <20210811045727.2381-1-felipe.contreras@gmail.com>
 <20210811045727.2381-7-felipe.contreras@gmail.com>
 <8034894f-a8dd-e1ee-1825-7cb172afdba3@gmail.com>
 <xmqqzgto9dkd.fsf@gitster.g>
 <YRQfx+Njj1WxOnyG@coredump.intra.peff.net>
 <611430a5b83e1_19f82083b@natae.notmuch>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <611430a5b83e1_19f82083b@natae.notmuch>
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

On Wed, Aug 11, 2021 at 03:18:45PM -0500, Felipe Contreras wrote:

> > One thing I find off-putting about "git stage --diff" is that to me,
> > "stage" reads as a verb. So it is like "git add --diff", which seems
> > out-of-place; there are two verbs in a row.
> > 
> > I do not mind the term "staging area", but using "the stage" as a noun
> > is simply confusing to me in this context.
> 
> OK, but "stage" can be a noun.
> 
> Here is one of the definitions:
> 
>   : a center of attention or scene of action
> 
> This definition doesn't imply what the action is about, but
> "commit stage" should be perfectly aligned with that definition.
> 
> Here's another one:
> 
>   : one of two or more sections of a rocket that have their own fuel and engine

Sure, I know the various meanings of "stage" in English. But I do not find it a
synonym for "staging area" at all. Now my opinion may not matter, but:

  - I thought the goal of using a different name was to find something
    that made intuitive sense to English speakers. I do not find "the
    stage" any better than "the index" (in fact, I find it worse).

  - Part of your argument seems to be "many people expressed an opinion
    that the term 'staging area' was a good idea". My name was among
    them.  But in the very email from which you quoted me, I am arguing
    that "staging area" makes sense to me, but "the stage" does not.

-Peff
