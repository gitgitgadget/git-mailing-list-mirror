Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.1 (2015-04-28) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-3.5 required=3.0 tests=AWL,BAYES_00,
	FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,RCVD_IN_DNSWL_HI shortcircuit=no autolearn=ham
	autolearn_force=no version=3.4.1
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 3F2FD1F404
	for <e@80x24.org>; Fri, 10 Aug 2018 22:01:05 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726998AbeHKAcq (ORCPT <rfc822;e@80x24.org>);
        Fri, 10 Aug 2018 20:32:46 -0400
Received: from mout.gmx.net ([212.227.17.20]:38345 "EHLO mout.gmx.net"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726708AbeHKAcq (ORCPT <rfc822;git@vger.kernel.org>);
        Fri, 10 Aug 2018 20:32:46 -0400
Received: from [192.168.0.129] ([37.201.193.145]) by mail.gmx.com (mrgmx103
 [212.227.17.168]) with ESMTPSA (Nemesis) id 0M8MyE-1g9v2o3DVq-00vuoK; Sat, 11
 Aug 2018 00:00:56 +0200
Date:   Sat, 11 Aug 2018 00:00:58 +0200 (DST)
From:   Johannes Schindelin <Johannes.Schindelin@gmx.de>
X-X-Sender: virtualbox@gitforwindows.org
To:     Junio C Hamano <gitster@pobox.com>
cc:     Stefan Beller <sbeller@google.com>, gitgitgadget@gmail.com,
        git <git@vger.kernel.org>
Subject: Re: [PATCH v4 00/21] Add `range-diff`, a `tbdiff` lookalike
In-Reply-To: <xmqqlg9d7vsy.fsf@gitster-ct.c.googlers.com>
Message-ID: <nycvar.QRO.7.76.6.1808110000260.71@tvgsbejvaqbjf.bet>
References: <pull.1.v3.git.gitgitgadget@gmail.com> <pull.1.v4.git.gitgitgadget@gmail.com> <CAGZ79kb4ki0cXLnJHeqzRvWaGWki1_epWOdCy49s_v9cy_tJ2A@mail.gmail.com> <nycvar.QRO.7.76.6.1808081422160.71@tvgsbejvaqbjf.bet> <CAGZ79kbj2sgKOmouvLDuXic3vq9RG1LZ_retOqMwX_YZtMP+1Q@mail.gmail.com>
 <nycvar.QRO.7.76.6.1808102313070.71@tvgsbejvaqbjf.bet> <xmqqlg9d7vsy.fsf@gitster-ct.c.googlers.com>
User-Agent: Alpine 2.21.1 (DEB 209 2017-03-23)
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
X-Provags-ID: V03:K1:zS44vdQ9r/Dz9dR8U6FoHqzAwPk5d+wQDh2oxPKeenF950Jm9Rm
 HNQiDdY/BJyxWONrhvyatq+LGDe3KGUzaeBOu/+D9+AnVhd4YDHT/FA0vONIfI0Zq7vnnMg
 z0iqhHUI/fUJbYThUlLLzavDE97Xh35kxes5zC1KG7ifykbXVd5e4TU57PtX6DaMuzc7od9
 bMK4Qlm9UhH7yYMHf4WqQ==
X-UI-Out-Filterresults: notjunk:1;V01:K0:urEBHdx0qe8=:AOwYalFP/eWo2ntMnaFWPk
 XnojkLkzI5bnOAkUlVx6MjLC2hId1C2OKv6FovMOTwgZcYOPzcySarq3usTudat5fVOvIPnXe
 lgPM4oO2SSgnFuAmAmTl4SaGmU77X1t2oYYKkcscSs7cILjiMIwKOMLn1eTfV3a7sDRlrF5gP
 Oam5ngeRm1QFHy/8cT95uuYoRxApmNLNDD9Bq9M0UMygl34Ukdj2jCciJCuQXa2Xz6vdHA9c4
 ohzyHxcq/QLkJy8IEar2bttvIN5X39zmIfZkEqa2+5aS5Q3WJwPBbJo4kMaEX1R4VImP8p0sx
 TCZ60mQweq6Asm9gdnhVJh4EwABMPzS2VWZ0R7Y30Aa7l/ZEOnvomK5+t4wdgkh08Aoo0Uufi
 EH+TOVGQoPHlHyoGsE0exyNdpwN8qdb9VeR6/QFYJlCkHA6z0X//cFrbISN3EhRBoo/XktSxW
 gQtoQYnRk8rQzFG96bET6Cxm+7A8Tn4Gdhf0X7tdlM6JmVhZE9ZLw9b2cV4CRA63JMAhkeaJM
 G1VecE9IKGVFxWxES39sLWcIX1oQ6OpK/94b56IP+kyCF4BzhA1r6EUhUQYZm36OpNFN9BjiF
 1eA8r+HIK3cjXGqmCJUQufr+Gc1qm9FwgVK7EIDpP3LQD0XUBTjev3Wy2bXTfx9MjCZZ8uk/C
 4XXhFOxTP8qJhjJCOFoK8chTlOQc6hrNPFkKQWH7VYZRPtzVUKifRksMVpk9XZz5pH1kO/iP6
 ARTq8+1seGSa54uVv76gS4LFqmBqGFZSQnE3Sfpijo7WKtywxiQHVv3E1ZaFHTl/MGvrXiwOc
 upihDFZ
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Hi Junio,

On Fri, 10 Aug 2018, Junio C Hamano wrote:

> Johannes Schindelin <Johannes.Schindelin@gmx.de> writes:
> 
> > I'll just try to get that option parsing change in that Eric suggested,
> > force-push, then wait for macOS and Linux builds to pass (trusting that
> > Windows will follow suite) and hit /submit.
> 
> OK.  Obviously receiving, applying and inspecting that result will
> not be done in time for today's integration cycle, but having a
> version that limits its cope and is suitable for 'next' is a good
> thing to have at this point during the cycle.  Correct whitespace
> error colouring, etc., can be done on top after the basics settle,
> and the basics were good in a few versions ago already IIRC.

No, a couple of issues were identified, still, that merited several dozen
rebases on my side.

Ciao,
Dscho
