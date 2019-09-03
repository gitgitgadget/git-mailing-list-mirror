Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.2 (2018-09-13) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-2.6 required=3.0 tests=AWL,BAYES_00,BODY_8BITS,
	DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,
	FREEMAIL_FROM,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,
	RCVD_IN_DNSWL_HI,SPF_HELO_NONE,SPF_NONE shortcircuit=no autolearn=ham
	autolearn_force=no version=3.4.2
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 360911F461
	for <e@80x24.org>; Tue,  3 Sep 2019 07:49:59 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727559AbfICHt6 (ORCPT <rfc822;e@80x24.org>);
        Tue, 3 Sep 2019 03:49:58 -0400
Received: from mail-wr1-f47.google.com ([209.85.221.47]:37966 "EHLO
        mail-wr1-f47.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725878AbfICHt5 (ORCPT <rfc822;git@vger.kernel.org>);
        Tue, 3 Sep 2019 03:49:57 -0400
Received: by mail-wr1-f47.google.com with SMTP id l11so7484522wrx.5
        for <git@vger.kernel.org>; Tue, 03 Sep 2019 00:49:56 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc:content-transfer-encoding;
        bh=EpSMAHpeMLQsay7rSdvgipODjNJiW2L/colSeI0qaQs=;
        b=AgPKRpV4PdRyWsUd4Zxvih01sIaYCNQDVAmp6Rn1SWKsyBauRpuynuHApjOeBmv/13
         G6I/XYr4Bx3SOWKhz34bAZt5FSZlfwmLvLvAy4o04WPI57qvSmfL/WTzLGp8fCyxrT0s
         rcltAX1OATDfeA85rgCNTQjuNt2ksW9gCVxfekCLk+W6voHdilRPZCYrX07w8ZPFGTCU
         IibcJUZHk7eDkpAbHFsojHvISOovqhjQkQicJRpaZvhR3+E8dhERzRNnpl3MManYEn0+
         o8bqh2q8E0OlvW8RW7s/KQl60ICfYHeKfK7ya2IIaiFnCXHkRHelqvVPlD0tbC0XXrw3
         tWyw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc:content-transfer-encoding;
        bh=EpSMAHpeMLQsay7rSdvgipODjNJiW2L/colSeI0qaQs=;
        b=UCBaZlUe8PjYX49QKrePuHSY5rfRBsaXmSTNIILlao160+U0snqmxYU399L9V7BanJ
         gOyJvL+5LfJhHFkHD3ZAtM4OVOGBKJO4qDHc6BZNC5Ocdz+Mr5GmVmeEQ+MMmWbs2Om1
         qnniHmiv0rBy5zukMIRbIqKvkP+Z0aMsZwtzOXerA9H9SZjtWVDrWd81j3DLS4xoyL8Z
         a9y497akLHQnZUR4bLAIRxwrdtpVSpWnDkPh83L0gNClTdbal5YKNQg7osrxx8Edh6K0
         Aj8Bj3JdJB9YKbePr/BsREaYI58dxiOMvn/ePww9q+uBmWwCtuW/RmmzDnZq5W2pHdBt
         CfpQ==
X-Gm-Message-State: APjAAAWKFscP2cu9zSx2tFvav2VLaEwVskoHyZxRYQcIBb9S3+dJr+hN
        V26TshpVhRH0rf21EWCjAWMywxrcWEQxwqwHySDOF0MM3mKn0A==
X-Google-Smtp-Source: APXvYqxRW/pnY+gxcgvIZuDIrMo1mqLJC214QeOYlDYkx3auxePCXJ2W9KBFVfSezht0TsOzNGjf+NyvHd/CAQxJiqs=
X-Received: by 2002:adf:cd8e:: with SMTP id q14mr40346850wrj.187.1567496995546;
 Tue, 03 Sep 2019 00:49:55 -0700 (PDT)
MIME-Version: 1.0
References: <CAHd-oW4d=x51EwwyZ-FhxHgLJNZM5sHLd19mUOuacFrhT_CQwQ@mail.gmail.com>
In-Reply-To: <CAHd-oW4d=x51EwwyZ-FhxHgLJNZM5sHLd19mUOuacFrhT_CQwQ@mail.gmail.com>
From:   Olga Telezhnaya <olyatelezhnaya@gmail.com>
Date:   Tue, 3 Sep 2019 10:49:44 +0300
Message-ID: <CAL21Bmkadiv-wkdUZ7zsZckz2eHK3po22y2Ry5X+MnEWKAuSZg@mail.gmail.com>
Subject: Re: [RFC] Post/tutorial for newcomers
To:     Matheus Tavares Bernardino <matheus.bernardino@usp.br>
Cc:     git <git@vger.kernel.org>,
        Christian Couder <christian.couder@gmail.com>,
        Rohit Ashiwal <rohit.ashiwal265@gmail.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

=D0=B2=D1=82, 3 =D1=81=D0=B5=D0=BD=D1=82. 2019 =D0=B3. =D0=B2 05:32, Matheu=
s Tavares Bernardino
<matheus.bernardino@usp.br>:
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

This is amazing! Thank you for such painstaking work. I wish I had
this doc before doing my first steps at Git :)

>
> Thanks,
> Matheus
>
> [1]: https://flusp.ime.usp.br
