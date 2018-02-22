Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-2.8 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_HI,T_DKIM_INVALID,
	T_RP_MATCHES_RCVD shortcircuit=no autolearn=no autolearn_force=no
	version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id CAA141F404
	for <e@80x24.org>; Thu, 22 Feb 2018 20:30:30 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1751379AbeBVUa2 (ORCPT <rfc822;e@80x24.org>);
        Thu, 22 Feb 2018 15:30:28 -0500
Received: from mail-wr0-f194.google.com ([209.85.128.194]:43721 "EHLO
        mail-wr0-f194.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1750802AbeBVUaX (ORCPT <rfc822;git@vger.kernel.org>);
        Thu, 22 Feb 2018 15:30:23 -0500
Received: by mail-wr0-f194.google.com with SMTP id u49so11879986wrc.10
        for <git@vger.kernel.org>; Thu, 22 Feb 2018 12:30:22 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=sender:from:to:cc:subject:references:date:in-reply-to:message-id
         :user-agent:mime-version:content-transfer-encoding;
        bh=OWOohVjdGeVWxDqWPgNyGZaaLzzR2wO0QSmZvmobsek=;
        b=RUv1eQoSlJqhAzomImpQ3JGTp+tD7xTBV/4YTYa61QWR3rvFgRLCZEPi38pDCImkdn
         taMeHkA26PoRgFmg7GVaZMDvkAxmQBV7+ceL4oZj/7u3TAjz6dufopiLjZLFeyW4Obeu
         OP+o07mAr7bYzGRWw5ULVSGuI4Epcs0/iYBHuaHbPcN4O76DmutqRrn/C8I7QVorm90w
         VoLZX3ydshEFT4Y0Q4eIY0zJaj2Ybo/5Kprjx7MvET7GCTk9jzr0T79+5lzYdMRwLxbk
         k2bsb6hSzgg1f1ZchmQAzbKgRk4ct+JUQOxFng5DeM5Di/sv1WldKWbVAvCsTsDkij7R
         UIiw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:sender:from:to:cc:subject:references:date
         :in-reply-to:message-id:user-agent:mime-version
         :content-transfer-encoding;
        bh=OWOohVjdGeVWxDqWPgNyGZaaLzzR2wO0QSmZvmobsek=;
        b=GyG5EhHNxCnwmnFgB702r9JqFai/E8f9uDrnJUZXbAbbegr2B2HYT1HqqJX5jJ02xE
         +KX27Et4lI7tzpA+FLQF/rsScOhRAtPD/8eZofuzndL67V5OJ1Ajnigj/1jdPMpJUEqA
         UukDQgvGP96EmIOHvI3s8Y9+kQhUZmZsFVFI4nQ7LlG7AXiw1TBu40p2x7eWqEMVPfB0
         c387dczMiQXaPPZ3JQMOxFzlbQp7clBty6HGCYhkndgK/ft0fW+BZfZh2E7l8TDL91sP
         IMYLINRA3oCn56/pxYomLVTdXzo48VxFgOVi2IRWUtRQLd0pNryjirmrGXKNpWQw+Dpo
         F8rA==
X-Gm-Message-State: APf1xPAjlSNJCwpZH6Mlf6+GrFD3/ADQDEs1MiMGewYuIkLwmjztRvwU
        ztbhXiIBW9TeT4HZYL+f/uk=
X-Google-Smtp-Source: AH8x224uWKshYfANBc8L5DDr6UdQJoshOVnsrVtedomZcvCQqWCFxxEI8hvjB1Hlnz1d8RwhkYVRFA==
X-Received: by 10.223.184.26 with SMTP id h26mr7955437wrf.65.1519331421357;
        Thu, 22 Feb 2018 12:30:21 -0800 (PST)
Received: from localhost (168.50.187.35.bc.googleusercontent.com. [35.187.50.168])
        by smtp.gmail.com with ESMTPSA id 137sm251792wmm.46.2018.02.22.12.30.20
        (version=TLS1_2 cipher=ECDHE-RSA-CHACHA20-POLY1305 bits=256/256);
        Thu, 22 Feb 2018 12:30:20 -0800 (PST)
From:   Junio C Hamano <gitster@pobox.com>
To:     marmot1123 <marmot.motoki@gmail.com>
Cc:     git@vger.kernel.org
Subject: Re: [PATCH v3 2/2] Replace non-ASCII apostrophes to ASCII single quotes in gitsubmodules.txt
References: <01020161bcb6b2b5-6a915ec6-57e5-4619-b281-0e2a193c69a2-000000@eu-west-1.amazonses.com>
        <01020161bcb6b3db-dd4dc2a0-4426-4bf0-97f3-18b299d91400-000000@eu-west-1.amazonses.com>
Date:   Thu, 22 Feb 2018 12:30:19 -0800
In-Reply-To: <01020161bcb6b3db-dd4dc2a0-4426-4bf0-97f3-18b299d91400-000000@eu-west-1.amazonses.com>
        (marmot's message of "Thu, 22 Feb 2018 08:52:25 +0000")
Message-ID: <xmqqtvu8vkbo.fsf@gitster-ct.c.googlers.com>
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/25.2.50 (gnu/linux)
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: 8bit
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

marmot1123 <marmot.motoki@gmail.com> writes:

> Before this patch, there are several non-ASCII apostrophes in
> gitsubmodules.txt, and misconverged at the https://git-scm.com/docs/gitsubmodules/ .
> To make codes consistent, these non-ASCII apostrophes are replaced
> with ASCII single quotes.  This patch also makes the document readable
> on the website.
>
> Signed-off-by: Motoki Seki <marmot.motoki@gmail.com>
> ---

Interesting.  I didn't know the AsciiDoc renderer used there
mishandled these non-ASCII ticks.  Thanks for writing it down in the
log message.

When we say "there are ..." in a proposed commit log message
(i.e. in the present tense), it is the norm to talk about the
current state of affairs, so "Before this patch," is redundant.  I'd
drop it myself while queuing, and possibly applying other typofixes.

Thanks.


>  Documentation/gitsubmodules.txt | 10 +++++-----
>  1 file changed, 5 insertions(+), 5 deletions(-)
>
> diff --git a/Documentation/gitsubmodules.txt b/Documentation/gitsubmodules.txt
> index 0d59ab4cdfb1c..030c974c25606 100644
> --- a/Documentation/gitsubmodules.txt
> +++ b/Documentation/gitsubmodules.txt
> @@ -132,27 +132,27 @@ using older versions of Git.
>  +
>  It is possible to construct these old form repositories manually.
>  +
> -When deinitialized or deleted (see below), the submodule’s Git
> +When deinitialized or deleted (see below), the submodule's Git
>  directory is automatically moved to `$GIT_DIR/modules/<name>/`
>  of the superproject.
>  
>   * Deinitialized submodule: A `gitlink`, and a `.gitmodules` entry,
> -but no submodule working directory. The submodule’s git directory
> +but no submodule working directory. The submodule's git directory
>  may be there as after deinitializing the git directory is kept around.
>  The directory which is supposed to be the working directory is empty instead.
>  +
>  A submodule can be deinitialized by running `git submodule deinit`.
>  Besides emptying the working directory, this command only modifies
> -the superproject’s `$GIT_DIR/config` file, so the superproject’s history
> +the superproject's `$GIT_DIR/config` file, so the superproject's history
>  is not affected. This can be undone using `git submodule init`.
>  
>   * Deleted submodule: A submodule can be deleted by running
>  `git rm <submodule path> && git commit`. This can be undone
>  using `git revert`.
>  +
> -The deletion removes the superproject’s tracking data, which are
> +The deletion removes the superproject's tracking data, which are
>  both the `gitlink` entry and the section in the `.gitmodules` file.
> -The submodule’s working directory is removed from the file
> +The submodule's working directory is removed from the file
>  system, but the Git directory is kept around as it to make it
>  possible to checkout past commits without requiring fetching
>  from another repository.
>
> --
> https://github.com/git/git/pull/459
