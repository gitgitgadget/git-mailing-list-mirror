Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-3.1 required=3.0 tests=AWL,BAYES_00,
	HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_HI,RP_MATCHES_RCVD
	shortcircuit=no autolearn=ham autolearn_force=no version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 435EC1FA14
	for <e@80x24.org>; Wed, 12 Apr 2017 13:11:59 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1754116AbdDLNL4 (ORCPT <rfc822;e@80x24.org>);
        Wed, 12 Apr 2017 09:11:56 -0400
Received: from mout.kundenserver.de ([212.227.126.187]:53259 "EHLO
        mout.kundenserver.de" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1752224AbdDLNLy (ORCPT <rfc822;git@vger.kernel.org>);
        Wed, 12 Apr 2017 09:11:54 -0400
Received: from skimbleshanks.math.uni-hannover.de ([130.75.46.4]) by
 mrelayeu.kundenserver.de (mreue002 [212.227.15.167]) with ESMTPSA (Nemesis)
 id 0MeGdC-1chKVE3e7a-00PrHi; Wed, 12 Apr 2017 15:11:50 +0200
Subject: Re: `git status` output is very misleading after a merge on a
 "detached HEAD"
To:     =?UTF-8?B?w4Z2YXIgQXJuZmrDtnLDsCBCamFybWFzb24=?= <avarab@gmail.com>
References: <CAMLReHYBVmuu5H015N1ShCD0iLNau9oLOabJhQ7xc=58rXQi+Q@mail.gmail.com>
 <88df8638-9b7b-42c4-bb34-4e1a49d4c22d@grubix.eu>
 <CAMLReHYbuHmGTtBSUQq3bO=6ghz=rfP-=Eg=PvP0tkwZbM2Q1Q@mail.gmail.com>
 <CACBZZX7xqoZ3LboOjwvQvX3JRJFhjFC54+mfLOddLXzconrobw@mail.gmail.com>
 <5704E476-BD11-47D1-A15E-C1E29A1398AD@grubix.eu>
 <CACBZZX4W1kk2cnncWz1EVjA-WtFryYzNoiiDHR9+9VC4AKJhKg@mail.gmail.com>
Cc:     =?UTF-8?Q?Enis_Bayramo=c4=9flu?= <enis@picussecurity.com>,
        Git Mailing List <git@vger.kernel.org>
From:   Michael J Gruber <git@grubix.eu>
Message-ID: <61ef36d9-7f25-80d6-5216-554684bd54dd@grubix.eu>
Date:   Wed, 12 Apr 2017 15:11:50 +0200
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:45.0) Gecko/20100101
 Thunderbird/45.8.0
MIME-Version: 1.0
In-Reply-To: <CACBZZX4W1kk2cnncWz1EVjA-WtFryYzNoiiDHR9+9VC4AKJhKg@mail.gmail.com>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: 8bit
X-Provags-ID: V03:K0:Kx9JrpN3SUBbS7Psb8n47FwCyo0BDJtejbQML82HuL850CfXqTM
 IyVqCaRNwt+C01lC6LWi57jMegLDDNZWSyZH287sg4hTK3tgVBzg4SLx8RK19I66PvxX1s4
 fidjKLXE9YqJWnTnAra1kUgoK25WbQxmW6gfjw9PzUHiW9tK0a21w4hGoG7DQ9aDdYEvCzP
 sviFAxrBNuf7lc2jWS5OA==
X-UI-Out-Filterresults: notjunk:1;V01:K0:08ZT1UAjyaM=:EBZcid3Q2TLIjXH/R91MXY
 nqZuN2G8Rt9Ep9EFcJWeWJAvCLtM6pVLyURJdWFE6TwTpUDfdy4JYmVvn82H93zgZGnEKIP6Z
 YER/M8CK3nkBm9BimhlNUCkGC4+guIGAhyj8MOvr58I+ud6TQ2uDfrWdaP+1VSsuoxRzcKdnm
 RWsFHHV9aaqAirByelFYArE6jx7J6rtz4AAVQyyXndeYxtMZX8XvpAPFtcs5OaluzKMAP4b44
 zNkRN+/K+1oKC2F2RQHaA2G41xXsRd0tAjZyBR3x+/npUQj7aysN2e4x+vKM2F+bQdRKQgHTL
 70ZZZwWNB/6vddeRE0SyIiQNU+H3Csr6eYhaYD3FJ9vTQCMiqQhW+4abrw1UhPcJHlrQzUSn5
 G8gyVuZz8MUMCdwGhdgRne1BnuSTxrXKpgHzd2vG94ajNjo9AfUyI2MyJDhywZlHwNkYpLDoa
 0kuUUkbaoPvAStSKcW9msDx9skSt9Bb1AamCaMmThGc/CR/uo7k6KrtcbEY+GqH59tv9XBw90
 wyDlfc3XEJZZRZHGOoZe9/EuNAj2B79Q87eeNK6nFnTZujvPdYtH4mbII6LWIXNaVSgBeE91s
 WIV5d4jbq/9NN7aFKNfpLPak5EZeZLxUx119GrHIKL0tclMa1/7/nXV85MdItWfr0DRjO+8pJ
 HyEgUuKPMEVayihKaxzGzcuXaKyxMvLLid1O3TNFNOZfYWdgedjHSLvG8sKlwmDGFQ4Nf/0Kd
 T3hcUJR+1cFhCIKN
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Ævar Arnfjörð Bjarmason venit, vidit, dixit 12.04.2017 14:18:
> On Wed, Apr 12, 2017 at 7:43 AM, Michael J Gruber <git@grubix.eu> wrote:
>> Am 11. April 2017 22:40:14 MESZ schrieb "Ævar Arnfjörð Bjarmason" <avarab@gmail.com>:
>>> On Tue, Apr 11, 2017 at 5:13 PM, Enis Bayramoğlu
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
> 
> How does it reduce the information we give? Maybe I've missed
> something about what "from" means here, as opposed to "at", but it
> seems to me to mean the same thing as "diverged" by definition, i.e.
> we detached from the branch but we diverged from it.

No, "at" means we're still at that commit - detached but not diverged.
"from" means we only started from that commit, but are not at it any more.

> Saying "diverged"
> just makes it clearer, how does it reduce the information we give?

I misread your patch on my mobile phone, sorry. I thought you meant to
replace both "at" and "from" by "diverged from" because you considered
them synonymous.

But your patch touches just the" from" case and emphasizes the "diverge"
aspect, which is fine, of course.

>> Note that the difference between from and at is also: are there commits that we could lose when we switch away, that is: that git checkout would warn us about?
> 
> Right, but I don't see how that's in any way conflicting or mutually
> exclusive with saying before hand that we've diverged from the branch.
> 
>> Maybe improve the doc instead?
> 
> Aside from whether my patch makes any sense, the solution to a UX
> issue really can't be "oh this just needs to be documented". For every
> user who's confused by some interface we provide a *tiny* minority of
> them go and exhaustively read the docs for an explanation, will just
> remain confused.
> 
> I think saying from v.s. at is way too subtle, I for one have been
> missing it for years until this thread, that's bad UX, git's also used
> by a lot of non-native English speakers who may not at all get the
> subtle difference between at and from in this context, or if they do
> think the UI is using that subtlety to tell them something.

Well, we have to find the right balance between clarity and brevity - an
interface that is too chatty is a nightmare. That's why I suggested both
doc changes and additional information.

What do you think about the ahead/behind info as suggested? That should
be more informative both qualitatively (something diverged) and
quantitatively (by how much).

Michael
