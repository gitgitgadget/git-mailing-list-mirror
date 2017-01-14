Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-5.9 required=3.0 tests=AWL,BAYES_00,
	FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,HEADER_FROM_DIFFERENT_DOMAINS,
	RCVD_IN_DNSWL_HI,RP_MATCHES_RCVD shortcircuit=no autolearn=ham
	autolearn_force=no version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 9A2B620798
	for <e@80x24.org>; Sat, 14 Jan 2017 14:58:54 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1751031AbdANO6w (ORCPT <rfc822;e@80x24.org>);
        Sat, 14 Jan 2017 09:58:52 -0500
Received: from mout.web.de ([212.227.17.12]:59481 "EHLO mout.web.de"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1750879AbdANO6v (ORCPT <rfc822;git@vger.kernel.org>);
        Sat, 14 Jan 2017 09:58:51 -0500
Received: from [192.168.178.36] ([79.213.118.247]) by smtp.web.de (mrweb103
 [213.165.67.124]) with ESMTPSA (Nemesis) id 0MbyMU-1cBQto2Ck2-00JLJV; Sat, 14
 Jan 2017 15:58:26 +0100
Subject: Re: [PATCH 2/3] xdiff: -W: include immediately preceding non-empty
 lines in context
To:     Junio C Hamano <gitster@pobox.com>,
        Vegard Nossum <vegard.nossum@oracle.com>
References: <1484324112-17773-1-git-send-email-vegard.nossum@oracle.com>
 <1484324112-17773-2-git-send-email-vegard.nossum@oracle.com>
 <e55dc4dd-768b-8c9b-e3b2-e850d5d521f5@web.de>
 <xmqqeg06hh6z.fsf@gitster.mtv.corp.google.com>
 <c74c260d-1a4d-39f6-a644-4f90a67d6d82@oracle.com>
 <xmqqbmvaecpl.fsf@gitster.mtv.corp.google.com>
Cc:     git@vger.kernel.org
From:   =?UTF-8?Q?Ren=c3=a9_Scharfe?= <l.s.r@web.de>
Message-ID: <48bdfd94-2fd4-bd55-d78b-2877e195fb82@web.de>
Date:   Sat, 14 Jan 2017 15:58:25 +0100
User-Agent: Mozilla/5.0 (Windows NT 10.0; WOW64; rv:45.0) Gecko/20100101
 Thunderbird/45.6.0
MIME-Version: 1.0
In-Reply-To: <xmqqbmvaecpl.fsf@gitster.mtv.corp.google.com>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Transfer-Encoding: 8bit
X-Provags-ID: V03:K0:ZqA0BH+8AZUgtFCFnEKFNgAyOI2CbBGKzvyFu/EBgp4zEei83fd
 7O4Ped1QMNmL0upF1SDFO2iIxVmi4ogrcajZAqEwvWQNtk56s4m1oRZkeTB5JOOE/B3D4M3
 yci+P3cnDTPa+4E2lP2V7izKqW70TesQbxuSNgWssPs0ijSCa1uRlJJh/rzxDhoIS8a8yu7
 lDWH4jTrvOIHBc7/XF3Ag==
X-UI-Out-Filterresults: notjunk:1;V01:K0:KslhNjXehyc=:hoFw+TudTLGQmDWLYZvKzw
 15KK67gSuEFLPQcXvTgkJ0WlnQDYfKiwDGsuI1EerSqqYpqA6bpuQEeUCky77kroC6RMN/nfA
 vlim6meaH2aL5VdlU1KCpvdvmt+C4sc65i8qIjmo66xbPCr82JBcnuJbwsl9P3Oh/NB2ajQsA
 53KVIP3nl14Zz8GS5yRmAKcoqXzXTcZU0S1OT/BqSMCu0FipVm9UJiWD1bzdDw9kjvmJ08dfx
 s1eWfKrOQVUKk9wk49xTtcTBRMtWf5gg2xatAp350upvIIKB58b/bP+C8E1rg2pTkdKJcsUwJ
 5bHqNeRU+wDA6DiskxOVrBZDEu78wv9DAQUKuB48thZo7ZRo05MnCU6z/7DEFvSh/gjqiDA+k
 SmS5lJs2r0nN+AGdli2d4V0XC7EDNramdSgWX77LHbgy4t2DegisVc6YXVrv9xWMTZdY+8yqa
 5g7R68glxtFXmg+21k+y21m6OHb46rHl6Q8YpT6oog1Ys3qLiRpVGHcmVpuvze7RHQ2es2d69
 TZuByTAYPeMyR9zXDuMTJZyGOtLnpZsK2oTGfevGXtkCy4gdAGQVtqe6Nq/revoEy8oE+UCv8
 9LzHhTTWA51a2yo6+XCiYFx97zVTunO8nDO3k6i1Q6FH+GxVHytZTtzAI/uXPA35sLpjomMZn
 4Gee8T/QNljmaXrSOz35nDLfN/BlF938zgHAc15s4EAZzXaG3RYsViVroD9oNzmcnLfHnBoRf
 iRASbquWHjHTxE8x74B3i8nNl0VqZQmmb0wIip9S1E6k6eVkcy9DCB5jUlZM9xZKruFllIc3e
 wq9Yi56
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Am 14.01.2017 um 00:56 schrieb Junio C Hamano:
> Vegard Nossum <vegard.nossum@oracle.com> writes:
>
>> The patch will work as intended and as expected for 95% of the users out
>> there (javadoc, Doxygen, kerneldoc, etc. all have the comment
>> immediately preceding the function) and fixes a very real problem for me
>> (and I expect many others) _today_; for the remaining 5% (who put a
>> blank line between their comment and the start of the function) it will
>> revert back to the current behaviour, so there should be no regression
>> for them.
>
> I notice your 95% are all programming languages, but I am more
> worried about the contents written in non programming languages
> (René gave HTML an an example--there may be other types of contents
> that we programmer types do not deal with every day, but Git users
> depend on).
>
> I am also more focused on keeping the codebase maintainable in good
> health by making sure that we made an effort to find a solution that
> is general-enough before solving a single specific problem you have
> today.  We may end up deciding that a blank-line heuristics gives us
> good enough tradeoff, but I do not want us to make a decision before
> thinking.

How about extending the context upward only up to and excluding a line 
that is either empty *or* a function line?  That would limit the extra 
context to a single function in the worst case.

Reducing context at the bottom with the aim to remove comments for the 
next section is more tricky as it could remove part of the function that 
we'd like to show if we get the boundary wrong.  How bad would it be to 
keep the southern border unchanged?

René

