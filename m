Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-2.8 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_HI,T_RP_MATCHES_RCVD
	shortcircuit=no autolearn=no autolearn_force=no version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id B1E1B1F428
	for <e@80x24.org>; Fri,  5 Jan 2018 14:19:46 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1751523AbeAEOTo (ORCPT <rfc822;e@80x24.org>);
        Fri, 5 Jan 2018 09:19:44 -0500
Received: from mail-wm0-f48.google.com ([74.125.82.48]:36186 "EHLO
        mail-wm0-f48.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1751365AbeAEOTn (ORCPT <rfc822;git@vger.kernel.org>);
        Fri, 5 Jan 2018 09:19:43 -0500
Received: by mail-wm0-f48.google.com with SMTP id b76so2774251wmg.1
        for <git@vger.kernel.org>; Fri, 05 Jan 2018 06:19:43 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:references:user-agent:in-reply-to:date
         :message-id:mime-version;
        bh=h1jDVMiWXt+94sFIlHNlQ5tQwX738eRtbY8X2z6IuiI=;
        b=IVmSnbM3Zwa+xVIsTkDfQwNZq5XNjdqiGDnHRh3M5fPGP8SF0XM+nZYCUfCcaByYyt
         mTo3M/XPTOj2FEUG5MNl2C3RUm5YwiaWuFk2fQEgBx0/Fjkl8X98rLc1NfP9eg3wUq/L
         djWr7vj/pdH5nrPQ5m2UlAvHEzguP847/GRtWPrROj8eHpn/9vf+/dVhdLvHiRDHVuWD
         zu1c9acApzNenbH+eQEWNVsBJIChEzNb9hAmBQUvXhvwFbSWKhqPCg1fS4UfJz6oFf/k
         lVoUDF6bjqnp8rAKlXb/Tf46uV1UWn9bhFMNkO2i07rc1zANcYhV7KN8aS5KcHu1sfEk
         oJaQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:references:user-agent
         :in-reply-to:date:message-id:mime-version;
        bh=h1jDVMiWXt+94sFIlHNlQ5tQwX738eRtbY8X2z6IuiI=;
        b=mgQxsa0B0KKWui1avyFOiFJYOFf/G5Q76S5PdPUCVf+XWz8D2j2+S6UqJtW82z8788
         3p3u7UDA6Z2aECG5QEJSTRA12CuDSWbGrlXmExbAtRlox6LWleVmCZl1XcLE7D9WfZ+W
         MXhCW6vvjsx+cAz0+0qygngKBZrLLb6ou2+htXMibNHsbSTqW+h1QUL3WHUf6ah71gmj
         IxlpLAXXXHB9rW7uCSqdon/inakX54d5GyQQDbl5aljWIfCnrfu3jOdrcLChMNO2NUpO
         pKL/o3EI94U0MwVK2TxS6obzqrukfu6OgsYPzmBSqDlvzvEewxuiNCuzqP0WZ9Nazq0n
         SVkQ==
X-Gm-Message-State: AKGB3mLRyaTDcAr1vtl/od9sOG1pi8FOCmeGQ2x+RRqWdHfbkn1m4l6Z
        WFqEsnAGG6AYeOSVQRr6cAs=
X-Google-Smtp-Source: ACJfBouWO9pLTFfex07EW2MxKURNu09NYwq+8BQfGKTDoJhzMjfPy7EVYASWqW8v+QWnycFDvhgSEg==
X-Received: by 10.80.134.249 with SMTP id 54mr4309892edu.295.1515161982517;
        Fri, 05 Jan 2018 06:19:42 -0800 (PST)
Received: from evledraar (proxy-gw-a.booking.com. [5.57.21.8])
        by smtp.gmail.com with ESMTPSA id o15sm3965800edk.25.2018.01.05.06.19.41
        (version=TLS1_2 cipher=ECDHE-RSA-CHACHA20-POLY1305 bits=256/256);
        Fri, 05 Jan 2018 06:19:41 -0800 (PST)
From:   =?utf-8?B?w4Z2YXIgQXJuZmrDtnLDsA==?= Bjarmason <avarab@gmail.com>
To:     Matthieu Moy <git@matthieu-moy.fr>
Cc:     git@vger.kernel.org, gitster@pobox.com,
        Alex =?utf-8?Q?Benn=C3=A9e?= <alex.bennee@linaro.org>,
        Thomas Adam <thomas@xteddy.org>
Subject: Re: [RFC PATCH 1/2] add a local copy of Mail::Address from CPAN
References: <1515092151-14423-1-git-send-email-git@matthieu-moy.fr>
User-agent: Debian GNU/Linux 9.3 (stretch); Emacs 25.1.1; mu4e 0.9.19
In-reply-to: <1515092151-14423-1-git-send-email-git@matthieu-moy.fr>
Date:   Fri, 05 Jan 2018 15:19:40 +0100
Message-ID: <87shbkbd6r.fsf@evledraar.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org


On Thu, Jan 04 2018, Matthieu Moy jotted:

> I looked at the perl/Git/Error.pm wrapper, and ended up writting a
> different, much simpler version. I'm not sure the same approach would
> apply to Error.pm, but my straightforward version does the job for
> Mail/Address.pm.

Yeah, yours is much simpler because Mail::Address doesn't have an import
method, which is the entire complexity in the Error.pm wrapper.

I'll probably submit a wrapper-for-the-wrappers patch at some point
after this gets in, i.e. both of these would become:

    package Git::Error;
    use Git::WrapCPAN 'Error';
    1;

    package Git::Mail::Address;
    use Git::WrapCPAN 'Mail::Address';
    1;

Then the Git::WrapCPAN package would do all the magic the Git::Error
wrapper is doing now, but with a configurable package.

But this doesn't have to wait for that.

> I would also be fine with using our local copy unconditionaly.

Some notes on your patch:

 * If I comment out your whole eval/or-do I was puzzled because tests
   still pass, turns out the eval { require Email::Valid } will bring in
   Mail::Address from CPAN.

   Not a bug, just something to note for others poking at this.

 * You didn't update t/t9000/test.pl to use the wrapper, which I thought
   was a bug until I realized this is built on top of
   gitster/mm/send-email-fallback-to-local-mail-address.
