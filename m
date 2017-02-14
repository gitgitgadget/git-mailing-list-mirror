Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-3.6 required=3.0 tests=AWL,BAYES_00,
	HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_HI,RP_MATCHES_RCVD
	shortcircuit=no autolearn=unavailable autolearn_force=no version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 489F52013C
	for <e@80x24.org>; Tue, 14 Feb 2017 07:13:29 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1752364AbdBNHN0 (ORCPT <rfc822;e@80x24.org>);
        Tue, 14 Feb 2017 02:13:26 -0500
Received: from dcvr.yhbt.net ([64.71.152.64]:56920 "EHLO dcvr.yhbt.net"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1751023AbdBNHN0 (ORCPT <rfc822;git@vger.kernel.org>);
        Tue, 14 Feb 2017 02:13:26 -0500
Received: from localhost (dcvr.yhbt.net [127.0.0.1])
        by dcvr.yhbt.net (Postfix) with ESMTP id 9FE342013A;
        Tue, 14 Feb 2017 07:13:24 +0000 (UTC)
Date:   Tue, 14 Feb 2017 07:13:24 +0000
From:   Eric Wong <e@80x24.org>
To:     Arif Khokar <arif.i.khokar@gmail.com>
Cc:     Johannes Schindelin <Johannes.Schindelin@gmx.de>,
        Jakub =?utf-8?B?TmFyxJlic2tp?= <jnareb@gmail.com>,
        Jeff King <peff@peff.net>, Stefan Beller <sbeller@google.com>,
        meta@public-inbox.org, git@vger.kernel.org
Subject: Re: Working with public-inbox.org [Was: [PATCH] rev-parse: respect
 core.hooksPath in --git-path]
Message-ID: <20170214071324.GA747@starla>
References: <CAGZ79kasebzJb=b2n=JQiVMrSfJKaVfZaaoaVJFkXWuqKjfYKw@mail.gmail.com>
 <alpine.DEB.2.20.1608181430280.4924@virtualbox>
 <20160819150340.725bejnps6474u2e@sigill.intra.peff.net>
 <46a5b9b6-f3f6-7650-8a5b-b0b52223e375@gmail.com>
 <DM5PR17MB1353EFB1F6FE3B05EFDF86DCD3EB0@DM5PR17MB1353.namprd17.prod.outlook.com>
 <alpine.DEB.2.20.1608241509200.4924@virtualbox>
 <alpine.DEB.2.20.1702101707060.3496@virtualbox>
 <d16546a4-25be-7b85-3191-e9393fda1164@hotmail.com>
 <alpine.DEB.2.20.1702131533400.3496@virtualbox>
 <7dbe0866-4a9b-7afe-8f51-ca1d5524d4a4@hotmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <7dbe0866-4a9b-7afe-8f51-ca1d5524d4a4@hotmail.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Arif Khokar <arif.i.khokar@gmail.com> wrote:
> On 02/13/2017 09:37 AM, Johannes Schindelin wrote:
> >I actually had expected *you* to put in a little bit of an effort, too. In
> >fact, I was very disappointed that you did not even look into porting that
> >script to use public-inbox instead of GMane.
> 
> I wasn't aware of that expectation.  My idea was to use NNTP as a way to
> facilitate the development of a new git utility that would serve as the
> inverse of git-send-email (sort of like the relationship between git
> format-patch and git am), rather than using a

Speaking for myself, I usually don't expect much, especially
from newcomers.  So I am disappointed to see Dscho's disappointment
aimed at you, Arif.  Especially since you're not a regular and
we have no idea how much free time, attention span, or familiarity
with Bourne shell you have.

> IIRC, I had posted some proof-of-concept Perl code to do so back in August
> in <DM5PR17MB1353B99EBD5F4FD23360DD41D3ED0@DM5PR17MB1353.namprd17.prod.outlook.com>
> 
> Looking at public-inbox now at the archives of this group, it appears that
> several of the messages I sent weren't archived for some reason (and I
> didn't see any more responses to what I posted at the time).  The messages
> are accessible via NNTP when connecting to gmane though.

It looks like it went to gmane via the meta@public-inbox.org to
gmane.mail.public-inbox.general mirror, not via the git@vger mirror.
I can't find it on git@vger's mail-archive.com mirror, either:

https://mail-archive.com/search?q=Arif+Khokar&l=git%40vger.kernel.org

> Also, looking at the source of the message I referenced, it appears that my
> MUA decided to base64 encode the message for some reason (which may have
> resulted in it getting filtered by those who I sent the message to).

It probably wasn't base64, but maybe it was one of these:
http://vger.kernel.org/majordomo-taboos.txt

Or it was the SPF softfail which you can see in the headers on both
gmane and public-inbox.
It might even be the '_' (underscore) in your other address.
But even Junio gets dropped by vger sometimes:
https://public-inbox.org/git/20170127035753.GA2604@dcvr/

But if I had to guess, vger gets hit by truckloads of spam and
the the backscatter volume could become unimaginable, so perhaps
it has good reason to discard silently.



Anyways, the eventual goal of public-inbox is to flip the
mailing list model backwards into "archives first" mode,
so a message needs to make it into public archives before
it goes out to subscribers.  That might prevent or avoid
such problems... *shrug*
