Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.1 (2015-04-28) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-3.4 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,RCVD_IN_DNSWL_HI
	shortcircuit=no autolearn=ham autolearn_force=no version=3.4.1
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id DE5131F403
	for <e@80x24.org>; Tue, 12 Jun 2018 09:48:39 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1754301AbeFLJsh (ORCPT <rfc822;e@80x24.org>);
        Tue, 12 Jun 2018 05:48:37 -0400
Received: from mail-vk0-f65.google.com ([209.85.213.65]:39382 "EHLO
        mail-vk0-f65.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1754286AbeFLJsg (ORCPT <rfc822;git@vger.kernel.org>);
        Tue, 12 Jun 2018 05:48:36 -0400
Received: by mail-vk0-f65.google.com with SMTP id r83-v6so8706199vkf.6
        for <git@vger.kernel.org>; Tue, 12 Jun 2018 02:48:36 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=mime-version:in-reply-to:references:from:date:message-id:subject:to
         :cc:content-transfer-encoding;
        bh=Qrh322jmxVzEO+tmaoGOMVVd9FzpXDqeS7izma9LYhg=;
        b=Reddw2rVyLuKyA87Rc+s0pMhf7OTrN18IFNjxywI35y2JjcXXJW9ZuylWxmwlU4hfV
         lGkJlZ994X3vEW0iFA5kBs+SRVeT8w3UY7DQviySHvPnRoi4iJlGMu5OaOtjPdPV0tBF
         z8CnhCJsgkvWEcDTfpKPFIjfWFlOFhTlG0EKG0/1UvEUIOrUYnK2MrENa3iiXsBgL3CM
         3K8kOxEt3xQw5Y1O+fZATjy6VGoITYQdvjXcMwRK1VRDW4W7O5KAQ1X428B+oRaZNUhv
         Efp5GfS0SjNDL8532hWjTOQUeEpAIiOMpWCD5NCUnwv/CSUQ4gubs2fV86rHCuu/lsMB
         ghMA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:in-reply-to:references:from:date
         :message-id:subject:to:cc:content-transfer-encoding;
        bh=Qrh322jmxVzEO+tmaoGOMVVd9FzpXDqeS7izma9LYhg=;
        b=WcSaWvQUV3vYFtAefKlkVMRRjCJRRec6WMl1Dm0yJcoHiUG4Z+0W0xn0uGZpZeT6mt
         s7RM9j3ceKFKgyH1d87mRFzy/KcuMjZsy4Xxeal7Bz5CfQoBwRb92oU7nRrCTeFAe0yx
         RgQxfNKR3UbTvEMFEZ8X4nvTyNMEE6YbX6Mor/kHrmFvBFW7Wpm3p49IylS9vTSEi/DC
         AbQWqZCZV2h2vx/b2YMKu89lX3SYeILzzQ46S1Uu0lw48rOgFf9VIZnokquTR3IqxyJs
         jpsCIu58t6PKsT7PGVOvTrUnE5PxDja0I3pzXGa29bfmdHPNeCv3KKstDEuBvTgTQqnD
         42oQ==
X-Gm-Message-State: APt69E0uRAtL0lOSmlT1wt8JxMSOQ5Yt37rdD1szFZgbz6GBi4yDm3Hi
        55XhDBLTYqZKyuIJ9Jgs8wNTxyMoo/+KZpx934U=
X-Google-Smtp-Source: ADUXVKLvhkoJXuRTYp8IGFB5Fyy3e8XUo6T1GpzGpzkdkb9g/ZVhITXgA7CCTqfjhVYcSkt+EAy8sPG8QY5K+F/mCbg=
X-Received: by 2002:a1f:4313:: with SMTP id q19-v6mr1586370vka.83.1528796916053;
 Tue, 12 Jun 2018 02:48:36 -0700 (PDT)
MIME-Version: 1.0
Received: by 2002:ab0:3105:0:0:0:0:0 with HTTP; Tue, 12 Jun 2018 02:48:35
 -0700 (PDT)
In-Reply-To: <20180611182053.GA20665@aiede.svl.corp.google.com>
References: <xmqqmuy2wz4j.fsf@gitster-ct.c.googlers.com> <20180417220219.30445-1-szeder.dev@gmail.com>
 <20180607054834.GB6567@aiede.svl.corp.google.com> <20180608211639.7611-1-szeder.dev@gmail.com>
 <20180611182053.GA20665@aiede.svl.corp.google.com>
From:   =?UTF-8?Q?SZEDER_G=C3=A1bor?= <szeder.dev@gmail.com>
Date:   Tue, 12 Jun 2018 11:48:35 +0200
Message-ID: <CAM0VKjm7Nap_tH-0Nd_QxabEPDL=71sVifo8cqhjMkqZOERJTA@mail.gmail.com>
Subject: Re: [PATCH] completion: correct zsh detection when run from
 git-completion.zsh (Re: [PATCH v2] completion: reduce overhead of clearing
 cached --options)
To:     Jonathan Nieder <jrnieder@gmail.com>
Cc:     Junio C Hamano <gitster@pobox.com>,
        Matthew Coleman <matt@1eanda.com>,
        Stephon Harris <theonestep4@gmail.com>,
        Duy Nguyen <pclouds@gmail.com>,
        =?UTF-8?Q?Jakub_Nar=C4=99bski?= <jnareb@gmail.com>,
        Git mailing list <git@vger.kernel.org>,
        Rick van Hattem <wolph@wol.ph>,
        Dave Borowitz <dborowitz@google.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

On Mon, Jun 11, 2018 at 8:20 PM, Jonathan Nieder <jrnieder@gmail.com> wrote=
:
> From: SZEDER G=C3=A1bor <szeder.dev@gmail.com>
> Subject: completion: correct zsh detection when run from git-completion.z=
sh
>
> v2.18.0-rc0~90^2 (completion: reduce overhead of clearing cached
> --options, 2018-04-18) worked around a bug in bash's "set" builtin on
> MacOS by using compgen instead.  It was careful to avoid breaking zsh
> by guarding this workaround with
>
>         if [[ -n ${ZSH_VERSION-}} ]]
>
> Alas, this interacts poorly with git-completion.zsh's bash emulation:
>
>         ZSH_VERSION=3D'' . "$script"
>
> Correct it by instead using a new GIT_SOURCING_ZSH_COMPLETION shell
> variable to detect whether git-completion.bash is being sourced from
> git-completion.zsh.  This way, the zsh variant is used both when run
> from zsh directly and when run via git-completion.zsh.
>
> Reproduction recipe:
>
>  1. cd git/contrib/completion && cp git-completion.zsh _git
>  2. Put the following in a new ~/.zshrc file:
>
>         autoload -U compinit; compinit
>         autoload -U bashcompinit; bashcompinit
>         fpath=3D(~/src/git/contrib/completion $fpath)
>
>  3. Open zsh and "git <TAB>".
>
> With this patch:
> Triggers nice git-completion.bash based tab completion
>
> Without:
>  contrib/completion/git-completion.bash:354: read-only variable: QISUFFIX
>  zsh:12: command not found: ___main
>  zsh:15: _default: function definition file not found
>  _dispatch:70: bad math expression: operand expected at `/usr/bin/g...'
>  Segmentation fault

Btw, even if ZSH were not to segfault, the resulting shell would be
next to useless.  The thing is that 'compgen -v foo' is supposed to
list only variable names starting with 'foo', at least that's what it
does under Bash.  In ZSH's Bash emulation, however, it lists _all_
variable names, including such fundamental env vars like PATH, HOME,
and IFS.  So when ZSH took the wrong if branch and run that

  unset $(compgen -v __gitcomp_builtin_)

then it would unset PATH and everything else as well.
