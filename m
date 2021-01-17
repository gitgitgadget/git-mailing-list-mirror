Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-3.8 required=3.0 tests=BAYES_00,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS
	autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 53D50C433E0
	for <git@archiver.kernel.org>; Sun, 17 Jan 2021 17:16:25 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 22FB32222B
	for <git@archiver.kernel.org>; Sun, 17 Jan 2021 17:16:25 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729846AbhAQRQJ (ORCPT <rfc822;git@archiver.kernel.org>);
        Sun, 17 Jan 2021 12:16:09 -0500
Received: from cloud.peff.net ([104.130.231.41]:58564 "EHLO cloud.peff.net"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1728181AbhAQRQI (ORCPT <rfc822;git@vger.kernel.org>);
        Sun, 17 Jan 2021 12:16:08 -0500
Received: (qmail 21580 invoked by uid 109); 17 Jan 2021 17:15:27 -0000
Received: from Unknown (HELO peff.net) (10.0.1.2)
 by cloud.peff.net (qpsmtpd/0.94) with ESMTP; Sun, 17 Jan 2021 17:15:27 +0000
Authentication-Results: cloud.peff.net; auth=none
Received: (qmail 16409 invoked by uid 111); 17 Jan 2021 17:15:27 -0000
Received: from coredump.intra.peff.net (HELO sigill.intra.peff.net) (10.0.0.2)
 by peff.net (qpsmtpd/0.94) with (TLS_AES_256_GCM_SHA384 encrypted) ESMTPS; Sun, 17 Jan 2021 12:15:27 -0500
Authentication-Results: peff.net; auth=none
Date:   Sun, 17 Jan 2021 12:15:26 -0500
From:   Jeff King <peff@peff.net>
To:     =?utf-8?B?w4Z2YXIgQXJuZmrDtnLDsA==?= Bjarmason <avarab@gmail.com>
Cc:     Emily Shaffer <emilyshaffer@google.com>,
        Junio C Hamano <gitster@pobox.com>,
        "brian m. carlson" <sandals@crustytoothpaste.net>,
        git@vger.kernel.org
Subject: Re: What's cooking in git.git (Jan 2021, #02; Fri, 8)
Message-ID: <YARwrtU9u51s13S0@coredump.intra.peff.net>
References: <xmqqk0sni68g.fsf@gitster.c.googlers.com>
 <871reu752k.fsf@evledraar.gmail.com>
 <xmqqk0slg5ph.fsf@gitster.c.googlers.com>
 <X/oosXBJlyt/IrOr@camp.crustytoothpaste.net>
 <xmqq4kjpelza.fsf@gitster.c.googlers.com>
 <X/uvhc5Hpu792qA/@camp.crustytoothpaste.net>
 <xmqqeeir8fdg.fsf@gitster.c.googlers.com>
 <87k0si5k75.fsf@evledraar.gmail.com>
 <YADZSsVqyGnArF0n@google.com>
 <87im7w4zqt.fsf@evledraar.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <87im7w4zqt.fsf@evledraar.gmail.com>
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

On Sat, Jan 16, 2021 at 05:23:38PM +0100, Ævar Arnfjörð Bjarmason wrote:

> > [...] especially when that pushback is "I'd like to write a tool to
> > reverse this thing, because <vague reasons> - and I don't mean that
> > tool maliciously so that should be OK."
> 
> ... this point in particular seems to be an attempt to summarize my
> views or motivations.
> 
> I don't see how you could read my E-Mails on the subject (especially
> what you're replying to,
> https://lore.kernel.org/git/87k0si5k75.fsf@evledraar.gmail.com/) and
> think that in any way reflects my views on the matter.
> 
> In lieu of repeating much/any of that I'll just say that that doesn't in
> any way reflect my views, and from having read all the rest of the
> message traffic associated with this topic I don't see who else you
> could be referring to with those comments.

This is sort orthogonal to what you're saying here, and possibly I
missed this part of the discussion, but...I'm confused about this
talk of a tool for unblinding the mailmap. Isn't:

  git log --all --format='%aE %ae'

basically that tool already?

-Peff
