Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.2 (2018-09-13) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-3.9 required=3.0 tests=AWL,BAYES_00,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,RCVD_IN_DNSWL_HI,
	SPF_HELO_NONE,SPF_NONE shortcircuit=no autolearn=ham
	autolearn_force=no version=3.4.2
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 312CA1F731
	for <e@80x24.org>; Fri,  9 Aug 2019 11:41:51 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2406081AbfHILlu (ORCPT <rfc822;e@80x24.org>);
        Fri, 9 Aug 2019 07:41:50 -0400
Received: from cloud.peff.net ([104.130.231.41]:38842 "HELO cloud.peff.net"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with SMTP
        id S1726537AbfHILlu (ORCPT <rfc822;git@vger.kernel.org>);
        Fri, 9 Aug 2019 07:41:50 -0400
Received: (qmail 10888 invoked by uid 109); 9 Aug 2019 11:41:49 -0000
Received: from Unknown (HELO peff.net) (10.0.1.2)
 by cloud.peff.net (qpsmtpd/0.94) with SMTP; Fri, 09 Aug 2019 11:41:49 +0000
Authentication-Results: cloud.peff.net; auth=none
Received: (qmail 29580 invoked by uid 111); 9 Aug 2019 11:44:25 -0000
Received: from sigill.intra.peff.net (HELO sigill.intra.peff.net) (10.0.0.7)
 by peff.net (qpsmtpd/0.94) with (TLS_AES_256_GCM_SHA384 encrypted) ESMTPS; Fri, 09 Aug 2019 07:44:25 -0400
Authentication-Results: peff.net; auth=none
Date:   Fri, 9 Aug 2019 07:41:48 -0400
From:   Jeff King <peff@peff.net>
To:     Phil Hord <phil.hord@gmail.com>
Cc:     Taylor Blau <me@ttaylorr.com>,
        Ariadne Conill <ariadne@dereferenced.org>,
        Junio C Hamano <gitster@pobox.com>, Git <git@vger.kernel.org>
Subject: Re: What's cooking in git.git (Jul 2019, #06; Thu, 25)
Message-ID: <20190809114148.GB3957@sigill.intra.peff.net>
References: <xmqq36itprzo.fsf@gitster-ct.c.googlers.com>
 <20190809001315.GA87896@syl.lan>
 <3C7105E5-5DE1-42DC-A9A4-65C061FD6139@dereferenced.org>
 <20190809020732.GA89008@syl.lan>
 <CABURp0oFNWfWEwnkjV1+Tag91HTRBCaJjyvc8CXtPGu78DhtSw@mail.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <CABURp0oFNWfWEwnkjV1+Tag91HTRBCaJjyvc8CXtPGu78DhtSw@mail.gmail.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

On Thu, Aug 08, 2019 at 08:07:36PM -0700, Phil Hord wrote:

> The long form you give there is to be used in case the old email
> address is not a unique key. See 'git help shortlog'.
> 
> The problem we have at work is that one woman's old email address
> includes her deadname, like <firstname.lastname@company.com>.  I will
> leave it up to her whether she chooses to be listed explicitly in the
> mailmap.  I have wondered if we should permit hashed email addresses
> to be used for this specific case, but this also has its drawbacks.

Since the set of hash inputs is finite and small (i.e., the set of all
emails in the repository), it would be trivial to generate the plaintext
mapping from even a cryptographically strong hashed mapping.

Which isn't to say it's _totally_ worthless, since that adds an extra
step, but it really is just obfuscating the data.

-Peff
