Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-3.8 required=3.0 tests=BAYES_00,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS
	autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 91F6EC48BE5
	for <git@archiver.kernel.org>; Wed, 16 Jun 2021 12:00:47 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 6943661356
	for <git@archiver.kernel.org>; Wed, 16 Jun 2021 12:00:47 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232784AbhFPMCw (ORCPT <rfc822;git@archiver.kernel.org>);
        Wed, 16 Jun 2021 08:02:52 -0400
Received: from cloud.peff.net ([104.130.231.41]:57460 "EHLO cloud.peff.net"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S232774AbhFPMCu (ORCPT <rfc822;git@vger.kernel.org>);
        Wed, 16 Jun 2021 08:02:50 -0400
Received: (qmail 12786 invoked by uid 109); 16 Jun 2021 12:00:44 -0000
Received: from Unknown (HELO peff.net) (10.0.1.2)
 by cloud.peff.net (qpsmtpd/0.94) with ESMTP; Wed, 16 Jun 2021 12:00:44 +0000
Authentication-Results: cloud.peff.net; auth=none
Received: (qmail 25968 invoked by uid 111); 16 Jun 2021 12:00:44 -0000
Received: from coredump.intra.peff.net (HELO sigill.intra.peff.net) (10.0.0.2)
 by peff.net (qpsmtpd/0.94) with (TLS_AES_256_GCM_SHA384 encrypted) ESMTPS; Wed, 16 Jun 2021 08:00:44 -0400
Authentication-Results: peff.net; auth=none
Date:   Wed, 16 Jun 2021 08:00:43 -0400
From:   Jeff King <peff@peff.net>
To:     "Robert P. J. Day" <rpjday@crashcourse.ca>
Cc:     Junio C Hamano <gitster@pobox.com>,
        =?utf-8?B?w4Z2YXIgQXJuZmrDtnLDsA==?= Bjarmason <avarab@gmail.com>,
        git@vger.kernel.org, Derrick Stolee <stolee@gmail.com>,
        Felipe Contreras <felipe.contreras@gmail.com>,
        Bagas Sanjaya <bagasdotme@gmail.com>,
        Robert Karszniewicz <avoidr@posteo.de>,
        Emily Shaffer <emilyshaffer@google.com>
Subject: Re: [PATCH 0/6] doc: replace "alice" and "bob" examples
Message-ID: <YMnn64zrMO1T1HTY@coredump.intra.peff.net>
References: <cover-0.6-00000000000-20210615T161330Z-avarab@gmail.com>
 <xmqqfsxitw2n.fsf@gitster.g>
 <9217211e-aa26-c1c9-2528-a29b93ff174e@crashcourse.ca>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <9217211e-aa26-c1c9-2528-a29b93ff174e@crashcourse.ca>
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

On Wed, Jun 16, 2021 at 05:30:14AM -0400, Robert P. J. Day wrote:

> On Wed, 16 Jun 2021, Junio C Hamano wrote:
> 
> > Ævar Arnfjörð Bjarmason  <avarab@gmail.com> writes:
> >
> > > I suggested in [1] that the "alice" and "bob" examples in our
> > > documentation would be better written without a reference to such
> > > fictional characters, for reasons that have nothing to do with trying
> > > to bend over backwards to avoid any reference to people's gender. It
> > > just makes for better documentation.
> >
> > I actually do not mind cast of characters with concrete names,
> > especially when there are more than three parties involved and
> > having names for them help clarify the description.  But I agree
> > with you that Alice and Bob should be reserved for situations where
> > appearance of Eve would reasonably be anticipated, or the use of
> > these two names become distracting to those who happen to be aware
> > how these characters are often used in CS literature.
> >
> > Perhaps s/Alice/Tabby/ and s/Bob/Fido/ or something like that ;-)?
> 
>   i look forward to the renaming of "git" to something more innocuous
> and palatable because, somewhere, someone could conceivably,
> hypothetically, theoretically take exception to it.
> 
>   seriously, can we start a second mailing list where people want to
> talk about, you know, version control?

Can you please tone down your responses a bit?

One of the points under discussion here is whether those names end up
being confusing to users because of their use in other places (like
cryptographic examples). And I think the comprehensibility of our
documentation is quite relevant to the project.

But even if this were done purely for reasons of gender-neutrality, I
still think your response is inappropriate. You are quite welcome to
argue against such a change, but snarky or dismissive responses aren't
welcome.

(I'm referring to the last paragraph of your other response in this
thread, too. I did find the wikipedia link you sent earlier helpful to
the discussion, and personally I don't find the names confusing at all,
for the reasons it mentioned. But that may not be universal).

-Peff
