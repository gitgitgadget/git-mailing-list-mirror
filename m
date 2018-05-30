Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-2.8 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	FROM_EXCESS_BASE64,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,
	RCVD_IN_DNSWL_HI shortcircuit=no autolearn=ham autolearn_force=no
	version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id AEF291F51C
	for <e@80x24.org>; Wed, 30 May 2018 11:14:32 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1752778AbeE3LOa (ORCPT <rfc822;e@80x24.org>);
        Wed, 30 May 2018 07:14:30 -0400
Received: from mail-wm0-f43.google.com ([74.125.82.43]:33516 "EHLO
        mail-wm0-f43.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1752625AbeE3LOI (ORCPT <rfc822;git@vger.kernel.org>);
        Wed, 30 May 2018 07:14:08 -0400
Received: by mail-wm0-f43.google.com with SMTP id x12-v6so1350745wmc.0
        for <git@vger.kernel.org>; Wed, 30 May 2018 04:14:08 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:references:user-agent:in-reply-to:date
         :message-id:mime-version;
        bh=vJqA5sfRc+Pe8+ir8pQkg97QIy1kFuP+HPiYV07YgbA=;
        b=XePm8LBXwUepGz4bRa8hA1l+bJulHvUcRzSFrLilrZ/t/bwtHC2Tw+/Jz7H3ICAUu5
         nqt0soxf5U5jR92G4bR6lB2u1MGunyrSuPXn0c/IUz+eNNSpd/G2/hkreM7XKqPUcobQ
         ppXmeWY7ZT109mnTO1VUjzNDZ9/UnOkX9XoNgExi9LnkompTbVnsHWvjrv3nAQGK9/ua
         asE9sM3ODfrzgwGiZ4/d62/Hom1kkkSn6PGmr3A4m1owya2+Y6tx/LH8yrBBhzZ5pHEN
         IITdKeoP9/r8uoV4Z4Kg2Z5uHpEYWFfSJ1xQ0kV1LN7/3tR4cIAHfH4iTbUhu+zvsqUH
         6Hog==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:references:user-agent
         :in-reply-to:date:message-id:mime-version;
        bh=vJqA5sfRc+Pe8+ir8pQkg97QIy1kFuP+HPiYV07YgbA=;
        b=CZyKBxlZizpA4CfUKCTBoyAsYGXspS0HZOLru9bCbVS9NQjep2bOTYeK0/g42eAByh
         nWWAOoSk18Ka7DQwC1/BwyO77mcqh1CUk3dV/gvXXFWtjgCQgwH4GCeYEspduzOZPKyS
         TFLIn7pMG9nLoKBnjshzN6sbuQAPaVHOKWPRnz3mydat32wCybzNnm0u4dlPUW33BSnz
         7infJYLg4D0ale0nX+Y+2mXeKQpsInU+47zXiJb60tuwy2u/UeM3I3A7PW+3u7NCPfHL
         5yXTcvo9DQUqxLHGmh6eb4d47047ZPOte7OTVwBAyCqlR3OvxVnPlbuw2yxdgI5bZ3Ob
         ElVQ==
X-Gm-Message-State: ALKqPwcT5FTuKoMu2cGlojdjjfvTnYfELs1zEbi73N+FMgiy9UZm5cod
        MAZWlzaxpNPzroWrP1uxgNY=
X-Google-Smtp-Source: ADUXVKIPLBtPfCzyDuzyGQPoaxtOlg2645MtKJ+49fc5opnFKd9oapSE6dcHBlrQgIB5/E2NdMYDRg==
X-Received: by 2002:a50:8463:: with SMTP id 90-v6mr2760157edp.308.1527678847428;
        Wed, 30 May 2018 04:14:07 -0700 (PDT)
Received: from evledraar (proxy-gw-a.booking.com. [5.57.21.8])
        by smtp.gmail.com with ESMTPSA id u8-v6sm20252169edj.2.2018.05.30.04.14.06
        (version=TLS1_2 cipher=ECDHE-RSA-CHACHA20-POLY1305 bits=256/256);
        Wed, 30 May 2018 04:14:06 -0700 (PDT)
From:   =?utf-8?B?w4Z2YXIgQXJuZmrDtnLDsA==?= Bjarmason <avarab@gmail.com>
To:     "Robert P. J. Day" <rpjday@crashcourse.ca>
Cc:     Git Mailing list <git@vger.kernel.org>
Subject: Re: some (fairly simple) questions about hooks
References: <alpine.LFD.2.21.1805300700190.7958@localhost.localdomain>
User-agent: Debian GNU/Linux testing (buster); Emacs 25.2.2; mu4e 1.1.0
In-reply-to: <alpine.LFD.2.21.1805300700190.7958@localhost.localdomain>
Date:   Wed, 30 May 2018 13:14:05 +0200
Message-ID: <877enlflaa.fsf@evledraar.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org


On Wed, May 30 2018, Robert P. J. Day wrote:

>   just want to clarify a few things about hooks to make sure i'm not
> missing anything when i write my own hooks tutorial.
>
>   first, for any hook to be active, it *must* be marked as executable
> -- that much seems clear from the man page.

Yes.

>   next, "core.hooksPath" aside, the hooks related to any repository
> are (by default) in $GIT_DIR/hooks and *only* in that directory. AIUI,
> there is no way to extend or enhance the per-repo hooks with, perhaps,
> a common subset of hooks in a common directory, is there? (i'm
> ignoring the possibility that one could populate $GIT_DIR/hooks with a
> few symlinks to share some common hooks among a number of repos --
> would that work? and is it something that is even considered good
> programming practice?)

Yes. There's git-native no way to have N number of the same type of
hooks. core.hooksPath is all or nothing.

See https://public-inbox.org/git/877eqqnq22.fsf@evledraar.gmail.com/ for
some musings of mine about potential future plans here & workarounds in
place in the wild, e.g. GitLab's support for N number of server-side
hooks.

You can also use e.g. the "pee" utility frome moreutils
(https://joeyh.name/code/moreutils/) to accomplish the same thing.

>   next, AIUI, the use of "core.hooksPath" *completely* overrides any
> hooks in $GIT_DIR/hooks, yes? that is, that config setting does not
> support any sort of enhancement of existing hooks, it's all or
> nothing, correct?

Yes.

>   and sticking with core.hooksPath, one could set it either globally
> to affect all repos, or one could of course set it locally to take
> advantage of it just for *some* repos, but not all of them.

Yes, this is not special to core.hooksPath but (almost) all config
variables (aside from stuff like per-remote config which can't be set
globally).

>   finally, if you run "git init" for an existing repo, as i read it,
> based on the templates content in effect, that will install new hooks
> in a repo but *only* hooks for which there is no existing equivalent
> -- it will *never* overwrite an existing hook by the same name.

Yes "git init" can re-initialize an existing repo, but will not clobber
existing stuff (or shouldn't).

>   oh, and related to that last paragraph, running "git init" related
> to hooks should be unaffected by core.hooksPath, is that correct? so
> that even if "git init" installs some new hooks in an existing repo,
> those new hooks will have no effect if core.hooksPath is set to refer
> somewhere else, yes?

Yes "git init" will just inject the hooks into .git/hooks, because it
doesn't care about hooks, it's just re-injecting stuff found in the
template dir, and the "hooks" dir is just one of the things that happens
to exist there.

>   am i missing any important features of hooks in the above?

Not that I can think of.
