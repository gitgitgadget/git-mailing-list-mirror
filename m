Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-2.6 required=3.0 tests=AWL,BAYES_00,
	FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,HEADER_FROM_DIFFERENT_DOMAINS,
	RCVD_IN_DNSWL_HI,T_RP_MATCHES_RCVD shortcircuit=no autolearn=no
	autolearn_force=no version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 028751F406
	for <e@80x24.org>; Tue,  9 Jan 2018 16:49:23 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1759699AbeAIQtV (ORCPT <rfc822;e@80x24.org>);
        Tue, 9 Jan 2018 11:49:21 -0500
Received: from mout.gmx.net ([212.227.15.19]:62083 "EHLO mout.gmx.net"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1759692AbeAIQtT (ORCPT <rfc822;git@vger.kernel.org>);
        Tue, 9 Jan 2018 11:49:19 -0500
Received: from [192.168.0.129] ([37.201.193.20]) by mail.gmx.com (mrgmx003
 [212.227.17.190]) with ESMTPSA (Nemesis) id 0MbxJ8-1eGji00zkk-00JIOh; Tue, 09
 Jan 2018 17:48:58 +0100
Date:   Tue, 9 Jan 2018 17:48:58 +0100 (STD)
From:   Johannes Schindelin <Johannes.Schindelin@gmx.de>
X-X-Sender: virtualbox@MININT-6BKU6QN.europe.corp.microsoft.com
To:     Derrick Stolee <stolee@gmail.com>
cc:     Jeff King <peff@peff.net>, Jeff Hostetler <git@jeffhostetler.com>,
        Ben Peart <peartben@gmail.com>, git@vger.kernel.org,
        gitster@pobox.com, Jeff Hostetler <jeffhost@microsoft.com>
Subject: Re: [PATCH v4 0/4] Add --no-ahead-behind to status
In-Reply-To: <c19f6469-190a-33e7-20a2-fcb17b8e45d9@gmail.com>
Message-ID: <nycvar.QRO.7.76.6.1801091744540.37@ZVAVAG-6OXH6DA.rhebcr.pbec.zvpebfbsg.pbz>
References: <20180108154822.54829-1-git@jeffhostetler.com> <7b759564-5544-8845-0594-e8342a0b4ba5@gmail.com> <8affe37c-d937-d7e0-fe06-cf7c8db173fa@jeffhostetler.com> <20180109072044.GD32257@sigill.intra.peff.net> <nycvar.QRO.7.76.6.1801091407480.37@ZVAVAG-6OXH6DA.rhebcr.pbec.zvpebfbsg.pbz>
 <c19f6469-190a-33e7-20a2-fcb17b8e45d9@gmail.com>
User-Agent: Alpine 2.21.1 (DEB 209 2017-03-23)
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
X-Provags-ID: V03:K0:Z3R61fwz0H9mXWk+QhLokxbOs8v6X0eScIzjxz/FNdDZvnBl9nU
 LKhvsv96c1NKoLFteNSpzZMNDq19L492QK2Rt9E1GNvngGhKOkXk40jYcKbsQV9dQsNrEjz
 OJTK0ttoHAglH8/87xyVGgZSwAXyKuSX67CaVrQM/nVHXkapwrCAysj/WgoLhV369uCchGI
 3DeVYASM52xNopgO4hGIQ==
X-UI-Out-Filterresults: notjunk:1;V01:K0:LWk43Lvusqk=:ZpJRPW55inEnZBy9yd6jB5
 wF0ZErvfjYYck12RhkIa74uSGWp/f4iU8NXNj45Up8d9N/07Mj2FN6UZqZHfRY1qoECU+WqTv
 7uvgVQ50c5G50erD637TnPITlgbDpyjUn/o/lljb2QmOICuo9plJDxErkNfMjth5cFsgxcCTG
 Jhqlgl5udXOWX5Tdc21wsoJ+Q9iGorj7DQJPeuvRHMjv4S6pE++SRWgCQaeifFsi1qXkCAD01
 tyNQPnLVrjyniFyREzu3GkxG+F11ufOiY2Eqy3fLwHqdJZKTMQHxIxZ2cvZ3KBSGwV0QiLcRP
 JjjIqBvagOywZF8KAn3BYixcnhP+ZDyi0SrI5F3tkudQUsxndie6ffld532J97heYG/b3yaBA
 wQFwVtytdOboNscOlUTMZ5UOfy6QEqXIbwR/CigEJ41AH66KDZF4tGJCpCJbksei9aY9g86DV
 EFyfDfqVndW1WtjD5Pq8c1JJy2sWwmWqUpPtbAhAa7rKfgGceS4GVEsDElBekcTjz8KlLFxot
 p/AkupAQ++W+1DBpFTpPrh1iMJT0IY3sL1Ofq7AZkwquuX5AsA3pjtXkgNPQ+joREzwxRLLdY
 eSWebFZQJqSj7o/Q7JRQK16wt4aZXJRrqTbaUMz+krNK5//9S1sezP4XS7lyYQOjTf7ZKs8Ci
 //0DGhUNJEy9iVO9+bJyKQpmEPRliiu2yIX7LjG5eaZYEdu/FzOJLmyXBDu6JsUtLM7s3A3K8
 xMrS4v2I+u7nN2neG8Sv14/y3cQqoFyq25vXBmgMlSiozzgThfFtsjSE6IMOWIAxFE6+wmd4h
 kug/1RLcCmL+iG+aRQ3NtjZBPOTt5ke8Yp3a5FwMl2hhKHgo06N2nHJIYvKoecsWcGxN7Is
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Hi Stolee,

On Tue, 9 Jan 2018, Derrick Stolee wrote:

> On 1/9/2018 8:15 AM, Johannes Schindelin wrote:
> >
> > On Tue, 9 Jan 2018, Jeff King wrote:
> >
> > > But I don't think you can approximate both ahead and behind together
> > > without finding the actual merge base.
> > >
> > > But even still, finding small answers quickly and accurately and
> > > punting to "really far, I didn't bother to compute it" on the big
> > > ones would be an improvement over always punting.
> >
> > Indeed. The longer I think about it, the more I like the "100+ commits
> > apart" idea.
> 
> Again, I strongly suggest we drop this approach because it will be more pain
> than it is worth.

So what you are saying is if there is a commit graph with *heavy* clock
skew, you might overestimate how many commits apart the tips are.

I say that this is striking the balance between correctness and usability
on the *wrong* side.

Sure, it might be wrong if your commit graph suffers heavily from clock
skew. In most cases, you still get a pretty darn useful hint where you're
at.

The alternative would be *not* to show any useful hint in most cases, i.e.
when you did not find all merge bases within <N> commits. I would really
hate it if Git spent so much time and did not even give me a hint. Totally
unsatisfying user experience.

Ciao,
Johannes
