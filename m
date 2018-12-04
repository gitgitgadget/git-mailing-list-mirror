Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.2 (2018-09-13) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-3.6 required=3.0 tests=AWL,BAYES_00,
	FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,RCVD_IN_DNSWL_HI shortcircuit=no autolearn=ham
	autolearn_force=no version=3.4.2
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 03D70211B3
	for <e@80x24.org>; Tue,  4 Dec 2018 09:13:39 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1725886AbeLDJNh (ORCPT <rfc822;e@80x24.org>);
        Tue, 4 Dec 2018 04:13:37 -0500
Received: from mout.gmx.net ([212.227.17.22]:43009 "EHLO mout.gmx.net"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1725613AbeLDJNh (ORCPT <rfc822;git@vger.kernel.org>);
        Tue, 4 Dec 2018 04:13:37 -0500
Received: from [192.168.0.129] ([37.201.193.149]) by mail.gmx.com (mrgmx101
 [212.227.17.168]) with ESMTPSA (Nemesis) id 0MCPhl-1gdDRE1Leb-0099e6; Tue, 04
 Dec 2018 10:13:25 +0100
Date:   Tue, 4 Dec 2018 10:13:24 +0100 (STD)
From:   Johannes Schindelin <Johannes.Schindelin@gmx.de>
X-X-Sender: virtualbox@gitforwindows.org
To:     Jeff King <peff@peff.net>
cc:     Luc Van Oostenryck <luc.vanoostenryck@gmail.com>,
        Paul Morelle <paul.morelle@gmail.com>,
        Git Users <git@vger.kernel.org>
Subject: Re: [PATCH] rebase -i: introduce the 'test' command
In-Reply-To: <20181203213134.GD8700@sigill.intra.peff.net>
Message-ID: <nycvar.QRO.7.76.6.1812041007070.41@tvgsbejvaqbjf.bet>
References: <3fb5a7ff-a63a-6fac-1456-4dbc9135d088@gmail.com> <nycvar.QRO.7.76.6.1811281600240.41@tvgsbejvaqbjf.bet> <25e07b91-3089-153c-2ecf-7d2d66bc3b65@gmail.com> <nycvar.QRO.7.76.6.1811281935310.41@tvgsbejvaqbjf.bet> <20181201200209.GC29120@sigill.intra.peff.net>
 <20181203172743.kq5zfbfnvjadeikj@ltop.local> <nycvar.QRO.7.76.6.1812031957060.41@tvgsbejvaqbjf.bet> <20181203213134.GD8700@sigill.intra.peff.net>
User-Agent: Alpine 2.21.1 (DEB 209 2017-03-23)
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
X-Provags-ID: V03:K1:PUnKTv/sDNRtr6zO7lcnvzI6L10S2KgkrKxLN0GXJTPOfKw1i+o
 /DbMTQcg+WBPBE423w6HI8Vtzs6hmgJJHIvGUKslncxvkbuS9/ywkBIMKEWJxLVi2O6NptJ
 /Sl2P/LOlHtEAAhSD1SIllLGepuZv39eBDEV32vAVn9f2wtpdPELVhC89yCaTP/ergmhOn+
 /CSWNJUB7t1Uz1hBb+Rxw==
X-UI-Out-Filterresults: notjunk:1;V03:K0:WbNKHYpCo7w=:hTWR+DKbJHYvZBEoowoXmi
 UW8foUaVRjqOSHeALTB27L4d7Fj//yxuiOvZaclOx0QuZwDwIZEGPPbMZkX+kVJjF3IapYExd
 pV4cYUmdd3oEcXzU49L9pLNbDW5FykfUAHG1QyKNoCz+DIspvlRmSIJig+SR2RTszFPi/SD34
 hIKqzjFw+GC3HKYMKhGEd4jVTJdUyjb/aaqDeM8w4UrSGfu8CywFqHcwzsG7R0YqER+ukD46e
 0RSyjQxS1X6YTtwU8uInttQnrfkKkyWsIJPbdGCdZIrPpUb9ayoRgHY0ni68AnheNiZC89We/
 nfuuEszKDEgVIbOgbSv0e4l650YJOmNVtVXyg/L+ZFUHBZ1+pNLYl7z8aVm8dc9VBrx6IyyBJ
 4RNbuoKB1/S/sgB95ogTD0nnHaX3ziJZxZ+Ic+g3qSsuzYwfpTJld4Kk4Wx2P5EYlzbud7l6d
 tdkDnCMXuRTRRfNeZYNdF2JnMIfArubSdre9Muq3D3sBxx4wW+3qMnhreKYg5onV8GcO1u0A2
 m8On7SGyVAHWGG8DMtvovfMhJEVbvq5s5DTIjKMEbDU/kfHGr4k/ZBK82025WMHFfWa++Udnd
 9pycWi66nX9caeL0jlVpGG5PE5/NPu3dfl0YnZSOnyK3RugpO9s8UZK56HoQ5UaGzv3MtBL5B
 QtXnF6A+1KlnySWqv/VNqEuwKxFsueD0rGUnRpjbx+TR5TDlKQIH8dzFcvndENpPTzoRpqa/s
 /BnefrcukfTcpEVVFx6+xlHCmQkNLls9wfC/oJszGBSKHi3LQrfghoznhw+iVDLjArVN6V0sc
 C2y6IFP5T6dAoyjIBQa+RIIAcIw37aPLk2qoJs+SntVkaqroB0h9kW9ERMfChXjbHbOP9ti10
 avesH8rlv9ULZXyb0JwbvFlELctdN4T5OJuPDEMfldgboyUcBB0kt/SebRxBQ9IlexCV3yijq
 LIsLUZjM1nA==
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Hi Peff,

On Mon, 3 Dec 2018, Jeff King wrote:

> On Mon, Dec 03, 2018 at 08:01:44PM +0100, Johannes Schindelin wrote:
> 
> > > In this sort of situation, I often whish to be able to do nested rebases.
> > > Even more because it happen relatively often that I forget that I'm
> > > working in a rebase and not on the head, and then it's quite natural
> > > to me to type things like 'git rebase -i @^^^' while already rebasing.
> > > But I suppose this has already been discussed.
> > 
> > Varieties of this have been discussed, but no, not nested rebases.
> > 
> > The closest we thought about was re-scheduling the latest <n> commits,
> > which is now harder because of the `--rebase-merges` mode.
> > 
> > But I think it would be doable. Your idea of a "nested" rebase actually
> > opens that door quite nicely. It would not *really* be a nested rebase,
> > and it would still only be possible in interactive mode, but I could
> > totally see
> > 
> > 	git rebase --nested -i HEAD~3
> > 
> > to generate and prepend the following lines to the `git-rebase-todo` file:
> > 
> > 	reset abcdef01 # This is HEAD~3
> > 	pick abcdef02 # This is HEAD~2
> > 	pick abcdef03 # This is HEAD~
> > 	pick abcdef04 # This is HEAD
> > 
> > (assuming that the latest 3 commits were non-merge commits; It would look
> > quite a bit more complicated in other situations.)
> 
> Yeah, I would probably use that if it existed.

I kind of use it, even if it does not exist ;-)

