Return-Path: <SRS0=g4/7=2A=vger.kernel.org=git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.8 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS autolearn=no autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 73102C43603
	for <git@archiver.kernel.org>; Tue, 10 Dec 2019 20:50:59 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 48F182077B
	for <git@archiver.kernel.org>; Tue, 10 Dec 2019 20:50:59 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726717AbfLJUu6 (ORCPT <rfc822;git@archiver.kernel.org>);
        Tue, 10 Dec 2019 15:50:58 -0500
Received: from cloud.peff.net ([104.130.231.41]:43824 "HELO cloud.peff.net"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with SMTP
        id S1726417AbfLJUu6 (ORCPT <rfc822;git@vger.kernel.org>);
        Tue, 10 Dec 2019 15:50:58 -0500
Received: (qmail 32225 invoked by uid 109); 10 Dec 2019 20:50:58 -0000
Received: from Unknown (HELO peff.net) (10.0.1.2)
 by cloud.peff.net (qpsmtpd/0.94) with SMTP; Tue, 10 Dec 2019 20:50:58 +0000
Authentication-Results: cloud.peff.net; auth=none
Received: (qmail 2109 invoked by uid 111); 10 Dec 2019 20:55:18 -0000
Received: from coredump.intra.peff.net (HELO sigill.intra.peff.net) (10.0.0.2)
 by peff.net (qpsmtpd/0.94) with (TLS_AES_256_GCM_SHA384 encrypted) ESMTPS; Tue, 10 Dec 2019 15:55:18 -0500
Authentication-Results: peff.net; auth=none
Date:   Tue, 10 Dec 2019 15:50:56 -0500
From:   Jeff King <peff@peff.net>
To:     Derrick Stolee <stolee@gmail.com>
Cc:     Junio C Hamano <gitster@pobox.com>, KOLANICH <kolan_n@mail.ru>,
        git@vger.kernel.org, Derrick Stolee <dstolee@microsoft.com>,
        Elijah Newren <newren@gmail.com>
Subject: Re: Could /Documentation/technical/commit-graph.txt be relicensed
 under a permissive license?
Message-ID: <20191210205056.GA14079@coredump.intra.peff.net>
References: <E2770343-BB39-458C-835E-04F0753783C3@mail.ru>
 <xmqqimmoq6vw.fsf@gitster-ct.c.googlers.com>
 <70575b23-6adb-a29b-8df8-f9099f86eb0e@gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <70575b23-6adb-a29b-8df8-f9099f86eb0e@gmail.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

On Tue, Dec 10, 2019 at 03:38:35PM -0500, Derrick Stolee wrote:

> On 12/10/2019 3:10 PM, Junio C Hamano wrote:
> > KOLANICH <kolan_n@mail.ru> writes:
> 
> I don't appear to have the original message? Perhaps it was
> directly addressed to Junio?

It made it to me via the list, too.

> > GPL copyright protects the expression of the document, but the
> > copyright protects only the expression, and does not protect the
> > underlying format itself and the idea behind it.  So I do not see a
> > need to relicense the documentation text at all.
> 
> (Insert "I am not a lawyer" warning.)
> 
> I think this is the correct interpretation. One can interact with
> binary files as you want. In fact, there are likely privately
> licensed products that interact with Git's pack-files even though
> their format documentation is under GPL.
> 
> What _could_ be problematic is repeating the documentation directly
> in another permissive-licensed repository.

That's my understanding as well. That said, I would not be opposed to
some kind of statement in the documentation making our view explicit.

-Peff
