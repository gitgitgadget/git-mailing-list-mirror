Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-3.8 required=3.0 tests=AWL,BAYES_00,
	FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,HEADER_FROM_DIFFERENT_DOMAINS,
	RCVD_IN_DNSWL_HI,RCVD_IN_SORBS_SPAM,RP_MATCHES_RCVD shortcircuit=no
	autolearn=ham autolearn_force=no version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 810361F4F8
	for <e@80x24.org>; Thu, 20 Oct 2016 12:07:29 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1754381AbcJTMHO (ORCPT <rfc822;e@80x24.org>);
        Thu, 20 Oct 2016 08:07:14 -0400
Received: from mout.gmx.net ([212.227.17.21]:57185 "EHLO mout.gmx.net"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1754099AbcJTMHM (ORCPT <rfc822;git@vger.kernel.org>);
        Thu, 20 Oct 2016 08:07:12 -0400
Received: from virtualbox ([37.24.142.40]) by mail.gmx.com (mrgmx103) with
 ESMTPSA (Nemesis) id 0MK0bZ-1byZZN2OZx-001SQg; Thu, 20 Oct 2016 14:07:04
 +0200
Date:   Thu, 20 Oct 2016 14:07:03 +0200 (CEST)
From:   Johannes Schindelin <Johannes.Schindelin@gmx.de>
X-X-Sender: virtualbox@virtualbox
To:     Junio C Hamano <gitster@pobox.com>
cc:     git@vger.kernel.org,
        =?UTF-8?Q?Jakub_Nar=C4=99bski?= <jnareb@gmail.com>,
        Johannes Sixt <j6t@kdbg.org>
Subject: Re: [PATCH v3 14/25] sequencer: introduce a helper to read files
 written by scripts
In-Reply-To: <xmqqpomxr6t6.fsf@gitster.mtv.corp.google.com>
Message-ID: <alpine.DEB.2.20.1610201406560.3264@virtualbox>
References: <cover.1473590966.git.johannes.schindelin@gmx.de>        <cover.1476120229.git.johannes.schindelin@gmx.de>        <b554346c600fafa71d2a3461fda8402e377b596e.1476120229.git.johannes.schindelin@gmx.de>        <xmqqr37ex5ck.fsf@gitster.mtv.corp.google.com>
        <alpine.DEB.2.20.1610181339550.197091@virtualbox> <xmqqpomxr6t6.fsf@gitster.mtv.corp.google.com>
User-Agent: Alpine 2.20 (DEB 67 2015-01-07)
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
X-Provags-ID: V03:K0:YMMAgF5fOdKaSwrhBbRHoleP8CGYGxFfoipAoJxaJv/vfeZyY1l
 ddClThxgcdHZH7wliApL+pbCSWeB/G1UamFfry9GCz80l3XdyolaACfeBykzj3UKeqS7uZX
 dDBgwqm18EwRpztKBgcD5gp2etY1ZKj9jpQR+k4eJy4gffHgLxM/Tnyk3UwUmqGFKwofwEh
 Z1svqFTi308DotP8SG2PQ==
X-UI-Out-Filterresults: notjunk:1;V01:K0:qsaLD5IAIr0=:BJcw2AKK1XtcWL2KywgwPK
 QIn+67R3u4u88BfEdfTGk/fqWIrkaMd9luDmu9frLpp9xKaFlAk2SHsOmq48Lrpo3sQldug1f
 lvUmd+/Q0ad6HwK5qJqwZoycJdjCw2M2ihDVCcB2uZM6Ia9xA1BdbyENpZVkhGyM5ee4950Kl
 2JOFQHGSKoGjBqDBANl5rVagxbKiqsYhzlV3HbPPcMYJVZlLfTWhTt/MGjoD3Uo4kvg81dXGY
 95elz9teoxhz0+DYRLDC2T+WT0h/1FoOnkOjTfhg/L085+P5hn+mGO2U53n9W8YCIavPEBSws
 pppLtLGn/EB1LfFfbS5Goeci6ZA6Jl8yIuo2ELL6BTYvjjxXxCegQgVzPLoybIaBQl42fSoLO
 xMp+FQqm7xqyVZUX3uWKQFpAW99drq53sTR2JkzpzFxI04WFLKcYOxMKZtJQi1HtwIYEQZAoP
 pFT64vqr+3rAXfIXfkkXz/2XkUwPodzoZUD1/MNgM9Zy8zNj2GH9BEWw8gHVAjZjzIcMcLg0r
 sic1xZdCm7wa1NIR0Jebi851QBQayN69zqt0YB09Pq8ZmsMrCN+N6NGboh2NtIP/dnY3GvHkk
 YTCqI2NfAwrt5TyqUUn+yTK0HRspBYAaLHjq2z0mLJnlDF48NVAxdP4KqSkv8yKyMDl8bkXYI
 qSDtsY/+OqrhUieQMKyIAFlfPRfoFAohwHQOeZbvGL8EI+x0aZX1PUrBTrMQdphuyM2OmtluK
 1c1ZxsaYjCTNY2kAiJTLXj1qRCpTUxPaodShK8dARvuoItYe6gwEvGvV7bjidWZj+zhAc+LR+
 pcegAQZ
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Hi Junio,

On Tue, 18 Oct 2016, Junio C Hamano wrote:

> Johannes Schindelin <Johannes.Schindelin@gmx.de> writes:
> 
> > In the meantime, I'd be happy to just add a comment that this function is
> > intended for oneliners, but that it will also read multi-line files and
> > only strip off the EOL marker from the last line.
> >
> > Would that work for you?
> 
> That would be ideal, I would think.

Done,
Dscho
