Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-3.2 required=3.0 tests=AWL,BAYES_00,
	FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,HEADER_FROM_DIFFERENT_DOMAINS,
	RCVD_IN_DNSWL_HI,RP_MATCHES_RCVD shortcircuit=no autolearn=ham
	autolearn_force=no version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 1551A202D7
	for <e@80x24.org>; Wed,  8 Mar 2017 16:28:06 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1754041AbdCHQ16 (ORCPT <rfc822;e@80x24.org>);
        Wed, 8 Mar 2017 11:27:58 -0500
Received: from mout.gmx.net ([212.227.17.22]:56442 "EHLO mout.gmx.net"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1754154AbdCHQ0W (ORCPT <rfc822;git@vger.kernel.org>);
        Wed, 8 Mar 2017 11:26:22 -0500
Received: from virtualbox ([37.201.192.247]) by mail.gmx.com (mrgmx102
 [212.227.17.168]) with ESMTPSA (Nemesis) id 0MFR2O-1czvVU370m-00EQe3; Wed, 08
 Mar 2017 17:18:48 +0100
Date:   Wed, 8 Mar 2017 17:18:46 +0100 (CET)
From:   Johannes Schindelin <Johannes.Schindelin@gmx.de>
X-X-Sender: virtualbox@virtualbox
To:     Jeff King <peff@peff.net>
cc:     git@vger.kernel.org, Junio C Hamano <gitster@pobox.com>,
        Duy Nguyen <pclouds@gmail.com>
Subject: Re: [PATCH v3 0/9] Fix the early config
In-Reply-To: <20170308073035.pt5ysp6bzpozoqps@sigill.intra.peff.net>
Message-ID: <alpine.DEB.2.20.1703081701100.3767@virtualbox>
References: <cover.1488506615.git.johannes.schindelin@gmx.de> <cover.1488562287.git.johannes.schindelin@gmx.de> <20170304073952.drfgy7jacnlm6tum@sigill.intra.peff.net> <alpine.DEB.2.20.1703071314180.3767@virtualbox>
 <20170308073035.pt5ysp6bzpozoqps@sigill.intra.peff.net>
User-Agent: Alpine 2.20 (DEB 67 2015-01-07)
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
X-Provags-ID: V03:K0:9BChIU/r3jWlVwZczvEmi1uYiSbx7XlFjnaaS8sBVkA266apkZO
 Y73CcndfEPnrTdHBaraYYPhyNqUjwunYeU3Qd38Q8VlkAaSVU8mNKgVK9XzLZuTm2QEV0Sn
 fIllwBbo61S8vKoX+NS3cm1L0gKnge1ApuiPZTBqvdO9r1Yv+s16svagH6/4+QSgGkGz7hV
 wICe0Aagxzcey/cBe4vtQ==
X-UI-Out-Filterresults: notjunk:1;V01:K0:pIEbC7S6Djc=:leM5HKMjzuoLvylslVR1Cl
 91m2fi7YrU8Kcg/CY8SHkIl4gCb1NLUPeeHH4cd30ZToFAINMxnI2ycH9K/Mpabm0cUcFDH0M
 Hb3iKLKY3omBMjH3zLdLH+irdMYJ/c/ifROqENYnWGc0Gu3UZf86Yc5R4ApX++chn/ODQl6bU
 YRcjwUIjGXW/cu597sanBcHHb+eFsbmhizSxckoS5fUh2Y2RGQiLweLiLDFylx0wrfcRGYYkz
 xaHeT0O9BV8MiYa8b1B9zzmWWFYPeayFvrbiu6lOlgMJ2Hi3frMzCifabarGI9tIJGKYcFaLc
 PW6s176FTnpAXyzxOKHEgfZp6hMNuQLXym10YMqhNj7kl6AQfnbp320J+ceV75W2uY914sP8b
 zSgmIQ95BgmlGuJEx2E6gF7sbEWioFMbIFsBCfykbDLl8Y8dRekZ4x97m9GdmwKqXo2iFptVW
 HOO3WvxMciUhy/V9lOZ8lQFVWLCjRqoW89YsVlFPPzgA+TAl/Gc0IKtCq7n6reH77cSfWqsdc
 JUiYO2/lxmqy/BdRJmdLE+quL/7RrEo12zq8n6Ye/uTtDeKH65xX6d39WnW++vCNA2Ruh8u3U
 4dU7KuAXDFSlupXp44Ww6lKyHZE1ZjysoGsOC2TNu5Qo/2Bh4yjQPfJtFBqIIdjoolCCOgEvs
 0Vll9wxW2WHEsg7Gr+VV4rsqCshIF6Pn3wECYCh215uDDuX11wSKAmuldvmIbW+GtYxDs3yMo
 FvUEMq/Ajfcxr8zvX5JzfT+Zde/vcD7V5CmhnxlI3Sk7ZAD99qU0QgJjOunpFxW6+UVh87Xpb
 G71sHm0
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Hi Peff,

On Wed, 8 Mar 2017, Jeff King wrote:

> Another "non-gentle" thing I noticed here while looking at
> another thread: the repository-format version check uses the config
> parser, which will die() in certain circumstances. [...]

Yes, that is part of the reason why I was not eager to add that check to
discover_git_directory(). The config code is die()-happy.

This is a much bigger problem, of course, and related to a constant gripe
of mine: I *always* get the quoting wrong in my aliases. Always. And when
I want to fix it, `git config -e` simply errors out because of an invalid
config. Yes, Git, I know, that is the exact reason why I want to edit the
config in the first place.

I am certain you will agree that this is a different topic, therefore
subject to a separate patch series.

In any case, I am fairly certain that the examples you showed demonstrate
that the config has to be rather broken for this patch series to have a
negative impact. And it still would report the broken config so that the
user is not blocked (she can fix the config and call the paginating
command again).

> On Tue, Mar 07, 2017 at 03:31:43PM +0100, Johannes Schindelin wrote:
> 
> > And another change: the GIT_DIR_NONE value was handled incorrectly in
> > discover_git_directory().
> 
> This is the "if (setup_git_directory_1() <= 0)" change from the
> interdiff? That's subtle.

Yes, it is subtle.

> The compiler could have noticed if we used a switch statement here. But
> then any new error conditions would have to be added to that switch
> statement.

We could still do that.

> > I am slightly disappointed that the these additional problems were not
> > spotted in any review but my own. And I had not even included a Duck.
> 
> Get used to being disappointed, I guess. A non-zero number of bugs will
> slip through when writing code _and_ when reviewing it.

I know that. I know that bugs are prone to come in through code
contributions. I don't go for 100%. But I would hope for a better rate
than we have right now: we pride ourselves in the OSS community to make bugs
shallow. I really would like to believe that we catch bugs rather than
discuss formatting (which should be automated) or white-space mangling
(which should not even be a problem if we were truly open for
contributions).

Maybe I am just a grumpy old guy. But I *hate* seeing how much buggy code
we get into Git, despite having a review process that does a very good job
of deterring seasoned developers from contributing.

I really wish it were different. I really wish that we did a better job at
catching bugs before they enter `master`. I really wish that I could be
proud of our code review process.

> > [ceil_offset]
> > Hopefully that clears up the picture?
> 
> Yes, it does. Thanks.

Perfect. Then the time I spent trying to figure all of this out was not
spent in vain.

Ciao,
Dscho
