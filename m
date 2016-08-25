Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-4.1 required=3.0 tests=AWL,BAYES_00,
	FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,HEADER_FROM_DIFFERENT_DOMAINS,
	RCVD_IN_DNSWL_HI,RP_MATCHES_RCVD shortcircuit=no autolearn=ham
	autolearn_force=no version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id C73612018E
	for <e@80x24.org>; Thu, 25 Aug 2016 11:56:31 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1758386AbcHYL43 (ORCPT <rfc822;e@80x24.org>);
        Thu, 25 Aug 2016 07:56:29 -0400
Received: from mout.gmx.net ([212.227.17.22]:57349 "EHLO mout.gmx.net"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1757820AbcHYL43 (ORCPT <rfc822;git@vger.kernel.org>);
        Thu, 25 Aug 2016 07:56:29 -0400
Received: from virtualbox ([37.24.141.250]) by mail.gmx.com (mrgmx101) with
 ESMTPSA (Nemesis) id 0LiY3U-1b0F2d3QHU-00clow; Thu, 25 Aug 2016 13:54:43
 +0200
Date:   Thu, 25 Aug 2016 13:54:41 +0200 (CEST)
From:   Johannes Schindelin <Johannes.Schindelin@gmx.de>
X-X-Sender: virtualbox@virtualbox
To:     Junio C Hamano <gitster@pobox.com>
cc:     Michael J Gruber <git@drmicha.warpmail.net>,
        Duy Nguyen <pclouds@gmail.com>,
        git-for-windows <git-for-windows@googlegroups.com>,
        Git Mailing List <git@vger.kernel.org>
Subject: Re: core.autocrlf, was Re: [git-for-windows] Re: [ANNOUNCE] Git for
 Windows 2.9.3
In-Reply-To: <xmqq37luru7z.fsf@gitster.mtv.corp.google.com>
Message-ID: <alpine.DEB.2.20.1608251343300.4924@virtualbox>
References: <alpine.DEB.2.20.1608131214070.4924@virtualbox> <xmqqshu8u0px.fsf@gitster.mtv.corp.google.com> <alpine.DEB.2.20.1608171507530.4924@virtualbox> <xmqqeg5nbehc.fsf@gitster.mtv.corp.google.com> <alpine.DEB.2.20.1608181022250.4924@virtualbox>
 <CACsJy8A3tkMY-iLPCDj9sqB4HpAK_cxsUu5Z7fsGcCQEORyxUg@mail.gmail.com> <alpine.DEB.2.20.1608231553030.4924@virtualbox> <2a6d2230-90ce-0f54-c7ae-a5aa595a2f73@drmicha.warpmail.net> <alpine.DEB.2.20.1608231736180.4924@virtualbox> <alpine.DEB.2.20.1608231758260.4924@virtualbox>
 <xmqqbn0iu50a.fsf@gitster.mtv.corp.google.com> <alpine.DEB.2.20.1608241743460.4924@virtualbox> <xmqq37luru7z.fsf@gitster.mtv.corp.google.com>
User-Agent: Alpine 2.20 (DEB 67 2015-01-07)
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
X-Provags-ID: V03:K0:Z/vIkGAb8844bHQO9xZOrjlCfFbOh6QFt0AGiHp5RBC+LgshvQ2
 VmpMU4m735HwN20DZUB4/HZprJv/l2c9qvWiMYLS5GudriCpakhYpB6QYpTM4rMIC8BMusY
 7IPiEfXFs97aEp0vFTKi4YbLO+dWXV2xMefUuf74i9AAo7JqZdnfETclclfjFDm5HOZ6DTq
 iYMp8spZ7FfDDth8O4UnQ==
X-UI-Out-Filterresults: notjunk:1;V01:K0:MUNeWSr8QU8=:GtdRSTl0WAXJZUSBVrlPVo
 hWhoHKEIE+eErSj6Ztj8FqkcRUY3nDN6QtJ5jqVowk803x1jRdDtOXC/ozLmCZHpuOy+7VRMh
 rbFYkYfiH8JYfh1umIJ2NhVSA7g6Xok9jZbemgQqdDThAr0oyBHfzhIi3SHLVeqlv8SXF2JR9
 GaBaqJGGwXCHSN0eXqMHSKkHvByCwJCO1MiBBMFREpdbvmfQrKKYRryOkkiiKLcs6+EakpQEp
 jPvsajD4YRW+MbgueewCFJNaQL9CpajRg4rp8whkU6ZakVYL6Q4BYNlk/EjbknUtFtls8WEie
 l9EvHpPGeveBKja2HO4MoY4RIbU8birF3Tyy0IXv/kfqb8Vlmq+DH3E69l4CR3P0UkvJ9F69v
 RNZ/vQ12skYoc6mSQA9lC4Uw0TyP15AV1RkT24Paig52DfdQFWs/8LCJjTr4FePLkQMrnPcbf
 lgp/0dGYkh/yuE58IxWpTaVoVzJx0HLWxSzfm7gSy5vtISzpIQ4ICceoNF2OcCGqTGYrqq/kD
 3ILN4bpnHnATj0Mb2c8uJzAONQqv0PdXBJiKrnoF5XA9qped52uSJduwaS+NFht3DvTGQU9GI
 YPP4ub06M2PPw+wYLV5grvA2xB6Ifu7LZT7GAukIseRfHbcy1jJ591dfxCgz4qPWA5Y4jiF47
 2bPP3MKe275lJ7/9wS8U+ME5o4lEowmP1jlPlj+pqzoW1qV1uhFNQSddTy7OAj3NredoVIVQB
 Kk3lE0LCVjBBIWKWlQS5o/PHv0x7Bhbry+3WvLwNpCj2bm6J+d+zYgsdVTnzOB22Op3oG0Emi
 r9hn1vU
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Hi Junio,

On Wed, 24 Aug 2016, Junio C Hamano wrote:

> Johannes Schindelin <Johannes.Schindelin@gmx.de> writes:
> 
> >> In any case, in the ideal future, I would imagine that we would want
> >> to have "cat-file blob" to enable "--filters" by default; that would
> >> make cat-file and hash-objects a pair of symmetric operations.
> >
> > I would advocate against that. It is not like the terms "hash-object" and
> > "cat-file" even *look* like they are opposites.
> 
> I do not quite understand your objection.
> 
> hash-object is "I have data somewhere on the filesystem, and I want
> to store it in the object store even though I am not ready to add it
> to the index yet (or I may not even add it to the index ever), just
> to make it available to Git tools".

That is not how I read it. I read "hash-object" as: "hash this object".
There was not a thought in my mind that it would apply filters. Since that
was so clear in my mind, I failed to understand that you do not consider
it a design mistake to turn on --filters by default in hash-object.

I read "cat-file" just the same: concatenate files and print on the
standard output. Now, it is confusing enough that it does not concatenate
files in unless in batch mode, and it would be even more confusing if it
started to behave as if the user had called "git checkout --dry-run
<revision> -- <path>" (which does not exist, but for which I would
understand the --filters default).

> Yes, correcting ancient mistakes is costly.  Such is life.

I was not talking about the cost of correcting mistakes. Running --filters
is potentially very costly. Just so you understand what I am talking
about: I have a report that says that checking out a sizeable worktree
with core.autocrlf=true is 58% slower than with core.autocrlf=false. That
is horrible. And it is a cost that is entirely born by Windows users.

In short: I think letting hash-object default to --filters was a mistake,
and doing the same for cat-file would be a mistake, too.

Ciao,
Dscho
