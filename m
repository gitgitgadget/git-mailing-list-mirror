Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-2.9 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_HI,T_RP_MATCHES_RCVD
	shortcircuit=no autolearn=no autolearn_force=no version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id CDEEB1F404
	for <e@80x24.org>; Wed,  7 Feb 2018 19:08:14 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1754320AbeBGTIM (ORCPT <rfc822;e@80x24.org>);
        Wed, 7 Feb 2018 14:08:12 -0500
Received: from mail-wm0-f53.google.com ([74.125.82.53]:40823 "EHLO
        mail-wm0-f53.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1753995AbeBGTIL (ORCPT <rfc822;git@vger.kernel.org>);
        Wed, 7 Feb 2018 14:08:11 -0500
Received: by mail-wm0-f53.google.com with SMTP id v123so5386425wmd.5
        for <git@vger.kernel.org>; Wed, 07 Feb 2018 11:08:10 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:references:user-agent:in-reply-to:date
         :message-id:mime-version:content-transfer-encoding;
        bh=/w6dGK9ds+4QlUi4pPdeud6tlZaiDJscHBgy6O6O9zQ=;
        b=iDAkBgpcKmK86AiKzLjF+JRtylFSfJX3Fb/pH4QV4lHfdqjRC46fZRm990oHUyoRsN
         44cCO+rvfcuDeoWWLjmrYfA/3r/xxeGc6yiG9Q7ieUb/UBJJTrNkK+ygqGS5KyRFvuQb
         kH5jFyeBJc8vFprMhw+d6F4UVlTQeWf6TDhxza5Fs1iQPsyoRsEE8JCLCRplgz481kih
         dP9KFh5HkGlTkYdpCxFMZE/umO7TMRq/PIWjfhq1Ks6S8C93ckokJexFIuWP9yNM83YP
         xjhjdMkJM2AlR4GiRJ7pd8k/FOQHf5MOVfYAj+rgGq5lzzAtNQH3/P7okVTIPKJHjSrp
         lnvg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:references:user-agent
         :in-reply-to:date:message-id:mime-version:content-transfer-encoding;
        bh=/w6dGK9ds+4QlUi4pPdeud6tlZaiDJscHBgy6O6O9zQ=;
        b=dnuy2a/liqRz2OyhQVEk412AqqINx5MvLeiyub8L49p0AV97k8zmnU2qXU0/jktPyG
         dyWYGMJXaW660IWZph+nPEDfoidN86+tlwEoix9D4t76HrBNua4hzoXB4VFophElWr2x
         +eZiK4TwI5R0aJoCC3ecZTq7UDTAicubBJ/mDOnYpmX/cq9sMP9lq8wqoppB0mbzedSH
         52Lw7btwwJlA0TLBg8peAQHISRE2r2znu7E/MCeRvWKFTq4SiVrw/hWCnRVH6U3fTJ9I
         tOwZTKjBAFDWaHZJBMh4T0FFI+iYBJDw/LdZulugVI2ecEfSUKRTXvy2U1MIHGl0A9ct
         hlvA==
X-Gm-Message-State: APf1xPBb0+knmfqi/5H5CZRe4cJtLcDoSIsPRyLACizfDPCHObAglxDO
        iJW3DBjWLRu+oO82/MtDEjk=
X-Google-Smtp-Source: AH8x2266ob8AXS5zF5dvm9VI7Mk4/h4jla4KA96O0uK4/igP9DuKMrKmHYNASFkCOocCwhqyZvBCUA==
X-Received: by 10.80.226.203 with SMTP id q11mr9833546edl.248.1518030490258;
        Wed, 07 Feb 2018 11:08:10 -0800 (PST)
Received: from evledraar (178-84-79-100.dynamic.upc.nl. [178.84.79.100])
        by smtp.gmail.com with ESMTPSA id b12sm1515643eda.81.2018.02.07.11.08.09
        (version=TLS1_2 cipher=ECDHE-RSA-CHACHA20-POLY1305 bits=256/256);
        Wed, 07 Feb 2018 11:08:09 -0800 (PST)
From:   =?utf-8?B?w4Z2YXIgQXJuZmrDtnLDsA==?= Bjarmason <avarab@gmail.com>
To:     Johannes Sixt <j6t@kdbg.org>
Cc:     git@vger.kernel.org, Junio C Hamano <gitster@pobox.com>,
        Ramsay Jones <ramsay@ramsayjones.plus.com>
Subject: Re: [PATCH] t0050: remove the unused $test_case variable
References: <20180206231303.8483-1-avarab@gmail.com> <bf3ad52d-4aa3-8678-9466-3996f6cba11c@kdbg.org> <87fu6dz0h6.fsf@evledraar.gmail.com> <a8bc404e-fca8-6d64-21c4-df6d6879bee7@kdbg.org>
User-agent: Debian GNU/Linux 9.3 (stretch); Emacs 25.1.1; mu4e 1.0-alpha3
In-reply-to: <a8bc404e-fca8-6d64-21c4-df6d6879bee7@kdbg.org>
Date:   Wed, 07 Feb 2018 20:08:08 +0100
Message-ID: <87k1vomxd3.fsf@evledraar.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: 8bit
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org


On Wed, Feb 07 2018, Johannes Sixt jotted:

> Am 07.02.2018 um 09:07 schrieb Ævar Arnfjörð Bjarmason:
>>
>> On Wed, Feb 07 2018, Johannes Sixt jotted:
>>
>>> Am 07.02.2018 um 00:13 schrieb Ævar Arnfjörð Bjarmason:
>>>> The $test_case variable hasn't been used since
>>>> decd3c0c28 ("t0050-*.sh: mark the rename (case change) test as
>>>> passing", 2014-11-28) when its last user went away.
>>>>
>>>> Let's remove the "say" as well, since it's obvious from subsequent
>>>> output that we're testing on a case sensitive filesystem.
>>>
>>> Am I misunderstanding the message? I think it reports properties of
>>> the test environment. And the tests do run on case-insensitive
>>> filesystems. IMO, the message should be kept.
>>
>> It's obvious from subsequent output whether the FS is case sensitive or
>> not, so I thought it was redundant to keep this report at the top since
>> we didn't have the variable setting anymore.
>
> There are test cases that do different things depending on whether the
> CASE_INSENSITIVE_FS prerequisite is set. I think it was the intent to
> report whether it is set and not whether one or the other value of the
> (now unused) variable is used somewhere.
>
> BTW, the message texts do not show which variant is taken (these are
> without your patch):
>
> On Windows:
>
> t>sh t0050-filesystem.sh
> will test on a case insensitive filesystem
> will test on a filesystem lacking symbolic links
> ok 1 - detection of case insensitive filesystem during repo init
> ok 2 - detection of filesystem w/o symlink support during repo init
> ok 3 - setup case tests
> ok 4 - rename (case change)
> ok 5 - merge (case change)
> not ok 6 - add (with different case) # TODO known breakage
> ok 7 - setup unicode normalization tests
> ok 8 - rename (silent unicode normalization)
> ok 9 - merge (silent unicode normalization)
> # still have 1 known breakage(s)
> # passed all remaining 8 test(s)
> 1..9
>
> On Linux:
>
> t@master:1002> ./t0050-filesystem.sh
> ok 1 - detection of case insensitive filesystem during repo init
> ok 2 - detection of filesystem w/o symlink support during repo init
> ok 3 - setup case tests
> ok 4 - rename (case change)
> ok 5 - merge (case change)
> ok 6 # skip add (with different case) (missing CASE_INSENSITIVE_FS)
> ok 7 - setup unicode normalization tests
> ok 8 - rename (silent unicode normalization)
> ok 9 - merge (silent unicode normalization)
> # passed all 9 test(s)
> 1..9
>
> I'd even argue that there should be messages on Linux, too.

Thanks. Let's just drop this patch. I thought it would still print out
something similar to that "missing CASE_INSENSITIVE_FS" at a quick
glance last night, but was obviously wrong.
