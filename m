Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.1 (2015-04-28) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-3.8 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,RCVD_IN_DNSWL_HI
	shortcircuit=no autolearn=ham autolearn_force=no version=3.4.1
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id E3D581F453
	for <e@80x24.org>; Fri, 26 Oct 2018 05:07:00 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726295AbeJZNm0 (ORCPT <rfc822;e@80x24.org>);
        Fri, 26 Oct 2018 09:42:26 -0400
Received: from mail-lj1-f194.google.com ([209.85.208.194]:45012 "EHLO
        mail-lj1-f194.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726177AbeJZNmZ (ORCPT <rfc822;git@vger.kernel.org>);
        Fri, 26 Oct 2018 09:42:25 -0400
Received: by mail-lj1-f194.google.com with SMTP id v6-v6so10316329ljc.11
        for <git@vger.kernel.org>; Thu, 25 Oct 2018 22:06:56 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=fy57s67wyFFJ6J8ZpgUnpv6nxNtcKn2NUZckS9i32Xs=;
        b=Uqm1o+iF4EdmreJfkPnQputKg4BYn79C2SqtbCuDB4ebFmXuQm+pACm95MrJZ1ajt1
         aV19T6s9CBnY8/EUPylhai6ph+S4JsxOFVcZejbwbA6D85gIwZOneSnrZQYd8Rfu6D2G
         kdTGISfmrNl1v7o4xNKjxGLQ7eW+1yqijdUzYuI/2MBg6iUYuJv6UJagUxAE7i+Wl5hW
         4hqGDqs8YIddJF+BuwP09QMqwPLaJSA/xbzNPP/ozXWSiLRUajRfJIg8MmO/bSjo42fE
         c/Lvl4UabgmDgodGOgMhgbqk6Cd97R+2OGWLviUThvzPgN7/yTS3pzKHU/Ec/p3c1hmT
         jhAA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=fy57s67wyFFJ6J8ZpgUnpv6nxNtcKn2NUZckS9i32Xs=;
        b=kFSmOtlMhNbPuouqE8S60sca8CZekUVvZBsH2N4D7Fh5NGhwjZnebqte2V00BEJi9p
         qrlcPyx2vSuOImrnxMYBeQCyIRewOjYBlflNLMcZcU2dUV1q7E1I+OHN4IcRHnNjTV+A
         tZYJgNTKRfiVaYfs7YXqie4P3pWqgTNaDQscwE+JxgTAq1MFx6ah09VFbswPTtwX3MVk
         wWtyr+vM0cL77TgfjGHHprpNyLV9TQjh2l8C72bl9GzRFxLJYNewJzvNfqEQOt2cUO7z
         y2CGhgiJjAcL2SictBhILC4QucENggIFdYZWauVYYhw+sYABRbTUO35l/NBCw76pfrzi
         VgDw==
X-Gm-Message-State: AGRZ1gImRQ7gtXWf9sIf1igYgdTICP/KpQmHCtuYaoWt+FASbVESTQu4
        96JN5mcm1C2fT44faODX1RX2N0oiL0y6C9KkPq4=
X-Google-Smtp-Source: AJdET5cEUVdwhKScHF82SAQkf3O6DgLzxPIhgruiXq4SKQUbRMtOL1ttpxMXHc8+dYtQgrOYzjqOGMEQ8qCgYv+hVas=
X-Received: by 2002:a2e:4811:: with SMTP id v17-v6mr1208207lja.151.1540530415082;
 Thu, 25 Oct 2018 22:06:55 -0700 (PDT)
MIME-Version: 1.0
References: <CA+xP2SYtBGoxyV+hfjvYeEVU6XuvoZubC+-ffdubRgee=JtWXA@mail.gmail.com>
 <xmqqo9bhfu0j.fsf@gitster-ct.c.googlers.com>
In-Reply-To: <xmqqo9bhfu0j.fsf@gitster-ct.c.googlers.com>
From:   Sebastian Staudt <koraktor@gmail.com>
Date:   Fri, 26 Oct 2018 07:06:18 +0200
Message-ID: <CA+xP2Sbm7YGU3tKMNEzrvZfOQScgE2-ap1GVCXcjLH5botr4ug@mail.gmail.com>
Subject: Re: [PATCH] travis-ci: no longer use containers
To:     gitster@pobox.com
Cc:     larsxschneider@gmail.com, szeder.dev@gmail.com, git@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Junio C Hamano <gitster@pobox.com> writes:
>
> Sebastian Staudt <koraktor@gmail.com> writes:
>
> > Travis CI will soon deprecate the container-based infrastructure
> > enabled by `sudo: false` in ce59dffb34190e780be2fa9f449f842cadee9753.
> >
> > More info:
> > https://blog.travis-ci.com/2018-10-04-combining-linux-infrastructures
>
> Thanks for posting a patch that would serve as a good discussion
> starter.  This is not a criticism on your patch, but more is a RFD
> to those who helped our use of Travis by contributing to .travis.yml
> and ci/.

In fact this was the intention while creating this patch. Although I see
I could have made this a bit clearer in the initial message.

Having a patch that may cause a broken build or other CI problems
seems more appropriate than waiting for Travis CI to flip the switch
and searching for the problem afterwards.

> Don't we need to do some other things so that we can run in vm
> environment, rather than in container environment, before doing this
> change?  IOW, aren't we doing in .travis.yml something we can do
> only in container but not in vm (if there is any), and if so,
> shouldn't we be rewriting that something so that we can run in vm?
>
> I know ce59dffb ("travis-ci: explicity use container-based
> infrastructure", 2016-01-26) only added "sudo: false" without doing
> anything else (e.g. adding things that are only available to those
> who run in container), but if we added stuff that are not usable in
> vm environment after that commit since then, we need to adjust them
> so that we can migrate to the container-based environment, no?
>
> To me, removing that "sudo: false" line seems like the least thing
> we need to worry about.  After all, they say that whether we have
> "sudo: false" or not, the CI jobs will start running in vm
> environment and not in container.  So if the rest of .travis.yml is
> ready to run in vm environment, we do not have to do anything ;-).
>
> In short, my question to Lars and SZEDER is, are we already prepared
> to be thrown into a vm environment?
>
> If the answer is "yes", then I think removing "sudo: false" is
> probably still a good thing to do for documentation purposes
> (i.e. showing that we knew we are ready to go through their
> migration).
>
> Thanks.
>
> > Signed-off-by: Sebastian Staudt <koraktor@gmail.com>
> > ---
> >  .travis.yml | 2 --
> >  1 file changed, 2 deletions(-)
> >
> > diff --git a/.travis.yml b/.travis.yml
> > index 4d4e26c9df..8d2499739e 100644
> > --- a/.travis.yml
> > +++ b/.travis.yml
> > @@ -1,7 +1,5 @@
> >  language: c
> >
> > -sudo: false
> > -
> >  cache:
> >    directories:
> >      - $HOME/travis-cache
> > --
> > 2.19.1
