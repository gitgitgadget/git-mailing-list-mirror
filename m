Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.2 (2018-09-13) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-3.1 required=3.0 tests=AWL,BAYES_00,
	FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,MALFORMED_FREEMAIL,RCVD_IN_DNSWL_HI shortcircuit=no
	autolearn=ham autolearn_force=no version=3.4.2
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id AC151202BB
	for <e@80x24.org>; Fri, 15 Mar 2019 15:51:45 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727866AbfCOPvo (ORCPT <rfc822;e@80x24.org>);
        Fri, 15 Mar 2019 11:51:44 -0400
Received: from mout.gmx.net ([212.227.15.19]:33195 "EHLO mout.gmx.net"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726792AbfCOPvo (ORCPT <rfc822;git@vger.kernel.org>);
        Fri, 15 Mar 2019 11:51:44 -0400
Received: from [192.168.0.129] ([37.201.192.41]) by mail.gmx.com (mrgmx002
 [212.227.17.190]) with ESMTPSA (Nemesis) id 0M5cMq-1gpEBJ2dcO-00xZVZ; Fri, 15
 Mar 2019 16:51:33 +0100
Date:   Fri, 15 Mar 2019 16:51:17 +0100 (STD)
From:   Johannes Schindelin <Johannes.Schindelin@gmx.de>
X-X-Sender: virtualbox@gitforwindows.org
To:     =?UTF-8?Q?=C3=86var_Arnfj=C3=B6r=C3=B0_Bjarmason?= 
        <avarab@gmail.com>
cc:     Duy Nguyen <pclouds@gmail.com>,
        Git Mailing List <git@vger.kernel.org>,
        Junio C Hamano <gitster@pobox.com>,
        Jeff King <peff@peff.net>,
        Michael Haggerty <mhagger@alum.mit.edu>,
        Stefan Beller <stefanbeller@gmail.com>,
        Jonathan Nieder <jrnieder@gmail.com>
Subject: Re: [PATCH v2 6/7] gc: don't run "reflog expire" when keeping
 reflogs
In-Reply-To: <877ed0bfl9.fsf@evledraar.gmail.com>
Message-ID: <nycvar.QRO.7.76.6.1903151650500.41@tvgsbejvaqbjf.bet>
References: <20190313235439.30439-1-avarab@gmail.com> <20190314123439.4347-7-avarab@gmail.com> <CACsJy8B=76dMKhvdzOyyOMK5o-s8t+77ZE-hBmezhxLdv7E9dQ@mail.gmail.com> <877ed0bfl9.fsf@evledraar.gmail.com>
User-Agent: Alpine 2.21.1 (DEB 209 2017-03-23)
MIME-Version: 1.0
Content-Type: multipart/mixed; boundary="8323328-2753841-1552665093=:41"
X-Provags-ID: V03:K1:31LjIgzpsdmxxoSHWPdTBKc8v8lxWN/2cYuWCKn69al8Ze0tCZl
 U3ehGhcO0HsASzu5NV/AC6B6q++qNUdBoW2Xq302/RfTmZlZ3UGimKeS/fQXTfDKFCYvMho
 Ew5St5wyGnrX6tGrwYK983E/aPFvRa5RojBWJ0bPvTB1y2yuHFOrYWR/V9Qts/g+JxSznra
 7y34mLB9xnRb7TpUomvgg==
X-UI-Out-Filterresults: notjunk:1;V03:K0:vInrKIu31Dw=:+Hu4pfcPeCVtAGB80mdXDZ
 apJmGOc4jYD6ZSoEfkf/peh1daJYpO6zJzvFnXRqTmD9e4GcJZArE2e9UACRCIdcLQnBcmjpr
 DmVCcBtqPZE8QyJ+bWCi8P3kHlLUjJhmJKhfxnYzj5V5YjtqctFD64qE6Ao+vB+Acz4aSM6oJ
 KmbquOvu8vYyL8urD6S7194UsiitdNYH9Jeyc4seD8hqzVLeAzWASWH+gHkzhLzzoy+4sCXkj
 OsBABt/dGLXXb9Y8hEPvfzRUsCtx6BeKSqPy1KzdJtnioJbcYqX6iTSZ7Oduz/NhNw/kOex4b
 vlxD9FZt3PaKwfpP+cGjDwhcZjn/x0d3rPoS1ieJmg+LEBdWsi9NzZIl/qk5LKDU57yazpwnf
 y1cFghYCLq45k40XI3Uoo0tVM1N+vKhc9skyenF03mbSmPpYgy428D4FOpgBnmdvbL7w+Y56t
 VEKj/otg7PS20acft4qV8KhcJaX+NicyUEOGdD3aDdBFTqNfTygs75HUSFfomFoO8jU80pyge
 o8N6Q4OX/KpuMmKFPvh87HlQ53l1WauMwCQyxd8Ni3/T8Bsl6Lu5gipoIeLgkYk4zYQPmdO6+
 9WgXO5aJK1BlH6tAckcGwh2Z8WKUibaTZgRkYa5E4Er/H/YL7/iOwMHdXIc2WhzLOqADeRyFd
 Bi1ZIbi+DAMCem6X2DOgnUFJV4vhjmr/17i6szjnGy0TWKaRHJnj11mgtGsm2uyg+kQq6Rgy2
 p4Qx63gJQ/5R6EBJm9fYueO3Lp0w3vWGCRzy6loNrY7JP4hSAwHrh3muy3uk5K1ljEACTv5yh
 q8nGv5kJevJIDR4XYgi3UNeG/RQyQPJi7hUU990uKMkRAiX2vqJG8UIwZiXa6oqPeLlm2igMK
 TItZdtjnmVI/th55DsleCJQo84kv4m6O77Kp/Jarr3Y2cty/z8NN9L38b5T7bFhkoABwVM/b4
 y578LFpBQT3my3qBD4dKccMTKouNZHL4=
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

  This message is in MIME format.  The first part should be readable text,
  while the remaining parts are likely unreadable without MIME-aware tools.

--8323328-2753841-1552665093=:41
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8BIT

Hi Ævar,

On Fri, 15 Mar 2019, Ævar Arnfjörð Bjarmason wrote:

> 
> On Fri, Mar 15 2019, Duy Nguyen wrote:
> 
> > On Thu, Mar 14, 2019 at 7:35 PM Ævar Arnfjörð Bjarmason
> > <avarab@gmail.com> wrote:
> >> @@ -127,6 +140,10 @@ static void gc_config(void)
> >>                         pack_refs = git_config_bool("gc.packrefs", value);
> >>         }
> >>
> >> +       if (gc_config_is_timestamp_never("gc.reflogexpire") &&
> >> +           gc_config_is_timestamp_never("gc.reflogexpireunreachable"))
> >
> > Nit. configset api normalizes the key internally, so we can safely
> > write gc.reflogExpireUnreachable here, which is a bit easier to read.
> 
> I didn't know that, do we want to do that?
> 
> I'd think that as a matter of coding style always sticking to lower case
> in the C code made more sense, because e.g. you might #define a config
> key, and then use it both in git_config_*() as well as via strcmp() in
> some callback. Mixing the two would lead to confusion and possible bugs
> as we'd refactor the former of those patterns to the latter.

It also saves on developer and reviewer time to stick to lower case.

Ciao,
Dscho
--8323328-2753841-1552665093=:41--
