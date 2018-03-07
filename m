Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-2.7 required=3.0 tests=AWL,BAYES_00,
	FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,HEADER_FROM_DIFFERENT_DOMAINS,
	RCVD_IN_DNSWL_HI,T_RP_MATCHES_RCVD shortcircuit=no autolearn=no
	autolearn_force=no version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id D15E31FAE3
	for <e@80x24.org>; Wed,  7 Mar 2018 13:50:11 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1751176AbeCGNuJ (ORCPT <rfc822;e@80x24.org>);
        Wed, 7 Mar 2018 08:50:09 -0500
Received: from mout.gmx.net ([212.227.17.22]:54065 "EHLO mout.gmx.net"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1751150AbeCGNuI (ORCPT <rfc822;git@vger.kernel.org>);
        Wed, 7 Mar 2018 08:50:08 -0500
Received: from [172.16.5.73] ([84.88.84.116]) by mail.gmx.com (mrgmx103
 [212.227.17.168]) with ESMTPSA (Nemesis) id 0LaGfK-1eP8Wk20eE-00m15P; Wed, 07
 Mar 2018 14:50:00 +0100
Date:   Wed, 7 Mar 2018 14:50:00 +0100 (STD)
From:   Johannes Schindelin <Johannes.Schindelin@gmx.de>
X-X-Sender: virtualbox@MININT-6BKU6QN.europe.corp.microsoft.com
To:     Igor Djordjevic <igor.d.djordjevic@gmail.com>
cc:     git@vger.kernel.org, Junio C Hamano <gitster@pobox.com>,
        Jacob Keller <jacob.keller@gmail.com>,
        Stefan Beller <sbeller@google.com>,
        Philip Oakley <philipoakley@iee.org>,
        Eric Sunshine <sunshine@sunshineco.com>,
        Phillip Wood <phillip.wood@dunelm.org.uk>
Subject: Re: [PATCH v5 00/12] rebase -i: offer to recreate merge commits
In-Reply-To: <bc9f82fb-fd18-ee45-36a4-921a1381b32e@gmail.com>
Message-ID: <nycvar.QRO.7.76.6.1803071445510.20700@ZVAVAG-6OXH6DA.rhebcr.pbec.zvpebfbsg.pbz>
References: <cover.1518307771.git.johannes.schindelin@gmx.de> <cover.1519680483.git.johannes.schindelin@gmx.de> <bc9f82fb-fd18-ee45-36a4-921a1381b32e@gmail.com>
User-Agent: Alpine 2.21.1 (DEB 209 2017-03-23)
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
X-Provags-ID: V03:K0:MvuDqj1lQ5SMshhFD8RwG9bXtHpRoVvo/8bbj7vTJSuQm8mNMW1
 epaZeXYhvFVPNhpKbytD4Cc30QcoBqbu+S4Bn3ypeIg7t52q96fuUZgqvQlEJFNDPfzTsTV
 RSdfp02H9AK1Xv2D6P7lOpLSmkXJQATiu14D2jG885VQmpOXJFRDExJSW8K+HYrgwsAz6Mz
 P0lNQHwC2sKuFM8YTC7jw==
X-UI-Out-Filterresults: notjunk:1;V01:K0:PUlN/WSrTUc=:fYGl3ybOYK6j+RV5G/3zKg
 nK4HwWxJVB1p7dkeW2n+s7mrrxwcTESAOaJRop0dFQkobuqg0qnDlnEDyCyp4lFQEnrbG1tLh
 dDW2xXUFDvlmseO/bS/O/wQBwwg27mU4T+8AkQ5a9eXpLUsHh6vQPLk3nZgth1V/hFKLN+61N
 YZ5MtE/fapEHj8BQghycsBUwsJc7rqerxLOMiq+HRQxcUdNmhofN/2VBI+6LN5kL5WvOY7Ae6
 LSY1r4yVl80EGdXn9HanhHQF/uAAhCg1Sx7hyNLhdMmocgN25kKCihYK2HfSIALdyopMICW80
 +6S+Mj2L3fJebB5JZMGeLzp2NZY6USR3Gprd0v9+KgC4efruPFMi4MWweBE4YHj04RigoJIFR
 6uOE619atOEtpcYf+vB/i9k3Ht1x8PUk8+71ANEZWEGOBjfjkg++G9uz+SHiQdtxL0bZ97oDV
 YC4Ns+MmfW0WGNoD98YdABZeadgtNYLsuhCRd/W+J6s78bCwAwMhT7DPbJvDUWGs37VZwhXHq
 2D11U1kW28Yp6dftuFaPc7kYael6DRWeaKSfE1ETz5oMIpvZblyf/adM1iX2cBuCEcOZLy5Pw
 6ntxa9shtaO8I/GhYbkjGm0nY5MDKbjXaxcN+4jF1EfF+GJIuZzGIW88NquAF6LIogA+dNeWt
 DoH4oX80vzcoo2wZjpz8725wAuxCydAbk6IfmawzKV4uEywl0uEJitC/q8i24s7O2wK0FRaSl
 uTeheWOxSAcUmRMj3ST/G8y5HaeGeb01jBin+EmA8GFydGCzxNo4hyTzh+SlgTmM1Ma9v+u+G
 DGa30llL2ib7zyzTL93sXwfw5UrGcbupp2wgI+wBU9ga0xzsM4=
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Hi Buga,

On Tue, 6 Mar 2018, Igor Djordjevic wrote:

> [...]
>
> But before elaborating, I would like to hear your opinion on whether you
> find it worth to pursue that goal here, before `--recreate-merges` hits
> the mainstream, or it might be just fine as a possible later
> improvement, too (if accepted, that is).

As I suggested in another sub-thread, I think the best way forward is to
use your idea to make the 'rebase original merge commits' strategy
explicit.

That would not actually hold up the current --recreate-merges patch
series, but would mean to provide an add-on patch series to add support
for `merge -R` and then use that from the generated todo list.

For implementation detail reasons, it may actually make sense to integrate
those patches into the --recreate-merges patch series, though. Should not
be hard (except during GitMerge).

> p.s. lol, now that I said it, and after writing all this, I might 
> actually even like the idea of (later) having `--rebase-merges` 
> alongside `--recreate-merges`, too, each one clearly communicating 
> its default mode of operation - rebase merges vs. recreate merges... 
> as one might rightfully expect ;) Eh :P

Hehe...

Ciao,
Dscho
