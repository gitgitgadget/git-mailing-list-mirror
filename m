Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.1 (2015-04-28) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-4.1 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,RCVD_IN_DNSWL_HI
	shortcircuit=no autolearn=ham autolearn_force=no version=3.4.1
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 80A931F453
	for <e@80x24.org>; Sat, 10 Nov 2018 05:53:09 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728766AbeKJPgx (ORCPT <rfc822;e@80x24.org>);
        Sat, 10 Nov 2018 10:36:53 -0500
Received: from mail-it1-f195.google.com ([209.85.166.195]:37141 "EHLO
        mail-it1-f195.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1728596AbeKJPgx (ORCPT <rfc822;git@vger.kernel.org>);
        Sat, 10 Nov 2018 10:36:53 -0500
Received: by mail-it1-f195.google.com with SMTP id j79-v6so6562069itb.2
        for <git@vger.kernel.org>; Fri, 09 Nov 2018 21:53:07 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=t6Xt52ZbI8Xg6mL0GDnOiT6Hd0ECnNbtJMdfHME9xVs=;
        b=q26dIHylDkmMfcwrwwevAW84U77pBCoqMmBNLRwE1kYJYUw3GQ/LHx+4T9tR1+3XnH
         tDyZpcfIzWu9d769a+QHuxVXVasPdUgdScK0aBv31QuY7Ox889cwuDIr1lke4U6Eg2TP
         PJ6uHcNCxE4irsHJJcibALQvzuWvCLeEib363T4rrkmbaS6NkZYJKEK5wOByHtwlOuS2
         MFNpioYHGiauo5pw0u5qk9SAxn2rzM8QdaDe/GIcwmx538n/5sxTPDl2YTeUajH4ulDe
         7UceUeMtgVLN+QrO9P7YV5ta4ZLXln2kq248VQT+LkCtB7e7FW+h7QV1JVVDk8GgUfY/
         /Fpg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=t6Xt52ZbI8Xg6mL0GDnOiT6Hd0ECnNbtJMdfHME9xVs=;
        b=SAyLaG7lkvnU3ubPY62XW+7UL9bz0US7K6Pr3njjKJMPvvLieFytX2YdGCj6fn7qXT
         KyVPnGYxHyvLVft9ntCU1hO/pRKu3mhQqwbIxy6Hu/ngGT/zc7HPndOS3NLNSmlECJTM
         KdWuL5JjPqWLoILYeYj4f41RdI4m3YtipY5l9xvmz85N7PQoICCOWkUCh577PpgvE5KG
         hFJV3sd/uCbTO51Z3h1+PiEdvLQSAPlWmebAT6SGHwGu/z632BCASZI7kZ3RmiNFwj4r
         vX1vh0d9lj5n/rne7+d2Dqm9OiS2d6JfACeIl3b8uoAet91HFUP7v5SA0t005SEhRMAD
         dc1g==
X-Gm-Message-State: AGRZ1gLYUOMuVWShCTHkQzWSAacEJ/7r/7q2nQXoaSl8LfzYKXpFhNVu
        UvdUqDCJTqxusvTeomSkXm5bcNspFhOFo5AUlgY=
X-Google-Smtp-Source: AJdET5cdHot3yTl/sFry9OXos8CulM+ZE1oq096yoVb+CqIO/iruTODKZTleGd92oANjwR62UC6u9odYIeqLHIk8VJY=
X-Received: by 2002:a24:61c2:: with SMTP id s185-v6mr3185282itc.70.1541825992121;
 Fri, 09 Nov 2018 20:59:52 -0800 (PST)
MIME-Version: 1.0
References: <20181028065157.26727-1-pclouds@gmail.com> <20181105192059.20303-1-pclouds@gmail.com>
 <20181105192059.20303-16-pclouds@gmail.com> <xmqqbm72g9ee.fsf@gitster-ct.c.googlers.com>
In-Reply-To: <xmqqbm72g9ee.fsf@gitster-ct.c.googlers.com>
From:   Duy Nguyen <pclouds@gmail.com>
Date:   Sat, 10 Nov 2018 05:59:25 +0100
Message-ID: <CACsJy8CT43QQRvkHefXnPtYHbAFQVB847bTYyj8Hxyt-csDkBA@mail.gmail.com>
Subject: Re: [PATCH v2 15/16] fsck: reduce word legos to help i18n
To:     Junio C Hamano <gitster@pobox.com>
Cc:     Git Mailing List <git@vger.kernel.org>,
        =?UTF-8?Q?SZEDER_G=C3=A1bor?= <szeder.dev@gmail.com>
Content-Type: text/plain; charset="UTF-8"
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

On Tue, Nov 6, 2018 at 4:41 AM Junio C Hamano <gitster@pobox.com> wrote:
> >  static int fsck_error_func(struct fsck_options *o,
> >       struct object *obj, int type, const char *message)
> >  {
> > -     objreport(obj, (type == FSCK_WARN) ? "warning" : "error", message);
> > -     return (type == FSCK_WARN) ? 0 : 1;
> > +     if (type == FSCK_WARN) {
> > +             fprintf_ln(stderr, "warning in %s %s: %s",
> > +                        printable_type(obj), describe_object(obj), message);
> > +             return 0;
> > +     }
> > +
> > +     fprintf_ln(stderr, "error in %s %s: %s",
> > +                printable_type(obj), describe_object(obj), message);
> > +     return 1;
>
> Make it look more symmetrical like the original, perhaps by
>
>         if (type == FSCK_WARN) {
>                 ...
>                 return 0;
>         } else { /* FSCK_ERROR */
>                 ...
>                 return 1;
>         }
>
> Actually, wouldn't it be clearer to see what is going on, if we did
> it like this instead?
>
>         const char *fmt = (type == FSCK_WARN)
>                 ? N_("warning in %s %s: %s")
>                 : N_("error in %s %s: %s");
>         fprintf_ln(stderr, _(fmt),
>                    printable_type(obj), describe_object(obj), message);
>         return (type == FSCK_WARN) ? 0 : 1;
>
> It would show that in either case we show these three things in the
> message.  I dunno.

Specifying "type == FSCK_WARN" twice triggers me (what if we add a
third fsck type?) so I just turn this to a switch/case block instead
(and get to know the third fsck type FSCK_IGNORE).
-- 
Duy
