Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-4.1 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_HI,RP_MATCHES_RCVD,
	STOX_REPLY_TYPE shortcircuit=no autolearn=ham autolearn_force=no version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 162DF20970
	for <e@80x24.org>; Fri, 14 Apr 2017 16:32:26 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1751654AbdDNQcY (ORCPT <rfc822;e@80x24.org>);
        Fri, 14 Apr 2017 12:32:24 -0400
Received: from a1i216.smtp2go.com ([43.228.184.216]:39831 "EHLO
        a1i216.smtp2go.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1751147AbdDNQcX (ORCPT <rfc822;git@vger.kernel.org>);
        Fri, 14 Apr 2017 12:32:23 -0400
X-Greylist: delayed 338 seconds by postgrey-1.27 at vger.kernel.org; Fri, 14 Apr 2017 12:32:22 EDT
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=smtpcorp.com; s=a0-2; h=Feedback-ID:X-Smtpcorp-Track:Date:Subject:To:From:
        Reply-To:Message-ID:List-Unsubscribe;
        bh=vkNJoZpmUbdtin2ZnLzctqSHy9C5TSKCdOSshujf1K0=; b=erwat1HKn9J4sPNlDysngr0oNs
        nA7NW0O7jlbZIDd+x8ryHTiOmyDSXTRq/8CIPXc6Qvcvj8paHgg+iX/bQawaGHLj7sQYZcg2S1J6a
        5o8Ufd4lGtGcJRAStZkel9UeLRBBbQTggTIs1H7v0zwBTBHYHmxa+AU+/U15YV+gnHKJlITFoYL7d
        540s9/fpZ1Lkp9GC0A7xnOUIgIva/jFQXF6u2RCvlpyipWTRvOYeE2rL8/vA1SuKK1vIlgv55+unC
        2ksQamw7MoVluujY7U8mkpJ/wk8U8kbdUDwf3uiJAWTdAvjnha9r0ag9OBt/5n3W+b8rJKx+niA9M
        DDwR5XnA==;
Message-ID: <D20C812A0278459095443B62002359A7@PhilipOakley>
Reply-To: "Philip Oakley" <philipoakley@iee.org>
From:   "Philip Oakley" <philipoakley@iee.org>
To:     =?UTF-8?Q?=C3=86var_Arnfj=C3=B6r=C3=B0_Bjarmason?= 
        <avarab@gmail.com>, "Michael J Gruber" <git@grubix.eu>
Cc:     =?UTF-8?Q?Enis_Bayramo=C4=9Flu?= <enis@picussecurity.com>,
        "Git Mailing List" <git@vger.kernel.org>
References: <CAMLReHYBVmuu5H015N1ShCD0iLNau9oLOabJhQ7xc=58rXQi+Q@mail.gmail.com> <88df8638-9b7b-42c4-bb34-4e1a49d4c22d@grubix.eu> <CAMLReHYbuHmGTtBSUQq3bO=6ghz=rfP-=Eg=PvP0tkwZbM2Q1Q@mail.gmail.com> <CACBZZX7xqoZ3LboOjwvQvX3JRJFhjFC54+mfLOddLXzconrobw@mail.gmail.com> <5704E476-BD11-47D1-A15E-C1E29A1398AD@grubix.eu> <CACBZZX4W1kk2cnncWz1EVjA-WtFryYzNoiiDHR9+9VC4AKJhKg@mail.gmail.com> <61ef36d9-7f25-80d6-5216-554684bd54dd@grubix.eu>
Subject: Re: `git status` output is very misleading after a merge on a "detached HEAD"
Date:   Fri, 14 Apr 2017 17:25:28 +0100
Organization: OPDS
MIME-Version: 1.0
Content-Type: text/plain;
        format=flowed;
        charset="UTF-8";
        reply-type=original
Content-Transfer-Encoding: 8bit
X-Priority: 3
X-MSMail-Priority: Normal
X-Mailer: Microsoft Outlook Express 6.00.2900.5931
X-MimeOLE: Produced By Microsoft MimeOLE V6.00.2900.6157
X-Smtpcorp-Track: 1cz43eDIIcx7JF.8NgB_PdNW
Feedback-ID: 66524m:66524aMf6O2Y:66524sHQpU73K_-:SMTPCORP
X-Report-Abuse: Please forward a copy of this message, including all
 headers, to <abuse@smtp2go.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

- a bit late in providing a comment..

From: "Michael J Gruber" <git@grubix.eu>
> Ævar Arnfjörð Bjarmason venit, vidit, dixit 12.04.2017 14:18:
>> On Wed, Apr 12, 2017 at 7:43 AM, Michael J Gruber <git@grubix.eu> wrote:
>>> Am 11. April 2017 22:40:14 MESZ schrieb "Ævar Arnfjörð Bjarmason"
>>> <avarab@gmail.com>:
>>>> On Tue, Apr 11, 2017 at 5:13 PM, Enis Bayramoğlu
>>>>> HEAD detached from origin/master 1 commit ago,
>>>>
>>>> In lieu of that, which would need some of the rev-list machinery to be
>>>> invoked on every git-status, I wonder if just saying "HEAD detached &
>>>> diverged from origin/master" wouldn't be clearer:
>>>>
>>>> diff --git a/wt-status.c b/wt-status.c
>>>> index 308cf3779e..79c8cfd1cf 100644
>>>> --- a/wt-status.c
>>>> +++ b/wt-status.c
>>>> @@ -1542,7 +1542,7 @@ static void wt_longstatus_print(struct wt_status
>>>> *s)
>>>>                                if (state.detached_at)
>>>>                                      on_what = _("HEAD detached at ");
>>>>                                else
>>>> -                                       on_what = _("HEAD detached from
>>>> ");
>>>> +                                       on_what = _("HEAD detached &
>>>> diverged from ");
>>>>                        } else {
>>>>                                branch_name = "";
>>>>                           on_what = _("Not currently on any branch.");
>>>>
>>>>
>>>>
>>>
>>> No way. That would reduce the information that we give.
>>
>> How does it reduce the information we give? Maybe I've missed
>> something about what "from" means here, as opposed to "at", but it
>> seems to me to mean the same thing as "diverged" by definition, i.e.
>> we detached from the branch but we diverged from it.
>
> No, "at" means we're still at that commit - detached but not diverged.
> "from" means we only started from that commit, but are not at it any more.
>
>> Saying "diverged"
>> just makes it clearer, how does it reduce the information we give?
>
> I misread your patch on my mobile phone, sorry. I thought you meant to
> replace both "at" and "from" by "diverged from" because you considered
> them synonymous.
>
> But your patch touches just the" from" case and emphasizes the "diverge"
> aspect, which is fine, of course.
>
>>> Note that the difference between from and at is also: are there commits
>>> that we could lose when we switch away, that is: that git checkout would
>>> warn us about?
>>
>> Right, but I don't see how that's in any way conflicting or mutually
>> exclusive with saying before hand that we've diverged from the branch.
>>
>>> Maybe improve the doc instead?

I think that the doc should highlight the subtelty implied by the at/from
distinction. Especially as users may reasonably think that they are detached 
from a branch, and not see the distinction.

>>
>> Aside from whether my patch makes any sense, the solution to a UX
>> issue really can't be "oh this just needs to be documented". For every
>> user who's confused by some interface we provide a *tiny* minority of
>> them go and exhaustively read the docs for an explanation, will just
>> remain confused.
>>
>> I think saying from v.s. at is way too subtle, I for one have been
>> missing it for years until this thread, that's bad UX, git's also used
>> by a lot of non-native English speakers who may not at all get the
>> subtle difference between at and from in this context, or if they do
>> think the UI is using that subtlety to tell them something.

As a native UK English speaker (living in Scotland), I focus on the verb
'detached' rather than the at/from distinction. There are many local
dialects and variants so that is only who are taught English as she is wrote
who tend to notice the fine distinctions. (There are many fine Scottish
words which are outwith RP English).

At least if the man page indicated the distinction folks would notice
sooner - they rarely get to see the distinction side by side in the terminal
window.

>
> Well, we have to find the right balance between clarity and brevity - an
> interface that is too chatty is a nightmare. That's why I suggested both
> doc changes and additional information.
>
> What do you think about the ahead/behind info as suggested? That should
> be more informative both qualitatively (something diverged) and
> quantitatively (by how much).
>
> Michael
>
--
Philip

