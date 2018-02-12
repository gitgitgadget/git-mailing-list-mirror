Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-2.8 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_HI,T_RP_MATCHES_RCVD
	shortcircuit=no autolearn=no autolearn_force=no version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 36A911F576
	for <e@80x24.org>; Mon, 12 Feb 2018 10:05:10 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1754039AbeBLKFH (ORCPT <rfc822;e@80x24.org>);
        Mon, 12 Feb 2018 05:05:07 -0500
Received: from mail-ot0-f180.google.com ([74.125.82.180]:40651 "EHLO
        mail-ot0-f180.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1754009AbeBLKFG (ORCPT <rfc822;git@vger.kernel.org>);
        Mon, 12 Feb 2018 05:05:06 -0500
Received: by mail-ot0-f180.google.com with SMTP id s4so13493219oth.7
        for <git@vger.kernel.org>; Mon, 12 Feb 2018 02:05:06 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=mime-version:in-reply-to:references:from:date:message-id:subject:to
         :cc:content-transfer-encoding;
        bh=+E5S+gqLJ5ZxNzu37W3eTpX51Cng2HQNJYvEPD5L9T4=;
        b=VtWtzajvEdvKX5I8PqYVveuO8RU7OT4wTFKulPvIrLfHyPuOWMrjMixtnihDRKQQD8
         rOTm3SaZuuGCkFiv07YooAOtwC2y9Bntc+zkszSy5EamNUP4kWuYWOI5UHxvqP90IAos
         qdjQMoqqUXyvTkQeN1L6VE4ujc2Hma3dEodq2ZrnEQzBW2G/T2luIbc374xbbRIDs1kj
         Yo8DGCohBH/ouRhF43JgnHsIV4cSnFuoM5VOHy7zJEU47G4Shao39AD7LKQyi/6I/74D
         pFRSSekO9a3m3HlCkvJZ+JL+dWE8q62/E7XU3tR2dGImqZ1i9upLFGZA1+Ms7boTm22g
         ZvYQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:in-reply-to:references:from:date
         :message-id:subject:to:cc:content-transfer-encoding;
        bh=+E5S+gqLJ5ZxNzu37W3eTpX51Cng2HQNJYvEPD5L9T4=;
        b=HLA8C8Mo80k63djhEhJp/jf1+5K9pwapH4l7Zi+zuoofA5XFKX3flLGZNEa4ySAZhQ
         sXoPzyYHcehCEurqoNgam7ornoBoRyv9eN1fH5WkSKfVJh/IRxwyom6Y58Tl8ddLSvQH
         Hwq02DoNXuUZFW+e4lXICdtRHZ6skZQRaAAEGEQ8z/qnujsL2BkdD+0BiPAYOt5+om68
         o/ri+ousvjx1q3By7w18Bh2BtAbz0LJ70k9qwQXbDGX/EaOReTClZqaZ1TP5c4B29JFl
         6QTbncGcepkuCo8h/bGpDD7g8pVG0vUdscVqL/TW8axENpqVsViShci9gJdVoHXCm5fL
         sIjg==
X-Gm-Message-State: APf1xPBZ1YvKb9n6U15jfzQPpkKuSV6uOorYDajl6E2K17sLkj9cRSAD
        ULE9q2hVWphay+IcCRQHDXyIDzjyPDfJ3A3p6qk=
X-Google-Smtp-Source: AH8x2275sJneKGycxPl7toI8Sdnidj8EbWncy7Liwl/8nH+637tGQRGKzQjqHr7N0EF+jhlufMaiKBfK6EPcc0ZDClk=
X-Received: by 10.157.53.5 with SMTP id o5mr8060343otc.181.1518429905862; Mon,
 12 Feb 2018 02:05:05 -0800 (PST)
MIME-Version: 1.0
Received: by 10.74.25.140 with HTTP; Mon, 12 Feb 2018 02:04:35 -0800 (PST)
In-Reply-To: <876073k2lc.fsf@evledraar.gmail.com>
References: <xmqqd11pr0he.fsf@gitster-ct.c.googlers.com> <87372am2ls.fsf@evledraar.gmail.com>
 <CACsJy8BeQ3mD9pReUZKi+=qio5z8an5RyVd=auxPnMZ3uCRhdQ@mail.gmail.com> <876073k2lc.fsf@evledraar.gmail.com>
From:   Duy Nguyen <pclouds@gmail.com>
Date:   Mon, 12 Feb 2018 17:04:35 +0700
Message-ID: <CACsJy8DZ7DqF9Y_D=Yif6zUj6-Ls=iczyr5UOJonCsafER7spQ@mail.gmail.com>
Subject: Re: What's cooking in git.git (Jan 2018, #04; Wed, 31)
To:     =?UTF-8?B?w4Z2YXIgQXJuZmrDtnLDsCBCamFybWFzb24=?= <avarab@gmail.com>
Cc:     Junio C Hamano <gitster@pobox.com>,
        Git Mailing List <git@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

On Sun, Feb 11, 2018 at 9:44 PM, =C3=86var Arnfj=C3=B6r=C3=B0 Bjarmason
<avarab@gmail.com> wrote:
>
> On Sat, Feb 10 2018, Duy Nguyen jotted:
>
>> On Sat, Feb 10, 2018 at 1:37 AM, =C3=86var Arnfj=C3=B6r=C3=B0 Bjarmason
>> <avarab@gmail.com> wrote:
>>>
>>> On Thu, Feb 01 2018, Junio C. Hamano jotted:
>>>
>>>> * nd/fix-untracked-cache-invalidation (2018-01-24) 5 commits
>>>>  - dir.c: stop ignoring opendir() error in open_cached_dir()
>>>>  - update-index doc: note a fixed bug in the untracked cache
>>>>  - dir.c: fix missing dir invalidation in untracked code
>>>>  - dir.c: avoid stat() in valid_cached_dir()
>>>>  - status: add a failing test showing a core.untrackedCache bug
>>>>
>>>>  Some bugs around "untracked cache" feature have been fixed.
>>>>
>>>>  Will merge to 'next'.
>>>
>>> I think you / Nguy=E1=BB=85n may not have seen my
>>> <87d11omi2o.fsf@evledraar.gmail.com>
>>> (https://public-inbox.org/git/87d11omi2o.fsf@evledraar.gmail.com/)
>>
>> I have. But since you wrote "I haven't found... yet", I assumed you
>> were still on it. You didn't give me much info to follow anyway.
>
> Haven't had time to dig further, sorry, and won't be able to share the
> repository. Is there some UC inspection command that can be run on the
> relevant path / other thing that'll be indicative of what went wrong?

There's test-dump-untracked-cache that will give you all the data.
From then on, you may need to dig in the code a bit to see how that
data should be processed.

There's no obfuscation support in that command, unfortunately, so you
can't just send me the dump. But if you could limit it to a few
"blocks" related to the error messages, then manual obfuscation should
not take that much time (either that or just add obfuscation in
test-dump-untracked-cache.c, it's probably easier task; or I can do
this for you)

>>> As noted there I think it's best to proceed without the "dir.c: stop
>>> ignoring opendir[...]" patch.
>>>
>>> It's going to be a bad regression in 2.17 if it ends up spewing pageful=
s
>>> of warnings in previously working repos if the UC is on.
>>
>> "previously working" is a strong word when opendir() starts to
>> complain. Sure we can suppress/ignore the error messages but I don't
>> think it's a healthy attitude. Unreported bugs can't be fixed.
>
> I mean that for the user it returned the right "git status" info and
> didn't print errors, but yeah, the index may have been in some
> internally funny state.

One question (I wasn't clear from your previous mail). Does "git
status" always report the same errors when run multiple times, or does
it just report once, then next "git status" is silent? I suppose it's
the former case..
--=20
Duy
