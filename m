Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-3.2 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_HI,
	RP_MATCHES_RCVD shortcircuit=no autolearn=ham autolearn_force=no version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 0B51C1F7D2
	for <e@80x24.org>; Mon,  5 Jun 2017 22:25:08 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1751237AbdFEWZG (ORCPT <rfc822;e@80x24.org>);
        Mon, 5 Jun 2017 18:25:06 -0400
Received: from mail-pg0-f44.google.com ([74.125.83.44]:36160 "EHLO
        mail-pg0-f44.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1751180AbdFEWZF (ORCPT <rfc822;git@vger.kernel.org>);
        Mon, 5 Jun 2017 18:25:05 -0400
Received: by mail-pg0-f44.google.com with SMTP id a70so19167426pge.3
        for <git@vger.kernel.org>; Mon, 05 Jun 2017 15:25:04 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20161025;
        h=mime-version:in-reply-to:references:from:date:message-id:subject:to
         :cc;
        bh=vN33Jrw93Sqf3f92mCVlzcX2B1pQWEe1wU5QsEl7KTU=;
        b=IXusKDqa6nlbiQWxRWrU2XosbdwbQZckVKrlN1sqJ6fyfdRRhZwTVEoYOjLm7NUjHi
         teGZjOxQGpR9aL8Lzl/4WvjxJxSQaDJwR6odhc+9hQkedfzQc3nb54lcHqWUb+457H2y
         KzadWynLuQaCjhZI83hkjORchmZah3cdaCwn1sVe+Ucq5lvmf1XbNtbqWX/x+P7K4q87
         OX4Jrq7FNCn7ieiaxIgV+bEsVQlWKDt1zSpZaw1iTgJwtvIEGgcnfO28JXndkfFzPjqX
         vuD2GwhzMr7hgtzMc05Ns1TlImF3xy4tzgu4qDZQWhfANK5KoUr8H9H3GGFVevEbIXu6
         nb7g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:in-reply-to:references:from:date
         :message-id:subject:to:cc;
        bh=vN33Jrw93Sqf3f92mCVlzcX2B1pQWEe1wU5QsEl7KTU=;
        b=T18MOWKS4nyLZ5NTP+cPjDGcv1FuMO7+ZL0ZJvCuZyG6EwCZw8gXeEtm4AV/fEIL0h
         VYlwsYbxcWf+HjZN9o7WPSBDPzGQiw7eCs9pN+ra5Cp7efMcBGUQk5mLMD5Qd0XH+zgv
         sKGR2E/Fjetz18G68zTkmxZMPYGXJRML99Ni+NgGo4BfmP1n942f5u40RHBMQsV/LvSj
         QbiFawwx6d46S7ahPE2GdPCQ+sRKt4Hv5W1qglT5BZ1hDlTG9smFWjZP9bU5T6+CmbdH
         0CA47GyMj1EtCsplqY0WLKhm8vPYpq7WVrnR9exRJT9W0XSpZzLGEKjS4M4ZZloMGqtO
         iSwA==
X-Gm-Message-State: AODbwcAu6iZEaI5PyoGlIorQ40YlvHvXtEEWBeW0F/3qbQVnb/dE5eO8
        xTME9fPcNbvkHIIIUayyXrNysTgJIbl5
X-Received: by 10.84.209.228 with SMTP id y91mr17695645plh.210.1496701504351;
 Mon, 05 Jun 2017 15:25:04 -0700 (PDT)
MIME-Version: 1.0
Received: by 10.100.218.134 with HTTP; Mon, 5 Jun 2017 15:25:03 -0700 (PDT)
In-Reply-To: <CAME+mvXACX7DejOKDJ=-qV8Ex9ZdYT4vXYV+7AeesaKYUk1sGw@mail.gmail.com>
References: <CAME+mvXACX7DejOKDJ=-qV8Ex9ZdYT4vXYV+7AeesaKYUk1sGw@mail.gmail.com>
From:   Stefan Beller <sbeller@google.com>
Date:   Mon, 5 Jun 2017 15:25:03 -0700
Message-ID: <CAGZ79kasawzm19HtZmAe71FxwPq5GTuCWW+3S2CWYHymVSBTEg@mail.gmail.com>
Subject: Re: [GSoC] Update: Week 3
To:     Prathamesh Chavan <pc44800@gmail.com>
Cc:     git <git@vger.kernel.org>,
        Christian Couder <christian.couder@gmail.com>
Content-Type: text/plain; charset="UTF-8"
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

On Mon, Jun 5, 2017 at 1:56 PM, Prathamesh Chavan <pc44800@gmail.com> wrote:
> 1. foreach: After a discussion over the issue of the path variable in
>    windows, in this week my mentor, Stefan Beller came up with the
>    appropriate solution for the problem after discussing it with Ramsay
>    Jones.

Thanks for having so much faith in my abilities, but it may not be
appropriate, yet. (It does multiple things at once, which is generally
a bad sign already. )

Maybe to be unblocked on the conversion of foreach, you could make
the patch have the original behavior, i.e.

<up_path><submodule path>

which makes sense in the way that it is only converting from shell to C,
not fixing a bug along the way. As we discovered a bug, you could just put
a NEEDSWORK comment explaining what the problem is; deferring solving
the issue until later.

I'll review the other patches.

Thanks,
Stefan
