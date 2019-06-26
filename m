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
	by dcvr.yhbt.net (Postfix) with ESMTP id E0C991F461
	for <e@80x24.org>; Wed, 26 Jun 2019 08:59:19 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726664AbfFZI7T (ORCPT <rfc822;e@80x24.org>);
        Wed, 26 Jun 2019 04:59:19 -0400
Received: from mail-io1-f67.google.com ([209.85.166.67]:45241 "EHLO
        mail-io1-f67.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726387AbfFZI7S (ORCPT <rfc822;git@vger.kernel.org>);
        Wed, 26 Jun 2019 04:59:18 -0400
Received: by mail-io1-f67.google.com with SMTP id e3so3259708ioc.12
        for <git@vger.kernel.org>; Wed, 26 Jun 2019 01:59:18 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=JFSqbiVL8vCt2GW21oCeN36ann6qAY6GqaSy1K7RUsg=;
        b=uIuVGI/762ABGRycUUE3r5VW4MWPulVbITG3z7kyIvS5NtzQQuk1YkmZ4TNvtknwtD
         1Hv+kEGYi+d8jfq/SvjDocppye9vbBkSy0c3sEqv06B7V7y/5gyE61dzWFjIAYXslT05
         QegaE1Z8caE8dNbiQ4Xq0EZCZDWzxCAvASr3CQzgkqy1Xy2+ylUqwHiVhy7a/D6GPHRE
         Z3qm72Fug7BgsGjx5C5Txfb3Mu3ShxSJDow2VpZbpYm/WiKT9ARratxwRbaDR47cNZeK
         TGvxrh0HVBt1AYazeuobMMKHCnwc20KErTvexW98SeAULAIFXRyCv7FLtsR6K66Vqc+u
         Di8Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=JFSqbiVL8vCt2GW21oCeN36ann6qAY6GqaSy1K7RUsg=;
        b=d1BMS7ktbAINjknPUFZopfcLjOEC1zhcgZdyMbz7eQcu3rfPBl9ig4u5Imxto6l0J+
         eDDzTF/ue+2T1o9l4lHhxkyW024oiK6QBCSuKM4KehlG15dm+jyehUl1OWsQTv0diVwq
         OuJNXAblDIt8AW8/+7OTkqzqU5yRD+BpYu6sT2cpFpZvtH13vfmQrwIj/Xv+wSvuxPc1
         yo37uG37tqUgtclKuwdyuNzZr8XsTl0FCSQEhEgcoAhrRvQhfnDxWH7cY1cu5iUo/v2d
         6DtdKWJGeSIfnP/KBklkDcftF5avIQcYqRrt7uXoFF9pK5KLW1i+wjCcw/J5EPptgcZW
         IOVw==
X-Gm-Message-State: APjAAAVd7eOficUaS284v5GtknV8GnD/0TnYv1KCr2JKOP+1DP6Va5Wl
        aiNjJFXiiZgQCai0TOyI3Tnj0KlYunL/ZLzSGhTUvdejGc0=
X-Google-Smtp-Source: APXvYqxqRm+XKLB8fl5+kBI52izpAwRoUH0MHGU53upMly+kt8rbmkX4MMZ4XMgs6ccHD4xvDoF0jQLtC4UM+1GQAmA=
X-Received: by 2002:a02:9567:: with SMTP id y94mr3750467jah.28.1561539557801;
 Wed, 26 Jun 2019 01:59:17 -0700 (PDT)
MIME-Version: 1.0
References: <20190625062540.88973-2-dimitriy.ryazantcev@gmail.com> <xmqqzhm5e8p9.fsf@gitster-ct.c.googlers.com>
In-Reply-To: <xmqqzhm5e8p9.fsf@gitster-ct.c.googlers.com>
From:   Dimitriy <dimitriy.ryazantcev@gmail.com>
Date:   Wed, 26 Jun 2019 11:59:06 +0300
Message-ID: <CAPUT4mR7B1nS8x=S0UW6PQmw0XjjxvJ8nxsXz2n77fodBPaurw@mail.gmail.com>
Subject: Re: [PATCH v5] l10n: localizable upload progress messages
To:     Junio C Hamano <gitster@pobox.com>
Cc:     Git Mailing List <git@vger.kernel.org>,
        =?UTF-8?B?Tmd1eeG7hW4gVGjDoWkgTmfhu41jIER1eQ==?= 
        <pclouds@gmail.com>, Jeff King <peff@peff.net>,
        =?UTF-8?B?w4Z2YXIgQXJuZmrDtnLDsCBCamFybWFzb24=?= <avarab@gmail.com>
Content-Type: text/plain; charset="UTF-8"
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Junio C Hamano <gitster@pobox.com> writes:
>
> Dimitriy Ryazantcev <dimitriy.ryazantcev@gmail.com> writes:
>
> > Currenly the data rate in throughput_string(...) method is
> > output by simple strbuf_humanise_bytes(...) call and '/s' append.
> > But for proper translation of such string the translator needs
> > full context.
> >
> > Add strbuf_humanise_rate(...) method to properly print out
> > localizable version of data rate ('3.5 MiB/s' etc) with full context.
>
> Hmph, so idea is that appending translation of "/s" to translation
> of "1.4MiB" may not be a good enough translation of "1.4MiB/s"?
>
> That does sounds like a good idea, but looking at the heavy
> duplication of implementation, I would have to say "Yuck" to it.
>
> I wonder if an approach like the following illustration would work
> better?  I am not sure how well Q_() and N_() would interact with
> each other, though.

Good idea!
But unfortunately this will not work properly as xgettext will unable
to extract byte/bytes to one plural msgid in *.pot file.
Seems it can extract plural forms only from Q_ (ngettext() call) and
cannot from _N (gettext_noop() call) in current configuration[0].
Maybe in this case we can try to forward already translated string
to strbuf_humanise():

static void strbuf_humanise(struct strbuf *buf, off_t bytes, struct
human_format *fmt)
{
....
        } else {
                strbuf_addf(buf, fmt->byte, (unsigned)bytes);
....
}

void strbuf_humanise_bytes(struct strbuf *buf, off_t bytes)
{
        struct human_format bytes_fmt = {
                .giga = _("%u.%2.2u GiB"),
                .mega = _("%u.%2.2u MiB"),
                .kilo = _("%u.%2.2u KiB"),
                .byte = Q_("%u byte", "%u bytes", (unsigned)bytes),
        };
        strbuf_humanise(buf, bytes, &bytes_fmt);
}

What do you think?

[0] https://github.com/git/git/blob/master/Makefile#L2498


>
> -- >8 --
>
> struct human_format {
>         const char *giga;
>         const char *mega;
>         const char *kilo;
>         const char *byte;
>         const char *bytes;
> };
>
> static void strbuf_humanise(struct strbuf *buf, off_t bytes, struct human_format *fmt)
> {
>         if (bytes > 1 << 30) {
>                 strbuf_addf(buf, _(fmt->giga),
>                             (unsigned)(bytes >> 30),
>                             (unsigned)(bytes & ((1 << 30) - 1)) / 10737419);
>         } else if (bytes > 1 << 20) {
>                 unsigned x = bytes + 5243;  /* for rounding */
>                 strbuf_addf(buf, _(fmt->mega),
>                             x >> 20, ((x & ((1 << 20) - 1)) * 100) >> 20);
>                 strbuf_addstr(buf, _(""));
>         } else if (bytes > 1 << 10) {
>                 unsigned x = bytes + 5;  /* for rounding */
>                 strbuf_addf(buf, _(fmt->kilo),
>                             x >> 10, ((x & ((1 << 10) - 1)) * 100) >> 10);
>         } else {
>                 strbuf_addf(buf, Q_(fmt->byte, fmt->bytes,
>                                     (unsigned)bytes), (unsigned)bytes);
>         }
> }
>
> void strbuf_humanise_bytes(struct strbuf *buf, off_t bytes)
> {
>         struct human_format bytes_fmt = {
>                 .giga = N_("%u.%2.2u GiB"),
>                 .mega = N_("%u.%2.2u MiB"),
>                 .kilo = N_("%u.%2.2u KiB"),
>                 .byte = N_("%u byte"),
>                 .bytes = N_("%u bytes"),
>         };
>         strbuf_humanise(buf, bytes, &bytes_fmt);
> }
>
> void strbuf_humanise_rate(struct strbuf *buf, off_t bytes)
> {
>         struct human_format rate_fmt = {
>                 .giga = N_("%u.%2.2u GiB/s"),
>                 .mega = N_("%u.%2.2u MiB/s"),
>                 .kilo = N_("%u.%2.2u KiB/s"),
>                 .byte = N_("%u byte/s"),
>                 .bytes = N_("%u bytes/s"),
>         };
>         strbuf_humanise(buf, bytes, &rate_fmt);
> }



--
Sincerely,
Dimitriy Ryazantcev
