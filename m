Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.1 (2015-04-28) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-3.6 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,RCVD_IN_DNSWL_HI,
	T_DKIMWL_WL_MED shortcircuit=no autolearn=ham autolearn_force=no version=3.4.1
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 899DF1F404
	for <e@80x24.org>; Tue, 28 Aug 2018 14:15:40 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727524AbeH1SHa (ORCPT <rfc822;e@80x24.org>);
        Tue, 28 Aug 2018 14:07:30 -0400
Received: from mail-lf1-f41.google.com ([209.85.167.41]:35199 "EHLO
        mail-lf1-f41.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726998AbeH1SHa (ORCPT <rfc822;git@vger.kernel.org>);
        Tue, 28 Aug 2018 14:07:30 -0400
Received: by mail-lf1-f41.google.com with SMTP id q13-v6so1526193lfc.2
        for <git@vger.kernel.org>; Tue, 28 Aug 2018 07:15:37 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=edwardthomson-com.20150623.gappssmtp.com; s=20150623;
        h=mime-version:in-reply-to:references:from:date:message-id:subject:to
         :cc:content-transfer-encoding;
        bh=YhYqsFrruRaI48choYoQSeHoTWDgBVYZ3+VRy7RLjaY=;
        b=NcvR33ldEIgDWYtng1xdKQ0iws6zWl+/WZllnUAk6iUorV+iq0Uo4EVTk0ymynVelq
         iz50elkXUeiMLa88D/YcETWrNvtJi/ex2IM8tkhe2gelH9R+/59cMD1SaI1ipp3AhEe1
         XYQ4pm9MriZKfViUUids68QgKT1NX2Dh1bpwRD7rQWIg3trrJmfLZs9+i6oZKf1qKi6M
         eb8zBfxpxuf1e35dm/bU5i7FFunZPhrFIyUDjA70mrPjytZI0ctYSdeNVhTNEjGtCM2h
         CDu2fXHTSkW36bv7wdxMLmT9jyI53FbmMWTRaId6gWHoU7sZ1VEGFd++4BbI086CDPe7
         RyVg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:in-reply-to:references:from:date
         :message-id:subject:to:cc:content-transfer-encoding;
        bh=YhYqsFrruRaI48choYoQSeHoTWDgBVYZ3+VRy7RLjaY=;
        b=cJKnQc0MzdqxjdT0+rEj1AbvukCyerhP0bwu6G0UYmLegWrD+/DCJXZqclb+f9BeRz
         7bRkQWDVvdi6kwPeJWuduKo3vqngIwzgwoL4MMPYhVzJeQMW7hS2BIMdeVp3x5lOjJXl
         jqcSJIDojqytWi1Jt1fy6fe3qFm1kKjOmeGYRSkSMKR0d3SglH7CHPkyYSord5Uzs6d1
         TB45DAko3uUpR0X3vkj5V5y6q0e0V5H//PPLVkDyg4E9d/qTNJVCo/0W7lodZtMKclmN
         Tbm0MsKn6Cv0WS2BQr9gh1tfTobQ16S17KSKaINN1Xmaik+YRwYHu7uQa1NPqCNBvotP
         psRg==
X-Gm-Message-State: APzg51DAhFQSt5bfuL0fiqYvVpZzmcwl6K193CNtnZFnbsb0DpwADI8I
        m6wrVF4l4IeWcnONx/NbrSM2ZYH+qpKG/cJMpHh95A==
X-Google-Smtp-Source: ANB0VdbUv2pnjujaZ1fGIfBBexfKbwMUBzmj9tg4/t0pBQhrZPBtEvbOT5JpvbX1HaYHocfLfth5lyl2kEDqkUIlf28=
X-Received: by 2002:a19:d85c:: with SMTP id p89-v6mr1402985lfg.27.1535465736612;
 Tue, 28 Aug 2018 07:15:36 -0700 (PDT)
MIME-Version: 1.0
Received: by 2002:a2e:8ec1:0:0:0:0:0 with HTTP; Tue, 28 Aug 2018 07:15:35
 -0700 (PDT)
In-Reply-To: <87h8jeeh2e.fsf@evledraar.gmail.com>
References: <878t4xfaes.fsf@evledraar.gmail.com> <87h8jeeh2e.fsf@evledraar.gmail.com>
From:   Edward Thomson <ethomson@edwardthomson.com>
Date:   Tue, 28 Aug 2018 15:15:35 +0100
Message-ID: <CA+WKDT1k1SpHQmUKunV+vC+VLBfTBjZBgw+n4NeTE=oKxWL-Sg@mail.gmail.com>
Subject: Re: Questions about the hash function transition
To:     =?UTF-8?B?w4Z2YXIgQXJuZmrDtnLDsCBCamFybWFzb24=?= <avarab@gmail.com>
Cc:     Git Mailing List <git@vger.kernel.org>,
        Junio C Hamano <gitster@pobox.com>,
        Linus Torvalds <torvalds@linux-foundation.org>,
        "brian m . carlson" <sandals@crustytoothpaste.net>,
        Jonathan Nieder <jrnieder@gmail.com>,
        Johannes Schindelin <Johannes.Schindelin@gmx.de>,
        demerphq <demerphq@gmail.com>,
        Brandon Williams <bmwill@google.com>,
        Derrick Stolee <stolee@gmail.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

On Tue, Aug 28, 2018 at 2:50 PM, =C3=86var Arnfj=C3=B6r=C3=B0 Bjarmason
<avarab@gmail.com> wrote:
> If we instead had something like clean/smudge filters:
>
>     [extensions]
>         objectFilter =3D sha256-to-sha1
>         compatObjectFormat =3D sha1
>     [objectFilter "sha256-to-sha1"]
>         clean  =3D ...
>         smudge =3D ...
>
> We could apply arbitrary transformations on objects through filters
> which would accept/return some simple format requesting them to
> translate such-and-such objects, and would either return object
> names/types under which to store them, or "nothing to do".

If I'm understanding you correctly, then on the libgit2 side, I'm very much
opposed to this proposal.  We never execute commands, nor do I want to star=
t
thinking that we can do so arbitrarily.  We run in environments where that'=
s
a non-starter

At present, in libgit2, users can provide their own mechanism for running
clean/smudge filters.  But hash transformation / compatibility is going to
be a crucial compatibility component.  So this is not something that we
could simply opt out of or require users to implement themselves.

-ed
