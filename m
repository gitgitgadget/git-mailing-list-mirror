Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-3.7 required=3.0 tests=AWL,BAYES_00,
	FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,RCVD_IN_DNSWL_HI shortcircuit=no autolearn=ham
	autolearn_force=no version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 5B3D1200B9
	for <e@80x24.org>; Sun,  6 May 2018 12:23:52 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1751230AbeEFMXu (ORCPT <rfc822;e@80x24.org>);
        Sun, 6 May 2018 08:23:50 -0400
Received: from mout.gmx.net ([212.227.17.20]:60447 "EHLO mout.gmx.net"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1751187AbeEFMXt (ORCPT <rfc822;git@vger.kernel.org>);
        Sun, 6 May 2018 08:23:49 -0400
Received: from MININT-6BKU6QN ([81.92.17.130]) by mail.gmx.com (mrgmx102
 [212.227.17.168]) with ESMTPSA (Nemesis) id 0LyB6P-1eJ1Ym2Br3-015ZJ4; Sun, 06
 May 2018 14:23:41 +0200
Date:   Sun, 6 May 2018 14:23:44 +0200 (DST)
From:   Johannes Schindelin <Johannes.Schindelin@gmx.de>
X-X-Sender: virtualbox@gitforwindows.org
To:     Junio C Hamano <gitster@pobox.com>
cc:     git@vger.kernel.org, Thomas Rast <tr@thomasrast.ch>,
        Thomas Gummerer <t.gummerer@gmail.com>,
        =?UTF-8?Q?=C3=86var_Arnfj=C3=B6r=C3=B0_Bjarmason?= 
        <avarab@gmail.com>, Ramsay Jones <ramsay@ramsayjones.plus.com>,
        Stefan Beller <sbeller@google.com>,
        Jacob Keller <jacob.keller@gmail.com>,
        Eric Sunshine <sunshine@sunshineco.com>
Subject: Re: [PATCH v2 00/18] Add `branch-diff`, a `tbdiff` lookalike
In-Reply-To: <xmqqzi1dqrya.fsf@gitster-ct.c.googlers.com>
Message-ID: <nycvar.QRO.7.76.6.1805061423050.77@tvgsbejvaqbjf.bet>
References: <cover.1525361419.git.johannes.schindelin@gmx.de> <cover.1525448066.git.johannes.schindelin@gmx.de> <xmqqzi1dqrya.fsf@gitster-ct.c.googlers.com>
User-Agent: Alpine 2.21.1 (DEB 209 2017-03-23)
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
X-Provags-ID: V03:K1:5z6guzDyn+nJU4y2y1GOexaCb+9UbwLHWQd6XuoHyPVZYO1seiG
 0+DGbbDGndb7+QgM1IwDWEARBjL826f5RbFnYySzUFlVIzSBssaBbhwt2H8pcac8h62+iPc
 zeRASxRhoUiv/GdFrI7SdbjZo7j6c7KdVw4M1b9aY6Z8lJNdYOPa/EUm2ZhWajiBLb6mzFr
 bsKciaDhKClC/33dV2lSA==
X-UI-Out-Filterresults: notjunk:1;V01:K0:c7loFl2/E8U=:ZiHc7NsOtskntjTTft3LCV
 6bB9Xu/O3B8A8RJHjgXPIQJnM4HHfW1It/cNWxad3r/WeV0/LE/mLFReJUVSXdDZub6dHr+Tz
 HAtIQo7dqpai+6NTkQqHqFDdpCk8w7Tpc69MKDii48J1LjA6QCWyAG+4Scta+LS5Xc7NqZmBh
 ATiAi0wETxhpPI5sByQ8/70pxjvt7LiKf2a+z/3/rrhb6pwJsSm1TGa33t/+u5fkMw7+hFeWh
 ZsIN5F2PrI5TApsVckRTfce9YQgJqjRrPUa5nWovet0iJ02YEWR6REbBubTyqhqRmiURww353
 cJFR/LuaPAyUT8fnFU6MWJWf4uvAI+aZFkFbdiZlwxWHDRAWjzSSRhhK68KAV1tpABp+f8RzN
 Pbdy83Z3Ib6nAKXV7Mr35VBXTWnyW2RNMrnuVXWUmrBYWt6iGWNjNXUC4QVfZCEazBIM0F1uf
 +fEytP5YZaFgQie8CqY/EQz8VgaI9hNmVNQDH1KZBBC2Xay0u8U49LM6zWW0UXJw688j4XxVZ
 AO/yubl1AWLgDv3M25QUQF+Bl2TnBcSbFhjJt8YDXnWSki8uiSpik46TFf/n7J/uEmUalSF1j
 QAzGIgEBEzZDmYqbXBgxdGXH5RSqWknkrhR6rUQ+ANFhV6FDeKORbUFhE81yOwsOmfAIAAQtC
 whDnuaDDeAfgCj1WYriBC1bnYN60uZsVForqbLo+nNDIvW+AgCcdAu6lxUnonZU6tivhV7EHU
 dc+M2TSYvgppFz0mWW/g9Wl9JXeHEzrtiGPu+W0Ov5ddXu5+1eJPDHfp1AVV6wxTDZJRUMmPG
 Le/MH9w
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Hi Junio,

On Sun, 6 May 2018, Junio C Hamano wrote:

> Johannes Schindelin <johannes.schindelin@gmx.de> writes:
> 
> > Johannes Schindelin (17):
> >   Add a function to solve least-cost assignment problems
> >   Add a new builtin: branch-diff
> 
> Perhaps retitling these to
> 
>     hungarian: a function to solve least-cost assignment problems
>     branch-diff: a new builtin to compare iterations of a topic
> 
> may serve as good precedents to changes other people may later make
> to these files.  Especially the second one is already consistent
> with the several changes that are listed below ;-)

I like it! They are retitled locally, in preparation for whenever I send
out the next iteration.

Ciao,
Dscho
