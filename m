Return-Path: <SRS0=jQhj=D2=vger.kernel.org=git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-3.7 required=3.0 tests=BAYES_00,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,
	URIBL_BLOCKED autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id E94C8C433E7
	for <git@archiver.kernel.org>; Mon, 19 Oct 2020 15:53:48 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 993B0222C2
	for <git@archiver.kernel.org>; Mon, 19 Oct 2020 15:53:48 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1730259AbgJSPxr (ORCPT <rfc822;git@archiver.kernel.org>);
        Mon, 19 Oct 2020 11:53:47 -0400
Received: from outgoing-auth-1.mit.edu ([18.9.28.11]:53981 "EHLO
        outgoing.mit.edu" rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org
        with ESMTP id S1730025AbgJSPxr (ORCPT <rfc822;git@vger.kernel.org>);
        Mon, 19 Oct 2020 11:53:47 -0400
Received: from callcc.thunk.org (pool-72-74-133-215.bstnma.fios.verizon.net [72.74.133.215])
        (authenticated bits=0)
        (User authenticated as tytso@ATHENA.MIT.EDU)
        by outgoing.mit.edu (8.14.7/8.12.4) with ESMTP id 09JFrcch024645
        (version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Mon, 19 Oct 2020 11:53:39 -0400
Received: by callcc.thunk.org (Postfix, from userid 15806)
        id 6A319420107; Mon, 19 Oct 2020 11:53:38 -0400 (EDT)
Date:   Mon, 19 Oct 2020 11:53:38 -0400
From:   "Theodore Y. Ts'o" <tytso@mit.edu>
To:     Junio C Hamano <gitster@pobox.com>
Cc:     Jeff King <peff@peff.net>,
        "Bradley M. Kuhn" <bkuhn@sfconservancy.org>,
        Philippe Blain <levraiphilippeblain@gmail.com>,
        Git mailing list <git@vger.kernel.org>
Subject: Re: [PATCH 0/1] Clarify and expand description of --signoff
Message-ID: <20201019155338.GK181507@mit.edu>
References: <20201015215933.96425-1-bkuhn@sfconservancy.org>
 <59E3B060-63E3-41C2-A7C4-5B2C888F8D68@gmail.com>
 <CAPc5daWenXds=0BW0CXa=4MOF2UxDeQ8DF2+7V9-WkKwCFCDBw@mail.gmail.com>
 <20201016015937.GA3335046@coredump.intra.peff.net>
 <xmqqft6eewc5.fsf@gitster.c.googlers.com>
 <xmqqh7quaqwb.fsf@gitster.c.googlers.com>
 <20201016201119.GA3356073@coredump.intra.peff.net>
 <xmqqwnzn73og.fsf@gitster.c.googlers.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <xmqqwnzn73og.fsf@gitster.c.googlers.com>
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

On Sun, Oct 18, 2020 at 12:08:15PM -0700, Junio C Hamano wrote:
> Jeff King <peff@peff.net> writes:
> 
> > On Fri, Oct 16, 2020 at 12:53:56PM -0700, Junio C Hamano wrote:
> >
> >> > Jeff King <peff@peff.net> writes:
> >> >
> >> >> What should we change there? We could perhaps bring up signoffs earlier
> >> >> or more prominently. Or tie it in to the git-commit docs by saying
> >> >> explicitly: these are _our_ project rules for signoffs.
> >> 
> >> Let's tie this loose end.  How about squashing in something like
> >> this?
> >
> > Thanks for writing this up. I agree it makes the text much better (not
> > only in emphasizing the point we've been discussing, but also in general
> > clarity).
> >
> > You said "squashing", but I'd suggest keeping it as its own patch on top
> > of Bradley's.
> 
> OK, let's do so.
> 
> I recall I read that Bradley's patch needs a bit of word/grammo
> polishing?

Well, I pointed out a missing article ("a") in the line *above*
Bradley's change in two man pages.  It's a minor nit, and it's
unrelated to his proposed change.  I have no opinion about whether
it's better to do it separately from his change or as a separate
commit.

						- Ted
