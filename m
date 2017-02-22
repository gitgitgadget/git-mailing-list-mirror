Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-2.9 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_HI,RP_MATCHES_RCVD,T_DKIM_INVALID
	shortcircuit=no autolearn=ham autolearn_force=no version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id B09D2201B0
	for <e@80x24.org>; Wed, 22 Feb 2017 17:50:55 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S932873AbdBVRut (ORCPT <rfc822;e@80x24.org>);
        Wed, 22 Feb 2017 12:50:49 -0500
Received: from mail-pf0-f195.google.com ([209.85.192.195]:36189 "EHLO
        mail-pf0-f195.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S932851AbdBVRur (ORCPT <rfc822;git@vger.kernel.org>);
        Wed, 22 Feb 2017 12:50:47 -0500
Received: by mail-pf0-f195.google.com with SMTP id c193so35988pfb.3
        for <git@vger.kernel.org>; Wed, 22 Feb 2017 09:50:47 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=sender:from:to:cc:subject:references:date:in-reply-to:message-id
         :user-agent:mime-version:content-transfer-encoding;
        bh=z5Q0mVUUxWDxAfdB2h8kbQMtaeQoXR1U24T9XP2klJg=;
        b=k55Jjoeo5q//FEfcgyuuzcWgoXytoi/miHl3fW8CMYm7sbfczLbOOxF3qxSzqIBJ/d
         zpUeonSxcVgrYrikWhvfevSzJnVZVUZK+2BwyDCszBoTJEbRUhVPv4b0CnM8aQKNYN8n
         34Ek7dBtc/Np7qatWHLWTrqx3+ZeBylr/BaXi5bZ0UruQnaYbpWa7YXAuCCETqHXtI1W
         f0BSJEYAst5fYbTp/67L90mk2cU4ANe/F8efB9FSZ4WmrNoeva+nMxlR1Axt2YvXBSf1
         iy5yDmTblTEP2W6Q33PC7Zzsq1iRDynH69GfZ1iacCEQF9ex6u66BC0BLGeIsMXuEg6p
         GLZA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:sender:from:to:cc:subject:references:date
         :in-reply-to:message-id:user-agent:mime-version
         :content-transfer-encoding;
        bh=z5Q0mVUUxWDxAfdB2h8kbQMtaeQoXR1U24T9XP2klJg=;
        b=G+xE2vf2z1XmRLovdg0m0CKXwN/YnxQn7g35K8cZz0dF0D1J6ttOQO28/L0sGKcj6l
         gwN6o8Rg+XkYp4u3srQByvtuy1U80eOFG/WvFn/DcfZyaxN9P4PRbUsW9BQ0eZ8gIMzG
         bU2CBUp3sKh6hJiGosmi0s/qjT068QBGmz9FHfZ9nqZssZwzQn37DBNeDJm2pi6YqxOU
         7KesQuaRhuraPCXlN9ZMKH6XBu7nX4p6SC6aw+NUWw5MS74jdUlz7qOmQVeZPBUZYjcU
         TNa1BwI8q78GZ+BMv2kIsi6NmA1MhkG3Tvzfo7yQQ2cl5MG0UZxl7ao8xL0PYp5eaRhA
         7z4g==
X-Gm-Message-State: AMke39mp84u5wITHaiJjPfX0PLPzd04xcapBaNBMRy3cj2IRthheALuTzu4mtQD3B64RSg==
X-Received: by 10.98.184.1 with SMTP id p1mr3746601pfe.127.1487785846932;
        Wed, 22 Feb 2017 09:50:46 -0800 (PST)
Received: from localhost ([2620:0:1000:8622:21a0:716b:e013:d129])
        by smtp.gmail.com with ESMTPSA id s8sm4940568pfj.30.2017.02.22.09.50.45
        (version=TLS1_2 cipher=AES128-SHA bits=128/128);
        Wed, 22 Feb 2017 09:50:46 -0800 (PST)
From:   Junio C Hamano <gitster@pobox.com>
To:     "brian m. carlson" <sandals@crustytoothpaste.net>
Cc:     git@vger.kernel.org, Casey Rodarmor <casey@rodarmor.com>
Subject: Re: [PATCH] Documentation: correctly spell git worktree --detach
References: <CANLPe+OaSnNb1jhAnFtMsOCfho0H7mHVHiXs7rqo6ZHNvRe3-w@mail.gmail.com>
        <20170222123442.923694-1-sandals@crustytoothpaste.net>
Date:   Wed, 22 Feb 2017 09:50:45 -0800
In-Reply-To: <20170222123442.923694-1-sandals@crustytoothpaste.net> (brian
        m. carlson's message of "Wed, 22 Feb 2017 12:34:42 +0000")
Message-ID: <xmqq7f4icdxm.fsf@gitster.mtv.corp.google.com>
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/25.1.91 (gnu/linux)
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: 8bit
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

"brian m. carlson" <sandals@crustytoothpaste.net> writes:

> The option is “--detach”, but we accidentally spelled it “--detached” at
> one point in the man page.
>
> Signed-off-by: brian m. carlson <sandals@crustytoothpaste.net>
> Reported-by: Casey Rodarmor <casey@rodarmor.com>
> ---

Thanks, both.

>  Documentation/git-worktree.txt | 2 +-
>  1 file changed, 1 insertion(+), 1 deletion(-)
>
> diff --git a/Documentation/git-worktree.txt b/Documentation/git-worktree.txt
> index e257c19ebe..553cf8413f 100644
> --- a/Documentation/git-worktree.txt
> +++ b/Documentation/git-worktree.txt
> @@ -52,7 +52,7 @@ is linked to the current repository, sharing everything except working
>  directory specific files such as HEAD, index, etc. `-` may also be
>  specified as `<branch>`; it is synonymous with `@{-1}`.
>  +
> -If `<branch>` is omitted and neither `-b` nor `-B` nor `--detached` used,
> +If `<branch>` is omitted and neither `-b` nor `-B` nor `--detach` used,
>  then, as a convenience, a new branch based at HEAD is created automatically,
>  as if `-b $(basename <path>)` was specified.
>  
