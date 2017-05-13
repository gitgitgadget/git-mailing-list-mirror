Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-2.7 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_HI,RCVD_IN_SORBS_SPAM,
	RP_MATCHES_RCVD shortcircuit=no autolearn=no autolearn_force=no version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id B7164201A4
	for <e@80x24.org>; Sat, 13 May 2017 11:34:13 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1752718AbdEMLeL (ORCPT <rfc822;e@80x24.org>);
        Sat, 13 May 2017 07:34:11 -0400
Received: from mail-it0-f66.google.com ([209.85.214.66]:33469 "EHLO
        mail-it0-f66.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1752054AbdEMLeK (ORCPT <rfc822;git@vger.kernel.org>);
        Sat, 13 May 2017 07:34:10 -0400
Received: by mail-it0-f66.google.com with SMTP id l145so7273118ita.0
        for <git@vger.kernel.org>; Sat, 13 May 2017 04:34:10 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=mime-version:in-reply-to:references:from:date:message-id:subject:to
         :cc:content-transfer-encoding;
        bh=aEqpyCfEld4RnFRIHyOICUp2JWRDaBzDMrnlqCuNGC8=;
        b=R5XoDlxa3553lS0InilaLiTtWaTSm1vgTFYvllkuMLvcs7bWHQy4pSLgYvLasYUtea
         mzoNTY2HBaETkner5dw8ytYIP41hyo9TDb9otx6heMLKY5jgTZWbW/Aqzkm5DamsSkLP
         yoeNWs5n/MaqcBGrLaWbwj0zZrPmIoGMnshvyH5napbrivCQj6q6B44w7sdNVSpbUK+O
         FDWQxIGwe6S0L17HY1zFoSDPG4nfwlvV8JTfi5nzRBWUPGfYIWAfzIS9jnR0aHzU+4nw
         TaOfuk7t7hsKYFTnkQzNRwVHmzrcp+coNXT6RxySzDUw/ViHijhC3zG4gqJc3k2RQzaX
         AcDw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:in-reply-to:references:from:date
         :message-id:subject:to:cc:content-transfer-encoding;
        bh=aEqpyCfEld4RnFRIHyOICUp2JWRDaBzDMrnlqCuNGC8=;
        b=MMYB7+ELvVQnY2/HHw5mqFuzmawcvI64FMw9E1JGogc2NnW8aikNPgS/JHyIdbInGK
         4NHzljngBoTFGFwbFCMj6ETsm2nU7lJy5P2ak5FK+VbKThZv34YJ5u/MvgCh+b1nU+vy
         MNhWKx71dCpBOC/C6XkR8c9XsvJMM6QZJWtF4wVGO2zuyLLZwJY6CKiAYts1Ke6hfz4C
         zYTrXSFFGj4c1YaFMsbgVNXWS4x6/7RVwZhQSBa6TPRp7i8Op2EG8pNKE5m5AQTtau36
         F7d39Bqq8iLOcB5K/u1Qb4T+VEg4CD6RoVp6DPu00DIE4qQ6o1XovopXx6PBo96E4suQ
         u9jQ==
X-Gm-Message-State: AODbwcAYA6dStAaXUuLX/Ho1UCXaq7gjUlYi/VIIr5lZNKwIMUa2N94c
        CCgxHzFyl6DyAym433lkFjI/FeqTlQ==
X-Received: by 10.36.138.131 with SMTP id v125mr1048962itd.66.1494675249833;
 Sat, 13 May 2017 04:34:09 -0700 (PDT)
MIME-Version: 1.0
Received: by 10.107.8.220 with HTTP; Sat, 13 May 2017 04:33:49 -0700 (PDT)
In-Reply-To: <xmqqlgq27jgl.fsf@gitster.mtv.corp.google.com>
References: <20170511091829.5634-1-avarab@gmail.com> <20170511091829.5634-12-avarab@gmail.com>
 <xmqqlgq27jgl.fsf@gitster.mtv.corp.google.com>
From:   =?UTF-8?B?w4Z2YXIgQXJuZmrDtnLDsCBCamFybWFzb24=?= <avarab@gmail.com>
Date:   Sat, 13 May 2017 13:33:49 +0200
Message-ID: <CACBZZX4MK8=YixozpbPjJh1JxHcFr9x6GoXJeA34E-qLn6ZSDw@mail.gmail.com>
Subject: Re: [PATCH 11/29] grep: add a test helper function for less verbose
 -f \0 tests
To:     Junio C Hamano <gitster@pobox.com>
Cc:     Git Mailing List <git@vger.kernel.org>, Jeff King <peff@peff.net>,
        Jeffrey Walton <noloader@gmail.com>,
        =?UTF-8?Q?Micha=C5=82_Kiedrowicz?= <michal.kiedrowicz@gmail.com>,
        J Smith <dark.panda@gmail.com>,
        Victor Leschuk <vleschuk@gmail.com>,
        =?UTF-8?B?Tmd1eeG7hW4gVGjDoWkgTmfhu41jIER1eQ==?= 
        <pclouds@gmail.com>, Fredrik Kuivinen <frekui@gmail.com>,
        Brandon Williams <bmwill@google.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

On Fri, May 12, 2017 at 7:06 AM, Junio C Hamano <gitster@pobox.com> wrote:
> =C3=86var Arnfj=C3=B6r=C3=B0 Bjarmason  <avarab@gmail.com> writes:
>
>> Add a helper function to make the tests which check for patterns with
>> \0 in them more succinct. Right now this isn't a big win, but
>> subsequent commits will add a lot more of these tests.
>>
>> The helper is based on the match() function in t3070-wildmatch.sh.
>>
>> Signed-off-by: =C3=86var Arnfj=C3=B6r=C3=B0 Bjarmason <avarab@gmail.com>
>> ---
>>  t/t7008-grep-binary.sh | 58 +++++++++++++++++++++++++------------------=
-------
>>  1 file changed, 29 insertions(+), 29 deletions(-)
>>
>> diff --git a/t/t7008-grep-binary.sh b/t/t7008-grep-binary.sh
>> index 9c9c378119..6c1952eafa 100755
>> --- a/t/t7008-grep-binary.sh
>> +++ b/t/t7008-grep-binary.sh
>> @@ -4,6 +4,29 @@ test_description=3D'git grep in binary files'
>>
>>  . ./test-lib.sh
>>
>> +nul_match() {
>
> Micronit: "nul_match () {"
>
>> +     status=3D$1
>> +     flags=3D$2
>> +     pattern=3D$3
>> +     pattern_human=3D$(echo $pattern | sed 's/Q/<NUL>/g')
>
> Double quote around "$pattern"?
>
>> +
>> +     if test $status =3D "1"
>
> Double quote around "$status" and drop double quote around "1"
> (which is clearly a literal string without any funnies) instead?
>
>> +     then
>> +             test_expect_success "git grep -f f $flags '$pattern_human'=
 a" "
>> +                     printf '$pattern' | q_to_nul >f &&
>> +                     git grep -f f $flags a
>> +             "
>> +     elif test $status =3D "0"
>> +     then
>> +             test_expect_success "git grep -f f $flags '$pattern_human'=
 a" "
>> +                     printf '$pattern' | q_to_nul >f &&
>> +                     test_must_fail git grep -f f $flags a
>> +             "

All changed in v2.

> It somehow was unintuitive that 0 expected failure and 1 expected
> success, but it probably was just me.

Except this. The wildmatch uses the same idiom, and I think it makes
sense. 1 =3D true, 0 =3D false, not 0 =3D exit zero, 1 =3D exit nonzero, wh=
ich
would also be IMO a bit more confusing since it should really be 0 and
!0 if you don't want to rely on specific non-zero exit codes, which is
just going down a garden path of complexity when all we wanted was
"does this match".
