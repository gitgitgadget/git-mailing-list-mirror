Return-Path: <SRS0=fhRL=6M=vger.kernel.org=git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.8 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED autolearn=no
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id CFDA3C83004
	for <git@archiver.kernel.org>; Tue, 28 Apr 2020 05:36:06 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id B32E2206C0
	for <git@archiver.kernel.org>; Tue, 28 Apr 2020 05:36:06 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726271AbgD1FgF (ORCPT <rfc822;git@archiver.kernel.org>);
        Tue, 28 Apr 2020 01:36:05 -0400
Received: from cloud.peff.net ([104.130.231.41]:41848 "HELO cloud.peff.net"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with SMTP
        id S1725792AbgD1FgE (ORCPT <rfc822;git@vger.kernel.org>);
        Tue, 28 Apr 2020 01:36:04 -0400
Received: (qmail 18269 invoked by uid 109); 28 Apr 2020 05:36:04 -0000
Received: from Unknown (HELO peff.net) (10.0.1.2)
 by cloud.peff.net (qpsmtpd/0.94) with SMTP; Tue, 28 Apr 2020 05:36:04 +0000
Authentication-Results: cloud.peff.net; auth=none
Received: (qmail 31496 invoked by uid 111); 28 Apr 2020 05:47:26 -0000
Received: from coredump.intra.peff.net (HELO sigill.intra.peff.net) (10.0.0.2)
 by peff.net (qpsmtpd/0.94) with (TLS_AES_256_GCM_SHA384 encrypted) ESMTPS; Tue, 28 Apr 2020 01:47:26 -0400
Authentication-Results: peff.net; auth=none
Date:   Tue, 28 Apr 2020 01:36:02 -0400
From:   Jeff King <peff@peff.net>
To:     Elijah Newren <newren@gmail.com>
Cc:     Junio C Hamano <gitster@pobox.com>,
        Johannes Schindelin <Johannes.Schindelin@gmx.de>,
        Sibi Siddharthan <sibisiddharthan.github@gmail.com>,
        Sibi Siddharthan via GitGitGadget <gitgitgadget@gmail.com>,
        Git Mailing List <git@vger.kernel.org>
Subject: Re: [PATCH 0/8] CMake build system for git
Message-ID: <20200428053602.GA2376380@coredump.intra.peff.net>
References: <pull.614.git.1587700897.gitgitgadget@gmail.com>
 <xmqqv9lod85m.fsf@gitster.c.googlers.com>
 <CAKiG+9V_nZUXf2a689vZ54rG+xTCFMGcJe_7Av-khaxxuijERg@mail.gmail.com>
 <xmqq8sikblv2.fsf@gitster.c.googlers.com>
 <nycvar.QRO.7.76.6.2004251354390.18039@tvgsbejvaqbjf.bet>
 <20200427200852.GC1728884@coredump.intra.peff.net>
 <xmqqlfmg7hn7.fsf@gitster.c.googlers.com>
 <20200427220955.GA1747507@coredump.intra.peff.net>
 <CABPp-BE4qBquBwHp6QH31WNcQ-jUMrC+SqCbnBWKtCxdhoWRCQ@mail.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <CABPp-BE4qBquBwHp6QH31WNcQ-jUMrC+SqCbnBWKtCxdhoWRCQ@mail.gmail.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

On Mon, Apr 27, 2020 at 03:23:22PM -0700, Elijah Newren wrote:

> > If it lived in contrib/ that might strike a good balance between making
> > it available for people to experiment with, but not having people
> > confuse it for the official build system.
> 
> Maybe we could move configure.ac and config.mak.in into contrib as well?

Maybe. I have a feeling that most folks who use autoconf do it from the
tarballs, which have the generated ./configure anyway.

-Peff
