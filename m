Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.1 (2015-04-28) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-3.6 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,RCVD_IN_DNSWL_HI
	shortcircuit=no autolearn=ham autolearn_force=no version=3.4.1
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 2CCF31F404
	for <e@80x24.org>; Thu,  6 Sep 2018 06:19:22 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726443AbeIFKxL (ORCPT <rfc822;e@80x24.org>);
        Thu, 6 Sep 2018 06:53:11 -0400
Received: from mail-pf1-f193.google.com ([209.85.210.193]:33687 "EHLO
        mail-pf1-f193.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725957AbeIFKxL (ORCPT <rfc822;git@vger.kernel.org>);
        Thu, 6 Sep 2018 06:53:11 -0400
Received: by mail-pf1-f193.google.com with SMTP id d4-v6so4744791pfn.0
        for <git@vger.kernel.org>; Wed, 05 Sep 2018 23:19:20 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=tHbFcu0WPcZBVdDm5V5O7Dkk50uMojRwZIz6ESmndQk=;
        b=gRropHjDbJLjKxll2PVPIYhEVOtusHfTrGbCb4PuwV1Oz2LNZisTSsUQYKsg/xwtqv
         nqVhEjL958SfKt2jEJamckue/UBld+u01ymxINoaIW0bkm7ss0Kaf4cplqgHtlK2vZNy
         a6WWuy5T+bs157EAqPVnpZ7czyAK+PEYpYA08r4YeQxnCrDe1MYo/oW7JDd+BA7KHwrK
         qtmZY0EMivcl4JIVcyheiYNCaP8sgJjljHb/YTtI649tZKuQwGvycrxghMGw402rsJKW
         pTcexmoDfjSkxOGOIl/6McnRnWvAHBRK4ZOl5ZyYK4LkMlqM9g+cMIJloOyADL53rctK
         mwFw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=tHbFcu0WPcZBVdDm5V5O7Dkk50uMojRwZIz6ESmndQk=;
        b=boeZ3XiHljoWzxDCJfF6JoauJtmgOy/VY2ybpmbOrWkWRyOAtN5961lvIM8t4USRoG
         /i6WBU6GMcEvjyepdxBScT6nzVFA2Z/rmi8TZlnoxBdd38Xb6KF41Hg6oHLpQSFZQeOq
         1vi21iiUVARJ37K/TVemTisAkSM9JvVXVIr4a7MN/zPSKVNjBFTcEOIym0iPe9DvrhMH
         zlCnIla5eyS8g9vw/OuEvOpM9LOwvi3TLYqiRNovF6GZFMQ4/JiGZJHSlX4f0N4QbD/+
         VYGDKCReAu/Z/Sv4djJZRIRLM7z42FTRxTrfkjuM7IUvRJNc/eBVQAHCYxHKvlkHNUIJ
         EGrg==
X-Gm-Message-State: APzg51ApAfe9qvicYZYpi1lDdWhnwjdrN5JcODE2ZSBtDjHj9iHzrExD
        Kb/PXwVnfCtj9U472mi47T2p7rD8421c+7n/HeoGMoPDYHk=
X-Google-Smtp-Source: ANB0VdbBT/+gizVwLyxnyOCoO9d3Ag0fB+KYr9Gl1fyiy8G7jfnp8QDM79Dw0kWpMENHmwV5t2kX5E7XtIY/o6OgL2s=
X-Received: by 2002:a63:4204:: with SMTP id p4-v6mr1227237pga.200.1536214759998;
 Wed, 05 Sep 2018 23:19:19 -0700 (PDT)
MIME-Version: 1.0
References: <20180905225828.17782-1-sbeller@google.com>
In-Reply-To: <20180905225828.17782-1-sbeller@google.com>
From:   =?UTF-8?Q?Martin_=C3=85gren?= <martin.agren@gmail.com>
Date:   Thu, 6 Sep 2018 08:19:05 +0200
Message-ID: <CAN0heSpOG8c5En_YVvtkcwBmOrnS72cTXSw9YRJP4FG-M8dWag@mail.gmail.com>
Subject: Re: [PATCH] diff: allow --recurse-submodules as an synonym for --submodule
To:     Stefan Beller <sbeller@google.com>
Cc:     Git Mailing List <git@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

On Thu, 6 Sep 2018 at 00:59, Stefan Beller <sbeller@google.com> wrote:
>
>  --submodule[=<format>]::

Maybe drop `--submodule` here ...

> +--recurse-submodules[=<format>]::
>         Specify how differences in submodules are shown.  When specifying
>         `--submodule=short` the 'short' format is used.  This format just

... and use `--recurse-submodules` here ...

>         shows the names of the commits at the beginning and end of the range.

... and mention `--submodule` here as a historical alias? Maybe
deprecate it? I suppose the implementation of the aliasing is easy
enough that we can carry `--submodule` around forever, though.

> diff --git a/diff.c b/diff.c
> index 145cfbae592..d3d5a989bd1 100644
> --- a/diff.c
> +++ b/diff.c
> @@ -5023,6 +5023,8 @@ int diff_opt_parse(struct diff_options *options,
>                 handle_ignore_submodules_arg(options, arg);
>         } else if (skip_to_optional_arg_default(arg, "--submodule", &arg, "log"))
>                 return parse_submodule_opt(options, arg);
> +       else if (skip_to_optional_arg_default(arg, "--recurse-submodules", &arg, "log"))
> +               return parse_submodule_opt(options, arg);

How about (whitespace-damaged)

} else if (skip_to_optional_arg_default(arg, "--submodule", &arg, "log") ||
           skip_to_optional_arg_default(arg, "--recurse-submodules",
&arg, "log"))
        return parse_submodule_opt(options, arg);

to make this future-proof? Sure, they're close enough that one should
notice the two instances, and any future work work would supposedly
happen in `parse_submodule_opt()` or anywhere else but here, but still.

Just a few thoughts.

Martin
