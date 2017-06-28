Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-3.5 required=3.0 tests=AWL,BAYES_00,
	FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,HEADER_FROM_DIFFERENT_DOMAINS,
	RCVD_IN_DNSWL_HI,RP_MATCHES_RCVD shortcircuit=no autolearn=ham
	autolearn_force=no version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 5BA772023D
	for <e@80x24.org>; Wed, 28 Jun 2017 22:30:25 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1752052AbdF1WaY (ORCPT <rfc822;e@80x24.org>);
        Wed, 28 Jun 2017 18:30:24 -0400
Received: from mout.web.de ([212.227.15.3]:52010 "EHLO mout.web.de"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1751681AbdF1WaW (ORCPT <rfc822;git@vger.kernel.org>);
        Wed, 28 Jun 2017 18:30:22 -0400
Received: from [192.168.178.36] ([79.237.60.227]) by smtp.web.de (mrweb002
 [213.165.67.108]) with ESMTPSA (Nemesis) id 0Letgd-1e5yXX203L-00qgSz; Thu, 29
 Jun 2017 00:30:16 +0200
Subject: Re: [PATCH v4 4/6] coccinelle: add a rule to make "expression" code
 use FREE_AND_NULL()
From:   =?UTF-8?Q?Ren=c3=a9_Scharfe?= <l.s.r@web.de>
To:     =?UTF-8?B?w4Z2YXIgQXJuZmrDtnLDsCBCamFybWFzb24=?= <avarab@gmail.com>
Cc:     Junio C Hamano <gitster@pobox.com>, git@vger.kernel.org
References: <20170615231549.20085-1-avarab@gmail.com>
 <xmqqa858zzb3.fsf@gitster.mtv.corp.google.com>
 <20170615231549.20085-5-avarab@gmail.com>
 <xmqq7f0byayu.fsf@gitster.mtv.corp.google.com>
 <2122b01f-7627-cd1b-c7df-751c076f90ff@web.de> <87injfkd0j.fsf@gmail.com>
 <433f9fb7-a202-1091-46de-04535b2a49e1@web.de>
Message-ID: <b1b97b26-f715-1d0f-410e-51356b05b890@web.de>
Date:   Thu, 29 Jun 2017 00:30:12 +0200
User-Agent: Mozilla/5.0 (Windows NT 10.0; WOW64; rv:52.0) Gecko/20100101
 Thunderbird/52.2.1
MIME-Version: 1.0
In-Reply-To: <433f9fb7-a202-1091-46de-04535b2a49e1@web.de>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Language: en-US
Content-Transfer-Encoding: 8bit
X-Provags-ID: V03:K0:e3Z75k5CUk5Cim19aAP7m1kHOhJcMyF4NualLm91iqrVN7o+08n
 jy997yWv94XwOI262Gyz+GR/G6XtB/5ddy9Gi2QdGiKiwDXb5STIcODUyI7L/LQJR65z4Bo
 O9JYowMFfoRMgFBLLbJlmk0xFnSGdgzIy1KMYBD1dxmK3msmhWmVvGRDfwS3u07ckNTtn8m
 5rGYiry4bEP4UVctmaMiQ==
X-UI-Out-Filterresults: notjunk:1;V01:K0:um8G1rZuMMg=:j0QZXPWKpFRkDu4Wx5nkCz
 u6G2c/1PQQgNcrUbFrwUnoRr5KHleczCl5WJcE58nWndYVGUX/5ag5PL/lFtQvKaG2ysoANla
 H8lg7luH4wJDXhwBOJda2HfhRrn9Y/hMhjNR+VtrcZPkEOkcW6mOMWe9fHVzohhCKodWf4+TR
 JNcojFC3Jz7G1BRqaOik0qTLSvjKWx1NPK6BAmfCSRVgLb6uqfvYIUrmcNH4w/BYKm+0Z67z/
 wx9Ln8LdNEl5G7wGR30EtgoICqHygIpI8rB13pSUiFP/VNnSGYuGIJqEax2BIjKyTUY4XBJkY
 xoAKmIu+2DNb5b/NyCJ9BzYgtWaDFMpDGt40yI+lmK/mmF74PcIoL6AFGKcb9D88IwVDEt/Sv
 58cKSiaLS+klggiigK+YeTkGDGBHT6Owl0ugCRYvqT/+24J5t9qQZ7XsrROnIyGk+AFmI1MP2
 3fXJo4HU1aAQ/SMvqGwC817q4+GpNUHx2WdEUxsVLzjec7YOZSn14nkHVd4mnNksyJqbhfPsU
 POZqEfd2WcjOsqEb/qJknlfo4SVXyrl/KJul51Z2LlZSZxWVF4Myzr0vaZ74DDBDAkQX6RoIq
 i1SAl3NUkmODZ+Z/AbV0MXgUzQWZWRTd51UpzcNlYKMGTpiWxHXpqbbUDi/7g9UZvwnQj79NZ
 HbfbGWD0KkyOsRJE+e7lpcNlp1gSMYtgN2eTnjcILn7Pjphk4WUuwtphnI3DtxsuV16DEkpsg
 RsbkBUL2hdb3YGlepCJoz+VHwq/o8ziDXSZspCjPq+DsysMGMnwCINu0cLyFEt/1dfXBhBDey
 dtDwf07
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Am 29.06.2017 um 00:21 schrieb René Scharfe:
> Am 28.06.2017 um 23:39 schrieb Ævar Arnfjörð Bjarmason:
>>
>> On Sun, Jun 25 2017, René Scharfe jotted:
>>
>>> Am 16.06.2017 um 21:43 schrieb Junio C Hamano:
>>>> Ævar Arnfjörð Bjarmason  <avarab@gmail.com> writes:
>>>>
>>>>> A follow-up to the existing "type" rule added in an earlier
>>>>> change. This catches some occurrences that are missed by the previous
>>>>> rule.
>>>>>
>>>>> Signed-off-by: Ævar Arnfjörð Bjarmason <avarab@gmail.com>
>>>>> ---
>>>>
>>>> Hmph, I wonder if the "type" thing is really needed.  Over there,
>>>> "ptr" is an expression and we can find "free(ptr); ptr = NULL" with
>>>> the rule in this patch already, no?
>>>
>>> Indeed.  How about this on top of master?
>>>
>>> -- >8 --
>>> Subject: [PATCH] coccinelle: polish FREE_AND_NULL rules
>>>
>>> There are two rules for using FREE_AND_NULL in free.cocci, one for
>>> pointer types and one for expressions.  Both cause coccinelle to remove
>>> empty lines and even newline characters between replacements for some
>>> reason; consecutive "free(x);/x=NULL;" sequences end up as multiple
>>> FREE_AND_NULL calls on the same time.
>>>
>>> Remove the type rule, as the expression rule already covers it, and
>>> rearrange the lines of the latter to place the addition of FREE_AND_NULL
>>> between the removals, which causes coccinelle to leave surrounding
>>> whitespace untouched.
>>>
>>> Signed-off-by: Rene Scharfe <l.s.r@web.de>
>>> ---
>>>    contrib/coccinelle/free.cocci | 10 +---------
>>>    1 file changed, 1 insertion(+), 9 deletions(-)
>>>
>>> diff --git a/contrib/coccinelle/free.cocci b/contrib/coccinelle/free.cocci
>>> index f2d97e755b..4490069df9 100644
>>> --- a/contrib/coccinelle/free.cocci
>>> +++ b/contrib/coccinelle/free.cocci
>>> @@ -11,16 +11,8 @@ expression E;
>>>      free(E);
>>>
>>>    @@
>>> -type T;
>>> -T *ptr;
>>> -@@
>>> -- free(ptr);
>>> -- ptr = NULL;
>>> -+ FREE_AND_NULL(ptr);
>>> -
>>> -@@
>>>    expression E;
>>>    @@
>>>    - free(E);
>>> -- E = NULL;
>>>    + FREE_AND_NULL(E);
>>> +- E = NULL;
>>
>> Late reply, sorry. What version of coccinelle are you running? I have
>> 1.0.4 (from Debian) and can't get this to produce the same results as
>> what I have.
>>
>> On top of next, I did:
>>
>>           Revert "*.[ch] refactoring: make use of the FREE_AND_NULL() macro"
>>           Revert "coccinelle: make use of the "expression" FREE_AND_NULL() rule"
>>           Revert "coccinelle: make use of the "type" FREE_AND_NULL() rule"
>>
>> And then generated the patch as usual with `make coccicheck`, and
>> applied it. This has your change.
>>
>> I then re-applied the manual "*.[ch] refactoring" changes
>>
>> This results in this diff with next:
>>
>>       $ git diff --stat origin/next.. -- '*.[ch]'
>>        builtin/am.c             |  3 ++-
>>        builtin/clean.c          |  6 ++++--
>>        builtin/config.c         |  6 ++++--
>>        builtin/index-pack.c     |  6 ++++--
>>        builtin/pack-objects.c   | 12 ++++++++----
>>        builtin/unpack-objects.c |  3 ++-
>>        fast-import.c            |  6 ++++--
>>        http-push.c              | 24 ++++++++++++++++--------
>>        http.c                   | 15 ++++++++++-----
>>        imap-send.c              |  3 ++-
>>        ref-filter.c             |  3 ++-
>>        refs/files-backend.c     |  3 ++-
>>        remote-testsvn.c         |  3 ++-
>>        sequencer.c              |  3 ++-
>>        sha1-array.c             |  3 ++-
>>        sha1_file.c              |  3 ++-
>>        transport-helper.c       | 27 ++++++++++++++++++---------
>>        transport.c              |  3 ++-
>>        tree-diff.c              |  6 ++++--
>>        tree.c                   |  3 ++-
>>        20 files changed, 94 insertions(+), 47 deletions(-)
>>
>> These are all cases where we now miss things that should use
>> FREE_AND_NULL(), e.g.:
>>
>>       diff --git a/builtin/am.c b/builtin/am.c
>>       index c973bd96dc..2f89338ed7 100644
>>       --- a/builtin/am.c
>>       +++ b/builtin/am.c
>>       @@ -484,7 +484,8 @@ static int run_applypatch_msg_hook(struct am_state *state)
>>               ret = run_hook_le(NULL, "applypatch-msg", am_path(state, "final-commit"), NULL);
>>
>>               if (!ret) {
>>       -               FREE_AND_NULL(state->msg);
>>       +               free(state->msg);
>>       +               state->msg = NULL;
>>                       if (read_commit_msg(state) < 0)
>>                               die(_("'%s' was deleted by the applypatch-msg hook"),
>>                                       am_path(state, "final-commit"));
>>
>> So it looks to me like removing the "type T" rule breaks a lot of
>> things, but that the change you made to the expression rule is good, and
>> we should do that for the "type" rule as well. Your commit says the
>> "expression rule already covers it", but this doesn't seem to be the
>> case at all.
>>
>> As an aside: Junio, did you mean to apply f8bb4631fb to next this way?
>> Looks like a mis-applied scissor commit.
> 
> I can't reproduce that strange result with master, but get a scissors
> line into the commit message as well.  The diff at the end looks
> reasonable (contains just the manual stuff).  Here's what I did:

On top of next it looks basically the same for me, only difference
being several new converted cases in repository.c.

Did you commit before diff?

René
