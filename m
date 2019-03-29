Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.2 (2018-09-13) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-4.0 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,RCVD_IN_DNSWL_HI
	shortcircuit=no autolearn=ham autolearn_force=no version=3.4.2
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 19B9120248
	for <e@80x24.org>; Fri, 29 Mar 2019 22:34:23 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1730501AbfC2WeW (ORCPT <rfc822;e@80x24.org>);
        Fri, 29 Mar 2019 18:34:22 -0400
Received: from mail-io1-f50.google.com ([209.85.166.50]:39224 "EHLO
        mail-io1-f50.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1730240AbfC2WeV (ORCPT <rfc822;git@vger.kernel.org>);
        Fri, 29 Mar 2019 18:34:21 -0400
Received: by mail-io1-f50.google.com with SMTP id e13so3046047ioq.6
        for <git@vger.kernel.org>; Fri, 29 Mar 2019 15:34:21 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc:content-transfer-encoding;
        bh=tFw7XGgA2lTXhSxfoQPLWmW/KlboVMdD7wzqvg1mLLY=;
        b=OrVWTjNgMh6wDaxv7omrFwEHl2m147gkXEzi9VVzjlEiLZ39SN1LVhCseqn2kXyxbR
         qTL8COXAJPlTD7edXTxlnFKhxmCJzhXKfHxELN+7uiZNWqIC6SgvqX86dEoTlyIUHf3I
         aiPfte+0YVm+PwFJBVumF4cSKoRBtXqd0IAfYVhNTX7LcwVaJf96yP/ku+PgBAXfhYS7
         NzrmJ7ZxGs4dm8OgKAUcHLxnnGjF9PmY7V4qD4LTObdlU/tnYBSjh5farRgYACL9unM8
         N5PtTZbsuN+MQgGznCvSiWnGVfiY+4/gX8p2QK3pksjkh/cRu7xb4mMm6Osj8lbdbUmO
         HdrA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc:content-transfer-encoding;
        bh=tFw7XGgA2lTXhSxfoQPLWmW/KlboVMdD7wzqvg1mLLY=;
        b=SleYQd+kowVxmMOdBrpqV9ANlVWXvGAWU9ARqMXEmI5No+oexSAtm6W9rjpUOyOGuu
         gnP3qQQk9pORtPvGutbrcf0gsGwmNRlWty6S4lVCfMqbtjPGJS4jlBsyRx7Yb93NWYhT
         lYpjXFXQBXP2599KV0QGRk2Q/C6QfS0Om0MOlcnx48hyrnORn1IoNtHUlIXRFivrEnN6
         G1BJJ+h2WFnA+qF9EOCC7zQxmkwdrfMXVqFQGAnN2RTrNbuD36KJsWZwnr6QMifHTwUj
         8epqZsgSYznBVgj/7Lg2NI1hIYwUr+AehJEXmXvFP1RjMUKmwTlCqmXXQ+Jwx+bn+gm8
         FwuQ==
X-Gm-Message-State: APjAAAWkHRpAdjhy6spogjnvzPbX2Tm4yM+2+4qJBJO4ht+PPWe/7MUg
        H20FZ49dw+GKR6Ryhc6AqTdVcs+Q0xU3zTWf3ETT4Ot9
X-Google-Smtp-Source: APXvYqw9Ha8afw8nudwBeWUChTp+EaZuKV32QONyu45StlxGE2F58V0bKo7d7hIZ+0zqXNVtJf4Y9qW1ejoQDL+82xo=
X-Received: by 2002:a6b:b909:: with SMTP id j9mr7911045iof.184.1553898860768;
 Fri, 29 Mar 2019 15:34:20 -0700 (PDT)
MIME-Version: 1.0
References: <nycvar.QRO.7.76.6.1903061512330.41@tvgsbejvaqbjf.bet>
In-Reply-To: <nycvar.QRO.7.76.6.1903061512330.41@tvgsbejvaqbjf.bet>
From:   Stefan Beller <stefanbeller@gmail.com>
Date:   Fri, 29 Mar 2019 15:34:09 -0700
Message-ID: <CALbm-EY6RBoj+pEvvL3C30CxN2z+fG47eEFMuObpuJ8r-TO77w@mail.gmail.com>
Subject: Re: "Give me a break"... well, you gave me one
To:     Johannes Schindelin <Johannes.Schindelin@gmx.de>
Cc:     Git Mailing List <git@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Am Mi., 6. M=C3=A4rz 2019 um 06:14 Uhr schrieb Johannes Schindelin
<Johannes.Schindelin@gmx.de>:
>
> Hi Stefan,
>
> just wanted to express my gratitude for your idea to introduce the `break=
`
> command in `git rebase -i`'s todo list. I use it *all* the time now.

You're welcome. As you know I am currently taking a break form #git,
and it turns out I had my email filters configured wrongly, which means
I just realized there is a bunch of emails where I am cc'd.

I do not use the break command myself yet, as I am stuck with
an older git version on Mac for now (Macs and Git don't seem to
go well together, if only there was an active Apple upstream person...).

Cheers,
Stefan
