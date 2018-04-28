Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-3.4 required=3.0 tests=AWL,BAYES_00,
	FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,RCVD_IN_DNSWL_HI shortcircuit=no autolearn=ham
	autolearn_force=no version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 890181F404
	for <e@80x24.org>; Sat, 28 Apr 2018 11:55:21 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S933420AbeD1LzT (ORCPT <rfc822;e@80x24.org>);
        Sat, 28 Apr 2018 07:55:19 -0400
Received: from mout.gmx.net ([212.227.17.21]:59693 "EHLO mout.gmx.net"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1759899AbeD1LzS (ORCPT <rfc822;git@vger.kernel.org>);
        Sat, 28 Apr 2018 07:55:18 -0400
Received: from [192.168.0.129] ([37.201.195.116]) by mail.gmx.com (mrgmx102
 [212.227.17.168]) with ESMTPSA (Nemesis) id 0MfBsk-1f1u4x3SKg-00Olax; Sat, 28
 Apr 2018 13:55:13 +0200
Date:   Sat, 28 Apr 2018 13:55:13 +0200 (DST)
From:   Johannes Schindelin <Johannes.Schindelin@gmx.de>
X-X-Sender: virtualbox@gitforwindows.org
To:     Derek Foulk <dfoulk@colheli.com>
cc:     "'git@vger.kernel.org'" <git@vger.kernel.org>
Subject: Re: Git Stash Creates sh.exe.stackdump (STATUS_STACK_OVERFLOW)
In-Reply-To: <ec9aec59d4d6497a84431f1abeae147d@mail2.colheli.loc>
Message-ID: <nycvar.QRO.7.76.6.1804281353110.79@tvgsbejvaqbjf.bet>
References: <ec9aec59d4d6497a84431f1abeae147d@mail2.colheli.loc>
User-Agent: Alpine 2.21.1 (DEB 209 2017-03-23)
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
X-Provags-ID: V03:K1:wAr0pcRivRXPf3tKiH2VTNttpRVlF+y3GIaOk/OR1o2DH4myzBX
 wk8tX8iBkk6vgLULxmnUJ/U6YDx5ztHO8DSkg3QhOmZezoiOOGnPf9NM9zEtUMapZgNAXl6
 VOWyYN27v2P0IVJSt+Llhfbo8vqiNd63i188mfi2n2kEcQzt6utzwhbilXsdDt5LfpdcP8v
 mTgjdL3ybKkJM6Dlye1YQ==
X-UI-Out-Filterresults: notjunk:1;V01:K0:BgpwedjN55E=:fJoDZaDWcQ/dqJi4wnxTe5
 O4vE1jnmz6LjQ58x5ENzfR+vmN6ZuIkcU7kKyO5+Ro6WjHN7Q6VaCNE1iB7q9iP0O4bF4BfMn
 VZ6ou7Rpw/AWdnZIUMfBROR5B4c59AmkrwCusWm/AB+MhZhf/BV1CJx/Bns19E2pJPC1LVVcQ
 ezgygpKxKZRK+kNiQo65mAHUDDjxv9dgYfvcLVnDYJYZPEL3VzJ9EyQGpeI2JeTqmwKcB3sTz
 EDwgEdaMqkQfnJrd89Uk0/kEvazqFqS6TRc1D+1myjCHvbNGL4XI7gYxdYWEuFR+KJRrk/bgj
 pRJp0oZgc5VF3gsmClh8u+YEs0L1A2Jy4vYmTXyBSvgLqTmd1QKF/XueGFtrGvxeYsqegpbnR
 SyWtQDTYqkHQiCA4Yv/h+x7vy1rTSfzVjk2C5sfjaW3dBO+PpplAU9HVL8nhQ/FfXQV4EqE7I
 hd0i01LhVbK+RDAGRLNA79eReDz0u9rJQrfYhuTI2rfAZGDPpa78fgkhJcMC7n93M4nOmLTZW
 mb6b25AD+nPFzFP0N3MornN3UfX4qcP2KFDcFhqgPM/wqJhCcOTWPbXpW6ybKpss27gCLbpFn
 tUdFr7eGSM1GGLCsvJA7b8rgB8ZFEvxhnKypiIaXKPEbsmFjH55F1uCpLQxk79fU/dNLxpL1I
 f9VWdiE7iXPQwH3dbVfvRaUJ/8TLv79aO0NlmDRuPodbLe+Z3whVWZSChD9L0t6X+jDRiYhJN
 tXQuQ72rvJknoatqqgOye+P7PAOhc7U1m8a4+lG8c4HhraYP0ZBvwQXnS2Co+cO9gtGfrUyYs
 veSS6y5
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Hi Derek,

On Fri, 16 Feb 2018, Derek Foulk wrote:

> An issue has arisen sometime between 2.16.1.windows.1 and 2.16.1.windows.4 in Git.
> 
> When you execute `git stash` commands (stash/pop/apply?), a sh.exe.stackdump file is generated that contains the following:
> 
> Exception: STATUS_STACK_OVERFLOW at rip=7FFB2C324B97
> rax=0000000000000010 rbx=0000000000000000 rcx=0000000000000010
> rdx=000000000000000C rsi=00000000FFFFAAE0 rdi=00007FFB23B8D4F0
> r8 =00000000FFFFAA18 r9 =00000000FFFFAA50 r10=00000000FFFFA000
> r11=00000000FFE03E70 r12=00000000FFFFB500 r13=000000000015C000
> r14=000000000000014C r15=0000000000000000
> rbp=00000000FFFFAA50 rsp=00000000FFFFAA08
> program=C:\Program Files\Git\usr\bin\sh.exe, pid 41552, thread unknown (0x949C)
> [...]

I saw similar reports on the Git for Windows bug tracker. Probably the
most relevant one is this here:
https://github.com/git-for-windows/git/issues/1562

In essence, the culprit there seems to be an overzealous anti-malware
called Comodo Internet Security. Maybe your setup has the same problem?

Ciao,
Johannes
