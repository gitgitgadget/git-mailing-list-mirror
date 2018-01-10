Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-2.8 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_HI,T_RP_MATCHES_RCVD
	shortcircuit=no autolearn=no autolearn_force=no version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id E93741F404
	for <e@80x24.org>; Wed, 10 Jan 2018 15:58:48 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S965816AbeAJP6q (ORCPT <rfc822;e@80x24.org>);
        Wed, 10 Jan 2018 10:58:46 -0500
Received: from mail-wm0-f49.google.com ([74.125.82.49]:37085 "EHLO
        mail-wm0-f49.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S964976AbeAJP6p (ORCPT <rfc822;git@vger.kernel.org>);
        Wed, 10 Jan 2018 10:58:45 -0500
Received: by mail-wm0-f49.google.com with SMTP id f140so27906172wmd.2
        for <git@vger.kernel.org>; Wed, 10 Jan 2018 07:58:44 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:references:user-agent:in-reply-to:date
         :message-id:mime-version;
        bh=znEvGY3W9cUfaH8uHmOeFc+wHIepmaokjg5rPVEjlKk=;
        b=kQIoyAV6XlROS/YvS/IRqlxcV1izAHiNaP90x4KRdUsTtEVpFjhsOpBojz1h3fYg6F
         xjj0DpNn/mhLn+W0LtloKYa20cYMzz0s6Q4l4gVHE8zlP6kO9Dljet3mLX1ROtGwZH/u
         0SDF25+nQ7WHf/YJo9GmzPTV/rFBAvPuPu/b7YShtGxnt4Uqf6oKBDChHZUXHC7UR7tT
         rglk1Omw1618c/b8zpeU96eJ4bLzvlRMignlNoOlWbxjlKg3Xa0Os7S/0u3ZnfoOXCbb
         41BPQ2ZAi8mt8FgCGrxhDJ5Hjotmf+wS77Pukw6GXXZXvj3wssJpGz7PxBTFHQnATFpE
         4k6g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:references:user-agent
         :in-reply-to:date:message-id:mime-version;
        bh=znEvGY3W9cUfaH8uHmOeFc+wHIepmaokjg5rPVEjlKk=;
        b=f9LoFsdjj7kssJtyhRj731v+PNVJ/8wG+fg/Mtb/natKLihzvO0sKnDNWIkOlGIUKa
         toERPHkjXH1m0JcmM/iYgVDdciVJbyOhVbF0CD5E6Db+D0zJS1VL9EUFeoJLBY9/U86S
         7NuTYJWEPjhQAbcS6LL6sJMdLv75TQ1ZlsL6rG5y9MO4n+YD+BrJ4L5XRBhcxaD8/vZ/
         lBP4hPVI/ktO+aXdXOe9YNHyGlEINtfBcqCa2z0ChgBGQ9Sko4pWCHYbv1OFK7Upt7R8
         rRkSWjK0ZOTuXOVBP8qKKmCWt2+bOvmW2PeKaJte4ppK1VyPc2aLPLtTOvXJhS0WecEF
         4c6Q==
X-Gm-Message-State: AKwxytdCYN8WmWzooN4WnUm5qpwSFz/7MAkDLLcTtQ8tGgq+4aqmp9qE
        1Az4OpfdkXQWV61rwgPdO0c=
X-Google-Smtp-Source: ACJfBosJnUOp7ghpHsz99pr/4dqRIFvEdcze4XtIbs5B0VCGG5h10kz2yEtDkck27CU4D8SXjBd8pg==
X-Received: by 10.80.140.248 with SMTP id r53mr8643428edr.306.1515599923618;
        Wed, 10 Jan 2018 07:58:43 -0800 (PST)
Received: from evledraar (proxy-gw-a.booking.com. [5.57.21.8])
        by smtp.gmail.com with ESMTPSA id f9sm8903555edm.83.2018.01.10.07.58.42
        (version=TLS1_2 cipher=ECDHE-RSA-CHACHA20-POLY1305 bits=256/256);
        Wed, 10 Jan 2018 07:58:42 -0800 (PST)
From:   =?utf-8?B?w4Z2YXIgQXJuZmrDtnLDsA==?= Bjarmason <avarab@gmail.com>
To:     Sam Millman <sam.millman@gmail.com>
Cc:     git@vger.kernel.org
Subject: Re: How to use multiple SSH keys on Git exe (not bash)
References: <CALKyTE7+qJSYHQRB44HjHXK_EjOxNnCfQOROSDVVwAFR-gMnXQ@mail.gmail.com> <CALKyTE7VpeCoofzzutdEmsjtGe7NaC3EywQWJvM0EOH3U6XvoA@mail.gmail.com>
User-agent: Debian GNU/Linux 9.3 (stretch); Emacs 25.1.1; mu4e 0.9.19
In-reply-to: <CALKyTE7VpeCoofzzutdEmsjtGe7NaC3EywQWJvM0EOH3U6XvoA@mail.gmail.com>
Date:   Wed, 10 Jan 2018 16:58:41 +0100
Message-ID: <87mv1laeoe.fsf@evledraar.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org


On Wed, Jan 10 2018, Sam Millman jotted:

> I am trying, for the sake of PhpStorm, to get multiple SSH keys
> working using git . exe, which means no GitBash.
>
> I can get the keys to work just fine with GitBash.
>
> I edited my .ssh/config to look like (I know this is incorrect):
>
> Host bitucket . org
> IdentityFile ~/.ssh/id_rsa1
>
> Host bitbucket . org
> IdentityFile ~/.ssh/id_rsa
>
>
> And id_rsa1 works, I can actually pick from the other repo. But, of
> course, id_rsa does not now.
>
> I change to:
>
> Host bitucket . org-dd
> HostName bitbucket . org
> IdentityFile ~/.ssh/id_rsa1
>
> Host bitbucket . org-sas
> HostName bitbucket . org
> IdentityFile ~/.ssh/id_rsa
>
> And now only id_rsa works.
>
> I also tried combining the two IdentityFile lines together like so
> (for some reason):
>
> Host bitucket . org
> IdentityFile ~/.ssh/id_rsa1
> IdentityFile ~/.ssh/id_rsa
>
> I have even tried running ssh-agent . exe, adding id_rsa1 to that and
> then running the git clone with no result.
>
> The weird thing is, I have two public keys as well and they both load
> in the ssh . exe (they return errors about format), I just cannot get
> my ssh . exe to work with multiple private keys.

This might just be a special case of the problem of some hosting
providers picking only the first key you provide, as described in this
thread:
https://public-inbox.org/git/20180103102840.27897-1-avarab@gmail.com/

If so, you either need to hack around this with ssh host aliases, or a
custom GIT_SSH_COMMAND.

> On 10 January 2018 at 15:29, Sam Millman <sam.millman@gmail.com> wrote:
>> I am trying, for the sake of PhpStorm, to get multiple SSH keys working
>> using git . exe, which means no GitBash.
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
>> ssh . exe (they return errors about format), I just cannot get my ssh . exe
>> to work with multiple private keys.
>>
>> Has anyone got any ideas on how to solve this?
