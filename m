Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.2 (2018-09-13) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-3.9 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,RCVD_IN_DNSWL_HI,
	SPF_HELO_NONE,SPF_NONE shortcircuit=no autolearn=ham
	autolearn_force=no version=3.4.2
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 5670B1F463
	for <e@80x24.org>; Wed, 25 Sep 2019 13:36:53 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2406565AbfIYNgw (ORCPT <rfc822;e@80x24.org>);
        Wed, 25 Sep 2019 09:36:52 -0400
Received: from mail-oi1-f196.google.com ([209.85.167.196]:36515 "EHLO
        mail-oi1-f196.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S2406133AbfIYNgw (ORCPT <rfc822;git@vger.kernel.org>);
        Wed, 25 Sep 2019 09:36:52 -0400
Received: by mail-oi1-f196.google.com with SMTP id k20so4899887oih.3
        for <git@vger.kernel.org>; Wed, 25 Sep 2019 06:36:51 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=9BI0PFv8NZYOJJUFLz5snJdFAl6eUP4NB5dOSJZJ2v0=;
        b=vOtxLWaOsdS9hqHoqqur55B1KN2quwY8BfFpecQOqy50jLdLYSXPor868NIlfVxEtA
         6tyKg/O93X9YLstszjyV/PBRgaUIbLmaWvErtbdZioXaAwHxv9QZqFxmyWWc06oxcOax
         GjSPVJHkwq6s3gbE/eaBwEM4XqDPLEVZTR6ZmaizKXV/X+9txW1cgP3D1UU+siogcIcv
         YV3evzOMEHTwuuDfyT1KhPZFUwkqjzlndcXhmcbLvfbvICanshKRzXuq2jU2zdLLW2vC
         l8Omblqi7LEBp7CHqW0LlJODL4C6OLNnDids9ajRvqWwxlKC0UEzcTalaoQTUObWt2Mr
         7vbQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=9BI0PFv8NZYOJJUFLz5snJdFAl6eUP4NB5dOSJZJ2v0=;
        b=j2rc7njyy8QQ08PCtAc30szwZzE8qPEoEJvTaUPaafMHSnFna795nMkf3mOf+sQua6
         QuPkyRMCkP5LYO1iHEibA3ZUvuj1sp70ShBz4rmKU3rxkMb9ruzJs+fQielM4NaMuEbZ
         hp+Rz57mrjU2NoADFwoVozvC1iwxSneDCy+X+F+0nCH4afX9d4IBEn/Fwh67hVnP9yMp
         0HI8K9dgxOygoTI2CdRvGFgzi2fWmMlNr6ayB9c3+8MzV6hN92dLcwug7ytA8UA5Ddtj
         ixB/Q0CkRKXn7JPMJ7y5WftFFauqT3S31bA5QCV0gazuWvJgtTk/eapznZ4Vgt7ACu82
         idIQ==
X-Gm-Message-State: APjAAAXVgaCzZJTKrQ1EPDimKy2NZNpR6IQdFi0yiRLLgz6Szw0/VpUy
        K3/2MjDmHvbd7UX200an3gUwBSBnmyR/BH4eG8wa+q56
X-Google-Smtp-Source: APXvYqwwur49/fNbPTWnOM1wZOpz/SkXQFS5c7mZrVuaPdwLilQrXTa7J6ryzctLtbbSSlg4lWn5jJs84RgmLvIfsXE=
X-Received: by 2002:a54:4383:: with SMTP id u3mr4655536oiv.168.1569418610660;
 Wed, 25 Sep 2019 06:36:50 -0700 (PDT)
MIME-Version: 1.0
References: <71fba9e7-6314-6ef9-9959-6ae06843d17a@gmail.com> <CABPp-BFXs4qes20S+9AZd++p3epW4eJ7Vu7zU_PdDysZ_D-yrg@mail.gmail.com>
In-Reply-To: <CABPp-BFXs4qes20S+9AZd++p3epW4eJ7Vu7zU_PdDysZ_D-yrg@mail.gmail.com>
From:   Pierre Tardy <tardyp@gmail.com>
Date:   Wed, 25 Sep 2019 15:36:39 +0200
Message-ID: <CAJ+soVcmMwy7GgLcV-m1kNEsHYirHMQQeFuEYZanbCNUK4_zHg@mail.gmail.com>
Subject: Re: [DISCUSSION] Growing the Git community
To:     Elijah Newren <newren@gmail.com>
Cc:     Derrick Stolee <stolee@gmail.com>,
        "git@vger.kernel.org" <git@vger.kernel.org>,
        "peff@peff.net" <peff@peff.net>,
        Emily Shaffer <emilyshaffer@google.com>,
        Jonathan Nieder <jrnieder@gmail.com>,
        Johannes Schindelin <Johannes.Schindelin@gmx.de>,
        "gitster@pobox.com" <gitster@pobox.com>, garimasigit@gmail.com
Content-Type: text/plain; charset="UTF-8"
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

> > As a community, our number one goal is for Git to continue to be the best
> > distributed version control system. At minimum, it should continue to be
> > the most widely-used DVCS.
>
> I'd rather we stated our goal in terms of what problems we are trying
> to address rather than accolades we want sent our way.  E.g. "Our goal
> is to make developers more productive by providing them increasingly
> useful version control software".
>

Agreed.
And why restrict on DVCS?
Isn't it admitted that the distributed version control is nowadays
much better in term of software productivity?
Is there some use cases that "traditional" centralized VCS are better
on, and on which we gave up as a goal?

Regards,
Pierre
