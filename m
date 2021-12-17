Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 8B58DC433EF
	for <git@archiver.kernel.org>; Fri, 17 Dec 2021 15:48:15 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S235867AbhLQPsP (ORCPT <rfc822;git@archiver.kernel.org>);
        Fri, 17 Dec 2021 10:48:15 -0500
Received: from mail-pg1-f181.google.com ([209.85.215.181]:36676 "EHLO
        mail-pg1-f181.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233461AbhLQPsO (ORCPT <rfc822;git@vger.kernel.org>);
        Fri, 17 Dec 2021 10:48:14 -0500
Received: by mail-pg1-f181.google.com with SMTP id 200so2488180pgg.3
        for <git@vger.kernel.org>; Fri, 17 Dec 2021 07:48:14 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=o4IcELGnAU61uE1orPbA7HVwapk8Kl+cwQkT6evMaSg=;
        b=M0VyjH7E0PJdngf6XJsBJn6mTWi3G0S9+pL+bfJNpPINFYJ7aAwVyhutzBon8GAIy3
         7pHmexo7t9YbT7WIrJgj2mDknxWHhp2GxDtiwJp02mSx1g04tE8GXegDKA0yHpvtHiKX
         U2xxyIp/nUH3lMQJgA8G1wvBT3I+5ZYl5a900Q0Wm4K7N2jMe6jWSxFodVqrBJljU+ZK
         h8ixvRHKQlarLFtVYwVUnzcp4n1DLR7FNFAGHO2CAkQ568Rpa/3hH5u5BsqXdWH7GrpR
         b061n582Yj6ssH994N4hqPvg7CPo7PmFgF2r/miV6UHJrU7mLxtgWMpa94aWhswASqOu
         i+rg==
X-Gm-Message-State: AOAM53042UzL3w0PybYe/7GUNkJKje8/r3cK7CmI8WJ6jOD1vvVcqncg
        LH8uqaYDsIF74NS7gvdkmM8nj/6sUnACteakPfCNZ7Llez/WlQ==
X-Google-Smtp-Source: ABdhPJy5Uks8cMpGaY3Nbe5kAF88oibqU9YNaeMDXghqMb1bdFLuNEXs4M6BMERHPvIQ2exvxF1qzfyFa5Cq7vP5hPA=
X-Received: by 2002:a05:6a00:1405:b0:4ba:c84:4127 with SMTP id
 l5-20020a056a00140500b004ba0c844127mr3806773pfu.4.1639756094200; Fri, 17 Dec
 2021 07:48:14 -0800 (PST)
MIME-Version: 1.0
References: <1e5dba11-fa01-44e1-b341-9d69bbdbbd39@www.fastmail.com> <CAPig+cTfL3e28geHMG6aga-1zSSYSgXknQKO-62msn3LO=+iZA@mail.gmail.com>
In-Reply-To: <CAPig+cTfL3e28geHMG6aga-1zSSYSgXknQKO-62msn3LO=+iZA@mail.gmail.com>
From:   Eric Sunshine <sunshine@sunshineco.com>
Date:   Fri, 17 Dec 2021 10:48:03 -0500
Message-ID: <CAPig+cSd8wpFM4CgHr-BUn0cWSTPJr_C2ahUaSJ=XMbMjDv_0Q@mail.gmail.com>
Subject: Re: [PATCH] docs: add missing colon to Documentation/config/gpg.txt
To:     Greg Hurrell <greg@hurrell.net>
Cc:     Git List <git@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

On Fri, Dec 17, 2021 at 10:44 AM Eric Sunshine <sunshine@sunshineco.com> wrote:
> > +gpg.ssh.defaultKeyCommand::
> >         This command that will be run when user.signingkey is not set and a ssh
> >         signature is requested. On successful exit a valid ssh public key is
> >         expected in the first line of its output. To automatically use the first
>
> If you want to tackle them, some other fixes would be:
>
> * "This _is the_ command that..." or "This command will be..."
>
> * in user-facing documentation, we use camelCase for configuration
> names, so "user.signingkey" should be "user.signingKey"
>
> * s/ssh/SSH/
>
> * s/exit/exit,/

Oh, I forgot to mention that we typically want to use backticks to
typeset text with fixed-width font for elements such as:

    `user.signingKey`
    `ssh-agent`
    `ssh-add -L`
