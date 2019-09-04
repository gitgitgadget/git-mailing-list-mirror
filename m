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
	by dcvr.yhbt.net (Postfix) with ESMTP id 02CCD1F461
	for <e@80x24.org>; Wed,  4 Sep 2019 20:18:41 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728526AbfIDUSk (ORCPT <rfc822;e@80x24.org>);
        Wed, 4 Sep 2019 16:18:40 -0400
Received: from mail-lj1-f170.google.com ([209.85.208.170]:41751 "EHLO
        mail-lj1-f170.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727125AbfIDUSj (ORCPT <rfc822;git@vger.kernel.org>);
        Wed, 4 Sep 2019 16:18:39 -0400
Received: by mail-lj1-f170.google.com with SMTP id a4so19916ljk.8
        for <git@vger.kernel.org>; Wed, 04 Sep 2019 13:18:38 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc:content-transfer-encoding;
        bh=mq7Sjp1YSaVH/Vgu5MW6KoZ0Ta9pQloF3iDi2uz162Q=;
        b=ASHM2zqLqbO5hHlkFUkVqL7PLmvdRt7jl5dJCsJZfzBqp4Dui/AerZy0HHA3OXpmUE
         VoYQW0TQMqXkmhd9a5kSYlubtQGa2hQMNGz3IU/AqFg7DCAZa6znr12xnSKDmPMS2sg4
         NlaLYSp7m6UfZZA7fXvM1ut4fr3QvfnRlHN4FsLWGqjry1ObQd5eTFG9nS6GzsnXMnlR
         zh3SVzbS4B+t7l2X/wIKhiN0Gi4LwbwJczQyvLcwblk7Uv72ijRVO8GsJ9nouv134jYx
         cbomnIxyIR5C7ruIEf6k7kJrGp8LqHPHBiYr+B4R0FbxlWh0BFIyd/N2jvQYIbjP+iOc
         D7hA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc:content-transfer-encoding;
        bh=mq7Sjp1YSaVH/Vgu5MW6KoZ0Ta9pQloF3iDi2uz162Q=;
        b=oplU3UPlLdjzhtGscdG+MwMSb4vdhFfI9Q+OM/hbyHMcfiEBgsgV8PirOyXkmOh90v
         YgNvxqUGLrEstyKXPivQ9e+CDuwrthTbQOKFz8iAH27v5C4jfAdrUCrq4ZiClcoE+iTP
         lbaZani5/DyEcOazSXqe9O/UHDQPg5GU30SQXm9PoIPqjKocOKO7XHTmxQYU9MHNKfFd
         fxNlPO3Dro20klGJ1HON/ZcJGfUF5soWXhKNw/TjdsXNzBIEJzo66UCXLQCGUezxBzNy
         cCLLNVAfq8TVJ8bSQQ0KE4W8l9J5vflyWX/8USa3BWb+widtAcc3ITCuC5Vc1lnoBKV+
         mPfg==
X-Gm-Message-State: APjAAAVfvFWOvRS46uiUlQBRQV//ia7QXcLe1EZZMLo+rim2NTZa3Tiu
        gu//O5Yo1uFdtgB+j9b7rttlBFykyvuu2GGY988=
X-Google-Smtp-Source: APXvYqwBTMz4wvryGmRT2XP1le4grjAYdPkFRmwrgu1wrIjfvwDQGrn+gRO6b9bZTB0a2sPH17Dp1fBDnRXNyKKRWH4=
X-Received: by 2002:a2e:9ad4:: with SMTP id p20mr24808225ljj.49.1567628317362;
 Wed, 04 Sep 2019 13:18:37 -0700 (PDT)
MIME-Version: 1.0
References: <CAHd-oW4d=x51EwwyZ-FhxHgLJNZM5sHLd19mUOuacFrhT_CQwQ@mail.gmail.com>
 <CAPMsMoB=8M2Nivf=20bLEnVhN_U9f0gmG6iZHgc1MJ_TvKB3Ww@mail.gmail.com>
 <CAHd-oW6aCcx8QviZtwpjaNQ6z=PDFKt91au77cDO7w5i=caR6g@mail.gmail.com> <20190904194102.GA31805@sigill.intra.peff.net>
In-Reply-To: <20190904194102.GA31805@sigill.intra.peff.net>
From:   pedro rijo <pedrorijo91@gmail.com>
Date:   Wed, 4 Sep 2019 21:18:01 +0100
Message-ID: <CAPMsMoC604_tj3hyP9XCMZu45X-6yHAiQ5TM0nGckbzy=jb2VQ@mail.gmail.com>
Subject: Re: [RFC] Post/tutorial for newcomers
To:     Jeff King <peff@peff.net>
Cc:     Matheus Tavares Bernardino <matheus.bernardino@usp.br>,
        git <git@vger.kernel.org>,
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

For some context: Documentation/MyFirstContribution.txt was added
recently by peff (https://github.com/git/git-scm.com/pull/1362) and
can be seen at https://git-scm.com/docs/MyFirstContribution

But tbh I don't see how to reach to that page, there may be something
failing while indexing:
https://git-scm.com/search/results?search=3DMyFirstContribution

So links on https://git-scm.com/community would be very helpful for sure :)


Jeff King <peff@peff.net> escreveu no dia quarta, 4/09/2019 =C3=A0(s) 20:41=
:
>
> On Tue, Sep 03, 2019 at 09:59:13PM -0300, Matheus Tavares Bernardino wrot=
e:
>
> > > It may be interesting to add a link on
> > > https://git-scm.com/community, what do you think @peff ?
> >
> > Nice :) I think a link to `Documentation/MyFirstContribution.txt`
> > could also be added to the "Contributing to Git" section.
>
> Yes, I think either or both would be good. Patches welcome (here, or at
> https://github.com/git/git-scm.com).
>
> -Peff



--=20
Obrigado,

Pedro Rijo
