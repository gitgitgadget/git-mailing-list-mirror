Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-3.8 required=3.0 tests=BAYES_00,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS
	autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 9BC05C2B9F2
	for <git@archiver.kernel.org>; Sat, 22 May 2021 09:55:12 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 6F840611AD
	for <git@archiver.kernel.org>; Sat, 22 May 2021 09:55:12 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230244AbhEVJ4f (ORCPT <rfc822;git@archiver.kernel.org>);
        Sat, 22 May 2021 05:56:35 -0400
Received: from cloud.peff.net ([104.130.231.41]:34320 "EHLO cloud.peff.net"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S230232AbhEVJ4e (ORCPT <rfc822;git@vger.kernel.org>);
        Sat, 22 May 2021 05:56:34 -0400
Received: (qmail 9898 invoked by uid 109); 22 May 2021 09:55:09 -0000
Received: from Unknown (HELO peff.net) (10.0.1.2)
 by cloud.peff.net (qpsmtpd/0.94) with ESMTP; Sat, 22 May 2021 09:55:09 +0000
Authentication-Results: cloud.peff.net; auth=none
Received: (qmail 17697 invoked by uid 111); 22 May 2021 09:55:10 -0000
Received: from coredump.intra.peff.net (HELO sigill.intra.peff.net) (10.0.0.2)
 by peff.net (qpsmtpd/0.94) with (TLS_AES_256_GCM_SHA384 encrypted) ESMTPS; Sat, 22 May 2021 05:55:10 -0400
Authentication-Results: peff.net; auth=none
Date:   Sat, 22 May 2021 05:55:07 -0400
From:   Jeff King <peff@peff.net>
To:     Felipe Contreras <felipe.contreras@gmail.com>
Cc:     Junio C Hamano <gitster@pobox.com>,
        Phillip Wood <phillip.wood123@gmail.com>, git@vger.kernel.org,
        =?utf-8?B?w4Z2YXIgQXJuZmrDtnLDsA==?= Bjarmason <avarab@gmail.com>,
        Leah Neukirchen <leah@vuxu.org>,
        "Randall S. Becker" <rsbecker@nexbridge.com>
Subject: Re: [PATCH v4] help: colorize man pages
Message-ID: <YKjU+/mGzWoqe88V@coredump.intra.peff.net>
References: <20210520040725.133848-1-felipe.contreras@gmail.com>
 <842221d6-51c4-e08a-4299-c4efb8bf1dcb@gmail.com>
 <xmqqbl94smjb.fsf@gitster.g>
 <YKdy5jhHgG2who27@coredump.intra.peff.net>
 <60a7f57fe3301_5503920831@natae.notmuch>
 <YKgXXCvWYI9rjKJT@coredump.intra.peff.net>
 <60a828cebd2f1_77e4f208b2@natae.notmuch>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <60a828cebd2f1_77e4f208b2@natae.notmuch>
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

On Fri, May 21, 2021 at 04:40:30PM -0500, Felipe Contreras wrote:

> Jeff King wrote:
> > On Fri, May 21, 2021 at 01:01:35PM -0500, Felipe Contreras wrote:
> > 
> > > > I still don't understand what we gain by making this a Git feature,
> > > 
> > > What do we gain by making `git diff` output color?
> > 
> > Huh? Git is outputting the diff. Who else would output the color?
> 
> Do you think our users know or care which binary has the final
> connection to the tty?

Yes. If we are telling them that "git help git" is using "man", which we
do, then I think they should expect it to behave like "man".

Moreover, I think that if they like colorized manpages, they'd probably
want them when running "man" themselves.

-Peff
