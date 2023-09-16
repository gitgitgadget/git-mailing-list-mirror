Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id C5405CD37B5
	for <git@archiver.kernel.org>; Sat, 16 Sep 2023 05:33:57 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S238669AbjIPFd3 (ORCPT <rfc822;git@archiver.kernel.org>);
        Sat, 16 Sep 2023 01:33:29 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:56982 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S238738AbjIPFdF (ORCPT <rfc822;git@vger.kernel.org>);
        Sat, 16 Sep 2023 01:33:05 -0400
Received: from cloud.peff.net (cloud.peff.net [104.130.231.41])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 340831FC7
        for <git@vger.kernel.org>; Fri, 15 Sep 2023 22:32:59 -0700 (PDT)
Received: (qmail 958 invoked by uid 109); 16 Sep 2023 05:32:59 -0000
Received: from Unknown (HELO peff.net) (10.0.1.2)
 by cloud.peff.net (qpsmtpd/0.94) with ESMTP; Sat, 16 Sep 2023 05:32:59 +0000
Authentication-Results: cloud.peff.net; auth=none
Received: (qmail 8938 invoked by uid 111); 16 Sep 2023 05:33:00 -0000
Received: from coredump.intra.peff.net (HELO coredump.intra.peff.net) (10.0.0.2)
 by peff.net (qpsmtpd/0.94) with (TLS_AES_256_GCM_SHA384 encrypted) ESMTPS; Sat, 16 Sep 2023 01:33:00 -0400
Authentication-Results: peff.net; auth=none
Date:   Sat, 16 Sep 2023 01:32:57 -0400
From:   Jeff King <peff@peff.net>
To:     Junio C Hamano <gitster@pobox.com>
Cc:     =?utf-8?B?UnViw6lu?= Justo <rjusto@gmail.com>,
        Git List <git@vger.kernel.org>,
        =?utf-8?B?w4Z2YXIgQXJuZmrDtnLDsA==?= Bjarmason <avarab@gmail.com>
Subject: Re: [PATCH 2/2] test-lib: fix GIT_TEST_SANITIZE_LEAK_LOG
Message-ID: <20230916053257.GC13092@coredump.intra.peff.net>
References: <68522960-edda-26d3-ddca-cee63f2d859e@gmail.com>
 <64825651-00d2-d2c5-2da2-91a9917bef21@gmail.com>
 <20230912082742.GB1630538@coredump.intra.peff.net>
 <2890b210-c42f-41cf-e676-0b1c56310f73@gmail.com>
 <20230915112906.GA3125427@coredump.intra.peff.net>
 <xmqq5y4bfhpm.fsf@gitster.g>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <xmqq5y4bfhpm.fsf@gitster.g>
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

On Fri, Sep 15, 2023 at 10:51:17AM -0700, Junio C Hamano wrote:

> Jeff King <peff@peff.net> writes:
> 
> > But having done so, the main value in re-rolling would be preventing
> > somebody else from reading the code and having the same question.
> 
> Indeed.  It would be valuable to help future developers not to waste
> time on wondering what we already know they may do so on.

I guess I was thinking "maybe that is not a good reason to change what
the code does" when I wrote my other email. But it is probably a good
reason to make a note in the commit message. :)

-Peff
