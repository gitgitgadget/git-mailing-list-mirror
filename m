Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-3.4 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_HI,T_RP_MATCHES_RCVD
	shortcircuit=no autolearn=no autolearn_force=no version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 0EE531F404
	for <e@80x24.org>; Wed,  3 Jan 2018 09:45:49 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1751920AbeACJpq (ORCPT <rfc822;e@80x24.org>);
        Wed, 3 Jan 2018 04:45:46 -0500
Received: from mail-wm0-f65.google.com ([74.125.82.65]:37107 "EHLO
        mail-wm0-f65.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1751335AbeACJpn (ORCPT <rfc822;git@vger.kernel.org>);
        Wed, 3 Jan 2018 04:45:43 -0500
Received: by mail-wm0-f65.google.com with SMTP id f140so1647501wmd.2
        for <git@vger.kernel.org>; Wed, 03 Jan 2018 01:45:43 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=mime-version:subject:from:in-reply-to:date:cc
         :content-transfer-encoding:message-id:references:to;
        bh=0Zr1TsEZVAhxSSV4+ld2mMe7sDhWNxS9ym74RL469z4=;
        b=U5LvXokGrVT/4nQ3MIhy70cAH27WrVh6LeO6Pm/Ida3PQFHIDW1at3WSCRiirNiEmB
         9N0W9r7l9nBWhMy/8xvggmaPS3uuzCVxAdbpAqQ/xAXTGYHXhQlk6YzRTtdq/F6brcW6
         T85aXGSCJ3sRKW3W4zbPybyUm9ISXWSYbjrMhewwTYKVTm7puH3KllEnBdMBrkVYnxHZ
         da6ZfKbBmhtZFFlJWzVIUWDPcPICQktvBRPr95j7S4s+OJtWAX8xjHP4hf5VXtUzjvXL
         1PXlG+2zQ0X4YEwYV0tboI6AqmakLkKL1Wlz1ogVtBUQY7W49k2yk0j9z7aEo07YJ0+7
         8bBw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:subject:from:in-reply-to:date:cc
         :content-transfer-encoding:message-id:references:to;
        bh=0Zr1TsEZVAhxSSV4+ld2mMe7sDhWNxS9ym74RL469z4=;
        b=gXiuEflVHTxstE2I5/Mn5I3AYdbeEIUlVodPppfKlYPtp+F6pD9iz0pRtIiqUr7mWa
         K5msr6dSMDQvreAVH2ZnBof4jUDeHpZqxIzAaFXv9v8apUVCVuVy490SUXAxnSZsJ7yI
         DrTnf42dd8E0x+s/a12HffsK/t2oWDooqSxalR3tES2y2x+8zZ+uX+kr3MZ2SUYIyh2N
         oVEfkiS2wCCTz55nLJJNlVOhLGEy5b8L9ErWXftmkYUcG4jhtajMTxX4WFcXplqbMZX6
         UnYjbMFBK3TKrkJYcRQkwsZA0x6SNKfVlV/fLm+k8OibO3Z5S1/I2BKTH382i+FR3FLd
         Q59w==
X-Gm-Message-State: AKGB3mLROGwhKvWYFFAdWeYALYQub6FKQj1xjQnukAqtEFEmQ57uFywG
        KQuTYPdaqWau+FxAJaVhr5Q=
X-Google-Smtp-Source: ACJfBotW41qaUNTfD+zScgQwtECcH9QIZAb9qWXP4I/g6YlIrx+/yT1tSnD3Wrb1UjLx5M2EnkuVnQ==
X-Received: by 10.28.221.138 with SMTP id u132mr859044wmg.113.1514972742510;
        Wed, 03 Jan 2018 01:45:42 -0800 (PST)
Received: from slxbook4.fritz.box (p5DDB59EF.dip0.t-ipconnect.de. [93.219.89.239])
        by smtp.gmail.com with ESMTPSA id c2sm1722194wrc.81.2018.01.03.01.45.41
        (version=TLS1 cipher=ECDHE-RSA-AES128-SHA bits=128/128);
        Wed, 03 Jan 2018 01:45:41 -0800 (PST)
Content-Type: text/plain; charset=utf-8
Mime-Version: 1.0 (Mac OS X Mail 9.3 \(3124\))
Subject: Re: [PATCH 2/2] travis-ci: check that all build artifacts are .gitignore-d
From:   Lars Schneider <larsxschneider@gmail.com>
In-Reply-To: <CAM0VKjmj7VGr5rcON=2VEug-fGtBrvNqhopH9x7pjB237V796g@mail.gmail.com>
Date:   Wed, 3 Jan 2018 10:45:42 +0100
Cc:     Git mailing list <git@vger.kernel.org>,
        Junio C Hamano <gitster@pobox.com>
Content-Transfer-Encoding: quoted-printable
Message-Id: <041D7B2A-F7C2-4842-9A83-2020CEAC3B75@gmail.com>
References: <20171231160206.19481-1-szeder.dev@gmail.com> <20171231160206.19481-3-szeder.dev@gmail.com> <D977F37C-D0E5-4EEB-98B4-693A5179F7B1@gmail.com> <CAM0VKjmj7VGr5rcON=2VEug-fGtBrvNqhopH9x7pjB237V796g@mail.gmail.com>
To:     =?utf-8?Q?SZEDER_G=C3=A1bor?= <szeder.dev@gmail.com>
X-Mailer: Apple Mail (2.3124)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org


> On 03 Jan 2018, at 00:12, SZEDER G=C3=A1bor <szeder.dev@gmail.com> =
wrote:
>=20
> On Tue, Jan 2, 2018 at 8:40 PM, Lars Schneider =
<larsxschneider@gmail.com> wrote:
>>=20
>>> On 31 Dec 2017, at 17:02, SZEDER G=C3=A1bor <szeder.dev@gmail.com> =
wrote:
>>>=20
>>> Every once in a while our explicit .gitignore files get out of sync
>>> when our build process learns to create new artifacts, like test
>>> helper executables, but the .gitignore files are not updated
>>> accordingly.
>>>=20
>>> Use Travis CI to help catch such issues earlier: check that there =
are
>>> no untracked files at the end of any build jobs building Git (i.e. =
the
>>> 64 bit Clang and GCC Linux and OSX build jobs, plus the =
GETTEXT_POISON
>>> and 32 bit Linux build jobs) or its documentation, and fail the =
build
>>> job if there are any present.
>>>=20
>>> Signed-off-by: SZEDER G=C3=A1bor <szeder.dev@gmail.com>
>>> ---
>>> ci/lib-travisci.sh       | 10 ++++++++++
>>> ci/run-linux32-docker.sh |  2 ++
>>> ci/run-tests.sh          |  2 ++
>>> ci/test-documentation.sh |  6 ++++++
>>> 4 files changed, 20 insertions(+)
>>>=20
>>> diff --git a/ci/lib-travisci.sh b/ci/lib-travisci.sh
>>> index 1543b7959..07f27c727 100755
>>> --- a/ci/lib-travisci.sh
>>> +++ b/ci/lib-travisci.sh
>>> @@ -67,6 +67,16 @@ skip_good_tree () {
>>>      exit 0
>>> }
>>>=20
>>> +check_unignored_build_artifacts ()
>>> +{
>>> +     ! git ls-files --other --exclude-standard --error-unmatch \
>>> +             -- ':/*' 2>/dev/null ||
>>=20
>> What does "-- ':/*'" do?
>=20
> It makes the whole thing work :)
> ':/*' is a pattern matching all paths, and '--others =
--exclude-standard'
> limit the command to list files that are both untracked and unignored.
> '--error-unmatch' causes the command to error out if any of the files
> given on the command line doesn't match anything in the working tree,
> in this case if there are no untracked-unignored files.  Without a =
path
> given on the cmdline '--error-unmatch' has basically no effect[1].

That was the missing piece. Thank you! I've used the exact command =
before=20
but I've never looked at the exit code. I just assumed that it would
behave like grep if there is no match (as you described in [1])


> In a clean worktree:
>=20
>  $ git ls-files --other --exclude-standard --error-unmatch ; echo $?
>  0
>  $ git ls-files --other --exclude-standard --error-unmatch ':/*' ; =
echo $?
>  error: pathspec ':/*' did not match any file(s) known to git.
>  Did you forget to 'git add'?
>  1
>=20
> The disambiguating double-dash is not really necessary, because the =
:/*
> pattern can't be confused with any --options, but doesn't hurt, =
either.
>=20
>> Plus, why do you redirect stderr?
>=20
> To prevent the above error message from appearing in the trace log of =
a
> successful build.

Makes sense. As I never specified the path, I did never see the error =
:-)


> [1] - Which makes me think whether we should consider =
'--error-unmatch'
>      without any paths given on the command line as an error.

Agreed!


- Lars=
