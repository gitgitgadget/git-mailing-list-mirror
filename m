Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.1 (2015-04-28) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-4.0 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,RCVD_IN_DNSWL_HI
	shortcircuit=no autolearn=ham autolearn_force=no version=3.4.1
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id D38781F97E
	for <e@80x24.org>; Sun, 19 Aug 2018 02:32:52 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1725850AbeHSFml (ORCPT <rfc822;e@80x24.org>);
        Sun, 19 Aug 2018 01:42:41 -0400
Received: from mail-vk0-f53.google.com ([209.85.213.53]:39838 "EHLO
        mail-vk0-f53.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725741AbeHSFml (ORCPT <rfc822;git@vger.kernel.org>);
        Sun, 19 Aug 2018 01:42:41 -0400
Received: by mail-vk0-f53.google.com with SMTP id e139-v6so4973132vkf.6
        for <git@vger.kernel.org>; Sat, 18 Aug 2018 19:32:51 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc:content-transfer-encoding;
        bh=xm6keO1223Vk9k4klWxkXnsiZm4LoG4a3ywYrGjY/XM=;
        b=Sc4DyaYJdRX8HzGp2jpyUFJCKHuZ2zkXn0VX6mljn5WqvzQqMluJEvXZKimhke+TNm
         tfwTPlutp6vhvzi53mmeAyuizn2dNBOQfAatBNd/KVB3WIEvQF57mUhtroK5mtlIXi86
         ynTvSQ7CCtygkcIE1WqBskfCIVuMb7NR7vnTCHcoDgctV/N19rtaCKeAZizdNKTDMOKC
         kJD1eKgL3B1uc4YjKKQBMhxxOtxOefE7sPje78QAsEJZ1klvlMqoxdahzGtHQ+q9nTIP
         a3Rrtbt4WUkujtIVZE/ufI1MfWIHB3oIB0+8cdgco7/nu8KcwfC/cA5ukoe+4HQM1Wpj
         iU0Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc:content-transfer-encoding;
        bh=xm6keO1223Vk9k4klWxkXnsiZm4LoG4a3ywYrGjY/XM=;
        b=XOKiD65Hq9OCxzmSSIkGvXxw9nn6LGDaXiOBkan+83dY70VVv0ynLao50uMRxXGSzr
         kS2SrbAUUv+JwUAH0SK1G51NOYUfldzDV0HYDizrabfoAKtpKxMWJYSadoi6Az1If27w
         FL+f23pdxd1sXLVCyDrffNPXcooXENsi2Le9zzApFIgGrwFvkP4NZHljy6gUB1226muD
         0qgxKMnCdABkbtB8NxWRa2ZtqUQQlCZtFxeW7zlWMzC2TRkokphAq3tQOymTXdUatA9Y
         rdZkiytx0RbpLWXlqQVI+5gTqg8RMnLzCuZ8bnx3/IKeAXCuhxwxs9BFNuDs7ZdpV3g0
         M9Lg==
X-Gm-Message-State: AOUpUlH0I8gqo2GwHmwKscsEq6Wmwuqst2GuUxUEYdRpewBEVkZ73uI1
        NPsZMIfwnOhRzGuuULa8VLiqEIXN+O3wP4FuH84=
X-Google-Smtp-Source: AA+uWPwMYRzvkMHlz/sjV2ZsOSMZA0CXhmmr0f58/T006x0GOog4cJAOMVZqwXvp5xlJ7shFmmPVHiJRH/5DOLdNVG0=
X-Received: by 2002:a1f:5c7:: with SMTP id 190-v6mr26706307vkf.47.1534645970330;
 Sat, 18 Aug 2018 19:32:50 -0700 (PDT)
MIME-Version: 1.0
References: <20180816224138.GA15490@sigill.intra.peff.net>
In-Reply-To: <20180816224138.GA15490@sigill.intra.peff.net>
From:   Elijah Newren <newren@gmail.com>
Date:   Sat, 18 Aug 2018 19:32:38 -0700
Message-ID: <CABPp-BGq7rw6YfyxGJbhcGeeVONTSkAzE7h8CiVNx_AA-veUgQ@mail.gmail.com>
Subject: Re: Git Project Leadership Committee
To:     Jeff King <peff@peff.net>
Cc:     Git Mailing List <git@vger.kernel.org>,
        Junio C Hamano <gitster@pobox.com>,
        Christian Couder <christian.couder@gmail.com>,
        =?UTF-8?B?w4Z2YXIgQXJuZmrDtnLDsA==?= <avarab@gmail.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

On Thu, Aug 16, 2018 at 3:43 PM Jeff King <peff@peff.net> wrote:
>  - we should avoid anyone who is affiliated with a company that already
>    has a member on the committee. So nobody from Google and nobody from
>    GitHub. I would extend that to Microsoft, too, given a certain
>    impending acquisition. I'd expect anybody who is affiliated with a
>    company to recuse themselves from decisions that directly affect that
>    company (which is what we've done so far).

That might make it hard for some of us to nominate others, since as
far as I can tell (e.g. looking at shortlog -sne output) few git
contributors use work email addresses to do so and we don't
necessarily know employers of other contributors.

> So here are the nominations I came up with. If you'd like to nominate
> somebody else (or yourself!), please do. If you have opinions, let me
> know (public or private, as you prefer).
>
>  - Christian Couder
>  - =C3=86var Arnfj=C3=B6r=C3=B0 Bjarmason

I think either of them would be excellent choices.
