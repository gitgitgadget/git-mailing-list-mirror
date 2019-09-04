Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.2 (2018-09-13) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-4.0 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,
	RCVD_IN_DNSWL_HI,SPF_HELO_NONE,SPF_NONE shortcircuit=no autolearn=ham
	autolearn_force=no version=3.4.2
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 1E5011F461
	for <e@80x24.org>; Wed,  4 Sep 2019 00:59:27 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727813AbfIDA70 (ORCPT <rfc822;e@80x24.org>);
        Tue, 3 Sep 2019 20:59:26 -0400
Received: from mail-vs1-f53.google.com ([209.85.217.53]:38694 "EHLO
        mail-vs1-f53.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727168AbfIDA7Z (ORCPT <rfc822;git@vger.kernel.org>);
        Tue, 3 Sep 2019 20:59:25 -0400
Received: by mail-vs1-f53.google.com with SMTP id b123so764041vsb.5
        for <git@vger.kernel.org>; Tue, 03 Sep 2019 17:59:25 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=usp-br.20150623.gappssmtp.com; s=20150623;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc:content-transfer-encoding;
        bh=uydvz7QhZA+AfjEvjIYpMectYQu5UXP4zlOcCEUlSlI=;
        b=gH9h1eotwSt/9QsVExeDyIJkB15sGVkPAsyTRGH4IVBFG1RLvBqrEISgoTs47o7Zgl
         JB/i/O88vS1dFcFivlH+3aZb0Vm4bRAQmsynbOR/dyctl0LhmLbolB8VZYxWUi0icgF7
         nAyTAwb/v8QpKxnm7R2nahSP3EfDpuxmhYDrBtsnlEiz9nphKaC2FW8fuuUqyDX438im
         Xt7jH/x5YoujvsV1MzmwBhQRfLWd8CszDVqSV4d10DOWGfxGRfITJwUDrYlTXDojpzxh
         FwUINIzzTA2laOBkuQmwKBQQsumdyOC0f0D0AKJj/L8HbR7sXylpjFmk1e6/akPfCyoX
         2NKQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc:content-transfer-encoding;
        bh=uydvz7QhZA+AfjEvjIYpMectYQu5UXP4zlOcCEUlSlI=;
        b=c/7RvH6rWTB5QALrO/NYZo7HpRRDXt6BxndxSvzo7zFNozHdZt7yblcVYGSkIH6TAK
         BhVyNGy0s76g4QSRVVCJvapahfD+lC+83lTJWMwwqywInlOZMkLcpuuk3fp6bvdVmVPU
         qYFEV86knfK2C/4OgezTHy0ev6uztbI9bpw77xWx9pSEqYiII8sU7KO+8yYEj79LPfM2
         sXu5AqpU2+y1wPH5/7Zvf2VO75Q63PqNxRZBSo13i3IwP/J9lBYho3jD2tdgRIginBYq
         iY55FXrrgxcDi4UpfQwefXZPoUuwG1Lx5ipGcq0BXJpxoCqYxoVLCGcAMisdHXVaM9KM
         kHnA==
X-Gm-Message-State: APjAAAUv1DoKCat/h383FxsdKjBzSNLLvJ9BWIejmz+5yQ9NQfk2/dx0
        ATFQ/lM0+lH1FLAZ4YjP1sf7yFzGLOV+5XygeVlOPw==
X-Google-Smtp-Source: APXvYqwsSIpr2F1A8GBGZAgx0kivsi9BjizsU/ZRmJEMZG1JKU4TDsQfrJuZ0Zt39V58zo5zL4wI8V39GVYNqVKiLxw=
X-Received: by 2002:a67:c79a:: with SMTP id t26mr19981342vsk.49.1567558764438;
 Tue, 03 Sep 2019 17:59:24 -0700 (PDT)
MIME-Version: 1.0
References: <CAHd-oW4d=x51EwwyZ-FhxHgLJNZM5sHLd19mUOuacFrhT_CQwQ@mail.gmail.com>
 <CAPMsMoB=8M2Nivf=20bLEnVhN_U9f0gmG6iZHgc1MJ_TvKB3Ww@mail.gmail.com>
In-Reply-To: <CAPMsMoB=8M2Nivf=20bLEnVhN_U9f0gmG6iZHgc1MJ_TvKB3Ww@mail.gmail.com>
From:   Matheus Tavares Bernardino <matheus.bernardino@usp.br>
Date:   Tue, 3 Sep 2019 21:59:13 -0300
Message-ID: <CAHd-oW6aCcx8QviZtwpjaNQ6z=PDFKt91au77cDO7w5i=caR6g@mail.gmail.com>
Subject: Re: [RFC] Post/tutorial for newcomers
To:     pedro rijo <pedrorijo91@gmail.com>
Cc:     git <git@vger.kernel.org>,
        Christian Couder <christian.couder@gmail.com>,
        =?UTF-8?B?0J7Qu9GPINCi0LXQu9C10LbQvdCw0Y8=?= 
        <olyatelezhnaya@gmail.com>,
        Rohit Ashiwal <rohit.ashiwal265@gmail.com>,
        Jeff King <peff@peff.net>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

On Tue, Sep 3, 2019 at 4:23 AM pedro rijo <pedrorijo91@gmail.com> wrote:
>
> Hey Matheus,
>
> Just gave a quick look at your post, and I find it awesome!  I think
> it covers most of the pains new contributors may have. Great
> initiative!

Thank you, Pedro! Also, if you have any suggestions for it, please,
let me know. (The "source" is here:
https://gitlab.com/MatheusTavares/matheustavares.gitlab.io)

> It may be interesting to add a link on
> https://git-scm.com/community, what do you think @peff ?

Nice :) I think a link to `Documentation/MyFirstContribution.txt`
could also be added to the "Contributing to Git" section.

> Thanks,
> Pedro
>
>
> Matheus Tavares Bernardino <matheus.bernardino@usp.br> escreveu no dia
> ter=C3=A7a, 3/09/2019 =C3=A0(s) 03:34:
> >
> > Hi, everyone
> >
> > I've been writing a blog post based on what I learned during GSoC to
> > help other students here at FLUSP[1] start contributing as well.
> >
> > In the meantime `Documentation/MyFirstContribution.txt` was released,
> > so I've pointed my interested colleagues to it. But since I was
> > already pretty close to finishing the post, I decided to conclude it
> > anyway.
> >
> > Here is the end result:
> > https://matheustavares.gitlab.io/posts/first-steps-contributing-to-git
> > If you have any comments or suggestions for it, please, let me know :)
> >
> > Thanks,
> > Matheus
> >
> > [1]: https://flusp.ime.usp.br
