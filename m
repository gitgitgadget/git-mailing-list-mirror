Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 4BF8AC76196
	for <git@archiver.kernel.org>; Fri,  7 Apr 2023 21:58:51 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231432AbjDGV6u (ORCPT <rfc822;git@archiver.kernel.org>);
        Fri, 7 Apr 2023 17:58:50 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:54488 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229741AbjDGV6s (ORCPT <rfc822;git@vger.kernel.org>);
        Fri, 7 Apr 2023 17:58:48 -0400
Received: from mail-ej1-x632.google.com (mail-ej1-x632.google.com [IPv6:2a00:1450:4864:20::632])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id A2A3FB463
        for <git@vger.kernel.org>; Fri,  7 Apr 2023 14:58:45 -0700 (PDT)
Received: by mail-ej1-x632.google.com with SMTP id a640c23a62f3a-946a769ae5cso188204466b.1
        for <git@vger.kernel.org>; Fri, 07 Apr 2023 14:58:45 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20210112; t=1680904724;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=Yi4TpOb6C+GUGBE7SMOz+jttt74AaCYyn00NCgtsEfU=;
        b=gCizxj/3dzZORs0tWbK57ioFkJo5+bAthEUpLrEVHhLC0bvMySdvmuMNKJPVz05OAw
         4cynY058k0+s37lXO9iRqWHNDLmTfKGfqt9wFgUADZeK85OU9uWkZBjlSw01JFjf0ubg
         q4/BZ3pPJdNnDnrP9QRQX9EnDU1OI/Hh/EIBnTA44ri1+r907lTCPhAHPYLl3PEpfDkU
         d80DBxBdAUFqSKAeHnnf4vyZx6xKaOq7Nj5JbKiSnHFIYTx1i7+1JrBriil5/nCRFbIA
         GOVBffsNOGtXMbltrr06DYYkT4Tf940fRtCk5QX5p7/YKtQy9kjQZyvzOJ0SbWhgO0qO
         ZDLg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112; t=1680904724;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=Yi4TpOb6C+GUGBE7SMOz+jttt74AaCYyn00NCgtsEfU=;
        b=mH1sH5Jo1y0RuSdjCY/xVzeWBA+Yl5L2yOPwhjO8V7hhNjIdVON/V5XP04/mpVkYEU
         kpg3sZN4ej/hDIl6/LxDKoSIT6rn5QbSoWuWTgIlq9VVNTav7zI6JcWlmc6NpWiyHOFo
         5UWRR8t6sgK5nF4WJbKBUpgEmPwMPHqkNuEQPiOrFYF90sjbuCXvSix7hso0pzzJ2nit
         O6CJ1aMUNrrV6Q49Fs/Px/6y9enSV5kYhySbooG6XIu9YZlNSMhSrm6t/IVbI4I3xYYz
         Z3jau+xNC4XSpJg7Iw0olVyN0Zft5tc8FHCQrpKB2IETDJisCgDslh9b2+6YoBTbCqvo
         qDkw==
X-Gm-Message-State: AAQBX9efQBg2QAvwX+R0YcasT1YInYGazh0fiPdSTT7PWmf+++mUlFyY
        SMf+Z5XtmN/+gWTfhjdYVAkB4QJEx6XY2RxQpPIczI27EIRAEUWqoZ4=
X-Google-Smtp-Source: AKy350bIxujGHSJqaM1zAt+GxpEzKImJKfq3Qnt4Gmo7iQwdnpxuQBQMYIP7Kau6+m6E9lckAaF6ZgzvZGU+Q56KPjU=
X-Received: by 2002:a50:d542:0:b0:504:7027:e320 with SMTP id
 f2-20020a50d542000000b005047027e320mr1497394edj.6.1680904723909; Fri, 07 Apr
 2023 14:58:43 -0700 (PDT)
MIME-Version: 1.0
References: <20230407212249.1541509-1-nasamuffin@google.com> <xmqq5ya7jrzm.fsf@gitster.g>
In-Reply-To: <xmqq5ya7jrzm.fsf@gitster.g>
From:   Emily Shaffer <nasamuffin@google.com>
Date:   Fri, 7 Apr 2023 14:58:31 -0700
Message-ID: <CAJoAoZnHPUvZONv8kgb_c2HvsEXHMnLCZShOOjE+uE0ainieVA@mail.gmail.com>
Subject: Re: [PATCH] mailmap: change primary address for Emily Shaffer
To:     Junio C Hamano <gitster@pobox.com>
Cc:     git@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

On Fri, Apr 7, 2023 at 2:35=E2=80=AFPM Junio C Hamano <gitster@pobox.com> w=
rote:
>
> emilyshaffer@google.com writes:
>
> > From:   emilyshaffer@google.com
> > Subject: [PATCH] mailmap: change primary address for Emily Shaffer
> >
> > Emily finally figured out how to set up their alias at DayJob, and woul=
d
> > prefer to use nasamuffin@google.com, partially to reduce confusion
> > between IRC and list, and partially because they just like the alias a
> > lot more.
> >
> > Signed-off-by: Emily Shaffer <nasamuffin@google.com>
> > ---
> >  .mailmap | 1 +
> >  1 file changed, 1 insertion(+)
>
> Cute.  By telling the machinery to map "<emilyshaffer@google.com>"
> (with any name) to "Emily Shaffer <nasamuffin@google.com>", and
> using a nameless <emilyshaffer@google.com> as the sender for the
> mail to add such a mailmap entry, the result of applying such a
> patch, even though the underlying commit object created lacks the
> human-readable name, like so:
>
>     $ git cat-file commit HEAD
>     tree cec72ed0d4fb9faa44cd8d23008f90da3239808b
>     parent 0607f793cbe0af16aee6d2480056d891835884bd
>     author emilyshaffer@google.com <emilyshaffer@google.com> 1680902569 -=
0700
>     committer Junio C Hamano <gitster@pobox.com> 1680902794 -0700
>
>     mailmap: change primary address for Emily Shaffer
>     ...
>
> would show with a substituted author:
>
>     $ git show HEAD
>     commit 2485a52e4b4419020286e98dd04c0e5ebb218f06
>     Author: Emily Shaffer <nasamuffin@google.com>
>     Date:   Fri Apr 7 14:22:49 2023 -0700
>
>         mailmap: change primary address for Emily Shaffer
>         ...

Oh, yuck. I guess I'm sending nameless From: line because of
poorly-configured git-send-email settings. I'll look into it.

>
> I'll amend the commit to record the nasammuffin name instead,
> though.

Thanks muchly.

 - Emily
