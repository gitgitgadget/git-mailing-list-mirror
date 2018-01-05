Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-2.8 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_HI,T_RP_MATCHES_RCVD
	shortcircuit=no autolearn=no autolearn_force=no version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 535C11F404
	for <e@80x24.org>; Fri,  5 Jan 2018 02:45:51 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1751428AbeAECps (ORCPT <rfc822;e@80x24.org>);
        Thu, 4 Jan 2018 21:45:48 -0500
Received: from mail-wm0-f66.google.com ([74.125.82.66]:40433 "EHLO
        mail-wm0-f66.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1751208AbeAECpq (ORCPT <rfc822;git@vger.kernel.org>);
        Thu, 4 Jan 2018 21:45:46 -0500
Received: by mail-wm0-f66.google.com with SMTP id f206so58042wmf.5
        for <git@vger.kernel.org>; Thu, 04 Jan 2018 18:45:45 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=mime-version:in-reply-to:references:from:date:message-id:subject:to
         :cc:content-transfer-encoding;
        bh=PrxA/N0rm2vRzYydmSlCKgWWOaSZxSI1J0WBGycybzc=;
        b=WndrUowKVW24CGk9S8bDaHAegsJQWG8gfuIhSYXABtuw4HI3lQi0IzAnDkCMMnwE6y
         XCrb98MtVI85rF9N4QJefO7ZEihhw/hwYCTKH+2Skdav/ZO6udHOTIS7tmnY+dNlzN8h
         nUzEoiRz1e2wdpPrTelAwmOGMCPVX6X8LsCtMy69kJ4/uyDv+arKP05BlAK28GoxQa4l
         IMxNZqSR3wrkZFEsO09Fy/NtIMbh/CswLV/bWVRypRQWBxE8cJ6jNQlNsUB8wToN6KR5
         BLlZcFxJ/0QlEmaK0O84oOItceHvFvRbXGXDc5AK9wDA0HHb/3mw0aOcVAhgHvl6Cs6Y
         JzFw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:in-reply-to:references:from:date
         :message-id:subject:to:cc:content-transfer-encoding;
        bh=PrxA/N0rm2vRzYydmSlCKgWWOaSZxSI1J0WBGycybzc=;
        b=lXuJBvxDWLWhSR3kte4tM6sGMIKMVTZld8ftGx+yV6u1J4JWX0fqRsB9H6dblyh/jd
         SZ9yDoRk4+mmwoyqUPLCG0VM3p4vos/2QB+1s54FdbQEpGy29Gvg4j2rqKzgJGjTO/LP
         fLkA9lsdjsG2c75g65Nb42Bb3q36g2s9j04kWjNeHOg7NJ3Rs08EABzLoyRIMoVwyiaM
         gKzkKZ2PiLUYumCKYIy1VaxpQWIb1wWD7PRtF42hsAQ3EB3vKrFwbwK2hb5uuhfT+DXp
         w8u0x0JYY30KFUFwSKbn6fSUHhyOeb5JSLtIBpOE6UEYeL3xRZWemwHY8OwIvZNhEUD3
         4qbw==
X-Gm-Message-State: AKGB3mKhaLyACb1Ke7Sn5zhEIJGARGGlbUcQznHLUPjDlAuvqbENAq0K
        Z5k+4xYZdP6hiCjfqb6F+CXSjfeRZ9ALwjWScJc=
X-Google-Smtp-Source: ACJfBot/KiAIGfSkALcHapFYfrogPBTRjawXNUP7XMnC3qlVSNBbklwQIArrz9FqPzGQ4yD8DJAzPiI1R+6WG5AGO6o=
X-Received: by 10.28.135.133 with SMTP id j127mr1076597wmd.14.1515120344682;
 Thu, 04 Jan 2018 18:45:44 -0800 (PST)
MIME-Version: 1.0
Received: by 10.223.197.193 with HTTP; Thu, 4 Jan 2018 18:45:43 -0800 (PST)
In-Reply-To: <CAN0heSrZ4dEFqNX69PgtGCERJKabokz88v-vnNZkUBXfK118mg@mail.gmail.com>
References: <CAELBRWKYZK2tVhGZSExXRXrRB94jFN-4N3d=iKARzEsqLu7k1g@mail.gmail.com>
 <87fu7nc9a2.fsf@evledraar.gmail.com> <CAN0heSrZ4dEFqNX69PgtGCERJKabokz88v-vnNZkUBXfK118mg@mail.gmail.com>
From:   Yasushi SHOJI <yasushi.shoji@gmail.com>
Date:   Fri, 5 Jan 2018 11:45:43 +0900
Message-ID: <CAELBRWK6Y=-7WBwai16dBKd8OLxdXWOiZMALVJXrP9ak8gF-LA@mail.gmail.com>
Subject: Re: [BUG] v2.16.0-rc0 seg faults when git bisect skip
To:     =?UTF-8?Q?Martin_=C3=85gren?= <martin.agren@gmail.com>
Cc:     =?UTF-8?B?w4Z2YXIgQXJuZmrDtnLDsCBCamFybWFzb24=?= <avarab@gmail.com>,
        Git Mailing List <git@vger.kernel.org>,
        Christian Couder <chriscool@tuxfamily.org>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Hi,

On Thu, Jan 4, 2018 at 3:26 AM, Martin =C3=85gren <martin.agren@gmail.com> =
wrote:
> On 3 January 2018 at 15:21, =C3=86var Arnfj=C3=B6r=C3=B0 Bjarmason <avara=
b@gmail.com> wrote:
>>
>> On Wed, Jan 03 2018, Yasushi SHOJI jotted:
>>
>>> Hi,
>>>
>>> git version 2.16.0.rc0 seg faults on my machine when I
>>> [...]
>>> Program terminated with signal SIGSEGV, Segmentation fault.
>>> #0  0x000055a73107f900 in best_bisection_sorted (list=3D0x0, nr=3D0) at=
 bisect.c:232
>>> 232 free_commit_list(p->next);
>>> (gdb) bt
>>> #0  0x000055a73107f900 in best_bisection_sorted (list=3D0x0, nr=3D0) at=
 bisect.c:232
>>> #1  0x000055a73107fc0f in do_find_bisection (list=3D0x0, nr=3D0,
>>> weights=3D0x55a731b6ffd0, find_all=3D1) at bisect.c:361
>>> #2  0x000055a73107fcf4 in find_bisection (commit_list=3D0x7ffe8750d4d0,
>>> reaches=3D0x7ffe8750d4c4, all=3D0x7ffe8750d4c0, find_all=3D1) at
>>> bisect.c:400
>>> #3  0x000055a73108128d in bisect_next_all (prefix=3D0x0, no_checkout=3D=
0)
>>> at bisect.c:969
>>> #4  0x000055a730fd5238 in cmd_bisect__helper (argc=3D0,
>>> argv=3D0x7ffe8750e230, prefix=3D0x0) at builtin/bisect--helper.c:140
>>> #5  0x000055a730fcbc76 in run_builtin (p=3D0x55a73145c778
>>> <commands+120>, argc=3D2, argv=3D0x7ffe8750e230) at git.c:346
>>> #6  0x000055a730fcbf40 in handle_builtin (argc=3D2, argv=3D0x7ffe8750e2=
30)
>>> at git.c:554
>>> #7  0x000055a730fcc0e8 in run_argv (argcp=3D0x7ffe8750e0ec,
>>> argv=3D0x7ffe8750e0e0) at git.c:606
>>> #8  0x000055a730fcc29b in cmd_main (argc=3D2, argv=3D0x7ffe8750e230) at=
 git.c:683
