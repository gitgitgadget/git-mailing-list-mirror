Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-3.3 required=3.0 tests=AWL,BAYES_00,
	FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,RCVD_IN_DNSWL_HI shortcircuit=no autolearn=ham
	autolearn_force=no version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id C9ABD200B9
	for <e@80x24.org>; Sat,  5 May 2018 22:04:00 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1751826AbeEEWD6 (ORCPT <rfc822;e@80x24.org>);
        Sat, 5 May 2018 18:03:58 -0400
Received: from mout.gmx.net ([212.227.17.20]:43373 "EHLO mout.gmx.net"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1750967AbeEEWD5 (ORCPT <rfc822;git@vger.kernel.org>);
        Sat, 5 May 2018 18:03:57 -0400
Received: from [192.168.0.129] ([37.201.195.116]) by mail.gmx.com (mrgmx101
 [212.227.17.168]) with ESMTPSA (Nemesis) id 0LhSfM-1ebbk32pCC-00mZ5h; Sun, 06
 May 2018 00:03:47 +0200
Date:   Sun, 6 May 2018 00:03:50 +0200 (DST)
From:   Johannes Schindelin <Johannes.Schindelin@gmx.de>
X-X-Sender: virtualbox@gitforwindows.org
To:     Jeff King <peff@peff.net>
cc:     git@vger.kernel.org, Junio C Hamano <gitster@pobox.com>,
        Thomas Rast <tr@thomasrast.ch>,
        Thomas Gummerer <t.gummerer@gmail.com>,
        =?UTF-8?Q?=C3=86var_Arnfj=C3=B6r=C3=B0_Bjarmason?= 
        <avarab@gmail.com>, Ramsay Jones <ramsay@ramsayjones.plus.com>,
        Stefan Beller <sbeller@google.com>,
        Jacob Keller <jacob.keller@gmail.com>,
        Eric Sunshine <sunshine@sunshineco.com>
Subject: Re: [PATCH v2 13/18] color: provide inverted colors, too
In-Reply-To: <20180505182922.GD17700@sigill.intra.peff.net>
Message-ID: <nycvar.QRO.7.76.6.1805060001230.77@tvgsbejvaqbjf.bet>
References: <cover.1525361419.git.johannes.schindelin@gmx.de> <cover.1525448066.git.johannes.schindelin@gmx.de> <1ebbe359547689d32aa27564929d733a26bb8054.1525448066.git.johannes.schindelin@gmx.de> <20180505182922.GD17700@sigill.intra.peff.net>
User-Agent: Alpine 2.21.1 (DEB 209 2017-03-23)
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
X-Provags-ID: V03:K1:vj4vsm5rgmKVgl1XqTp+1Jf0v+1EoTQGQctJHQ/TEK4yj9HI3/o
 JovObBiBwGYEAiZHIU2tPN/CqXq8Mc6PkHqIVSsEEjvznefiAwCu/qrbBUggZ1rD8tE0J82
 iwBvIPl7xGKQFerjdqcv6Q5k55h2AKtdpwc8MtXWQEDJvrqyuaqSJuzBynfsKHkEz883CCy
 YHeHLGJc/IfCHnxwajRCw==
X-UI-Out-Filterresults: notjunk:1;V01:K0:R0pwulCM/lE=:grimRmbWUN3T+tyFb2swDg
 mhRu4K+6OiFK/qFb671YlOdhSGQ3qP3U18dAjLBMxv0IaTnxFEuVHFLf4dOIfLzGgYJkP8Ea9
 T44HdKkx+sRnjc8rv/AoPrscuZTEMCZV9ipC9oriFtfZfX3pf9SkHDqvQ5+p/pnkdNYaBgtP8
 0+F2KiBtpNpsfU/ni/MZXSD+U34i8u+1lCaAHEqBqWOfeQCWCF7DEPoVKH0Ld6eyifPVeg5ob
 HHYrXvr14O0NLIvb1kpuANya5vBbZSSh6fLTZnrla/HRklh4pd8MHr7N2VQRAqsQ0ESi2hdpw
 tq0VddBPplFU+btgwsIvLPD/QGyGAmsx/662OAdkFOtFuHlaMdBDuwOa4hqvLVav9S79HHWwH
 mb9qiEOLupjzLj3XdhvBosBN/0p2E+EEwTq6T2QdF21vc+8/7k65g2PTYKYsBomf7Qsim1Dkm
 jF0ohOKi9W3V85useP9x29eFMj1auDgAMaBFdNdS6wJxu0dL6mXl/O6+gNlM2VMV1HmgEDBqj
 Oj8/U/4gO/ocksNNQFoh9fSUBv7pjGrdzE4UluywKEj0lqf0H9jBzkwZPsee2ngYMV3tWI6dC
 EqWMhUm/pavTg1hJI17iQBrhAkxePjl6gcsuZq2AGQwJcrIFxMLFohTCI+AeGOwnikHazPZfe
 dS7yzzzRy2de4swFSCgRqzzLR2kzsiu9HBot06O1r1WNqpU1NQHT8svh/zFkYlAwgiPpE0OLl
 wggdesylJg7GZiEKMgXdmxnTF4OFNj0y/SFOfn6GJynUrICHqQ4Pa0yj69TgBi6TXNre6Y0mw
 okDPjTX
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Hi Peff,

On Sat, 5 May 2018, Jeff King wrote:

> On Fri, May 04, 2018 at 05:34:58PM +0200, Johannes Schindelin wrote:
> 
> > For every regular color, there exists the inverted equivalent where
> > background and foreground colors are exchanged.
> > 
> > We will use this in the next commit to allow inverting *just* the +/-
> > signs in a diff.
> 
> There's a "reverse" attribute (which we already parse and support) that
> can do this without having to repeat the colors. AFAIK it's well
> supported everywhere, but I could be wrong.

How would I use that here, though? I need to get the thing via
diff_get_color_opt() which takes a parameter of type `enum color_diff`.
There is no way I can specify `reverse` here, can I?

> I wonder if that would make configuring this slightly more pleasant,
> since it saves the user having to define "oldinv" whenever they change
> "old".

I am all for making the configuration more pleasant. So I hope I can make
use of the `reverse` thing here, without having to introduce a new enum
value.

Ciao,
Dscho
