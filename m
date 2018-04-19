Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-3.2 required=3.0 tests=AWL,BAYES_00,
	FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,RCVD_IN_DNSWL_HI shortcircuit=no autolearn=ham
	autolearn_force=no version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 0470E1F424
	for <e@80x24.org>; Thu, 19 Apr 2018 08:16:09 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1751136AbeDSIQG (ORCPT <rfc822;e@80x24.org>);
        Thu, 19 Apr 2018 04:16:06 -0400
Received: from mout.gmx.net ([212.227.15.18]:53777 "EHLO mout.gmx.net"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1750858AbeDSIQE (ORCPT <rfc822;git@vger.kernel.org>);
        Thu, 19 Apr 2018 04:16:04 -0400
Received: from [192.168.0.129] ([37.201.195.116]) by mail.gmx.com (mrgmx003
 [212.227.17.190]) with ESMTPSA (Nemesis) id 0MfEZG-1elLsL2zEI-00Osfi; Thu, 19
 Apr 2018 10:15:59 +0200
Date:   Thu, 19 Apr 2018 10:15:43 +0200 (DST)
From:   Johannes Schindelin <Johannes.Schindelin@gmx.de>
X-X-Sender: virtualbox@MININT-6BKU6QN.europe.corp.microsoft.com
To:     Stefan Beller <sbeller@google.com>
cc:     git <git@vger.kernel.org>, Junio C Hamano <gitster@pobox.com>,
        Jakub Narebski <jnareb@gmail.com>
Subject: Re: [PATCH] Deprecate support for .git/info/grafts
In-Reply-To: <CAGZ79kawFhCuDbAndg2oU87jFT-PhpLBMoEBumN=J_DfGK=v9A@mail.gmail.com>
Message-ID: <nycvar.QRO.7.76.6.1804191014430.4241@ZVAVAG-6OXH6DA.rhebcr.pbec.zvpebfbsg.pbz>
References: <0f0942043678fe76f8d654306482ee26fac643f0.1523617836.git.johannes.schindelin@gmx.de> <CAGZ79kbEec_U5wL_aOS5O_3+ZOshGwARALpjz801h-fRx-zotA@mail.gmail.com> <nycvar.QRO.7.76.6.1804132339130.234@ZVAVAG-6OXH6DA.rhebcr.pbec.zvpebfbsg.pbz>
 <CAGZ79kawFhCuDbAndg2oU87jFT-PhpLBMoEBumN=J_DfGK=v9A@mail.gmail.com>
User-Agent: Alpine 2.21.1 (DEB 209 2017-03-23)
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
X-Provags-ID: V03:K1:ZBvPAO+giidOit+VLwFPl7i1Dkz8dUbSVEkH6ReO+i77PZ4KG5c
 0azW67MT2aRJSY/n5H/PPflOcvnZ+EH4kSVkA2LAyCWQW5d8xr7Lc/Hiv19s8L3Cbd9UzH8
 PzK8IGXZKT3+fpC+rZwiMJodfH/m+bUyOE7gX5SLTivDT5YEiw8coOacyIIn4kZIk9XHg2L
 EORYFdQUjkpyOGx8bvlDA==
X-UI-Out-Filterresults: notjunk:1;V01:K0:R2RokygGtGs=:4C33Fs9y1/H64qTrGrhgcu
 Bl2fXIm0dML/AzrNvJh2Xnfo+S4svhiQjaAMxdwZbVIkKhZcRu4CLUPhwDcWDumT0KlZE476k
 ssL9HmG8FoeZvGXihbenWWhZM1nkrSw8nXShTzgqY6UO2oQyplp7S+4wCopP0IU0I1FS/hOLX
 T6Jvwr6x0bhJD3kSjRfZFhICy3VwhtERyO6AiO9Xp5JwDqYWfsmXx4iYuTTAZ/R1w40FLXrIZ
 rKydZAuVT5sktMx1+SbYk10vVUhBftZi1/7ui92zvDYvDslDI6wCASh/uV2N4HDN+m/FakzOd
 RW3z0dQDuWm5ekRb9cATbXG9ddiSNBOtyC7gUN7p3qb6oWzZGrXg7jDf62ZrrFNQtoq6b20xB
 IX2JB0yJJNgtiTYb1xmNpWzufaKxU9LGgIxShE/a7HdVOf7FxBs5wyCNQpu/PMOJLxqjYvZKI
 qTaazbRISzSai/lnyshQjjfzN9ZwbLphtGju3+gHHl1KWCC6QyJ/ePI4BT03MhTe+/akhFwz5
 Pxy0qZlbOeziEw5RO2CKYceun3OfaJasVBrI/aBEu1EoIByAkORx/GYvkmSvahg4eviZB2AjT
 DTfvF7dGD5Z3FBrqfOTN2Y0swxCgll3oN0vUBNgpMO68OXHiRkVhpZx2Mt40TYDvSmdyrEkX9
 0U32tbTspTrX2mokyArlNuGwydt4X+5qodZwOTv8jm0evr+uLgLMflPKc55vg+wV23exFABdR
 7rH/okRY+jsi+tA6iK4xSwVBNaVFAijvXcj4X4QzR9z9Hzbspi697AVQXUkWVOSWvdMnV8xQ2
 T4DhQh2f1boKdhsVTmtCwEKThemT5ezpvnUh4BhHz/SKS55S10=
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Hi Stefan,

On Fri, 13 Apr 2018, Stefan Beller wrote:

> On Fri, Apr 13, 2018 at 3:35 PM, Johannes Schindelin
> <Johannes.Schindelin@gmx.de> wrote:
> 
> >> I wonder if we want to offer a migration tool or just leave it at
> >> this hint.
> >
> > There is contrib/convert-grafts-to-replace-refs.sh.
> 
> Oh cool! I wonder if we want to expose it more such that people
> discover it.

Nah.

> > I wonder whether we have to care enough to implement a `git replace
> > --convert-graft-file`...
> 
> I don't think so.

After reflecting about this in the back of my mind, I actually do. So I
implemented it.

Ciao,
Dscho
