Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-3.8 required=3.0 tests=BAYES_00,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS
	autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id A655FC433F5
	for <git@archiver.kernel.org>; Sat, 11 Sep 2021 14:47:24 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 8328961206
	for <git@archiver.kernel.org>; Sat, 11 Sep 2021 14:47:24 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229971AbhIKOsg (ORCPT <rfc822;git@archiver.kernel.org>);
        Sat, 11 Sep 2021 10:48:36 -0400
Received: from cloud.peff.net ([104.130.231.41]:44918 "EHLO cloud.peff.net"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S229633AbhIKOsf (ORCPT <rfc822;git@vger.kernel.org>);
        Sat, 11 Sep 2021 10:48:35 -0400
Received: (qmail 12480 invoked by uid 109); 11 Sep 2021 14:47:22 -0000
Received: from Unknown (HELO peff.net) (10.0.1.2)
 by cloud.peff.net (qpsmtpd/0.94) with ESMTP; Sat, 11 Sep 2021 14:47:22 +0000
Authentication-Results: cloud.peff.net; auth=none
Received: (qmail 20812 invoked by uid 111); 11 Sep 2021 14:47:21 -0000
Received: from coredump.intra.peff.net (HELO sigill.intra.peff.net) (10.0.0.2)
 by peff.net (qpsmtpd/0.94) with (TLS_AES_256_GCM_SHA384 encrypted) ESMTPS; Sat, 11 Sep 2021 10:47:21 -0400
Authentication-Results: peff.net; auth=none
Date:   Sat, 11 Sep 2021 10:47:21 -0400
From:   Jeff King <peff@peff.net>
To:     Junio C Hamano <gitster@pobox.com>
Cc:     Gwyneth Morgan <gwymor@tilde.club>, Fangyi Zhou <me@fangyi.io>,
        git@vger.kernel.org, Birger Skogeng Pedersen <birger.sp@gmail.com>,
        Birger Skogeng Pedersen <birgersp@gmail.com>,
        Brandon Williams <bwilliamseng@gmail.com>,
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
Message-ID: <YTzBef1JuSCKl1tX@coredump.intra.peff.net>
References: <20210910130236.40101-1-me@fangyi.io>
 <YTt4RymWg+TOEmUf@tilde.club>
 <YTt6RTwJw64tYJRw@coredump.intra.peff.net>
 <xmqqa6kkosst.fsf@gitster.g>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <xmqqa6kkosst.fsf@gitster.g>
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

On Fri, Sep 10, 2021 at 05:32:50PM -0700, Junio C Hamano wrote:

> Which leads me to suggest something like the attached patch.  I
> wrote "Please notify us" for those who are no longer active and
> forgot how .mailmap entries are spelled to ask for help correcting.

FWIW, that seems like a quite reasonable addition to me.

-Peff
