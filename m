Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 592CCC433F5
	for <git@archiver.kernel.org>; Fri, 29 Oct 2021 21:28:31 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 31B3C60FF2
	for <git@archiver.kernel.org>; Fri, 29 Oct 2021 21:28:31 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231293AbhJ2Va6 (ORCPT <rfc822;git@archiver.kernel.org>);
        Fri, 29 Oct 2021 17:30:58 -0400
Received: from mail-ed1-f48.google.com ([209.85.208.48]:36451 "EHLO
        mail-ed1-f48.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231258AbhJ2Va5 (ORCPT <rfc822;git@vger.kernel.org>);
        Fri, 29 Oct 2021 17:30:57 -0400
Received: by mail-ed1-f48.google.com with SMTP id s1so42976567edd.3
        for <git@vger.kernel.org>; Fri, 29 Oct 2021 14:28:27 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=FZwidZs58JIXOOUBldk5RPvf90kJZ8aOeTQxufV8VAw=;
        b=gzeqNZhezWlgTe+cVIGTsddHHgtJqfrT9Jt0Up+4dYPDtPLmq8BRq01MREtROpIWqm
         sceBtli2auw51lhE1CAcYewcJbJuzRht5dWuz8FdGGw7h2TjlFGATzsbVyNBirTgOREL
         okwhEuXKA7pFLVFz2c6nuoFwnKKN9i+y8Etw+2IgCrUpYTcSlYwuXbQ5UkiF8KqPA2vJ
         cwv23gY1V31q2N/dS7Jp7WD8HlM/C/TLIac2x6Tc7es4qGte+VbOYcmGeAMGaYcRJ8c3
         8Rs65AUAOHMhVLarw0/MF/RFfBbWePmg7eps/YFqdrTnNAo42clnd9XwMWyQJ1r5KOzV
         BeRw==
X-Gm-Message-State: AOAM533gUMnFmxpIH4CZ7aHcBOm4WezxEGNGeR4XKZXuhINtTqFlFUDQ
        pQ4hJi11fxJGKfQrlCqOpO/+beoIxUUMj2aIyIXkBA75
X-Google-Smtp-Source: ABdhPJxrhWDFleV+CZVPaQp4qhOYexdGetEb/0LDG+XbBfYK02FKMkYCNSJ2HACaEN6dYEJxjsqIP3/tkXQup8DNUnI=
X-Received: by 2002:a05:6402:10da:: with SMTP id p26mr18233899edu.283.1635542906893;
 Fri, 29 Oct 2021 14:28:26 -0700 (PDT)
MIME-Version: 1.0
References: <pull.1063.v2.git.1635530296.gitgitgadget@gmail.com> <pull.1063.v3.git.1635537163.gitgitgadget@gmail.com>
In-Reply-To: <pull.1063.v3.git.1635537163.gitgitgadget@gmail.com>
From:   Eric Sunshine <sunshine@sunshineco.com>
Date:   Fri, 29 Oct 2021 17:28:16 -0400
Message-ID: <CAPig+cQzqUrbu6gdO-0atxP8E5wGUnQQC-ytCKqL+3u_NpXMbQ@mail.gmail.com>
Subject: Re: [PATCH v3 0/2] fix up example code in MyFirstObjectWalk tutorial
To:     John Cai via GitGitGadget <gitgitgadget@gmail.com>
Cc:     Git List <git@vger.kernel.org>, John Cai <johncai86@gmail.com>
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

On Fri, Oct 29, 2021 at 3:52 PM John Cai via GitGitGadget
<gitgitgadget@gmail.com> wrote:
> MyFirstObjectWalk tutorial was missing directives to add some header files.
> Also fixes some initialization code.
>
> Changes since v1:
>
>  * added back ticks to header file names
>  * wrapped overly long lines
>
> Changes since v2:
>
>  * fixed commit organization

This version looks better. Thanks.
