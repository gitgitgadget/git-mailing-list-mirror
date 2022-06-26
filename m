Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 03EF0C43334
	for <git@archiver.kernel.org>; Sun, 26 Jun 2022 21:03:22 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230477AbiFZVDV (ORCPT <rfc822;git@archiver.kernel.org>);
        Sun, 26 Jun 2022 17:03:21 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:58052 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229722AbiFZVDU (ORCPT <rfc822;git@vger.kernel.org>);
        Sun, 26 Jun 2022 17:03:20 -0400
Received: from cloud.peff.net (cloud.peff.net [104.130.231.41])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id DB86210C0
        for <git@vger.kernel.org>; Sun, 26 Jun 2022 14:03:16 -0700 (PDT)
Received: (qmail 19257 invoked by uid 109); 26 Jun 2022 21:03:16 -0000
Received: from Unknown (HELO peff.net) (10.0.1.2)
 by cloud.peff.net (qpsmtpd/0.94) with ESMTP; Sun, 26 Jun 2022 21:03:16 +0000
Authentication-Results: cloud.peff.net; auth=none
Received: (qmail 10768 invoked by uid 111); 26 Jun 2022 21:03:14 -0000
Received: from coredump.intra.peff.net (HELO sigill.intra.peff.net) (10.0.0.2)
 by peff.net (qpsmtpd/0.94) with (TLS_AES_256_GCM_SHA384 encrypted) ESMTPS; Sun, 26 Jun 2022 17:03:14 -0400
Authentication-Results: peff.net; auth=none
Date:   Sun, 26 Jun 2022 17:03:14 -0400
From:   Jeff King <peff@peff.net>
To:     Fernando Ramos <greenfoo@u92.eu>
Cc:     Junio C Hamano <gitster@pobox.com>, git@vger.kernel.org
Subject: Re: [ANNOUNCE] Git v2.37.0-rc2
Message-ID: <YrjJkuX6diZiF/SM@coredump.intra.peff.net>
References: <xmqqedzg4hqj.fsf@gitster.g>
 <Yrii4Wj+c0YuQy61@zacax395.localdomain>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <Yrii4Wj+c0YuQy61@zacax395.localdomain>
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

On Sun, Jun 26, 2022 at 08:18:09PM +0200, Fernando Ramos wrote:

> On 22/06/22 12:32PM, Junio C Hamano wrote:
> >  * "vimdiff[123]" mergetool drivers have been reimplemented with a
> >    more generic layout mechanism.
> 
> Hi. Maybe because this is my first contribution to git I was strangely excited
> and decided to create a small blog post describing how the new mechanism works.
> [...]
> PS: Please let me know if this type of message is not appropriate for this
> mailing list and I will never do it again... I just thought it might be good to
> explain the new feature in a blog post to prevent it from going unnoticied
> considering how "hidden" the new configuration variable is. Thanks!

No, this is very cool. Describing your changes to the greater world is
very welcome, and letting people here know about it is good.

One thing I would suggest, though: many folks on the list use the
presence of their email in the "to" or "cc" of a message to help
prioritize (i.e., to see responses directly to them which may need a
response, versus general list chatter). You can imagine that Junio
especially gets a lot of emails. :) So for something like this that's
more of general interest than an email to a specific person, I'd usually
either bump them down to "cc" rather than "to" (using the list address
for "to"), or even remove them entirely from the headers (and they may
read it from the general list like everyone else).

Congratulations on making your first contribution to Git!

-Peff
