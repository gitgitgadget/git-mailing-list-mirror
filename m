Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-3.8 required=3.0 tests=BAYES_00,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,
	URIBL_BLOCKED autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 3E193C433E0
	for <git@archiver.kernel.org>; Thu, 21 Jan 2021 03:51:06 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id E6038238E4
	for <git@archiver.kernel.org>; Thu, 21 Jan 2021 03:51:05 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1732657AbhAUDsl (ORCPT <rfc822;git@archiver.kernel.org>);
        Wed, 20 Jan 2021 22:48:41 -0500
Received: from cloud.peff.net ([104.130.231.41]:33640 "EHLO cloud.peff.net"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S2393424AbhAUCzK (ORCPT <rfc822;git@vger.kernel.org>);
        Wed, 20 Jan 2021 21:55:10 -0500
Received: (qmail 32737 invoked by uid 109); 21 Jan 2021 02:54:14 -0000
Received: from Unknown (HELO peff.net) (10.0.1.2)
 by cloud.peff.net (qpsmtpd/0.94) with ESMTP; Thu, 21 Jan 2021 02:54:14 +0000
Authentication-Results: cloud.peff.net; auth=none
Received: (qmail 29581 invoked by uid 111); 21 Jan 2021 02:54:14 -0000
Received: from coredump.intra.peff.net (HELO sigill.intra.peff.net) (10.0.0.2)
 by peff.net (qpsmtpd/0.94) with (TLS_AES_256_GCM_SHA384 encrypted) ESMTPS; Wed, 20 Jan 2021 21:54:14 -0500
Authentication-Results: peff.net; auth=none
Date:   Wed, 20 Jan 2021 21:54:12 -0500
From:   Jeff King <peff@peff.net>
To:     Jacob Vosmaer <jacob@gitlab.com>
Cc:     Taylor Blau <me@ttaylorr.com>,
        Git Mailing List <git@vger.kernel.org>, avarab@gmail.com
Subject: Re: [PATCH v2 1/1] builtin/pack-objects.c: avoid iterating all refs
Message-ID: <YAjs1FjELfSdGhI+@coredump.intra.peff.net>
References: <20210120124514.49737-1-jacob@gitlab.com>
 <20210120124514.49737-2-jacob@gitlab.com>
 <YAhC8Gsp4H17e28n@nand.local>
 <YAhXw9Gvn5Pyvacq@coredump.intra.peff.net>
 <YAhYHUcdynbWyhwo@nand.local>
 <YAiIbEAZSlL7B+am@coredump.intra.peff.net>
 <CADMWQoPrKBjLM5ABhhhCibEyJVOXQxsNkncSU6dmwjynQ1oCcQ@mail.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <CADMWQoPrKBjLM5ABhhhCibEyJVOXQxsNkncSU6dmwjynQ1oCcQ@mail.gmail.com>
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

On Wed, Jan 20, 2021 at 10:46:29PM +0100, Jacob Vosmaer wrote:

> On Wed, Jan 20, 2021 at 8:45 PM Jeff King <peff@peff.net> wrote:
> 
> > I also rage-replaced peel_ref() with a function taking an oid so we
> > never have to do that digging again. Posted separately in its own
> > thread.
> 
> That sounds like a good solution. Where does that leave my patch? Do I
> need to wait for that new commit somehow? I don't know how that works,
> "contributing to Git" wise.

Nope, you shouldn't need to do anything. The conflict is minimal
enough that the two can proceed independently, and the maintainer can
resolve it.

-Peff
