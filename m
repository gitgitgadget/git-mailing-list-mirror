Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.2 (2018-09-13) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-3.8 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,RCVD_IN_DNSWL_HI
	shortcircuit=no autolearn=ham autolearn_force=no version=3.4.2
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id B4C5720248
	for <e@80x24.org>; Mon, 11 Mar 2019 10:41:58 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727216AbfCKKl5 (ORCPT <rfc822;e@80x24.org>);
        Mon, 11 Mar 2019 06:41:57 -0400
Received: from mail-pg1-f193.google.com ([209.85.215.193]:38774 "EHLO
        mail-pg1-f193.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726826AbfCKKl5 (ORCPT <rfc822;git@vger.kernel.org>);
        Mon, 11 Mar 2019 06:41:57 -0400
Received: by mail-pg1-f193.google.com with SMTP id m2so3716020pgl.5
        for <git@vger.kernel.org>; Mon, 11 Mar 2019 03:41:56 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc:content-transfer-encoding;
        bh=9I8WE2UsIbCXtv8zPK7jYPlN8vT3aNVaocUk2CuDUQ0=;
        b=go6vz3MEILsUkfruhAI7nKQo4W6HLppwIRmDnHudGf2sRNKMxO5HzQqgKFfGFjKIok
         WAocf3UkbXkskWkoeDaEPcj/Br4bZng0bH//+WYSP5qnrK/F8+CKHL4ggktRw3Kmv/NF
         xwOa8+ZE8uo0KtYYRde47rjPqb8WExnWaW4Xp1Gw8Q0g5E0mFoQdjSM7gMTNJz7jpg3K
         ZbHcDwo1W8vSML+o7j2P4ZfoXOBw2/628MkIHTPaDu8z/Kxt3Ck5X5T6hdd0PTeVl6bJ
         B+PNicWTzFHiWZcscB74zKRlG27y4ZJvIMiihOFjawpEykjQQrme6B3aKHi++sqzpY2p
         Ag3g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc:content-transfer-encoding;
        bh=9I8WE2UsIbCXtv8zPK7jYPlN8vT3aNVaocUk2CuDUQ0=;
        b=nZ/nZsloQTiVSuP89tCPnUID5U0nlTTzgiCPqj1izjOMhWRTIKUOHJPHbO4kkvXC4N
         ePwUmOTPqx4sv0Ynw/rSRsMj77TQOxyh41k6kF0NIFvmXL6Um4qpoAfOMQbvADmnrBLt
         0fgMIsAXZ0VyikrfcvnjGO4GIoswBoVFT0DY+ujw1aKFOXnBvWOJtnUaE9lkofa3XLCZ
         /Av5+15dwuF58a0Fcu7PQjCu6g9L4MYNWD1I/ixO6OcdRdeV/67Y6nr30aAOXAYVGi+M
         /sQVpyNL/DRFDCWA6Q9EbFBXVbEMIQEKNxcXMTCb3QrV3keyp/fJbNq/Tq/nDP4Z7gTn
         FJ0g==
X-Gm-Message-State: APjAAAXHxR7NKwx9v+uxocvNJMgOlS0G/90/D4d9vosGkiPklTN0Ipzn
        kVfEL8Zzhu99Bcows/cfab8uCAaJx5pe/kKtdH0=
X-Google-Smtp-Source: APXvYqxTfZpOkAoXPwjJXlBNkMe0BQ6YCJFQEqRImEW89b9LFo5dLZMwib9SBfbuGdvjk5MH65daQvCT89kN276rV0g=
X-Received: by 2002:a63:4287:: with SMTP id p129mr11726469pga.84.1552300916572;
 Mon, 11 Mar 2019 03:41:56 -0700 (PDT)
MIME-Version: 1.0
References: <20190308095752.8574-5-pclouds@gmail.com> <20190309123518.2193053-1-martin.agren@gmail.com>
 <CACsJy8DdzbcZzny+v=TESeBxaOsvJcmwY0e54xYvh2m+0zzVXw@mail.gmail.com>
In-Reply-To: <CACsJy8DdzbcZzny+v=TESeBxaOsvJcmwY0e54xYvh2m+0zzVXw@mail.gmail.com>
From:   =?UTF-8?Q?Martin_=C3=85gren?= <martin.agren@gmail.com>
Date:   Mon, 11 Mar 2019 11:41:43 +0100
Message-ID: <CAN0heSo94+noufXERexAqodh3GsTFh=f+W+Hd2_0OL3buNfNKg@mail.gmail.com>
Subject: Re: [PATCH v3 04/21] git-checkout.txt: fix monospace typeset
To:     Duy Nguyen <pclouds@gmail.com>
Cc:     Git Mailing List <git@vger.kernel.org>,
        Junio C Hamano <gitster@pobox.com>,
        Eric Sunshine <sunshine@sunshineco.com>,
        =?UTF-8?Q?SZEDER_G=C3=A1bor?= <szeder.dev@gmail.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

On Mon, 11 Mar 2019 at 10:35, Duy Nguyen <pclouds@gmail.com> wrote:
>
> On Sat, Mar 9, 2019 at 7:35 PM Martin =C3=85gren <martin.agren@gmail.com>=
 wrote:
>
> > @@ -285,7 +285,7 @@ Note that this option uses the no overlay mode by d=
efault (see also
> The part not shown here is
>
>     Using `--recurse-submodules` will update the content of all initializ=
ed
>     submodules according to the commit recorded in the superproject. If
>     local modifications in a submodule would be overwritten the checkout
>
> and the --recurse-submodules is rendered incorrectly (not with
> monospace font, and the quotes remain) because...
>
> >         will fail unless `-f` is used. If nothing (or `--no-recurse-sub=
modules`)
> >         is used, the work trees of submodules will not be updated.
> >         Just like linkgit:git-submodule[1], this will detach the
> > -       submodules HEAD.
> > +       submodules' `HEAD`.
>
> ...of this apostrophe, it seems, on both man and html versions. This
> is with asciidoc 8.6.9.

Oh wow, nicely debugged. Yeah, I see this with 8.6.10, but not with
Asciidoctor (1.5.5).

> Martin, could you check if your asciidoc (or asciidoctor) behaves the
> same? If it's not just my buggy asciidoc version, I can turn this to
> "wil detach `HEAD` of the submodule" which should fix the problem.

Sounds good.

Martin
