Return-Path: <SRS0=Lnee=43=vger.kernel.org=git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.8 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS autolearn=no autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 28642C10DCE
	for <git@archiver.kernel.org>; Tue, 10 Mar 2020 19:49:00 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id C7C7E208E4
	for <git@archiver.kernel.org>; Tue, 10 Mar 2020 19:48:59 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727124AbgCJTs6 (ORCPT <rfc822;git@archiver.kernel.org>);
        Tue, 10 Mar 2020 15:48:58 -0400
Received: from cloud.peff.net ([104.130.231.41]:35752 "HELO cloud.peff.net"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with SMTP
        id S1726545AbgCJTs6 (ORCPT <rfc822;git@vger.kernel.org>);
        Tue, 10 Mar 2020 15:48:58 -0400
Received: (qmail 26021 invoked by uid 109); 10 Mar 2020 19:48:58 -0000
Received: from Unknown (HELO peff.net) (10.0.1.2)
 by cloud.peff.net (qpsmtpd/0.94) with SMTP; Tue, 10 Mar 2020 19:48:58 +0000
Authentication-Results: cloud.peff.net; auth=none
Received: (qmail 14531 invoked by uid 111); 10 Mar 2020 19:58:17 -0000
Received: from coredump.intra.peff.net (HELO sigill.intra.peff.net) (10.0.0.2)
 by peff.net (qpsmtpd/0.94) with (TLS_AES_256_GCM_SHA384 encrypted) ESMTPS; Tue, 10 Mar 2020 15:58:17 -0400
Authentication-Results: peff.net; auth=none
Date:   Tue, 10 Mar 2020 15:48:57 -0400
From:   Jeff King <peff@peff.net>
To:     Junio C Hamano <gitster@pobox.com>
Cc:     Elijah Newren <newren@gmail.com>, git@vger.kernel.org
Subject: Re: [ANNOUNCE] Git v2.26.0-rc1
Message-ID: <20200310194857.GD549010@coredump.intra.peff.net>
References: <xmqqo8t4z29k.fsf@gitster-ct.c.googlers.com>
 <20200310174017.GA549010@coredump.intra.peff.net>
 <xmqqwo7shvt2.fsf@gitster.c.googlers.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <xmqqwo7shvt2.fsf@gitster.c.googlers.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

On Tue, Mar 10, 2020 at 12:08:41PM -0700, Junio C Hamano wrote:

> Hmph.  It might have been way premature to switch the default, then.
> 
> Introducing rebase.backend to allow adventurous to opt in early,
> while keeping the default backend same, may not be a bad way to
> avoid the regression in the upcoming release and to give us enough
> time deal with it after the release, perhaps?

Yeah, certainly that's the conservative route, and I don't mind it.

-Peff
