Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-2.8 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_HI,T_RP_MATCHES_RCVD
	shortcircuit=no autolearn=no autolearn_force=no version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 0E6101FAE2
	for <e@80x24.org>; Sun,  4 Mar 2018 02:57:44 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1751819AbeCDC5l (ORCPT <rfc822;e@80x24.org>);
        Sat, 3 Mar 2018 21:57:41 -0500
Received: from mail-ot0-f196.google.com ([74.125.82.196]:36668 "EHLO
        mail-ot0-f196.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1751756AbeCDC5k (ORCPT <rfc822;git@vger.kernel.org>);
        Sat, 3 Mar 2018 21:57:40 -0500
Received: by mail-ot0-f196.google.com with SMTP id 108so12094976otv.3
        for <git@vger.kernel.org>; Sat, 03 Mar 2018 18:57:40 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=mime-version:in-reply-to:references:from:date:message-id:subject:to
         :cc;
        bh=sbMVa4YOuuoL3O+TK8cCFrJvXWeSLNzA+YCL7v7I+Ug=;
        b=bWMFhPNj4r5vuXhcigN+foSvh+p0XQ5/fSaSRqUL+iX4zXhimzzMNMn555e/KNoVpW
         cUlkGZyIEAIrHmXDeGniiPIkRwYpaiKOuyxrYUqEIHQ/WUYN8VvYWCSBTu9V1MfTOKby
         Vh5STZoAhSVAIaN85lJ1IOhxXEH4tKcwcO3gp1XtDdg2IV82O5fm5ATDQPYrTXJIUalz
         TFRll2ZMUuEjYV/nH65BvIJPiMWT53fBXjKV0iLEXYFsBIHNTFEKXU03unqOrb5DQJqs
         rl+JpaneiJZ+6XZDHVGuLTFutnvAmnxFlxoaSrMLN/Yk4Nu24+inciIXZFnqpLLoviSU
         Vw9g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:in-reply-to:references:from:date
         :message-id:subject:to:cc;
        bh=sbMVa4YOuuoL3O+TK8cCFrJvXWeSLNzA+YCL7v7I+Ug=;
        b=qW2OwNkf/5xIKPExKazkWNPiaQiZXEO3n+8UkFr40ACZgOwIqE/YHenPp3NuTicb66
         WlgfDGC2vWpiYJhAs3Vzfbh0rNSutXYzGX0MBtqFYkeZJtvQgtkfBoZhBPPsrI8XcsdO
         BP7QVLJy+u+SWJqqoZld+70swQPa/6jzd4V4Gh6jpQF4838OKr7roCbKtMo79HWbxsdv
         emeqXWVkOH7WgpKDcJw8NaJYdPo2Mahk1zwNQqRPrxF4tZnLkkV+8/YODHeK+76FA+nd
         BidqeuYMtq+ColOxSYhQvl6tBK8Qq5p5lV0+Nf1xcevhxt/5p5t1j5P99ldq0XIB+gMJ
         7I0Q==
X-Gm-Message-State: AElRT7FplHL11ji3KXHkphWmUCreoXJJroliytZI3/Ep5k9FeDFy1t8A
        4QDSHb7LwVp3iB+bTJZspq99oVF40wC46PgvfF5UPg==
X-Google-Smtp-Source: AG47ELuI+pMyT5tzgnbgIi4kEU9dBdtNWpKo53J06rNFDRI/I9r8eqW8Zylf0v5o8QCcd0DtTV3iR4WWQPWLCwqy7kU=
X-Received: by 10.157.53.10 with SMTP id o10mr7111553otc.283.1520132259831;
 Sat, 03 Mar 2018 18:57:39 -0800 (PST)
MIME-Version: 1.0
Received: by 10.74.76.9 with HTTP; Sat, 3 Mar 2018 18:57:39 -0800 (PST)
In-Reply-To: <CAPig+cTyZAFx486Y9LrQuaK0qMnQEGD3U55sk9Vvyb_TgDz5tQ@mail.gmail.com>
References: <20180303034803.21589-1-dorabpatel@gmail.com> <CAPig+cR=adC_Ok=FJw2APaLahXX_v1ix4ufEJyBhED5ruXaQxA@mail.gmail.com>
 <CAE09B1+XXJvrOucHwehUGk=Taio7sirfOh5gq7KGs4iZSpK=vQ@mail.gmail.com> <CAPig+cTyZAFx486Y9LrQuaK0qMnQEGD3U55sk9Vvyb_TgDz5tQ@mail.gmail.com>
From:   Dorab Patel <dorabpatel@gmail.com>
Date:   Sat, 3 Mar 2018 18:57:39 -0800
Message-ID: <CAE09B1Ky1_PKWq17Nm_Uc9sZn7khycR0aK2Z3AHnyjYoPMy8Qg@mail.gmail.com>
Subject: Re: [PATCH] git.el: handle default excludesfile properly
To:     Eric Sunshine <sunshine@sunshineco.com>
Cc:     Git List <git@vger.kernel.org>,
        Alexandre Julliard <julliard@winehq.org>
Content-Type: text/plain; charset="UTF-8"
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Thanks for reviewing and locating the commits.

OK, I'll re-roll and add the relevant commits. It may take some time.

Should I just send the revised patch as a separate thread (with the
relevant commits and history)?

On Sat, Mar 3, 2018 at 6:12 PM, Eric Sunshine <sunshine@sunshineco.com> wrote:
> On Sat, Mar 3, 2018 at 8:36 PM, Dorab Patel <dorabpatel@gmail.com> wrote:
>> Correct me if I'm wrong, but my understanding, from
>> https://git-scm.com/docs/gitignore, is that $HOME/.gitignore is used
>> only if it is specified as the value of core.excludesfile in
>> ~/.gitconfig. It is not used by default. If that is so, then the
>> proposed (and original) code works. The changes I am proposing handle
>> the default case, when core.excludesfile is not specified.
>
> You're right. I must have set core.excludesfile so long ago that I
> forgot about it and assumed $HOME/.gitignore was consulted by default.
>
>> Looking deeper into how the function git-get-exclude-files is used, I
>> see that it is only being called from git-run-ls-files-with-excludes.
>> So, perhaps, a better (or additional) fix might be to add the
>> parameter "--exclude-standard" in the call to git-run-ls-files from
>> within git-run-ls-files-with-excludes. And remove the need for
>> get-get-exclude-files altogether.  Presumably, "--exclude-standard"
>> handles the default case with/without XDG_CONFIG_HOME correctly. The
>> question I'd have then is: why didn't the original author use that
>> option? Either I'm missing something? Or the option was added later,
>> after the original code was written? Or something else?
>
> Using --exclude-standard rather than --exclude-from and retiring
> git-get-exclude-files() makes sense to me.
>
> As for why the original author didn't use --exclude-standard, project
> history tells us that. In particular, git-get-exclude-files() was
> implemented by 274e13e0e9 (git.el: Take into account the
> core.excludesfile config option., 2007-07-31), whereas
> --exclude-standard was introduced by 8e7b07c8a7 (git-ls-files: add
> --exclude-standard, 2007-11-15), three and a half months later.
>
> If you do re-roll to use --exclude-standard, then it would be good for
> your commit message to explain this history, citing the relevant
> commits.
>
> Thanks.
