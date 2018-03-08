Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-2.7 required=3.0 tests=BAYES_00,
	FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,HEADER_FROM_DIFFERENT_DOMAINS,
	RCVD_IN_DNSWL_HI,T_RP_MATCHES_RCVD shortcircuit=no autolearn=no
	autolearn_force=no version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 64FD41FAE2
	for <e@80x24.org>; Thu,  8 Mar 2018 07:03:48 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S934865AbeCHHDq (ORCPT <rfc822;e@80x24.org>);
        Thu, 8 Mar 2018 02:03:46 -0500
Received: from mout.gmx.net ([212.227.17.20]:44637 "EHLO mout.gmx.net"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1751107AbeCHHDo (ORCPT <rfc822;git@vger.kernel.org>);
        Thu, 8 Mar 2018 02:03:44 -0500
Received: from [192.168.1.64] ([88.26.243.156]) by mail.gmx.com (mrgmx102
 [212.227.17.168]) with ESMTPSA (Nemesis) id 0MTeVY-1f2WkZ1UC8-00QW9N; Thu, 08
 Mar 2018 08:03:35 +0100
Date:   Thu, 8 Mar 2018 08:03:32 +0100 (STD)
From:   Johannes Schindelin <Johannes.Schindelin@gmx.de>
X-X-Sender: virtualbox@MININT-6BKU6QN.europe.corp.microsoft.com
To:     Junio C Hamano <gitster@pobox.com>
cc:     Phillip Wood <phillip.wood@dunelm.org.uk>,
        Igor Djordjevic <igor.d.djordjevic@gmail.com>,
        Jacob Keller <jacob.keller@gmail.com>,
        Sergey Organov <sorganov@gmail.com>,
        Git Mailing List <git@vger.kernel.org>,
        Johannes Sixt <j6t@kdbg.org>
Subject: Re: [RFC] Rebasing merges: a jorney to the ultimate
 solution(RoadClear)
In-Reply-To: <xmqqh8pr21f3.fsf@gitster-ct.c.googlers.com>
Message-ID: <nycvar.QRO.7.76.6.1803080801230.20700@ZVAVAG-6OXH6DA.rhebcr.pbec.zvpebfbsg.pbz>
References: <87y3jtqdyg.fsf@javad.com> <nycvar.QRO.7.76.6.1802271718090.56@ZVAVAG-6OXH6DA.rhebcr.pbec.zvpebfbsg.pbz> <4d7f3406-b206-cc22-87df-85700d6a03d9@gmail.com> <33da31e9-9101-475d-8901-4b6b3df2f29d@gmail.com> <940d959d-151d-68dd-0f13-320ebad0d75b@gmail.com>
 <87606hoflx.fsf@javad.com> <0ac3a3fd-4053-e32e-75ed-8829f22c2e1f@gmail.com> <87a7vss6ax.fsf@javad.com> <f1a960dc-cc5c-e7b0-10b6-39e5516655b3@gmail.com> <ed4d2b30-2dea-740b-6283-973c798f619d@philandanna.no-ip.org> <1298a701-a860-a675-83d7-72f29e14cd2b@talktalk.net>
 <CA+P7+xpgChuvh_vsPktBkOEhF=MjJh1n_3jD0-n4d67j9kYqzw@mail.gmail.com> <ee809701-a6d8-157d-09cd-cebbf2e949ec@gmail.com> <1580e48a-be44-38dd-79af-8a2a31c5712e@talktalk.net> <nycvar.QRO.7.76.6.1803061812090.20700@ZVAVAG-6OXH6DA.rhebcr.pbec.zvpebfbsg.pbz>
 <xmqqzi3k23fu.fsf@gitster-ct.c.googlers.com> <nycvar.QRO.7.76.6.1803070804440.20700@ZVAVAG-6OXH6DA.rhebcr.pbec.zvpebfbsg.pbz> <xmqqh8pr21f3.fsf@gitster-ct.c.googlers.com>
User-Agent: Alpine 2.21.1 (DEB 209 2017-03-23)
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
X-Provags-ID: V03:K0:RUh7BL9ktU30q33pvy+u3J8d8C7AKBz26EB7xJvc6zjUlhE4WeM
 R2eIEZrvjbeYjngnbdYeNSOWmNIq2xT1OuFmoJlooO1W83vjOFTfiNDfOD4WAQHMAMvZbWC
 67FUTfUqk1uO8RuY90ZJzTmqqGxIR8xaml0yOU7vrdaletF80l53+MqGqHYrs1vZS9Kznq8
 qWyoZcseQS6m5Pb7hAJ8g==
X-UI-Out-Filterresults: notjunk:1;V01:K0:NEXY1CrhIEw=:LEuhwQsPwK/j30OzBtxoCh
 +5pIu9lzwPpjT5pls9C0/UKdnef951lg5Mjq69jKFnPXWkzh1qImY+BI2xHfYvrEVgQAuFBDE
 N3r8ynFKHKhFS1521Cf1zOZKU4LTiYwF1o99q2gsozEf5mrDEAfU7Rag9GwV4Oqsets/9w17R
 ojKCyLAg/u4v3lKpoal4YVgLDWwR+AxBynzXd/2toECZO7RWylxflcs7bXBV8XGwR2zwXeinT
 ztDE/k/kdLcCTWGJkSwTnTGI5L6byO8LpDEig/XAhbfgsyYV7gdRyC6PPw6qbsWjzJC3ipnOx
 DezLcWjOKcd8q9KCnm0gsKpNPIi4LRhckJPoR+ZB07ued3Xji+LS+uS4MRRGP0cZYkyOUPdSo
 KE5yz86hvP6j9A4yMPtxoZ0vFWRveMgOFONRd94Uw6OygH1ciJ+Co6g2u9tvGv9ZdHppqYYYJ
 9bMfY+5oPKbRxjIH7tOjq4JB/IghRV+PTQTHRyBsOAXKcxdV+R8f348R2T7fF1sO7gFsaRqyq
 FBUsrQRy4mrzgIAsVH3TkoC9P8tzhouX0b9ypROC9404W4X/MD2rR5FFp3ZUTBFa02x2+QfrP
 bVqTx/FpB6LJ/RxF2WrMd89NZ82TCtykKjwRZh1zO7IJOqkQ5QphY38W4YWwps2YhSmn+EuOO
 yqdXr4UTKZpUAKE9qEPvSTus2/yC1wP2kqNMawYdclExxHCUIcPhTSjy3o+8mnf2xB5iS6Q5X
 QVGg4mu1CyzTtWUuuiRQ2skN0FkpGYxnK79Spn4Qc4BggCFUAxKnIiOsI5Qca6FpRpBGGYA68
 J8WBNtbE4h5zzSCoqAq36ULWVT0yZt23cKxPDOypyHbUQh2wKs=
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Hi Junio,

On Wed, 7 Mar 2018, Junio C Hamano wrote:

> Johannes Schindelin <Johannes.Schindelin@gmx.de> writes:
> 
> >> OK, does this mean we want to wait before merging the "recreate
> >> merge" topic down to 'next'?  For more than a few weeks, it has been
> >> slated for 'next'.
> >
> > Maybe a few more days.
> > ...
> > I want to discuss this in the other subthread, though.
> 
> If we are talking about a drastic change, a few more days may not be
> sufficient, but we are not in a hurry, as this already sounds like a
> 2.18 material anyway.

It is not at all a drastic change. It will actually make the current patch
series better (simplifying the "can we fast-forward?" check).

I just want to make sure that I already have Phillip's strategy working,
but it will be yet another topic branch on top of the topic branch that
will add support for octopus merges *after* the current --recreate-merges
topic branch ;-)

> As you made it clear that it is OK not to merge the current one for now,
> my objective of asking the question is already satisfied ;-)

Depending how much GitMerge will occupy my time, I hope to have something
polished by tomorrow.

Ciao,
Dscho
