Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 780A1C433EF
	for <git@archiver.kernel.org>; Wed, 22 Dec 2021 01:47:15 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S241222AbhLVBrP (ORCPT <rfc822;git@archiver.kernel.org>);
        Tue, 21 Dec 2021 20:47:15 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:60056 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232258AbhLVBrN (ORCPT <rfc822;git@vger.kernel.org>);
        Tue, 21 Dec 2021 20:47:13 -0500
Received: from mail-lf1-x135.google.com (mail-lf1-x135.google.com [IPv6:2a00:1450:4864:20::135])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id AC224C061574
        for <git@vger.kernel.org>; Tue, 21 Dec 2021 17:47:12 -0800 (PST)
Received: by mail-lf1-x135.google.com with SMTP id x21so1780414lfa.5
        for <git@vger.kernel.org>; Tue, 21 Dec 2021 17:47:12 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=0B69jTR2MHYoF9vl5RbhPq1IzDKP7i3+psXoiOHST54=;
        b=ZFK8scCgLY9TKswpGJ1KH/t1svT/juWfEGPuGb1toqe4YwjOz2eamPmVdQlmQGpCvj
         isNJsv7GGR3WpepCXCA5jl/iSrwyXSNsACehb3rq6cxR6S3qBT8coLm0Ejk3CyX3IMT4
         GMdYdC4UGxmAxrY+Gz9Vj4adykLz3izeLen6D9Vwyz7BF/+A5dAuODOX20A62vKtXIE6
         vcD3Ouqk1U46+ZLE0eplgfgZ9WemvgopoUNLUnVLWR3roEeKT2XpAhby++an9egMQUee
         gum1CZjBQ3kr4hl/Dx7i5D756Hg1vVGmpBvTaaf0Q5yg/hTazpO2D7wz0YVYT8ySsHTY
         sqBA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=0B69jTR2MHYoF9vl5RbhPq1IzDKP7i3+psXoiOHST54=;
        b=pycXB6RfMCttKRRTDkX9Kk/EGwbTLI3t0yIFlcju0UTQYOPQC6b+15vQtt0KFqzVh+
         htXQ8MvshfP16iUMBfITksR6/MWIDTb0NWwlOOhKmNp4GidiIPEvkp/EjvPpzyciUjT6
         3FeKPxhxdzyZHB5q1uDtCLuaZp000AZmAag8Ig0hy0Mq3qdKFzD9ObkGaA7GB/jLci19
         5Vaud1HBq6ujuHV03UmqQb87ASbWpWA8qW4GjjZjIXhxj5RT5650SPFrByKbkcOu4zdL
         KLLA5eztOoGI45Fzq7aulZ0W90XHZXWRrWeynP/Z6q63YkZYrO4Dq+oBWqfryT4kPUJC
         8N6Q==
X-Gm-Message-State: AOAM531VcSw545aOw2P1xm3ACEtPj4QlwneLessv5dEz9q8dA1fkfPHZ
        +y0TPCEaAxj1rAvqRCNwyg2INynYRnIoCJdURGg=
X-Google-Smtp-Source: ABdhPJzF7tztU6pxo0GPRWVyiQCUZIs6hNYzeVb/G9JsGe2P8Ve9MjkdzmE3aALl3A0Od5XgWG/g+jkRTJgWnyNh2bY=
X-Received: by 2002:a05:6512:32a3:: with SMTP id q3mr765325lfe.473.1640137630989;
 Tue, 21 Dec 2021 17:47:10 -0800 (PST)
MIME-Version: 1.0
References: <25107068cbbf8c9ce6886e66e25dff19e072583f.1639425295.git.steadmon@google.com>
 <a9453065c2e89d79fc117363fe41fa10986e06d1.1640113138.git.steadmon@google.com> <xmqq1r25ptjx.fsf@gitster.g>
In-Reply-To: <xmqq1r25ptjx.fsf@gitster.g>
From:   Jiang Xin <worldhello.net@gmail.com>
Date:   Wed, 22 Dec 2021 09:46:59 +0800
Message-ID: <CANYiYbFmVRBUgwqKBcOvOz6LRLE8gRUoFfJUjVR7_YeQjjT2ig@mail.gmail.com>
Subject: Re: [PATCH v2] l10n: README: call more attention to plural strings
To:     Junio C Hamano <gitster@pobox.com>
Cc:     Josh Steadmon <steadmon@google.com>, Git List <git@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

On Wed, Dec 22, 2021 at 4:55 AM Junio C Hamano <gitster@pobox.com> wrote:
>
> Josh Steadmon <steadmon@google.com> writes:
>
> > In po/README.md, we point core developers to gettext's "Preparing
> > Strings" documentation for advice on marking strings for translation.
> > However, this doc doesn't really discuss the issues around plural form
> > translation, which can make it seem that nothing special needs to be
> > done in this case.
> >
> > Add a specific callout here about marking plural-form strings so that
> > the advice later on in the README is not overlooked.
> >
> > Signed-off-by: Josh Steadmon <steadmon@google.com>
> > ---
> >  po/README.md | 4 ++++
> >  1 file changed, 4 insertions(+)
> >
> > diff --git a/po/README.md b/po/README.md
> > index dcd8436c25..19fabb4acf 100644
> > --- a/po/README.md
> > +++ b/po/README.md
> > @@ -221,6 +221,10 @@ General advice:
> >  - Adjust the strings so that they're easy to translate. Most of the
> >    advice in `info '(gettext)Preparing Strings'` applies here.
> >
> > +- Strings referencing numbers of items may need to be split into singular and
> > +  plural forms; see the Q\_() wrapper in the C sub-section below for an
> > +  example.
> > +
> >  - If something is unclear or ambiguous you can use a "TRANSLATORS"
> >    comment to tell the translators what to make of it. These will be
> >    extracted by xgettext(1) and put in the "po/\*.po" files, e.g. from
> >
> > base-commit: cd3e606211bb1cf8bc57f7d76bab98cc17a150bc
>
> Looks sensible to me.
>
> I do not mind taking this myself, instead of getting it via our i18n
> manager, if Jiang is OK with it.

Look good to me, and please help merge, otherwise the patch will have
to wait about 1 month for the next l10n window.

--
Jiang Xin
