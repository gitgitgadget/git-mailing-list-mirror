Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.7 required=3.0 tests=BAYES_00,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_CR_TRAILER,MAILING_LIST_MULTI,
	SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 41165C433E6
	for <git@archiver.kernel.org>; Tue,  2 Feb 2021 19:40:09 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 07E8964F2C
	for <git@archiver.kernel.org>; Tue,  2 Feb 2021 19:40:09 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S239847AbhBBTkD (ORCPT <rfc822;git@archiver.kernel.org>);
        Tue, 2 Feb 2021 14:40:03 -0500
Received: from cloud.peff.net ([104.130.231.41]:44900 "EHLO cloud.peff.net"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S239972AbhBBTji (ORCPT <rfc822;git@vger.kernel.org>);
        Tue, 2 Feb 2021 14:39:38 -0500
Received: (qmail 15520 invoked by uid 109); 2 Feb 2021 19:38:56 -0000
Received: from Unknown (HELO peff.net) (10.0.1.2)
 by cloud.peff.net (qpsmtpd/0.94) with ESMTP; Tue, 02 Feb 2021 19:38:56 +0000
Authentication-Results: cloud.peff.net; auth=none
Received: (qmail 6578 invoked by uid 111); 2 Feb 2021 19:38:56 -0000
Received: from coredump.intra.peff.net (HELO sigill.intra.peff.net) (10.0.0.2)
 by peff.net (qpsmtpd/0.94) with (TLS_AES_256_GCM_SHA384 encrypted) ESMTPS; Tue, 02 Feb 2021 14:38:56 -0500
Authentication-Results: peff.net; auth=none
Date:   Tue, 2 Feb 2021 14:38:55 -0500
From:   Jeff King <peff@peff.net>
To:     Junio C Hamano <gitster@pobox.com>
Cc:     Paul Jolly <paul@myitcv.io>, git@vger.kernel.org
Subject: Re: Bash completion suggests tags for git branch -D
Message-ID: <YBmqT/hvT9wM6yHz@coredump.intra.peff.net>
References: <CACoUkn6+9C3+HVVQF905t1siAD9Sqo1JvRa0Whw-J6x7V7icyg@mail.gmail.com>
 <YBkVFTOP6K1//i6m@coredump.intra.peff.net>
 <YBkZnY8X5VyNkXkR@coredump.intra.peff.net>
 <xmqqpn1igznk.fsf@gitster.c.googlers.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <xmqqpn1igznk.fsf@gitster.c.googlers.com>
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

On Tue, Feb 02, 2021 at 09:14:39AM -0800, Junio C Hamano wrote:

> > Oops. I meant to paste the "before" snippet, but this is obviously after
> > I stuck "-D" in there. It does seem to work. :)
> 
> ;-)
> 
> Before we forget, as you said a few times that everything you send
> here on Git are signed off...
> 
> -- >8 --
> From: Jeff King <peff@peff.net>
> Date: Tue Feb 2 04:02:13 2021 -0500
> Subject: [PATCH] completion: treat "branch -D" the same way as "branch -d"
> 
> Paul Jolly noticed that the former offers not just branches but tags
> as completion candidates.  Mimic how "branch -d" limits its suggestion
> to branch names.
> 
> Signed-off-by: Jeff King <peff@peff.net>
> Signed-off-by: Junio C Hamano <gitster@pobox.com>

Yeah, this looks fine (though Eric's reported-by suggestion seems
reasonable). I endorse the signoff. :)

I had also considered whether a test made sense, but I wasn't at all
familiar with the completion tests. It looks like we're not even testing
"-d", so I'm happy to proceed without one.

-Peff
