Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-2.9 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_HI,RCVD_IN_SORBS_SPAM,
	RP_MATCHES_RCVD shortcircuit=no autolearn=no autolearn_force=no version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 2A7532095B
	for <e@80x24.org>; Tue, 21 Mar 2017 18:58:48 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S933183AbdCUS6l (ORCPT <rfc822;e@80x24.org>);
        Tue, 21 Mar 2017 14:58:41 -0400
Received: from mail-it0-f65.google.com ([209.85.214.65]:35959 "EHLO
        mail-it0-f65.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S933918AbdCUS63 (ORCPT <rfc822;git@vger.kernel.org>);
        Tue, 21 Mar 2017 14:58:29 -0400
Received: by mail-it0-f65.google.com with SMTP id 190so2526092itm.3
        for <git@vger.kernel.org>; Tue, 21 Mar 2017 11:58:28 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=mime-version:in-reply-to:references:from:date:message-id:subject:to
         :cc:content-transfer-encoding;
        bh=AX4FWrYZsEpAi2ROx55AyFqR5qH7UbzBesvTdbtiaRk=;
        b=pCcLTcAzrl985sltNrtmA/4CFpWWIf8sjda8Ixl6EzQ5i0Vs/uXBWyx5InB+YZR9+j
         7OGKiMyOoTrsj+MpSThN35ndWuM5x5+bVtvKd3b6F1PaLdAILH6VRa1Zs0/Tkb1jLJLW
         geFcGIAc3b1hlh4Du6jAAh8QG+uOAO8rbAZHeqDA4jydMUU7b/gfPG7icfra3j4oJIrC
         IPNb5zfazflmCPHgRNMMgrCEQ/B9qExcEX43MSdc48p3VBvV1QfDcwHhgBQNaWsVDI1N
         hOiBqKFayzw6/u0XgI/xbqNw5Vhih34aOOOMJ7K8hpInlbv1M2gjMJsZsoODl7ZZqDWq
         nfeQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:in-reply-to:references:from:date
         :message-id:subject:to:cc:content-transfer-encoding;
        bh=AX4FWrYZsEpAi2ROx55AyFqR5qH7UbzBesvTdbtiaRk=;
        b=GVGuSVgmTDRvFvr5HXPXvmX03IX0Or14oIRBAWA8aWYLtQEpSUTWMgUJjpTUv+nUOS
         iF+lMPaeJ0V6umreJ4AIDDXvvl+dgm7S1chQVBdrUORgFbBDL2fxYoyw35a4BaHG4X9b
         Csk4szZTBrB+ezzfkyQb6Tu6g2Zo3Q8VhhLUgo7wXRnxsBBtmTisr7eOD06/h6TCbQs1
         1Tw8FcsGFvrcVwS/9IRhg4rfTGQcaSpwt28W5oM6N0OgwtWIWyhTvAMsyE3t0ukrLETx
         5nviJ6+jbWiek9oAHplsHFcK9vYdGLGR2l+fLp9yfNZeQidmgodywKraBeLVF4gFO8XI
         zEKA==
X-Gm-Message-State: AFeK/H3cxeQM7zQ0zvUtkDu8QPdAfJWAL3JyXoPfzWrvPQ5/5I9xbEoPOHJGxX/Qc5XKt2X0gNQx4xV4lGJuaA==
X-Received: by 10.36.76.11 with SMTP id a11mr4497803itb.60.1490122707783; Tue,
 21 Mar 2017 11:58:27 -0700 (PDT)
MIME-Version: 1.0
Received: by 10.107.130.208 with HTTP; Tue, 21 Mar 2017 11:58:07 -0700 (PDT)
In-Reply-To: <xmqqshm6pjja.fsf@gitster.mtv.corp.google.com>
References: <20170321125901.10652-1-avarab@gmail.com> <20170321125901.10652-10-avarab@gmail.com>
 <xmqqshm6pjja.fsf@gitster.mtv.corp.google.com>
From:   =?UTF-8?B?w4Z2YXIgQXJuZmrDtnLDsCBCamFybWFzb24=?= <avarab@gmail.com>
Date:   Tue, 21 Mar 2017 19:58:07 +0100
Message-ID: <CACBZZX4jXtYqnsYuHRohF+zx+y0VyyRudMMYjtLuxoCziccd=w@mail.gmail.com>
Subject: Re: [PATCH v2 09/16] tag: add more incompatibles mode tests
To:     Junio C Hamano <gitster@pobox.com>
Cc:     Git Mailing List <git@vger.kernel.org>,
        Lars Hjemli <hjemli@gmail.com>, Jeff King <peff@peff.net>,
        Christian Couder <christian.couder@gmail.com>,
        Carlos Rica <jasampler@gmail.com>,
        Samuel Tardieu <sam@rfc1149.net>,
        Tom Grennan <tmgrennan@gmail.com>,
        Karthik Nayak <karthik.188@gmail.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: quoted-printable
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

On Tue, Mar 21, 2017 at 7:32 PM, Junio C Hamano <gitster@pobox.com> wrote:
> =C3=86var Arnfj=C3=B6r=C3=B0 Bjarmason  <avarab@gmail.com> writes:
>
>> Amend the test suite to test for more invalid uses like "-l -a"
>> etc. This mainly tests the `(argc =3D=3D 0 && !cmdmode)` ->
>> `((create_tag_object || force) && (cmdmode !=3D 0))` code path in
>> builtin/tag.c.
>
> The second sentence is now stale, isn't it?
I've reworded this in WIP v3 to split out the code from the text,
making this less confusing.
>>
>> Signed-off-by: =C3=86var Arnfj=C3=B6r=C3=B0 Bjarmason <avarab@gmail.com>
>> ---
>>  t/t7004-tag.sh | 13 +++++++++++++
>>  1 file changed, 13 insertions(+)
>>
>> diff --git a/t/t7004-tag.sh b/t/t7004-tag.sh
>> index 63ee2cf727..958c77ab86 100755
>> --- a/t/t7004-tag.sh
>> +++ b/t/t7004-tag.sh
>> @@ -1455,6 +1455,19 @@ test_expect_success 'checking that initial commit=
 is in all tags' "
>>
>>  test_expect_success 'mixing incompatibles modes and options is forbidde=
n' '
>>       test_must_fail git tag -a &&
>> +     test_must_fail git tag -a -l &&
>> +     test_must_fail git tag -s &&
>> +     test_must_fail git tag -s -l &&
>> +     test_must_fail git tag -m &&
>> +     test_must_fail git tag -m -l &&
>> +     test_must_fail git tag -m "hlagh" &&
>> +     test_must_fail git tag -m "hlagh" -l &&
>> +     test_must_fail git tag -F &&
>> +     test_must_fail git tag -F -l &&
>> +     test_must_fail git tag -f &&
>> +     test_must_fail git tag -f -l &&
>> +     test_must_fail git tag -a -s -m -F &&
>> +     test_must_fail git tag -a -s -m -F -l &&
>>       test_must_fail git tag -l -v &&
>>       test_must_fail git tag -n 100 &&
>>       test_must_fail git tag -l -m msg &&
