Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.2 (2018-09-13) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-3.6 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,RCVD_IN_DNSWL_HI,
	SPF_HELO_NONE,SPF_NONE shortcircuit=no autolearn=ham
	autolearn_force=no version=3.4.2
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id E77C51F461
	for <e@80x24.org>; Sun, 23 Jun 2019 08:28:55 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726378AbfFWI2y (ORCPT <rfc822;e@80x24.org>);
        Sun, 23 Jun 2019 04:28:54 -0400
Received: from mail-io1-f67.google.com ([209.85.166.67]:42395 "EHLO
        mail-io1-f67.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726086AbfFWI2y (ORCPT <rfc822;git@vger.kernel.org>);
        Sun, 23 Jun 2019 04:28:54 -0400
Received: by mail-io1-f67.google.com with SMTP id u19so1003419ior.9
        for <git@vger.kernel.org>; Sun, 23 Jun 2019 01:28:53 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc:content-transfer-encoding;
        bh=SuCfvMCZnX0Wog09co181aLE2OS+12UFlC+Ueo1+q+Y=;
        b=F7sSZe7Rj1sZ4R7tVCJ+LOKHHhQB8wP/Hw3yW4mz5KyNYjJhrb2DPhOiEnh6WiHygw
         L9ykqFOIol6gZ0AABG6uibMbvDsie+PE3zHIyVhWWSesVF6jaMxxitvqnPZPfl01TAOG
         Yg9pwz/6GdqIKdTvihgFQIzx8wDGvQhTCd4bkroOrhw7quQm3n/BUlEJWlxSBO7k0hue
         D4ZoaAHzvwqgA0UZPxpaq3Vo1ijiWkZ8lWcUGoia8O9NQnITQp1AIqmfn+S2WVkxUQ/6
         p5z7QAFpeKZ/1q66MetsLreLe4eyQ/MfOxKZ+x9dZT+4Vwlim9NuorwHy3rSAa6J1QCz
         2JsA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc:content-transfer-encoding;
        bh=SuCfvMCZnX0Wog09co181aLE2OS+12UFlC+Ueo1+q+Y=;
        b=ni97wSUIueS/Z1PeGE6iM/YtIX13KeU0pkRY1kAd/nBLrDXl1n7JgIA7cgqiv4lmIK
         T7PbJLY++BIyCs/121OI+/NumZksXpJb9O/e75XEGnz+9b2hzIkNtYJ8agG7Tqh85ybr
         uers5pT7uBhmazVPrj3JwfYM3GodnOMtsp84CEBT7oq8kVOm2jb8d7AaaSTd2GyDSWVh
         7EPtWJFslU5ocJHTk5AmT9BnkSAzBBwXykgz0DvMIia/uNhoIGOKGgGt4z8Gxg7aNY4l
         0yuCjTUhsN6ZcmJEy+8qLuR56A11y0kP7Yj3LlML0CXNdeLC5t7f03ve+fet/Ho7A3lF
         UAmA==
X-Gm-Message-State: APjAAAUzUGYl8aUGuLdOdumq4f70IkUx31QUQKAqN806dLGQrvh0gFG7
        VFB+EyKDSgLEbz2DeU7lZv/zz2lYzJlr88r4VTo=
X-Google-Smtp-Source: APXvYqy1aMAXkfvDmgM3qamONovqZTBSsMbqCvtUlNWcOWv2HnzKLP0sMFZKzLC7h1m+r4qjP+LfTi6U+L28INOWdAk=
X-Received: by 2002:a5d:9a04:: with SMTP id s4mr55601722iol.19.1561278532806;
 Sun, 23 Jun 2019 01:28:52 -0700 (PDT)
MIME-Version: 1.0
References: <20190622093655.80092-2-dimitriy.ryazantcev@gmail.com>
 <65cf1cfd-bb5f-dba0-17d6-7fee0ed1f51f@kdbg.org> <20190623010311.GC965782@genre.crustytoothpaste.net>
In-Reply-To: <20190623010311.GC965782@genre.crustytoothpaste.net>
From:   Dimitriy <dimitriy.ryazantcev@gmail.com>
Date:   Sun, 23 Jun 2019 11:28:41 +0300
Message-ID: <CAPUT4mSHK8bD-TGf9QOM2O2ChxTvwScCvmmQH37pedGDVR2w-g@mail.gmail.com>
Subject: Re: [PATCH v3] l10n: localizable upload progress messages
To:     "brian m. carlson" <sandals@crustytoothpaste.net>,
        Johannes Sixt <j6t@kdbg.org>,
        Dimitriy Ryazantcev <dimitriy.ryazantcev@gmail.com>
Cc:     Git Mailing List <git@vger.kernel.org>,
        Junio C Hamano <gitster@pobox.com>,
        =?UTF-8?B?Tmd1eeG7hW4gVGjDoWkgTmfhu41jIER1eQ==?= 
        <pclouds@gmail.com>, Jeff King <peff@peff.net>,
        =?UTF-8?B?w4Z2YXIgQXJuZmrDtnLDsCBCamFybWFzb24=?= <avarab@gmail.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

brian m. carlson <sandals@crustytoothpaste.net> wrote:
>
> On 2019-06-22 at 21:42:33, Johannes Sixt wrote:
> > Am 22.06.19 um 11:36 schrieb Dimitriy Ryazantcev:
> > > diff --git a/strbuf.c b/strbuf.c
> > > index 0e18b259ce..0a3ebc3749 100644
> > > --- a/strbuf.c
> > > +++ b/strbuf.c
> > > @@ -814,20 +814,28 @@ void strbuf_addstr_urlencode(struct strbuf *sb,=
 const char *s,
> > >  void strbuf_humanise_bytes(struct strbuf *buf, off_t bytes)
> > >  {
> > >     if (bytes > 1 << 30) {
> > > -           strbuf_addf(buf, "%u.%2.2u GiB",
> > > +           strbuf_addf(buf, "%u.%2.2u ",
> > >                         (unsigned)(bytes >> 30),
> > >                         (unsigned)(bytes & ((1 << 30) - 1)) / 1073741=
9);
> > > +           /* TRANSLATORS: ISO/IEC 80000-13:2008, clause 4: gibi */
> > > +           strbuf_addstr(buf, _("Gi"));
> > >     } else if (bytes > 1 << 20) {
> > >             unsigned x =3D bytes + 5243;  /* for rounding */
> > > -           strbuf_addf(buf, "%u.%2.2u MiB",
> > > +           strbuf_addf(buf, "%u.%2.2u ",
> > >                         x >> 20, ((x & ((1 << 20) - 1)) * 100) >> 20)=
;
> > > +           /* TRANSLATORS: ISO/IEC 80000-13:2008, clause 4: mebi */
> > > +           strbuf_addstr(buf, _("Mi"));
> > >     } else if (bytes > 1 << 10) {
> > >             unsigned x =3D bytes + 5;  /* for rounding */
> > > -           strbuf_addf(buf, "%u.%2.2u KiB",
> > > +           strbuf_addf(buf, "%u.%2.2u ",
> > >                         x >> 10, ((x & ((1 << 10) - 1)) * 100) >> 10)=
;
> > > +           /* TRANSLATORS: ISO/IEC 80000-13:2008, clause 4: kibi */
> > > +           strbuf_addstr(buf, _("Ki"));
> > >     } else {
> > > -           strbuf_addf(buf, "%u bytes", (unsigned)bytes);
> > > +           strbuf_addf(buf, "%u ", (unsigned)bytes);
> > >     }
> > > +   /* TRANSLATORS: ISO/IEC 80000-13:2008, subclause 13-9.c: byte */
> > > +   strbuf_addstr(buf, _("B"));
> > >  }
> > >
> > >  void strbuf_add_absolute_path(struct strbuf *sb, const char *path)
> > >
> >
> > All of the prefixes are in ISO/IEC, i.e., standardized. Why do they hav=
e
> > to be translated?
> >
> > Isn't the way of presentation of magnitudes with a unit also
> > standardized, and should not need to be translated?
>
> In my view, the translation is less important for the prefixes and more
> important for the unit: at least French prefers the term "octet" over
> "byte"[0], so instead of writing "MB", you'd write "Mo".

Localization according to local rules is important for every unit part.
There is a Russian adoption of IEC 80000-13:2008 called
GOST R IEC 80000-13-2016[0].
And in this document there is national translations for these units\prefixe=
s.
So 'KiB' should become '=D0=9A=D0=B8=D0=91' according to this national stan=
dard.
Same story with Ukrainian adoption called DSTU IEC 80000-13:2016[1]:
'KiB' -> '=D0=9A=D1=96=D0=91'.
Also according to ISO website seems that there is French version of
IEC 80000-13:2008 exist. Not sure about French translation through.

> In general, I think it's better to keep the prefixes and units together,
> since trying to translate a single letter runs the risk of collisions
> with other places in the code. It's likely to be easier for translators
> as well.

I agree with you in this part.
I searched for similar code in other codebases and found such in KDE
codebase[2]. I'll update patch if there is no objections.

> [0] Technically, as in English, they have different meanings, but I've
> always seen French units written with "o" for "octet", not "B" for
> "byte".

To solve this ambiguity IEC standard in subclause 13-9.=D1=81 says
that 'byte' implies 'octet' (8-bit byte).

> --
> brian m. carlson: Houston, Texas, US
> OpenPGP: https://keybase.io/bk2204

[0] http://docs.cntd.ru/document/1200143231
[1] http://online.budstandart.com/ua/catalog/doc-page.html?id_doc=3D69033
[1] https://cgit.kde.org/kcoreaddons.git/tree/src/lib/util/kformatprivate.c=
pp#n254

--=20
Sincerely,
Dimitriy Ryazantcev
