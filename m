Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.1 (2015-04-28) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-4.0 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,RCVD_IN_DNSWL_HI
	shortcircuit=no autolearn=ham autolearn_force=no version=3.4.1
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 86FE61F453
	for <e@80x24.org>; Wed, 24 Oct 2018 15:00:51 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727033AbeJXX3R (ORCPT <rfc822;e@80x24.org>);
        Wed, 24 Oct 2018 19:29:17 -0400
Received: from mail-io1-f45.google.com ([209.85.166.45]:41592 "EHLO
        mail-io1-f45.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726748AbeJXX3Q (ORCPT <rfc822;git@vger.kernel.org>);
        Wed, 24 Oct 2018 19:29:16 -0400
Received: by mail-io1-f45.google.com with SMTP id q4-v6so3327941iob.8
        for <git@vger.kernel.org>; Wed, 24 Oct 2018 08:00:49 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=SBZJUQHqG3Tk/8UZfoEzwVwtf3XoEK9d6zlNTm6EmZQ=;
        b=PKJnqc9BW2qTUGxj8WPsEG4rYeElOWvt8+gUWNAFP61Nv4vJMglHaYemTgL/dJmp9B
         en64kyoWFCY5sfAmGQ77AJKC1UYURp/EWpcUO2cyMktZO3SS21NKGfX2Q0j8Z6vwGJUV
         b0q7FnhRX4VpLLPC5K6nhBkl0nxG2huxoMoBvA1Vs9hx8UiOVoSb7c/pXE0mAeZmKiY9
         aCSEoTdNZw0jI4WaYRLWB7ILrIbad0cL89wNXYks/M+m30UNXKoKdN+TR6Dx1G+40EcI
         VmCLpQYx0JjgYzZJdWSW/FOB4eq+GcRzXTnjktAnvLNIFI5a9M9Md+evgZwswwv3Epz0
         M5Cw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=SBZJUQHqG3Tk/8UZfoEzwVwtf3XoEK9d6zlNTm6EmZQ=;
        b=ONVC0DvzDqmFbnrqe1QoXMIlSET65+Y8x/vhHyLpbL7eY+sAKTBQmAr6KPoO9sOTrS
         6puFN5Skh9ycPAFU1L3/Vamg9NSlHEpwfR2CrA+yu/kTUPP7m0ED3tHk2C1S1fpmme3V
         zIt65xJKld2CGBUDWGqDlkZj2CH19Lkom+HWyISLIMKrFsiwmGZDie7PadEX+Jo11ne8
         dQh6c/0nvgYOlLPePLgC+DyegJBMsxXdf+g1BuYJHceLRyQOn0m6OaSkesS9l6aRYSo3
         8lRWsEvtua6nLxHGtP9ikatONEtGx8xnoSpy+gK8jvKc8v9+kzHu5o6VQKKV4Cs2P2VI
         dIiQ==
X-Gm-Message-State: AGRZ1gI3MQu5nPKIHvtX0PgBxJu1X2OYoONA/GShR7u0Jt2VJP4X7qEv
        NIBh4g+OQhF/4jKaQli37omNqGVbJFCtTWP0GGU=
X-Google-Smtp-Source: ACcGV60+iZn4zdZIgME//TDNTQI0gRnnaiAWlPAS0oH3kKIc+rhaTzKtUVkb8zRUJkPFtjYFgBLbwgG/TBDl1FKhhIk=
X-Received: by 2002:a6b:9383:: with SMTP id v125-v6mr3417947iod.282.1540393248272;
 Wed, 24 Oct 2018 08:00:48 -0700 (PDT)
MIME-Version: 1.0
References: <f0770ca7-9a1c-18ad-8d9e-7fb3faa20cad@gmail.com>
In-Reply-To: <f0770ca7-9a1c-18ad-8d9e-7fb3faa20cad@gmail.com>
From:   Duy Nguyen <pclouds@gmail.com>
Date:   Wed, 24 Oct 2018 17:00:20 +0200
Message-ID: <CACsJy8BWdJ0rzP+cBrfQi7O0nm9qAdaeYoaTqScCA+nMs6_XvQ@mail.gmail.com>
Subject: Re: Translate ProGit v2 into vietnamese
To:     hung.rocket42@gmail.com
Cc:     Git Mailing List <git@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

On Wed, Oct 24, 2018 at 2:16 PM rk42_gg <hung.rocket42@gmail.com> wrote:
>
> Dear Git Developer,
>
> I have started translating Pro Git v2 book into Vietnamese at
> https://github.com/rocket42/progit2-vi

Great!

> Pls show me how to add it to "*Translations started for*" section in
> https://git-scm.com/book/en/v2

This is the wrong place for this though because the book is maintained
separately. At the bottom left of that page you can see the link
"hosted on GitHub", which leads me to

https://github.com/progit/progit2/blob/master/TRANSLATING.md

Start from there and maybe open pull requests (or issues for support)
on that project. Good luck.
-- 
Duy
