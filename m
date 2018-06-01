Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-3.9 required=3.0 tests=AWL,BAYES_00,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,RCVD_IN_DNSWL_HI
	shortcircuit=no autolearn=ham autolearn_force=no version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id C6E231F51C
	for <e@80x24.org>; Fri,  1 Jun 2018 07:06:14 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1750805AbeFAHGM (ORCPT <rfc822;e@80x24.org>);
        Fri, 1 Jun 2018 03:06:12 -0400
Received: from cloud.peff.net ([104.130.231.41]:58972 "HELO cloud.peff.net"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with SMTP
        id S1750750AbeFAHGM (ORCPT <rfc822;git@vger.kernel.org>);
        Fri, 1 Jun 2018 03:06:12 -0400
Received: (qmail 12829 invoked by uid 109); 1 Jun 2018 07:06:11 -0000
Received: from Unknown (HELO peff.net) (10.0.1.2)
 by cloud.peff.net (qpsmtpd/0.94) with SMTP; Fri, 01 Jun 2018 07:06:11 +0000
Authentication-Results: cloud.peff.net; auth=none
Received: (qmail 21866 invoked by uid 111); 1 Jun 2018 07:06:23 -0000
Received: from sigill.intra.peff.net (HELO sigill.intra.peff.net) (10.0.0.7)
 by peff.net (qpsmtpd/0.94) with (ECDHE-RSA-AES256-GCM-SHA384 encrypted) SMTP; Fri, 01 Jun 2018 03:06:23 -0400
Authentication-Results: peff.net; auth=none
Received: by sigill.intra.peff.net (sSMTP sendmail emulation); Fri, 01 Jun 2018 03:06:10 -0400
Date:   Fri, 1 Jun 2018 03:06:10 -0400
From:   Jeff King <peff@peff.net>
To:     =?utf-8?B?w4Z2YXIgQXJuZmrDtnLDsA==?= Bjarmason <avarab@gmail.com>
Cc:     "Robert P. J. Day" <rpjday@crashcourse.ca>,
        Git Mailing list <git@vger.kernel.org>
Subject: Re: does a new repo actually *need* default template content?
Message-ID: <20180601070609.GC15578@sigill.intra.peff.net>
References: <alpine.LFD.2.21.1805280836140.10191@localhost.localdomain>
 <87h8mr7jgj.fsf@evledraar.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <87h8mr7jgj.fsf@evledraar.gmail.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

On Mon, May 28, 2018 at 07:56:12PM +0200, Ævar Arnfjörð Bjarmason wrote:

> 
> On Mon, May 28 2018, Robert P. J. Day wrote:
> 
> >   (apologies for more pedantic nitpickery, just little things i'm
> > running across in my travels. aside: i actually teach git courses, so
> > it's a bit embarrassing that i don't know some of this stuff. *sigh*.)
> 
> Aside from maybe the empty branches/ directory (see c8a58ac5a5 ("Revert
> "Don't create the $GIT_DIR/branches directory on init"", 2009-10-31)),
> none of this is needed.
> 
> I wish we didn't create any of this stuff, but have never been inclined
> to make that my hill to die on.
> 
> I think we're much better off just shipping e.g. a single README file in
> hooks/, or just nothing at all.

FWIW, that's my opinion, too (including the "hill to die on" part).

I also wish hooks were just shell snippets in the config files that
could follow the usual config-precedence rules.

-Peff
