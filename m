Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.1 (2015-04-28) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-3.6 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,RCVD_IN_DNSWL_HI
	shortcircuit=no autolearn=ham autolearn_force=no version=3.4.1
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 448031F453
	for <e@80x24.org>; Mon, 15 Oct 2018 16:18:09 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726588AbeJPAEB (ORCPT <rfc822;e@80x24.org>);
        Mon, 15 Oct 2018 20:04:01 -0400
Received: from mail-qt1-f196.google.com ([209.85.160.196]:46986 "EHLO
        mail-qt1-f196.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726557AbeJPAEB (ORCPT <rfc822;git@vger.kernel.org>);
        Mon, 15 Oct 2018 20:04:01 -0400
Received: by mail-qt1-f196.google.com with SMTP id d8-v6so22073800qtk.13
        for <git@vger.kernel.org>; Mon, 15 Oct 2018 09:18:07 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc:content-transfer-encoding;
        bh=U4K1uQ7DWe0/SJ/eRoay1YFQ9Tfe6TXIViC5tBMPA4k=;
        b=QQoYC2WwKmVPx0sl+NID44poZNNPxd8FXfMCfokGMwuno//ftxniFAHzZgUX0VBbxB
         LCUdD7RnW2GHZsD1yKlLrMbaZjjFEz02mGcVTvehvztRZVxN5PVr/vwfKegBCKGAy/9N
         SxtJUROC52Z0ulwQBjLq3HqNaT0EVdtUd7i1mTCfTzS+xONZ8VJWVl/rQo4vBwviFddB
         CTWfpEizAW2EcpGl3J871DvAIirAzXiqsjpXcbboUc1y95I+2o00xPUP0xMyutj+fSSx
         GowOqMPWiAwzznR6lxJmihVlTJERyjsUbL3PpJAuuJwPDGVd6w5mZ0w4g8grqaX7jzLy
         Y53g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc:content-transfer-encoding;
        bh=U4K1uQ7DWe0/SJ/eRoay1YFQ9Tfe6TXIViC5tBMPA4k=;
        b=dRAF4VVoJWar6Rlvd4jSpqzjUnmKtTzpZgRZA0irL/Z3ld6C+6J6oO39drqayS6Hnh
         sdJHPHGNUbHkkmlBMlPwwxUM9rMsigPbL7fJNTQHsQQ7HH+y3yfErsQX+2Qp2mP38p8z
         6TVxPytuBGHAtPsKQPFYnqYKW6DulPJGLj1Ebgfvwf8SpeezFxRrDT+yxG91VsInQcAK
         WElIGYvp4iwyHFvRiLQE8Kx5BCeUApJp8pW+7Bcwftgdfx6dDAQ7MJ5YlhGWgHEBZmha
         mJZ3WCpZaaQtXr82J2JTnDNFgVItzp/B1HJofgrgpj4RQrIaPq2CpA+3fiTJXWmGJrVK
         uq7g==
X-Gm-Message-State: ABuFfojFDwjt6yZ0cgH6h4RGpn8gd/6YYK+CgZsRBqWiBWCCD8RppPYQ
        gEENYQrgDCpJvCt07U0hXC7qQZJlSLjAwB/St48=
X-Google-Smtp-Source: ACcGV60AyTxY2hM/XcOZFzglHCXgVbsegGf3AOFanluhySLhd2JG5K7ogVz8yo6QecK/zAxuOXYtEDTV3e7AlLYOKho=
X-Received: by 2002:a0c:9842:: with SMTP id e2-v6mr17956791qvd.185.1539620286872;
 Mon, 15 Oct 2018 09:18:06 -0700 (PDT)
MIME-Version: 1.0
References: <pull.31.git.gitgitgadget@gmail.com> <8736t7dzan.fsf@evledraar.gmail.com>
 <CACsJy8DeA0Zko4+ZM5F2L6YO5rpvL9LX3H9NB_bVCyO2mJFUzg@mail.gmail.com>
In-Reply-To: <CACsJy8DeA0Zko4+ZM5F2L6YO5rpvL9LX3H9NB_bVCyO2mJFUzg@mail.gmail.com>
From:   Christian Couder <christian.couder@gmail.com>
Date:   Mon, 15 Oct 2018 18:17:55 +0200
Message-ID: <CAP8UFD3cpXpyx-AtTybPirzduFR7TfhFf2woa-_CU46DN3RaXw@mail.gmail.com>
Subject: Re: [PATCH 0/9] Offer to run CI/PR builds in Visual Studio Team Services
To:     Nguyen Thai Ngoc Duy <pclouds@gmail.com>
Cc:     =?UTF-8?B?w4Z2YXIgQXJuZmrDtnLDsCBCamFybWFzb24=?= <avarab@gmail.com>,
        gitgitgadget@gmail.com, git <git@vger.kernel.org>,
        Junio C Hamano <gitster@pobox.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

On Mon, Oct 15, 2018 at 5:46 PM Duy Nguyen <pclouds@gmail.com> wrote:
>
> On Mon, Oct 15, 2018 at 5:08 PM =C3=86var Arnfj=C3=B6r=C3=B0 Bjarmason
> <avarab@gmail.com> wrote:
> > As an aside I poked Junio via private mail in late August to see if he'=
d
> > be interested in pushing to gitlab.com/git/git.git too as part of his
> > normal push-outs.

People at GitLab also have wondered if it would be possible for GitLab
to host an official Git mirror, and I think it would be nice indeed if
Junio could push to gitlab.com.

> > One neat thing that would buy us is the ability to
> > have a .gitlab-ci.yml in git.git and use their CI implementation.

Yeah, that would be nice for people who prefer to use GitLab CI.

In general I agree that it is a good idea to have support for many CI
tools even if it is not always up-to-date and even if it's not used by
many people.

> That would be great since it allows gitlab forks to have CI support
> from the beginning. But gitlab ci has time execution limits if I
> remember correctly and I'm not sure if we'll use it all up before the
> end of the month (or whatever period that is), or do they offer
> something special to git.git?

I can ask for more time if that would help.
