Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-3.4 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,RCVD_IN_DNSWL_HI
	shortcircuit=no autolearn=ham autolearn_force=no version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 9C0B71F404
	for <e@80x24.org>; Tue, 24 Apr 2018 09:36:39 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1754617AbeDXJgh (ORCPT <rfc822;e@80x24.org>);
        Tue, 24 Apr 2018 05:36:37 -0400
Received: from mail-pg0-f43.google.com ([74.125.83.43]:47033 "EHLO
        mail-pg0-f43.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1752953AbeDXJgg (ORCPT <rfc822;git@vger.kernel.org>);
        Tue, 24 Apr 2018 05:36:36 -0400
Received: by mail-pg0-f43.google.com with SMTP id t12so10439489pgp.13
        for <git@vger.kernel.org>; Tue, 24 Apr 2018 02:36:36 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=mime-version:in-reply-to:references:from:date:message-id:subject:to
         :cc;
        bh=0zGsqTzPyHc7UwYrANXGyl4uJ30w6oA9G3AJro3/+pU=;
        b=ko4YUCULMGQrITxSJygoeTs2ozs7cYQ7FmE11IlG4FCQjUSQpvSeChjItqHtXzoCFX
         0kKQWQ7auayMk1la1u2Ov55WEgJHdmGAGxCraexRPgI6nqGeX/u/xRHCNl+82bzdBJhY
         DyobQPpsHDcAXnaQ1y1gspPCi+hR9/gRhwrlzlJk4jR5VbgZ1Km2YmucI1PDaMO3RbKX
         wqTS6e1Ic9eUXgUO/LNqBqHfmXtv0QzgbYVjSM7vykS9mAvCvSUDmL6SM5TElFh8M3E0
         ow4d2S/IPZ5cuBdo1KelL4UNZoKvcr1qjbkSmVeG+I34qzMOuBvco8Sbfrw9y4EY0qDJ
         5izQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:in-reply-to:references:from:date
         :message-id:subject:to:cc;
        bh=0zGsqTzPyHc7UwYrANXGyl4uJ30w6oA9G3AJro3/+pU=;
        b=PbSvca9Mk30X96+b4wFJp/Ac+21FutI/ZHoPy5I9V8HadJaaGAKBCsBBTOQE9lGS/m
         VJ0WxUQZi3BzbUgqMtmyIthSBfNchobLbRi6PdepQeuZDAIeRR6AYfMhI52dm55dtgQ9
         TGErKYCZFkFy5MOj1jRnuixxC2MutdTItQimx6yPjkAzuV4Ua87otHsx/vQkW3Yyc+81
         9pUhzGbjnceZQd07AaVdOwM7TgAQlbgC6Gtw1r5u9Ho5zEnFpDd6sKJltuhIDiBxf5PM
         0SkVeJe9AtNAkk9Ax4MEFC8WE7ieDDAFX1NoOr+n/9rYHs/hoWF3L3dMsyIL6Li7YVUs
         mcqA==
X-Gm-Message-State: ALQs6tBrKjGM5zjBBD03wP0oU9TKuYcvKDerNjZ0gEnBw6TXTBpkCRmD
        qPdIG6M9mpmsmOJ1thKpX4BGb/Z6f4dAVlAc6S0=
X-Google-Smtp-Source: AIpwx49SZY5beNvd7drwJcSarpcnBxmHxHfOV2ZTjkQOLXrTh6nt8/6QmOPM8St5Ajvw9o0W5iZC6NYXBCZWbAJs2eU=
X-Received: by 10.101.99.206 with SMTP id n14mr3174871pgv.316.1524562595624;
 Tue, 24 Apr 2018 02:36:35 -0700 (PDT)
MIME-Version: 1.0
Received: by 10.236.150.4 with HTTP; Tue, 24 Apr 2018 02:36:34 -0700 (PDT)
In-Reply-To: <CA+P7+xqP8b1i4-C242de2_P9dFsZ03pcRGo45scyfK2ohd-ykw@mail.gmail.com>
References: <ec58f482-ffde-1959-ff4a-9b128905ccb0@talktalk.net>
 <cover.1524545557.git.martin.agren@gmail.com> <f140d2795b9dce8b805cd2ebaf076742978ab8ae.1524545557.git.martin.agren@gmail.com>
 <CA+P7+xqP8b1i4-C242de2_P9dFsZ03pcRGo45scyfK2ohd-ykw@mail.gmail.com>
From:   =?UTF-8?Q?Martin_=C3=85gren?= <martin.agren@gmail.com>
Date:   Tue, 24 Apr 2018 11:36:34 +0200
Message-ID: <CAN0heSqo43YkHa-1e7jaZqxktenonj3HZFrF=AKYR4+3ciZ2Sg@mail.gmail.com>
Subject: Re: [PATCH 1/2] merge: setup `opts` later in `checkout_fast_forward()`
To:     Jacob Keller <jacob.keller@gmail.com>
Cc:     Phillip Wood <phillip.wood@talktalk.net>,
        Git mailing list <git@vger.kernel.org>,
        Johannes Schindelin <Johannes.Schindelin@gmx.de>,
        Junio C Hamano <gitster@pobox.com>,
        Stefan Beller <sbeller@google.com>,
        Philip Oakley <philipoakley@iee.org>,
        Eric Sunshine <sunshine@sunshineco.com>,
        Igor Djordjevic <igor.d.djordjevic@gmail.com>,
        Johannes Sixt <j6t@kdbg.org>,
        Sergey Organov <sorganov@gmail.com>
Content-Type: text/plain; charset="UTF-8"
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

On 24 April 2018 at 08:20, Jacob Keller <jacob.keller@gmail.com> wrote:
> I'm guessing the diff algorithm simply found that this was a more
> compact representation of the change? It's a bit confusing when your
> description indicates you "moved" some code down, but it looks like
> you moved code up.

Agreed. I'll play with --anchored and other magic stuff to see if I can
improve this. Or I could instead try to sell this patch as "move some
other stuff out of the way" ;-) That seems a bit less direct though.

Thanks
Martin
