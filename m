Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-2.9 required=3.0 tests=AWL,BAYES_00,
	HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_HI,RCVD_IN_SORBS_SPAM,
	RP_MATCHES_RCVD shortcircuit=no autolearn=no autolearn_force=no version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 58B8D20960
	for <e@80x24.org>; Wed, 12 Apr 2017 11:36:26 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1752224AbdDLLgY (ORCPT <rfc822;e@80x24.org>);
        Wed, 12 Apr 2017 07:36:24 -0400
Received: from mout.kundenserver.de ([212.227.126.134]:56801 "EHLO
        mout.kundenserver.de" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1752016AbdDLLgX (ORCPT <rfc822;git@vger.kernel.org>);
        Wed, 12 Apr 2017 07:36:23 -0400
Received: from skimbleshanks.math.uni-hannover.de ([130.75.46.4]) by
 mrelayeu.kundenserver.de (mreue005 [212.227.15.167]) with ESMTPSA (Nemesis)
 id 0MC5PI-1cpV7z1OS0-008qxi; Wed, 12 Apr 2017 13:36:19 +0200
Subject: Re: `git status` output is very misleading after a merge on a
 "detached HEAD"
To:     =?UTF-8?Q?Enis_Bayramo=c4=9flu?= <enis@picussecurity.com>
References: <CAMLReHYBVmuu5H015N1ShCD0iLNau9oLOabJhQ7xc=58rXQi+Q@mail.gmail.com>
 <88df8638-9b7b-42c4-bb34-4e1a49d4c22d@grubix.eu>
 <CAMLReHYbuHmGTtBSUQq3bO=6ghz=rfP-=Eg=PvP0tkwZbM2Q1Q@mail.gmail.com>
 <CACBZZX7xqoZ3LboOjwvQvX3JRJFhjFC54+mfLOddLXzconrobw@mail.gmail.com>
 <5704E476-BD11-47D1-A15E-C1E29A1398AD@grubix.eu>
 <CAMLReHa2M=h+cWm_9qqiL0n+E1+AFzHXqiBG45fGiGUBTdkseg@mail.gmail.com>
Cc:     =?UTF-8?B?w4Z2YXIgQXJuZmrDtnLDsCBCamFybWFzb24=?= <avarab@gmail.com>,
        Git Mailing List <git@vger.kernel.org>
From:   Michael J Gruber <git@grubix.eu>
Message-ID: <4d5f14ff-a886-bdca-126b-0261c4d33de1@grubix.eu>
Date:   Wed, 12 Apr 2017 13:36:19 +0200
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:45.0) Gecko/20100101
 Thunderbird/45.8.0
MIME-Version: 1.0
In-Reply-To: <CAMLReHa2M=h+cWm_9qqiL0n+E1+AFzHXqiBG45fGiGUBTdkseg@mail.gmail.com>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: 8bit
X-Provags-ID: V03:K0:JxZrrliPstRNijSNQS1F3tgGkKY45/eFH3PJbjZWUp35LNrsjWw
 dEhPzoVQ1TkG+u5QEc44F6EUgJnG9xKfKbcv5wYnxqJtOnXRsg7/1/QwBpBAagbzrXe+9Su
 Mxj0qx/hs3HreVSMNVOCcdAt5Nc0knlY2Al+c9+DIjMY1o54WzFHjFgHXhuXKC3JtoqZlED
 P+EPbDu4+814899N1khVA==