>>> #9  0x000055a731068d9e in main (argc=3D3, argv=3D0x7ffe8750e228) at com=
mon-main.c:43
>>> (gdb) p p
>>> $1 =3D (struct commit_list *) 0x0
>>>
>>> As you can see, the code dereferences to the 'next' while 'p' is NULL.
>>>
>>> I'm sure I did 'git bisect good' after git _found_ bad commit.  Then I
>>> typed 'git bisect skip' on the commit 726804874 of guile repository.
>>> If that matters at all.
>>>
>>> I haven't touched guile repo to preserve the current state.
>>
>> I can't reproduce this myself, but looking at the backtrace it seems
>> pretty obvious that 7c117184d7 ("bisect: fix off-by-one error in
>> `best_bisection_sorted()`", 2017-11-05) is the culprit.
>>
>> That changed more careful code added by Christian in 50e62a8e70
>> ("rev-list: implement --bisect-all", 2007-10-22) to free a pointer which
>> as you can see can be NULL.
>>
>> If you can test a patch to see if it works this should fix it:
>>
>> diff --git a/bisect.c b/bisect.c
>> index 0fca17c02b..2f3008b078 100644
>> --- a/bisect.c
>> +++ b/bisect.c
>> @@ -229,8 +229,10 @@ static struct commit_list *best_bisection_sorted(st=
ruct commit_list *list, int n
>>                 if (i < cnt - 1)
>>                         p =3D p->next;
>>         }
>> -       free_commit_list(p->next);
>> -       p->next =3D NULL;
>> +       if (p) {
>> +               free_commit_list(p->next);
>> +               p->next =3D NULL;
>> +       }
>>         strbuf_release(&buf);
>>         free(array);
>>         return list;
>>
>> But given the commit message by Martin maybe there's some deeper bug her=
e.
>
> I haven't tried to reproduce, or tested the patch, but from the looks of
> it, your analysis and fix are both spot on. The special case that yashi
> has hit is that `list` is NULL. The old code handled that very well, the
> code after my patch ... not so well. The loop-sort-loop pattern reduces
> to a no-op, both before and after my patch. But what I failed to realize
> was that `list` could be NULL.

The patch (actually, I've tested the one in pu, 2e9fdc795cb27) avoids
the seg fault for sure, but the question is:

When does the list allowed to contain NULLs?

Since nobody noticed it since 7c117184d7, it must be a rare case, right?

Would you guys elaborate a bit?  I don't have any insight how
best_bisection_sorted() should work and what the list should contain.
So that I can make a test case.

Thanks,
--=20
               yashi
