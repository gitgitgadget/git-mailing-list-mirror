Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.2 (2018-09-13) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-3.8 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,RCVD_IN_DNSWL_HI,
	SPF_HELO_NONE,SPF_NONE shortcircuit=no autolearn=ham
	autolearn_force=no version=3.4.2
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id C7BAB1F4B5
	for <e@80x24.org>; Fri, 15 Nov 2019 16:37:43 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727671AbfKOQhn (ORCPT <rfc822;e@80x24.org>);
        Fri, 15 Nov 2019 11:37:43 -0500
Received: from mail-pl1-f196.google.com ([209.85.214.196]:36389 "EHLO
        mail-pl1-f196.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727507AbfKOQhm (ORCPT <rfc822;git@vger.kernel.org>);
        Fri, 15 Nov 2019 11:37:42 -0500
Received: by mail-pl1-f196.google.com with SMTP id d7so5018151pls.3
        for <git@vger.kernel.org>; Fri, 15 Nov 2019 08:37:42 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc:content-transfer-encoding;
        bh=hhZVqYBOqblTzGasAL/aalfgt9KMEdO3RC7RNm71w3U=;
        b=g/QOrUq9AfvLPZh8UKYaazy+RFq9g/I7BHwiDBQFzL5FT9KD+/BE0NVJX2dLcJXlZ1
         8A3pLgykLuqf08fdDH+Qt3YuSGrkB8sKcxsujX7ubonosEGwGsfw50QmHYLjOCz4HxLy
         dRsUw3IpJ8fW1SPWT7sHW/Jaq77Z7YCTtR0Xd3GZlHXAw3L0F3dBlFQJ9HG4Xp6F/mW6
         MUAQqNOXLqSIUESunqWZN73D8YibI0kJoq0dyiH6HlY9MhieReA2WWGPy01QW7LQziih
         Ax4A+nDIGsFpbroe87TzyhAAi9rBIm0iGJm8qETMxnKzpPbau/pdxu2dKdhRzJ3JwRKr
         /HdQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc:content-transfer-encoding;
        bh=hhZVqYBOqblTzGasAL/aalfgt9KMEdO3RC7RNm71w3U=;
        b=Oq1MlM0nAKQLqFcNAIzoZDgaNewEpF3R80epbin1rNpd+Yu4tQ/CesxlpZaSjivjnj
         wrfA4zJWW1Ob4bQf7SbBi7z6t5OD71LWNwP9iqKhjGnoBdHE7bSUqTToHhSAvmM2Zlsq
         YZ+BsObOS6NBoLDm7re7VyV42vJ4mEOvP81OznzF/KKItpeXgpZ8/OoomxMaUZKooZsm
         o6Q/szSElueKAKddA9LfYm7wT7Hv19JFowE94lR6kSk0nvViqKdAvN4+wU6I54IVQp0+
         M+CpxvAPCHyW31Veq8Tp5skf8DQTr60MDIEee1XsRMkHIJ1YCpc18Ka4evcy03ihg0OO
         bTsw==
X-Gm-Message-State: APjAAAXYrzAF7212z2NKh11NPzqeLSOM9bvXZqQK1LTrfOi4JgUOAegf
        VW/79rrDu8KFr0jNYtqGQZxaZAzMAKPOKY9Biew=
X-Google-Smtp-Source: APXvYqw7I3cyNsyVbR/9go761yiZQUjt/+6xD/rI6YB18XeHwMVe7VYlZQ/ag9KuoF4PRpQG1J5fwcMAEdbI1dNZ0yY=
X-Received: by 2002:a17:90a:ba05:: with SMTP id s5mr21489052pjr.73.1573835862143;
 Fri, 15 Nov 2019 08:37:42 -0800 (PST)
MIME-Version: 1.0
References: <20191115160330.A64EBD756F@wsmn.osm-gmbh.de> <CAN0heSoW1GWEDxQN-d9bR4Vs5vzMaeDMar=QzShhcVNO1A0Sxg@mail.gmail.com>
In-Reply-To: <CAN0heSoW1GWEDxQN-d9bR4Vs5vzMaeDMar=QzShhcVNO1A0Sxg@mail.gmail.com>
From:   =?UTF-8?Q?Martin_=C3=85gren?= <martin.agren@gmail.com>
Date:   Fri, 15 Nov 2019 17:37:30 +0100
Message-ID: <CAN0heSprR-CMyc0qXvq5QKi4Qq5pqi+yvAU1=P+Cp+=Sg1My1g@mail.gmail.com>
Subject: Re:
To:     Martin Nicolay <m.nicolay@osm-ag.de>
Cc:     Git Mailing List <git@vger.kernel.org>,
        =?UTF-8?B?Tmd1eeG7hW4gVGjDoWkgTmfhu41jIER1eQ==?= 
        <pclouds@gmail.com>, Michael Haggerty <mhagger@alum.mit.edu>,
        Junio C Hamano <gitster@pobox.com>, yuelinho777@gmail.com
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

[Trying with another e-mail address for Martin Nicolay. Maybe the one
from the in-body From header works better. wsmn.osm-gmbh.de couldn't be
found.]

On Fri, 15 Nov 2019 at 17:29, Martin =C3=85gren <martin.agren@gmail.com> wr=
ote:
>
> Hi Martin
>
> On Fri, 15 Nov 2019 at 17:17, Martin Nicolay <martin@wsmn.osm-gmbh.de> wr=
ote:
>
> > While working with complex scripts invoking git multiple times my
> > editor detects the changes and calls "git status". This leads to
> > aborts in "git-stash". With this patch and an appropriate value
> > core.fileslocktimeout this problem goes away.
>
> Are you able to patch your editor to call
>   git --no-optional-locks status
> instead? See the bottom of git-status(1) ("BACKGROUND REFRESH") for more
> on this.
>
> > +long get_files_lock_timeout_ms(void)
> > +{
> > +       static int configured =3D 0;
> > +
> > +       /* The default timeout is 100 ms: */
> > +       static int timeout_ms =3D 100;
> > +
> > +       if (!configured) {
> > +               git_config_get_int("core.fileslocktimeout", &timeout_ms=
);
> > +               configured =3D 1;
> > +       }
> > +
> > +       return timeout_ms;
> > +}
> > +
>
> > @@ -172,7 +174,7 @@ static inline int hold_lock_file_for_update(
> >                 struct lock_file *lk, const char *path,
> >                 int flags)
> >  {
> > -       return hold_lock_file_for_update_timeout(lk, path, flags, 0);
> > +       return hold_lock_file_for_update_timeout(lk, path, flags, get_f=
iles_lock_timeout_ms() );
> >  }
>
> This looks like it changes the default from 0 ("try exactly once") to
> 100ms. Maybe we should stick with 0 for those who don't jump onto this
> new config knob?
>
> Martin
