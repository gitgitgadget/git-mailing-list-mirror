Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-2.0 required=3.0 tests=AWL,BAYES_00,
	FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,HEADER_FROM_DIFFERENT_DOMAINS,
	RCVD_IN_DNSWL_HI,RCVD_IN_SORBS_WEB,RP_MATCHES_RCVD shortcircuit=no
	autolearn=no autolearn_force=no version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 6DEC91F667
	for <e@80x24.org>; Wed, 16 Aug 2017 12:19:08 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1751756AbdHPMTG (ORCPT <rfc822;e@80x24.org>);
        Wed, 16 Aug 2017 08:19:06 -0400
Received: from mout.gmx.net ([212.227.15.15]:62916 "EHLO mout.gmx.net"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1751592AbdHPMTF (ORCPT <rfc822;git@vger.kernel.org>);
        Wed, 16 Aug 2017 08:19:05 -0400
Received: from virtualbox ([37.201.192.198]) by mail.gmx.com (mrgmx001
 [212.227.17.190]) with ESMTPSA (Nemesis) id 0LkfdE-1d7neW2UPE-00aT21; Wed, 16
 Aug 2017 14:18:48 +0200
Date:   Wed, 16 Aug 2017 14:18:46 +0200 (CEST)
From:   Johannes Schindelin <Johannes.Schindelin@gmx.de>
X-X-Sender: virtualbox@virtualbox
To:     Jeff King <peff@peff.net>
cc:     Brandon Williams <bmwill@google.com>, git@vger.kernel.org,
        sbeller@google.com, gitster@pobox.com, jrnieder@gmail.com,
        ramsay@ramsayjones.plus.com, peartben@gmail.com, avarab@gmail.com
Subject: Re: [PATCH v2 1/2] clang-format: outline the git project's coding
 style
In-Reply-To: <20170814230108.wucznh66vfblrsys@sigill.intra.peff.net>
Message-ID: <alpine.DEB.2.21.1.1708161414120.19382@virtualbox>
References: <20170808012554.186051-1-bmwill@google.com> <20170814213046.107576-1-bmwill@google.com> <20170814213046.107576-2-bmwill@google.com> <20170814224831.qhs7b44bg7v7tryx@sigill.intra.peff.net> <20170814225108.qoq6noojqznp4be6@sigill.intra.peff.net>
 <20170814225430.GB95777@google.com> <20170814230108.wucznh66vfblrsys@sigill.intra.peff.net>
User-Agent: Alpine 2.21.1 (DEB 209 2017-03-23)
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
X-Provags-ID: V03:K0:xCxHL5roUfQzkgzTBx1LZ57lH/L99L+NsGWuBlbUBtOct26eIxp
 6QeVAEQF0z4AZSKF3wAoJNoFwFTRdfWjT3BRYKQGpfZMLBLtJiFInfSvi02jGjcHy6Lymy5
 fSQOTvaYDWyD7NRwWQuibhCBxuPaLesRwoSQEMLKgw3+iVf4e6QtFaBykYIUqXAI0sluR/j
 /5d5+eZA1bmqD7TKqBgWQ==
X-UI-Out-Filterresults: notjunk:1;V01:K0:lqjEneTJb8g=:7ZYOQgydBCuQdnLvhJfk6v
 1asUaqxVDEqpV5AzhSxrBB84lyXg0igwuScBBoZ/BWcE9mJ+CgRa/Vi54+gZMBtD7PJ5VdW2g
 onjSJ04Yw0LbrElJGljQLbBxPL09zcqi1pw+X8auUg3QAP2Ttwo0+Yp0xhkxf0td1jEPwzyPx
 25vbWGfGHTk3t6zuB3ATe+OBfGZLvyhU9FxZVOZAtO2VdaFzzzuZudNwtfoKqJP/ckzdze1xT
 GwAcSsTcYN0t/5hZmAnJsIMhj8z7WsQJ+DEXuqoJgdNpgJ6wB8WH4Gt4DOdh4sq/SS5SiqMeC
 lcAG1xwZ8D8kjcRxRdEkq1ziN58+fqRryx5cZptUBggTYs1iZI7OBKBjDJ7qzOYtjGXR951Km
 Fw+HsjIGO5kRyu9Oln8lbULAE25hxbbT7qTb/hk9r82NUVk44usUv6mwrtAxixdoKfhi1/6js
 nWpJFXtFOtyo26HN4AL71x7s9MjAbsiYVBf5B+AVA1ag9CtFp3Gc3FCAVVyf4cIezRgqp7+qv
 kHiA1NbfXN+i/0BHl732iHL0Z0mekhokXKcOvOxxan7alDDChwhERC0p7o8B+vxrkKuSPyqib
 GRWvvEOEyWYkf0XjGaxlLNgxOSeRKTir99Vaa4nhNRT5+tEf96b3wUGZANvAlIgBA+Hh9ki+1
 6EBnvP/TEoNA3BoIZIeiQnh4ccV/zXdzZS9frhRV+R6oq87C4Y2EkErD2oFjj8+048khQzrX7
 dZw2h47T/jGiwMeroKsNSTgsGj3oyx+I96VoXfSDH1F2Isj/VsPuZz8ie3arjkR/V5KuKVwKb
 wx1A/OBJF5oyKfgSilxh9heS3Rk8/q7YJkW0n3k0mVXkqtLUGc=
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Hi Peff,

On Mon, 14 Aug 2017, Jeff King wrote:

> On Mon, Aug 14, 2017 at 03:54:30PM -0700, Brandon Williams wrote:
> 
> > > And removing that gives me a clean output. I have no idea why my clang
> > > doesn't like these (but presumably yours does). It's clang-format-5.0 in
> > > Debian unstable (and clang-format-3.8, etc).
> > 
> > Those must be features in version 6 (which is what I seem to have
> > installed on my machine).
> 
> OK, that makes sense. The most recent one package for Debian unstable is
> 5.0. AFAICT 5.0 is actually in release freeze for another week or two,
> and 6 is just bleeding-edge that moved on after the release freeze a few
> weeks ago.
> 
> I'm not sure which version it makes sense to target as a minimum, but
> probably not 6 yet. :)

I agree.

There is most likely a middle path between too old and too new, and with
the current pace of the review 5.0 will probably be good enough by the
time this patch series can possibly hit `master`. So I'd guess 5.0 would
be a good version to aim for.

Besides, it may not matter *all* that much which version we target: As I
mentioned elsewhere, the contributor experience would most likely be
vastly improved if this was a bot, say, monitoring GitHub Pull Requests.
It could use filter-branch to apply clang-format to each commit's diff and
report back to the Pull Request either by saying that the style is okay,
or by linking to another repository where the fixed commits live (combined
with instructions how to update the local branch).

Ciao,
Dscho
