Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.1 (2015-04-28) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-4.0 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,RCVD_IN_DNSWL_HI
	shortcircuit=no autolearn=ham autolearn_force=no version=3.4.1
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id F022C1F404
	for <e@80x24.org>; Tue,  4 Sep 2018 15:16:35 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727573AbeIDTmG (ORCPT <rfc822;e@80x24.org>);
        Tue, 4 Sep 2018 15:42:06 -0400
Received: from mail-io0-f195.google.com ([209.85.223.195]:38080 "EHLO
        mail-io0-f195.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727093AbeIDTmF (ORCPT <rfc822;git@vger.kernel.org>);
        Tue, 4 Sep 2018 15:42:05 -0400
Received: by mail-io0-f195.google.com with SMTP id y3-v6so3279800ioc.5
        for <git@vger.kernel.org>; Tue, 04 Sep 2018 08:16:34 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc:content-transfer-encoding;
        bh=vzeTz6DZPEN0l8eKE9ff6lk1J1dJ9CU4hDSmehVYRpA=;
        b=HGC3BUR6KkDbZpigYqjRyol1UbUO3G07BTmXaWMsM35zpAhNNmDyHtfLTWRLpluVyr
         wQmWUxnv3lOlS1AOgJbNma7159SavKQzFamvWkovQ1zpOzmKA6KkSJTjmHTVNZjyeVS2
         j2fCcyGOIi63JZ1uctjmjU1ac0endASIaPJO+7ssReSW92jvWa7Tm/522oxEJlw1++zl
         khJJ19H5LB3wEn7zrhuWZPRBOpoGGjUNoNaXzFUPd8jPLC/Nq4GtUdTZll0Ki4GRh7YA
         y94yaIDBN5U/UECObpQNkyg2XFk++v3uL27UR0jWJCmt4qBuYacWeQ8b2fxdg64gizN4
         roCg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc:content-transfer-encoding;
        bh=vzeTz6DZPEN0l8eKE9ff6lk1J1dJ9CU4hDSmehVYRpA=;
        b=b6+wWCFlxneKV8UP/Ul1J+FHvlGh/Ko7QJPgveWB7O+G79i/dOZ+kPD8sjamUytChV
         3XbM8Eo9F9eOLHjqXG36sxbvHnODQH5Sp49m/WntPV730gusYKH3CvFSwzTL3FjW+AZR
         HrhszHSXdiw6e30Fs9KLngmHA8w/DaiadcrrY0ylk1z9qHIM7K3iWkwuAqRaC4SLnWfQ
         JsnfPq/skLLvXMfqdHALtIthCc7bG+qusTnavpo4JVvaewWv/6yQbPSH65hyJRTEWf7E
         IFB6Sgb8qWe005tsJ3Vywdf2tn08rWn4dC43LN/2f7heYIlPILDr9UrDseiqzSYJCxLc
         Ivvg==
X-Gm-Message-State: APzg51BHKL6yaGI+aRdC9AM7xYP+0SBuKq/fctf8HjWYCuybyXZzSC99
        XZNofUl6+eEc2oM/XQ/dKdelDe0xCjMzx2mCd30=
X-Google-Smtp-Source: ANB0VdYHG3UIjZmO3KzHt/7PHb7wTQZZOGuijXsY25dAEJ0f4AzqWFjY7OZ0fMbAiN7SaHzsWMW9TOd4lk4qBgI8HP0=
X-Received: by 2002:a6b:4515:: with SMTP id s21-v6mr21716676ioa.273.1536074193777;
 Tue, 04 Sep 2018 08:16:33 -0700 (PDT)
MIME-Version: 1.0
References: <CANYiYbHmU=j+MwLTumJ+BK_0msyPBeux92wF8VqL9J04VOc-FQ@mail.gmail.com>
 <20180904141816.26398-1-jn.avila@free.fr> <CACBZZX6Bm-xOO-mvDzmRAA9Xu6HrBr5z+39dp4t6fTTCmNHKbQ@mail.gmail.com>
In-Reply-To: <CACBZZX6Bm-xOO-mvDzmRAA9Xu6HrBr5z+39dp4t6fTTCmNHKbQ@mail.gmail.com>
From:   Duy Nguyen <pclouds@gmail.com>
Date:   Tue, 4 Sep 2018 17:16:05 +0200
Message-ID: <CACsJy8CgS1JzbKhV4T+xpCHnc8OrVEd5i-o-O-XamPxuPOZjMw@mail.gmail.com>
Subject: Re: [PATCH] i18n: fix dangling dot in die() messages
To:     =?UTF-8?B?w4Z2YXIgQXJuZmrDtnLDsCBCamFybWFzb24=?= <avarab@gmail.com>
Cc:     jn.avila@free.fr, Git Mailing List <git@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

On Tue, Sep 4, 2018 at 5:08 PM =C3=86var Arnfj=C3=B6r=C3=B0 Bjarmason <avar=
ab@gmail.com> wrote:
>
> On Tue, Sep 4, 2018 at 4:59 PM Jean-Noel Avila <jn.avila@free.fr> wrote:
>
> Your commit message says "dangling dot"...
>
> > diff --git a/builtin/submodule--helper.c b/builtin/submodule--helper.c
> > index b56028ba9d..a011abfd7c 100644
> > --- a/builtin/submodule--helper.c
> > +++ b/builtin/submodule--helper.c
> > @@ -521,7 +521,7 @@ static void runcommand_in_submodule_cb(const struct=
 cache_entry *list_item,
> >                 printf(_("Entering '%s'\n"), displaypath);
> >
> >         if (info->argv[0] && run_command(&cp))
> > -               die(_("run_command returned non-zero status for %s\n.")=
,
> > +               die(_("run_command returned non-zero status for %s"),
>
> ...but here and below you're also removing the newline. Is this
> intended, and does it work as desired afterwards? I.e. were we just
> ignoring the \n?

die() already adds \n, so this \n adds a blank line. Since this is an
error, not part of any fancy text layout construction, I think the \n
here could (and should) be removed
--=20
Duy
