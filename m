Return-Path: <SRS0=Ny9l=7D=vger.kernel.org=git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.8 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS autolearn=no autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 1BB13C433E0
	for <git@archiver.kernel.org>; Thu, 21 May 2020 18:35:39 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id EC97B20738
	for <git@archiver.kernel.org>; Thu, 21 May 2020 18:35:38 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729193AbgEUSfi (ORCPT <rfc822;git@archiver.kernel.org>);
        Thu, 21 May 2020 14:35:38 -0400
Received: from cloud.peff.net ([104.130.231.41]:53788 "EHLO cloud.peff.net"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1728240AbgEUSfh (ORCPT <rfc822;git@vger.kernel.org>);
        Thu, 21 May 2020 14:35:37 -0400
Received: (qmail 15000 invoked by uid 109); 21 May 2020 18:35:37 -0000
Received: from Unknown (HELO peff.net) (10.0.1.2)
 by cloud.peff.net (qpsmtpd/0.94) with ESMTP; Thu, 21 May 2020 18:35:37 +0000
Authentication-Results: cloud.peff.net; auth=none
Received: (qmail 29920 invoked by uid 111); 21 May 2020 18:35:37 -0000
Received: from coredump.intra.peff.net (HELO sigill.intra.peff.net) (10.0.0.2)
 by peff.net (qpsmtpd/0.94) with (TLS_AES_256_GCM_SHA384 encrypted) ESMTPS; Thu, 21 May 2020 14:35:37 -0400
Authentication-Results: peff.net; auth=none
Date:   Thu, 21 May 2020 14:35:36 -0400
From:   Jeff King <peff@peff.net>
To:     Junio C Hamano <gitster@pobox.com>
Cc:     Denton Liu <liu.denton@gmail.com>,
        Git Mailing List <git@vger.kernel.org>,
        Taylor Blau <me@ttaylorr.com>, Johannes Sixt <j6t@kdbg.org>,
        Eric Sunshine <sunshine@sunshineco.com>
Subject: Re: [PATCH v2 0/4] t: replace incorrect test_must_fail usage (part 5)
Message-ID: <20200521183536.GA1308489@coredump.intra.peff.net>
References: <cover.1588162842.git.liu.denton@gmail.com>
 <cover.1590019226.git.liu.denton@gmail.com>
 <xmqq8shlteud.fsf@gitster.c.googlers.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <xmqq8shlteud.fsf@gitster.c.googlers.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

On Thu, May 21, 2020 at 09:47:22AM -0700, Junio C Hamano wrote:

> Denton Liu <liu.denton@gmail.com> writes:
> 
> > Hi all,
> >
> > This is mostly a resend of what's currently queued in
> > "dl/test-must-fail-fixes-5" except with a tiny bit of cleanup on the tip
> > patch. I'd appreciate a review on this series so that we can finally get
> > rid of that "Needs review" on the What's Cooking messages ;)
> 
> Thanks.  
> 
> The OVERWRITING_FAIL one was the only one I was unhappy about, so it
> would be good to have more eyeballs on it---perhaps other people
> find the approach acceptable, or can suggest more readable and
> understandable approach.

FWIW, I don't really like it either. :) I gave my best shot at an
alternative in reply to that patch.

-Peff
