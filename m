Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-3.2 required=3.0 tests=AWL,BAYES_00,
	FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,RCVD_IN_DNSWL_HI shortcircuit=no autolearn=ham
	autolearn_force=no version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 587401F424
	for <e@80x24.org>; Wed, 11 Apr 2018 11:29:24 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1751891AbeDKL3W (ORCPT <rfc822;e@80x24.org>);
        Wed, 11 Apr 2018 07:29:22 -0400
Received: from mout.gmx.net ([212.227.17.20]:42609 "EHLO mout.gmx.net"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1751797AbeDKL3U (ORCPT <rfc822;git@vger.kernel.org>);
        Wed, 11 Apr 2018 07:29:20 -0400
Received: from [192.168.0.129] ([37.201.195.115]) by mail.gmx.com (mrgmx101
 [212.227.17.168]) with ESMTPSA (Nemesis) id 0MgXCF-1es7T00hmB-00O21l; Wed, 11
 Apr 2018 13:29:09 +0200
Date:   Wed, 11 Apr 2018 13:28:51 +0200 (DST)
From:   Johannes Schindelin <Johannes.Schindelin@gmx.de>
X-X-Sender: virtualbox@MININT-6BKU6QN.europe.corp.microsoft.com
To:     Sergey Organov <sorganov@gmail.com>
cc:     git@vger.kernel.org, Junio C Hamano <gitster@pobox.com>,
        Jacob Keller <jacob.keller@gmail.com>,
        Stefan Beller <sbeller@google.com>,
        Philip Oakley <philipoakley@iee.org>,
        Eric Sunshine <sunshine@sunshineco.com>,
        Phillip Wood <phillip.wood@dunelm.org.uk>,
        Igor Djordjevic <igor.d.djordjevic@gmail.com>,
        Johannes Sixt <j6t@kdbg.org>
Subject: Re: [PATCH v6 00/15] rebase -i: offer to recreate commit topology
In-Reply-To: <871sfm737e.fsf@javad.com>
Message-ID: <nycvar.QRO.7.76.6.1804111324350.65@ZVAVAG-6OXH6DA.rhebcr.pbec.zvpebfbsg.pbz>
References: <cover.1519680483.git.johannes.schindelin@gmx.de> <cover.1523362469.git.johannes.schindelin@gmx.de> <87tvsj6rn2.fsf@javad.com> <nycvar.QRO.7.76.6.1804110009080.56@ZVAVAG-6OXH6DA.rhebcr.pbec.zvpebfbsg.pbz> <871sfm737e.fsf@javad.com>
User-Agent: Alpine 2.21.1 (DEB 209 2017-03-23)
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
X-Provags-ID: V03:K1:54xtyIUXn+G5t8+Ub5RjpGFFcs4sAS5wKdL1Gb2HgVUy6s8qYpb
 6Y7qi2anJ1hr/OXopGhet4Hra7bxacI3HjFfkUD4uBsTusjmVoFi5fL5CxuqbUvdwvj5iQR
 iBGAOoqDYBjN3CtGKuZJKn2/yLzFxoHlEDSTbtk5lGnHErDBlFQd6+zfYvqmPJh/m8Jx/no
 y21APL0FI0G1rMX/9Z9Fg==
X-UI-Out-Filterresults: notjunk:1;V01:K0:vTa6y3PIVgk=:PsSCXvCU+WjgZY2Rpuj4tY
 +iGS1LTW/g90Hfoi1eDDX+/qB+pawKfNt5Z1HDo2wAkndoVmb+RZ+O8DhWrtxYgO3LBd2p5Dp
 KJuSKkAYkRqsuBv7J3jNmaVe5g2UptsQ0B/AMSJI9eMDZN08ktXJOlhG+5duwzFem7CcM3PiI
 iB2ei8l5eXiK/x1f/EMPUXZgrxmN1Nfn5MPLAmm9uAEaPavWAp2IFeIfC8CgkFTHVcHlKlMN9
 K05KJsLflTridiAm8AeUka4R7UBaJzX5AU7yN7cPMJprhMiHxz7nRjN/DIFMmvUEXM7cwkHIP
 /7I5fe2MSQ/r6EgBAepkVVBopeSTS2+isyzCSJcdvf/r67O8+XMFxhPxLBePNGcdmyZtjirDE
 34qXluuZB4ukUXEFrx9lQ/eLVzXZes5iY3HFvZH/TNuakFwrcwfQh3kRfQ6xE+nv84rCw9evh
 wJMJIcPohj5SRI3N4xXODC/XYyxqfqDSyFLhUDbVsdpbByrJYw072znFg4cylezAgD4+16tx5
 gCcsj5nYda3Wg4AaxGz5bbD3xE8Yldji0/wZi//x7tPB3sX/gzZSVQbXiNtaQrpZrlepz/cYe
 HK0kkyJNf9n0FC1mp8x9O4K58SvEfHFivRf+6ZrBoQw/ekKbldYFdUGyObg7wXLrgWBBW26xu
 bKTuQaBRQBbFB2uhxjM99fm4CD6rmbnQgkmmNpbuMgArm885Ied+cl3UftNMjK1bV+e/+CzZQ
 8y/hmIHs9G8m2VfUhT4f2+N+q3JrVrq1uu+d/OjTAMfNkOdSfUuTYZv1JCjARB2/MPY6ZMOa7
 RtjZiV7/+5icK0Z1Bd3iJl1KH7iAuHZo0K6fDinwXP8onY9X78=
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Hi Sergey,

On Wed, 11 Apr 2018, Sergey Organov wrote:

> Johannes Schindelin <Johannes.Schindelin@gmx.de> writes:
> 
> > On Tue, 10 Apr 2018, Sergey Organov wrote:
> >
> >> Johannes Schindelin <johannes.schindelin@gmx.de> writes:
> >> 
> >> > Once upon a time, I dreamt of an interactive rebase that would not
> >> > flatten branch structure, but instead recreate the commit topology
> >> > faithfully.
> >> 
> >> [...]
> >> 
> >> > Think of --rebase-merges as "--preserve-merges done right".
> >> 
> >> Both option names seem to miss the primary point of the mode of
> >> operation that you've formulated in the first sentence. I suggest to
> >> rather call the new option in accordance to your description, say,
> >> --no-flatten, --keep-topology, or --preserve-shape.
> >
> > A very quick A/B test shows that neither --no-flatten nor --keep-topology
> > and certainly not --preserve-shape conveys to Git users what those options
> > are supposed to do.
> 
> In fact, my preference would be --[no-]flatten, exactly because the
> default mode of rebase operation flattens the history, and thus what I'm
> talking about is:
> 
> git rebase --no-flatten

And this is the option out of the four that fared *worst* in the A/B
testing. Not even experts in Git internals were able to figure out what
the heck you are talking about.

Now, you can beat that dead horse until it is pulp. Your choice. I'd
rather go on to more interesting things, because as far as I am concerned,
the naming issue has been settled, with you being the only person in
disfavor of --rebase-merges.

What you *could* do is finally take your RFC to the test. Run it with the
concrete example I showed you in
https://public-inbox.org/git/nycvar.QRO.7.76.6.1803261405170.77@ZVAVAG-6OXH6DA.rhebcr.pbec.zvpebfbsg.pbz/

It is high time that you demonstrated on this concrete case study how your
proposed solution performs. And then tally that up with Phillip's
strategy.

Ciao,
Johannes
