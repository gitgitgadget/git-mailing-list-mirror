Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-2.8 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_HI,T_RP_MATCHES_RCVD
	shortcircuit=no autolearn=no autolearn_force=no version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 0CE9A1F404
	for <e@80x24.org>; Wed, 10 Jan 2018 16:01:45 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1754613AbeAJQBm (ORCPT <rfc822;e@80x24.org>);
        Wed, 10 Jan 2018 11:01:42 -0500
Received: from mail-vk0-f41.google.com ([209.85.213.41]:43682 "EHLO
        mail-vk0-f41.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1751293AbeAJQBV (ORCPT <rfc822;git@vger.kernel.org>);
        Wed, 10 Jan 2018 11:01:21 -0500
Received: by mail-vk0-f41.google.com with SMTP id k132so11850461vke.10
        for <git@vger.kernel.org>; Wed, 10 Jan 2018 08:01:21 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=mime-version:in-reply-to:references:from:date:message-id:subject:to
         :cc;
        bh=AUL6gRNEY+PWIqqhWLQr+dUauV83SOxrGK15KTIhCSw=;
        b=pBm9ZMc/zK0/HLJjpayMJ7PXmztkj5T5CCPGuHpDhyuEWRV6TEYYNoUrPSv26oqgXQ
         ifRzHBZU9DQ9OBZy4ej4t6JVFiw2V/u6ldhEshaScS7gSWXwz4qzVbr5dnnyvIiqYfrt
         zmmvKoV26cp8LELKg/8cDX5chIyh0eb6HHALkrw7AvNso/zqwHwDDMbRBELZ3Aio1Wfq
         MCVoUyGPprJlthHrdQfOYclz78CdiE+Xfrnvi2qwRBXuMVppkpfVVbO+HUh8hwMNxv6G
         QDxg+uQs3lo4vwJBNoqMZv1m5hTJiwAN5nCoy7u4Dt1DIewoX3L+8gDhgc7/vJYUaCpW
         gcvg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:in-reply-to:references:from:date
         :message-id:subject:to:cc;
        bh=AUL6gRNEY+PWIqqhWLQr+dUauV83SOxrGK15KTIhCSw=;
        b=SkTXQAqoOF+4kkOKMENWm8j0o/gUe4Hc9VVGuY6YUP5YaJgf6g+7TWY3492QeNGVvF
         K+ZEt+myBkwSiT7qTHqBCC494MKKwD9beIb+mRQmuJDgjsvwoWQSvFEvO326RAYIXkc3
         eIgsfd2OyCQRGIXzUfIZk5CDgRYG2pfJGrRNiCM77bHckB2iLC4j0h9hh0Tx7an9q2hR
         B3vUGvPmFdEKdxg0Jh+8csiNXvQDCBpPze9QCGJ4EESiS6AqJE7bfL2R4LeJPfi/wUme
         n+aujuWCDszJGTfZEdo9s9ieP7PSr4FJjKUR+Bf1AiZoiH4hvxeERaQu9+/vciWepW7q
         nJjQ==
X-Gm-Message-State: AKwxytdU//xsZzse1fJRR9Tm7bYRw9yZ1ddvbJ18AZh+Jjsth2T9DXZV
        //8O8U3/SBC3sdZtu2b83KTUF7DJRIaoYhLuc339wA==
X-Google-Smtp-Source: ACJfBosRJbvsFyELv7T3uMPOvxMEXt1eKtbm344hojbOHpWKV1xSYHx22LLYd56ieGuhdc40H0GHOql4yzHhGtpfHxs=
X-Received: by 10.31.61.85 with SMTP id k82mr16722988vka.187.1515600079753;
 Wed, 10 Jan 2018 08:01:19 -0800 (PST)
MIME-Version: 1.0
Received: by 10.103.142.195 with HTTP; Wed, 10 Jan 2018 08:01:19 -0800 (PST)
In-Reply-To: <000c01d38a2b$d14c4620$73e4d260$@nexbridge.com>
References: <CALKyTE7+qJSYHQRB44HjHXK_EjOxNnCfQOROSDVVwAFR-gMnXQ@mail.gmail.com>
 <CALKyTE7VpeCoofzzutdEmsjtGe7NaC3EywQWJvM0EOH3U6XvoA@mail.gmail.com> <000c01d38a2b$d14c4620$73e4d260$@nexbridge.com>
From:   Sam Millman <sam.millman@gmail.com>
Date:   Wed, 10 Jan 2018 16:01:19 +0000
Message-ID: <CALKyTE4eqbw_kMEH9fpwFa-s-WagFn5j9OxK68YXoARm7f4zHQ@mail.gmail.com>
Subject: Re: How to use multiple SSH keys on Git exe (not bash)
To:     "Randall S. Becker" <rsbecker@nexbridge.com>
Cc:     git@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

That would mean I would need to change the case for a letter everytime
I have a repo with a new key, that would mean I would be restricted to
12 client repos at a time :\, seems very hacky to me

On 10 January 2018 at 15:58, Randall S. Becker <rsbecker@nexbridge.com> wrote:
> On January 10, 2018 10:31 AM Sam Millman wrote:
>> I am trying, for the sake of PhpStorm, to get multiple SSH keys working using
>> git . exe, which means no GitBash.
>>
>> I can get the keys to work just fine with GitBash.
>>
>> I edited my .ssh/config to look like (I know this is incorrect):
>>
>> Host bitucket . org
>> IdentityFile ~/.ssh/id_rsa1
>>
>> Host bitbucket . org
>> IdentityFile ~/.ssh/id_rsa
>>
>>
>> And id_rsa1 works, I can actually pick from the other repo. But, of course,
>> id_rsa does not now.
>>
>> I change to:
>>
>> Host bitucket . org-dd
>> HostName bitbucket . org
>> IdentityFile ~/.ssh/id_rsa1
>>
>> Host bitbucket . org-sas
>> HostName bitbucket . org
>> IdentityFile ~/.ssh/id_rsa
>>
>> And now only id_rsa works.
>>
>> I also tried combining the two IdentityFile lines together like so (for some
>> reason):
>>
>> Host bitucket . org
>> IdentityFile ~/.ssh/id_rsa1
>> IdentityFile ~/.ssh/id_rsa
>>
>> I have even tried running ssh-agent . exe, adding id_rsa1 to that and then
>> running the git clone with no result.
>>
>> The weird thing is, I have two public keys as well and they both load in the
>> ssh . exe (they return errors about format), I just cannot get my ssh . exe to
>> work with multiple private keys.
>>
>> On 10 January 2018 at 15:29, Sam Millman <sam.millman@gmail.com> wrote:
>> > I am trying, for the sake of PhpStorm, to get multiple SSH keys
>> > working using git . exe, which means no GitBash.
>> >
>> > I can get the keys to work just fine with GitBash.
>> >
>> > I edited my .ssh/config to look like (I know this is incorrect):
>> >
>> > Host bitucket . org
>> > IdentityFile ~/.ssh/id_rsa1
>> >
>> > Host bitbucket . org
>> > IdentityFile ~/.ssh/id_rsa
>> >
>> >
>> > And id_rsa1 works, I can actually pick from the other repo. But, of
>> > course, id_rsa does not now.
>> >
>> > I change to:
>> >
>> > Host bitucket . org-dd
>> > HostName bitbucket . org
>> > IdentityFile ~/.ssh/id_rsa1
>> >
>> > Host bitbucket . org-sas
>> > HostName bitbucket . org
>> > IdentityFile ~/.ssh/id_rsa
>> >
>> > And now only id_rsa works.
>> >
>> > I also tried combining the two IdentityFile lines together like so
>> > (for some
>> > reason):
>> >
>> > Host bitucket . org
>> > IdentityFile ~/.ssh/id_rsa1
>> > IdentityFile ~/.ssh/id_rsa
>> >
>> > I have even tried running ssh-agent . exe, adding id_rsa1 to that and
>> > then running the git clone with no result.
>> >
>> > The weird thing is, I have two public keys as well and they both load
>> > in the ssh . exe (they return errors about format), I just cannot get
>> > my ssh . exe to work with multiple private keys.
>> >
>> > Has anyone got any ideas on how to solve this?
>
> The ~/.ssh/config file is case sensitive by definition when it comes to Host and HostName. Try bitbucket.org for one and Bitbucket.org for another. You will have to change the remote URL accordingly to pick up the correct identity.
>
> Good luck,
> Randall
>
>
