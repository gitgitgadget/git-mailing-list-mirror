Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-2.9 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_HI,T_RP_MATCHES_RCVD
	shortcircuit=no autolearn=ham autolearn_force=no version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 2ACD520D09
	for <e@80x24.org>; Tue,  6 Jun 2017 08:51:33 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1751333AbdFFIvb (ORCPT <rfc822;e@80x24.org>);
        Tue, 6 Jun 2017 04:51:31 -0400
Received: from mail-pf0-f181.google.com ([209.85.192.181]:33335 "EHLO
        mail-pf0-f181.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1751274AbdFFIva (ORCPT <rfc822;git@vger.kernel.org>);
        Tue, 6 Jun 2017 04:51:30 -0400
Received: by mail-pf0-f181.google.com with SMTP id 83so37903834pfr.0
        for <git@vger.kernel.org>; Tue, 06 Jun 2017 01:51:29 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=mime-version:in-reply-to:references:from:date:message-id:subject:to
         :cc;
        bh=JhHv2/kvz/GykT/QCBdzm30NkyYk8Usrb7SMaqbHV8o=;
        b=ANc3clQCehasMXcGqHuypTEdZ9H5B1Pc97RLFJayMKftbiAl2mApLaplC4zJYxVp0n
         oq1pakL5EQ3svk6HICXPRgnA2cjJoXTJc9+OYGkFM70tayHuOffeZSlZWJQ6thdc6cRR
         e+Fl66fwOaSGLRQ+xyRCyJmDQ5iWCd/MbfU1RKY3Kc0NCkxHUTOspko0X9/RHBuMqP2G
         InVH5uAYMf95dasDa1idaYzQ846uC/r9EZU/frbqDx5YSq+AzmIh7NW87pl9NCPDizUJ
         7dyQbAznFCXQFD/fiOC60qye8A1+8WQrHpydjEy6kcrXDk1WzchgPCh+VADMa+HnYVXz
         T8/A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:in-reply-to:references:from:date
         :message-id:subject:to:cc;
        bh=JhHv2/kvz/GykT/QCBdzm30NkyYk8Usrb7SMaqbHV8o=;
        b=ppu5bTLEY0mVyyS/m8l3NVeSGTHXp+AY4ngZou8lb0Qzk8vIIHOXATqyPcKeQZe7Mj
         ltlYg2G9NuulchaUQJ5tbKCue7ls9UogEN6BtGppRNm8CFj2i1HDdey4/prTbm05PArs
         sQHz1rVr0+0Dw2S0uvS89FmyT2c2FAeWshmFvtrc5h1Jg7DshtECm8ar9E0NffnUrqlm
         KG/JWJSk+nBtmlRIXa5b3Yn0HLquOUhUZSMYrZG3hPp3jYuMXXEFYYYstLDtlPuT22/o
         pKLODVZsgXdEVBt103EpSOj5DUZ9T/4r1ixu6dGl64wo8x5pVW4+C/YHEZrFhrtKJusA
         7v+Q==
X-Gm-Message-State: AODbwcCPIQHTy62duMlwdhm8EgjjRcx2qe2+2fIDoFzEUqOj7ay5TnyL
        lDnjGU72aZhppjk6kzpb4wGLHPvkPQ==
X-Received: by 10.99.113.78 with SMTP id b14mr25183843pgn.229.1496739089392;
 Tue, 06 Jun 2017 01:51:29 -0700 (PDT)
MIME-Version: 1.0
Received: by 10.100.151.14 with HTTP; Tue, 6 Jun 2017 01:51:08 -0700 (PDT)
In-Reply-To: <xmqqzidl9a8l.fsf@gitster.mtv.corp.google.com>
References: <0102015c7a68c647-372a5a13-5412-4838-921d-66980bac4099-000000@eu-west-1.amazonses.com>
 <xmqqzidl9a8l.fsf@gitster.mtv.corp.google.com>
From:   Sahil Dua <sahildua2305@gmail.com>
Date:   Tue, 6 Jun 2017 10:51:08 +0200
Message-ID: <CALiud+mvAuDhcLr1DSxAxaf+-NtotBBSxgPM6tMJNueNdR8eAQ@mail.gmail.com>
Subject: Re: [PATCH] t3200: add test for single parameter passed to -m option
To:     Junio C Hamano <gitster@pobox.com>
Cc:     Git Mailing List <git@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

On Tue, Jun 6, 2017 at 3:27 AM, Junio C Hamano <gitster@pobox.com> wrote:
> Sahil Dua <sahildua2305@gmail.com> writes:
>
>> Adds a test for the case when only one parameter is passed to '-m'
>> (move/rename) option.
>>
>> For example - if 'git branch -m bbb' is run, it should rename the
>> currently checked out branch to bbb. There was no test for this
>> particular case with only one parameter for -m option. However,
>> there's one similar test case for -M option.
>>
>> Signed-off-by: Sahil Dua <sahildua2305@gmail.com>
>> ---
>>  t/t3200-branch.sh | 8 ++++++++
>>  1 file changed, 8 insertions(+)
>>
>> diff --git a/t/t3200-branch.sh b/t/t3200-branch.sh
>> index fe62e7c775da6..7504f14bc52f8 100755
>> --- a/t/t3200-branch.sh
>> +++ b/t/t3200-branch.sh
>> @@ -100,6 +100,14 @@ test_expect_success 'git branch -m n/n n should work' '
>>       git reflog exists refs/heads/n
>>  '
>>
>> +test_expect_success 'git branch -m bbb should rename checked out branch' '
>> +     test_when_finished git branch -d bbb &&
>> +     test_when_finished git checkout master &&
>> +     git checkout -b aaa &&
>> +     git branch -m bbb &&
>> +     git reflog exists refs/heads/bbb
>> +'
>
> Looks almost good.  Don't we want to also make sure that HEAD points
> at bbb branch, e.g.
>
>         git symbolic-ref HEAD >actual &&
>         echo refs/heads/bbb >expect &&
>         test_cmp expect actual &&
>
> after the "do we have reflog for the bbb branch?" test?
>
> Also, I suspect that we care about the reflog that is moved to 'bbb'
> retains entries created for 'aaa'.  So perhaps "reflog exists" needs
> to be replaced by something like
>
>         git checkout -b aaa &&
>         git commit --allow-empty -m "a new commit" &&
>         git rev-parse aaa@{1} >expect &&
>         git branch -m bbb &&
>         # the topmost entry is about branch creation
>         git rev-parse bbb@{2} >actual
>
> no?

Both of these changes make complete sense and in my opinion will
increase the quality of the tests if applied to the other tests too. I
notice that no other test for this (-m|-M) option checks if the branch
is actually checked out. Similarly, no other test checks if the
operation retains reflog entries. They just check if the new reflog
exists.

Do you think I should make similar changes to the other tests for
(-m|-M) option as well?

>
>>  test_expect_success 'git branch -m o/o o should fail when o/p exists' '
>>       git branch o/o &&
>>       git branch o/p &&
>>
>> --
>> https://github.com/git/git/pull/371
