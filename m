Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.2 (2018-09-13) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-3.1 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	FROM_EXCESS_BASE64,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,
	RCVD_IN_DNSWL_HI shortcircuit=no autolearn=ham autolearn_force=no
	version=3.4.2
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 862591F87F
	for <e@80x24.org>; Mon, 19 Nov 2018 21:37:54 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1731213AbeKTID2 (ORCPT <rfc822;e@80x24.org>);
        Tue, 20 Nov 2018 03:03:28 -0500
Received: from mail-ed1-f66.google.com ([209.85.208.66]:35231 "EHLO
        mail-ed1-f66.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1731062AbeKTID2 (ORCPT <rfc822;git@vger.kernel.org>);
        Tue, 20 Nov 2018 03:03:28 -0500
Received: by mail-ed1-f66.google.com with SMTP id x30so177408edx.2
        for <git@vger.kernel.org>; Mon, 19 Nov 2018 13:37:51 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:references:user-agent:in-reply-to:date
         :message-id:mime-version:content-transfer-encoding;
        bh=A/W+3EiNbR8rv0YSnSBqTu6mq5tCqt6bBQEPN7ub9Rw=;
        b=qHOyPsEJsYWqmmtynx2NmGgQU4GnkcxMFiRrrIHm5Mn0WXAYkWit/VjdAzMvc9zXjy
         Hv33kMoFADtU+ED4+KLH8NYRZYMsHSfkb4pETK7DaDwhe+kg3+Hv4wz2q29hnd7RkQYs
         PKSQh2tgbdHpx1BGHhD+MZQhXXyXvI1nMOUiZMI0EPv1qRmydtJYTBae1muISV1rNRV3
         FvL2cJqihDqya0PbzSmOfpVCXFm2qnuGTBxrgEVS3sVAV2Q0ve24nP9I8LBEClxlpGDi
         7eUNGpotgeq5AINX1NWxU76yll+7a82NRy9akzKR61tswSLSbHc9JbAJXF9JYDqTaVy8
         ZGIA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:references:user-agent
         :in-reply-to:date:message-id:mime-version:content-transfer-encoding;
        bh=A/W+3EiNbR8rv0YSnSBqTu6mq5tCqt6bBQEPN7ub9Rw=;
        b=N0cxuWLWBfyqiYRdg16xasAiww78eNQMJ7S8jyPbm0R4LkdMmuqpmFCDHsLZtB4a0f
         LGMaA0zjAIyQIcWmftVXCTydSRqFHyyD2L4tWNLhl5v4Q/mvVQjZPRand83jmyDJAazz
         j3j+6SHhACrYaDUoedvTbBOphiuvUY0ZZv4hkUJMi89ylzs9dz9CTxWNzXXf/9vmHWwC
         sj7zMzIFPj+lzWIzv/CpddwQFVVbqOtrZ18JnvXIlpB7D7eOz6jskizKyopQFnpI3xJc
         YdC6CRq5h0PER8yI8d0nxN+BdL7x5bnLwwbT/G7ftMU43Z3DONmhgcNC8zk73LO8bCq2
         AsqQ==
X-Gm-Message-State: AGRZ1gIO/sU/mrmg1FW9I22NyriB+C7/T9q3ldNidRdXIfW7AlIi63a6
        LbQKw8+3HJEKdkDkqsG7mjoC3adKiHE=
X-Google-Smtp-Source: AJdET5cEtkvTg3RTIXFteaDIbFNwU143j7CnDbYbmu9jXKJgfZe8USzTdV8OgqrbOaGLULyXXLn6vg==
X-Received: by 2002:a50:f61e:: with SMTP id c30mr20783003edn.197.1542663470840;
        Mon, 19 Nov 2018 13:37:50 -0800 (PST)
Received: from evledraar (ip545586d2.adsl-surfen.hetnet.nl. [84.85.134.210])
        by smtp.gmail.com with ESMTPSA id b42-v6sm13342517edd.81.2018.11.19.13.37.49
        (version=TLS1_2 cipher=ECDHE-RSA-CHACHA20-POLY1305 bits=256/256);
        Mon, 19 Nov 2018 13:37:50 -0800 (PST)
From:   =?utf-8?B?w4Z2YXIgQXJuZmrDtnLDsA==?= Bjarmason <avarab@gmail.com>
To:     Derrick Stolee <stolee@gmail.com>
Cc:     "git\@vger.kernel.org" <git@vger.kernel.org>,
        Johannes Schindelin <Johannes.Schindelin@gmx.de>
Subject: Re: Git Test Coverage Report (v2.20.0-rc0)
References: <9e293b1b-1845-1772-409b-031c0bf4d17b@gmail.com>
        <871s7g29zy.fsf@evledraar.gmail.com>
        <6f0ff2e3-4019-1dcc-f61a-cd0919b9a247@gmail.com>
        <874lcd1bub.fsf@evledraar.gmail.com>
User-agent: Debian GNU/Linux testing (buster); Emacs 25.2.2; mu4e 1.1.0
In-reply-to: <6f0ff2e3-4019-1dcc-f61a-cd0919b9a247@gmail.com>
Date:   Mon, 19 Nov 2018 22:37:49 +0100
Message-ID: <87va4szr2q.fsf@evledraar.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: 8bit
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org


On Mon, Nov 19 2018, Derrick Stolee wrote:

> On 11/19/2018 1:33 PM, Ævar Arnfjörð Bjarmason wrote:
>> On Mon, Nov 19 2018, Derrick Stolee wrote:
>>
>>> [...]
>>> builtin/rebase.c
>>> 62c23938fa 55) return env;
>>> [...]
>>> Ævar Arnfjörð Bjarmason 62c23938f: tests: add a special setup
>>> where rebase.useBuiltin is off
>> This one would be covered with
>> GIT_TEST_REBASE_USE_BUILTIN=false. Obviously trivial, but I wonder if
>> the rest of the coverage would look different when passed through the various GIT_TEST_* options.
>>
>
> Thanks for pointing out this GIT_TEST_* variable to me. I had been
> running builds with some of them enabled, but didn't know about this
> one.
>
> Unfortunately, t3406-rebase-message.sh fails with
> GIT_TEST_REBASE_USE_BUILTIN=false and it bisects to 4520c2337: Merge
> branch 'ab/rebase-in-c-escape-hatch'.
>
> The issue is that the commit 04519d72 "rebase: validate -C<n> and
> --whitespace=<mode> parameters early" introduced the following test
> that cares about error messages:
>
> +test_expect_success 'error out early upon -C<n> or --whitespace=<bad>' '
> + test_must_fail git rebase -Cnot-a-number HEAD 2>err &&
> + test_i18ngrep "numerical value" err &&
> + test_must_fail git rebase --whitespace=bad HEAD 2>err &&
> + test_i18ngrep "Invalid whitespace option" err
> +'
>
> The merge commit then was the first place where this test could run
> with that variable.

Yup. Sorry should have mentioned that, it's broken in master. Reported
it earlier today:
https://public-inbox.org/git/874lcd1bub.fsf@evledraar.gmail.com/

> What's the correct fix here? Force the builtin rebase in this test?
> Unify the error message in the non-builtin case?

Probably to just force the builtin, unless Johannes wants to also fix
the bug for the shellscript version. I don't know if for 2.20 we're
trying to maintain 100% compatibility.
