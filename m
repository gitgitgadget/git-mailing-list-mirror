Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-3.2 required=3.0 tests=BAYES_00,
	HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_HI,RP_MATCHES_RCVD
	shortcircuit=no autolearn=ham autolearn_force=no version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id ADA4920970
	for <e@80x24.org>; Wed, 12 Apr 2017 05:43:27 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1751115AbdDLFnZ convert rfc822-to-8bit (ORCPT
        <rfc822;e@80x24.org>); Wed, 12 Apr 2017 01:43:25 -0400
Received: from mout.kundenserver.de ([212.227.126.187]:49895 "EHLO
        mout.kundenserver.de" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1750899AbdDLFnY (ORCPT <rfc822;git@vger.kernel.org>);
        Wed, 12 Apr 2017 01:43:24 -0400
Received: from MotoRolla.fritz.box ([188.96.94.86]) by
 mrelayeu.kundenserver.de (mreue003 [212.227.15.167]) with ESMTPSA (Nemesis)
 id 0MfE46-1cjMva2nqE-00Orud; Wed, 12 Apr 2017 07:43:20 +0200
Date:   Wed, 12 Apr 2017 07:43:19 +0200
User-Agent: K-9 Mail for Android
In-Reply-To: <CACBZZX7xqoZ3LboOjwvQvX3JRJFhjFC54+mfLOddLXzconrobw@mail.gmail.com>
References: <CAMLReHYBVmuu5H015N1ShCD0iLNau9oLOabJhQ7xc=58rXQi+Q@mail.gmail.com> <88df8638-9b7b-42c4-bb34-4e1a49d4c22d@grubix.eu> <CAMLReHYbuHmGTtBSUQq3bO=6ghz=rfP-=Eg=PvP0tkwZbM2Q1Q@mail.gmail.com> <CACBZZX7xqoZ3LboOjwvQvX3JRJFhjFC54+mfLOddLXzconrobw@mail.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain;
 charset=utf-8
Content-Transfer-Encoding: 8BIT
Subject: Re: `git status` output is very misleading after a merge on a "detached HEAD"
To:     =?ISO-8859-1?Q?=C6var_Arnfj=F6r=F0_Bjarmason?= <avarab@gmail.com>,
        =?UTF-8?Q?Enis_Bayramo=C4=9Flu?= <enis@picussecurity.com>
CC:     Git Mailing List <git@vger.kernel.org>
From:   Michael J Gruber <git@grubix.eu>
Message-ID: <5704E476-BD11-47D1-A15E-C1E29A1398AD@grubix.eu>
X-Provags-ID: V03:K0:p0HxksCi6Su4rMq7Z3tjUssVousqr+n3wxYJmrIZxu1L2OCBTLh
 6NUbp1fIKO+HgNQ2yS4sjudLhdLXI1eXAmuXbUy1bt7Va5G/waoZfZfJpLzf6SEzen0C/6v
 RCMcQHcrae6k6ckIjSnkMHL5CB51WZUNLda70r0qcxU/IDyJWTxuJ24bsLRMgYMrTcZ/lCA
 wPAurupRHhzgol8XLgXqQ==
X-UI-Out-Filterresults: notjunk:1;V01:K0:58/8fM9BZVM=:ZG/Y+g3XcBb+E813xnIx2U
 m1zgEJ3+70m40t43k+eRyKsz/j8mVGqE1uBrZFrk0QcT44Vt+BTf/0Ly3wSogi+DSTd+wu5jo
 IUdv32BBQJnK8g1ocyJpr2p2R1D3+gSecQNhEybwpJIR2v8dyDwhRhecSUTxdbi9mMsjQAS3m
 WA0reaUbI01d3FV1+sqr8tSGKlf9YptTYSVl/33GhYZUZKOb6o6sydr6IlDYzRQMhy1CrEFO9
 4/ikG/RGAiEyTojRDwKcFuTeoRD+U7b+K2JkOfyPbOG2ck3+f2hrkgVqshVJ6PBGquccet9dg
 YbAYnZff3qW6D6CLuLPsD2uyvbYNZ7tzH4MFFRYptQIzxBlWA+uwhWhW62jIuo5Qz/k4rw+lS
 tbu80aUyMnKzt+faut1MbKc8B8RICM78t5d5HXapddATCU2FBzKQ/9jTPiIQE9a/c3KHXVIjH
 3DE73IKBFDenRQ9bWf1mCyHo2Pd7bE3l+AQE/lCB1N6xfoSoHvQ+5idu00nCvyT/ssxm25hiP
 5eHx/iAgV4KkE8haAKGEOryrr6DajqaJgf0r3kQ8t+jbfXAHBI1lfm+hzFYObWmohuGW+0Gwy
 0PdbXWjb1hsu3HN8bRn1DBtiH4xhcj5xGkrkxAFxsQ2foLOIeBN8ClYQzDciHq6Zz7iiIyf0G
 pjgFT73VIePyXELN25oE4TntOTzvP/4zIfC068MVNrZuvV6TAC9jXyR6BNWGJtlzWcXp2Tajc
 MlaVH0S8+3+WUneb
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Am 11. April 2017 22:40:14 MESZ schrieb "Ævar Arnfjörð Bjarmason" <avarab@gmail.com>:
>On Tue, Apr 11, 2017 at 5:13 PM, Enis Bayramoğlu
><enis@picussecurity.com> wrote:
>>> Well, what do you suggest as an alternative?
>>>
>>> Git tells you that you are in detached state and where you came from
>>> (detached from).
>>
>> I think it'd be best if git status somehow indicated that you're no
>> longer at the same commit. Maybe something like:
>>
>> $ git status
>> HEAD detached from origin/master, no longer at the same commit
>> nothing to commit, working directory clean
>
>I'm not saying this is clear, I didn't know this until I read the code
>just now, but for what it's worth it says "detached at" if you're
>detached from BRANCH but at the same commit, and "detached from" if
>you're now on a different commit.
>

That's what I explained in my first reply which the OP quoted in a chopped way.  I think he even misquoted the git output he got. 

It's the difference between from and at. 


>> or, to be more informative
>>
>> HEAD detached from origin/master 1 commit ago,
>
>In lieu of that, which would need some of the rev-list machinery to be
>invoked on every git-status, I wonder if just saying "HEAD detached &
>diverged from origin/master" wouldn't be clearer:
>
>diff --git a/wt-status.c b/wt-status.c
>index 308cf3779e..79c8cfd1cf 100644
>--- a/wt-status.c
>+++ b/wt-status.c
>@@ -1542,7 +1542,7 @@ static void wt_longstatus_print(struct wt_status
>*s)
>                                if (state.detached_at)
>                                      on_what = _("HEAD detached at ");
>                                else
>-                                       on_what = _("HEAD detached from
>");
>+                                       on_what = _("HEAD detached &
>diverged from ");
>                        } else {
>                                branch_name = "";
>                           on_what = _("Not currently on any branch.");
>
>
>

No way. That would reduce the information that we give. 

Note that the difference between from and at is also: are there commits that we could lose when we switch away, that is: that git checkout would warn us about? 

Maybe improve the doc instead? 

>
>> On Tue, Apr 11, 2017 at 5:55 PM, Michael J Gruber <git@grubix.eu>
>wrote:
>>> Enis Bayramoğlu venit, vidit, dixit 11.04.2017 10:57:
>>>> I've encountered a very misleading output from `git status`. Here's
>a
>>>> sequence of events that demonstrates the issue:
>>>>
>>>> $ git --version
>>>> git version 2.12.0
>>>>
>>>> $ git checkout origin/master
>>>>
>>>> $ git status
>>>> HEAD detached from origin/master
>>>> nothing to commit, working directory clean
>>>
>>> Hmm. My Git would display "detached at" here as long as you are on
>the
>>> commit that you detached from.
>>>
>>>> $ git merge --ff f3515b749be861b57fc70c2341c1234eeb0d5b87
>>>>
>>>> $ git status
>>>> HEAD detached from origin/master
>>>> nothing to commit, working directory clean
>>>>
>>>> $ git rev-parse origin/master
>>>> e1dc1baaadee0f1aef2d5c45d068306025d11f67
>>>>
>>>> $ git rev-parse HEAD
>>>> 786cb6dd09897e0950a2bdc971f0665a059efd33
>>>>
>>>> I think it's extremely misleading that `git status` simply reports
>>>> "HEAD detached from origin/master" while this simply happens to be
>a
>>>> mildly relevant fact about some past state.
>>>>
>>>> Thanks and regards
>>>>
>>>
>>> Well, what do you suggest as an alternative?
>>>
>>> Git tells you that you are in detached state and where you came from
>>> (detached from).
>>>
>>> Michael