X-UI-Out-Filterresults: notjunk:1;V01:K0:f1nTpVNf+D4=:aMeJWPZQqsRVSOG5sJI2X8
 fdGEM6JPSCedP/11+opeVwJPUszK0WSdrIUFiL+B//E/VJb7jWE9GYp+4qssQA3ve4lKe/sEO
 vLvNLCXaxmA/c5D6l7oGrhHz/MN2TdE9+GUKP/TmAtZqRg3t6vge3legV1A9H3jbOi1kMxVd9
 jhJNchP2LUam+b4J5tWdn/S1uV3P+bo52RnZvwmwiYg5AXUBaErWL78qLtDhCHaaWDgi3bdDH
 f9ZqU1oKUdeYauwcLdO2ne5FBX7MBFLLR5+lVBvWyYZ42XjyV1C3ePlqcgDnm3HN/sEiqh9/9
 GQrypD+3MCRAXyUgccv3LHdUuFaxY0WNnHdyh97IMZf9y13nzlR+Z9ReBk4kNKaDUQNEXmu+9
 NJexChqRL1biLp2SfRwzq/wpx9mL8pPBCREeUmoA/zDylAyLxDPB008CQETFfhKVHDbJ4MunQ
 Bub7vUB9ZHfjHPpnZTLSixur6mQ6Wyo/7TWgys80s8Uiosi6zsXVK6MN8NNb3S2A2PFlzUNwT
 o4MoYhs9BNE5NeCThaiFFkte6w/X2aKubiqG+SiXXCFiP19PFzez94VIG2uyEr1AaH28P3X7p
 pngMy/UprSfY8APJb5NESZxg39oQi3zIuSOzTNSvZhV3a7kfOU96nhOGqM6e79IDo/i4uZMaZ
 UYnnPnMGcfx/b4QZ1D/of9iqZLwpVhxtRCYzweBZR++G7JU5J9jzR/a1Bfg+YLTL750ZBnZgA
 FZxY3ojsWbjpRkXz
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Enis Bayramoğlu venit, vidit, dixit 12.04.2017 08:15:
> On Wed, Apr 12, 2017 at 8:43 AM, Michael J Gruber <git@grubix.eu> wrote:
>> Am 11. April 2017 22:40:14 MESZ schrieb "Ævar Arnfjörð Bjarmason" <avarab@gmail.com>:
>>> On Tue, Apr 11, 2017 at 5:13 PM, Enis Bayramoğlu
>>> <enis@picussecurity.com> wrote:
>>>>> Well, what do you suggest as an alternative?
>>>>>
>>>>> Git tells you that you are in detached state and where you came from
>>>>> (detached from).
>>>>
>>>> I think it'd be best if git status somehow indicated that you're no
>>>> longer at the same commit. Maybe something like:
>>>>
>>>> $ git status
>>>> HEAD detached from origin/master, no longer at the same commit
>>>> nothing to commit, working directory clean
>>>
>>> I'm not saying this is clear, I didn't know this until I read the code
>>> just now, but for what it's worth it says "detached at" if you're
>>> detached from BRANCH but at the same commit, and "detached from" if
>>> you're now on a different commit.
>>>
>>
>> That's what I explained in my first reply which the OP quoted in a chopped way.  I think he even misquoted the git output he got.
>>
>> It's the difference between from and at.
> 
> You're right, I hadn't noticed the difference, I really thought I
> copied the git output verbatim from the console, but I must've been
> confused while switching windows. Sorry about that.
> 
> I consider myself fairly fluent in English, but it's not my native
> language. If you think head detached "from" vs. "at" is immediately
> and unambiguously clear about what's going on, then I guess it's not
> worth changing the behavior.

I don't mind trying to make this clearer (which is why I asked for
alternatives), I just don't want to reduce the amount of information.
The man pages mentions neither "from" nor "at", so that would be a
starting point.

In fact, I think that "git status [--short]" lacks some of the
information that you only get from, e.g., the git prompt or from "git
checkout" after you switch away. I've set out to amend "git status" with
"in-progress information" (bisecting etc.) in a different thread.

Now for the detached HEAD, I see two variants:

"git branch --list -vv" displays information such as "[origin/next:
ahead 2, behind 3]" for a branch that has diverged from its upstream
"origin/next", and whose upstream has new commits. Mimicking that, git
status could display

HEAD detached from origin/next [ahead 2, behind 3]

