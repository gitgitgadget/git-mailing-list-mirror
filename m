Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-3.2 required=3.0 tests=AWL,BAYES_00,
	FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,RCVD_IN_DNSWL_HI shortcircuit=no autolearn=ham
	autolearn_force=no version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 4B6D11F404
	for <e@80x24.org>; Sat, 14 Apr 2018 13:11:36 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1751054AbeDNNLe (ORCPT <rfc822;e@80x24.org>);
        Sat, 14 Apr 2018 09:11:34 -0400
Received: from mout.gmx.net ([212.227.17.22]:49581 "EHLO mout.gmx.net"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1750914AbeDNNLd (ORCPT <rfc822;git@vger.kernel.org>);
        Sat, 14 Apr 2018 09:11:33 -0400
Received: from [192.168.0.129] ([37.201.203.18]) by mail.gmx.com (mrgmx102
 [212.227.17.168]) with ESMTPSA (Nemesis) id 0MMYZG-1f6ksJ1BfC-008N6f; Sat, 14
 Apr 2018 15:11:29 +0200
Date:   Sat, 14 Apr 2018 15:11:28 +0200 (DST)
From:   Johannes Schindelin <Johannes.Schindelin@gmx.de>
X-X-Sender: virtualbox@MININT-6BKU6QN.europe.corp.microsoft.com
To:     phillip.wood@dunelm.org.uk
cc:     Johannes Sixt <j6t@kdbg.org>,
        Git Mailing List <git@vger.kernel.org>
Subject: Re: Bug: rebase -i creates committer time inversions on 'reword'
In-Reply-To: <f56b84fa-9286-3a7b-fc5b-2307c9ff5b5e@philandanna.no-ip.org>
Message-ID: <nycvar.QRO.7.76.6.1804141444060.234@ZVAVAG-6OXH6DA.rhebcr.pbec.zvpebfbsg.pbz>
References: <5f5d5b88-b3ac-ed4f-ee24-6ce2cba2bd55@kdbg.org> <f56b84fa-9286-3a7b-fc5b-2307c9ff5b5e@philandanna.no-ip.org>
User-Agent: Alpine 2.21.1 (DEB 209 2017-03-23)
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
X-Provags-ID: V03:K1:MUIV/Neo8PEu4q0NxGyA1/nnpX+gZFJcRbg9SlpO7McSR9Zs/kt
 c7KriHJcLGX8Mr8I8fPA+xBxgB2FndqcByQcrxTilFmnLcHpF3Qitfzxgyf3Y8apMpZR2E0
 OlNmxaZTucpWFhQdCSQaRllcMFhr3U7oRWHMkpgnvKzAn7YestSXOt4GYqpNVmx+oVabDYN
 6zI5tAut4CPG3ym+8rcyA==
X-UI-Out-Filterresults: notjunk:1;V01:K0:8LzTQhCiIbE=:DmX4//FDMVwMJqHmC2Tezv
 6U9GySXOdlVcCTxUC8e91Awvza1yxEkUYK6lswOngp+h9ik3Ys7/uF9T4ovmoksskoVpJya7y
 yby6xz64o8Ae7XdAJ2yQ9s6SHgzMZV7CHK0fOsakvm0ciwhnx9DxRdseXar9q7HE3CmL+KmGj
 Q9/mDwVhTr4efZ/Owc+5w/aDOPiQ/sxwOjHGfZ70boqOdjMKi5JmuHBkGBEiF0JmPRTjMMYqK
 aoH0O2qUWbWBirfg7LDJTY5t3DzvsOR0/QU8NRS5U+6FRWdXCsXdh6Xu9zwVNR0t+QFhJ88ta
 YWdhsEI2+zPBYoKjPd8h/GFQuHcT6N2BeWj8rUPgUpxMvSuGOoY458PHFkUAX2Vd9ihorsm+F
 DQo6Hsffp136xJeZbwhzr50GOZSNcPjo4qIixm4k0DDcLlFRRf3Ad8V3DM5xoZd1tStuIVu8N
 Ivc1qy/XZKb8omt5YRBD2nZmu0qBP0gCTLrP1ghj0P7fwgFxiA74OlOpwjvsUsQ3WGSwWxPCB
 ca3sNgtqiVIUdixBuzYycGEy8TBFEpoZCf4qFxjII5tDh67l2Q5niyNuVLYz5d//521YdWZLd
 njgvhAOKA2bq4FPNcy9NTnyrbZWt0tO1/7apcN/vNv6aTc2oc1bEdGoyw8ZWpvepT+p9FRajK
 C/XvLkpLewWetCSq+puvfiG5AG1xHb6ht2tPnF8spwueVJqbvRfgyTuHNd2y5P8zRPJWD6O9e
 4MrpGe1FE/DBzuB7IJHIgpQvcVggT7qZbe1ekR4hO0kvwwTeF6USvadKUNEkVQ1Z/6DhUdkz+
 aiXhPhNQXYpPALHZEjh6A/XH1cs7GNTXftgAVjArQtmzKmbLWc=
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Hi,

On Sat, 14 Apr 2018, Phillip Wood wrote:

> On 13/04/18 17:52, Johannes Sixt wrote:
> > 
> > I just noticed that all commits in a 70-commit branch have the same
> > committer timestamp. This is very unusual on Windows, where rebase -i of
> > such a long branch takes more than one second (but not more than 3 or
> > so thanks to the builtin nature of the command!).
> > 
> > And, in fact, if you mark some commits with 'reword' to delay the quick
> > processing of the patches, then the reworded commits have later time
> > stamps, but subsequent not reworded commits receive the earlier time
> > stamp. This is clearly not intended.
> 
> Oh dear, I think this is probably due to my series making rebase commit
> in-process when the commit message isn't being edited. I didn't realize
> that git cached the commit date rather than using the current time when
> calling commit_tree_extended(). I'll take a look at it next week.

Thanks.

However, a quick lock at `git log @{u}.. --format=%ct` in my
`sequencer-shears` branch thicket (which I rebase frequently on top of
upstream's `master` using the last known-good `rebase-merges` sub-branch)
shows that the commits have different-enough commit timestamps. (It is
satisfying to see that multiple commits were made during the same second,
of course.)

So while I cannot find anything in the code that disagrees with Hannes'
assessment, it looks on the surface as if I did not encounter the bug
here.

Curious.

FWIW I agree with Hannes' patch.

> I think 'git am' probably gives all patches the same commit time as well
> if the commit date is cached though it wont suffer from the time-travel
> problem.

I thought that `git am` was the subject of such a complaint recently, but
I thought that had been resolved? Apparently I misremember...

Ciao,
Dscho
