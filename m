Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-2.8 required=3.0 tests=AWL,BAYES_00,
	HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_HI,STOX_REPLY_TYPE,
	T_RP_MATCHES_RCVD shortcircuit=no autolearn=ham autolearn_force=no
	version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 6A48A20A40
	for <e@80x24.org>; Sat,  2 Dec 2017 22:26:02 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1752367AbdLBW0A (ORCPT <rfc822;e@80x24.org>);
        Sat, 2 Dec 2017 17:26:00 -0500
Received: from smtp-out-2.talktalk.net ([62.24.135.66]:59268 "EHLO
        smtp-out-2.talktalk.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1751996AbdLBWZ7 (ORCPT <rfc822;git@vger.kernel.org>);
        Sat, 2 Dec 2017 17:25:59 -0500
Received: from PhilipOakley ([92.29.14.162])
        by smtp.talktalk.net with SMTP
        id LGEPewitxNSVVLGEPeYexz; Sat, 02 Dec 2017 22:25:58 +0000
X-Originating-IP: [92.29.14.162]
X-Spam: 0
X-OAuthority: v=2.2 cv=NYGW7yL4 c=1 sm=1 tr=0 a=NXc+vVEgz70gitWznrz3ig==:117
 a=NXc+vVEgz70gitWznrz3ig==:17 a=IkcTkHD0fZMA:10 a=pGLkceISAAAA:8
 a=Dx4yW56zAAAA:8 a=ybZZDoGAAAAA:8 a=UXIAUNObAAAA:8 a=NEAV23lmAAAA:8
 a=MbBU0op5AAAA:8 a=dFqcmvXlYHaoOI6vaiAA:9 a=QEXdDO2ut3YA:10
 a=X_u8qhY6y2Nm79co_leF:22 a=0RhZnL1DYvcuLYC8JZ5M:22 a=UjowuL6zFGdFnWIPC7Gz:22
Message-ID: <FF34D4C2058D44E990BF149F3AB1E010@PhilipOakley>
Reply-To: "Philip Oakley" <philipoakley@iee.org>
From:   "Philip Oakley" <philipoakley@iee.org>
To:     "anatoly techtonik" <techtonik@gmail.com>,
        =?UTF-8?Q?=C3=86var_Arnfj=C3=B6r=C3=B0_Bjarmason?= 
        <avarab@gmail.com>
Cc:     "Randall S. Becker" <rsbecker@nexbridge.com>,
        "Junio C Hamano" <gitster@pobox.com>,
        "Git Mailing List" <git@vger.kernel.org>,
        "Igor Djordjevic" <igor.d.djordjevic@gmail.com>
References: <201711231458.vANEwUMK048049@elephants.elehost.com> <003c01d3646c$df78fc50$9e6af4f0$@nexbridge.com> <CAPkN8xJBWRs-2DxViBACLKzAbD1_EBA2MvmWVZmWgL+Sg72znw@mail.gmail.com> <CACBZZX4SM45hgA=PW0MEP9Ea0OG_8OTb5U7JCOX7xnd=hT5n3A@mail.gmail.com> <CAPkN8xKDQrf+LMpj9GHw9n_crJ1UUwq7Zek+Z1dgQ0n2Jz5U6g@mail.gmail.com>
Subject: Re: Re: Unify annotated and non-annotated tags
Date:   Sat, 2 Dec 2017 22:25:56 -0000
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
X-Antivirus: AVG (VPS 171202-2, 02/12/2017), Outbound message
X-Antivirus-Status: Clean
X-CMAE-Envelope: MS4wfHa/VrKml5Iw7CMxwgCcK8ZZYkePT5BzsOzH3qafh90Oml6yj0oHPn7/rNQu+JSgUBkgXI/YBtP2njvyFKOpayXbo7ElRNBq5I5qqGRUZzKDOdDo6ERw
 lpsBkz1W0YkN38FzphjbS4A7iO+NdGBO9f8BPvVuQk4uda1bEfdVFGEhISxaQOY7SKPFUzFOI0ix1NhWrEIj53qUgMJU1O9psBmuDF2d08lIRip82OYlA8gl
 pPwKnr5A/VkI0lW8vXLzqxaFNS7YFYdQd3EigaNvDXYj41koEHdDIz6ekDxVZwBELtHhgSF2Bm4HVO9MN3d0Cfov8J7QVNaM08UV2+cd8GA=
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

From: "anatoly techtonik" <techtonik@gmail.com>

comment at end - Philip

On Fri, Nov 24, 2017 at 1:24 PM, Ævar Arnfjörð Bjarmason
<avarab@gmail.com> wrote:
> On Fri, Nov 24, 2017 at 10:52 AM, anatoly techtonik <techtonik@gmail.com> 
> wrote:
>> On Thu, Nov 23, 2017 at 6:08 PM, Randall S. Becker
>> <rsbecker@nexbridge.com> wrote:
>>> On 2017-11-23 02:31 (GMT-05:00) anatoly techtonik wrote
>>>>Subject: Re: Unify annotated and non-annotated tags
>>>>On Sat, Nov 11, 2017 at 5:06 AM, Junio C Hamano <gitster@pobox.com> 
>>>>wrote:
>>>>> Igor Djordjevic <igor.d.djordjevic@gmail.com> writes:
>>>>>
>>>>>> If you would like to mimic output of "git show-ref", repeating
>>>>>> commits for each tag pointing to it and showing full tag name as
>>>>>> well, you could do something like this, for example:
>>>>>>
>>>>>>       for tag in $(git for-each-ref --format="%(refname)" refs/tags)
>>>>>>       do
>>>>>>               printf '%s %s\n' "$(git rev-parse $tag^0)" "$tag"
>>>>>>       done
>>>>>>
>>>>>>
>>>>>> Hope that helps a bit.
>>>>>
>>>>> If you use for-each-ref's --format option, you could do something
>>>>> like (pardon a long line):
>>>>>
>>>>> git 
>>>>> for-each-ref --format='%(if)%(*objectname)%(then)%(*objectname)%(else)%(objectname)%(end) 
>>>>> %(refname)' refs/tags
>>>>>
>>>>> without any loop, I would think.
>>>>Thanks. That helps.
>>>>So my proposal is to get rid of non-annotated tags, so to get all
>>>>tags with commits that they point to, one would use:
>>>>git for-each-ref --format='%(*objectname) %(refname)' refs/tags>
>>>>For so-called non-annotated tags just leave the message empty.
>>>>I don't see why anyone would need non-annotated tags though.
>>>
>>> I have seen non-annotated tags used in automations (not necessarily well 
>>> written ones) that create tags as a record of automation activity. I am 
>>> not sure we should be writing off the concept of unannotated tags 
>>> entirely. This may cause breakage based on existing expectations of how 
>>> tags work at present. My take is that tags should include whodunnit, 
>>> even if it's just the version of the automation being used, but I don't 
>>> always get to have my wishes fulfilled. In essence, whatever behaviour a 
>>> non-annotated tag has now may need to be emulated in future even if 
>>> reconciliation happens. An option to preserve empty tag compatibility 
>>> with pre-2.16 behaviour, perhaps? Sadly, I cannot supply examples of 
>>> this usage based on a human memory page-fault and NDAs.
>>
>> Are there any windows for backward compatibility breaks, or git is
>> doomed to preserve it forever?
>> Automation without support won't survive for long, and people who rely
>> on that, like Chromium team, usually hard set the version used.
>
> Git is not doomed to preserve anything forever. We've gradually broken
> backwards compatibility for a few core things like these.
>
> However, just as a bystander reading this thread I haven't seen any
> compelling reason for why these should be removed. You initially had
> questions about how to extract info about them, which you got answers
> to.
>
> So what reasons remain for why they need to be removed?

To reduce complexity and prior knowledge when dealing with Git tags.

For example, http://readthedocs.io/ site contains a lot of broken
"Edit on GitHub" links, for example - 
http://git-memo.readthedocs.io/en/stable/

And it appeared that the reason for that is discrepancy between git
annotated and non-annotated tags. The pull request that fixes the issue
after it was researched and understood is simple
https://github.com/rtfd/readthedocs.org/pull/3302

However, while looking through linked issues and PRs, one can try to
imagine how many days it took for people to come up with the solution,
which came from this thread.
-- 
anatoly t.

>>>>>>>

So if I understand correctly, the hope is that `git show-ref --tags` could 
get an alternate option `--all-tags` [proper option name required...] such 
that the user would not have to develop the rather over the complicated 
expression that used a newish capability of a different command.

Would that be right?

Or at least update the man page docs to clarify the annotated vs 
non-annotated tags issue (many SO questions!).

And indicate if the --dereference and/or --hash options would do the 
trick! - maybe the "^{}" appended would be part of the problem (and need 
that new option "--objectreference" ).

Philip 