either by default or with an extra flag. This requires a "git rev-list
--count --left-right origin/next...HEAD", which is not too bad. The
behind info might be superfluous, but maybe keeping it similar to "git
branch" is beneficial, maybe even more similar:

HEAD detached [from origin/next: ahead 2, behind 3]

"git checkout somewhereElse" display information such as "Warning: you
are leaving 2 commits behind, not connected to any of your branches" and
lists them (the first up to 4). Mimicking that, git status could display

HEAD detached from origin/next [2 orphans]

but this takes more time to compute, especially when you have a lot of
branches. It's the more relevant information in the sense that it counts
those commits that you would loose (once pruned from the reflog) unless
you bind a ref to them or a child commit.

>>
>>
>>>> or, to be more informative
>>>>
>>>> HEAD detached from origin/master 1 commit ago,
>>>
>>> In lieu of that, which would need some of the rev-list machinery to be
>>> invoked on every git-status, I wonder if just saying "HEAD detached &
>>> diverged from origin/master" wouldn't be clearer:
>>>
>>> diff --git a/wt-status.c b/wt-status.c
>>> index 308cf3779e..79c8cfd1cf 100644
>>> --- a/wt-status.c
>>> +++ b/wt-status.c
>>> @@ -1542,7 +1542,7 @@ static void wt_longstatus_print(struct wt_status
>>> *s)
>>>                                if (state.detached_at)
>>>                                      on_what = _("HEAD detached at ");
>>>                                else
>>> -                                       on_what = _("HEAD detached from
>>> ");
>>> +                                       on_what = _("HEAD detached &
>>> diverged from ");
>>>                        } else {
>>>                                branch_name = "";
>>>                           on_what = _("Not currently on any branch.");
>>>
>>>
>>>
>>
>> No way. That would reduce the information that we give.
>>
>> Note that the difference between from and at is also: are there commits that we could lose when we switch away, that is: that git checkout would warn us about?
>>
>> Maybe improve the doc instead?
>>
>>>
>>>> On Tue, Apr 11, 2017 at 5:55 PM, Michael J Gruber <git@grubix.eu>
>>> wrote:
>>>>> Enis Bayramoğlu venit, vidit, dixit 11.04.2017 10:57:
>>>>>> I've encountered a very misleading output from `git status`. Here's
>>> a
>>>>>> sequence of events that demonstrates the issue:
>>>>>>
>>>>>> $ git --version
>>>>>> git version 2.12.0
>>>>>>
>>>>>> $ git checkout origin/master
>>>>>>
>>>>>> $ git status
>>>>>> HEAD detached from origin/master
>>>>>> nothing to commit, working directory clean
>>>>>
>>>>> Hmm. My Git would display "detached at" here as long as you are on
>>> the
>>>>> commit that you detached from.
>>>>>
>>>>>> $ git merge --ff f3515b749be861b57fc70c2341c1234eeb0d5b87
>>>>>>
>>>>>> $ git status
>>>>>> HEAD detached from origin/master
>>>>>> nothing to commit, working directory clean
>>>>>>
>>>>>> $ git rev-parse origin/master
>>>>>> e1dc1baaadee0f1aef2d5c45d068306025d11f67
>>>>>>
>>>>>> $ git rev-parse HEAD
>>>>>> 786cb6dd09897e0950a2bdc971f0665a059efd33
>>>>>>
>>>>>> I think it's extremely misleading that `git status` simply reports
>>>>>> "HEAD detached from origin/master" while this simply happens to be
>>> a
>>>>>> mildly relevant fact about some past state.
>>>>>>
>>>>>> Thanks and regards
>>>>>>
>>>>>
>>>>> Well, what do you suggest as an alternative?
>>>>>
>>>>> Git tells you that you are in detached state and where you came from
>>>>> (detached from).
>>>>>
>>>>> Michael
>>
> 
> Thanks,
> Enis
> 
