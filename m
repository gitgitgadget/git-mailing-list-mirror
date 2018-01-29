Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-2.6 required=3.0 tests=AWL,BAYES_00,
	FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,HEADER_FROM_DIFFERENT_DOMAINS,
	RCVD_IN_DNSWL_HI,T_RP_MATCHES_RCVD shortcircuit=no autolearn=no
	autolearn_force=no version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 1BBD81F404
	for <e@80x24.org>; Mon, 29 Jan 2018 20:55:41 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1751760AbeA2Uzi (ORCPT <rfc822;e@80x24.org>);
        Mon, 29 Jan 2018 15:55:38 -0500
Received: from mout.gmx.net ([212.227.15.15]:50441 "EHLO mout.gmx.net"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1751642AbeA2Uzf (ORCPT <rfc822;git@vger.kernel.org>);
        Mon, 29 Jan 2018 15:55:35 -0500
Received: from MININT-KR8J64V.europe.corp.microsoft.com ([37.201.193.1]) by
 mail.gmx.com (mrgmx003 [212.227.17.190]) with ESMTPSA (Nemesis) id
 0LpKrt-1fINAj49y9-00f6sW; Mon, 29 Jan 2018 21:55:29 +0100
Date:   Mon, 29 Jan 2018 21:55:27 +0100 (STD)
From:   Johannes Schindelin <Johannes.Schindelin@gmx.de>
X-X-Sender: virtualbox@MININT-6BKU6QN.europe.corp.microsoft.com
To:     Junio C Hamano <gitster@pobox.com>
cc:     Eric Sunshine <sunshine@sunshineco.com>,
        Git List <git@vger.kernel.org>,
        Jacob Keller <jacob.keller@gmail.com>
Subject: Re: [PATCH 1/8] sequencer: introduce new commands to reset the
 revision
In-Reply-To: <xmqqa7x2c3w7.fsf@gitster.mtv.corp.google.com>
Message-ID: <nycvar.QRO.7.76.6.1801292154420.35@ZVAVAG-6OXH6DA.rhebcr.pbec.zvpebfbsg.pbz>
References: <cover.1516225925.git.johannes.schindelin@gmx.de> <8a91bf2184a3da4c0d5a13ba184813068e51f5c8.1516225925.git.johannes.schindelin@gmx.de> <CAPig+cQbG2s-LrAo9+7C7=dXifbWFJ3SzuNa-QePHDk7egK=jg@mail.gmail.com>
 <xmqqa7x2c3w7.fsf@gitster.mtv.corp.google.com>
User-Agent: Alpine 2.21.1 (DEB 209 2017-03-23)
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
X-Provags-ID: V03:K0:1GccR0zcnDOe1KdE60cG/CPa781ihs4RFP99cDSVzYIREBIViGV
 o7/grO8hmy/9ayNocVVtB6+lpo92p6vXszpDKImusP+F9EV33DeHe1UjDwXZfCJOETGI2Xj
 WVce2otVgBM+9CudV5zw1fpk3yGVqgdmqz4H+mHj0Ggr0a39bS7Dn9Q96Ge27xUy8breHpY
 TW8xFCR8IE8M5Lv2qXNzw==
X-UI-Out-Filterresults: notjunk:1;V01:K0:XixnyR+Ewaw=:lAGR4bbAxrast6An35t//C
 8CvSm41Xx3CT1HtN2woFgfgSNlapXtlmOGcI8ScK0hMNsvX1lcN8ktkCuu0w0X0YeiiRbvnsv
 cP0hH+sYzM7JyZesEJWiDTMX310OpCb+S444zfmvc91uJ9DwirHcCI0qQp3LKIeHpaE+sz41I
 yyo04gkm+rZ9UlnDOnE1lQI49gtJ7ZU5Vkfr75UOC1/Cdpdx4Eai4vUqWAtcVqgAfHJdf0J5E
 ExLo8pnJOJgHrPWQfV46a7KzAXwesaodgfxLjYp6NdcvQkaUyBBhDVhUhMh6S0YkUeYi90b+D
 IYi50bMmDlVTna+SKHOwbEpTTB3EVAfmcCIfj8tJGMfJSGQjhdU2UKVDbYvTT39hw/Cla59tX
 ou8iMIXIjAOPZwS3afgVXTl904D7bO69jMi1NT3YtLIYzK3wE5/9nBTDk++oOKlTSKcXm1RqG
 lAZupzq14QNEsxKXoX0w/57CS86lF1ff7dibkbmSyajIuxVSlScS8QDsb8rMtS++FntJnofag
 bmbIDGMcr2NInKxn94uMkFoGlIH2JjtKZ0Eu/VL0z0eLZV9Q9VOfoyUsF0FTWe2qonFJVs85V
 GVb/K6h2naH3mYy4RCI33SDL+gfAHiLjxwOR3aav/UPxOpH3128qJpSJ0Oa3gPZuSBD9dtC3f
 nbdjy+N+T+uUYpNKNxO1lrAV1fCbd42NPkiGI3nMR3AH8GFEAYfI/URH7EKRnbX4Opi69qB/U
 Ldv313Ww2Xjx4iTQrhZNd4VZepRdcxx27wfyRJlUKbjK6cA0ZEXLz7v0wed2jZ/I9605rnGcz
 FcUKyeWrfbXsBH891aaVi18qKY7M1cy26KpDJ/nsEDduH2qCjfyjujz+PDpDI7JYSNoQSjV
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Hi Junio,

On Wed, 24 Jan 2018, Junio C Hamano wrote:

> Eric Sunshine <sunshine@sunshineco.com> writes:
> 
> >> +static int do_reset(const char *name, int len)
> >> +{
> >> +       [...]
> >> +       if (hold_locked_index(&lock, LOCK_REPORT_ON_ERROR) < 0)
> >> +               return -1;
> >> +
> >> +       for (i = 0; i < len; i++)
> >> +               if (isspace(name[i]))
> >> +                       len = i;
> >
> > What is the purpose of this loop? I could imagine that it's trying to
> > strip all whitespace from the end of 'name', however, to do that it
> > would iterate backward, not forward. (Or perhaps it's trying to
> > truncate at the first space, but then it would need to invert the
> > condition or use 'break'.) Am I missing something obvious?
> 
> I must be missing the same thing.  Given that the callers of
> do_reset(), other than the "bug" thing that passes the hard coded
> "onto", uses item->arg/item->arg_len which includes everything after
> the insn word on the line in the todo list, I do suspect that the
> intention is to stop at the first whitespace char to avoid creating
> a ref with whitespace in it, i.e. it is a bug that can be fixed with
> s/len = i/break/.
> 
> The code probably should further check the resulting string with
> check_ref_format() to detect strange chars and char sequences that
> make the resulting refname invalid.  For example, you would not want
> to allow a label with two consecutive periods in it.

The code already checks that by creating a ref.

No need to go crazy and validate ref names every time we parse the todo
list (which is quite often), eh?

Ciao,
Dscho
