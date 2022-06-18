Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id E9E83C43334
	for <git@archiver.kernel.org>; Sat, 18 Jun 2022 11:10:58 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232262AbiFRLKL (ORCPT <rfc822;git@archiver.kernel.org>);
        Sat, 18 Jun 2022 07:10:11 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:37070 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229721AbiFRLKJ (ORCPT <rfc822;git@vger.kernel.org>);
        Sat, 18 Jun 2022 07:10:09 -0400
Received: from mail-pg1-x52b.google.com (mail-pg1-x52b.google.com [IPv6:2607:f8b0:4864:20::52b])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 88E6F22518
        for <git@vger.kernel.org>; Sat, 18 Jun 2022 04:10:08 -0700 (PDT)
Received: by mail-pg1-x52b.google.com with SMTP id 68so683937pgb.10
        for <git@vger.kernel.org>; Sat, 18 Jun 2022 04:10:08 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=CcGZys3xZAk+M4nfNM/lbPBySwpA59fkvPmIVRld3dU=;
        b=PtA6Eb6ICJWf80gQdgxlNvCS7Sy0NZwDG2wSXkyhe+9nNATjesYCo0Z9MxJXF+FqFH
         wdGXAMqR86hC9OrpQ2QEYUy+HnpwtzpEuiXyFgIjfthB9JKZS7r3/aCljQrPUO5aNQdt
         1ZzBC5Aw2mbkz0UY39EmsCKd8SPcnqRACgd0xue4hGW1qKR1zJO7XsSnGkWvDPuHk0Cz
         0S2ENuIbLLbPC5Q2mpY+SuE0zEyQDY7oLTmX9Wk3zGk3MhQzTfBofRdlNn4ti1E3dn13
         zGRR6kpyOdzLAvywp9TtOfKvYmdNvCbXXcV1/yRhanGgMyovjcQc6B2qnouahpeUpH+z
         gpJQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=CcGZys3xZAk+M4nfNM/lbPBySwpA59fkvPmIVRld3dU=;
        b=EQWE23JdpvaHFQL34/LmHiEZw3ER9G9m4yfkAttzbGBr+iQJFEJoaUhKgFoz4OsiUd
         4HfrVwFRF6ItxetpqW03m7LNIgnarrOtCpjgDPifQn0XbCQ7Q0i3ovOqUAbrnoKQVe+Z
         fjlx/ugqlS+0YhfWYLX37smO89JZ2upSmOxrG13iBeGoT27rMrVQSLulT2oUwEXeQln4
         Fe/ktQWmrfojBYoNQ/4jXRgHk7yGpomFB59WBRgmaWUe/uBfGbeb78xkuwocTcNkaAaq
         zL9qpWO/60qRwM33VQc9Fc1yHfDFALlpc3K5F/SG/NtRwvsX7c5tGmuNGR7tKV2uywKH
         PlGw==
X-Gm-Message-State: AJIora8Ls+ibiQwX4xWUn8V8/yi19vKQuYIQvjup0OWbprNtQ6A90/vO
        vA7ppT16LXtAlQrv0mb3QT9UWOFDBGLOjdunFEd9fc/TElXlaA==
X-Google-Smtp-Source: AGRyM1uQ6QQr+02ndVybebotYfeE45Nie8w4n4Ts1UeeQKXwJBzBDvPowz0rQlJ1atWaqaDupfEqrqLSM0NWljS3wAM=
X-Received: by 2002:a65:6459:0:b0:3fc:700a:ce88 with SMTP id
 s25-20020a656459000000b003fc700ace88mr13279268pgv.143.1655550607929; Sat, 18
 Jun 2022 04:10:07 -0700 (PDT)
MIME-Version: 1.0
References: <b4f40821-8592-1a35-8b60-219fd7e29e9f@luigifab.fr>
In-Reply-To: <b4f40821-8592-1a35-8b60-219fd7e29e9f@luigifab.fr>
From:   Shaoxuan Yuan <shaoxuan.yuan02@gmail.com>
Date:   Sat, 18 Jun 2022 19:09:55 +0800
Message-ID: <CAJyCBORdr3kaBbBmec5T5JAjcUpq6mSKQC=8_poLaZzSpkMJLA@mail.gmail.com>
Subject: Re: git a/xyz or b/xyz
To:     Fabrice Creuzot <code@luigifab.fr>
Cc:     git@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

On Sat, Jun 18, 2022 at 6:50 PM Fabrice Creuzot <code@luigifab.fr> wrote:
>
> Hello
>
> When we are reading a "git diff", all paths are prefixed with "a/" and
> "b/". Example:
> diff --git a/xyz
> index 4aa4b5230..1c2b8b69e 100644
> --- a/xyz
> +++ b/xyz
> @@ -1,7 +1,7 @@
>
>
> With my terminal, I double click on the path to select the full path for
> copy.
>
> Then, when I paste: "git log a/xyz",
>   git says: unknown revision or path not in the working tree
>
> Ok, I need to remove the "a/" or "b/".
> But, is git can understand that "a/xyz" is "xyz" because "a/xyz" does
> not exist?
>
> Thanks

Hi Fabrice,

You can think that "a/" stands for "before" or "old content", whereas
 "b/" stands for "after" or "new content". Paths are prefixed with these
to indicate which is before and which is after.

For example, when you call "git diff", it is to "view the changes you made
relative to the index (staging area for the next commit)".
In this case, "before" is the index, namely "a/", whereas "after"
is your current working tree, namely "b/".

-- 
Thanks & Regards,
Shaoxuan
