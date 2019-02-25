Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.2 (2018-09-13) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-3.9 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,RCVD_IN_DNSWL_HI
	shortcircuit=no autolearn=ham autolearn_force=no version=3.4.2
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 20D8C20248
	for <e@80x24.org>; Mon, 25 Feb 2019 20:29:06 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727218AbfBYU3F (ORCPT <rfc822;e@80x24.org>);
        Mon, 25 Feb 2019 15:29:05 -0500
Received: from mail-pg1-f194.google.com ([209.85.215.194]:42302 "EHLO
        mail-pg1-f194.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727021AbfBYU3E (ORCPT <rfc822;git@vger.kernel.org>);
        Mon, 25 Feb 2019 15:29:04 -0500
Received: by mail-pg1-f194.google.com with SMTP id b2so5004653pgl.9
        for <git@vger.kernel.org>; Mon, 25 Feb 2019 12:29:04 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc:content-transfer-encoding;
        bh=fgMHd9ZxkSoa5HIHMFwyBrPdzKQHw8E6vrWuOel+QKc=;
        b=SwTeuucMhSk2EfY9J+tF3VBTYnor7ng5it1U7wa92awT1cguYe6eXH5G+IENS7SGZb
         9K0tiZP+A+a0ZAU/BgUcAEmVF136Es4UPuuDKZPJYZH5gR2+Uip3QQ8mjC40M074CTnP
         eNt0zUsbRvRbXwZ3LIkubumc/Yp9k1eBLD/KVLr87oGjQ+jzc9HEu2HLkjvMze5HfROS
         g+2IsF9yyicCoW1gyIpr9DKU5O5/cRtF/EWn0MuFhRtbAMSOlNebzdPjRKvOxjW/w46F
         JfT4wi9QW0/z0/Nwa7l6Is7qHzA2/hyRbGyU2GX+XvwE8flV16rVJy6NSwwp5pAibbTf
         QcLA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc:content-transfer-encoding;
        bh=fgMHd9ZxkSoa5HIHMFwyBrPdzKQHw8E6vrWuOel+QKc=;
        b=TkPBOcaygMovETw3x4yJu6E7jQS7eK6qUuqoon1z2Dza5ffZU6dOhcy2O34lNWiZQ1
         HkAKyUOn9gIvmliZsB9XjSvplVpGYF9HcGktxEcNjpjMVY751hx62DS7i6zgoF2mEsGQ
         lOziO87mWswlUIiuHCtcJ4vc5HcrZpyNlg/7/a16GvHeKb7eiw5lbBzA9qml9Tf6zeVz
         OO+0BaHWqECZce4zMPpCsaPxzLtYWWXVuVg+mRwaOmd5j1SQg1gXABcm0U1NnN+WwBgX
         /Eab3e91f/Ks0jxol70urWBPgN8YglMa5lDe4whh1scOzI/XL/F+zFHrn13eMZe15pK9
         RXww==
X-Gm-Message-State: AHQUAuZD4oB0xNBaVP8RuDKk5pHS/7ecNcoSsxmI9J154/IG+mtHQajV
        2hyxobcFLYwAoJbrnkfgAJFOlVJ7n9bucNYPmnupaA==
X-Google-Smtp-Source: AHgI3IaT2K6nzcl2aRKOpxLks3mCcWGVKOjADw1ybrxJSJLd/tcK/MLBzHHR33frZSmLG0qm1K2erMh+vGdqGmGhfek=
X-Received: by 2002:aa7:9152:: with SMTP id 18mr21667192pfi.215.1551126544130;
 Mon, 25 Feb 2019 12:29:04 -0800 (PST)
MIME-Version: 1.0
References: <cover.1551123979.git.martin.agren@gmail.com> <e960fec4b492f3edf7bade35862333af5e8704d7.1551123979.git.martin.agren@gmail.com>
 <CAPig+cS7BdHhLn+XjjyVa+PC040y-E4iPD=kuDtigenzSHcFKQ@mail.gmail.com>
In-Reply-To: <CAPig+cS7BdHhLn+XjjyVa+PC040y-E4iPD=kuDtigenzSHcFKQ@mail.gmail.com>
From:   =?UTF-8?Q?Martin_=C3=85gren?= <martin.agren@gmail.com>
Date:   Mon, 25 Feb 2019 21:28:52 +0100
Message-ID: <CAN0heSrogSpdSOGj0ibx0Dcjw=0o0u0VSivfjgL7r5f-Jiqs3w@mail.gmail.com>
Subject: Re: [PATCH 1/3] Documentation/Makefile: add missing xsl dependencies
 for manpages
To:     Eric Sunshine <sunshine@sunshineco.com>
Cc:     Git List <git@vger.kernel.org>,
        "brian m. carlson" <sandals@crustytoothpaste.net>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

On Mon, 25 Feb 2019 at 21:08, Eric Sunshine <sunshine@sunshineco.com> wrote=
:
>
> On Mon, Feb 25, 2019 at 3:03 PM Martin =C3=85gren <martin.agren@gmail.com=
> wrote:
> > These stylesheets very rarely change, but when they do, it really helps
> > if the manpages depend on them. We're casting the net a bit too wide
> > here, since we'll only ever use a subset of the stylesheets, but since
> > these files change so rarely, that should be ok. It's better than
> > missing a dependency.
> >
> > Signed-off-by: Martin =C3=85gren <martin.agren@gmail.com>
> > ---
> > diff --git a/Documentation/Makefile b/Documentation/Makefile
> > @@ -354,7 +354,7 @@ $(OBSOLETE_HTML): %.html : %.txto asciidoc.conf
> > -%.1 %.5 %.7 : %.xml manpage-base-url.xsl
> > +%.1 %.5 %.7 : %.xml manpage-base-url.xsl $(wildcard manpage*.xsl)
>
> The wildcard expression also matches the manpage-base-url.xsl
> mentioned explicitly. Did you intentionally retain the explicit one or
> was that an oversight?

Hmm, I should have mentioned that, thanks for asking for clarification.

It's intentional. You can see in the context how manpage-base-url.xsl is
actually generated, so the wildcard won't be able to expand to mention
it. That's subtle enough that it warrants being mentioned upfront.


Martin
