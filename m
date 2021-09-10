Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-3.8 required=3.0 tests=BAYES_00,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS
	autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 630DAC433EF
	for <git@archiver.kernel.org>; Fri, 10 Sep 2021 15:31:21 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 489F260FDC
	for <git@archiver.kernel.org>; Fri, 10 Sep 2021 15:31:21 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234360AbhIJPcb (ORCPT <rfc822;git@archiver.kernel.org>);
        Fri, 10 Sep 2021 11:32:31 -0400
Received: from cloud.peff.net ([104.130.231.41]:44060 "EHLO cloud.peff.net"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S234130AbhIJPcb (ORCPT <rfc822;git@vger.kernel.org>);
        Fri, 10 Sep 2021 11:32:31 -0400
Received: (qmail 6139 invoked by uid 109); 10 Sep 2021 15:31:18 -0000
Received: from Unknown (HELO peff.net) (10.0.1.2)
 by cloud.peff.net (qpsmtpd/0.94) with ESMTP; Fri, 10 Sep 2021 15:31:18 +0000
Authentication-Results: cloud.peff.net; auth=none
Received: (qmail 26187 invoked by uid 111); 10 Sep 2021 15:31:18 -0000
Received: from coredump.intra.peff.net (HELO sigill.intra.peff.net) (10.0.0.2)
 by peff.net (qpsmtpd/0.94) with (TLS_AES_256_GCM_SHA384 encrypted) ESMTPS; Fri, 10 Sep 2021 11:31:18 -0400
Authentication-Results: peff.net; auth=none
Date:   Fri, 10 Sep 2021 11:31:17 -0400
From:   Jeff King <peff@peff.net>
To:     Gwyneth Morgan <gwymor@tilde.club>
Cc:     Fangyi Zhou <me@fangyi.io>, git@vger.kernel.org,
        Birger Skogeng Pedersen <birger.sp@gmail.com>,
        Birger Skogeng Pedersen <birgersp@gmail.com>,
        Brandon Williams <bwilliamseng@gmail.com>,
        Brandon Williams <bmwill@google.com>,
        CB Bailey <cbailey32@bloomberg.net>,
        Christopher =?utf-8?B?RMOtYXo=?= Riveros 
        <christopher.diaz.riv@gmail.com>,
        Christopher =?utf-8?B?RMOtYXo=?= Riveros <chrisadr@gentoo.org>,
        Ed Maste <emaste@freebsd.org>,
        =?utf-8?Q?Jean-No=C3=ABl?= Avila <jn.avila@free.fr>,
        Jean-Noel Avila <jean-noel.avila@scantech.fr>,
        Jessica Clarke <jrtc27@jrtc27.com>,
        Jiang Xin <worldhello.net@gmail.com>,
        Jiang Xin <zhiyou.jx@alibaba-inc.com>,
        Kazuhiro Kato <kato-k@ksysllc.co.jp>,
        Kazuhiro Kato <kazuhiro.kato@hotmail.co.jp>,
        Kevin Willford <Kevin.Willford@microsoft.com>,
        Kevin Willford <kewillf@microsoft.com>,
        Peter Kaestle <peter@piie.net>,
        Peter Kaestle <peter.kaestle@nokia.com>,
        Sibi Siddharthan <sibisiddharthan.github@gmail.com>,
        Sibi Siddharthan <sibisiv.siddharthan@gmail.com>,
        Slavica =?utf-8?B?xJB1a2nEhw==?= <slawica92@hotmail.com>,
        Slavica Djukic <slavicadj.ip2018@gmail.com>
Subject: Re: [PATCH] .mailmap: Update mailmap
Message-ID: <YTt6RTwJw64tYJRw@coredump.intra.peff.net>
References: <20210910130236.40101-1-me@fangyi.io>
 <YTt4RymWg+TOEmUf@tilde.club>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <YTt4RymWg+TOEmUf@tilde.club>
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

On Fri, Sep 10, 2021 at 03:22:47PM +0000, Gwyneth Morgan wrote:

> On 2021-09-10 14:02:36+0100, Fangyi Zhou wrote:
> > Similar to a35b13fce0 (Update .mailmap, 2018-11-09).
> > 
> > This patch makes the output of `git shortlog -nse v2.10.0..master`
> > duplicate-free by taking/guessing the current and preferred
> > addresses for authors that appear with more than one address.
> 
> The line for Jessica Clarke should probably just be
> 
> Jessica Clarke <jrtc27@jrtc27.com>
> 
> That works the same and doesn't put a reference to an old name.

Thanks, that's a good suggestion. I kind of wonder if these mass
mailmap-cleanup patches are a good idea in general. They are making
assumptions about how people want their names to be represented, and
whether and how they want any mappings to appear. Maybe that's something
we should be leaving to people to propose for their own identities.

Of course people who aren't active in the project anymore may not bother
to do the cleanup, and of course messy data makes me sad. But on the
whole, I'm not sure it's that big a deal either way.

-Peff
