Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-3.0 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_HI,T_DKIM_INVALID,
	T_RP_MATCHES_RCVD shortcircuit=no autolearn=no autolearn_force=no
	version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 370941F404
	for <e@80x24.org>; Sun, 11 Feb 2018 01:59:52 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1751166AbeBKB7u (ORCPT <rfc822;e@80x24.org>);
        Sat, 10 Feb 2018 20:59:50 -0500
Received: from mail-qk0-f195.google.com ([209.85.220.195]:46187 "EHLO
        mail-qk0-f195.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1751050AbeBKB7t (ORCPT <rfc822;git@vger.kernel.org>);
        Sat, 10 Feb 2018 20:59:49 -0500
Received: by mail-qk0-f195.google.com with SMTP id g129so115336qkb.13
        for <git@vger.kernel.org>; Sat, 10 Feb 2018 17:59:48 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=mime-version:sender:in-reply-to:references:from:date:message-id
         :subject:to:cc:content-transfer-encoding;
        bh=CBJ9Fq6Tk5PwqSlxMtrE0/Rqc2NCqcNPYp0aPoNsCyg=;
        b=qJvkVIIB1BkigSeLz5PSZAWMzHaaT9gpHF5u3DQIsJl/zwEAxNcmYTa6n6jrDsr8Qg
         NfII0hB6bWP/gNlZi+XH6ruQvSYICI7OHw1y1xpzD5Djh5lBXZNvoixQxo2zC/anCf7S
         rSw5gv5LiLye44T94eEvVVkAO94XS42vJ27JGyO2LoMrPFBzpMaoOTH0139u3VJr8Eu+
         Zy/CAqAS8sNt7yEzK3XMIWaECz0zQ0f6bUKhRZoymeeXlEXIY4f+OQDR7C9hBTTTdbKq
         d154MYtDAqJ3rJZsJWeXaNahFpfaM/mYexHQZQcv7AeezAewxwbAbMxoeLIyQfHRBBp7
         Sszw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:sender:in-reply-to:references:from
         :date:message-id:subject:to:cc:content-transfer-encoding;
        bh=CBJ9Fq6Tk5PwqSlxMtrE0/Rqc2NCqcNPYp0aPoNsCyg=;
        b=JNS/aeG26dnwUnhg09LpN4fN+A4EdKc06WsMAXDJJu+mDy9dZm9sujnKRGPexwhey8
         HDSr9nzOCB7A7wM+zHPJIhBC+kql9+jv4RCZMsh/caTWxf1rOcGIjB3Cceit1jH8DyJE
         jwcEbIJsAoocbwNSlkRCIfiEEJB3lJWrKu8ZvKuEzzop8dHcdQKxZPLd+Q8gAyJnsv4K
         KWkksmse9wWPcuoenjoqO4zFU9AtmaUp2qvZ9pOoNjVrEociK6PeqlsEae7bn5Bt0zH4
         fzUN+mrWNOI/Pyn1G+TW9Sy6BeirWFbsVhxrGSFV3359UrEwwuIqlFXhCH0xiVqjjAiQ
         r6dQ==
X-Gm-Message-State: APf1xPAeRS+1LRbEPv4Y+KSatm6KW1iN5kUdtIE3qqVZ4FFZ3jHO3LRy
        I/v7oYlcbVkBCFRG6Ye/g3SSuyLsKqxNnVLTZjY=
X-Google-Smtp-Source: AH8x225Uy2fRIIe1r1QmJKmxWexXhfMoYc7qWHGPCrZze2J0bBhfdoG/GRGbizMfpQ43YomwFf9vIJFxoYGPy1rsDwc=
X-Received: by 10.233.214.1 with SMTP id r1mr684000qkk.81.1518314388476; Sat,
 10 Feb 2018 17:59:48 -0800 (PST)
MIME-Version: 1.0
Received: by 10.12.128.40 with HTTP; Sat, 10 Feb 2018 17:59:48 -0800 (PST)
In-Reply-To: <20180209110221.27224-43-pclouds@gmail.com>
References: <20180131110547.20577-1-pclouds@gmail.com> <20180209110221.27224-1-pclouds@gmail.com>
 <20180209110221.27224-43-pclouds@gmail.com>
From:   Eric Sunshine <sunshine@sunshineco.com>
Date:   Sat, 10 Feb 2018 20:59:48 -0500
X-Google-Sender-Auth: pIUrzXa-AvGK4rheB0MyQnqC_Uw
Message-ID: <CAPig+cT63UnZ1qLKc-Rk4k0ixL93ywd-i6AFH3mFJOWq2QpuBQ@mail.gmail.com>
Subject: Re: [PATCH v3 42/42] git-completion.bash: add GIT_COMPLETION_OPTIONS=all
 config
To:     =?UTF-8?B?Tmd1eeG7hW4gVGjDoWkgTmfhu41jIER1eQ==?= 
        <pclouds@gmail.com>
Cc:     Git List <git@vger.kernel.org>, Junio C Hamano <gitster@pobox.com>,
        =?UTF-8?B?w4Z2YXIgQXJuZmrDtnLDsCBCamFybWFzb24=?= <avarab@gmail.com>,
        =?UTF-8?Q?SZEDER_G=C3=A1bor?= <szeder.dev@gmail.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

On Fri, Feb 9, 2018 at 6:02 AM, Nguy=E1=BB=85n Th=C3=A1i Ng=E1=BB=8Dc Duy <=
pclouds@gmail.com> wrote:
> By default, some option names (mostly --force, scripting related or for
> internal use) are not completable for various reasons. When
> GIT_COMPLETION_OPTIONS is set to all, all options (except hidden ones)
> are completable.
>
> Signed-off-by: Nguy=E1=BB=85n Th=C3=A1i Ng=E1=BB=8Dc Duy <pclouds@gmail.c=
om>
> ---
> diff --git a/contrib/completion/git-completion.bash b/contrib/completion/=
git-completion.bash
> @@ -36,6 +36,10 @@
> +#
> +#   GIT_COMPLETION_OPTIONS
> +#
> +#     When set to "all", complete all possible options
> @@ -303,7 +307,7 @@ __gitcomp_builtin ()
>         if [ -z "$options" ]; then
>                 # leading and trailing spaces are significant to make
>                 # option removal work correctly.
> -               options=3D" $(__git ${cmd/_/ } --git-completion-helper) $=
incl "
> +               options=3D" $(__git ${cmd/_/ } --git-completion-helper=3D=
$GIT_COMPLETION_OPTIONS) $incl "

This approach is rather different from what I had envisioned. Rather
than asking --git-completion-helper to do the filtering, my thought
was that it should unconditionally dump _all_ options but annotate
them, and then git-completion.bash can filter however it sees fit. For
instance, --git-completion-helper might annotate "dangerous" options
with a "!" ("!--force" or "--force!" or "--force:!" or whatever).

The benefit of this approach is that it more easily supports future
enhancements. For instance, options which only make sense in certain
contexts could be annotated to indicate such. An example are the
--continue, --abort, --skip options for git-rebase which only make
sense when a rebase session is active. One could imagine these options
being annotated something like this:

    --abort:rebasing
    --continue:rebasing
    --skip:rebasing

where git-completion.bash understands the "rebasing" annotation as
meaning that these options only make sense when "rebase-apply" is
present. (In fact, the annotation could be more expressive, such as
"--abort:exists(rebase-apply)", but that might be overkill.)
