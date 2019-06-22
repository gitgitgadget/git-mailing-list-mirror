Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.2 (2018-09-13) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-3.5 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,RCVD_IN_DNSWL_HI,
	SPF_HELO_NONE,SPF_NONE shortcircuit=no autolearn=ham
	autolearn_force=no version=3.4.2
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 028DE1F461
	for <e@80x24.org>; Sat, 22 Jun 2019 16:40:11 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726304AbfFVQkJ (ORCPT <rfc822;e@80x24.org>);
        Sat, 22 Jun 2019 12:40:09 -0400
Received: from mail-io1-f66.google.com ([209.85.166.66]:45560 "EHLO
        mail-io1-f66.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726276AbfFVQkJ (ORCPT <rfc822;git@vger.kernel.org>);
        Sat, 22 Jun 2019 12:40:09 -0400
Received: by mail-io1-f66.google.com with SMTP id e3so97680ioc.12
        for <git@vger.kernel.org>; Sat, 22 Jun 2019 09:40:08 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=tiXXFM2rXGyZo5T8yAIdh5geGnAbZtL20RGZBjoVKrs=;
        b=I/k/Cd+BMZHDFqlixoTWxuL7FdOchrAh60TB2KrQfqWfyfXOD/umeIOXSeg1eX0gHn
         RiAytIki1U2FVZtkdTiN/wn+jV4T/4YdMdtxfJ2ld+QoIhwzStq4g063cW/MAwPcr4rk
         1XsLKE30HhGyHCPeXGj3ofzMzl2qiehJePDz3SxsMDOXomolOii7vhegFIRsFfBzUjAe
         fqIrPkKkewrhrZ4djhtxmqRbUBiaAMJ9k+uunr8ionqdkDIl1Ooy3e/dekEpD7QIund0
         Z7LefOGkeM6sQn8MKniPp2zULDwnYVpha289u3du7OZN6G05STxQJtET1R+HNsbAwDWJ
         0LHQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=tiXXFM2rXGyZo5T8yAIdh5geGnAbZtL20RGZBjoVKrs=;
        b=PuH7gVjgQ3M1ODT9gWsTkXwUws4orcf/+TbPv6e2mwyHJTPFTf98mPVDvQAqrul8uE
         s72OI1ODBQYk1MNB8mBrULszFuRdpbKUac/P99SGTP4YWsjcTMU0BzbY7ZWmwxjDTHk6
         GvcGWUsy5TeNRAmwMn9d48FhddMyeDIj6//WecDv1cVUDEXzd+aiKnzC/2WUdE5cdVMu
         nsyqSUuf9TkTPGikKJZ1Y/1OgYoQc/OMq86+uea2u5W/+nbbAHvwDlwhB8xa/xKnfQDq
         Hg+F1bttk4scbHzRDcYIQIOoPYW+6fhWl4CIaenfhBQFmfBp2JKm5gUrL5D3gPYSm0pe
         ldOg==
X-Gm-Message-State: APjAAAW+W/OAXIYY0j/f4LRSxo0evnT7GOQOSfinm5S5XGFaxuL/+dL/
        YX3GZgsPBH8ZEixyqF84iMqEtBHCDvdeef4Op+E=
X-Google-Smtp-Source: APXvYqzp1hhsnLumPjlnxLJ4j/N9qseK73JPYCDEMFqolKbtK0pt8qlpyA05kYC2EErvBbqBbnYpn7odLVHFeyVL8SU=
X-Received: by 2002:a5d:915a:: with SMTP id y26mr15033721ioq.207.1561221608409;
 Sat, 22 Jun 2019 09:40:08 -0700 (PDT)
MIME-Version: 1.0
References: <20190622093655.80092-2-dimitriy.ryazantcev@gmail.com> <CACsJy8CPChOGSZVfXd6ioaXHWg_aFxNMzr2J=Zdm2RZXkO++Ew@mail.gmail.com>
In-Reply-To: <CACsJy8CPChOGSZVfXd6ioaXHWg_aFxNMzr2J=Zdm2RZXkO++Ew@mail.gmail.com>
From:   Dimitriy <dimitriy.ryazantcev@gmail.com>
Date:   Sat, 22 Jun 2019 19:39:57 +0300
Message-ID: <CAPUT4mQnsThA=ZxZD8K+J+u6tbN5PggPomuymEUO=u2GT88aUA@mail.gmail.com>
Subject: Re: [PATCH v3] l10n: localizable upload progress messages
To:     Duy Nguyen <pclouds@gmail.com>
Cc:     Git Mailing List <git@vger.kernel.org>,
        Junio C Hamano <gitster@pobox.com>,
        Jeff King <peff@peff.net>,
        =?UTF-8?B?w4Z2YXIgQXJuZmrDtnLDsCBCamFybWFzb24=?= <avarab@gmail.com>
Content-Type: text/plain; charset="UTF-8"
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Duy Nguyen <pclouds@gmail.com> wrote:
>
> On Sat, Jun 22, 2019 at 4:37 PM Dimitriy Ryazantcev
> <dimitriy.ryazantcev@gmail.com> wrote:
> > diff --git a/strbuf.c b/strbuf.c
> > index 0e18b259ce..0a3ebc3749 100644
> > --- a/strbuf.c
> > +++ b/strbuf.c
> > @@ -814,20 +814,28 @@ void strbuf_addstr_urlencode(struct strbuf *sb, const char *s,
> >  void strbuf_humanise_bytes(struct strbuf *buf, off_t bytes)
> >  {
> >         if (bytes > 1 << 30) {
> > -               strbuf_addf(buf, "%u.%2.2u GiB",
> > +               strbuf_addf(buf, "%u.%2.2u ",
> >                             (unsigned)(bytes >> 30),
> >                             (unsigned)(bytes & ((1 << 30) - 1)) / 10737419);
> > +               /* TRANSLATORS: ISO/IEC 80000-13:2008, clause 4: gibi */
> > +               strbuf_addstr(buf, _("Gi"));
>
> It may be ISO standard, but GiB to me looks much easier to understand.
> What's the reason for changing GiB to Gi btw?

I just moved 'B' out of else block so it will be prepended with
'Gi'/'Mi'/'Ki' when needed.
Note: I changed 'bytes' to just 'B' unit.

>
> >         } else if (bytes > 1 << 20) {
> >                 unsigned x = bytes + 5243;  /* for rounding */
> > -               strbuf_addf(buf, "%u.%2.2u MiB",
> > +               strbuf_addf(buf, "%u.%2.2u ",
> >                             x >> 20, ((x & ((1 << 20) - 1)) * 100) >> 20);
> > +               /* TRANSLATORS: ISO/IEC 80000-13:2008, clause 4: mebi */
> > +               strbuf_addstr(buf, _("Mi"));
> >         } else if (bytes > 1 << 10) {
> >                 unsigned x = bytes + 5;  /* for rounding */
> > -               strbuf_addf(buf, "%u.%2.2u KiB",
> > +               strbuf_addf(buf, "%u.%2.2u ",
> >                             x >> 10, ((x & ((1 << 10) - 1)) * 100) >> 10);
> > +               /* TRANSLATORS: ISO/IEC 80000-13:2008, clause 4: kibi */
> > +               strbuf_addstr(buf, _("Ki"));
> >         } else {
> > -               strbuf_addf(buf, "%u bytes", (unsigned)bytes);
> > +               strbuf_addf(buf, "%u ", (unsigned)bytes);
> >         }
> > +       /* TRANSLATORS: ISO/IEC 80000-13:2008, subclause 13-9.c: byte */
> > +       strbuf_addstr(buf, _("B"));
> >  }
> >
> >  void strbuf_add_absolute_path(struct strbuf *sb, const char *path)
> > --
> > 2.22.0
> >
>
>
> --
> Duy



-- 
Sincerely,
Dimitriy Ryazantcev
