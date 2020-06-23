Return-Path: <SRS0=IiYM=AE=vger.kernel.org=git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-1.0 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS autolearn=no autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 7848BC433E0
	for <git@archiver.kernel.org>; Tue, 23 Jun 2020 19:44:59 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 4B8E220C09
	for <git@archiver.kernel.org>; Tue, 23 Jun 2020 19:44:59 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1733305AbgFWTo6 (ORCPT <rfc822;git@archiver.kernel.org>);
        Tue, 23 Jun 2020 15:44:58 -0400
Received: from cloud.peff.net ([104.130.231.41]:40802 "EHLO cloud.peff.net"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1733236AbgFWTo6 (ORCPT <rfc822;git@vger.kernel.org>);
        Tue, 23 Jun 2020 15:44:58 -0400
Received: (qmail 13441 invoked by uid 109); 23 Jun 2020 19:44:57 -0000
Received: from Unknown (HELO peff.net) (10.0.1.2)
 by cloud.peff.net (qpsmtpd/0.94) with ESMTP; Tue, 23 Jun 2020 19:44:57 +0000
Authentication-Results: cloud.peff.net; auth=none
Received: (qmail 20358 invoked by uid 111); 23 Jun 2020 19:44:58 -0000
Received: from coredump.intra.peff.net (HELO sigill.intra.peff.net) (10.0.0.2)
 by peff.net (qpsmtpd/0.94) with (TLS_AES_256_GCM_SHA384 encrypted) ESMTPS; Tue, 23 Jun 2020 15:44:58 -0400
Authentication-Results: peff.net; auth=none
Date:   Tue, 23 Jun 2020 15:44:56 -0400
From:   Jeff King <peff@peff.net>
To:     Junio C Hamano <gitster@pobox.com>
Cc:     git@vger.kernel.org, Eric Sunshine <sunshine@sunshineco.com>,
        Johannes Schindelin <Johannes.Schindelin@gmx.de>
Subject: Re: [alternative 0/10] fast-export: allow seeding the anonymized
 mapping
Message-ID: <20200623194456.GA2068874@coredump.intra.peff.net>
References: <20200619132304.GA2540657@coredump.intra.peff.net>
 <20200622214745.GA3302779@coredump.intra.peff.net>
 <20200623152436.GA50925@coredump.intra.peff.net>
 <xmqq1rm5d19k.fsf@gitster.c.googlers.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <xmqq1rm5d19k.fsf@gitster.c.googlers.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

On Tue, Jun 23, 2020 at 12:34:47PM -0700, Junio C Hamano wrote:

> > Both of these techniques _could_ live side-by-side within fast-export,
> > as they have slightly different strengths and weaknesses. But I'd prefer
> > to just go with one (this one) in the name of simplicity, and I strongly
> > suspect nobody will ever ask for the other.
> 
> OK.  So should we revert the merge of the other one into 'next'?
> That is easy enough ;-)

Yes, please. :)

-Peff
