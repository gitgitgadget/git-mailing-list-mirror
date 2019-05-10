Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.2 (2018-09-13) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-4.0 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,RCVD_IN_DNSWL_HI
	shortcircuit=no autolearn=ham autolearn_force=no version=3.4.2
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 067381F45F
	for <e@80x24.org>; Fri, 10 May 2019 10:29:55 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727392AbfEJK3x (ORCPT <rfc822;e@80x24.org>);
        Fri, 10 May 2019 06:29:53 -0400
Received: from mail-it1-f174.google.com ([209.85.166.174]:40453 "EHLO
        mail-it1-f174.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727302AbfEJK3x (ORCPT <rfc822;git@vger.kernel.org>);
        Fri, 10 May 2019 06:29:53 -0400
Received: by mail-it1-f174.google.com with SMTP id g71so8319437ita.5
        for <git@vger.kernel.org>; Fri, 10 May 2019 03:29:53 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc:content-transfer-encoding;
        bh=9u4hPrNQeGONFqbeAYvQeKXf8DRZ91EPT3KJ76nKziI=;
        b=rP4ODaYLphvHKnbWmSmsuqU36XPKDc2i1QNzCImyG2h2lmMbc/5WhMogyxgw3z9UlO
         3rRStl2zr8nbB5OlJNSJH2BjCoD9+/yOWUq2OahElEPiOp1osZI1vvxwuSJujtBZgHMh
         OUYYyhzqsVS8j7TEcF4czGF2DOQUsHs22lzSvNZTste7XIBG3E74NHyv+2uzrvjPHzW6
         uXZaio7xZJldOUa8ri4yg4Pz4yuQMGYx9ZyHiB4KOanrUYxcET8P0Mh8l//cOWAFjtVf
         UNuI7g/0QMV1R0MQCPaGYeXdr9Plup7y2k8qAfcbIYIZILoPtqh4tR3StaFwo49EEz0f
         zKIg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc:content-transfer-encoding;
        bh=9u4hPrNQeGONFqbeAYvQeKXf8DRZ91EPT3KJ76nKziI=;
        b=F4mWXc1ZqWaBiCGsWVoWM9ubZueDYgLWJKAtpFdIzjrEv+pNuy0dxSVet6LXblD0wC
         yEau91mWhRpie4IyKDswxVIoBri6M2UrDrlAkGgZAnyuYKepXg75qFBIanPHAg5RNhcv
         JeE6k7ga1uw5mf+CXbogZBAZ2tcacjlGSUqCnWIxNDx96WxYhpdjbFWogaxr67c/H+Nb
         ek8q0ppfWtPMKMsvL+Ww2W6Le2C8bnmgeaWgeuVqEgeejZXGv/UvhIy5gQMAd32w4a1i
         OLwpfB3MNJYsT7lLwxmgDqVU8TvIHeNlOrcrPjhg1SodVTiCHPM/szoiNkhia9TMqYgU
         Nsvg==
X-Gm-Message-State: APjAAAUEHv3McU6LyN66CSoANDAei0E2NCQ4Gh8oJtp85t1HWKgEb0yU
        f+TR+meeLTTMR5oecSLTx/ol3QrXyk05uP3vDdY=
X-Google-Smtp-Source: APXvYqyjxLm5qotTqkJY8lCqgB4v5nt2YBiOFrf3sUZl6rvU85XqWNZVfaenI9Zr3jAIt0Z8yCd/RvxfFfQB+R3xyHI=
X-Received: by 2002:a02:c64a:: with SMTP id k10mr7009956jan.30.1557484192691;
 Fri, 10 May 2019 03:29:52 -0700 (PDT)
MIME-Version: 1.0
References: <CACG5jMxnS1AR4YjuRu1woBKfrC+R-Fr9qbBK9L2L9D6Vfp9dig@mail.gmail.com>
In-Reply-To: <CACG5jMxnS1AR4YjuRu1woBKfrC+R-Fr9qbBK9L2L9D6Vfp9dig@mail.gmail.com>
From:   Duy Nguyen <pclouds@gmail.com>
Date:   Fri, 10 May 2019 17:29:26 +0700
Message-ID: <CACsJy8C__PCufU2L9F0OWNa1WaXncWKKNp7x7HLUxHLhmUSqLw@mail.gmail.com>
Subject: Re: config file not being copied from templates folder
To:     Jack Zylkin <jzylkin@gmail.com>
Cc:     Git Mailing List <git@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

On Fri, May 10, 2019 at 2:07 AM Jack Zylkin <jzylkin@gmail.com> wrote:
>
> The =E2=80=9Cgit init=E2=80=9D documentation for the =E2=80=9CTemplate Di=
rectory=E2=80=9D states that:
>
>
> =E2=80=9CFiles and directories in the template directory whose name do no=
t
> start with a dot will be copied to the $GIT_DIR after it is created.=E2=
=80=9D
>
>
> However, I put a file called =E2=80=9Cconfig=E2=80=9D in this directory, =
and it was
> not copied to the .git directory after running =E2=80=9Cgit init=E2=80=9D=
.  Instead
> there is always the same old default config file there (and I don=E2=80=
=99t
> know where this file comes from).

What version are you using? Seems to work for me.

> I don=E2=80=99t know any other way of changing the default local config f=
ile
> used for new repos.  I really want to change this default config file
> because I want to use =E2=80=9Csymlinks=3Dtrue=E2=80=9D in all new repos,=
 regardless of
> what git was told to do about symlinks when it was installed.
>
>
> (In my case, the chocolatey installer that installs git seems to
> disable symlinks no matter what).
--=20
Duy
