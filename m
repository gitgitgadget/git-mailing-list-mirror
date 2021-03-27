Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-3.8 required=3.0 tests=BAYES_00,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS
	autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id D35CCC433DB
	for <git@archiver.kernel.org>; Sat, 27 Mar 2021 09:49:14 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id A4B80619E4
	for <git@archiver.kernel.org>; Sat, 27 Mar 2021 09:49:14 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231382AbhC0Jsh (ORCPT <rfc822;git@archiver.kernel.org>);
        Sat, 27 Mar 2021 05:48:37 -0400
Received: from cloud.peff.net ([104.130.231.41]:50642 "EHLO cloud.peff.net"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S230427AbhC0JsG (ORCPT <rfc822;git@vger.kernel.org>);
        Sat, 27 Mar 2021 05:48:06 -0400
Received: (qmail 13335 invoked by uid 109); 27 Mar 2021 09:48:04 -0000
Received: from Unknown (HELO peff.net) (10.0.1.2)
 by cloud.peff.net (qpsmtpd/0.94) with ESMTP; Sat, 27 Mar 2021 09:48:04 +0000
Authentication-Results: cloud.peff.net; auth=none
Received: (qmail 16203 invoked by uid 111); 27 Mar 2021 09:48:04 -0000
Received: from coredump.intra.peff.net (HELO sigill.intra.peff.net) (10.0.0.2)
 by peff.net (qpsmtpd/0.94) with (TLS_AES_256_GCM_SHA384 encrypted) ESMTPS; Sat, 27 Mar 2021 05:48:04 -0400
Authentication-Results: peff.net; auth=none
Date:   Sat, 27 Mar 2021 05:48:04 -0400
From:   Jeff King <peff@peff.net>
To:     =?utf-8?B?w4Z2YXIgQXJuZmrDtnLDsA==?= Bjarmason <avarab@gmail.com>
Cc:     git@vger.kernel.org, Junio C Hamano <gitster@pobox.com>
Subject: Re: [PATCH 0/5] small doc make and lint fixes
Message-ID: <YF7/VJmb+B1eH6Ro@coredump.intra.peff.net>
References: <cover-0.6-00000000000-20210326T103454Z-avarab@gmail.com>
 <YF3AGsFFX3FQ1/ew@coredump.intra.peff.net>
 <87sg4indt1.fsf@evledraar.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <87sg4indt1.fsf@evledraar.gmail.com>
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

On Fri, Mar 26, 2021 at 04:18:50PM +0100, Ævar Arnfjörð Bjarmason wrote:

> >> A small stand-alone series of doc infrastructure fixes. 5/6 fixes an
> >> interesting bug that's been missed since doc-diff was introduced.
> >
> > I'm not sure what you mean about doc-diff here. Patch 5 (of 5?) doesn't
> > seem related. Patch 4 is related only tangentially, in that you might
> > have more stuff in your Documentation directory.
> 
> That's how it's related, the lint script recursively looks for all *.txt
> under Documentation/, before doc-diff we could safely assume this was
> *.txt at that version of the repository, after doc-diff our recursively
> search leads us to a different checkout at a different revision.
> 
> I don't think it had any practical effect, just say'n.

OK, thanks. I just wanted to make sure I wasn't missing something.

-Peff
