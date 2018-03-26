Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-2.6 required=3.0 tests=AWL,BAYES_00,
	FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,HEADER_FROM_DIFFERENT_DOMAINS,
	RCVD_IN_DNSWL_HI,T_RP_MATCHES_RCVD shortcircuit=no autolearn=no
	autolearn_force=no version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 774041F42D
	for <e@80x24.org>; Mon, 26 Mar 2018 11:33:15 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1751116AbeCZLdN (ORCPT <rfc822;e@80x24.org>);
        Mon, 26 Mar 2018 07:33:13 -0400
Received: from mout.gmx.net ([212.227.17.21]:34517 "EHLO mout.gmx.net"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1751024AbeCZLdM (ORCPT <rfc822;git@vger.kernel.org>);
        Mon, 26 Mar 2018 07:33:12 -0400
Received: from [192.168.0.129] ([37.201.195.115]) by mail.gmx.com (mrgmx103
 [212.227.17.168]) with ESMTPSA (Nemesis) id 0M1WHV-1eggfJ0hL7-00tXbV; Mon, 26
 Mar 2018 13:33:04 +0200
Date:   Mon, 26 Mar 2018 13:33:20 +0200 (DST)
From:   Johannes Schindelin <Johannes.Schindelin@gmx.de>
X-X-Sender: virtualbox@MININT-6BKU6QN.europe.corp.microsoft.com
To:     Sergey Organov <sorganov@gmail.com>
cc:     Igor Djordjevic <igor.d.djordjevic@gmail.com>, git@vger.kernel.org,
        Johannes Sixt <j6t@kdbg.org>,
        Junio C Hamano <gitster@pobox.com>,
        Jacob Keller <jacob.keller@gmail.com>,
        Phillip Wood <phillip.wood@dunelm.org.uk>
Subject: Re: [RFC v2] Rebasing merges: a jorney to the ultimate solution
 (Road Clear)
In-Reply-To: <87zi3dh53k.fsf@javad.com>
Message-ID: <nycvar.QRO.7.76.6.1803261331340.77@ZVAVAG-6OXH6DA.rhebcr.pbec.zvpebfbsg.pbz>
References: <87y3jtqdyg.fsf@javad.com> <87r2oxe3o1.fsf@javad.com> <nycvar.QRO.7.76.6.1803070742580.20700@ZVAVAG-6OXH6DA.rhebcr.pbec.zvpebfbsg.pbz> <87vae8yq15.fsf@javad.com> <nycvar.QRO.7.76.6.1803071450511.20700@ZVAVAG-6OXH6DA.rhebcr.pbec.zvpebfbsg.pbz>
 <a0cc88d2-bfed-ce7b-1b3f-3c447d2b32da@gmail.com> <nycvar.QRO.7.76.6.1803111324390.20700@ZVAVAG-6OXH6DA.rhebcr.pbec.zvpebfbsg.pbz> <d18a6e73-ce6f-b4aa-8ead-7aaabddf454d@gmail.com> <87zi3dh53k.fsf@javad.com>
User-Agent: Alpine 2.21.1 (DEB 209 2017-03-23)
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
X-Provags-ID: V03:K0:VJse6FH7p+lqkrr+dIy8d46kXzNZjL/tct6xdl/CUN4ZZ/+6FTU
 oGMc5geCnoHDHvS1dhPeKUHC9wXLSnJcl9EAEBiF/GTgjgSc7KofNglWTzsi2iPkWT2++zt
 5qUQrsw3YJkoAfjsLSfXVo7wEJxo4BKMUQ7wMCPMrrU9Pz404c9fLBaT+TKyJLFEo2NS+Op
 JIzPLyWKCuNb4hEZoqx7w==
X-UI-Out-Filterresults: notjunk:1;V01:K0:KyPfRASU/k4=:h/x7R/FhNfMD+g36RrtJH2
 DkRSMiQLE3Zk/Xhy9Jugcdq6RX+aWBfCNbjOkhPmM53cNFHsRXhFx0Vp5uwX9LVdS5voJHJDa
 EE3LSsTBDjaP21bkDzsRTAFSLQeZOz22Fmu7vxlDXylrexTuwTXRz+j1BgiiNMVYCuqz2LCIq
 uy2K1DhS32z/Xg342wfOYwRWBoXEQ04hpGco72br11yBkcXI6Pd/adSGL8GMwMxzC0g0zR13X
 hdylSdHrhkdoUjBK7iZujxjhoan6MUnO6z+SwRg7zBauuUkMRTkYmxNu78nuorjtRhNxSS1rc
 8kmapU0B/rrC9mdE33k3k5A+ixcDGixaMgxvs0OaPin+98P3ZtFTr6c6yVJ5QwYv1jyG9Ivbp
 yEgo+tg7E86yQq604v09M5dfc8tE0M5134At1/lfgAmgJ06zuiczYOR4j4/R8TeC/EIgMGHWJ
 UObPtU54TJFOFysm4hNa9DNETC9g+k+9ITySPCbjqD3KjLvhhrIT30ZGEYJnvhUz1MdntNxOp
 kzcKBG5D2gDlEcPrwVv8CJR1R6xIMSA2seR5EWe9Udgh1b/RrBaYm5FrV39M0RA1x9WgsQIoU
 BOUksYuu8zV4NcgbZmyKuRx5zxJycAblL+oQGpA731BT6tuqc5Qr9Ah7dfuIKq06TlFu1fN9X
 3uHvOlbqeJ+iHpec/x+iKGBDxt2tLcIzQGaA1p+c4eCRwf2rcYpWybD/HNVQMZ16Jgvz9EMM1
 8XAY2b77xxGfBl3bYHgGT56hgIVBhL46Vuv7MgrXqMIX+Fcv6tqLr/fq4SdWqwQtY4qreC+x3
 LVSY8MDz0NuxOQuvU0cxnh7vdQ+SqEZQSEGaD7A6akPWlAD8gxBN5UZgPc0NMF1jwrAsx7b
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Hi Sergey,

On Mon, 12 Mar 2018, Sergey Organov wrote:

> [...]
> 
> Yet another consequence is that my approach will likely result in better
> code reuse.

This is a purely academic speculation. At least until somebody implements
Phillip's method. Oh wait, I already started to implement it, and it was
not exactly hard to implement:

https://github.com/dscho/git/commit/26d2858800a4e0d3cc6313ddb54dd4d2ce516f31

Ciao,
Johannes
