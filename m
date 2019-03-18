Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.2 (2018-09-13) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-4.0 required=3.0 tests=AWL,BAYES_00,DKIM_INVALID,
	DKIM_SIGNED,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,
	RCVD_IN_DNSWL_HI shortcircuit=no autolearn=ham autolearn_force=no
	version=3.4.2
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id A6E7920248
	for <e@80x24.org>; Mon, 18 Mar 2019 05:42:36 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1725967AbfCRFmf (ORCPT <rfc822;e@80x24.org>);
        Mon, 18 Mar 2019 01:42:35 -0400
Received: from mail-wm1-f67.google.com ([209.85.128.67]:36620 "EHLO
        mail-wm1-f67.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725896AbfCRFmf (ORCPT <rfc822;git@vger.kernel.org>);
        Mon, 18 Mar 2019 01:42:35 -0400
Received: by mail-wm1-f67.google.com with SMTP id h18so2894622wml.1
        for <git@vger.kernel.org>; Sun, 17 Mar 2019 22:42:34 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=sender:from:to:cc:subject:references:date:in-reply-to:message-id
         :user-agent:mime-version;
        bh=zbjDf22fsCRZoZ+7Efi/ufSPiAKeiyIGGl/BYA35FvY=;
        b=Ilyn5/xH98rLZLvg2nj8u6oHI6B0sEecNVCCwUL5tq9c7YJM/jtM6z7TIbYlkUZyX6
         Q8SYV743KmaU7jtTmOHOM+ABHChgUV7ywZ5boZbjyy8hkrBUkpIxkP7Ebvi/+goJ/xkq
         zTsenJGB35ZgNB6GbrzEUuoRO5EywTmzXW2JTWhV06UpVnL3M13cZeah6faki0r0rt8o
         azfocFouhnz1cAxju1F1bmCuZnaMpfEB9ym7Fx/cS480WbMVAlHAzCsIh6TcYHq99Q3f
         g2dfVlvi7SljW8clFwyEd3BeD2mzFN/2kebKIOvw8MicBrw7fkf1ELPaNx4fmzQ2B5+N
         C2Qg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:sender:from:to:cc:subject:references:date
         :in-reply-to:message-id:user-agent:mime-version;
        bh=zbjDf22fsCRZoZ+7Efi/ufSPiAKeiyIGGl/BYA35FvY=;
        b=KWIO5qxCXomm5WKF/BTKfHg/M0DKhGdf4SNTZhiDmzAoR66yaWJ34zOAHnjzE02jR6
         Io1n2fQfN6nASE/TVNInBhc7/nnfFv0AjbN1J1iB09KsiFChqTypwSpYrtDGD1lrP3Lv
         FVeBKxYvvkZFABUv/abWrJ2OZrIobybVWW2JuJvxv4I09Lg1PjFOR0Y/xBaixa+sUEkS
         ZGeQm4a/D54Bxzjol4kV2g1HDzoGWIvjLGA/4HOX3c4Xn2xMdY/fCvGvaRYjNtCmgZSC
         hFFh9UrH0Po9FxfpLM0PeOWGnzDzzfNwL7AbpIv7Rg8V3cGp3BqHnrCZmFAczZMsTCIK
         s+Og==
X-Gm-Message-State: APjAAAUot2tN5vQJONAxYodjRZe7tPwOg76dFo12l+YtveXuwh8fe7ut
        f3O2Ei8no0BvelT+eTEmurk=
X-Google-Smtp-Source: APXvYqwhM3ZjBqxBoW6NVLH+LC/2efUptcSUycMEijNoQsTiF1p8OulezG2udu1pGBBUfLNyngPYcA==
X-Received: by 2002:a1c:e143:: with SMTP id y64mr5420600wmg.141.1552887753385;
        Sun, 17 Mar 2019 22:42:33 -0700 (PDT)
Received: from localhost (141.255.76.34.bc.googleusercontent.com. [34.76.255.141])
        by smtp.gmail.com with ESMTPSA id z20sm10460375wma.48.2019.03.17.22.42.32
        (version=TLS1_2 cipher=ECDHE-RSA-CHACHA20-POLY1305 bits=256/256);
        Sun, 17 Mar 2019 22:42:32 -0700 (PDT)
From:   Junio C Hamano <gitster@pobox.com>
To:     Alexander Blesius <alexander+git@blesius.eu>
Cc:     git@vger.kernel.org
Subject: Re: [PATCH] doc: fix typos in man pages
References: <6e00f5fc-13a3-a9b9-d964-f787ae194a73@blesius.eu>
Date:   Mon, 18 Mar 2019 14:42:32 +0900
In-Reply-To: <6e00f5fc-13a3-a9b9-d964-f787ae194a73@blesius.eu> (Alexander
        Blesius's message of "Sat, 16 Mar 2019 11:34:39 +0100")
Message-ID: <xmqqef744u2f.fsf@gitster-ct.c.googlers.com>
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/26.1 (gnu/linux)
MIME-Version: 1.0
Content-Type: text/plain
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Alexander Blesius <alexander+git@blesius.eu> writes:

> Signed-off-by: Alexander Blesius <alexander+git@blesius.eu>
> ---
>  Documentation/git-worktree.txt  | 4 ++--
>  Documentation/gitattributes.txt | 4 ++--
>  2 files changed, 4 insertions(+), 4 deletions(-)
>
> diff --git a/Documentation/git-worktree.txt b/Documentation/git-worktree.txt
> index cb86318f3e..fa5ec7a5dc 100644
> --- a/Documentation/git-worktree.txt
> +++ b/Documentation/git-worktree.txt
> @@ -213,8 +213,8 @@ refs of one working tree from another.
>   In general, all pseudo refs are per working tree and all refs starting
>  with "refs/" are shared. Pseudo refs are ones like HEAD which are
> -directly under GIT_DIR instead of inside GIT_DIR/refs. There are one
> -exception to this: refs inside refs/bisect and refs/worktree is not
> +directly under GIT_DIR instead of inside GIT_DIR/refs. There is one
> +exception to this: refs inside refs/bisect and refs/worktree are not
>  shared.

Perhaps bisect is one and worktree is the other, and that made them
two things (plural) in the author's mind.  But the single exception
is about these two hierarchies, so "is" is correct ;-)

>   Refs that are per working tree can still be accessed from another
> diff --git a/Documentation/gitattributes.txt
> b/Documentation/gitattributes.txt
> index 9b41f81c06..908d9a3009 100644
> --- a/Documentation/gitattributes.txt
> +++ b/Documentation/gitattributes.txt
> @@ -314,8 +314,8 @@ stored as UTF-8 internally. A client without
> `working-tree-encoding`
>  support will checkout `foo.ps1` as UTF-8 encoded file. This will
>  typically cause trouble for the users of this file.
>  +
> -If a Git client, that does not support the `working-tree-encoding`
> -attribute, adds a new file `bar.ps1`, then `bar.ps1` will be
> +If a Git client that does not support the `working-tree-encoding`
> +attribute adds a new file `bar.ps1`, then `bar.ps1` will be

Or s/that/which/.  I am not sure which one gives us a cleaner
result.

    If a new file `bar.ps1` is added by a Git client that does not
    understand `working-tree-encoding` attribute, then ...

is how I may write it, though.  I dunno.  Let's take yours at least
for now and let others complain if they care deeply about it.

>  stored "as-is" internally (in this example probably as UTF-16).
>  A client with `working-tree-encoding` support will interpret the
>  internal contents as UTF-8 and try to convert it to UTF-16 on checkout.

Thanks.

