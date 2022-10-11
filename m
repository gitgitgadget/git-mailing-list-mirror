Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 5A0B4C433F5
	for <git@archiver.kernel.org>; Tue, 11 Oct 2022 00:23:49 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229472AbiJKAXs (ORCPT <rfc822;git@archiver.kernel.org>);
        Mon, 10 Oct 2022 20:23:48 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:55644 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229461AbiJKAXr (ORCPT <rfc822;git@vger.kernel.org>);
        Mon, 10 Oct 2022 20:23:47 -0400
Received: from cloud.peff.net (cloud.peff.net [104.130.231.41])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 9A379804B0
        for <git@vger.kernel.org>; Mon, 10 Oct 2022 17:23:45 -0700 (PDT)
Received: (qmail 29711 invoked by uid 109); 11 Oct 2022 00:23:45 -0000
Received: from Unknown (HELO peff.net) (10.0.1.2)
 by cloud.peff.net (qpsmtpd/0.94) with ESMTP; Tue, 11 Oct 2022 00:23:45 +0000
Authentication-Results: cloud.peff.net; auth=none
Received: (qmail 15149 invoked by uid 111); 11 Oct 2022 00:23:46 -0000
Received: from coredump.intra.peff.net (HELO sigill.intra.peff.net) (10.0.0.2)
 by peff.net (qpsmtpd/0.94) with (TLS_AES_256_GCM_SHA384 encrypted) ESMTPS; Mon, 10 Oct 2022 20:23:46 -0400
Authentication-Results: peff.net; auth=none
Date:   Mon, 10 Oct 2022 20:23:44 -0400
From:   Jeff King <peff@peff.net>
To:     Junio C Hamano <gitster@pobox.com>
Cc:     git@vger.kernel.org
Subject: Re: [PATCH 4alt/4] attr: drop DEBUG_ATTR code
Message-ID: <Y0S3kKVm0jYxEXc1@coredump.intra.peff.net>
References: <Yz7Tjy7Rh8cXVxYQ@coredump.intra.peff.net>
 <Yz7UhYXvNl6+1GbZ@coredump.intra.peff.net>
 <Yz7Wx4kVbrZFfm0s@coredump.intra.peff.net>
 <xmqqwn9clwba.fsf@gitster.g>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <xmqqwn9clwba.fsf@gitster.g>
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

On Thu, Oct 06, 2022 at 10:02:33AM -0700, Junio C Hamano wrote:

> Jeff King <peff@peff.net> writes:
> 
> > On Thu, Oct 06, 2022 at 09:13:41AM -0400, Jeff King wrote:
> >
> >> The other obvious option is to just delete this debug code, and remove
> >> the unused parameter. I'm not sure if the trace would ever be useful or
> >> not, and I am mostly retaining it out of the logic of "well, somebody
> >> bothered to write it". I think the const issue has been there since
> >> e810e06357 (attr: tighten const correctness with git_attr and
> >> match_attr, 2017-01-27).
> >
> > And here's what that would look like.
> 
> I highly suspect that I was the one who bothered, and while I admit
> it was useful while developing the attribute subsystem, I haven't
> needed it for the past 10 or so years.

It was indeed you. :) I am quite happy to delete the code (via 4alt),
but didn't want to step on any toes.

-Peff
