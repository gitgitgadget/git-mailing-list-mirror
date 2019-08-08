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
	by dcvr.yhbt.net (Postfix) with ESMTP id 2F4121F732
	for <e@80x24.org>; Thu,  8 Aug 2019 18:34:44 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2389883AbfHHSen (ORCPT <rfc822;e@80x24.org>);
        Thu, 8 Aug 2019 14:34:43 -0400
Received: from mail-ua1-f66.google.com ([209.85.222.66]:39450 "EHLO
        mail-ua1-f66.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725535AbfHHSen (ORCPT <rfc822;git@vger.kernel.org>);
        Thu, 8 Aug 2019 14:34:43 -0400
Received: by mail-ua1-f66.google.com with SMTP id j8so36764785uan.6
        for <git@vger.kernel.org>; Thu, 08 Aug 2019 11:34:42 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=aT7eVk1OFEfvYPql6ZmJSlgi4hJ6Ek5yVeXJCv7d1P4=;
        b=HH3aJaKFz4G5DM3M+xBBfpOvjj8YyQMhcVOoTNm5Z0Jx0dCDBM1wK5eMgChNoEi1Xe
         TLlTistMYBjntTvd39lFrRhTnEKcVDVJiHsjFxv1tac6sXMPwF6DN1zAeuXHTTJbCcoq
         xMmD8tBV3qI5QHZHLz1P86EukY6eVArYuawIDc1U9fkDpwbH5oLvg9Xg4p9fUIEApxTP
         Ca9HEgiXg+3AHgNHS7wRujLgyDUA5IoLwekIOjSfi0k/gYFoXA7qm36P6zGd/ClM7fl3
         qQMVJkcA9LKbayVNI0BeqL5IrtIz/VVxaIx7o4+lVQiX1f10BUiRJmFoBnqkoVkQ0qwX
         MaXQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=aT7eVk1OFEfvYPql6ZmJSlgi4hJ6Ek5yVeXJCv7d1P4=;
        b=U+Caz6z2BJiunUYYPCl4T8sO27ne7wvPOJpWN+iRKuJqiwK1gtD4fZy4F/ScF3qAaf
         lT6hj63p4ilk9+++wtEy/6rs84SXzTWEzYudxFsidYDiYpIuG+ISgaL9bKB/JW9Dlh4v
         V+Um8OC5z334vrhbPU4mBNElLnLT+53QP/DYBrJg0FgrO9xlpaM/J0xHBdxB9/YkE4vv
         LijmCuffbE2HWiAINgJClK14KKbdh8ys6J7ji8dM0fvE+uGVgJvJUL3Gy6cNzt8wvd1Y
         IEc/QeRebB4rdcdq5lTjNFDfNH4CU+FKVeXKRPN3HfjPstPVyaSA8gQLiWQhPwGoHcf9
         C/aw==
X-Gm-Message-State: APjAAAXIsjU50o2XxOYV3m2h9nUeSH8Ikx7CzQ7bQDwjYcuUBhso4I08
        5sESsPXjXBXzHpklFAUTI0kEr3qHka31oxVD0uM=
X-Google-Smtp-Source: APXvYqwIQIpadY5XdcBwYd4JpmXMdovkvySAdpb9CBsjkcxw/Ts9XJMjZ+PX7ivYFdBdgmzazC9yNzjPpXIZPhvUEC4=
X-Received: by 2002:a9f:25e9:: with SMTP id 96mr10758330uaf.95.1565289281659;
 Thu, 08 Aug 2019 11:34:41 -0700 (PDT)
MIME-Version: 1.0
References: <pull.292.v2.git.gitgitgadget@gmail.com> <pull.292.v3.git.gitgitgadget@gmail.com>
 <2e153fac22dc5c27fc85efc802785edc0c9d78ad.1564515324.git.gitgitgadget@gmail.com>
In-Reply-To: <2e153fac22dc5c27fc85efc802785edc0c9d78ad.1564515324.git.gitgitgadget@gmail.com>
From:   Elijah Newren <newren@gmail.com>
Date:   Thu, 8 Aug 2019 11:34:29 -0700
Message-ID: <CABPp-BGppXSt9i4SXTizgPXap-YgHBwHTVrvwDpg98zvpYRwcQ@mail.gmail.com>
Subject: Re: [PATCH v3 5/5] repo-settings: create feature.experimental setting
To:     Derrick Stolee via GitGitGadget <gitgitgadget@gmail.com>
Cc:     Git Mailing List <git@vger.kernel.org>,
        Johannes Schindelin <Johannes.Schindelin@gmx.de>,
        Jeff King <peff@peff.net>, Jakub Narebski <jnareb@gmail.com>,
        =?UTF-8?B?Tmd1eeG7hW4gVGjDoWkgTmfhu41j?= <pclouds@gmail.com>,
        carenas@gmail.com,
        =?UTF-8?B?w4Z2YXIgQXJuZmrDtnLDsA==?= <avarab@gmail.com>,
        Junio C Hamano <gitster@pobox.com>,
        Derrick Stolee <dstolee@microsoft.com>
Content-Type: text/plain; charset="UTF-8"
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Sorry for the late reply...

On Tue, Jul 30, 2019 at 3:49 PM Derrick Stolee via GitGitGadget
<gitgitgadget@gmail.com> wrote:
>
> --- a/Documentation/config/merge.txt
> +++ b/Documentation/config/merge.txt
> @@ -54,7 +54,8 @@ merge.directoryRenames::
>         moved into the new directory.  If set to "conflict", a conflict
>         will be reported for such paths.  If merge.renames is false,
>         merge.directoryRenames is ignored and treated as false.  Defaults
> -       to "conflict".
> +       to "conflict" unless `feature.experimental` is enabled and the
> +       default is "true".

I have a hard time parsing that changed sentence.  Perhaps something like:
   ...unless `feature.experimental` is enabled in which case the
default is "true".
?

...
> diff --git a/repo-settings.c b/repo-settings.c
> index af93696343..e0673938c0 100644
> --- a/repo-settings.c
> +++ b/repo-settings.c
> @@ -34,6 +34,18 @@ void prepare_repo_settings(struct repository *r)
>                 free(strval);
>         }
>
> +       if (!repo_config_get_maybe_bool(r, "merge.directoryrenames", &value))
> +               r->settings.merge_directory_renames = value ? MERGE_DIRECTORY_RENAMES_TRUE : 0;

Shouldn't that be "MERGE_DIRECTORY_RENAMES_NONE" instead of "0"?

> diff --git a/repository.h b/repository.h
> index e7a72e2341..b8e52dd48f 100644
> --- a/repository.h
> +++ b/repository.h
> @@ -19,6 +19,20 @@ enum untracked_cache_setting {
>         UNTRACKED_CACHE_WRITE = 2
>  };
>
> +enum merge_directory_renames_setting {
> +       MERGE_DIRECTORY_RENAMES_UNSET = -1,
> +       MERGE_DIRECTORY_RENAMES_NONE = 0,
> +       MERGE_DIRECTORY_RENAMES_CONFLICT = 1,
> +       MERGE_DIRECTORY_RENAMES_TRUE = 2,
> +};

Thanks for adding these; makes things much nicer.  :-)


Cheers,
Elijah
