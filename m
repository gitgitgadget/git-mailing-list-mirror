Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id DC311C433EF
	for <git@archiver.kernel.org>; Thu, 16 Dec 2021 01:10:28 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229945AbhLPBK2 (ORCPT <rfc822;git@archiver.kernel.org>);
        Wed, 15 Dec 2021 20:10:28 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:58466 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229441AbhLPBK1 (ORCPT <rfc822;git@vger.kernel.org>);
        Wed, 15 Dec 2021 20:10:27 -0500
Received: from mail-qt1-x831.google.com (mail-qt1-x831.google.com [IPv6:2607:f8b0:4864:20::831])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 46BE5C061574
        for <git@vger.kernel.org>; Wed, 15 Dec 2021 17:10:27 -0800 (PST)
Received: by mail-qt1-x831.google.com with SMTP id o17so23866195qtk.1
        for <git@vger.kernel.org>; Wed, 15 Dec 2021 17:10:27 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to;
        bh=ZGxgkTEf6fD0VL3FxZjwVj0vtrSP60SurOAzUzptb+A=;
        b=Nh2c3P0f/4d3Fjr8uPPPfGWlalm+bihRKr00/3m471h23AbQI+MBPzOTPkfBXKJ5L6
         DErxKWcQ9EMCtZEJqyteCODOGzUjuPXt/VQyyUP3HkM5N2DHlhLQMZ5Z/SL6fViuOjx9
         o/hg1r9UCyc/4r6SecJEmmy2fJHvljEsjmfxWZYn95Ju0wHtqiJPwzxqcGIPyY5U67Or
         YZ4d/oKcxdsWZlt41k1t7s647AjcbSqr8+ssUkJu2d+EYx281INIorQEhE/rrT427qbV
         gF/PfR280Gz6cDaVFtXTGaipyqmlNpv6U8nx+ru7+GRYJpCDWP4x/MnZg/xhKy2d2DvC
         VtbA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to;
        bh=ZGxgkTEf6fD0VL3FxZjwVj0vtrSP60SurOAzUzptb+A=;
        b=vmNmHdXnStqM6Iv1+W0nku4MzPxyGXBlqOV08i0G5XK/A6HJcoNcjitbfevM/OW+XV
         8ZdLuM1orkhkLVmaPksXH0+W7PTz8XotghuFX7wfESzr4BTLv3WZ9aJ0ypqh30zEhIcV
         ibktiYe8aZPjyfIW2GejGBhEfrsRJICQJJAqBxwP7WBZwBhp2LiYA8UUTh03jJvUVcWb
         c9lkV/YwDgbIeBi1NNDPw8PQmhnLvNynbpxsqVpYh2560av7yGHaI6Istuwf76q/xKTY
         0iuzrkiyI8A3AAeL7ISt3RLlOBCghnYLeKxhTq3eEJOJQh3vYmSqcG0f/C4XFWzlX5n/
         9TOw==
X-Gm-Message-State: AOAM5301KQEH1ENUgI2picCNRfV1oTEJ4Se79qWOaiMlDo3GQsphcaJh
        a2uASR4Xa25DMyw7YtWUEspkDTtoDAkZUk24t8w=
X-Google-Smtp-Source: ABdhPJxQCIy93TaV37iUmcnHiV6g41BZ1U5bzPGB+MdyBmqbmguoJOq9GneY1TyCaTaGJXFkaxoEnxNQ9/VcNBCpQ10=
X-Received: by 2002:ac8:588a:: with SMTP id t10mr14955733qta.151.1639617026343;
 Wed, 15 Dec 2021 17:10:26 -0800 (PST)
MIME-Version: 1.0
References: <25107068cbbf8c9ce6886e66e25dff19e072583f.1639425295.git.steadmon@google.com>
 <xmqqa6h4b24o.fsf@gitster.g> <YbfC5/+Q7lPp0G2i@google.com>
In-Reply-To: <YbfC5/+Q7lPp0G2i@google.com>
From:   Jiang Xin <worldhello.net@gmail.com>
Date:   Thu, 16 Dec 2021 09:10:15 +0800
Message-ID: <CANYiYbF31o-sQYU-OjJk=pQR5RHM0k7jqmEhiKGLeO3Suu1khQ@mail.gmail.com>
Subject: Re: [PATCH] l10n: README: call more attention to plural strings
To:     Josh Steadmon <steadmon@google.com>,
        Junio C Hamano <gitster@pobox.com>,
        Git List <git@vger.kernel.org>,
        Jiang Xin <worldhello.net@gmail.com>,
        Bagas Sanjaya <bagasdotme@gmail.com>
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

On Tue, Dec 14, 2021 at 6:02 AM Josh Steadmon <steadmon@google.com> wrote:
>
> On 2021.12.13 13:56, Junio C Hamano wrote:
> > Josh Steadmon <steadmon@google.com> writes:
> >
> > > In po/README.md, we point core developers to gettext's "Preparing
> > > Strings" documentation for advice on marking strings for translation.
> > > However, this doc doesn't really discuss the issues around plural form
> > > translation, which can make it seem that nothing special needs to be
> > > done in this case.
> > >
> > > Add a specific callout here about marking plural-form strings so that
> > > the advice later on in the README is not overlooked.
> > >
> > > Signed-off-by: Josh Steadmon <steadmon@google.com>
> > > ---
> > >  po/README.md | 5 ++++-
> > >  1 file changed, 4 insertions(+), 1 deletion(-)
> > >
> > > diff --git a/po/README.md b/po/README.md
> > > index dcd8436c25..fd1e024dd3 100644
> > > --- a/po/README.md
> > > +++ b/po/README.md
> > > @@ -219,7 +219,10 @@ General advice:
> > >    they're part of Git's API.
> > >
> > >  - Adjust the strings so that they're easy to translate. Most of the
> > > -  advice in `info '(gettext)Preparing Strings'` applies here.
> > > +  advice in `info '(gettext)Preparing Strings'` applies here. Strings
> > > +  referencing numbers of items may need to be split into singular and
> > > +  plural forms; see the Q\_() wrapper in the C sub-section below for an
> > > +  example.

Wouldn't it be better if we add a new rule ("Strings ... an example.")
after this one?

> > >
> > >  - If something is unclear or ambiguous you can use a "TRANSLATORS"
> > >    comment to tell the translators what to make of it. These will be
> >
> > Sounds good to me, but I'd want an ack by those from the l10n
> > department.
> >
> > Thanks.
>
> Hmm, I meant to CC both Jiang and Bagas, not sure why it didn't go
> through.

Yesterday I was interrupted by a meeting while reading this thread.

--
Jiang Xin
