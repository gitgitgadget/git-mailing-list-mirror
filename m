Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-3.8 required=3.0 tests=BAYES_00,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS
	autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 356C5C433B4
	for <git@archiver.kernel.org>; Fri, 23 Apr 2021 14:41:19 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 011ED61422
	for <git@archiver.kernel.org>; Fri, 23 Apr 2021 14:41:18 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S242194AbhDWOly (ORCPT <rfc822;git@archiver.kernel.org>);
        Fri, 23 Apr 2021 10:41:54 -0400
Received: from cloud.peff.net ([104.130.231.41]:33464 "EHLO cloud.peff.net"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S231383AbhDWOlv (ORCPT <rfc822;git@vger.kernel.org>);
        Fri, 23 Apr 2021 10:41:51 -0400
Received: (qmail 7587 invoked by uid 109); 23 Apr 2021 14:41:13 -0000
Received: from Unknown (HELO peff.net) (10.0.1.2)
 by cloud.peff.net (qpsmtpd/0.94) with ESMTP; Fri, 23 Apr 2021 14:41:13 +0000
Authentication-Results: cloud.peff.net; auth=none
Received: (qmail 9148 invoked by uid 111); 23 Apr 2021 14:41:13 -0000
Received: from coredump.intra.peff.net (HELO sigill.intra.peff.net) (10.0.0.2)
 by peff.net (qpsmtpd/0.94) with (TLS_AES_256_GCM_SHA384 encrypted) ESMTPS; Fri, 23 Apr 2021 10:41:13 -0400
Authentication-Results: peff.net; auth=none
Date:   Fri, 23 Apr 2021 10:41:12 -0400
From:   Jeff King <peff@peff.net>
To:     =?utf-8?B?w4Z2YXIgQXJuZmrDtnLDsA==?= Bjarmason <avarab@gmail.com>
Cc:     Junio C Hamano <gitster@pobox.com>, git@vger.kernel.org,
        "brian m. carlson" <sandals@crustytoothpaste.net>,
        Eric Wong <e@80x24.org>
Subject: Re: What's cooking in git.git (Apr 2021, #05; Mon, 19)
Message-ID: <YILciIL/WtNWdOPF@coredump.intra.peff.net>
References: <xmqqtuo17t6t.fsf@gitster.g>
 <87mttt2hcu.fsf@evledraar.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <87mttt2hcu.fsf@evledraar.gmail.com>
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

On Tue, Apr 20, 2021 at 03:52:33PM +0200, Ævar Arnfjörð Bjarmason wrote:

> > * ab/fsck-unexpected-type (2021-04-13) 6 commits
> >  - fsck: report invalid object type-path combinations
> >  - fsck: report invalid types recorded in objects
> >  - object-store.h: move read_loose_object() below 'struct object_info'
> >  - fsck: don't hard die on invalid object types
> >  - fsck tests: refactor one test to use a sub-repo
> >  - cache.h: move object functions to object-store.h
> >
> >  "git fsck" has been taught to report mismatch between expected and
> >  actual types of an object better.
> 
> Jeff King: *re-poke* per the mention the last WC: I.e. did you review
> this?

I hadn't, but I just did. I had some organizational nits to pick in the
middle, but there's something really wrong with the cat-file changes in
patch 5. I stopped there for now, because at least one of us is really
confused. ;)

-Peff
