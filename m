Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id C46ACC636CC
	for <git@archiver.kernel.org>; Tue,  7 Feb 2023 22:16:56 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229896AbjBGWQz (ORCPT <rfc822;git@archiver.kernel.org>);
        Tue, 7 Feb 2023 17:16:55 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:56734 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229661AbjBGWQz (ORCPT <rfc822;git@vger.kernel.org>);
        Tue, 7 Feb 2023 17:16:55 -0500
Received: from cloud.peff.net (cloud.peff.net [104.130.231.41])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id CC37030D5
        for <git@vger.kernel.org>; Tue,  7 Feb 2023 14:16:48 -0800 (PST)
Received: (qmail 13772 invoked by uid 109); 7 Feb 2023 22:16:48 -0000
Received: from Unknown (HELO peff.net) (10.0.1.2)
 by cloud.peff.net (qpsmtpd/0.94) with ESMTP; Tue, 07 Feb 2023 22:16:48 +0000
Authentication-Results: cloud.peff.net; auth=none
Received: (qmail 25345 invoked by uid 111); 7 Feb 2023 22:16:47 -0000
Received: from coredump.intra.peff.net (HELO sigill.intra.peff.net) (10.0.0.2)
 by peff.net (qpsmtpd/0.94) with (TLS_AES_256_GCM_SHA384 encrypted) ESMTPS; Tue, 07 Feb 2023 17:16:47 -0500
Authentication-Results: peff.net; auth=none
Date:   Tue, 7 Feb 2023 17:16:47 -0500
From:   Jeff King <peff@peff.net>
To:     Junio C Hamano <gitster@pobox.com>
Cc:     =?utf-8?B?w4Z2YXIgQXJuZmrDtnLDsA==?= Bjarmason <avarab@gmail.com>,
        git@vger.kernel.org, Jiang Xin <worldhello.net@gmail.com>,
        Bernhard Reiter <ockham@raz.or.at>,
        Remi Pommarel <repk@triplefau.lt>
Subject: Re: [PATCH v2 6/6] imap-send: correctly report "host" when using
 "tunnel"
Message-ID: <Y+LNz+o3V8te7/c6@coredump.intra.peff.net>
References: <patch-1.1-3bea1312322-20230201T225915Z-avarab@gmail.com>
 <cover-v2-0.6-00000000000-20230202T093706Z-avarab@gmail.com>
 <patch-v2-6.6-686febb8cdc-20230202T093706Z-avarab@gmail.com>
 <Y91J+P5P9gV1Dygm@coredump.intra.peff.net>
 <230203.86bkmabfjr.gmgdl@evledraar.gmail.com>
 <Y94866yd3adoC1o9@coredump.intra.peff.net>
 <230205.86ilgf7osb.gmgdl@evledraar.gmail.com>
 <Y+KYwsBjty0aaLes@coredump.intra.peff.net>
 <230207.86fsbh2nqo.gmgdl@evledraar.gmail.com>
 <xmqq8rh9yxot.fsf@gitster.g>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <xmqq8rh9yxot.fsf@gitster.g>
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

On Tue, Feb 07, 2023 at 01:26:10PM -0800, Junio C Hamano wrote:

> Ævar Arnfjörð Bjarmason <avarab@gmail.com> writes:
> 
> > I think you might be right that people might rely on this after having
> > discovered this undocumented interaction by accident.
> >
> > But I also think that the lack of questions about how to get imap-send's
> > tunnel mode to work with auth helpers (at least I couldn't find any
> > on-list), which is what you'd run into if you went by the documentation
> > & were trying to get htat ot work, is a pretty good sign that this may
> > be either entirely unused by anyone, or at best very obscure.
> 
> I actually think the misconfiguration (from documentation's point of
> view) Peff is taking advantage of is a behaviour you would naturally
> expect, if you do not read the documentation but are merely aware of
> the presence of .host and .tunnel and guess what these do. 

Just to be clear, I am not taking advantage of anything. I do not use
imap-send myself, because a much better solution is to have a decent
mail client that can access both imap and local maildirs. ;)

I was only trying to offer some perspective as a general imap-tunnel
user.

-Peff
