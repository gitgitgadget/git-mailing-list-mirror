Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-2.6 required=3.0 tests=AWL,BAYES_00,
	FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,HEADER_FROM_DIFFERENT_DOMAINS,
	RCVD_IN_DNSWL_HI,T_RP_MATCHES_RCVD shortcircuit=no autolearn=no
	autolearn_force=no version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 487EB1F42D
	for <e@80x24.org>; Mon, 19 Mar 2018 11:42:09 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1755433AbeCSLmH (ORCPT <rfc822;e@80x24.org>);
        Mon, 19 Mar 2018 07:42:07 -0400
Received: from mout.gmx.net ([212.227.15.15]:52839 "EHLO mout.gmx.net"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1755299AbeCSLmG (ORCPT <rfc822;git@vger.kernel.org>);
        Mon, 19 Mar 2018 07:42:06 -0400
Received: from [192.168.0.129] ([37.201.195.115]) by mail.gmx.com (mrgmx003
 [212.227.17.190]) with ESMTPSA (Nemesis) id 0MXqaN-1f9Dg41E9P-00WnVU; Mon, 19
 Mar 2018 12:41:47 +0100
Date:   Mon, 19 Mar 2018 12:41:30 +0100 (STD)
From:   Johannes Schindelin <Johannes.Schindelin@gmx.de>
X-X-Sender: virtualbox@MININT-6BKU6QN.europe.corp.microsoft.com
To:     Junio C Hamano <gitster@pobox.com>
cc:     Derrick Stolee <stolee@gmail.com>, git@vger.kernel.org,
        peff@peff.net, sbeller@google.com, szeder.dev@gmail.com,
        ramsay@ramsayjones.plus.com, git@jeffhostetler.com,
        Derrick Stolee <dstolee@microsoft.com>
Subject: Re: [PATCH v6 00/14] Serialized Git Commit Graph
In-Reply-To: <xmqqpo442aok.fsf@gitster-ct.c.googlers.com>
Message-ID: <nycvar.QRO.7.76.6.1803191236320.55@ZVAVAG-6OXH6DA.rhebcr.pbec.zvpebfbsg.pbz>
References: <1519698787-190494-1-git-send-email-dstolee@microsoft.com> <20180314192736.70602-1-dstolee@microsoft.com> <xmqq605yz8ue.fsf@gitster-ct.c.googlers.com> <nycvar.QRO.7.76.6.1803151821270.64@ZVAVAG-6OXH6DA.rhebcr.pbec.zvpebfbsg.pbz>
 <xmqq37115ggs.fsf@gitster-ct.c.googlers.com> <nycvar.QRO.7.76.6.1803161249060.56@ZVAVAG-6OXH6DA.rhebcr.pbec.zvpebfbsg.pbz> <xmqqpo442aok.fsf@gitster-ct.c.googlers.com>
User-Agent: Alpine 2.21.1 (DEB 209 2017-03-23)
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
X-Provags-ID: V03:K0:eoMgF53AP8zcurIp7KdPhcjNakOlso3jZcaGo2nh5p0ygAOFo/W
 CADW5hiGTFfnWOrzt9BXN9NVPCWNA5vyApYV3joUpW5YbpnsqPVwm2a0jfxpiSptAwEEPUZ
 1ucqeZEU33V6Rpa8ce0saHJgAQXAveYXewUrVMj/Ke2d1M/JUgSjvwX1gEbk7GmYsrWMrF3
 7cD+10pEd0iL4YlnmOtCA==
X-UI-Out-Filterresults: notjunk:1;V01:K0:NqYajBRcSp0=:+KlAGDJTnBAcFFd3Inc5ql
 8Ly5m4VOryEjVX4THiEuwLHnzOwaaDgFByWhJDo1JBADHUqmdPfWoK/5d8DoWdqAjLtFUdrNR
 IYq6tBzMNJaEqFNDBuKqx4NUkmccxu86SL8xsAVDul1ECWV8Sd7xI04MOwFAGHEQLjS9oeawW
 v3oI/vm6/lOIExi/irEv2p83UtyB/Dv2P/APmLyDSOcCe2t/G2a4ByQsnyPXljtFtOkZ+4lb8
 qaVE9C4xGuWAJBKOvc0bpneLR/1vgcEFQuN9GC0KcDJcpa7bp1uGCXD2qYkabmaqXXNwBxFvx
 d+5eqNXqJHbupTf7cC4NeXp1zXy1irF+N52HFtzkqzodwpnmt35sgK0IpNZ4qrHs+MSLVkrCe
 r/jJMVgqt+eFg/uNKwndGal8fkjLJTUFu2eCJRmir6E4T+f20swUQ8FMfCF8x9HPnf3Y9XXDX
 t+4xd88FM5REtXTIekwOMOqKQSRzqSzF8ApsE/YaEYLoFVT++2bdFE6c/9vYOvWo0McDzZnBg
 RwQAnUxumAoQ9KgiLgFCd+pxHf0/4HviHRaSjfsd6QAftaNCj9FR1DaZ+lRcnUQ06fpOviGYw
 Gtxa1hdXxxXNfdkIYxKc1rv0go7ehjekT0yXH0ohemvwPTZhDdRklMEgOf6YP94Ygtf/t1QUZ
 q7Z2hFDxKyuCr8X6KcEyy2lccxnM2/xxsUHYKXWfQJPpT24K1T4QJD9SjfvNp5+87G9MhA0pr
 KhLU9LFWzHUvyiV89ALxB39o7zKM1CaQ+lgohOwy8gq1gCrRfOCntFgs60E8njAP0PF5BFZAi
 eVXmPF42S6Zm0pdSyDlvc1kRu4+tVEJhUZFanUKpccP8jWyLEA=
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Hi Junio,

On Fri, 16 Mar 2018, Junio C Hamano wrote:

> Johannes Schindelin <Johannes.Schindelin@gmx.de> writes:
> 
> > I understand that it is a trade-off between time you have to spend and
> > that others have to spend, and since you do not scale, that trade-off
> > has to be in your favor.
> 
> That tradeoff may exist, but it does not weigh in the picture above
> at all.

It does, however. You frequently do not even tell the original contributor
what changes you made while applying the patches. I know because I have
been surprised by some of those changes, long after you merged them into
`master`.

And quite honestly, my time is valuable, too. So you should stop assuming
that I, for one (and probably other contributors, too) compare carefully
what differences exist between the local topic branch and what you chose
to make of the patches. I cannot make you stop suggesting that, but I can
tell you right away that I won't do that unless I *have* to. It is an
inefficient use of my time. I wish you would also realize that it
invariably leads to your having to "touch up" iteration after iteration
because your touch-ups had not been picked up.

Having said that, I can live with the status quo. I have a track record of
being able to.

Ciao,
Dscho
