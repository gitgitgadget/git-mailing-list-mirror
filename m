Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-4.5 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_HI,RP_MATCHES_RCVD
	shortcircuit=no autolearn=ham autolearn_force=no version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 569841F6C1
	for <e@80x24.org>; Tue, 30 Aug 2016 20:17:44 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1752721AbcH3UR2 (ORCPT <rfc822;e@80x24.org>);
        Tue, 30 Aug 2016 16:17:28 -0400
Received: from mail-yw0-f193.google.com ([209.85.161.193]:35596 "EHLO
        mail-yw0-f193.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1752187AbcH3UR0 (ORCPT <rfc822;git@vger.kernel.org>);
        Tue, 30 Aug 2016 16:17:26 -0400
Received: by mail-yw0-f193.google.com with SMTP id r9so1197185ywg.2
        for <git@vger.kernel.org>; Tue, 30 Aug 2016 13:17:26 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20120113;
        h=mime-version:in-reply-to:references:from:date:message-id:subject:to
         :cc;
        bh=MCqATVx2IXFX3aj1j9OSoRn0fn+eepxjcMclMJTpd5k=;
        b=eGxy9On8OlhWYpikmmGbUcbb8JJIUlMvQBOl4X+iFO24rZIzfD2vu/HkTbklCDtost
         l3uUbTIJ6290QogHm523pbNS77Yld2FdAuX+QcQoLKRvLNYwiJ/v87G0w+cum+GGEBAn
         B2iPYt8l1BTWiMIOZc63yJuLI0fc3ZCYPTnBPIqOaLIv8JtJauafjRiXfeDVM+a0C4jM
         yTyG8jJt5d+ec28WU38rXXtvvMPKgKYhX+cMpsT7s2i/UqMOI+/LJB2tKDi2hmXnlPp4
         8LNlE/pSPxisfwsmLn+a/HCYH4osjv9FgVVVQkLRyLIC9+qTe8KD+N9/YagM+fHDsB2r
         pV4Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20130820;
        h=x-gm-message-state:mime-version:in-reply-to:references:from:date
         :message-id:subject:to:cc;
        bh=MCqATVx2IXFX3aj1j9OSoRn0fn+eepxjcMclMJTpd5k=;
        b=VaZHxIEfKXfNMYF/sJ6iA40Jon2am/gm58xMOy4IZZaiehqLJgnTMUl5XfPSCsg9Nr
         vWdPC+SWGnQ2bwVKWZ9VKd5pGAnszlFbCaRPKSnGB3Ci5U5giOA7xcpNoEqQ2qWlB5Lh
         5EAX6E3Of3VNVSkNiDNC8LtD0Jd0sqgO5BIBYuw4nHAYg2wlZTHp1/xa8+WHs9Jt4mwg
         cNOxFKQbkWeaspD7dkBb6Ij6bR1LFm/2wMDhembX8j5ZVVN77dvKk46CzyWxnYq3BPYc
         mnR1hUw1ti+jb203ejrszuuGXpKc2wSEBhVkfdFli9ONDLwHPZQySIX4ZMeYu+E9wUEM
         1ASA==
X-Gm-Message-State: AE9vXwN13R5rvId2gVYKN8rYN0n3uAEV57QNoZIm18Np/RtdjJCv3tDQgIgqYe9mH3pSyw0vTX8UmXHH38AdAQ==
X-Received: by 10.13.212.139 with SMTP id w133mr5139314ywd.49.1472588245484;
 Tue, 30 Aug 2016 13:17:25 -0700 (PDT)
MIME-Version: 1.0
Received: by 10.129.89.132 with HTTP; Tue, 30 Aug 2016 13:17:25 -0700 (PDT)
In-Reply-To: <xmqqvayi2grg.fsf@gitster.mtv.corp.google.com>
References: <01020156b73fe5b4-5dc768ab-b73b-4a21-ab92-018e2a7aa6f7-000000@eu-west-1.amazonses.com>
 <01020156b73fe6ce-3b204354-849b-40fd-93ff-2ebcf77df91c-000000@eu-west-1.amazonses.com>
 <xmqq37lsmw15.fsf@gitster.mtv.corp.google.com> <CAFZEwPP-c00aNvDKoQFiCf_-tqrP3tAwwU6KAnswfMkjyoP3QQ@mail.gmail.com>
 <xmqqvayi2grg.fsf@gitster.mtv.corp.google.com>
From:   Pranit Bauva <pranit.bauva@gmail.com>
Date:   Wed, 31 Aug 2016 01:47:25 +0530
Message-ID: <CAFZEwPOb2HhULRyPqdnZd-_ADgnSeZsdikgG4odvD_svWMJgCQ@mail.gmail.com>
Subject: Re: [PATCH v14 14/27] bisect--helper: `bisect_next` and
 `bisect_auto_next` shell function in C
To:     Junio C Hamano <gitster@pobox.com>
Cc:     Git List <git@vger.kernel.org>
Content-Type: text/plain; charset=UTF-8
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Hey Junio,

On Wed, Aug 31, 2016 at 1:03 AM, Junio C Hamano <gitster@pobox.com> wrote:
> Pranit Bauva <pranit.bauva@gmail.com> writes:
>
>> This is a very tricky one. I have purposely not included this after a
>> lot of testing. I have hand tested with the original git and with this
>> branch. The reason why anyone wouldn't be able to catch this is
>> because its not covered in the test suite. I am including a patch with
>> this as an attachment (because I am behind a proxy right now but don't
>> worry I will include this as a commit in the next series). The
>> original behaviour of git does not clean the bisect state when this
>> situation occurs.
>
> "We sometimes clean and we sometimes don't and this follows the
> original" may be a valid justification but it is not a very useful
> explanation.  The real issue is if not cleaning is intended (and if
> so why; otherwise, if it is clear that it is simply forgotten, we
> can just fix it in the series as a follow-up step).

I think we do want to recover from this "bad merge base" state and for
that not cleaning up is essential. The original behaviour of git seems
natural to me.

> If not cleaning in some cases (but not others) is the right thing,
> at least there needs an in-code comment to warn others against
> "fixing" the lack of cleanups (e.g. "don't clean state here, because
> the caller still wants to see what state we were for this and that
> reason").

I will mention it in the comments.

>>>> +     if (bisect_next_check(terms, terms->term_good.buf))
>>>> +             return -1;
>>>
>>> Mental note.  The "autostart" in the original is gone.  Perhaps it
>>> is done by next_check in this code, but we haven't seen that yet.
>>
>> This will be added back again in a coming patch[1].
>
> In other words, this series is broken at this step and the breakage
> stay with the codebase until a later step?

Broken though it passes the test suite.

> I do not know if reordering the patches in the series is enough to
> fix that, or if it is even worth to avoid such a temporary breakage.
> It depends on how serious the circularity is, but I would understand
> if it is too hard and not worth the effort (I think in a very early
> review round some people advised against the bottom-up rewrite
> because they anticipated this exact reason).  At least the omission
> (and later resurrection) needs to be mentioned in the log so that
> people understand what is going on when they later need to bisect.

bisect_autostart() call from bisect_next() was introduced in the
earliest version of git-bisect in the commit 8cc6a0831 but it isn't
really a very big deal and I think it would be OK to skip it for a
very little while as any which ways the series in the end would fix
it. It is important to mention this in the commit message and I will
do it.

Regards,
Pranit Bauva
