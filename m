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
	by dcvr.yhbt.net (Postfix) with ESMTP id 2BF9C1F462
	for <e@80x24.org>; Sun, 26 May 2019 07:48:41 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727185AbfEZHsk (ORCPT <rfc822;e@80x24.org>);
        Sun, 26 May 2019 03:48:40 -0400
Received: from mail-ed1-f66.google.com ([209.85.208.66]:37175 "EHLO
        mail-ed1-f66.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726751AbfEZHsk (ORCPT <rfc822;git@vger.kernel.org>);
        Sun, 26 May 2019 03:48:40 -0400
Received: by mail-ed1-f66.google.com with SMTP id w37so21406793edw.4
        for <git@vger.kernel.org>; Sun, 26 May 2019 00:48:38 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=OT8Uzun/FFLozubt2dRV81FC7EIbwDaybleXHKocbeI=;
        b=dFXXRqQ2s/KqgMbYoAptR6slGtWf4ZFhwe+cGcMfaJwWVL5T0Gch1kGb35T549wlE2
         6Okf14egEOoVZoWzNPRS48gieMTPWlpNC4Jk9/Dv9xUr0PDKqiNwAEXaqga//ltSt5BL
         9wFImSfj2P6BkMpWKCCorm0nfo380TtqWnfeTfRRL1fvEeiXf+5loMEsOhJCclLL0sgO
         eJvG5lb+gvKBYLzxWZuG4pK26YxBobKgStm6nRLrXo4I3DaXzQwGQfcH0ZQ4ze6Lj+Fd
         FB4xsNWulQS4Bu32QVZKetJBx7YSvSHu2u+rS/F1fbyj9yYZ/kOGdJPA/bROXy4hqEG/
         300w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=OT8Uzun/FFLozubt2dRV81FC7EIbwDaybleXHKocbeI=;
        b=XIwAasNNW/6l/tGJQBq6PHlc/PKd1xeKyZ9isFtPRtOR2CxBYInni3JyrEpY1KGzZt
         8hhhwldA9uJP0xLAW2LvlzRjpB40BYNeEmNXy+4CRUxBudvYLsRR3AAMsFRXmLMXY8uP
         fnWhjxEtA6CkWmVTkMMrl5z9WxHRRnng75jlGTsZVsQEkR+tg22Xo+uR/ELmWawMJ+9e
         B8MHB9gRJFvxlvXh8VN59R5VazwKRPbWlyAkFWeXkfgmT97pZjASiTWJ9woW2PmMkVvL
         Pv+7BgwYLT8IP+8z08r6+46YsZP4ar23CBtATfXNaKZ7dm3iBSwt/DSiBo7k9ItMTilp
         e4OA==
X-Gm-Message-State: APjAAAW+kaPgdqdOaFenOiz/yVOa7IFpsZsd+xHaK+nkPf1ij6LDOhI9
        Arkb2t5uxoutTVrVs3WAqIGuI3UK/6S0si2RL4w=
X-Google-Smtp-Source: APXvYqwc5hn6P0Kia9uzcjgA2ocfLqVDfqEs6z0FMGvtTcOpF3CJPPLvz05ci9AW94gMzYarg9wG/CDfyBMQZGfv0HE=
X-Received: by 2002:a17:906:8496:: with SMTP id m22mr42208352ejx.281.1558856918024;
 Sun, 26 May 2019 00:48:38 -0700 (PDT)
MIME-Version: 1.0
References: <20190517190359.21676-1-emilyshaffer@google.com> <20190517190701.49722-2-emilyshaffer@google.com>
In-Reply-To: <20190517190701.49722-2-emilyshaffer@google.com>
From:   Christian Couder <christian.couder@gmail.com>
Date:   Sun, 26 May 2019 09:48:26 +0200
Message-ID: <CAP8UFD2YH50Br4BNmTqEVeUknxi1X39JCRB4XMwK8rx3DWx=KA@mail.gmail.com>
Subject: Re: [PATCH v6 1/2] documentation: add tutorial for first contribution
To:     Emily Shaffer <emilyshaffer@google.com>
Cc:     git <git@vger.kernel.org>,
        Johannes Schindelin <johannes.schindelin@gmx.de>,
        Jonathan Tan <jonathantanmy@google.com>
Content-Type: text/plain; charset="UTF-8"
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

On Fri, May 17, 2019 at 11:48 PM Emily Shaffer <emilyshaffer@google.com> wrote:
>
> This tutorial covers how to add a new command to Git and, in the
> process, everything from cloning git/git to getting reviewed on the
> mailing list. It's meant for new contributors to go through
> interactively, learning the techniques generally used by the git/git
> development community.

Very nice, thanks! I tried it and I liked it very much.

I noted a few nits that might help improve it a bit.

> +----
> +$ git clone https://github.com/git/git git

Nit: maybe add "$ cd git" after that.

> +Check it out! You've got a command! Nice work! Let's commit this.
> +
> +----
> +$ git add Makefile builtin.h builtin/psuh.c git.c
> +$ git commit -s
> +----

Nit: when building a "git-psuh" binary is created at the root of the
repo which will pollute the `git status` output. The usual way we deal
with that is by adding "/git-psuh" to the ".gitignore" at the root of
the repo.

> +=== Implementation
> +
> +It's probably useful to do at least something besides printing out a string.
> +Let's start by having a look at everything we get.
> +
> +Modify your `cmd_psuh` implementation to dump the args you're passed:

Nit: maybe it could be a bit more clear that the previous printf()
call should be kept as is, otherwise the test added later will fail.

> +----
> +       const char *cfg_name;
> +
> +...
> +
> +       git_config(git_default_config, NULL)

Nit: a ";" is missing at the end of the above line.

> +Let's commit this as well.
> +
> +----
> +$ git commit -sm "psuh: print the current branch"

Nit: maybe add "builtin/psuh.c" at the end of the above line, so that
a `git add builtin/psuh.c` is not needed.

> +....
> +git-psuh(1)
> +===========
> +
> +NAME
> +----
> +git-psuh - Delight users' typo with a shy horse
> +
> +
> +SYNOPSIS
> +--------
> +[verse]
> +'git-psuh'
> +
> +DESCRIPTION
> +-----------
> +...
> +
> +OPTIONS[[OPTIONS]]
> +------------------
> +...
> +
> +OUTPUT
> +------
> +...
> +
> +

Nit: it seems that the above newline could be removed.

Thanks,
Christian.
