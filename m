Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.2 (2018-09-13) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-4.1 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,
	RCVD_IN_DNSWL_HI,SPF_HELO_NONE,SPF_NONE shortcircuit=no autolearn=ham
	autolearn_force=no version=3.4.2
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 092EA1F461
	for <e@80x24.org>; Sun, 14 Jul 2019 07:38:26 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728009AbfGNHiW (ORCPT <rfc822;e@80x24.org>);
        Sun, 14 Jul 2019 03:38:22 -0400
Received: from mail-io1-f45.google.com ([209.85.166.45]:38402 "EHLO
        mail-io1-f45.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726783AbfGNHiW (ORCPT <rfc822;git@vger.kernel.org>);
        Sun, 14 Jul 2019 03:38:22 -0400
Received: by mail-io1-f45.google.com with SMTP id j6so29140906ioa.5
        for <git@vger.kernel.org>; Sun, 14 Jul 2019 00:38:21 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=usp-br.20150623.gappssmtp.com; s=20150623;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=fjYspN6CKRIpmFVrFVQx0/0I8QP0d4NuF5fQo3FVlQE=;
        b=jJASGeTv3aZW7ra54xuvK4/7/LrBDwOs27vmXC2TFNkBAl+Mxy0Liu4MlsqDzn+2Le
         PC0n/TSvzJU8csKm6ku6B98jicsGu9rOWo/F62Hb1FqB4VixZiW7b2ca9VzhDKKVGztK
         hyM9iasNTNU9PwEHx3RCpc3g/TxVzApXBYI3Fsmpd997FIjSfdBTXvgElsJ0+U9uF4zD
         UtuRKcVFyPbNHAdE5qoujxMtO2vsFUNc1BUnMKWNUJ6ZhKx6TEYW3uO19Fexx2Y5uG9V
         TlALxvde/JarOKDfyXqN2RXzz8BYUarsuQqFwXBgi74YgxOoXMcIvR0E/BXA58f17XqS
         JVUQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=fjYspN6CKRIpmFVrFVQx0/0I8QP0d4NuF5fQo3FVlQE=;
        b=BYGupDnST1QvdbasqrU5KGbWTcw3MrRY3iynRx6NrKph6Vqa/CgBWgsGjAW5tGsTPU
         NiMA9z1/NgjP0xANl6t7lnfx5/0VwPHooXhKq/HcFJex6QHmftJPVn8m/n7xc209eoH1
         HEgUTNH7w1v6H8KsL0IV+fxK6m0rDdayQLIuFBHAs6ZtQp/XI7pSrD45muogiQMPPoPh
         lsbuk7XjavWVQ0Mu6tB1fd3E+7oQAzUzHnGI8uwMLNVYGfC0jm6Rka2QLKJydJC9HjwY
         slX19Yx1nDPlMjopE4MpKpBryb4CDcD4gI55gnU3PM4mRRfPl1YlXluOU69VDxHxnA7Y
         5kZA==
X-Gm-Message-State: APjAAAXngWsNKugQXKv6mf6oiIUvpspk7dmcadHLT4ruI24KuDTaPb86
        VdA4wvkaiqSP+7lA8l08r9PbreLZfNeE1iAHec2VROgBwvQ=
X-Google-Smtp-Source: APXvYqypRzHi3ucTTePr6YuPVS46nhraV5PM9jFJFKPBfc5RO0YMYo8DeaGM7TFR2bCiM+8QJv/Q5LLhox5oAMJzRIQ=
X-Received: by 2002:a05:6602:cc:: with SMTP id z12mr6584794ioe.86.1563089901329;
 Sun, 14 Jul 2019 00:38:21 -0700 (PDT)
MIME-Version: 1.0
References: <CAHd-oW5MZNQ=AWwL+4wh6wERYJTMVv_1DKCBk4OK9Asui_bQBA@mail.gmail.com>
In-Reply-To: <CAHd-oW5MZNQ=AWwL+4wh6wERYJTMVv_1DKCBk4OK9Asui_bQBA@mail.gmail.com>
From:   Matheus Tavares Bernardino <matheus.bernardino@usp.br>
Date:   Sun, 14 Jul 2019 04:38:10 -0300
Message-ID: <CAHd-oW7V_oK5Tqg-fF3G-7r+k7eX8czyaT77yBPoEDoXVthj8g@mail.gmail.com>
Subject: Re: [GSoC] My project blog
To:     git <git@vger.kernel.org>
Cc:     Christian Couder <christian.couder@gmail.com>,
        =?UTF-8?B?0J7Qu9GPINCi0LXQu9C10LbQvdCw0Y8=?= 
        <olyatelezhnaya@gmail.com>, Thomas Gummerer <t.gummerer@gmail.com>,
        Elijah Newren <newren@gmail.com>,
        Rohit Ashiwal <rohit.ashiwal265@gmail.com>
Content-Type: text/plain; charset="UTF-8"
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Hi, everyone

I just posted a new update about my GSoC project here:
https://matheustavares.gitlab.io/posts/week-8-a-working-parallel-inflation
Please, feel free to leave any comments. I've finally solved the race
condition problem and now we have a working parallel inflation :) But
there's still some tasks to be done on it before I have a proper
patchset.

Thanks,
Matheus
