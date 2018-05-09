Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-3.6 required=3.0 tests=AWL,BAYES_00,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,RCVD_IN_DNSWL_HI
	shortcircuit=no autolearn=ham autolearn_force=no version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id D11131F424
	for <e@80x24.org>; Wed,  9 May 2018 16:24:42 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S965448AbeEIQYk (ORCPT <rfc822;e@80x24.org>);
        Wed, 9 May 2018 12:24:40 -0400
Received: from avasout01.plus.net ([84.93.230.227]:50459 "EHLO
        avasout01.plus.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S965034AbeEIQYk (ORCPT <rfc822;git@vger.kernel.org>);
        Wed, 9 May 2018 12:24:40 -0400
Received: from [10.0.2.15] ([80.189.70.162])
        by smtp with ESMTPA
        id GRtMf5BwSQrTpGRtOfvpoH; Wed, 09 May 2018 17:24:38 +0100
X-CM-Score: 0.00
X-CNFS-Analysis: v=2.3 cv=ZIX5Z0zb c=1 sm=1 tr=0
 a=zzlqjQC3YyNvDZl/Gy+4mg==:117 a=zzlqjQC3YyNvDZl/Gy+4mg==:17
 a=IkcTkHD0fZMA:10 a=NEAV23lmAAAA:8 a=3L1EsLzu84tvToWsA4MA:9 a=QEXdDO2ut3YA:10
X-AUTH: ramsayjones@:2500
Subject: Re: [PATCH 02/18] Add a new builtin: branch-diff
To:     Johannes Schindelin <Johannes.Schindelin@gmx.de>
Cc:     git@vger.kernel.org, Junio C Hamano <gitster@pobox.com>,
        Thomas Rast <tr@thomasrast.ch>,
        Thomas Gummerer <t.gummerer@gmail.com>,
        =?UTF-8?B?w4Z2YXIgQXJuZmrDtnLDsCBCamFybWFzb24=?= <avarab@gmail.com>
References: <cover.1525361419.git.johannes.schindelin@gmx.de>
 <8bc517e35d4842f8d9d98f3b99adb9475d6db2d2.1525361419.git.johannes.schindelin@gmx.de>
 <71b00bbf-07e7-11e1-046b-f0241b82ebd3@ramsayjones.plus.com>
 <nycvar.QRO.7.76.6.1805032224150.77@tvgsbejvaqbjf.bet>
 <850f1ad6-752d-85ae-ebad-feae09a76c54@ramsayjones.plus.com>
 <nycvar.QRO.7.76.6.1805040829390.77@tvgsbejvaqbjf.bet>
 <019cce70-c109-496e-e043-c471dcb21e00@ramsayjones.plus.com>
 <nycvar.QRO.7.76.6.1805052130360.77@tvgsbejvaqbjf.bet>
From:   Ramsay Jones <ramsay@ramsayjones.plus.com>
Message-ID: <8876f376-db86-c3e1-b97d-9e33506f2df2@ramsayjones.plus.com>
Date:   Wed, 9 May 2018 17:24:36 +0100
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:52.0) Gecko/20100101
 Thunderbird/52.7.0
MIME-Version: 1.0
In-Reply-To: <nycvar.QRO.7.76.6.1805052130360.77@tvgsbejvaqbjf.bet>
Content-Type: text/plain; charset=utf-8
Content-Language: en-GB
Content-Transfer-Encoding: 7bit
X-CMAE-Envelope: MS4wfD3kBFno7aU2Ku/pygRlauavQpYrCLyYHKQD9jWWTaoZ206fCppJJtUxW5t4Fkb0VUPQEBVvWr4sLGEFXqMbD3cbJwxWnvM6yF/8K/9VpV9P4nR7kl3t
 DhdO9Um3SLCTIARe7jZR/szlAbLl3xMNQ9hWnec1pFl/Idv7A4ik9854
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org



On 05/05/18 20:41, Johannes Schindelin wrote:
[snip]

[Sorry for the late reply - still catching up after (long weekend)
UK public holiday]

> Well, what I would want to do is let the cloud work for me. By adding an
> automated build to my Visual Studio Team Services (VSTS) account, of
> course, as I have "cloud privilege" (i.e. I work in the organization
> providing the service, so I get to play with all of it for free).
> 
> So I really don't want to build sparse every time a new revision needs to
> be tested (whether that be from one of my branches, an internal PR for
> pre-review of patches to be sent to the mailing list, or maybe even `pu`
> or the personalized branches on https://github.com/gitster/git).
> 
> I really would need a ready-to-install sparse, preferably as light-weight
> as possible (by not requiring any dependencies outside what is available
> in VSTS' hosted Linux build agents.
> 
> Maybe there is a specific apt source for sparse?

Not that I'm aware of, sorry! :(

[release _source_ tar-balls are available, but that's not
what you are after, right?]

I don't know what is involved in setting up a 'ppa repo' for
Ubuntu, which I suspect is the kind of thing you want, but it
would have helped me several times in the past (so that I could
have something to point people to) ... ;-)

ATB,
Ramsay Jones

