Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-3.8 required=3.0 tests=BAYES_00,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS
	autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 99066C4361B
	for <git@archiver.kernel.org>; Wed,  9 Dec 2020 17:12:46 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 6B51923C30
	for <git@archiver.kernel.org>; Wed,  9 Dec 2020 17:12:46 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1730954AbgLIRMa (ORCPT <rfc822;git@archiver.kernel.org>);
        Wed, 9 Dec 2020 12:12:30 -0500
Received: from cloud.peff.net ([104.130.231.41]:55708 "EHLO cloud.peff.net"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1730313AbgLIRMa (ORCPT <rfc822;git@vger.kernel.org>);
        Wed, 9 Dec 2020 12:12:30 -0500
Received: (qmail 18640 invoked by uid 109); 9 Dec 2020 17:11:49 -0000
Received: from Unknown (HELO peff.net) (10.0.1.2)
 by cloud.peff.net (qpsmtpd/0.94) with ESMTP; Wed, 09 Dec 2020 17:11:49 +0000
Authentication-Results: cloud.peff.net; auth=none
Received: (qmail 16865 invoked by uid 111); 9 Dec 2020 17:11:49 -0000
Received: from coredump.intra.peff.net (HELO sigill.intra.peff.net) (10.0.0.2)
 by peff.net (qpsmtpd/0.94) with (TLS_AES_256_GCM_SHA384 encrypted) ESMTPS; Wed, 09 Dec 2020 12:11:48 -0500
Authentication-Results: peff.net; auth=none
Date:   Wed, 9 Dec 2020 12:11:48 -0500
From:   Jeff King <peff@peff.net>
To:     Felipe Contreras <felipe.contreras@gmail.com>
Cc:     git@vger.kernel.org, Junio C Hamano <gitster@pobox.com>,
        Emily Shaffer <emilyshaffer@google.com>,
        "Brian M. Carlson" <sandals@crustytoothpaste.net>,
        Aaron Schrab <aaron@schrab.com>,
        Denton Liu <liu.denton@gmail.com>,
        Christian Couder <christian.couder@gmail.com>
Subject: Re: [PATCH v2 0/2] vim: configuration and sharness syntax
Message-ID: <X9EFVIlm8sYKtLwr@coredump.intra.peff.net>
References: <20201209065537.48802-1-felipe.contreras@gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <20201209065537.48802-1-felipe.contreras@gmail.com>
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

On Wed, Dec 09, 2020 at 12:55:35AM -0600, Felipe Contreras wrote:

> After investigating alternatives for exrc I found too many, doing a wide
> range of irrelevant stuff, many unmaintained, others requiring multiple
> dependencies, and some loaded the configuration too late.

I'm not opposed to this solution, but I probably wouldn't use it myself.
I wonder if it would be sufficient to just say "here are some sensible
vim options", coupled with human-readable instructions for how to
integrate them into your .vimrc, along with some path-selection.

It's perhaps not quite as turnkey. On the other hand, it's easy for
people who are even moderate vim users to understand what each line
does. In the plugin solution, there are more lines dedicated to loading
the config than there are actual config lines.

I dunno.

> And since I already created some files in 'contrib/vim' I decided to put
> the sharness syntax file there too.

This part I like very much. The actual policy logic is sufficiently
complex that I hope people will be able to contribute back small fixes.

-Peff
