Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.1 (2015-04-28) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-3.4 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,RCVD_IN_DNSWL_HI
	shortcircuit=no autolearn=ham autolearn_force=no version=3.4.1
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id A1D1C1F403
	for <e@80x24.org>; Tue, 12 Jun 2018 08:46:23 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1754287AbeFLIqU (ORCPT <rfc822;e@80x24.org>);
        Tue, 12 Jun 2018 04:46:20 -0400
Received: from mail-ua0-f176.google.com ([209.85.217.176]:42475 "EHLO
        mail-ua0-f176.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1754154AbeFLIqR (ORCPT <rfc822;git@vger.kernel.org>);
        Tue, 12 Jun 2018 04:46:17 -0400
Received: by mail-ua0-f176.google.com with SMTP id x18-v6so15433009uaj.9
        for <git@vger.kernel.org>; Tue, 12 Jun 2018 01:46:17 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=mime-version:in-reply-to:references:from:date:message-id:subject:to
         :cc:content-transfer-encoding;
        bh=Kw0JinBlkqywJjMWEv8lf2z9hMbsmDuYj6nrlfs0wY8=;
        b=BeZ1mdLsOt98jhIY4jKNXLYgPEgzHsThuqU2EpM9iH2yrCyfffnseigHwB6ozvKLKc
         fA699VV4H8P5i8n5mk3e7Ht9ignkTjvt4rGaO4Qlhq4GOyjyktf1ZBxaN9eVCQWiloM6
         +DewEVixe1MksCboc8NItHgU/+uB4gGQU0Sxm0oJEsVYKcyDHj2BNTxPb1FiJZHtEtso
         QlPMFuXwN3AFOoMbZAfiHeezWG/xlkvUvoBaNDp5PmUgzCrgC+oVNZgpsjeCImoV3dDo
         njZ9HsCZAjNFSDjMdH6JNjpah5q0a8wRgr8JCV38clLrT/E4CHaY7AUK+ZvIbg9esRAn
         FqBQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:in-reply-to:references:from:date
         :message-id:subject:to:cc:content-transfer-encoding;
        bh=Kw0JinBlkqywJjMWEv8lf2z9hMbsmDuYj6nrlfs0wY8=;
        b=QdNmSe+EZaOjpDxbKO8lAC3KKIDmyNZyTXJjayFPqaG9BuS7bt0DUfbI2M9Oj5mEgf
         PfWMhsresYA6ZfKkSbKN3cRckEUwOTFCZvbDbKer8C5q2AQPohpD8IoincvBEiW5BJFI
         08ZA9mH0j4kjS99XN7k5/sm9oUfTWwf24Zcdc7/+kSHFKJUu2ly/Xeml8YEsAJ4+A8IF
         0ROMRB3NgNguv8hYXtPLB9MIOZr7/LDoVjYMrf4k+nSIWyD4j+p8Rz90m2r0J/bIuPSl
         3O2EoICWMK0VCr0hnZy5LJ0nw+73YU4xMz4m9G312nuHD7hZqUztdHrYMfft/NOUCYz5
         3m/Q==
X-Gm-Message-State: APt69E2vpg6M5efrv0AbKRjkFbyOMIwfTSWAN83SYLvfsN9TtEFKRi9C
        61YZUomO6i/JfbVzVl9JWe6RoXgm8Ob6h2wEZLGpiw==
X-Google-Smtp-Source: ADUXVKKlpSm3Mf4IpLAtyO/Wm6ZDJ8jHpHf1NO2lxU5XPxuKkLbQnNOmpyYcIAuFm1mKpYvMA4Ax1kYR2E7hpdImRVw=
X-Received: by 2002:ab0:4c24:: with SMTP id l36-v6mr1699407uaf.27.1528793177039;
 Tue, 12 Jun 2018 01:46:17 -0700 (PDT)
MIME-Version: 1.0
Received: by 2002:ab0:3105:0:0:0:0:0 with HTTP; Tue, 12 Jun 2018 01:46:16
 -0700 (PDT)
In-Reply-To: <20180611182053.GA20665@aiede.svl.corp.google.com>
References: <xmqqmuy2wz4j.fsf@gitster-ct.c.googlers.com> <20180417220219.30445-1-szeder.dev@gmail.com>
 <20180607054834.GB6567@aiede.svl.corp.google.com> <20180608211639.7611-1-szeder.dev@gmail.com>
 <20180611182053.GA20665@aiede.svl.corp.google.com>
From:   =?UTF-8?Q?SZEDER_G=C3=A1bor?= <szeder.dev@gmail.com>
Date:   Tue, 12 Jun 2018 10:46:16 +0200
Message-ID: <CAM0VKj==u0DgnHF0j+OOtyWMCsuGApHW65CN9S4d5iUxb2bRUg@mail.gmail.com>
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
>
> Reported-by: Rick van Hattem <wolph@wol.ph>
> Reported-by: Dave Borowitz <dborowitz@google.com>
> Signed-off-by: Jonathan Nieder <jrnieder@gmail.com>
> ---
> SZEDER G=C3=A1bor wrote:
>
>> Being in RC phase, I'm all for aiming for a minimal solution.
>> However, I don't think that the better fix would be erm.. any "less
>> minimal":
>
> Thanks again. May we have your sign-off?

Sure:

Signed-off-by: SZEDER G=C3=A1bor <szeder.dev@gmail.com>

Thank you for the commit message; had a family visit the last couple
of days and could not get around to it.


>  contrib/completion/git-completion.bash | 5 ++++-
>  contrib/completion/git-completion.zsh  | 2 +-
>  2 files changed, 5 insertions(+), 2 deletions(-)
>
> diff --git a/contrib/completion/git-completion.bash b/contrib/completion/=
git-completion.bash
> index 12814e9bbf..f4a2e6774b 100644
> --- a/contrib/completion/git-completion.bash
> +++ b/contrib/completion/git-completion.bash
> @@ -3223,7 +3223,10 @@ __gitk_main ()
>         __git_complete_revlist
>  }
>
> -if [[ -n ${ZSH_VERSION-} ]]; then
> +if [[ -n ${ZSH_VERSION-} ]] &&
> +   # Don't define these functions when sourced from 'git-completion.zsh'=
,
> +   # it has its own implementations.
> +   [[ -z ${GIT_SOURCING_ZSH_COMPLETION-} ]]; then
>         echo "WARNING: this script is deprecated, please see git-completi=
on.zsh" 1>&2
>
>         autoload -U +X compinit && compinit
> diff --git a/contrib/completion/git-completion.zsh b/contrib/completion/g=
it-completion.zsh
> index 53cb0f934f..049d6b80f6 100644
> --- a/contrib/completion/git-completion.zsh
> +++ b/contrib/completion/git-completion.zsh
> @@ -39,7 +39,7 @@ if [ -z "$script" ]; then
>                 test -f $e && script=3D"$e" && break
>         done
>  fi
> -ZSH_VERSION=3D'' . "$script"
> +GIT_SOURCING_ZSH_COMPLETION=3Dy . "$script"
>
>  __gitcomp ()
>  {
> --
> 2.18.0.rc1.242.g61856ae69a
>
