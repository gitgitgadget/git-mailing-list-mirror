Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-3.8 required=3.0 tests=BAYES_00,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,
	URIBL_BLOCKED autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id E83A9C47082
	for <git@archiver.kernel.org>; Tue,  8 Jun 2021 07:10:38 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id CA2A561263
	for <git@archiver.kernel.org>; Tue,  8 Jun 2021 07:10:38 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229797AbhFHHMa (ORCPT <rfc822;git@archiver.kernel.org>);
        Tue, 8 Jun 2021 03:12:30 -0400
Received: from cloud.peff.net ([104.130.231.41]:48684 "EHLO cloud.peff.net"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S229507AbhFHHM3 (ORCPT <rfc822;git@vger.kernel.org>);
        Tue, 8 Jun 2021 03:12:29 -0400
Received: (qmail 28533 invoked by uid 109); 8 Jun 2021 07:10:36 -0000
Received: from Unknown (HELO peff.net) (10.0.1.2)
 by cloud.peff.net (qpsmtpd/0.94) with ESMTP; Tue, 08 Jun 2021 07:10:36 +0000
Authentication-Results: cloud.peff.net; auth=none
Received: (qmail 7285 invoked by uid 111); 8 Jun 2021 07:10:38 -0000
Received: from coredump.intra.peff.net (HELO sigill.intra.peff.net) (10.0.0.2)
 by peff.net (qpsmtpd/0.94) with (TLS_AES_256_GCM_SHA384 encrypted) ESMTPS; Tue, 08 Jun 2021 03:10:38 -0400
Authentication-Results: peff.net; auth=none
Date:   Tue, 8 Jun 2021 03:10:36 -0400
From:   Jeff King <peff@peff.net>
To:     Derrick Stolee via GitGitGadget <gitgitgadget@gmail.com>
Cc:     git@vger.kernel.org, gitster@pobox.com,
        sandals@crustytoothpaste.net, stolee@gmail.com, jrnieder@gmail.com,
        emilyshaffer@google.com, Derrick Stolee <derrickstolee@github.com>,
        Derrick Stolee <dstolee@microsoft.com>
Subject: Re: [PATCH 4/4] CodingGuidelines: recommend singular they
Message-ID: <YL8X7PepIggpKlSl@coredump.intra.peff.net>
References: <pull.975.git.1623085069.gitgitgadget@gmail.com>
 <d2c079264955b3bd6c3a5ef77a9c3684206f8475.1623085069.git.gitgitgadget@gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <d2c079264955b3bd6c3a5ef77a9c3684206f8475.1623085069.git.gitgitgadget@gmail.com>
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

On Mon, Jun 07, 2021 at 04:57:48PM +0000, Derrick Stolee via GitGitGadget wrote:

> If we use singular "they/them" pronouns instead of "he/him" or "she/her"
> pronouns, then we can avoid this congitive load on the reader.
> 
> Using singular "they" is also incredibly efficient. Choosing a gendered
> pronoun is usually arbitrary between "he" or "she". Using constructs
> such as "he or she", "s/he", or "(s)he" are more complicated than
> singular "they".

In general, I do like the efficiency and readability of singular "they".
As a native speaker, I have no problem reading it, and I have little
sense that most of my native-speaker acquaintances would, either.

I _do_ worry that it would be jarring or difficult to read for
non-native speakers (or perhaps native speakers who aren't in my circle
of acquaintances). There have been a few comments to that effect on the
list, but it's hard to consider that data and not anecdotes.

One thing that gives me some comfort is your research here:

> Perhaps due to similar reasons, official style guides have changed their
> stance on singuler "they" in recent years. For example, the APA style
> guide changed their official recommendation in 2019 [1]. The MLA
> handbook also references helpful ways to use singular "they" [2]. While
> not fully endorsing it, the Chicago Manual of Style has removed its
> blanket ban on singular "they" [3] (the previous recommendation was to
> only use "it" as a singular non-gendered pronoun).
> 
> [1] https://apastyle.apa.org/blog/singular-they
> [2] https://style.mla.org/using-singular-they/
> [3] https://libraries.indiana.edu/chicago-manual-style-singular-pronoun-they

I don't know to what degree those style guidelines take into account
non-native speakers. But they at least provide a sense that this style
is in wide-ish use. And probably growing use, as well, considering that
they have changed recently. So even if it may be surprising to some
readers at first, I hope it may become less so as time goes on and
projects (like ours) make it more commonplace.

(You could perhaps argue the same "it may become less surprising over
time" for something like "xe", but that one does not seem to be in
particularly wide or growing use, from my experience).

So I think this is a reasonable style suggestion to put in our
guidelines.

-Peff
