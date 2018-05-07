Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-3.7 required=3.0 tests=BAYES_00,
	FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,RCVD_IN_DNSWL_HI shortcircuit=no autolearn=ham
	autolearn_force=no version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 2321A200B9
	for <e@80x24.org>; Mon,  7 May 2018 01:21:16 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1751901AbeEGBVO (ORCPT <rfc822;e@80x24.org>);
        Sun, 6 May 2018 21:21:14 -0400
Received: from mout.gmx.net ([212.227.15.18]:36605 "EHLO mout.gmx.net"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1751874AbeEGBVM (ORCPT <rfc822;git@vger.kernel.org>);
        Sun, 6 May 2018 21:21:12 -0400
Received: from [10.40.94.26] ([209.226.201.248]) by mail.gmx.com (mrgmx001
 [212.227.17.190]) with ESMTPSA (Nemesis) id 0Ld0fQ-1eXKJK1GUa-00iBYl; Mon, 07
 May 2018 03:20:55 +0200
Date:   Sun, 6 May 2018 21:20:46 -0400 (DST)
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
In-Reply-To: <20180506064104.GB3418@sigill.intra.peff.net>
Message-ID: <nycvar.QRO.7.76.6.1805062119051.77@tvgsbejvaqbjf.bet>
References: <cover.1525361419.git.johannes.schindelin@gmx.de> <cover.1525448066.git.johannes.schindelin@gmx.de> <1ebbe359547689d32aa27564929d733a26bb8054.1525448066.git.johannes.schindelin@gmx.de> <20180505182922.GD17700@sigill.intra.peff.net>
 <nycvar.QRO.7.76.6.1805060001230.77@tvgsbejvaqbjf.bet> <20180506063543.GA3418@sigill.intra.peff.net> <20180506064104.GB3418@sigill.intra.peff.net>
User-Agent: Alpine 2.21.1 (DEB 209 2017-03-23)
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
X-Provags-ID: V03:K1:Tqmsn6pLjNSFaDN2JKEEwppHI7Z1T7pH+nmZZnTKjiLMGTUOIIh
 DqBEs/M6tkp+ILEcuqPw6Wwgke5cQcyrfgFv+vIBgtX3nYCyPMyUIf1pWQdMH+GEKki7VZT
 5ZVqRUXPq0Z7PZBROWc0uOiA75MIvSVS8zXj/+vo5L9V46ST3+L9dc7kVe43wqW5eSBC0U7
 aK5E2WkTnueUrEJPGpyOQ==
X-UI-Out-Filterresults: notjunk:1;V01:K0:ytkwGL423EA=:cRurjTaRc5lXOwyQH5XeQz
 P3fjF3gO4LQYJMbapPbecErcoLHkt8+tUOtSyFIO1u1O3DOoXynC44B7V0EvI8BORQWqV763d
 mRONXeNNvtmIHpjoauLzI8tKsoIN1IBaeJZ7oBadCKGcjGZf+LC8WJA2MSqlhPGkk5vIaWcje
 mDjIGW47Ud5lpL0Gi51G/EraQCLbLhEOK4bBbd94TxadPgoZ348P8Uu2CfGHESct7LOuP+RxW
 FQ4gpnEvk3Jg1LNasrZlMZIwEnBL5Wa3tOUyxqYO6AMEOWC9YJzKji5r0eCyvgPovnW90yhac
 5lREgAecWd1Fqz5afPnzT6Q3xScypBNgy/mSGlJLJZDrDuTepYnOP0zpui/kN1hAU8mzI5e7+
 RYKN+eTUpOaY8+39Z7jayW19JKUtGt+CCDisbOlQu6rIFV6ooLp5titGTOUVkXHJoXX4hM+yj
 AMjWBeraorU+Y6fNLeZ/4Rt3uwMbGdlL2A1KtcXOCb/3cekMApiL+PXj2PscTJdTBKA9jW0vt
 emWF0Gyj6z6YaeKLy2S1VHRRdUroRuSuKXNByjG6E0gSE9WoowCK25adXnX9sqVIh7u0z6+R5
 bEAnHYCmOen1fRZ5ppmb0r4v1mnjAuKZcd8Vj1BbY7DGc/V1N72L6OV2i0SubmVWwu11qd8hi
 RnWhHpE4jMQOfD6EUpI0jrn5JuVTVix5AbRwqwL9XPpqpK2asNo1XdcPqksiY7tZuMYsp1hsa
 WDg0b1Cv8NC9D01cjT0na+MuGwQcB0JJoHIDOlZhFFDCmISewFG5/zn6ZH8SnkX8v96ffrIE2
 uvSy8MQ
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Hi Peff,

On Sun, 6 May 2018, Jeff King wrote:

> On Sun, May 06, 2018 at 02:35:44AM -0400, Jeff King wrote:
> 
> > You'd have to introduce GIT_COLOR_REVERSE. I don't think we have a
> > constant for it yet, but it's \x[7m.
> 
> Heh, of course you knew that already, as I just noticed your patch is
> using the reverse attribute internally (I had thought at first glance
> you were just specifying the background independently).
> 
> So really, I guess all I am arguing for is having GIT_COLOR_INV (or
> REVERSE) as a constant, and then teaching the code to combine it with
> the existing "new" color. It's perfectly OK to have:
> 
>   \x1b[7m\x1b[36m
> 
> instead of:
> 
>   \x1b[7;36m
> 
> It's two extra bytes, but I doubt anybody cares.

Yep, I agree that it is a small price to pay for the benefit of simply
using the reverse of diff.color.old (and .new).

While at it, I also changed the hunk header colors: they are *also* simply
the same ones, with the outer one having background and foreground
reversed.

Ciao,
Dscho
