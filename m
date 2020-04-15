Return-Path: <SRS0=MaRY=57=vger.kernel.org=git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.7 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED autolearn=no
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 2851AC2BA19
	for <git@archiver.kernel.org>; Wed, 15 Apr 2020 21:57:37 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 0F4EC20774
	for <git@archiver.kernel.org>; Wed, 15 Apr 2020 21:57:37 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729780AbgDOV5f (ORCPT <rfc822;git@archiver.kernel.org>);
        Wed, 15 Apr 2020 17:57:35 -0400
Received: from cloud.peff.net ([104.130.231.41]:55180 "HELO cloud.peff.net"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with SMTP
        id S1729298AbgDOV5d (ORCPT <rfc822;git@vger.kernel.org>);
        Wed, 15 Apr 2020 17:57:33 -0400
Received: (qmail 14516 invoked by uid 109); 15 Apr 2020 21:57:33 -0000
Received: from Unknown (HELO peff.net) (10.0.1.2)
 by cloud.peff.net (qpsmtpd/0.94) with SMTP; Wed, 15 Apr 2020 21:57:33 +0000
Authentication-Results: cloud.peff.net; auth=none
Received: (qmail 11912 invoked by uid 111); 15 Apr 2020 22:08:20 -0000
Received: from coredump.intra.peff.net (HELO sigill.intra.peff.net) (10.0.0.2)
 by peff.net (qpsmtpd/0.94) with (TLS_AES_256_GCM_SHA384 encrypted) ESMTPS; Wed, 15 Apr 2020 18:08:20 -0400
Authentication-Results: peff.net; auth=none
Date:   Wed, 15 Apr 2020 17:57:31 -0400
From:   Jeff King <peff@peff.net>
To:     Junio C Hamano <gitster@pobox.com>
Cc:     Johannes Schindelin <Johannes.Schindelin@gmx.de>,
        git@vger.kernel.org
Subject: Re: [PATCH] Makefile: avoid running curl-config unnecessarily
Message-ID: <20200415215731.GA3595073@coredump.intra.peff.net>
References: <20200326080540.GA2200522@coredump.intra.peff.net>
 <nycvar.QRO.7.76.6.2004041535360.46@tvgsbejvaqbjf.bet>
 <20200404145829.GB679473@coredump.intra.peff.net>
 <xmqqzhbc4e0s.fsf@gitster.c.googlers.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <xmqqzhbc4e0s.fsf@gitster.c.googlers.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

On Wed, Apr 15, 2020 at 02:47:47PM -0700, Junio C Hamano wrote:

> Jeff King <peff@peff.net> writes:
> 
> > Junio, you may want to hold off on moving jk/build-with-right-curl to
> > next until we resolve this one way or the other.
> >
> > -- >8 --
> > Subject: [PATCH] Makefile: avoid running curl-config unnecessarily
> 
> I think this has been accepted favourably after all?  I am inclined
> to mark these three as ready for 'next'.

Yeah, my "until we resolve" was basically "do people find this Makefile
eval trick too gross". And I think the answer is that it's fine.

-Peff
