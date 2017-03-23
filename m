Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-3.1 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_HI,RP_MATCHES_RCVD
	shortcircuit=no autolearn=ham autolearn_force=no version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 4A28820958
	for <e@80x24.org>; Thu, 23 Mar 2017 20:37:43 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S935015AbdCWUhl (ORCPT <rfc822;e@80x24.org>);
        Thu, 23 Mar 2017 16:37:41 -0400
Received: from mail-io0-f194.google.com ([209.85.223.194]:35990 "EHLO
        mail-io0-f194.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S934994AbdCWUhk (ORCPT <rfc822;git@vger.kernel.org>);
        Thu, 23 Mar 2017 16:37:40 -0400
Received: by mail-io0-f194.google.com with SMTP id 68so781433ioh.3
        for <git@vger.kernel.org>; Thu, 23 Mar 2017 13:37:39 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=mime-version:in-reply-to:references:from:date:message-id:subject:to
         :cc:content-transfer-encoding;
        bh=OV9p9XqrwznuXD+qBbE5/PT4Wyf4WX35B2W32H47fjU=;
        b=q9RT/CxuSxdLRnyu098Epvxk0CmSF3lQJb5gUM+cdPmT7MuwtTWnHvOO8AWZ9oqcev
         m7WBlPA5u63ynZrYRGlHCLEpZd5eFPj+cD39DOvLiDvSp7zbpWt2XRHyozaOjh+ZyaJd
         0OiITa4chZCARkofcy97G4C/cK4YVSkDkHFvmQ7AIVXOEqX1PodOj1UpxRKv3DXYzgI2
         blPNWPR2lDZBR7UhZ+QN59PMg62xPXFOV0Ewg9X2NACqReVIhK45nsdOL3AjIT5nmTQV
         k0GVkcBPG+PCPbuemCxsg6pom9od03hGAI8tPXSZYKOwA5VGYQSKV2/4/zC5D6SY5ULd
         uGYg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:in-reply-to:references:from:date
         :message-id:subject:to:cc:content-transfer-encoding;
        bh=OV9p9XqrwznuXD+qBbE5/PT4Wyf4WX35B2W32H47fjU=;
        b=Av1XY6D6MtI4dIYBoTwbEBSKPv3+EsmWflFHonj8VlPW/YjMDisP/bYhFkUI8yTEWm
         3O1XFIdGPvI8oRvM1zorkXPYtA/K40lQbvrqZuz5OnHxvgajeWd6kwwMjOnAaTwoKFmd
         CRRvFPzMDuF1kE1BMF9ruiYTQlcEo/eA3SUNF+TxsrPey5ryHdrJnGSOMfInPAPzGj8Z
         aevm/+5qPqHVeMOQ4Gj2+5aGfXDZvmAY8pUOH5krxkFQiBkxNTVKJ2x1gl3RX+PpxN/k
         sk36SyxFOp5lXkPt0oJMiqWXd37BAzm8Th1VjhMBLJ8XnSIP7kMCPgPq3I52wLZsfldM
         Pgzg==
X-Gm-Message-State: AFeK/H0It4Yg6aoDjoiPeRh9IqfgjBjiG3pIv6anw/tieL3qEGuMnQCYx3iL8RJwqftYaETahOBHKdDSu06Xvw==
X-Received: by 10.107.150.201 with SMTP id y192mr5197429iod.33.1490301458950;
 Thu, 23 Mar 2017 13:37:38 -0700 (PDT)
MIME-Version: 1.0
Received: by 10.107.130.208 with HTTP; Thu, 23 Mar 2017 13:37:18 -0700 (PDT)
In-Reply-To: <xmqqtw6jex0o.fsf@gitster.mtv.corp.google.com>
References: <20170323130529.11361-1-avarab@gmail.com> <20170323130529.11361-10-avarab@gmail.com>
 <xmqqtw6jex0o.fsf@gitster.mtv.corp.google.com>
From:   =?UTF-8?B?w4Z2YXIgQXJuZmrDtnLDsCBCamFybWFzb24=?= <avarab@gmail.com>
Date:   Thu, 23 Mar 2017 21:37:18 +0100
Message-ID: <CACBZZX5wFaSdeXGxGNMK4j_OoEJ_Zt08vAYRosSwnJVs9K+Lng@mail.gmail.com>
Subject: Re: [PATCH v3 09/16] tag: add more incompatibles mode tests
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

On Thu, Mar 23, 2017 at 6:13 PM, Junio C Hamano <gitster@pobox.com> wrote:
> =C3=86var Arnfj=C3=B6r=C3=B0 Bjarmason  <avarab@gmail.com> writes:
>
>> Amend the test suite to test for more invalid uses like "-l -a"
>> etc. This change tests this code path in builtin/tag.c:
>>
>>     `(argc =3D=3D 0 && !cmdmode)`
>>     ->
>>     `((create_tag_object || force) && (cmdmode !=3D 0))`
>
> What is this notation trying to tell us?  A range of lines starting
> with the first one to the second one?

Yeah.

> If so perhaps
>
>         Add tests to detect more invalid combinations like "-a -l",
>         to test code that defaults to the list mode when no other
>         conflicting options are given and that detects conflicting
>         requests.

I think the only people who'll ever dig up this commit is someone
trying to figure out why one of these invocations dies after 'git
blame'-ing this code. Surely it'll be more useful to them to see what
specific code this was aiming to test, rather than having more vague
prose like that...

> would be easier to understand, I would think.
>
>> Signed-off-by: =C3=86var Arnfj=C3=B6r=C3=B0 Bjarmason <avarab@gmail.com>
>> ---
>>  t/t7004-tag.sh | 16 ++++++++++++++++
>>  1 file changed, 16 insertions(+)
>>
>> diff --git a/t/t7004-tag.sh b/t/t7004-tag.sh
>> index 63ee2cf727..92af8bb7e6 100755
>> --- a/t/t7004-tag.sh
>> +++ b/t/t7004-tag.sh
>> @@ -1455,8 +1455,24 @@ test_expect_success 'checking that initial commit=
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
>> +     test_must_fail git tag -l -d &&
>> +     test_must_fail git tag -l -v -d &&
>>       test_must_fail git tag -n 100 &&
>> +     test_must_fail git tag -n 100 -v &&
>>       test_must_fail git tag -l -m msg &&
>>       test_must_fail git tag -l -F some file &&
>>       test_must_fail git tag -v -s &&
