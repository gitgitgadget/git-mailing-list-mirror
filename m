Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.2 (2018-09-13) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-3.7 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,RCVD_IN_DNSWL_HI,
	SPF_HELO_NONE,SPF_NONE shortcircuit=no autolearn=ham
	autolearn_force=no version=3.4.2
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id AAD361F461
	for <e@80x24.org>; Tue,  3 Sep 2019 07:23:43 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726738AbfICHXm (ORCPT <rfc822;e@80x24.org>);
        Tue, 3 Sep 2019 03:23:42 -0400
Received: from mail-lf1-f46.google.com ([209.85.167.46]:35663 "EHLO
        mail-lf1-f46.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726473AbfICHXm (ORCPT <rfc822;git@vger.kernel.org>);
        Tue, 3 Sep 2019 03:23:42 -0400
Received: by mail-lf1-f46.google.com with SMTP id w6so6637418lfl.2
        for <git@vger.kernel.org>; Tue, 03 Sep 2019 00:23:41 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc:content-transfer-encoding;
        bh=tGABJg7CReM6A3KZYqr8rdolg91W2VtVKFFRhEP2hFM=;
        b=H7Ub/FJUunSrHyG6/ZuZfS6+pXX6Ml52puaVzlgwgREpdVj+qHENH+GJkHz9pBgVMW
         HKkbLvvqsPGAco2pEcu2G8FBLh2QzLuNGFzmk0qSfCu5mm9SY8SJV1GG9tpuWM9HVqui
         3mi7cQLZ9rb3SeLFmk167iv2EAhVZejfS2u0lmW5+16fsM9wKi2Bt4Gzsv+USVXXLOzD
         08Gt4M05/A+1xFEqibhFmVruCn5MOQ9AtdtaAqopdzr3WrejUq4cOS/QRKGNBjEWpEBQ
         hD4IKYFHn4bi3gewFULB6Gt/xkZ04r0kgVx9QVU6hDlLEBl1MBY0fT7F7iwqZAjq71hB
         +AMQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc:content-transfer-encoding;
        bh=tGABJg7CReM6A3KZYqr8rdolg91W2VtVKFFRhEP2hFM=;
        b=nZ4kxoCihg4poqUAQZtdyesOm5fF4BggDS7iPczEFZARdM1cu8MiqH2nJPEafxB16r
         24oowH9Fi+aFjftUTL4oBp1teSGcxwHQGet/amdXWc4iI2s+RTVi0PJbSYM5qzr4kyZA
         vJnVQZ8ZyEKJYuliMoBynNyzgDfmluDRDzY3YuSPWacYQHiYMFWw6Qs/6zpOl35su8uO
         5i97VhDUxGq9QLmF/zLyp2M69/kZV8EBzfd7UKgoOuQ5fsRK8aXPvTtbNf7YpDmTsEEn
         E0HYYsSc1Wvg9DTHtttnMYnXjEK3JPBSlKBwBPbA2UXO157n4ns8aHq/fZoRfunfO/lL
         Iqug==
X-Gm-Message-State: APjAAAXa8EwkjX+cBy1GEPKgUGsIUt+csmlte06+4US3vB3iQ5UUAFrR
        XX0+18sDNkBkYv44lBLRijXUF6IYJ8WwIMVUOJo=
X-Google-Smtp-Source: APXvYqxIs58Pvn7Q1bnNG+MK038/OO/8DR7bZDyXr6KCJtXKil2QCme5YTavq42OgAfX0TzZCAIyYMO46gx3bKciTyA=
X-Received: by 2002:a19:f11c:: with SMTP id p28mr9119755lfh.44.1567495420614;
 Tue, 03 Sep 2019 00:23:40 -0700 (PDT)
MIME-Version: 1.0
References: <CAHd-oW4d=x51EwwyZ-FhxHgLJNZM5sHLd19mUOuacFrhT_CQwQ@mail.gmail.com>
In-Reply-To: <CAHd-oW4d=x51EwwyZ-FhxHgLJNZM5sHLd19mUOuacFrhT_CQwQ@mail.gmail.com>
From:   pedro rijo <pedrorijo91@gmail.com>
Date:   Tue, 3 Sep 2019 08:23:04 +0100
Message-ID: <CAPMsMoB=8M2Nivf=20bLEnVhN_U9f0gmG6iZHgc1MJ_TvKB3Ww@mail.gmail.com>
Subject: Re: [RFC] Post/tutorial for newcomers
To:     Matheus Tavares Bernardino <matheus.bernardino@usp.br>
Cc:     git <git@vger.kernel.org>,
        Christian Couder <christian.couder@gmail.com>,
        =?UTF-8?B?0J7Qu9GPINCi0LXQu9C10LbQvdCw0Y8=?= 
        <olyatelezhnaya@gmail.com>,
        Rohit Ashiwal <rohit.ashiwal265@gmail.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Hey Matheus,

Just gave a quick look at your post, and I find it awesome!  I think
it covers most of the pains new contributors may have. Great
initiative! It may be interesting to add a link on
https://git-scm.com/community, what do you think @peff ?

Thanks,
Pedro


Matheus Tavares Bernardino <matheus.bernardino@usp.br> escreveu no dia
ter=C3=A7a, 3/09/2019 =C3=A0(s) 03:34:
>
> Hi, everyone
>
> I've been writing a blog post based on what I learned during GSoC to
> help other students here at FLUSP[1] start contributing as well.
>
> In the meantime `Documentation/MyFirstContribution.txt` was released,
> so I've pointed my interested colleagues to it. But since I was
> already pretty close to finishing the post, I decided to conclude it
> anyway.
>
> Here is the end result:
> https://matheustavares.gitlab.io/posts/first-steps-contributing-to-git
> If you have any comments or suggestions for it, please, let me know :)
>
> Thanks,
> Matheus
>
> [1]: https://flusp.ime.usp.br



--=20
Obrigado,

Pedro Rijo
