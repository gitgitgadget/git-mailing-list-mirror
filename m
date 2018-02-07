Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-2.8 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_HI,T_RP_MATCHES_RCVD
	shortcircuit=no autolearn=no autolearn_force=no version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 3EBF11F576
	for <e@80x24.org>; Wed,  7 Feb 2018 11:37:38 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1753848AbeBGLhg (ORCPT <rfc822;e@80x24.org>);
        Wed, 7 Feb 2018 06:37:36 -0500
Received: from mail-wm0-f53.google.com ([74.125.82.53]:34859 "EHLO
        mail-wm0-f53.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1753736AbeBGLhf (ORCPT <rfc822;git@vger.kernel.org>);
        Wed, 7 Feb 2018 06:37:35 -0500
Received: by mail-wm0-f53.google.com with SMTP id r78so2732286wme.0
        for <git@vger.kernel.org>; Wed, 07 Feb 2018 03:37:34 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:references:user-agent:in-reply-to:date
         :message-id:mime-version;
        bh=HdVyRUeAAxHJbBU1XAhJLzZ2tx0ET8zWh94vAoSzuZM=;
        b=uSi2yfjIBtMYWCoroW76/7BfZLFT9TpOELiG74iLhxlvwM59LtQGwnI2S60v26VgKY
         7SAGwIIwguhalnbG19+KpQ20bD/GsTM7Vj8xlkbraJd8okXunOF25KGHpKN9IPXZEFbz
         ptwk/Lhr1/9S2cxUYcyutfZ1/ehtecemB2rOHA7SY6YJ3lwvnNsBHMqtWqfim3SUz6ke
         6liJfBHyvbZ7+iDCM4ZnV4xtpML7V2ULS6zK29Pu+brFkCM+NaJoew+0+l0b80j+YV6S
         MDjnd+8QwhL8z2EYfAJHTdoGnvGozvTi3jwSxxfav38g68ivXXwFYkzLc40N3q6zqw4u
         Mm/A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:references:user-agent
         :in-reply-to:date:message-id:mime-version;
        bh=HdVyRUeAAxHJbBU1XAhJLzZ2tx0ET8zWh94vAoSzuZM=;
        b=F2NJwd+ih799vf+7WcTEUlTCH+hR44Emku9nm0EGH8fnZAbuceXJFuzZDwLg2l27/G
         6JPmL39h4ULoDMqXxBJapukEu7c81AnrOQqxEuAWbr3l1zosI9vWxmWBas1ePrI3nJ6q
         QdFfTHO5fVsPCGCAvbwT+fPHkKiLne3tqc+O0IPL92LsoJkrRy6PEkkOZhxdzq4q/z8G
         bB2RiTPFOpN0I1yLw2pOHVBONuLFlNIOy2DEPj42qSB7Arm+0RVf+WAQ2rAaif0L8kF7
         m6L+35sE0eSD+soh/2zhHtRW9dlDbFP/193y2Mn2l75UzGOmLATTRc4NiQqtpd/Fd9u2
         ldZg==
X-Gm-Message-State: APf1xPDbceUfCEsJk0JLVaxvqt6mLrz3dI5pIk6TzGo7q4SMGKdui//X
        jCRP+ENh5xhiyTJ9lfNeKBo6CeO9
X-Google-Smtp-Source: AH8x226VyJSJh4tCUs74cE8i0+Ec9bLn1DVwsj6Xt66Eg196XZqqhxjV7gFpxuGtMy06go2IggT2Pg==
X-Received: by 10.80.208.2 with SMTP id j2mr7874315edf.134.1518003454198;
        Wed, 07 Feb 2018 03:37:34 -0800 (PST)
Received: from evledraar (proxy-gw-a.booking.com. [5.57.21.8])
        by smtp.gmail.com with ESMTPSA id h56sm1189257ede.5.2018.02.07.03.37.33
        (version=TLS1_2 cipher=ECDHE-RSA-CHACHA20-POLY1305 bits=256/256);
        Wed, 07 Feb 2018 03:37:33 -0800 (PST)
From:   =?utf-8?B?w4Z2YXIgQXJuZmrDtnLDsA==?= Bjarmason <avarab@gmail.com>
To:     "Robert P. J. Day" <rpjday@crashcourse.ca>
Cc:     Git Mailing list <git@vger.kernel.org>,
        Avery Pennarun <apenwarr@gmail.com>
Subject: Re: is http://git-scm.com an *official* git-affiliated site?
References: <alpine.LFD.2.21.1802070547040.5530@android-a172fe96dd584b41>
User-agent: Debian GNU/Linux 9.3 (stretch); Emacs 25.1.1; mu4e 1.0-alpha3
In-reply-to: <alpine.LFD.2.21.1802070547040.5530@android-a172fe96dd584b41>
Date:   Wed, 07 Feb 2018 12:37:32 +0100
Message-ID: <87eflxyqrn.fsf@evledraar.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org


On Wed, Feb 07 2018, Robert P. J. Day jotted:

>   i ask WRT whether it should be up to date. i'm currently writing a
> number of git-related wiki pages, and i want to link to whatever are
> the canonical man pages for various git commands, but that site seems
> a bit off.
>
>   if one follows a link to get here:
>
> https://git-scm.com/doc
>
> there is another link to the "Reference Manual" that promises "The
> official and comprehensive man pages that are included in the Git
> package itself."
>
>   but upon getting there:
>
> https://git-scm.com/docs
>
> it seems clear that that page doesn't come close to covering all of
> the available git commands.
>
>   as an example, there is a link "submodule" on that page, which does
> indeed take one to the page https://git-scm.com/docs/git-submodule. so
> far, so good.
>
>   however, while there is no link for the "worktree" command, there
> does in fact exist a similarly-named web page
> https://git-scm.com/docs/git-worktree.

It is an official site, of the git project. The project is legally
managed by the SFC which owns the domain, Github happens to host it (for
free) for us.

It's not fully auto-generated so stuff like git-worktree doesn't get
added automatically, I just added a PR for that:
https://github.com/git/git-scm.com/pull/1133

>   finally, there is no reference to the git "subtree" command, either
> as a link *or* as an existing web page
> https://git-scm.com/docs/git-subtree. it all seems kind of arbitrary.

Unlike git-worktree, git-subtree is not shipped as a "proper" git
command, it lives in contrib/. What the status of that is I'm not sure,
but that's why it's not on git-scm or kernel.org in any form.

>   is there an actual, canonical set of online web pages for all
> current git commands one should use?

You can use git-scm.com or the kernel.org link Duy noted.

The thing that's the most official is the man pages we ship with any
given release, and as seen above the online presence may lag behind in
some ways, but that can always be fixed.

Even though we may have some official online sources, it's better to
direct users to the documentation that ships with git on their system,
since it'll reflect the version they're using.
