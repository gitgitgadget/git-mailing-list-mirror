Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.2 (2018-09-13) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-4.2 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,RCVD_IN_DNSWL_HI
	shortcircuit=no autolearn=ham autolearn_force=no version=3.4.2
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 235AD1F453
	for <e@80x24.org>; Tue, 12 Feb 2019 05:33:40 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1725936AbfBLFdj (ORCPT <rfc822;e@80x24.org>);
        Tue, 12 Feb 2019 00:33:39 -0500
Received: from mail-it1-f194.google.com ([209.85.166.194]:39139 "EHLO
        mail-it1-f194.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725778AbfBLFdi (ORCPT <rfc822;git@vger.kernel.org>);
        Tue, 12 Feb 2019 00:33:38 -0500
Received: by mail-it1-f194.google.com with SMTP id a6so4521244itl.4
        for <git@vger.kernel.org>; Mon, 11 Feb 2019 21:33:38 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=Ixtn4F5XROFIvaX/s/+SqX3yuPAe0ZjX1/8/xtJtmFE=;
        b=KQAmWNvX/aN0vwTuWXzW3JpqZeL8POFWCON6sb6CVGXPcK3BZIS7mcTJleXNyacZ14
         X5Tdk85LI6asm81I8zmQk7XKgiHDjmyWsEQN4Z0eDCjYBegnN1Z1xveaPznJMk0B+3pg
         oYgpAf1EKfDLpyYv4gWkn/0t8YhythSefQMgqbp5zfjZkkJ7kmTEImv1jWy+BFErpj4l
         tJF7S9/P0wUx6lvFWrsAfdA1EWcvN9qXPSpjUpgS2CpYGZ3O1FFSuGFUPdtrBmOh9Lu2
         uczVjsaZgzQXYKJwqVF/vli9L4RUiY/QJjffgh1heRAFD9BTq2+J4GQ72FSdaX0v3H/c
         +rjg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=Ixtn4F5XROFIvaX/s/+SqX3yuPAe0ZjX1/8/xtJtmFE=;
        b=dVtLmcG3nRl5DyHPTQaUMe+I7npFSNqW0V9WEwk09k0Nx5fWnuZGHQMS0EfF9d2lak
         GQi2nA1FSbZKB582A5q5oCTXQQX0MnWFAn+V2iY5HwmOG5a4vxh6U5KHIWfm8TKg9Edd
         A2Pi52ILGyxSFqx731AiLowFJH22xvPCDIxNkHfggr7FGpYgZ1ieas2jK2cEr0cskKUj
         ZM6pC/vjuoQCk6CaCDBFYdQgsPuy9tDJNPxO+P3WDtLqAXPztJqTRl0ppNNs2Mk607t/
         jF96pXSwkCjg4u+OLXtwm/fRVNgX5p31lNNOrqwj0Tg+ed2aS4T2FtadWtS/gmnytr0W
         hVEw==
X-Gm-Message-State: AHQUAub5Sr9TrnOSZG54KXxATRcJJ5IeAYZAYnZ+3l8vHhTlubOECROg
        NCVPl/sZm3TwduoRj9H0zLesg4HDFTf3//1N1rc=
X-Google-Smtp-Source: AHgI3IY58VsAdMOY9nFNj1PIrHyH0yxmdTh5SpqzopHeEqgmaMRrRR3RNzLWMvyPAi0RaUlJBqMElKba4nV7DepOIB8=
X-Received: by 2002:a24:2fd0:: with SMTP id j199mr915721itj.123.1549949618161;
 Mon, 11 Feb 2019 21:33:38 -0800 (PST)
MIME-Version: 1.0
References: <0b62f65a8016c41b96aa6caead366e1ed9dda333.1549944164.git.liu.denton@gmail.com>
In-Reply-To: <0b62f65a8016c41b96aa6caead366e1ed9dda333.1549944164.git.liu.denton@gmail.com>
From:   Duy Nguyen <pclouds@gmail.com>
Date:   Tue, 12 Feb 2019 12:33:11 +0700
Message-ID: <CACsJy8ADLyog0ntfij+MUhPXHZfK-xQnnQPd5pvapttZQ9ZZ5w@mail.gmail.com>
Subject: Re: [PATCH] git-submodule.txt: document default behavior
To:     Denton Liu <liu.denton@gmail.com>
Cc:     Git Mailing List <git@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

On Tue, Feb 12, 2019 at 11:04 AM Denton Liu <liu.denton@gmail.com> wrote:
>
> This patch documents the default behavior of git-submodule if no
> subcommands are given, similar to how git-remote.txt documents it.
>
> Signed-off-by: Denton Liu <liu.denton@gmail.com>
> ---
>  Documentation/git-submodule.txt | 3 +++
>  1 file changed, 3 insertions(+)
>
> diff --git a/Documentation/git-submodule.txt b/Documentation/git-submodule.txt
> index ba3c4df550..9bc98da154 100644
> --- a/Documentation/git-submodule.txt
> +++ b/Documentation/git-submodule.txt
> @@ -28,6 +28,9 @@ For more information about submodules, see linkgit:gitsubmodules[7].
>
>  COMMANDS
>  --------
> +With no arguments, shows the status of existing submodules.  Several

Maybe just "The default command is 'status'" and let the user read
that subcommand for more info.

> +subcommands are available to perform operations on the submodules.
> +
>  add [-b <branch>] [-f|--force] [--name <name>] [--reference <repository>] [--depth <depth>] [--] <repository> [<path>]::
>         Add the given repository as a submodule at the given path
>         to the changeset to be committed next to the current
> --
> 2.20.1.530.g88cfe87ec3
>


-- 
Duy
