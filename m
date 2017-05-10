Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-2.2 required=3.0 tests=AWL,BAYES_00,
	FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,HEADER_FROM_DIFFERENT_DOMAINS,
	RCVD_IN_DNSWL_HI,RCVD_IN_SORBS_WEB,RP_MATCHES_RCVD shortcircuit=no
	autolearn=no autolearn_force=no version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 53D8820188
	for <e@80x24.org>; Wed, 10 May 2017 19:48:57 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1754595AbdEJTsz (ORCPT <rfc822;e@80x24.org>);
        Wed, 10 May 2017 15:48:55 -0400
Received: from mout.gmx.net ([212.227.17.21]:52048 "EHLO mout.gmx.net"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1753724AbdEJTsy (ORCPT <rfc822;git@vger.kernel.org>);
        Wed, 10 May 2017 15:48:54 -0400
Received: from virtualbox ([37.201.192.198]) by mail.gmx.com (mrgmx102
 [212.227.17.168]) with ESMTPSA (Nemesis) id 0MQMBU-1dc7iF1VSm-00Tpf5; Wed, 10
 May 2017 21:48:47 +0200
Date:   Wed, 10 May 2017 21:48:46 +0200 (CEST)
From:   Johannes Schindelin <Johannes.Schindelin@gmx.de>
X-X-Sender: virtualbox@virtualbox
To:     Stefan Beller <sbeller@google.com>
cc:     "git@vger.kernel.org" <git@vger.kernel.org>,
        Junio C Hamano <gitster@pobox.com>
Subject: Re: Automating Coverity, was Re: [PATCH 00/26] Address a couple of
 issues identified by Coverity
In-Reply-To: <alpine.DEB.2.21.1.1705052227120.146734@virtualbox>
Message-ID: <alpine.DEB.2.21.1.1705101801300.146734@virtualbox>
References: <cover.1493237937.git.johannes.schindelin@gmx.de> <CAGZ79kbbHshh4=WC2ymG15=W5oq98b3KTV4zxiTx0LgCLeYwfQ@mail.gmail.com> <alpine.DEB.2.20.1704280010160.3480@virtualbox> <CAGZ79kYOp1deMgcEB3HHXeEcLOKNs4KPjdT_W2CD+4Amduv2Wg@mail.gmail.com>
 <alpine.DEB.2.20.1704282205320.3480@virtualbox> <alpine.DEB.2.21.1.1705052227120.146734@virtualbox>
User-Agent: Alpine 2.21.1 (DEB 209 2017-03-23)
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
X-Provags-ID: V03:K0:Q/Mf5xofivDsd/SqjAmTUlXp9U9wU0lHz5OKAA6+qmww0YOc36b
 uVGAEQyKf2I4OKyzNg/oHOsuBqyFlfd6zW0yDhQVO9nQEwfU5hnQlpIybhxUMToUULGOovd
 BawJPZPpGd7Hbsowm7o2Rg0jHBwMBrOFFs1T9UQFxj552QajL3zEapXIlTmis3KjYCRX09u
 pKKoOPQiTDVAcGhEZTf1g==
X-UI-Out-Filterresults: notjunk:1;V01:K0:deZjcEZhDt8=:vAD91jNiZW3UQSB77p6x8/
 8J4JAZYWBG5JLMN3q0LCE9kvO6WHSQMuaRWPc5IogtpaZG8RH+LoYUzK5N5ggyy5MwScs3x4u
 227otRwj4VPK5lsGXzsVLE7xE7P3TIEl3tswf7K7A+ZemI3+l67hFmNwR///44qCsW5M/XwIS
 b+GY+ZMtBDutr7vx5nqKckYfIzxuAFIxhNW/JZOPpX6tW/ZhU7TjcvebZHEZcBPIR/OBYSwap
 lwjIRBFEIEMr2MNmu60Qy/x8MB/CoZAcEOWhsa1EaBQFBsna5j5KvtRmsg/MbcXFaDsOubLop
 zYUtHDhgTFK6ZCfCjKAavlKQvjx3Na0BIZG2VpgFBLl7eTtRLO0JQGz5M/v0TAU6Awcio96in
 jSM+9Vr9/abAbY2dh3WHofsiw1XHVvMDTnQ1n4dSQn0zfPamj8mEOiO/8YJ5ZBGp0dmz1k2sx
 9Q6I9GPrye0WJ3b5eWs92SXhkHE0qgznJANzAp7u9tCN5QrD9EoWPiP390c6+ALRSiMPAlZCS
 XNBC3XRZUy2b6/oQCoiGwj0g/0PGqik9ZyHbNKZJY4mqHmCOeZYRi+/+UryAbkvvtnh5Iki6J
 Bh0YwPZB8cDTJhoT4f6mgMIenKcNOEOf4nMWAe6Urj4dbqMpJQDSmFVrsvxeWFimPrF0CsOXA
 cX4qDaVxLBQbFXu876TNKohRcZpXzmNK2HWAaetoPxAJ5l4dr1MwRAC5MYGDrlNdmib3Kmc0L
 C/0GlC7YX/fefyr054jcFZ0IeGSaMjYqknoYxuESXpACBMhzlvGJ0/6ldQAsE7jUfE0GsFNyd
 A55bRkU
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Hi Stefan,

On Fri, 5 May 2017, Johannes Schindelin wrote:

> On Fri, 28 Apr 2017, Johannes Schindelin wrote:
> 
> > On Fri, 28 Apr 2017, Stefan Beller wrote:
> > 
> > > On Thu, Apr 27, 2017 at 3:50 PM, Johannes Schindelin
> > > <Johannes.Schindelin@gmx.de> wrote:
> > > 
> > > > I still have to find the time to figure out one more detail: how
> > > > to download and extract the Coverity tool (the .zip archive has a
> > > > variable name for the top-level directory), and doing that only
> > > > every once in a while, say, only when there is no previously
> > > > unpacked tool, or it is already 4 weeks old.
> > > 
> > > That is an interesting problem, which I ignored as the older
> > > versions of their tools still works once they release new versions.
> > > So I just manually check every once in a while if they have new
> > > versions out there.
> > > 
> > > So if you find a nice solution to that problem, let me know, please.
> > 
> > I think I have a working idea (jotting it down in the editor,
> > untested):
> > 
> > [... totally untested snippet ...]
> 
> And now I edited it and tested it. The code is now part of the script I
> use for pretty much all administrative (i.e. recurring and boring) tasks
> in the Git for Windows project:
> 
> 	https://github.com/git-for-windows/build-extra/commit/05b5342128

Oh, I completely forgot to mention that I tried to set the FLEX_ARRAY
constant to something quite large (I used 64k), but apparently that does
not work as expected, Coverity still insists on complaining about strbufs.

On a second thought, it is actually quite obvious why it does not fix
those reports: STRBUF_INIT has nothing to do with FLEX_ARRAY. D'oh.

My next attempt to work around these bogus claims was to modify the "model
file" by adding a line saying "char strbuf_slopbuf[64];", but that was
sadly not picked up by Coverity either.

My current thinking is that I will simply patch strbuf.c via `sed
's/^\(char struct_slopbuf\[\)1\[/&64[/'`.

Ciao,
Dscho
