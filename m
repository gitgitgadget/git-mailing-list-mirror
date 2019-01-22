Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.2 (2018-09-13) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-3.6 required=3.0 tests=AWL,BAYES_00,
	FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,RCVD_IN_DNSWL_HI shortcircuit=no autolearn=ham
	autolearn_force=no version=3.4.2
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id C37381F453
	for <e@80x24.org>; Tue, 22 Jan 2019 15:37:24 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728719AbfAVPhX (ORCPT <rfc822;e@80x24.org>);
        Tue, 22 Jan 2019 10:37:23 -0500
Received: from mout.gmx.net ([212.227.15.15]:34711 "EHLO mout.gmx.net"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1728699AbfAVPhX (ORCPT <rfc822;git@vger.kernel.org>);
        Tue, 22 Jan 2019 10:37:23 -0500
Received: from [192.168.0.129] ([37.201.193.149]) by mail.gmx.com (mrgmx003
 [212.227.17.190]) with ESMTPSA (Nemesis) id 0M3j17-1h3V1z0svR-00rLGC; Tue, 22
 Jan 2019 16:37:18 +0100
Date:   Tue, 22 Jan 2019 16:37:02 +0100 (STD)
From:   Johannes Schindelin <Johannes.Schindelin@gmx.de>
X-X-Sender: virtualbox@gitforwindows.org
To:     Elijah Newren <newren@gmail.com>
cc:     Git Mailing List <git@vger.kernel.org>,
        Junio C Hamano <gitster@pobox.com>,
        Alban Gruin <alban.gruin@gmail.com>
Subject: Re: [RFC PATCH 3/3] git-rebase.sh: make git-rebase--interactive the
 default
In-Reply-To: <CABPp-BEQ2e06zFEgOYp2iA9tvD9gdV-zOtyD3sOnmxCHd=PrSw@mail.gmail.com>
Message-ID: <nycvar.QRO.7.76.6.1901221633290.41@tvgsbejvaqbjf.bet>
References: <CABPp-BGxaroePB6aKWAkZeADLB7VE3y1CPy2RyNwpn=+C01g3A@mail.gmail.com> <20180607171344.23331-1-newren@gmail.com> <20180607171344.23331-4-newren@gmail.com> <nycvar.QRO.7.76.6.1806100006000.77@tvgsbejvaqbjf.bet> <CABPp-BHa+sxuFBa3EmSyio28ytF_ORn950Keh1P=L-VxXtOwMw@mail.gmail.com>
 <nycvar.QRO.7.76.6.1806172337340.77@tvgsbejvaqbjf.bet> <CABPp-BEnJ4q9WGi4BgikpLJ9Aty5-3MR4VozjBk7ie4rGMc-ng@mail.gmail.com> <nycvar.QRO.7.76.6.1806211242440.11870@tvgsbejvaqbjf.bet> <CABPp-BGh7yW69QwxQb13K0HM38NKmQif3A6C6UULEKYnkEJ5vA@mail.gmail.com>
 <nycvar.QRO.7.76.6.1901211635080.41@tvgsbejvaqbjf.bet> <CABPp-BEQ2e06zFEgOYp2iA9tvD9gdV-zOtyD3sOnmxCHd=PrSw@mail.gmail.com>
User-Agent: Alpine 2.21.1 (DEB 209 2017-03-23)
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
X-Provags-ID: V03:K1:zmBy+38XPR/G83JIbeHKQcxgYzqPlsD/dWXVGmhu3tApHP4X2KK
 tOQ4DdX5b0j2f5i1knVbNrdh2NCcWWZDvq1dWinxQ7LOLQYWboxpt1cMVJKHCeeb63FZ03u
 j/GhYDvUyl6o7bPUKnYJofT/gDOydsML+zzJ7O1GjZktj60RcDkVnyiaa+72Nol2R1Xhffe
 uW+Ib+/DDXEnO6h8KQ7Ew==
X-UI-Out-Filterresults: notjunk:1;V03:K0:DVj8bD5rJjE=:J9N+Bfikq5O+/miRrXl8OI
 RDCjod4MW939o9XXbq1pEgiFLDLQPKe1KfL+V5NOUvX+TPamZRGBiKmNRmgv3Vid8OIy9zXQU
 P0DCJLe/4+Yl23TgXCZrXiwTYt3pvoVLxiZQCYIh1t9VYKkDsoOrJMlthkKooX9mWcTxVWckc
 1UbF3wYl5g29Ad89O0hPbnOaTkfDaRcPeuL4wV/Os/nXhD858K2hpxTRpScaL9aqXHZfowuSL
 PFY0SHzHNILW6lsivYr8mJTVMn7d2OzHIuBcZaOK3EMqervkeS6PVMeSuXsUnwpGfzwDdOqBw
 vpj57QUgQeEE1Q0qWUNcggyVRtTIF7qNY+BTZ5au8HRDOl5CxXRMswN3gYbmdC1vb4HDlU9De
 A1/opwvtHIq1I9fJaxzOnj5kDgh98nWUHQKsW7n+O/uVL7oCRIqVwU99B2zGXvDNywAAIcS3Y
 bL8p+awD6smhFoI4rsUSoVtcqGQ7MEEsO+Ul8Y5e0IBCXlyTVtZzHYjEF87hBbeEALjLWMW2v
 7noTbNn0JXJQ69IEuWqwnRF5seM/ZFVblxSgbrLuJYay5Vp/hqkzwfhB04cxO7kzAhzgOZOvp
 pMzonXvHnBBkMNJkBDNIPlxwQSsJmeQfubrqIAUYGt1PJ2TQPzxg/Im0MTyHtYyE1otrOxEdB
 wEOp6NYK/ibLHw+ZJHUR5lxOXeMVkfO8vTY/42E4VbazarFADNmsLO2iUAqrJk8TJrU8zqeXB
 JogFAOp51FgMsyTtYr7FOnQu1n2pXu+rKv0giMZC4g10+KAuh/4YVCYXc22+DhluugJukA3MA
 V3NmZAmEncigOH+av5l26BmiFSU/yLOiW60y3b1MY9xr7w296ic11NTZXt5ZrfElXKkIxxLbt
 vMzTwyjaDUF/gqTWaILyuUkpproJqPtMGQ12Vm37F2Z0mcLfEputSI61HMW0R9VYItbBca0ja
 P/GUji2uv6A==
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Hi Elijah,

On Mon, 21 Jan 2019, Elijah Newren wrote:

> Before worrying about adding extra options and deprecation periods,
> though, perhaps we could start by by omitting the --cherry-pick for
> implicitly_interactive rebases, like --merge?  (In particular, I'm
> thinking that when we switch the default rebase to be --merge instead of
> --am[1], we avoid breaking things.)

There are more implicitly interactive rebase modes, though, such as
`--exec` and `--rebase-merges`. I would like to keep `--cherry-pick` for
them by default, at least I think I would.

> I am not familiar with MinHash and Locally Sensitive Hashes, but I'll
> add them to the list of things to look into.  Thanks for the idea.

Of course! Please let me know if you get to this idea, or if you find
something even better. I'd like to collaborate with you on this, as I
really need to find a better way to identify upstream commits in
GitGitGadget.

Thanks,
Dscho
