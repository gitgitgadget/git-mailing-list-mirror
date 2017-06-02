Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-3.9 required=3.0 tests=AWL,BAYES_00,
	FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,HEADER_FROM_DIFFERENT_DOMAINS,
	RCVD_IN_DNSWL_HI,RP_MATCHES_RCVD shortcircuit=no autolearn=ham
	autolearn_force=no version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 673762027C
	for <e@80x24.org>; Fri,  2 Jun 2017 17:26:20 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1751220AbdFBR0N (ORCPT <rfc822;e@80x24.org>);
        Fri, 2 Jun 2017 13:26:13 -0400
Received: from mout.web.de ([212.227.17.11]:65476 "EHLO mout.web.de"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1751141AbdFBR0L (ORCPT <rfc822;git@vger.kernel.org>);
        Fri, 2 Jun 2017 13:26:11 -0400
Received: from [192.168.178.36] ([79.237.60.227]) by smtp.web.de (mrweb101
 [213.165.67.124]) with ESMTPSA (Nemesis) id 0MVLj0-1dPADE1yVK-00YkvA; Fri, 02
 Jun 2017 19:25:46 +0200
Subject: Re: git-2.13.0: log --date=format:%z not working
To:     Jeff King <peff@peff.net>, Junio C Hamano <gitster@pobox.com>
Cc:     =?UTF-8?B?w4Z2YXIgQXJuZmrDtnLDsCBCamFybWFzb24=?= <avarab@gmail.com>,
        Ulrich Mueller <ulm@gentoo.org>,
        Git Mailing List <git@vger.kernel.org>
References: <22824.29946.305300.380299@a1i15.kph.uni-mainz.de>
 <CACBZZX6t0Q9AJ4cpnG298tf5Las-YpmvvJXgLNNYMszikLvtMQ@mail.gmail.com>
 <20170527214611.suohggo226tvmbgt@sigill.intra.peff.net>
 <0a56f99e-aaa4-17ea-245a-12897ba08dbb@web.de>
 <xmqq1sr3161p.fsf@gitster.mtv.corp.google.com>
 <20170602030825.hdpbaisn54d4fi4n@sigill.intra.peff.net>
From:   =?UTF-8?Q?Ren=c3=a9_Scharfe?= <l.s.r@web.de>
Message-ID: <72b001fc-80e7-42b9-bd9d-87621da7978a@web.de>
Date:   Fri, 2 Jun 2017 19:25:43 +0200
User-Agent: Mozilla/5.0 (Windows NT 10.0; WOW64; rv:52.0) Gecko/20100101
 Thunderbird/52.1.1
MIME-Version: 1.0
In-Reply-To: <20170602030825.hdpbaisn54d4fi4n@sigill.intra.peff.net>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Language: en-US
Content-Transfer-Encoding: 8bit
X-Provags-ID: V03:K0:AHM1F333aBP1TAjrmt9q0Cqa/H2IgrbSQ6MFh+hAEM1CS+zBhQ+
 c1nuVDE4F99MUb2kc7KcMP3BDlzcx4PHqcljBBx1NWBFmonQNH0RY0zNQrmHsOzYiMjEb0I
 37wscecmXFeceHXr0fsmVS6kN4WMjKzPxRkYkqVM/h+ZOI4e4WgRtNpytZKOAiIif8LMY4z
 bNp24pMTCiu0oHE+OLM3Q==
X-UI-Out-Filterresults: notjunk:1;V01:K0:xSYWfQ8kZ9I=:buEfob8dBVaQWUAuBp/4L0
 gJaIAWowyPsF4MMC9mBORuB1Ue2dqChNOmrgs9pJKoWr+qzIFx7zKgHs1cpy1MdLESNbqxpde
 nSVhX5HJQJAXn6t4adKdq0bLCmwA/Us9IpEaP5VrjFAkIUP4vfNobJNgW8OC5BUBwuyI1BCeW
 RX7pzunm3Irh3Y7qDdQ+6knWSLWbu1e2dWb2gs6Oun81O4K0MiqvaMkzn1CYHxh2ptHIp1R9D
 YGeEPM1lHpAuD8K1v0EexBb14XJfHvQSXSEgsMHWdf95jpzKihscWT0r/7ewbRTPzjonOgG45
 g3IQRsrxMnCyZKJuv7bbyRcOPqBlBJ9otIAc3FDxz7Fxd2NzMvjJjOY+cDFU8V3DZExVEERuJ
 g524DBNjbh6bIZArdH68bK2kskMduBt2YbkHZYBVyHedJfcBEBJNGWM1rLlBQ9y0BytSqNZuL
 eHYoVQD8FzIkjVxx0dIgql+dEZpDxpWMnvzAiIxS6cqCuzrEhKwGPaM+YRCePC1AfwT+S+wxg
 ZzgbXX5GFxFgigz0LYf6QqO7PlnsWN1Jij3D/zpW5Bqh51EjU0FXT/yHwumg0BvY+nGrd1khX
 f41lC+YaMQAzH75EE8jtMQIpq47wC7bFG/wBTBuQud6bCMr0T0dTiSy7wJktjb5KCfjND3fFr
 UVTuxgnjoxce5nBl6nm4+UJsDOMdwABDe2Mts7NN2jIn30OzZlrfhdm92EmBWrVsoX5hkRHBR
 nsTD06Eqf5hQlP3JBdvWmBCa4YJ8i/pOSkMCZG0ZukjXnoO/nwrpZO0dASzUodmONbRpwqzJj
 X3koyHc
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Am 02.06.2017 um 05:08 schrieb Jeff King:
> In theory the solution is:
> 
>    1. Start using localtime() instead of gmtime() with an adjustment when
>       we are converting to the local timezone (i.e., format-local). We
>       should be able to do this portably.
> 
>       This is easy to do, and it's better than handling %z ourselves,
>       because it makes %Z work, too.
> 
>    2. When showing the author's timezone, do some trickery to set the
>       program's timezone, then use localtime(), then restore the program
>       timezone.
> 
>       I couldn't get this to work reliably. And anyway, we'd still have
>       nothing to put in %Z since we don't have a timezone name at all in
>       the git objects. We just have "+0400" or whatever.
> 
> So I don't see a portable way to make (2) work.

We could create a strftime wrapper that also takes a time zone offset,
with platform-specific implementations.  Is it worth the effort?

What reliability issues did you run into?

> But it seems a shame
> that %Z does not work for case (1) with René's patch.
> 
> I guess we could do (1) for the local cases and then handle "%z"
> ourselves otherwise. That sounds even _more_ confusing, but it at least
> gets the most cases right.
> 
> If we do handle "%z" ourselves (either always or for just the one case),
> what should the matching %Z say? Right now (and I think with René's
> patch) it says GMT, which is actively misleading. We should probably
> replace it with the same text as "%z". That's not quite what the user
> wanted, but at least it's accurate.

On Linux "%z %Z" is expanded to "+0200 CEST" for me, while on Windows I
get "Mitteleurop▒ische Sommerzeit Mitteleurop▒ische Sommerzeit".  (That
"▒" is probably supposed to be an "ä".)  POSIX requires  +hhmm or -hhmm
format for %z, and for %Z is to be "Replaced by the timezone name or
abbreviation".

I'd say "GMT+0200" etc. is a nice enough timezone name, i.e. having %Z
resolve to the same as %z plus a literal prefix of "GMT" should at least
not be wrong.

Alternatively we could have a lookup table mapping a few typical offsets
to timezone names, but e.g. handling daylight saving times would
probably be too hard (when did that part of the world switch in the
given year?  north or south of the equator?)..

> As far as the patch itself goes, I'm disappointed to lose the automatic
> "%" handling for all of the other callers. But I suspect the boilerplate
> involved in any solution that lets callers choose whether or not to use
> it would end up being longer than just handling it in each caller.

Actually I felt uneasy when you added that forced %% handling because it
put a policy into an otherwise neutral interpreter function.  I just had
no practical argument against it -- until now.

I'd rather see strbuf_expand also lose the hard-coded percent sign, but
again I don't have an actual user for such a flexibility (yet).

Perhaps we should add a fully neutral strbuf_expand_core (or whatever),
make strbuf_expand a wrapper with hard-coded % and %% handling and use
the core function in the strftime wrapper.  Except that the function is
not easily stackable.  Hmm..

René
