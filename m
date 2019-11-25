Return-Path: <SRS0=39iz=ZR=vger.kernel.org=git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.8 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS autolearn=no autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 01D50C432C0
	for <git@archiver.kernel.org>; Mon, 25 Nov 2019 09:34:03 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id CE1B320823
	for <git@archiver.kernel.org>; Mon, 25 Nov 2019 09:34:02 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727295AbfKYJeB (ORCPT <rfc822;git@archiver.kernel.org>);
        Mon, 25 Nov 2019 04:34:01 -0500
Received: from cloud.peff.net ([104.130.231.41]:59714 "HELO cloud.peff.net"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with SMTP
        id S1727006AbfKYJeB (ORCPT <rfc822;git@vger.kernel.org>);
        Mon, 25 Nov 2019 04:34:01 -0500
Received: (qmail 25418 invoked by uid 109); 25 Nov 2019 09:34:01 -0000
Received: from Unknown (HELO peff.net) (10.0.1.2)
 by cloud.peff.net (qpsmtpd/0.94) with SMTP; Mon, 25 Nov 2019 09:34:01 +0000
Authentication-Results: cloud.peff.net; auth=none
Received: (qmail 16830 invoked by uid 111); 25 Nov 2019 09:38:00 -0000
Received: from sigill.intra.peff.net (HELO sigill.intra.peff.net) (10.0.0.7)
 by peff.net (qpsmtpd/0.94) with (TLS_AES_256_GCM_SHA384 encrypted) ESMTPS; Mon, 25 Nov 2019 04:38:00 -0500
Authentication-Results: peff.net; auth=none
Date:   Mon, 25 Nov 2019 04:34:00 -0500
From:   Jeff King <peff@peff.net>
To:     Junio C Hamano <gitster@pobox.com>
Cc:     Hariom Verma via GitGitGadget <gitgitgadget@gmail.com>,
        git@vger.kernel.org, Hariom Verma <hariom18599@gmail.com>
Subject: Re: [PATCH 1/1] git-compat-util.h: drop the `PRIuMAX` definition
Message-ID: <20191125093400.GA25851@sigill.intra.peff.net>
References: <pull.473.git.1574600963.gitgitgadget@gmail.com>
 <177deddcf83c2550c0db536a7a6942ba69a92fa5.1574600963.git.gitgitgadget@gmail.com>
 <20191124170643.GA16907@sigill.intra.peff.net>
 <xmqq1rtwzoal.fsf@gitster-ct.c.googlers.com>
 <xmqqv9r8y8qe.fsf@gitster-ct.c.googlers.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <xmqqv9r8y8qe.fsf@gitster-ct.c.googlers.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

On Mon, Nov 25, 2019 at 11:45:29AM +0900, Junio C Hamano wrote:

> Junio C Hamano <gitster@pobox.com> writes:
> 
> >> Can we likewise ditch the fallback definition for SCNuMAX? And PRIu32,
> >> etc? It seems likely any platform would either have all of them or none.
> >
> > I guess that's also a C99-ism that we can use?
> >
> > Thanks, both.
> 
> Here is what I have locally for now.

Yes, that looks good to me (and yes, those other format macros are in
C99, too).

-Peff
