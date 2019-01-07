Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.2 (2018-09-13) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-4.0 required=3.0 tests=AWL,BAYES_00,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,RCVD_IN_DNSWL_HI
	shortcircuit=no autolearn=ham autolearn_force=no version=3.4.2
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 311191F803
	for <e@80x24.org>; Mon,  7 Jan 2019 12:30:16 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726676AbfAGMaO (ORCPT <rfc822;e@80x24.org>);
        Mon, 7 Jan 2019 07:30:14 -0500
Received: from cloud.peff.net ([104.130.231.41]:56542 "HELO cloud.peff.net"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with SMTP
        id S1726540AbfAGMaO (ORCPT <rfc822;git@vger.kernel.org>);
        Mon, 7 Jan 2019 07:30:14 -0500
Received: (qmail 16976 invoked by uid 109); 7 Jan 2019 12:30:15 -0000
Received: from Unknown (HELO peff.net) (10.0.1.2)
 by cloud.peff.net (qpsmtpd/0.94) with SMTP; Mon, 07 Jan 2019 12:30:15 +0000
Authentication-Results: cloud.peff.net; auth=none
Received: (qmail 2280 invoked by uid 111); 7 Jan 2019 12:29:53 -0000
Received: from sigill.intra.peff.net (HELO sigill.intra.peff.net) (10.0.0.7)
 by peff.net (qpsmtpd/0.94) with (ECDHE-RSA-AES256-GCM-SHA384 encrypted) SMTP; Mon, 07 Jan 2019 07:29:53 -0500
Authentication-Results: peff.net; auth=none
Received: by sigill.intra.peff.net (sSMTP sendmail emulation); Mon, 07 Jan 2019 07:30:12 -0500
Date:   Mon, 7 Jan 2019 07:30:12 -0500
From:   Jeff King <peff@peff.net>
To:     Philip Oakley <philipoakley@iee.org>
Cc:     =?utf-8?B?UmVuw6k=?= Scharfe <l.s.r@web.de>, git@vger.kernel.org,
        Junio C Hamano <gitster@pobox.com>,
        =?utf-8?B?w4Z2YXIgQXJuZmrDtnLDsA==?= Bjarmason <avarab@gmail.com>
Subject: Re: [PATCH 1/3] object-store: factor out odb_loose_cache()
Message-ID: <20190107123012.GA6032@sigill.intra.peff.net>
References: <xmqqh8explya.fsf@gitster-ct.c.googlers.com>
 <3512c798-aa42-6fba-ee82-d33a8985be91@web.de>
 <b87e7e01-baa6-6fb2-7081-0042ecd3b6b7@web.de>
 <0797a920-32f3-aaaf-9321-528f78d980ae@iee.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <0797a920-32f3-aaaf-9321-528f78d980ae@iee.org>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

On Mon, Jan 07, 2019 at 11:27:06AM +0000, Philip Oakley wrote:

> On 06/01/2019 16:45, René Scharfe wrote:
> > Add and use a function for loading the entries if a loose object
> > subdirectory for a given object ID.
> 
> The second part of the sentence 'a loose object subdirectory for a given
> object ID' does not scan for me. Is there a word missing?

I think s/if/in/ ?

-Peff
