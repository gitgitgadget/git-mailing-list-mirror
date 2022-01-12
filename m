Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id B5ECCC433EF
	for <git@archiver.kernel.org>; Wed, 12 Jan 2022 19:47:09 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S242868AbiALTrH (ORCPT <rfc822;git@archiver.kernel.org>);
        Wed, 12 Jan 2022 14:47:07 -0500
Received: from mail-pj1-f47.google.com ([209.85.216.47]:34569 "EHLO
        mail-pj1-f47.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1357120AbiALTqy (ORCPT <rfc822;git@vger.kernel.org>);
        Wed, 12 Jan 2022 14:46:54 -0500
Received: by mail-pj1-f47.google.com with SMTP id d10-20020a17090a498a00b001b33bc40d01so4344788pjh.1
        for <git@vger.kernel.org>; Wed, 12 Jan 2022 11:46:54 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=4KelChQMLFofxhp4FeNHxqdtcGB+qtl0NhAPzZgEQr0=;
        b=eEvNi7DWbzB5cHXnFEsQWGXqbbKcgMyzwexn7/LKgxVNXaQnYGTgCT2nhY+yd8mf4M
         F1QwkORZOTozigA0jTvbtKdsHYWGxrq3K7P7q/60OK2UxCcl1nY4rg3tWM+9ZiaehfxW
         ppE8RvEJc6PxNZ0dq1jFjfCQYLR6R6HV7L7jqDLshEQU0rDmC0fzBVE+FA6Vv02LaY39
         Pk2IFSBfKYZiZOd+AT4oIC6XWEtbfMTMm0I3sUwVIQ/7gsx1LEcziCPmWR7zaZCR3nam
         nmZcDGi1KjwgzM64AnTcmdJ7iKpQtslTZXMLIIxAftIzR3d6tpASkiWjF4t3r7KyomR6
         8yzQ==
X-Gm-Message-State: AOAM532+EjoIWUNvWBhz20elNZYbuQlL/+smUbU98JM9UOoI4bbAc9kg
        +2zW0FmrgLsPXrzlTvembC92ZGSY8Y/2nvhWmSk=
X-Google-Smtp-Source: ABdhPJzXTshfGjrRQcJk6gnkqdEKDvkg4/Iowuuu7SsYtlpxcvE5s+RvYMiIDA3iZG1N9801u21OUf+tl5dKvQ6EtK8=
X-Received: by 2002:a63:8bca:: with SMTP id j193mr1014724pge.227.1642016813881;
 Wed, 12 Jan 2022 11:46:53 -0800 (PST)
MIME-Version: 1.0
References: <20220112134635.177877-1-jholdsworth@nvidia.com> <20220112134635.177877-17-jholdsworth@nvidia.com>
In-Reply-To: <20220112134635.177877-17-jholdsworth@nvidia.com>
From:   Eric Sunshine <sunshine@sunshineco.com>
Date:   Wed, 12 Jan 2022 14:46:43 -0500
Message-ID: <CAPig+cQifriYb9mid2em18yuyPmpDvtROtRFC=Gq6=+sE+CBtw@mail.gmail.com>
Subject: Re: [PATCH 16/20] git-p4: tidied visual indented lines of conditionals
To:     Joel Holdsworth <jholdsworth@nvidia.com>
Cc:     Git List <git@vger.kernel.org>, Luke Diamand <luke@diamand.org>,
        Junio C Hamano <gitster@pobox.com>,
        Tzadik Vanderhoof <tzadik.vanderhoof@gmail.com>,
        Dorgon Chang <dorgonman@hotmail.com>,
        Joachim Kuebart <joachim.kuebart@gmail.com>,
        Daniel Levin <dendy.ua@gmail.com>,
        Johannes Schindelin <johannes.schindelin@gmx.de>,
        Ben Keene <seraphire@gmail.com>,
        Andrew Oakley <andrew@adoakley.name>
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

On Wed, Jan 12, 2022 at 8:47 AM Joel Holdsworth <jholdsworth@nvidia.com> wrote:
> git-p4: tidied visual indented lines of conditionals

Perhaps:

    git-p4: normalize indentation of lines in conditionals

or something. (Probably not worth a re-roll.)


> PEP8 recommends that when wrapping the arguments of conditional
> statements, an extra level of indentation should be added to distinguish
> arguments from the body of the statement.
>
> This guideline is described here:
> https://www.python.org/dev/peps/pep-0008/#indentation
>
> This patch either adds the indentation, or removes unnecessary wrapping.
>
> Signed-off-by: Joel Holdsworth <jholdsworth@nvidia.com>
