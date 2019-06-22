Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.2 (2018-09-13) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-4.0 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,RCVD_IN_DNSWL_HI,
	SPF_HELO_NONE,SPF_NONE shortcircuit=no autolearn=ham
	autolearn_force=no version=3.4.2
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 5514F1F4B6
	for <e@80x24.org>; Sat, 22 Jun 2019 03:10:50 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726070AbfFVDKt (ORCPT <rfc822;e@80x24.org>);
        Fri, 21 Jun 2019 23:10:49 -0400
Received: from mail-io1-f68.google.com ([209.85.166.68]:45562 "EHLO
        mail-io1-f68.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726049AbfFVDKs (ORCPT <rfc822;git@vger.kernel.org>);
        Fri, 21 Jun 2019 23:10:48 -0400
Received: by mail-io1-f68.google.com with SMTP id e3so5692142ioc.12
        for <git@vger.kernel.org>; Fri, 21 Jun 2019 20:10:48 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=sGkj0Rm4T1mAyHtc1pBHXwBGViO7OI2DxBV6aR+bLI8=;
        b=CFz1V1ShDQM+6SwMOELH+1z5dMojdkBebP3NpMENcNWl33ptgBoOMVO46xE4UfV3MN
         5Pu8SiK91uIvdUQJNtzm16IMKUke6ZwRp3SonjimAi/JRvL0yDLqlLO2mp+tMbsoixDK
         6iunI2ojw4zXD3vKlRjU07MWfhhsBWn77LZ+rlYn+TXNy5mGqqg3Qi8vTrthWJDy4KxR
         yn7Iv2BSGPvOtUApcUY15qlx0+tjw6ewmCSQZRnP3UBZSnWwC4d4TXKLnqW6y150uLtV
         9RYIz1cWwynex8+nmkpS8h392puVvsxuqOqi6gIonQIznJX5qMYhi/nEKdUJ+PwuNItd
         rnlg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=sGkj0Rm4T1mAyHtc1pBHXwBGViO7OI2DxBV6aR+bLI8=;
        b=qSqqCW2h6jIvKUH71m1Uf1zI4vsIfUiNCYYeXAM8bXKBkdOUEr8p2cD0YaW0BtrRpm
         FYlLSHDoj5EKOCtGRF7EZ/rgH8PKx1pOhl+8ZLJ6BrS1xKooO+nwiUKW1PD16P/3zF64
         lf+fxmQxExJ/e729TGctv3veXyonF/jOULUIwy2slDpg0L8l+Twew9BYWT0/+WViq7ec
         kgNW8GvE66ce3gMyLTMV6VG+RuSDaQo/GV7r4tGETgjSPJOyoHQn1RnubKMbFiaRA9OV
         W7Iakn0v+baA4Div21ansSq4OyMKI/0C1bgfXVUaE5Ay18bgUOZqr6mV7azr0V9Ef5iM
         9B3g==
X-Gm-Message-State: APjAAAVM1byhsL+G/mn/9u2fIxmi0kns36KMJLcXlK/Ob2wr8lBBfGpQ
        6oMkB/F1rI+oqgCDImRoaJPn/umKpDP69LRMNstDcQ==
X-Google-Smtp-Source: APXvYqzAlBWFkuVabUEOt81KWvW4nKokZbpVDw8VGK+lRNnfNOE0OQQmr/NvND+CoSiPslYzheehAaKYNluHp8a/nLU=
X-Received: by 2002:a5d:8890:: with SMTP id d16mr9358238ioo.274.1561173047882;
 Fri, 21 Jun 2019 20:10:47 -0700 (PDT)
MIME-Version: 1.0
References: <20190621185051.77354-1-dimitriy.ryazantcev@gmail.com> <xmqq8stukarw.fsf@gitster-ct.c.googlers.com>
In-Reply-To: <xmqq8stukarw.fsf@gitster-ct.c.googlers.com>
From:   Duy Nguyen <pclouds@gmail.com>
Date:   Sat, 22 Jun 2019 10:10:21 +0700
Message-ID: <CACsJy8BF0RHgrw9A_6zj8hQk7s15LvCZDz_P7rxgRvGfRhLJZg@mail.gmail.com>
Subject: Re: [PATCH] l10n: localizable upload progress messages
To:     Junio C Hamano <gitster@pobox.com>
Cc:     Dimitriy Ryazantcev <dimitriy.ryazantcev@gmail.com>,
        Git Mailing List <git@vger.kernel.org>,
        Jeff King <peff@peff.net>,
        =?UTF-8?B?w4Z2YXIgQXJuZmrDtnLDsCBCamFybWFzb24=?= <avarab@gmail.com>
Content-Type: text/plain; charset="UTF-8"
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

On Sat, Jun 22, 2019 at 2:18 AM Junio C Hamano <gitster@pobox.com> wrote:
>
> Dimitriy Ryazantcev <dimitriy.ryazantcev@gmail.com> writes:
>
> > Signed-off-by: Dimitriy Ryazantcev <dimitriy.ryazantcev@gmail.com>
> > ---
> >  progress.c | 3 ++-
> >  strbuf.c   | 8 ++++----
> >  2 files changed, 6 insertions(+), 5 deletions(-)
> >
> > diff --git a/progress.c b/progress.c
> > index a2e8cf64a8..3d47c06495 100644
> > --- a/progress.c
> > +++ b/progress.c
> > @@ -151,7 +151,8 @@ static void throughput_string(struct strbuf *buf, uint64_t total,
> >       strbuf_humanise_bytes(buf, total);
> >       strbuf_addstr(buf, " | ");
> >       strbuf_humanise_bytes(buf, rate * 1024);
> > -     strbuf_addstr(buf, "/s");
> > +     /* TRANSLATORS: per second */
> > +     strbuf_addstr(buf, _("/s"));
> >  }
>
> Hpmh, if it is OK to assume that in all human languages it is OK to
> express the reate as <number> followed by translated "per second",
> without allowing the order from getting changed, then ...

Probably not (but I don't know any language that is not ok with this).
I would just add strbuf_humanise_rate() that prints "GiB/s",
"MiB/s"... Then we probably should print "bytes/second". This will
print "bytes/s" which looks just weird.

> >       if (bytes > 1 << 30) {
> > -             strbuf_addf(buf, "%u.%2.2u GiB",
> > +             strbuf_addf(buf, _("%u.%2.2u GiB"),
> >                           (unsigned)(bytes >> 30),
> >                           (unsigned)(bytes & ((1 << 30) - 1)) / 10737419);
>
> wouldn't it make more sense to split GiB, MiB, KiB and "bytes" units
> out of these messages, and ask only these unit names, without the
> %u.%2.2u number formats, to get translated by the localization team?

That assumes all languages will print the unit after the number. I
guess that is ok and it helps share code if we add
strbuf_humanise_rate() above because only the unit part changes.
-- 
Duy
