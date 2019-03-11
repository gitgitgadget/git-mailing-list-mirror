Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.2 (2018-09-13) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-4.1 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,RCVD_IN_DNSWL_HI
	shortcircuit=no autolearn=ham autolearn_force=no version=3.4.2
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 6A63520248
	for <e@80x24.org>; Mon, 11 Mar 2019 09:36:00 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727282AbfCKJf6 (ORCPT <rfc822;e@80x24.org>);
        Mon, 11 Mar 2019 05:35:58 -0400
Received: from mail-it1-f194.google.com ([209.85.166.194]:36047 "EHLO
        mail-it1-f194.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726969AbfCKJf6 (ORCPT <rfc822;git@vger.kernel.org>);
        Mon, 11 Mar 2019 05:35:58 -0400
Received: by mail-it1-f194.google.com with SMTP id v83so6205342itf.1
        for <git@vger.kernel.org>; Mon, 11 Mar 2019 02:35:58 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc:content-transfer-encoding;
        bh=m9nvdF08sblVDiGM/ZOp4AvVg2sYOwc+2GN28fyQ9U0=;
        b=nX3CXwCGVgT3wUVStA+oxlV7FejNvwFslPGPp4R2D+tzE8dD4z2+ygQh4ug4Aw7UZK
         3n6wygvKsfy8AM7CFrpRN9arele1fbC8ZckZAy3DwgG+PghjX7fDsDtLSAKb0A3ClQ6B
         X5vnozGp1me6Eee9cBVAPQf9dRHYolo6oNaweJ+QqF60oauuwm/P4rjCznqejsnUSTRq
         sZT4/L1A2ekrHUhv9RBuW2RrEA6rPi3KXKoKjzsu4uO/c75UD/YIULcC7mz5z53sXNot
         ybVFFoZaFc6GTQ6u43ewGPyEFZYppsTitTlz/gNzcAOfifQCNPqip3dglFIfQffinO/v
         9XWA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc:content-transfer-encoding;
        bh=m9nvdF08sblVDiGM/ZOp4AvVg2sYOwc+2GN28fyQ9U0=;
        b=E+2Mb5tX2r8BpGREN/nM4vYpv4IDBX89U5jxFDSnUZ+COVx8awp+mhnRA0et2lh8mK
         VGG+ZmJkFFCB4Vpto5DJ6hkhMhf7/s1YCJipKrh9ff1Zvww6qdJcKe+iWIGCMYCtaQFL
         CTjwfuks/73z63n6A2D8vJ4CMS8MuH3Ij8eq5bGQr3jkhEYOz167mzyW9Eg1ICzyLz6E
         CmF0agY0D3IHIrs1ry5RXptlodFqfRiD3EpOgCcMG6R8DXU919wZ3D76HLEfhun70uBN
         9Y8p4Na/NAF8cNQBM/X6jI2F/ta1BLj4PPXVyvOV8BFHmIJYJMnKId86vo6uK26CzrAQ
         1fqw==
X-Gm-Message-State: APjAAAVpDke4OJmsP7IRqtOvbPnRZmBxO3qeXSGYMqbvOSgYB7Ely/3W
        RriOdoW1x9pEji1ibU5dvsJf4PLe2vClPi62lRs=
X-Google-Smtp-Source: APXvYqyUK+ggzOLMePuUoNWCX4R/9RzoO79Q4z8x2aLxsh4E4CkxGG1U7N5XD6wlNdGIEG452UNmb/xjDDeovYJWfMg=
X-Received: by 2002:a24:ccc5:: with SMTP id x188mr15085882itf.123.1552296957626;
 Mon, 11 Mar 2019 02:35:57 -0700 (PDT)
MIME-Version: 1.0
References: <20190308095752.8574-5-pclouds@gmail.com> <20190309123518.2193053-1-martin.agren@gmail.com>
In-Reply-To: <20190309123518.2193053-1-martin.agren@gmail.com>
From:   Duy Nguyen <pclouds@gmail.com>
Date:   Mon, 11 Mar 2019 16:35:31 +0700
Message-ID: <CACsJy8DdzbcZzny+v=TESeBxaOsvJcmwY0e54xYvh2m+0zzVXw@mail.gmail.com>
Subject: Re: [PATCH v3 04/21] git-checkout.txt: fix monospace typeset
To:     =?UTF-8?Q?Martin_=C3=85gren?= <martin.agren@gmail.com>
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

On Sat, Mar 9, 2019 at 7:35 PM Martin =C3=85gren <martin.agren@gmail.com> w=
rote:

> @@ -285,7 +285,7 @@ Note that this option uses the no overlay mode by def=
ault (see also
The part not shown here is

    Using `--recurse-submodules` will update the content of all initialized
    submodules according to the commit recorded in the superproject. If
    local modifications in a submodule would be overwritten the checkout

and the --recurse-submodules is rendered incorrectly (not with
monospace font, and the quotes remain) because...

>         will fail unless `-f` is used. If nothing (or `--no-recurse-submo=
dules`)
>         is used, the work trees of submodules will not be updated.
>         Just like linkgit:git-submodule[1], this will detach the
> -       submodules HEAD.
> +       submodules' `HEAD`.

...of this apostrophe, it seems, on both man and html versions. This
is with asciidoc 8.6.9.

Martin, could you check if your asciidoc (or asciidoctor) behaves the
same? If it's not just my buggy asciidoc version, I can turn this to
"wil detach `HEAD` of the submodule" which should fix the problem.
--=20
Duy
