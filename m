Return-Path: <SRS0=QOHA=BI=vger.kernel.org=git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.0 required=3.0 tests=BAYES_00,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,MENTIONS_GIT_HOSTING,
	SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 98692C433DF
	for <git@archiver.kernel.org>; Wed, 29 Jul 2020 16:22:07 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 7E20B2075D
	for <git@archiver.kernel.org>; Wed, 29 Jul 2020 16:22:07 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726962AbgG2QWG (ORCPT <rfc822;git@archiver.kernel.org>);
        Wed, 29 Jul 2020 12:22:06 -0400
Received: from cloud.peff.net ([104.130.231.41]:41184 "EHLO cloud.peff.net"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726341AbgG2QWG (ORCPT <rfc822;git@vger.kernel.org>);
        Wed, 29 Jul 2020 12:22:06 -0400
Received: (qmail 7444 invoked by uid 109); 29 Jul 2020 16:22:05 -0000
Received: from Unknown (HELO peff.net) (10.0.1.2)
 by cloud.peff.net (qpsmtpd/0.94) with ESMTP; Wed, 29 Jul 2020 16:22:05 +0000
Authentication-Results: cloud.peff.net; auth=none
Received: (qmail 5825 invoked by uid 111); 29 Jul 2020 16:22:05 -0000
Received: from coredump.intra.peff.net (HELO sigill.intra.peff.net) (10.0.0.2)
 by peff.net (qpsmtpd/0.94) with (TLS_AES_256_GCM_SHA384 encrypted) ESMTPS; Wed, 29 Jul 2020 12:22:05 -0400
Authentication-Results: peff.net; auth=none
Date:   Wed, 29 Jul 2020 12:22:04 -0400
From:   Jeff King <peff@peff.net>
To:     Junio C Hamano <gitster@pobox.com>
Cc:     git@vger.kernel.org
Subject: Re: [PATCH 10/11] strvec: drop argv_array compatibility layer
Message-ID: <20200729162204.GA2320983@coredump.intra.peff.net>
References: <20200728202124.GA1021264@coredump.intra.peff.net>
 <20200728202709.GJ1021513@coredump.intra.peff.net>
 <xmqq5za7cm8e.fsf@gitster.c.googlers.com>
 <20200729000430.GA1623001@coredump.intra.peff.net>
 <20200729003720.GA1653374@coredump.intra.peff.net>
 <xmqqpn8fb15l.fsf@gitster.c.googlers.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <xmqqpn8fb15l.fsf@gitster.c.googlers.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

On Tue, Jul 28, 2020 at 05:44:22PM -0700, Junio C Hamano wrote:

> Jeff King <peff@peff.net> writes:
> 
> > Worse than the resolutions are all the new calls which needed to be
> > fixed up. I know your scripts keep a fix-up commit for this, but I don't
> > think you publish it.
> 
> They are found in refs/merge-fix/$topicname, and the broken-out
> mirror repository https://github.com/gitster/git/ should have them.

Oh indeed. I stupidly looked in my refs/remotes, but of course I didn't
set up a refspec to fetch them. :)

-Peff
