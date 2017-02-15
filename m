Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-3.9 required=3.0 tests=AWL,BAYES_00,
	HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_HI,RP_MATCHES_RCVD,
	STOX_REPLY_TYPE shortcircuit=no autolearn=ham autolearn_force=no version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 809632013A
	for <e@80x24.org>; Wed, 15 Feb 2017 23:57:39 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1755890AbdBOX5c (ORCPT <rfc822;e@80x24.org>);
        Wed, 15 Feb 2017 18:57:32 -0500
Received: from smtp-out-6.talktalk.net ([62.24.135.70]:15582 "EHLO
        smtp-out-6.talktalk.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1755531AbdBOX5a (ORCPT <rfc822;git@vger.kernel.org>);
        Wed, 15 Feb 2017 18:57:30 -0500
Received: from PhilipOakley ([92.31.218.76])
        by smtp.talktalk.net with SMTP
        id e9RrcusbFgKste9RrcP1di; Wed, 15 Feb 2017 23:57:23 +0000
X-Originating-IP: [92.31.218.76]
X-Spam: 0
X-OAuthority: v=2.2 cv=GdBVpkfL c=1 sm=1 tr=0 a=e6L6E7eW+5Nb7SO+DvSdIg==:117
 a=e6L6E7eW+5Nb7SO+DvSdIg==:17 a=8nJEP1OIZ-IA:10 a=pGLkceISAAAA:8
 a=ybZZDoGAAAAA:8 a=uPZiAMpXAAAA:8 a=kE_PIER_e4T5cFN5X-QA:9 a=wPNLvfGTeEIA:10
 a=6kGIvZw6iX1k4Y-7sg4_:22 a=0RhZnL1DYvcuLYC8JZ5M:22 a=svzibyHiZmA4t4YY0eFS:22
Message-ID: <77C7E23E18774409AA1818B12C844985@PhilipOakley>
Reply-To: "Philip Oakley" <philipoakley@iee.org>
From:   "Philip Oakley" <philipoakley@iee.org>
To:     "Johannes Schindelin" <Johannes.Schindelin@gmx.de>
Cc:     "Christian Couder" <christian.couder@gmail.com>,
        "Junio C Hamano" <gitster@pobox.com>,
        <git-for-windows@googlegroups.com>, "git" <git@vger.kernel.org>
References: <alpine.DEB.2.20.1702101241210.3496@virtualbox> <xmqq60kdbqmy.fsf@gitster.mtv.corp.google.com> <alpine.DEB.2.20.1702142150220.3496@virtualbox> <xmqqd1ek8oqo.fsf@gitster.mtv.corp.google.com> <CAP8UFD1+AgBVqSh=wHteM3uKO+55ZqqD4cHzBUfN0KTPXyvutQ@mail.gmail.com> <E2C1B7A8FBF94C8CB1C9C5754D882800@PhilipOakley> <alpine.DEB.2.20.1702151509251.3496@virtualbox>
Subject: Re: [git-for-windows] Re: Continuous Testing of Git on Windows
Date:   Wed, 15 Feb 2017 23:57:23 -0000
Organization: OPDS
MIME-Version: 1.0
Content-Type: text/plain;
        format=flowed;
        charset="iso-8859-1";
        reply-type=original
Content-Transfer-Encoding: 7bit
X-Priority: 3
X-MSMail-Priority: Normal
X-Mailer: Microsoft Outlook Express 6.00.2900.5931
X-MimeOLE: Produced By Microsoft MimeOLE V6.00.2900.6157
X-CMAE-Envelope: MS4wfCE7kfr5FdPCb3RG2i+rbLeiuYIOQYotwVvMPx3PCQg3G2oIHZtfJRJFFmmQU/hRmxlt2PrHUs9+8fyHR+257Eh2h3ItjcQ1AXMeUCcm6zbyQMZY++mI
 cc2DFoWq0sZmWoMeK4UUTPrhT+PmhSvGSLSHY0btM9PdxwOVnZEduIOgykmi5T0i8EebPaGVT+o1jRvz/m5YQgzbOxMe4UFn0QvFtpu2xk1Iw5h8PWfjt4mx
 1mcMmXXIOvk1op788KKvJZ5+884hH+amKRgYFQUIDmTxe/oXlUJ4Zk+MpNm6YQ9piFCHYw8ewksJjA8BR1K/cA==
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

From: "Johannes Schindelin" <Johannes.Schindelin@gmx.de>
> Hi Philip,
>
> On Tue, 14 Feb 2017, Philip Oakley wrote:
>
>> From: "Christian Couder" <christian.couder@gmail.com>
>> > On Tue, Feb 14, 2017 at 10:08 PM, Junio C Hamano <gitster@pobox.com>
>> > wrote:
>> > > Johannes Schindelin <Johannes.Schindelin@gmx.de> writes:
>> > >
>> > > > On Mon, 13 Feb 2017, Junio C Hamano wrote:
>> > > >
>> > > > > Johannes Schindelin <Johannes.Schindelin@gmx.de> writes:
>> > > > >
>> > > > > > That is why I taught the Git for Windows CI job that tests the
>> > > > > > four upstream Git integration branches to *also* bisect test
>> > > > > > breakages and then upload comments to the identified commit on
>> > > > > > GitHub
>> > > > >
>> > > > > Good.  I do not think it is useful to try 'pu' as an aggregate
>> > > > > and expect it to always build and work [*1*], but your "bisect
>> > > > > and pinpoint" approach makes it useful to identify individual
>> > > > > topic that brings in a breakage.
>> > > >
>> > > > Sadly the many different merge bases[*1*] between `next` and `pu`
>> > > > (which are the obvious good/bad points for bisecting
>> > > > automatically) bring my build agents to its knees. I may have to
>> > > > disable the bisecting feature as a consequence.
>> >
>> > Yeah, this is a bug in the bisect algorithm. Fixing it is in the GSoC
>> > 2017 Ideas.
>>
>> There are also a few ideas at the SO answers:
>> http://stackoverflow.com/a/5652323/717355
>
> Thanks for that link!
>
> However, my main aim was not to get distracted into yet another corner of
> Git that needs to be fixed (I am on enough of those projects already).
>
> I was merely surprised (and not in a good way) that a plenty ordinary
> bisect between `next` and `pu` all of a sudden tested a *one year old*
> commit whether it was good or not.
>
> And I doubt that the strategy to mark all second parents of all merge
> commits in pu..next as "good" would work well, as the merge bases *still*
> would have to be tested.

I was expecting that if all the second parents were marked as good, then 
there would be no merge bases, as there shouldn't be a forked graph, just 
the linear string of pearls - if bisect doesn't do that then there's an 
failed optimisation to be had.

I don't see anything in the `git bisect --help` page that would indicate 
that the merges themselves are omitted from the bisection.

>
> I guess what I have to resort to is this: if I know that `next` tests
> fine, and that `pu` fails, I shall mark all merge bases as "good". I am
> sure this has its own set of pitfalls, undoubtedly costing me more time on
> that front...
>
> But at least my cursory analysis of this idea seems to make sense: I use
> `next` essentially as a catch-all to verify that the breakage has entered
> `pu`, but not yet `next`. This reasoning makes sense, given that we know
> the waterfall topology of pu/next/master/maint: patches enter from left to
> right, i.e. anything that entered `pu` may later enter `next`, but not
> vice versa.

It may even be worth 'splitting' the pu branch sequence into the existing pu 
(with merges from series that are selected as reasonable), and then a pr 
branch (public review?) on top of that holding the rest of the series that 
have been submitted, so that the CI can do a full test on the tips of them 
to support those devs with limited test capability.


>
> Ciao,
> Dscho
> 

