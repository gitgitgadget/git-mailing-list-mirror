Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.1 (2015-04-28) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-4.0 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,RCVD_IN_DNSWL_HI
	shortcircuit=no autolearn=ham autolearn_force=no version=3.4.1
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id B12101F597
	for <e@80x24.org>; Sat, 21 Jul 2018 07:38:02 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727341AbeGUI3q (ORCPT <rfc822;e@80x24.org>);
        Sat, 21 Jul 2018 04:29:46 -0400
Received: from mail-it0-f67.google.com ([209.85.214.67]:40301 "EHLO
        mail-it0-f67.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727041AbeGUI3q (ORCPT <rfc822;git@vger.kernel.org>);
        Sat, 21 Jul 2018 04:29:46 -0400
Received: by mail-it0-f67.google.com with SMTP id 188-v6so17435456ita.5
        for <git@vger.kernel.org>; Sat, 21 Jul 2018 00:38:01 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=RBGaoubwccIdOV5HyY9u+j+iowi89g84a0J1wg3p440=;
        b=dppg2rHFTTe+PTxTJ3rJweGNUY8sTTy71r59vGtCotEP5Zif9K6uk4KCylr1D3XB/v
         BEswOT6e1WqQv2wXwpIjqgYaM1LCY3dXG0fzDfHHtJKKXOJyNOLwDufFx/puKhQiwJf6
         u958XahaMBmhVvMIYtb1oCBqir0Dnlzk9us8Q9FqxN/aV6CnZTUmGhD3IKyz5YimL4dm
         fzPUm5cAT2vNcbiS64yrnSmZE6vfUuK56VdDKQJDr+M03FPRjlRj5mX2rM+cZFnF8jUy
         Km6jdmdhX8Uh38yd4/OcWt1e96G+rMYZCBzfr80E/z0SvG9z8unoVsHzYnk1bChe3bnq
         +UAw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=RBGaoubwccIdOV5HyY9u+j+iowi89g84a0J1wg3p440=;
        b=V0YuXzber8sK0UQQtA1qXr2WsAj3FtJjYviN3JWEh2I8D53WpKRvHQgqGeh7FmbbyF
         VZxnGnNIO2Gf76hos/3apuxM2jhjtOQ+2ZgbPrjgtygXxeSvAp4fPjbwZos/O4LwJF/q
         4NBNB1QVdRQ8Iu/m0cHoTHtD+0dV6QtZ5e1FXf5M9EamLGzkW+1DLpMB087H2fX2CRKE
         Y1EjYRafRyBIq9M47Y2sRrfCXt3K70iMCtTC01Uo3JH37uawuW2Fp5+Fy8F9xTS6OAqM
         aOkF32UabgUlyb93y83eNpw+YIEI4uJQ2Mx63JWnOd62DRmBpB3QcB5cL/pgy3kKbTrs
         dwbA==
X-Gm-Message-State: AOUpUlHT+YQRv8mMXPTutiwep+gAvpIIoxeUtUkg1kZm50AS0Hps0v9F
        qrHNzBxJBh2lEscsfzWvfYfCYgUnUJKYHdzQlow=
X-Google-Smtp-Source: AAOMgpfaaQ2uXsB4jEPgcrtMlzF1rf9suwkjxxU7bxBQRcgsp2U4jmBvcB858wBZk0rm33YCK4MYXxV5V9rT+WlfD1M=
X-Received: by 2002:a24:c888:: with SMTP id w130-v6mr4601803itf.78.1532158680866;
 Sat, 21 Jul 2018 00:38:00 -0700 (PDT)
MIME-Version: 1.0
References: <20180718161101.19765-1-pclouds@gmail.com> <20180718161101.19765-2-pclouds@gmail.com>
 <xmqqr2jzf5rk.fsf@gitster-ct.c.googlers.com>
In-Reply-To: <xmqqr2jzf5rk.fsf@gitster-ct.c.googlers.com>
From:   Duy Nguyen <pclouds@gmail.com>
Date:   Sat, 21 Jul 2018 09:37:34 +0200
Message-ID: <CACsJy8Dcby0tX4gS9+mM9W09187LZDksfhyAZTZYk10bJhL8eQ@mail.gmail.com>
Subject: Re: [PATCH v2 01/23] Update messages in preparation for i18n
To:     Junio C Hamano <gitster@pobox.com>
Cc:     Git Mailing List <git@vger.kernel.org>,
        Elijah Newren <newren@gmail.com>,
        Derrick Stolee <stolee@gmail.com>
Content-Type: text/plain; charset="UTF-8"
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

On Thu, Jul 19, 2018 at 8:18 PM Junio C Hamano <gitster@pobox.com> wrote:
> > --- a/config.c
> > +++ b/config.c
> > @@ -461,7 +461,7 @@ int git_config_from_parameters(config_fn_t fn, void *data)
> >       envw = xstrdup(env);
> >
> >       if (sq_dequote_to_argv(envw, &argv, &nr, &alloc) < 0) {
> > -             ret = error("bogus format in " CONFIG_DATA_ENVIRONMENT);
> > +             ret = error("bogus format in %s", CONFIG_DATA_ENVIRONMENT);
> >               goto out;
> >       }
> >
>
> Good job spotting that the original wanted to say, but failed to
> say, that CONFIG_DATA_ENVIRONMENT as the source of broken data we
> detected.  But I am not sure CONFIG_DATA_ENVIRONMENT is what we want
> to report as the source of bad data to the end users.  One-shot
> configuration we get form "git -c VAR=VAL" are placed in the
> environment as an internal implementation detail, so from their
> point of view, the place we saw broken data coming from is their
> command line "git -c VAR=VAL" one-shot configuration.

I think I'll leave this one out for future follow up. The change here
is needed because otherwise we can't wrap the string in _(). This
patch, as you noted, is already big and getting more complicated than
it should be.
-- 
Duy
