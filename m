Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-3.7 required=3.0 tests=BAYES_00,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,
	URIBL_BLOCKED autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 6F7B8C433E0
	for <git@archiver.kernel.org>; Tue,  2 Feb 2021 22:32:54 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 341E964F2C
	for <git@archiver.kernel.org>; Tue,  2 Feb 2021 22:32:54 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S235737AbhBBWci (ORCPT <rfc822;git@archiver.kernel.org>);
        Tue, 2 Feb 2021 17:32:38 -0500
Received: from dcvr.yhbt.net ([64.71.152.64]:50900 "EHLO dcvr.yhbt.net"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S232802AbhBBWch (ORCPT <rfc822;git@vger.kernel.org>);
        Tue, 2 Feb 2021 17:32:37 -0500
X-Greylist: delayed 496 seconds by postgrey-1.27 at vger.kernel.org; Tue, 02 Feb 2021 17:32:37 EST
Received: from localhost (dcvr.yhbt.net [127.0.0.1])
        by dcvr.yhbt.net (Postfix) with ESMTP id A4F5A1F4B4;
        Tue,  2 Feb 2021 22:23:39 +0000 (UTC)
Date:   Tue, 2 Feb 2021 22:23:39 +0000
From:   Eric Wong <e@80x24.org>
To:     Hongyi Zhao <hongyi.zhao@gmail.com>
Cc:     Jeff King <peff@peff.net>, Junio C Hamano <gitster@pobox.com>,
        git@vger.kernel.org
Subject: Re: Only receive the topics I participated in or initiated on this
 mailing list.
Message-ID: <20210202222339.GA20119@dcvr>
References: <CAGP6POK1s5fdzY74HyE9=0CV_B+HpbM9gU2qKuYtQAaPuc7XgQ@mail.gmail.com>
 <CAPc5daUtOMQB9YqOTQL4mrHpfyATe=FM01cW9Ngd1iy8aWwMmg@mail.gmail.com>
 <CAGP6POJ62-HG88uRv7yHHGy3Uu+T57APQ6GiNU3nQDW2eT4cXw@mail.gmail.com>
 <YBkUJP2u4NcldpOp@coredump.intra.peff.net>
 <CAGP6POKxr6k5KaC0xNaFGt=mBoEMkObNGHhDpUHQdEbsokrHhQ@mail.gmail.com>
 <YBkZZrDzBo0UC+SQ@coredump.intra.peff.net>
 <CAGP6POJStLEGwiU6yobaA6ag1q1ametFoe2AVkOAs6zDQ5bk3A@mail.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <CAGP6POJStLEGwiU6yobaA6ag1q1ametFoe2AVkOAs6zDQ5bk3A@mail.gmail.com>
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Hongyi Zhao <hongyi.zhao@gmail.com> wrote:
> On Tue, Feb 2, 2021 at 5:20 PM Jeff King <peff@peff.net> wrote:
> >
> > On Tue, Feb 02, 2021 at 05:02:53PM +0800, Hongyi Zhao wrote:
> >
> > > > If you only care about topics that you have participated in, the easiest
> > > > thing is to simply unsubscribe from the list.
> > >
> > > Do you mean I still can post to this list without subscription to it?
> >
> > Yes.
> 
> Does this rule apply to all the lists residing on <http://vger.kernel.org/>?

Yes, and any exceptions would be documented.

> > You can also read the archive at https://lore.kernel.org/git if you
> > later feel like checking for threads you might have missed.

Btw, you can use the "tc:" prefix to search To/Cc: fields
as documented in https://lore.kernel.org/git/_/text/help/

You can get all the messages sent to you in gzipped mboxrd
format via:

  curl -sSf -d '' 'https://lore.kernel.org/git/?q=tc:hongyi&x=m' >mboxrd.gz

And public-inbox.org/git still exists for redundancy and dogfooding:

  curl -sSf -d '' 'https://public-inbox.org/git/?q=tc:hongyi&x=m' >mboxrd.gz

There may be a CLI tool for dealing with that in the near future
that lets you keep track of which messages you've read/unread or tagged :>
