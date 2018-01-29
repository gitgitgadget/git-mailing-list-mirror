Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-2.6 required=3.0 tests=AWL,BAYES_00,
	FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,HEADER_FROM_DIFFERENT_DOMAINS,
	RCVD_IN_DNSWL_HI,T_RP_MATCHES_RCVD shortcircuit=no autolearn=no
	autolearn_force=no version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id F26E01F404
	for <e@80x24.org>; Mon, 29 Jan 2018 20:50:15 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1753877AbeA2UuO (ORCPT <rfc822;e@80x24.org>);
        Mon, 29 Jan 2018 15:50:14 -0500
Received: from mout.gmx.net ([212.227.15.19]:61461 "EHLO mout.gmx.net"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1753872AbeA2UuM (ORCPT <rfc822;git@vger.kernel.org>);
        Mon, 29 Jan 2018 15:50:12 -0500
Received: from MININT-KR8J64V.europe.corp.microsoft.com ([37.201.193.1]) by
 mail.gmx.com (mrgmx002 [212.227.17.190]) with ESMTPSA (Nemesis) id
 0Mgt3g-1eT9Kw46UK-00M4wF; Mon, 29 Jan 2018 21:50:07 +0100
Date:   Mon, 29 Jan 2018 21:50:05 +0100 (STD)
From:   Johannes Schindelin <Johannes.Schindelin@gmx.de>
X-X-Sender: virtualbox@MININT-6BKU6QN.europe.corp.microsoft.com
To:     Eric Sunshine <sunshine@sunshineco.com>
cc:     Git List <git@vger.kernel.org>, Junio C Hamano <gitster@pobox.com>,
        Jacob Keller <jacob.keller@gmail.com>
Subject: Re: [PATCH 1/8] sequencer: introduce new commands to reset the
 revision
In-Reply-To: <CAPig+cQbG2s-LrAo9+7C7=dXifbWFJ3SzuNa-QePHDk7egK=jg@mail.gmail.com>
Message-ID: <nycvar.QRO.7.76.6.1801292146270.35@ZVAVAG-6OXH6DA.rhebcr.pbec.zvpebfbsg.pbz>
References: <cover.1516225925.git.johannes.schindelin@gmx.de> <8a91bf2184a3da4c0d5a13ba184813068e51f5c8.1516225925.git.johannes.schindelin@gmx.de> <CAPig+cQbG2s-LrAo9+7C7=dXifbWFJ3SzuNa-QePHDk7egK=jg@mail.gmail.com>
User-Agent: Alpine 2.21.1 (DEB 209 2017-03-23)
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
X-Provags-ID: V03:K0:jtFF2oTn+cEKzy7gOYUMiI8aR6AJPkuG8XwGerpDEljAc1x85Bt
 Ydq/izq5iO2ETxxmNI/hJZJDnsaWBxFtsFTrWwd9uQZuBLRwH/4+QgRFPg2Wsu8gnNKw8Ma
 QsOXHL412rwoAu2bKkqh9bW5/ZXT7r7LjGw3OR039lfOqNiB9Cb1RimQyURNLoOwC4iTBZ7
 JskGpfSr30va14VtuQ0rA==
X-UI-Out-Filterresults: notjunk:1;V01:K0:/1wR6vw+kl4=:nOoboBi9K17xPQ/o15fqRr
 BQa4rLgmtkApq0i0HDgpImFUR5PIBr8rFJfSrQlLg9Qg+sWzwjFq6KMfNk2xdXODHf01fwkbM
 gYWQGQpWaazZ8wVTUpZhYUV5lXjRUnWZB/iBqN7MSYc+l9bC0OM4i9WUbHTH2wZZwKDwwfi6E
 QWV5qAPfzmiDOr3DVG+HaF3RBnHX72YW7hdspPaJdYcHhktBdeEi9kzCIRKpsQ6P3YwNR4vnT
 Xo4MLmKdvEAe37S2mMHJFKU89PVP/zWWY/i394lLrkwqyGooeX6befi0wew3/OdU7ekglCaz2
 OpwRlui2toOei6GIlw7/RFkiZVuI2tJE67LYTnMy0S2BUqgMomANbqPkg/5efGR1sH1A/d/SK
 Q6ZejjHwKTOdP3iYZPIGCjn5/fRSwPlPd+EfV5weStzQTxfmfYiJxqpeEUkMW/oi4lDvr+ca3
 cXCz+HEiftw30d8AcSmI4dGpV3wmZ1Ngn68PhqPfB/zFkcxFnLSAunAP/yPkIo4FwSYvefA6m
 9QTS3/YhY0K1hGThmUBCKSDk1mrU8QFqnesf9St5QUvqkWTEHiHxShoVfvZbsEyLpfFzrWcM6
 5ej1z1DnhQGjo8/fLbSKoHE7P6ZkxkRGyFwNdm/upH/kACTu687nAuONZ8p/8PqNMIyrffaic
 SUTu8x+DzPiMsnREiwY6fbtGV8GF0g1o2haCipvlPhnKMJ3plal340b4+ZfU83eEvTZnE42AF
 FaYldf1w1L3GEf4f8ydTejHfXlczfCQWdUliM25Y4ixmObXwRdAG6YDyLnnnTrWpXrIkMIlb4
 Tk8OQrIcynJ1666KmF+DjdALsUmZ11FwTfuH/Q6ajzc789Wwk0zxwkBwA2937cR3nQM49kU
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Hi Eric,

On Fri, 19 Jan 2018, Eric Sunshine wrote:

> On Thu, Jan 18, 2018 at 10:35 AM, Johannes Schindelin
> <johannes.schindelin@gmx.de> wrote:
> > [...]
> > +static int do_reset(const char *name, int len)
> > +{
> > +       [...]
> > +       if (hold_locked_index(&lock, LOCK_REPORT_ON_ERROR) < 0)
> > +               return -1;
> > +
> > +       for (i = 0; i < len; i++)
> > +               if (isspace(name[i]))
> > +                       len = i;
> 
> What is the purpose of this loop? I could imagine that it's trying to
> strip all whitespace from the end of 'name', however, to do that it
> would iterate backward, not forward. (Or perhaps it's trying to
> truncate at the first space, but then it would need to invert the
> condition or use 'break'.) Am I missing something obvious?

Yes, you are missing something obvious. The idea of the `reset` command is
that it not only has a label, but also the oneline of the original commit:

	reset branch-point sequencer: prepare for cleanup

In this instance, `branch-point` is the label. And for convenience of the
person editing, it also has the oneline. This came in *extremely* handy
when editing the commit topology in Git for Windows, i.e. when introducing
topic branches or flattening them.

In the Git garden shears, I separated the two arguments via `#`:

	reset branch-point # sequencer: prepare for cleanup

I guess that is actually more readable, so I will introduce that into this
patch series, too.

Ciao,
Dscho
