Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-3.7 required=3.0 tests=BAYES_00,
	FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,RCVD_IN_DNSWL_HI shortcircuit=no autolearn=ham
	autolearn_force=no version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 5B0011F42D
	for <e@80x24.org>; Sat, 19 May 2018 10:05:35 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1752238AbeESKFd (ORCPT <rfc822;e@80x24.org>);
        Sat, 19 May 2018 06:05:33 -0400
Received: from mout.gmx.net ([212.227.15.19]:38207 "EHLO mout.gmx.net"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1752168AbeESKFc (ORCPT <rfc822;git@vger.kernel.org>);
        Sat, 19 May 2018 06:05:32 -0400
Received: from [192.168.178.79] ([91.96.60.5]) by mail.gmx.com (mrgmx001
 [212.227.17.190]) with ESMTPSA (Nemesis) id 0Le64S-1eU63K10Rw-00psSA for
 <git@vger.kernel.org>; Sat, 19 May 2018 12:05:30 +0200
Subject: Re: error(?) in "man git-stash" regarding "--keep-index"
To:     Git Mailing list <git@vger.kernel.org>
References: <alpine.LFD.2.21.1805180534170.6786@localhost.localdomain>
 <CAN0heSrJMFij9xt6RstLD16+2CxJ_HALer4iRL74AZQvH0VWRQ@mail.gmail.com>
 <alpine.LFD.2.21.1805180648020.10270@localhost.localdomain>
 <CAN0heSpVKd=-Dpdk09LVtTd0vC2dLUwg0=hbxhKskM3RencsYA@mail.gmail.com>
 <96486abe-cf13-ef10-7513-2d6c20a9dc1e@gmx.de>
 <alpine.LFD.2.21.1805181141030.10462@localhost.localdomain>
 <CAN0heSq6YLarECVtHiPFNyUMNb-XwLQqTULpB_pSW+JZsCMw0Q@mail.gmail.com>
From:   Sybille Peters <sypets@gmx.de>
Message-ID: <2472f005-4d60-7342-2e59-f60da036f622@gmx.de>
Date:   Sat, 19 May 2018 12:05:29 +0200
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:52.0) Gecko/20100101
 Thunderbird/52.7.0
MIME-Version: 1.0
In-Reply-To: <CAN0heSq6YLarECVtHiPFNyUMNb-XwLQqTULpB_pSW+JZsCMw0Q@mail.gmail.com>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Language: en-US
Content-Transfer-Encoding: 8bit
X-Provags-ID: V03:K1:O88g2sNHeKSqzcUlt1IaQCsAa4mvwgt0gESnodtbzOfGoTJrJy7
 wfRFEy6sKY/Q9y9VKoQDjZ8ydNiGANcdHS1UY2s+rbhEoEM3Sp/Zlgy4gloLx3wguIRicZP
 hP04GmhZLbTKzHAK6pApKcBKtNS9GuNMVButFXQ1vgjfPQoo/B+/jANs56k0KFzgO/0z7QO
 ojqPRVlrg/SlP6htRwH6Q==
X-UI-Out-Filterresults: notjunk:1;V01:K0:/+pT172pAdI=:PV0g2A4l6+Y1Gy04fWpMp6
 B8G6wy7yksP6kkM15QhOeU4RAd9fTSR54gN9Zzf+gjZeLJ8kPKd44gKCoHOnpbRgWrpTeW7cA
 bR+b2VSIYYk+aSYAWrJXGqeIbeBO+zAF1w+JbE4oCO2FAevZsg13dxUof95/4MPgvUboZ41Tb
 dYt6OCU/Y02Cv4/FllKnLHp+kSHNpdUP+QyYReAfDdm1Rmm8SEjkJ8nSV1buRyO7zcGmXj8BU
 eN1nmwOBaD4PpkYd4BxvxlGhjJA8k78zCoc27EURq13dipIf4C48K/c1VpZSnBkiC/ByKCNNI
 4PbGvsqX7OxuVmXqmq4FXoXMmQbGuuLixn1jChCt5oxvetPhEZA5VChR1g8LZgYN/aLBvSO5w
 O90T7rz8sAeCJNkDFHbCGzpiYYVETCnBhFAPwP0TsrtkOlaTtsUKNwtfVOkc3Rro11QvBJt4h
 wznra2KSqIB5fClmgUCaXPPC9qz91YIaVkE/QXjct3scSYPykQnC8NGq1Yj1wAn0Ag9xPSDkx
 KZeb2iEgSI27aWE7JLggIUqr8sE1CdezKvYfpOQ08ftY9N0LYdqT4Ge1pem1ukozPpWsaM9TM
 6H0gL3Dy4d+9qjRjjyc6kWhTPs0nzKO2EWASqdDAmvF4NG+LAnF+FQ56cXuU+6Q+8n5wTzXoB
 AW9nqN8eQht0VcFsOGwJFPBIGfW8LSKT3p7yi2/g7FQuw5YgEPZuZrxCy11Gpu7tPPkHaV8JW
 EY79FVHXTrzaHTuI0NzqOgJQBXpFE5rg9cUz5Me0ly74ABdXFyijQ2haIFpQCSwhOuKWXX8nE
 hHBAr9H
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

On 18.05.2018 19:14, Martin Ågren wrote:
> On 18 May 2018 at 17:43, Robert P. J. Day <rpjday@crashcourse.ca> wrote:

...

> Ah, this is about saving to the stash vs stashing away. The latter is
> what `git stash` is all about -- stashing changes *away*. At least
> according to my mental model and the top of the man-page.

Stashing changes *away* would mean a move in my mental model (as in
command line mv): Whatever gets copied to stash gets removed in working 
area. And what doesn't get removed, doesn't get copied to stash.

Thus, --keep-index *would* ignore the index and only move working-tree
to the stash minus the changes already staged.

BUT, that might lead to other problems, I suppose.

The current behaviour can cause problems as in the Stackoverflow
question where someone already staged some hunks, and on
stashing with -p gets asked about these *again*. Which does make
the workflow more tedious.


> 
> ...
> 
> The work flow in the example is about temporarily stashing a few changes
> (changes B) to test a couple of others (changes A). Whether the stash
> entry contains changes A or not is practically irrelevant to the use
> case. At pop-time, auto-merging will do the correct thing.

Aha, now it gets interesting. So you are saying, it doesn't matter if
the stash entry also contains the already staged changes A? Well in the 
combination with -p it does (see Stackoverflow question and above).

Even if auto-merging will take care of it (?), it would be good to
have the manpage clarify things that might confuse people.

Disclaimer: I am not a git expert, so I may be getting things wrong. I
just noticed the Stackoverflow question, answered it (only because
an adequate answer did not exist yet) and then saw a similar topic
being raised here.

> 
> So how about "All changes are saved to the stash. Those that have been
> added to the index are left intact in the working tree, all others are
> removed from the working tree."? That's quite a lot of text. Maybe
> "save all changes to the stash, make the working tree match the index"?
> 
> Or more to the point: "make the working directory match the index" or
> "keep only what is in the index"?


I am not sure yet about the text. Still in the clarifying phase.

Sybille

> 
> Martin
> 
