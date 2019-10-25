Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.2 (2018-09-13) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-4.0 required=3.0 tests=AWL,BAYES_00,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,RCVD_IN_DNSWL_HI,
	SPF_HELO_NONE,SPF_NONE shortcircuit=no autolearn=ham
	autolearn_force=no version=3.4.2
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 9AB1B1F4C1
	for <e@80x24.org>; Fri, 25 Oct 2019 00:15:58 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1732214AbfJYAMz (ORCPT <rfc822;e@80x24.org>);
        Thu, 24 Oct 2019 20:12:55 -0400
Received: from dcvr.yhbt.net ([64.71.152.64]:36120 "EHLO dcvr.yhbt.net"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1729514AbfJYAMz (ORCPT <rfc822;git@vger.kernel.org>);
        Thu, 24 Oct 2019 20:12:55 -0400
Received: from localhost (dcvr.yhbt.net [127.0.0.1])
        by dcvr.yhbt.net (Postfix) with ESMTP id B34A61F4C0;
        Fri, 25 Oct 2019 00:12:54 +0000 (UTC)
Date:   Fri, 25 Oct 2019 00:12:54 +0000
From:   Eric Wong <e@80x24.org>
To:     Johannes Schindelin <Johannes.Schindelin@gmx.de>
Cc:     Junio C Hamano <gitster@pobox.com>, git@vger.kernel.org,
        Thomas Gummerer <t.gummerer@gmail.com>
Subject: Re: [RFC/WIP] range-diff: show old/new blob OIDs in comments
Message-ID: <20191025001254.GA29496@dcvr>
References: <20191017121045.GA15364@dcvr>
 <nycvar.QRO.7.76.6.1910222111430.46@tvgsbejvaqbjf.bet>
 <20191023015629.GA15495@dcvr>
 <xmqq5zkghzid.fsf@gitster-ct.c.googlers.com>
 <nycvar.QRO.7.76.6.1910250014240.46@tvgsbejvaqbjf.bet>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <nycvar.QRO.7.76.6.1910250014240.46@tvgsbejvaqbjf.bet>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Johannes Schindelin <Johannes.Schindelin@gmx.de> wrote:
> On Wed, 23 Oct 2019, Junio C Hamano wrote:
> > Eric Wong <e@80x24.org> writes:
> > > Johannes Schindelin <Johannes.Schindelin@gmx.de> wrote:
> > >> Instead, we will have to rely on your centralized, non-distributed
> > >> service...
> > >
> > > I'm curious how you came to believe that, since that's the
> > > opposite of what public-inbox has always been intended to be.
> >
> > I think the (mis)perception comes from the fact that the website and
> > the newsfeed you give are both too easy to use and directly attract
> > end users, instead of enticing them to keep their own mirrors for
> > offline use.
> >
> > Thanks for injecting dose of sanity.
> 
> Maybe your dose of sanity can inject a statement about the case when
> public-inbox.org/git differs from a mirror, and not in a
> fast-forwardable way? What is the authoritative source of truth, then?

Why does authoritative source of truth matter?  My
anti-authoritarian ethos is what drew me to DVCS in the first
place.

If senders want to attest to the integrity of their messages;
they can sign, and/or publish a copy/log of their sent messages
on their homepage/social media/whatever.  That's up to THEM,
not anybody else.

If somebody wants to fork public-inbox.org/git and run
public-inbox-watch from their own Maildir, they're more than
welcome to.

If somebody wants to write their own importers since they don't
like the code I write, they are more than welcome to.  There's
already mail-archive.com, marc.info, news.gmane.org (which
public-inbox.org/git forked from) and some others.

Going farther, if people want to fork entire mailing lists and
communities, they should be able to do so.  I don't like mail
subscriber lists being centralized on any host, either.

I have never, ever asked anybody to trust me or public-inbox;
in fact, I've stated the opposite and will continue to do so.
