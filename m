Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.1 (2015-04-28) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-4.0 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,RCVD_IN_DNSWL_HI
	shortcircuit=no autolearn=ham autolearn_force=no version=3.4.1
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id F27471F597
	for <e@80x24.org>; Thu, 19 Jul 2018 18:49:23 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1732179AbeGSTds (ORCPT <rfc822;e@80x24.org>);
        Thu, 19 Jul 2018 15:33:48 -0400
Received: from mail-it0-f68.google.com ([209.85.214.68]:51544 "EHLO
        mail-it0-f68.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727401AbeGSTds (ORCPT <rfc822;git@vger.kernel.org>);
        Thu, 19 Jul 2018 15:33:48 -0400
Received: by mail-it0-f68.google.com with SMTP id h2-v6so11303370itj.1
        for <git@vger.kernel.org>; Thu, 19 Jul 2018 11:49:22 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=iQbfkZDNe7kVE0zdk3Etba2RjZuxKaV/7p5rT3m92bw=;
        b=E9jdtA9lqRLToKFo9fcBiWyip8oi2xxH3WIw3hwIo0NCYdcVE0OQGUB3XnwBUpWlOA
         ijnwUOVm0sR8L/mEunei8+FED8BRHVcy/VDbVtwFdXb14qFUqi02QfD/wA4ovvXW9Jf0
         kXHF/MOxSEvH90HVpKNIaIN5PDYQSMNRqwHpOW5iUvAmaiZW+wmBBEzaECrYtLDNeuRt
         B3uFMoIvSvz0UdtZvuyyNlNfxW3t34dRumVQSF6M6Hnx0XbVVqSpwGHd4Hd6jYv1qIYL
         oMLAeanRTJ2NriynobTm6l5ckAqFsvy+/OzH/x8bkkvIqEjs1279RRsOZfxcTRDaAB5k
         mXnw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=iQbfkZDNe7kVE0zdk3Etba2RjZuxKaV/7p5rT3m92bw=;
        b=CqdmFW7fiSWSaFyBUgnjcRB1r6YwQjVtSlqV5WMldhettNenqBNDHKYJdZ3aIqydEQ
         7ysGzGtz6HvNHVyMq/0ZEEnmqy+KqfqP9nE85WAXF68OrAXUSsn6GVR1Ue7bxNteXKvA
         1QfLAs24ERLKQl49+JlCziq/G5kKjZt0g7jWpEoiQpAz6AvGLKaIzOt15XIVcnvNpTyS
         LwLURY7sydwHOciXm5JBT8AByyUC6kMDIyoNfEnlCXp8OopVRPK56pnDV4OY5Jxx0Jd5
         ze8c6doROnV5b2yhlxGw2ehqvmZ5xgTE7dBOE110fh1KPPwoGs5vkPpcwGlqH2H2C3zu
         sC4w==
X-Gm-Message-State: AOUpUlH6sU03UWkOHrBHi4NuV8K2FPBSQB/fLeOCm4UysfP9+w/Lps0u
        skYylyyLJSJQWb7qct02qiwmZp8D+4Qca7hBX+s=
X-Google-Smtp-Source: AAOMgpfICmhuc4y++si0b38jIfEFa8bV7+xjj8jLxMgc3YRyN/RY/exoh1MXhvUuHk7m5qhP3DcH4XVhtVIBkaery84=
X-Received: by 2002:a24:610d:: with SMTP id s13-v6mr5379679itc.68.1532026162024;
 Thu, 19 Jul 2018 11:49:22 -0700 (PDT)
MIME-Version: 1.0
References: <20180718161101.19765-1-pclouds@gmail.com> <20180718161101.19765-4-pclouds@gmail.com>
 <xmqqin5bf5fp.fsf@gitster-ct.c.googlers.com>
In-Reply-To: <xmqqin5bf5fp.fsf@gitster-ct.c.googlers.com>
From:   Duy Nguyen <pclouds@gmail.com>
Date:   Thu, 19 Jul 2018 20:48:55 +0200
Message-ID: <CACsJy8BBwy_WBg5fduQvWdWRxSP__T8DofVZzKcPcYwPg2n3LA@mail.gmail.com>
Subject: Re: [PATCH v2 03/23] archive-zip.c: mark more strings for translation
To:     Junio C Hamano <gitster@pobox.com>
Cc:     Git Mailing List <git@vger.kernel.org>,
        Elijah Newren <newren@gmail.com>,
        Derrick Stolee <stolee@gmail.com>
Content-Type: text/plain; charset="UTF-8"
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

On Thu, Jul 19, 2018 at 8:26 PM Junio C Hamano <gitster@pobox.com> wrote:
> > @@ -601,7 +601,7 @@ static void dos_time(timestamp_t *timestamp, int *dos_date, int *dos_time)
> >       struct tm *t;
> >
> >       if (date_overflows(*timestamp))
> > -             die("timestamp too large for this system: %"PRItime,
> > +             die(_("timestamp too large for this system: %"PRItime),
> >                   *timestamp);
>
> I suspect that this won't do the right "cross-platform" thing.  For
> built-in PRItype formats gettext tool knows about, *.po files let
> translators translate original with "%<PRItype>" into localized text
> with the same "%<PRItype>" left, and the runtime does the right
> thing, but for a custom format like PRItime there is no such
> support.
>

It turns out gettext is smart! I got this in git.pot

msgid "timestamp too large for this system: %<PRIuMAX>"

Your second half about the runtime does cause cross platform problems,
luckily PRItime is always defined as PRIuMAX for all platforms, so
gettext should be able to do the right thing.

Besides, PRItime has already been wrapped in _() and Q_() in many
places. If people have not screamed now, they probably don't care
about l10n on that platform.
-- 
Duy