> It would be nicer to have real nested sequencer operations, I think, for
> other situations.

I agree. But for the moment, our data format is too married to the exact
layout of .git/, thanks to `git rebase`'s evolution from a Unix shell
script.

Alban has this really great patch series to work on the todo list
in-memory, and that paves the way to decouple the entire sequencer thing
from the file system.

The most notably thing that still would need to be encapsulated would be
the options: currently, there is a plethora of inconsistent options files
being saved into the state directory (for some, the mere presence
indicates `true`, some contain `true` or `false`, others contain text,
etc).

> E.g., cherry-picking a sequence of commits while you're in the middle of
> a rebase.

You will be delighted to learn that you can cherry-pick a sequence of
commits in the middle of a rebase already. I do `exec git cherry-pick
<range>` *all* the time.

> But I suspect getting that right would be _loads_ more work, and
> probably would involve some funky UI corner cases to handle the stack of
> operations (so truly aborting a rebase may mean an arbitrary number of
> "rebase --abort" calls to pop the stack). Your suggestion is probably a
> reasonable trick in the meantime.

You know what is an even more reasonable trick? Worktrees.

I only thought about that this morning, but I should have mentioned it
right away, as I use it quite frequently.

When I have tricky nested rebases to perform, I do use throw-away
worktrees where I check out unnamed branches, work on those, and then
integrate them back into the "outer rebase" via the `reset` command in the
todo list.

Ciao,
Dscho
