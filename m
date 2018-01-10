Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-2.7 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_HI,T_RP_MATCHES_RCVD
	shortcircuit=no autolearn=no autolearn_force=no version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id E989F1FADF
	for <e@80x24.org>; Wed, 10 Jan 2018 07:07:13 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1754198AbeAJHHM (ORCPT <rfc822;e@80x24.org>);
        Wed, 10 Jan 2018 02:07:12 -0500
Received: from mail-qt0-f182.google.com ([209.85.216.182]:36469 "EHLO
        mail-qt0-f182.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1753532AbeAJHHK (ORCPT <rfc822;git@vger.kernel.org>);
        Wed, 10 Jan 2018 02:07:10 -0500
Received: by mail-qt0-f182.google.com with SMTP id a16so20875453qtj.3
        for <git@vger.kernel.org>; Tue, 09 Jan 2018 23:07:10 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=mime-version:in-reply-to:references:from:date:message-id:subject:to
         :cc;
        bh=vWI/9UU8apc1AchKr0s39FnSVxK1uugG6KIfnAA0tV8=;
        b=t/moJ0n7NC7XgDIbzOhR+okLZSvMu5s2X7MVPBYW5zvniWPLXl6/1XXr0rPiCCLUct
         jPAnNInCdMGqIrO8aMbhsgXyl87JJVf9TPJcRBpA1UfvUHnqn2EHQxZWpjtjbnGC/2fW
         gzHhkbyB+BgDp0Vt77uOv/CUC3lLttAj1nllgHW09XYti8PywDn7mCFoh3s6X1XUtK9y
         bEdtXqrf01l0Qni7awhIweX8GAGrIS0T5gqK43EaWgX4l6n9yFIvXAXnyOHjOJvjZ2ya
         +aEoR6SU9QcFWwoF6aA6iaJ/fBtPj8D8zClZRUe9yji/UzX59nSe4oOFE5gxViqVfhmK
         UEmw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:in-reply-to:references:from:date
         :message-id:subject:to:cc;
        bh=vWI/9UU8apc1AchKr0s39FnSVxK1uugG6KIfnAA0tV8=;
        b=g18RVV1Xr3elaJUBxOQ79x8fBH7Sb+Iyc2G4i9Ep1TOBChqw8Ojf9DC9vcSCeHxxHO
         pNmKhdt+QlFtUr+iNO0lwWV0sFdWaSnXQEfPxCRkZ2OpWam6r4mNTRO48v2Yij1jOfU+
         IG4DmyPTP31UI5ORfIb80uv0WXCmpA3Iw1avRJiaAlClY9wiKDMVVuOZ4AtHfCIVYT9u
         leN8TjbgVac4buoOdDDuMOksF6nHvpS/4lWUwnuYYLXX0O8b1eMWRAq/EXsA6rmp9brj
         9Fz/nkWRcIf4udSrODefNvChwop66LwT+42QH3II/1c/fas5XgDNFv//6MbrB77x6Kru
         Z6zg==
X-Gm-Message-State: AKwxyteTGgaXPmZZeTEhrga2IzrW/ECm+2NJCmx8Xxgp88h1WNaCwnS+
        Rumc5WqzCA95mZ9nGEZ8UrD/tmCv1h7HL6igrx8b8g==
X-Google-Smtp-Source: ACJfBotTIAVna9dWwFEzjzXyudVtxzuOtUv1K/gqSRHbzPY6J+E+Z7j980xAyqpGce5JmgwKgU1Q5sNIQPE4lARTjN4=
X-Received: by 10.237.38.35 with SMTP id z32mr25531023qtc.180.1515568029833;
 Tue, 09 Jan 2018 23:07:09 -0800 (PST)
MIME-Version: 1.0
Received: by 10.200.16.154 with HTTP; Tue, 9 Jan 2018 23:07:09 -0800 (PST)
In-Reply-To: <xmqqtvvu3d0a.fsf@gitster.mtv.corp.google.com>
References: <01020160db0679c9-799a0bc4-b6d1-43e2-ad3b-80be4e4c55e9-000000@eu-west-1.amazonses.com>
 <01020160db067bde-7f500636-b80e-4099-a84e-2613126c9aa1-000000@eu-west-1.amazonses.com>
 <xmqqtvvu3d0a.fsf@gitster.mtv.corp.google.com>
From:   =?UTF-8?B?0J7Qu9GPINCi0LXQu9C10LbQvdCw0Y8=?= 
        <olyatelezhnaya@gmail.com>
Date:   Wed, 10 Jan 2018 10:07:09 +0300
Message-ID: <CAL21BmnBcYD1ws+2e18o-X4awzFteMkZ0fGYtoJyYdB51JqdzQ@mail.gmail.com>
Subject: Re: [PATCH 03/20] cat-file: rename variables in ref-filter
To:     Junio C Hamano <gitster@pobox.com>
Cc:     git <git@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

2018-01-10 1:04 GMT+03:00 Junio C Hamano <gitster@pobox.com>:
> Olga Telezhnaya <olyatelezhnaya@gmail.com> writes:
>
>> Rename some variables for easier reading.
>> They point not to values, but to arrays.
>
> Once the code is written and people start to build on top, a change
> like this is not worth the code churn, especially because there are
> two equally valid schools of naming convention.
>
>  - When you have an array, each of whose 20 slots holds a single
>    dosh, I would prefer to call the array dosh[20], not doshes[20],
>    so that I can refer to the seventh dosh as "dosh[7]".
>
>  - If you more often refer to the array as a whole (than you refer
>    to individual elements) and want to stress the fact that the
>    array holds multiple elements in it, I can understand that you
>    may be tempted to call the whole array "doshes[]".
>
> So please drop this and other "rename variables" patches from the
> series.
>
>

OK, I will revert that. I have done this because it's hard for me to
keep in mind that it's not just a simple pointer to a single value,
and I tried to make the code more intuitive.
