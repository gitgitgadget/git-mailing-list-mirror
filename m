Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.2 (2018-09-13) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-3.8 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,RCVD_IN_DNSWL_HI
	shortcircuit=no autolearn=ham autolearn_force=no version=3.4.2
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 1BCD220248
	for <e@80x24.org>; Sat,  6 Apr 2019 09:21:37 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726419AbfDFJVf (ORCPT <rfc822;e@80x24.org>);
        Sat, 6 Apr 2019 05:21:35 -0400
Received: from mail-pl1-f193.google.com ([209.85.214.193]:38821 "EHLO
        mail-pl1-f193.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726310AbfDFJVf (ORCPT <rfc822;git@vger.kernel.org>);
        Sat, 6 Apr 2019 05:21:35 -0400
Received: by mail-pl1-f193.google.com with SMTP id g37so4354269plb.5
        for <git@vger.kernel.org>; Sat, 06 Apr 2019 02:21:35 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=1oj9g1cuk9mAGSBlEroUJl6MdP3b/YDGEWjQ86YrWmo=;
        b=DPq2bKa1BPtpX4UgBvBlqvw+iKfWRhiSW5lKIErdZaHAoayDN8GTN05ILsHMz1x+0K
         G9aE7ndPYLkpCWcSXYafg7zfWUX/IjHYTbeblHu/KCZ7iXNswhB6lMRtHh4+fTtn+Y/+
         UOG4xgkAvOkNx4WaHezlBTJ4C6gwh+2zZp80fzkOQyNWT3qB5ZQesfMOddxfooXLmTLn
         2GKO1GNgUQcz2+rpr3bvtd60IwR1IRBhj759vQCfeoFjfYVgzR3j20zqDMzz6h/67sHI
         bvkWWsrer7dgyepcoaCEPR1cHb9S23pcGx/WjiD2KwzGGnLEIo8JeYUzqs2KIhCF2au0
         tZQQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=1oj9g1cuk9mAGSBlEroUJl6MdP3b/YDGEWjQ86YrWmo=;
        b=FKJn/zDxOVFirGTD6/J0IcMdV2KqQfo1+CvEcvXypLmGhZ2HJaSNds3HLlb0wxB/A9
         PLBHNO2cvGpqYBeHhrdWMd90xeeLi4Gp60yyfDs2ManaqI2vnbH8EiCwgy69cK7QRu7Z
         gltdYlB9IpZs9072XZ5MImTG0aFUUz07bbhxFFjKQ2ktUvW6fCygUDsL9HDiMOM/gFrD
         3PGEATiZvAWmT5uGfGB0inWKMdGNuZecjvHuzR76/seR9Clfb/P3LA8Ck1UQRor3fkAi
         M6hb1x2ViDbCz7qGWc6HPpbzU0QRtHDUvzwBwquDf3kSUaRrrZZizcLnbFIZw55FJQcY
         tieQ==
X-Gm-Message-State: APjAAAXIhrqlUs+n2ySdRy/axV0UfZcd9399P1sJWzxWBDo+QCuuSuaN
        DnjDPgCwFUr9avG/XOV8qZ+0rQT6AcINVKTIoBg=
X-Google-Smtp-Source: APXvYqwG/xTdS/THLgGrBorW1xVA0yWivv5gyC0ii2CcMWYUpcUUURdZAl5EBNlI3/wF7lBTHLlzA2Ag1B7eIWZXo58=
X-Received: by 2002:a17:902:e407:: with SMTP id ci7mr17939899plb.219.1554542494907;
 Sat, 06 Apr 2019 02:21:34 -0700 (PDT)
MIME-Version: 1.0
References: <CAN0heSrbjRExHwch0K_W+xwpERnFUJmaiHhCkAaK9nnxFnXEhw@mail.gmail.com>
 <20190405225115.3882-2-tmz@pobox.com>
In-Reply-To: <20190405225115.3882-2-tmz@pobox.com>
From:   =?UTF-8?Q?Martin_=C3=85gren?= <martin.agren@gmail.com>
Date:   Sat, 6 Apr 2019 11:21:22 +0200
Message-ID: <CAN0heSoNNb4QLqQfkgPZRBD2TJ3h1JM3udyRyHnuoOcWbe94Zg@mail.gmail.com>
Subject: Re: [PATCH 1/2] Documentation/git-show-branch: drop last use of {apostrophe}
To:     Todd Zullinger <tmz@pobox.com>
Cc:     Git Mailing List <git@vger.kernel.org>,
        "brian m. carlson" <sandals@crustytoothpaste.net>,
        Jeff King <peff@peff.net>,
        =?UTF-8?Q?SZEDER_G=C3=A1bor?= <szeder.dev@gmail.com>
Content-Type: text/plain; charset="UTF-8"
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

On Sat, 6 Apr 2019 at 00:51, Todd Zullinger <tmz@pobox.com> wrote:
>
> The {apostrophe} was needed at the time of a521845800 ("Documentation:
> remove stray backslash in show-branch discussion", 2010-08-20).  All
> other uses of {apostrophe} were removed in 6cf378f0cb ("docs: stop using
> asciidoc no-inline-literal", 2012-04-26).
>
> Escape only the leading single-quote.  This renders properly in asciidoc
> and asciidoctor.

You could perhaps say that "{apostrophe}" renders literally with
Asciidoctor (at least with 1.5.5). Right now, you sort of undersell this
patch. I know from context that you have some Asciidoctor "issue", but
it's not clear from this patch alone.

> ---
>
> Maybe it would be easier to change the example commit messages
> and avoid having to nest single quotes within double quotes?  I
> don't know if that's much preferable to escaping only the opening
> single quote.

Yeah, those commit messages are a bit unfortunate from the point of view
of quoting. Avoiding all that nesting would probably improve the reading
experience, but I don't think that should hold up this patch.

> This is another potential parsing bug in asciidoctor.  Of course,
> distros will have versions of asciidoctor in place for some time
> which have trouble parsing this doc.  Since it's not much work
> for us to adjust the text to work around it, that seemed
> reasonable.

Agreed.


Martin
