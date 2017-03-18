Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-3.3 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_HI,RP_MATCHES_RCVD
	shortcircuit=no autolearn=ham autolearn_force=no version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 498532095B
	for <e@80x24.org>; Sat, 18 Mar 2017 19:51:42 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1751047AbdCRTub (ORCPT <rfc822;e@80x24.org>);
        Sat, 18 Mar 2017 15:50:31 -0400
Received: from mail-it0-f50.google.com ([209.85.214.50]:38600 "EHLO
        mail-it0-f50.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1750957AbdCRTua (ORCPT <rfc822;git@vger.kernel.org>);
        Sat, 18 Mar 2017 15:50:30 -0400
Received: by mail-it0-f50.google.com with SMTP id m27so60578819iti.1
        for <git@vger.kernel.org>; Sat, 18 Mar 2017 12:49:40 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=mime-version:in-reply-to:references:from:date:message-id:subject:to
         :cc:content-transfer-encoding;
        bh=rRjWADPX+bLAlf3kypF3GFZV3mpZVSNW84Tjp7MOuXQ=;
        b=cMchxnzUfYPq+4WYp4OwXaybYtO8scwamzw8EUKV2EeiEL1aFi7CI01JHgryRDzCz+
         C7HO8PD/HWiBMTclnd8wOY3kW209YZP2ZykXPOfIqFtftQf1Vr0Hg1gZgoWfHIrx/NNS
         qJkzWG9+oU7R4JjCepEiej6WHqgf7w4dPZwSdubSPd08FPbUa/apZDiXncXiwnh8jJSH
         AmVYoJC10ADIXn2lsN2FLni7Ur+UG/bRVJVALVAVEb+L7kEc8NaHvVjMpcxSP+HpR57O
         ry1JzYqcyKb40XLXeueDzXHUFSALK7sQNxA3nQ2i0t5uXefZK8QBkiPQmNLg8K8j3YXn
         IuMg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:in-reply-to:references:from:date
         :message-id:subject:to:cc:content-transfer-encoding;
        bh=rRjWADPX+bLAlf3kypF3GFZV3mpZVSNW84Tjp7MOuXQ=;
        b=I1RmzinSRdfBkMrnOCOISE6UkQ60H78V7JqJa6dlF2z0EIsFmrYH3VbsocASuOgbik
         DjYpbQG1bwLcw7ubBtxo7M5NhHhIZy/rpewkcr/cO0L67gXMYZpAyfafPOqdTHGTtMTq
         LeSG4s7h/FmTq9WZgrIsJYQDxz8Ryd1Euic5CUyFde7OGgk8YgE8lLw/EGLcAvumCiT0
         qlljtcU1kWkUHKFfZwvwp963v9BU7ZLnzgmt6r6E5zh4hpjum24E2tKQrYlGT9pYecGq
         sdNnjBOlWra4xSbzpA/x1vW3D8OwQ4oRg7nyKuK+YbA8scqb7ULmtjPHQ37E9jnQy8vg
         /lHg==
X-Gm-Message-State: AFeK/H0AoG37ZKoypExPZry05UpgiQn6QWfBz2UdGLevEv9lSsfCyE0MMHaYBQW0a0RL+AlcxMc89taurweh7g==
X-Received: by 10.36.103.9 with SMTP id u9mr3526827itc.91.1489866579577; Sat,
 18 Mar 2017 12:49:39 -0700 (PDT)
MIME-Version: 1.0
Received: by 10.107.130.208 with HTTP; Sat, 18 Mar 2017 12:49:19 -0700 (PDT)
In-Reply-To: <xmqqmvci2zoc.fsf@gitster.mtv.corp.google.com>
References: <20170318103256.27141-1-avarab@gmail.com> <20170318103256.27141-4-avarab@gmail.com>
 <xmqqmvci2zoc.fsf@gitster.mtv.corp.google.com>
From:   =?UTF-8?B?w4Z2YXIgQXJuZmrDtnLDsCBCamFybWFzb24=?= <avarab@gmail.com>
Date:   Sat, 18 Mar 2017 20:49:19 +0100
Message-ID: <CACBZZX5LN8nhs85K18XVg4Y9_qb9zKGBoFnnQHSsRZVOP=OkDw@mail.gmail.com>
Subject: Re: [PATCH 3/8] tag: Change misleading --list <pattern> documentation
To:     Junio C Hamano <gitster@pobox.com>
Cc:     Git Mailing List <git@vger.kernel.org>,
        Lars Hjemli <hjemli@gmail.com>, Jeff King <peff@peff.net>,
        Christian Couder <christian.couder@gmail.com>,
        Carlos Rica <jasampler@gmail.com>,
        Samuel Tardieu <sam@rfc1149.net>,
        Tom Grennan <tmgrennan@gmail.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: quoted-printable
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

On Sat, Mar 18, 2017 at 7:43 PM, Junio C Hamano <gitster@pobox.com> wrote:
> =C3=86var Arnfj=C3=B6r=C3=B0 Bjarmason  <avarab@gmail.com> writes:
>
>> However, documenting this as "-l <pattern>" was never correct, as
>> these both worked before Jeff's change:
>>
>>     git tag -l 'v*'
>>     git tag 'v*' -l
>
> Actually, we do not particularly care about the latter, and quite
> honestly, I'd prefer we do not advertise and encourage the latter.
> Most Git commands take dashed options first and then non-dashed
> arguments, and so should "git tag".  A more important example to
> show why "-l <pattern>" that pretends <pattern> is an argument to
> the option is wrong is this:

I for one do care about the latter in my CLI use. I.e. I'm fairly used
to GNU-style getopt parsing where if you type "ls foo*" and forget the
-l you don't have to "^Mb-l <RET>" to produce "ls -l foo*" as you
would on the BSD's, you just type " -l<RET>".

I don't see any reason for why we'd force users to migrate to strict
BSD-like getopt parsing for commands like tag/branch which accept
these form of arguments, although one could argue that it's worth it
for consistency with the likes of git-log might have better reasons to
require it.

I.e. are there cases where we encounter genuine ambiguities in our
option parsing because of this that don't involve the usual suspect of
e.g. pattern that starts with "-" needing "<opts> -- <pattern>" to
resolve the ambiguity?

As for this patch, I don't think accurately documenting an option like
--list in terms of what it actually does is advertising and
encouraging this use. All the examples are still of the form "git tag
-l <pattern>" not "git tag <pattern> -l".

I think the main point of reference documentation like this should be
to accurately and exhaustively document what something actually does.
If we'd like to change it & deprecate some mode of operation in the
future, fine, but surely the first step towards that is to document
what the command does *now*.

You should be able to look at a git command, then read the
documentation, and without having run the command or inspected the
code be confident that you understand what the command will do when
you run it.

Right now that isn't the case with "tag --list" at all, because it's
documented as taking a pattern as an argument, but that isn't how it
works.

>         git tag -l --merged X 'v*'
>
> and this one
>
>>     git tag --list 'v*rc*' '*2.8*'
>
>> diff --git a/t/t7004-tag.sh b/t/t7004-tag.sh
>> index 74fc82a3c0..d36cd51fe2 100755
>> --- a/t/t7004-tag.sh
>> +++ b/t/t7004-tag.sh
>> @@ -118,6 +118,18 @@ test_expect_success 'listing all tags if one exists=
 should succeed' '
>>       git tag
>>  '
>>
>> +cat >expect <<EOF
>> +mytag
>> +EOF
>> +test_expect_success 'Multiple -l or --list options are equivalent to on=
e -l option' '
>> +     git tag -l -l >actual &&
>> +     test_cmp expect actual &&
>> +     git tag --list --list >actual &&
>> +     test_cmp expect actual &&
>> +     git tag --list -l --list >actual &&
>> +     test_cmp expect actual
>> +'
>
> OK.  I do not care too deeply about this one, but somebody may want
> to tighten up the command line parsing to detect conflicting or
> duplicated cmdmode as an error in the future, and at that time this
> will require updating.  I am not sure if we want to promise that
> giving multiple -l will keep working.
>
>> +test_expect_success 'tag -l can accept multiple patterns interleaved wi=
th -l or --list options' '
>> +     git tag -l "v1*" "v0*" >actual &&
>
> This is good thing to promise that we will keep it working.
>
>> +     test_cmp expect actual &&
>> +     git tag -l "v1*" --list "v0*" >actual &&
>> +     test_cmp expect actual &&
>> +     git tag -l "v1*" "v0*" -l --list >actual &&
>> +     test_cmp expect actual
>
> I'd prefer we do *not* promise that it will keep working if you give
> pattern and then later any dashed-option like -l to the command by
> having tests like these.

To continue the above, I don't agree with this take on the issue at
all. We should as much as possible aim for full coverage on our tests,
just because something's tested for doesn't implicitly mean that
there's a future promise that the functionality will always work that
way, it's just testing for both intentional & unintentional
regressions when the code is changed.

Then if we decide to e.g. change to stricter parsing or BSD-style
parsing we'll hopefully have an exhaustive list of the cases we're
changing.

It might make sense in cases where we're testing for a feature that
might get deprecated in the future to have some test prefix for that,
i.e. similar to "test_must_fail" but "test_might_get_deprecated" or
whatever.

Although that might just as likely turn out to be a useless catalog of
things we never actually end up changing, see e.g. that TODO test for
the exit code of "git tag -l" which I removed at the start of this
series.
