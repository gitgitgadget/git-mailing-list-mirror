Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id E7BFFC433F5
	for <git@archiver.kernel.org>; Fri, 22 Oct 2021 10:02:18 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id BDB1660FF2
	for <git@archiver.kernel.org>; Fri, 22 Oct 2021 10:02:18 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232520AbhJVKEf (ORCPT <rfc822;git@archiver.kernel.org>);
        Fri, 22 Oct 2021 06:04:35 -0400
Received: from mout.gmx.net ([212.227.17.21]:58855 "EHLO mout.gmx.net"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S231944AbhJVKEe (ORCPT <rfc822;git@vger.kernel.org>);
        Fri, 22 Oct 2021 06:04:34 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=gmx.net;
        s=badeba3b8450; t=1634896935;
        bh=XWoEewUCaVDX/TpeTmZGekwz8Dc4rRLPP9ubuKF16Zk=;
        h=X-UI-Sender-Class:Date:From:To:cc:Subject:In-Reply-To:References;
        b=JLegPZ6waCJp1a+1R6KggnV2/WUjFWV7w7ORLp8MtKi5dtqPmFY8IgYUenoA+nWAm
         l+Fxk6gx+J38Fl1px7klAmus7SDNOLlDp3/dHHYRJ0Gi5LVB5HkCjyF5jWprlsx8nR
         6Gs2YV8Fn16fhLMQfISM2APBb2QgssOc4jXdUB+I=
X-UI-Sender-Class: 01bb95c1-4bf8-414a-932a-4f6e2808ef9c
Received: from [172.24.19.78] ([89.1.213.179]) by mail.gmx.net (mrgmx104
 [212.227.17.168]) with ESMTPSA (Nemesis) id 1MJmKX-1mOnV81jyL-00KAiv; Fri, 22
 Oct 2021 12:02:15 +0200
Date:   Fri, 22 Oct 2021 12:02:14 +0200 (CEST)
From:   Johannes Schindelin <Johannes.Schindelin@gmx.de>
X-X-Sender: virtualbox@gitforwindows.org
To:     Son Luong Ngoc <sluongng@gmail.com>
cc:     git <git@vger.kernel.org>
Subject: vale check, was Re: [Summit topic] Increasing diversity & inclusion
 (transition to `main`, etc)
In-Reply-To: <CAL3xRKe6Ewps2n54KED7kX=8=Nk7RWHvTkhoB2X-Y1-ZjKEizw@mail.gmail.com>
Message-ID: <nycvar.QRO.7.76.6.2110221201290.62@tvgsbejvaqbjf.bet>
References: <nycvar.QRO.7.76.6.2110211129130.56@tvgsbejvaqbjf.bet> <nycvar.QRO.7.76.6.2110211149530.56@tvgsbejvaqbjf.bet> <CAL3xRKe6Ewps2n54KED7kX=8=Nk7RWHvTkhoB2X-Y1-ZjKEizw@mail.gmail.com>
User-Agent: Alpine 2.21.1 (DEB 209 2017-03-23)
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
X-Provags-ID: V03:K1:CJBjILL5hHm8zyTyzZ3IxHp02bFi8kBmOg0JBn9rE5ICysIR69N
 II9SkfnFYdiByZ0VZxClGaYfCR4iNxBcRnVjGIzy1Io0XNpdXbrkHNs5CaphRCGw5eM3s93
 oH8XaYDlmUdsFCq+5AIcf4xsfEuXnPOmpde8gM5mSAImg6k7rauCa9fvILVD9Y5PZbtArLd
 5QmSNp2romqEPy13mp+QQ==
X-UI-Out-Filterresults: notjunk:1;V03:K0:MSNIeNAtY5c=:4weE5BXqiZj9OPxFWs9nSX
 1Y/6NzS1JItFn/2FbTJs+DCPO6DasxR6KnMpO9MAoy1o1ER0mQ+Xx00HMtSMrGUuaL7/UrrfN
 rTbfrC4Fo+3CHAwzYMMpE3d5+mQ2h1Osqhq1h9yARYA07fr8sVJtOKS25Finr1ZSybYtxw4Bu
 qmsCaposOzuynS0DQa38q5uiuERLNY/ViR9JbN5Y54yKggSlObcClVQgG75lp7rqGm8A/2kuo
 VZQscGkpQPBfz2N2nYxPpDfold0muG6oxhOCPSv5dzWg9CwLQD0p+5p9Gljdwj7e7iLWjC0PR
 /Goy8j06Yk5MON7wnHUJwmOxpFyVlD8xbfFKz0HqchYVkbixd0YI7cBoaORTkShA6S4kgT617
 Szrx4AZ2vbGWXcTNrmIHaLX3AEa5uB23sQkkfL9bbCBikT8oVIMqKFdHF+IFHR7A9NRwntuEw
 1GJvfnRhIwWihSgz0rvNdAqpu2ukcGNOyGYASRi9mhkvdSw8sr2YlC5gVPjRM5OEvL1nzDyGO
 sk3wJaFqS/CMynY32uSQvRVYMSRk2sKwzITW5rapqLGw1N1PzWk2n0SeqIHrtgctqI9LURImZ
 THYMoXokKFS4qPwzt0LRvt2j7mXqaJV1lpDbt9T60YhCztxGDtqsbaLsJonViqIzd3fCW+hv8
 4O1Ut5U1+vBx2ePw6Jt7f8KDJWPNI554ETJTBuUamJe//YVhd2pFWR/umqndLEVTda3AMXsNT
 6+Zoy9/wWycO5PaXqCg92WnyruKdMF4RbtiskGmPtD/UbL/0rWHHXgN0ixeffr9E9JDxkeszT
 dz/KOvAci29QFjs436UvRyYOJq++C6w2+BkBswRwiNvOdMs8YWCY7e7c5u92q2JHNPaf2BKKI
 W8rU7enNvt6itYV8k0XP2eA2WS+QVLcz0YxqhZrSj9FG5I7PYrUGcbLbHMSjTmLGCPPSK86gC
 DF89fZ3dZHuAo14wLQvwqqjNlWa10pPzv4rqfac396tzXeSgUf9n6CIdlLK4SLKhfiEiqrwOv
 i9UXIpQ2PnO0ICMlbg6t3ppfGpwDbY6ddtd8aX0MC2rj8cMOE140gXzfacXCCPWmRVCiQIOcQ
 Aijst4a5d6UrKs=
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Hi Bagas,

On Thu, 21 Oct 2021, Son Luong Ngoc wrote:

> I would recommend, on top of having a guideline document, to have a
> Valve check (1) setup as a commit-msg hook and run it as part of
> GitGitGadget CI to help folks shorten the feedback loops in some basic
> cases.
>
> [...]
>
> (1): https://docs.errata.ai/vale/styles

How about setting this up, then opening a PR?

Ciao,
Dscho
