Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-5.0 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_HI,
	RCVD_IN_SORBS_SPAM,RP_MATCHES_RCVD shortcircuit=no autolearn=ham
	autolearn_force=no version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id B753B207EC
	for <e@80x24.org>; Mon, 10 Oct 2016 05:45:12 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1751947AbcJJFpK (ORCPT <rfc822;e@80x24.org>);
        Mon, 10 Oct 2016 01:45:10 -0400
Received: from mail-qk0-f181.google.com ([209.85.220.181]:35596 "EHLO
        mail-qk0-f181.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1751263AbcJJFpJ (ORCPT <rfc822;git@vger.kernel.org>);
        Mon, 10 Oct 2016 01:45:09 -0400
Received: by mail-qk0-f181.google.com with SMTP id z190so78433490qkc.2
        for <git@vger.kernel.org>; Sun, 09 Oct 2016 22:45:09 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20120113;
        h=mime-version:in-reply-to:references:from:date:message-id:subject:to
         :cc;
        bh=/mi7TpWUWwogFxxk5N9+gsj3z71O8DZdC6lFpSPzkl4=;
        b=lLIBneVpQimfYg4KdJeKtej9jpJcD9N+3FARalsPXkJ5yJ/ZBgY/Enybz7JfVQ45EI
         r63QmtsgtqhIwa4M04/p2hptBr37b/hIvEpYZDCXK8nsymjpv/vYpvH3Pwne+BcfTg7N
         q7O7ZryfnorMjJUSYS2FRyt49do3bOv0tlByZ5/XtWY7M7WrGpIOJl0yGR6YbxtoJhGJ
         ZB4iHAUBM6vg5MNlc/DJeUNvJacTFRgk08Vk0jGnoOPfDhQv4FIth0KOtldycVo3Wfnl
         4HLddzE6exhH6hBZT+5vi2GJtCaBtUJM7MI2xF3f+n36xYvyki3AoTK/i9dw+pkrY5W5
         jjRQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20130820;
        h=x-gm-message-state:mime-version:in-reply-to:references:from:date
         :message-id:subject:to:cc;
        bh=/mi7TpWUWwogFxxk5N9+gsj3z71O8DZdC6lFpSPzkl4=;
        b=EaKlxJtCRSmnN4CGzLYMaY6YlN+Kd5dSv7DIizzQCIweNes28l/uT+R1YTCixcExRZ
         u3zMOhkzt4gF7jxuYs5tO3nZ3kOJQl+lgxCcAHyjKrzPu751+u9aTstA9+zCUqRQJHiY
         HYS/SZpTu0M42lxq8Q9q1kVGDHJ1kXHvqleJQo3J/TiTbR7Crip54w9IDNCUtY6uGf0/
         Z0M0DgO+PI4bBbcTvbqPmsfzjgc2HMwFwQEHQdLl+pe6bLT7WC//aYfxRlBnJRkmQZoI
         ZP8NoCXjkq5XpSGHcPuMy+wo7xFdqWzb8awtobV/pwm7/xPc3ILjOQFmMHDt5EF+aT7O
         Jy8A==
X-Gm-Message-State: AA6/9Rnvz1LpxWgCgxR+czuXabrfB5nuWE7lmOXhPyVgMD/MH90RVN1A5+Tl+4tu6L9GHPPbqpKkBIMmbQIsu/w1
X-Received: by 10.55.45.193 with SMTP id t184mr26179547qkh.58.1476078308620;
 Sun, 09 Oct 2016 22:45:08 -0700 (PDT)
MIME-Version: 1.0
Received: by 10.12.135.40 with HTTP; Sun, 9 Oct 2016 22:45:08 -0700 (PDT)
In-Reply-To: <1476046602.26041.3.camel@kaarsemaker.net>
References: <CAL4SumgJbrirymt5+iyNbpo++xXfzJZRiHDm8=0+eCArpCX=DA@mail.gmail.com>
 <1476035501.26041.1.camel@kaarsemaker.net> <CAL4Sumj7r-RNXBi2Oh_=KAkcksM13sJjLzJEpszWXPXZ8hP6Kw@mail.gmail.com>
 <1476046602.26041.3.camel@kaarsemaker.net>
From:   Stefan Beller <sbeller@google.com>
Date:   Sun, 9 Oct 2016 22:45:08 -0700
Message-ID: <CAGZ79kYVr9NwAQzMb8Gxo9CO8PDpzPBX1PUka4BCDugFeQm7Fw@mail.gmail.com>
Subject: Re: Problem with submodules
To:     Dennis Kaarsemaker <dennis@kaarsemaker.net>,
        "git@vger.kernel.org" <git@vger.kernel.org>
Cc:     "venv21@gmail.com" <venv21@gmail.com>
Content-Type: text/plain; charset=UTF-8
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Adding the list back on.

On Sun, Oct 9, 2016 at 1:56 PM, Dennis Kaarsemaker
<dennis@kaarsemaker.net> wrote:
> On Sun, 2016-10-09 at 21:15 +0200, venv21@gmail.com wrote:
>> Sure, http://pastebin.com/bUFBDj0Q
>
> So you actually cloned from a path ending in epihany/, not epiphany.
> Turns out the trainling slash matters when using relative urls for
> submodules:
>
> $ cat test.sh
> url=http://remote.example/repo
>
> for url in $url "$url/"; do
>     echo "Remote: $url"
>     rm -rf main
>     git init -q main
>     (
>         cd main
>         git remote add origin $url
>         git init -q sub
>         git -C sub commit --allow-empty -mtest
>         printf '[submodule "sub"]\n\tpath = sub\n\t\turl = ../sub\n' > .gitmodules
>         git add sub .gitmodules
>         git commit -mtest
>         git submodule init
>     ) >/dev/null
> done
>
> $ sh test.sh
> Remote: http://remote.example/repo
> Submodule 'sub' (http://remote.example/sub) registered for path 'sub'
> Remote: http://remote.example/repo/
> Submodule 'sub' (http://remote.example/repo/sub) registered for path 'sub'
>
> I don't know whether this is a bug or a feature. I find using relative
> paths for submodules a pretty dodgy idea anyway and would fix up the
> .gitmodules file.

I disagree here, IMHO relative path/urls are better than absolute URLs as
it allows to hand over a project to a different organisation that wants to have
its own fork including submodule changes just easily (no need to muck around
the submodule config, "it just works" ;)

>
> Stefan, is it possible that this is a regression in the C rewrite?

Totally possible!

Thanks for the regression test, I'll dive into the code tomorrow.

Thanks,
Stefan

>
> D.
>
