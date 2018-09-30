Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.1 (2015-04-28) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-3.6 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,RCVD_IN_DNSWL_HI
	shortcircuit=no autolearn=ham autolearn_force=no version=3.4.1
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id E40321F453
	for <e@80x24.org>; Sun, 30 Sep 2018 16:57:21 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728533AbeI3XbH (ORCPT <rfc822;e@80x24.org>);
        Sun, 30 Sep 2018 19:31:07 -0400
Received: from mail-io1-f67.google.com ([209.85.166.67]:46329 "EHLO
        mail-io1-f67.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1728393AbeI3XbH (ORCPT <rfc822;git@vger.kernel.org>);
        Sun, 30 Sep 2018 19:31:07 -0400
Received: by mail-io1-f67.google.com with SMTP id t7-v6so116164ioj.13
        for <git@vger.kernel.org>; Sun, 30 Sep 2018 09:57:20 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=zl1eQ7eUrKXwWz6gW4816Q0kOwiyIMWFxVWEe2wh6h4=;
        b=ujvxRHd1uaskYi5vl5PoqF3llbR/b0gusur31pSTRaNbAfLZ9wp8q+lJDkT1MF1k1k
         t1RmKbLpkfm3TER5+LUi/GXPXZlPCzl9dxfKnLn+7CVN6mvCVEpA1qbCgkudDxTvaksB
         feooskkWaWMYF6ZV7EtHwP4w7EeqeHZXlDk5ZR5LVpdFBx2KiCGH2hOOXJcWOhSScVa0
         Q1eeZP3HKCqoXW8VrHQ6DhfOX7osLgaw6J2cKsKYC22eJVKqcj1y0XEt8NeSLraqKVI9
         edpESiVzd0pob1K8ZsXAqKmXzzQZn6BG3plvFbdcNr/QQzdN8Is34Bh3FlyHm3SuZul8
         kjVA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=zl1eQ7eUrKXwWz6gW4816Q0kOwiyIMWFxVWEe2wh6h4=;
        b=qOiF4UTd0THlrPT42W90w4SPf+/7sba2BFIKEjLi3iGnD7gVysVrzA10uVnnrN9ybJ
         CsD4JMOO7HGXg/doknj+tJ2QXY7Nr6QVmHqUFdoQeEjeC32vF6Ilqb7ijxrhfpPUwxlJ
         PDXjGqeAAQsxQpn6CuwE1WbGjiVy6pz49IWcGxKJYsvVCt6R5nj/IjapZhWvBbhCMso5
         pk6F6Y9OGvDrCUCioyMXGUAG+pubvcZGRzCofRRQTI9GLc5J3Pnk/jZQxPV+C1R7By8p
         J3oMryLXsbuH5DggzBRLS6GvqyBTkCn55MDkVACddPmgjFgUR07MjR+ev1la50zj25qK
         52rw==
X-Gm-Message-State: ABuFfoi/GSqrobz5RW1J+1hr3gkaIj8t6JI9BjRChOHV7o/obWxhhzOz
        RSH4YEMe51wXFpF+htRzRm4sTlOQC6SNoFQ/hOY=
X-Google-Smtp-Source: ACcGV63iEzjOglEihNCh2HRwEDLRoI7Svk3EObsKHh/SeiHUvelNcdNcNp3SgGJSRd8iKC2tJTrCj1eT5bt2q/C2/D8=
X-Received: by 2002:a6b:1a11:: with SMTP id a17-v6mr4612729ioa.223.1538326639587;
 Sun, 30 Sep 2018 09:57:19 -0700 (PDT)
MIME-Version: 1.0
References: <CA+=o6KHC=wkJCK9g4aVdaw6CieXr3qFJTb1GHa48=vQaOdRh6g@mail.gmail.com>
In-Reply-To: <CA+=o6KHC=wkJCK9g4aVdaw6CieXr3qFJTb1GHa48=vQaOdRh6g@mail.gmail.com>
From:   Christian Couder <christian.couder@gmail.com>
Date:   Sun, 30 Sep 2018 18:57:07 +0200
Message-ID: <CAP8UFD0XS3vsB1n_Jm=4TrdXqc8zU9+3LBU5CFn5TDYhYgf=2Q@mail.gmail.com>
Subject: Re: [Outreachy] Introduce myself
To:     ananyakittu1997@gmail.com
Cc:     git <git@vger.kernel.org>,
        Johannes Schindelin <Johannes.Schindelin@gmx.de>
Content-Type: text/plain; charset="UTF-8"
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Hi Ananya,

On Sun, Sep 30, 2018 at 5:53 PM Ananya Krishna Maram
<ananyakittu1997@gmail.com> wrote:
>
> Hi Git Community, Christian and Johannes,
>
> My initial Outreachy got accepted.

Great! Welcome to the Git community!

[...]

> Having done a lot of assignment in C and
> bash scripting and keen interest to learn about working of git
> internals, I choose to contribute to this project. So I started
> observing the patches sent to git mailing list.

About possible projects I updated https://git.github.io/Outreachy-17/
but only the `git bisect` has been officially proposed as an Outreachy
project. I hope Dscho (Johannes) will be ok to submit one of the 2
others soon and to register himself as a mentor or co-mentor on some
of the projects.

> I am currently looking for first patch opportunities to git. I came
> across[1] and I will try to put maximum effort towards my goal and if
> I need some clarification of the problem statement I guess you guys or
> Outreachy mentors will be here to help me.

The micro-project page you found is not up-to-date, so some
micro-projects we propose might have already been taken by GSoC
students last winter/spring. Sorry we didn't update the page or create
another one. Anyway there are some micro-projects there like "Add more
builtin patterns for userdiff" that are still valid and still good
small tasks to get started working on Git. And there are explanations
about how you can search for micro-projects (especially how to search
for #leftoverbits on the mailing list archive).

Thank you for your interest in contributing to Git,
Christian.
