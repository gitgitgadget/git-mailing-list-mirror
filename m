Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.2 (2018-09-13) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-4.1 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,RCVD_IN_DNSWL_HI
	shortcircuit=no autolearn=ham autolearn_force=no version=3.4.2
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 8214820248
	for <e@80x24.org>; Thu, 14 Mar 2019 06:10:36 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727106AbfCNGKf (ORCPT <rfc822;e@80x24.org>);
        Thu, 14 Mar 2019 02:10:35 -0400
Received: from mail-qk1-f196.google.com ([209.85.222.196]:43736 "EHLO
        mail-qk1-f196.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726539AbfCNGKe (ORCPT <rfc822;git@vger.kernel.org>);
        Thu, 14 Mar 2019 02:10:34 -0400
Received: by mail-qk1-f196.google.com with SMTP id s26so2645126qkm.10
        for <git@vger.kernel.org>; Wed, 13 Mar 2019 23:10:34 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=AwgAJ9LAJx9pTZR6yPF43shyJTgznY5wmen000ZFC5E=;
        b=eUwhpSSe71n4PigI4U7xjOyHaM83XTy6f13u+IbmuTYopMMqsrdsTAkW6IIrIPYKNB
         ef1TOCu58s3zkpdPdXOQHWyxPEMMoSNXF2GeUVwkaeZm6AYpcoZ2cPA+D9/2z3QQlImH
         DaO5F9PZGPZafnNynkWd6P+DXjFk/TLKtHrcp7Sy10y/S4hkJW9hVcrW8ysWgqYUO6St
         vxkYqp5CaczbIScBW+87tEAoPCKO8bnXqkq7UCYQHsBZbjAg8uKryTnJMteGd6UxoY0s
         6R6z2bKi+77zVRPo45wN5kx3O4CH/tclvHxl+cfwrJSekhXJoOn/J8QyPxFLUqge8XaL
         vrRg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=AwgAJ9LAJx9pTZR6yPF43shyJTgznY5wmen000ZFC5E=;
        b=m3XrFvRwdO+K0uFm3vtJTEGLnkMkhRi2s33hPiAb6hsH9LVzErIA6IEG/+W5OdhKrn
         8ZY7wAue0fEuwdUZZcONh9SQNAyukOI2D6cc5lFXsB2TjDmjXV1RIGmLXGJ65+b31A29
         GyEZslq4OGBab2A9AFv4A8NOq1y6jkCzBRmaQtMiGql1woS5ebHSpLf7R3wLMqQsuRq0
         MXiAqJOYbFJ6vozxVg+FqAMTO2PXKjJGw985z8rEsg22awijHeg0eu5/0apBl6Jpb+m5
         cPwu5P/3tTI2zmehhihdTp2wI6aaZzIGaFWiEzU19kKkFGhmGek2sFBi/XhI6YHB06yJ
         AEpw==
X-Gm-Message-State: APjAAAXs7Y7/s0TAmg/CndIVtqTdouNujIzv6u2mF4einlVBjQ2o5JFh
        EZpQy5zQQvhM0EJAYGGQOOE/o0K1eB1MK0llgmA=
X-Google-Smtp-Source: APXvYqw4SnUPgukVPLgQQgi3ytZf61tFqCRtNhJiPrFkny4yC2i6fnu1s28B66+jwBz/rk4SdhuG+IL7mM9jkiPq8PA=
X-Received: by 2002:a37:c50f:: with SMTP id p15mr15523292qki.278.1552543833832;
 Wed, 13 Mar 2019 23:10:33 -0700 (PDT)
MIME-Version: 1.0
References: <CAC05386q2iGoiJ_fRgwoOTF23exEN2D1+oh4VjajEvYQ58O1TQ@mail.gmail.com>
 <20190219083123.27686-1-nbelakovski@gmail.com> <20190221123646.GA12185@sigill.intra.peff.net>
In-Reply-To: <20190221123646.GA12185@sigill.intra.peff.net>
From:   Nickolai Belakovski <nbelakovski@gmail.com>
Date:   Wed, 13 Mar 2019 23:10:06 -0700
Message-ID: <CAC05385woS0XUsDHRBHrZkjzFU9q9+JOJ3BvE8pRh48794-iBA@mail.gmail.com>
Subject: Re: [PATCH v8 0/3]
To:     Jeff King <peff@peff.net>
Cc:     Git List <git@vger.kernel.org>,
        =?UTF-8?Q?Rafael_Ascens=C3=A3o?= <rafa.almas@gmail.com>,
        Junio C Hamano <gitster@pobox.com>,
        =?UTF-8?B?w4Z2YXIgQXJuZmrDtnLDsCBCamFybWFzb24=?= <avarab@gmail.com>
Content-Type: text/plain; charset="UTF-8"
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

>
> Patch 1 looks good to me. Given that we're on v8 and most of the other
> comments are for patches 2 and 3, I think we might consider graduating
> it separately if the other two are not ready soon. It's independently
> useful, IMHO.

Patch 2 was my main motivation, so it would be nice to get it in
together with 1 :)
Patch 3, like I said in the thread on that one I don't have strong
feeling about it. It was an attempt to provide a connection between
the new cyan output and its intent, as opposed to having the user
guess, but I think anyone who's using a worktree will figure it out
sooner or later, and anyone not using a worktree will be unaffected.

I'm willing to keep going with comments on patch 2. I can't imagine it
would take many more revisions as it's much more straightforward than
patch 1, it's basically just modifying one line of branch.c. If we
decide to drop patch 3 fine with me.

I'll send in v9 with the latest changes for both 2 and 3 sometime
tomorrow unless I hear otherwise.

Thanks for the feedback.
