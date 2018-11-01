Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.1 (2015-04-28) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-3.0 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	FROM_EXCESS_BASE64,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,
	RCVD_IN_DNSWL_HI shortcircuit=no autolearn=ham autolearn_force=no
	version=3.4.1
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 256BA1F453
	for <e@80x24.org>; Thu,  1 Nov 2018 13:15:06 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728607AbeKAWR7 (ORCPT <rfc822;e@80x24.org>);
        Thu, 1 Nov 2018 18:17:59 -0400
Received: from mail-wr1-f43.google.com ([209.85.221.43]:46736 "EHLO
        mail-wr1-f43.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1728351AbeKAWR7 (ORCPT <rfc822;git@vger.kernel.org>);
        Thu, 1 Nov 2018 18:17:59 -0400
Received: by mail-wr1-f43.google.com with SMTP id 74-v6so11832408wrb.13
        for <git@vger.kernel.org>; Thu, 01 Nov 2018 06:15:03 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:references:user-agent:in-reply-to:date
         :message-id:mime-version:content-transfer-encoding;
        bh=+DtPCfjkiNZwmJJrBrXoPnbZnIZU0M3UQG8+OrXXXPk=;
        b=BfMVfnZb4qaXIpPe10fZ1s1gFKn+ds/lTjeA5WDiCIB3cRo4yXB8vU4oeK8iUd4N0L
         CyOZrKw8iNgVfSykDoG0lIsgImJrFd1+5RuvnJxW0mDsubj16xkjWatToIcXM/ZmggPd
         yuhk43kTA4Idl7M+TTbJ1HuVuRaVjqSnf5IzoSfjbZm4tnqlfQXuwUIVqf5koZakX0Vm
         mM/79UgSDwII4WIOKqSFB92rT1sJipVomRh24Gdck2WiDwQaMoXCsJ4q7ihKkgS5SDc2
         +YEdItiGFFnDc7PiLSaG4AlSv+o6xRci1cU+TRKDIfn8RL/GFofP9EuJhhDWY8sICT8K
         4Oww==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:references:user-agent
         :in-reply-to:date:message-id:mime-version:content-transfer-encoding;
        bh=+DtPCfjkiNZwmJJrBrXoPnbZnIZU0M3UQG8+OrXXXPk=;
        b=ulY0IWGf+HO9PzkMhBP14dleoXPIm9BLukDiKFbH8FrVeiDqvnUUCfYvprn/gepDiD
         UKIamveFO488d3tieqMFo5jUoutHnfON61UaXB+XVjsyoC4GSLLaR1ieFzZoekFu88aO
         +daRwmdFvNbjAZ8n8G8sMzIH6K7YFS/9y4eXc1IaZPIeeJH3bKL0oxER5f2FiieSxMNa
         xsG5S11HcNirhj8UrmjG6y9A8uNgOcvoQ6btEvzQqIjqt8gFnU420lH1epENnqfwfjQV
         mUNOKsyHDbjJwq3q5HqDt97bWtlZy/obOrcJb+OyXFpp2clRBmJ0YD6m9S0+Qr06eMIl
         elsg==
X-Gm-Message-State: AGRZ1gIvN4UDx0uEbyGpySdVDzLHrua8ryOachExSFAuRRj+zWfpWtVp
        abyYZh+myE/K7oHQg4PLmDg=
X-Google-Smtp-Source: AJdET5cZfCMovI9b00BJmA9alQ8XKONjtGSQOdYjwfzvT4s8hhQlDKMrV/vlvtIGa9J2/qr6B0M9MA==
X-Received: by 2002:adf:bb0f:: with SMTP id r15-v6mr6656779wrg.24.1541078102528;
        Thu, 01 Nov 2018 06:15:02 -0700 (PDT)
Received: from evledraar ([2001:981:2f6f:1:6765:91b4:348a:a673])
        by smtp.gmail.com with ESMTPSA id y4-v6sm10834420wrd.61.2018.11.01.06.15.01
        (version=TLS1_2 cipher=ECDHE-RSA-CHACHA20-POLY1305 bits=256/256);
        Thu, 01 Nov 2018 06:15:01 -0700 (PDT)
From:   =?utf-8?B?w4Z2YXIgQXJuZmrDtnLDsA==?= Bjarmason <avarab@gmail.com>
To:     Nicolas Mailhot <nicolas.mailhot@gmail.com>
Cc:     git@vger.kernel.org
Subject: Re: [RFE] Please add name and email to git credentials
References: <6d8ef01ad9eb08d90cb9848eeaeabe6784b7b3e3.camel@laposte.net> <87zhutjb3t.fsf@evledraar.gmail.com> <6f3d8c49e1d44ab20d4169e5254364cba707f1af.camel@laposte.net>
User-agent: Debian GNU/Linux testing (buster); Emacs 25.2.2; mu4e 1.1.0
In-reply-to: <6f3d8c49e1d44ab20d4169e5254364cba707f1af.camel@laposte.net>
Date:   Thu, 01 Nov 2018 14:15:00 +0100
Message-ID: <87wopxj5wr.fsf@evledraar.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: 8bit
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org


On Thu, Nov 01 2018, Nicolas Mailhot wrote:

> Le jeudi 01 novembre 2018 à 12:22 +0100, Ævar Arnfjörð Bjarmason a
> écrit :
>>
>> Where would we get an E-Mail to lookup to pass to the helper? Are you
>> just asking that the helper git the result of $(git config user.name
>> &&
>> git config user.email)? If so why can't it just look this up itself?
>
>
> So, just in case it was not clear enough, allow things in .gitconfig
> like
>
> [credential "https://pkgs.fedoraproject.org/"]
> username = doe4ever
> name = John Doe
> email = doe4ever@fedoraproject.org
> [credential "https://gitlab.corp.com/"]
> username = jdoe56874
> name = John Doe, Snr Engineer
> email = john.doe@corp.com
>
> Instead of just
>
> [user]
> name = John Doe
> email =  john.doe@corp.com
> [credential "https://pkgs.fedoraproject.org/"]
> username = doe4ever
> [credential "https://gitlab.corp.com/"]
> username = jdoe56874
>
> and drat, I've commited to XXX with the wrong name/email again

Aaaah! So really you just want to set user.{name,email} if you match a
given URL in the project, and this per-se has nothing to do with
credentials..

Yeah that's a fair request. Although I think tying that up with
credential.* doesn't make sense because we'd:

 1) Need yet another place (config, env vars, now this...) to search for
    what we're putting in the commit object.

 2) Users want to configure this for e.g. different URLs even though
    they don't need different credentials for the two.

I'm too lazy to dig up the thread, but there's been a discussion before
of extending the IncludeIf syntax to support more things that "gitdir",
e.g. matching on the remote URL.

So then you'd do:

    [credential "https://pkgs.fedoraproject.org/"]
    username = doe4ever
    [IncludeIf "remote:https://pkgs.fedoraproject.org/*"]
    path ~/.gitconfig.d/fedoraproject.config

But now what you need to do is clone all the projects in
e.g. ~/git/fedoraproject/* and do:

    [credential "https://pkgs.fedoraproject.org/"]
    username = doe4ever
    [IncludeIf "gitdir:~/g/fedoraproject/*"]
    path ~/.gitconfig.d/fedoraproject.config
