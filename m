Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-3.8 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_HI,RCVD_IN_SORBS_SPAM,
	RP_MATCHES_RCVD shortcircuit=no autolearn=no autolearn_force=no version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 0A7501FAFC
	for <e@80x24.org>; Sat,  4 Feb 2017 05:58:35 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1753670AbdBDF6c (ORCPT <rfc822;e@80x24.org>);
        Sat, 4 Feb 2017 00:58:32 -0500
Received: from mail-lf0-f66.google.com ([209.85.215.66]:35727 "EHLO
        mail-lf0-f66.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1753539AbdBDF6b (ORCPT <rfc822;git@vger.kernel.org>);
        Sat, 4 Feb 2017 00:58:31 -0500
Received: by mail-lf0-f66.google.com with SMTP id v186so3017554lfa.2
        for <git@vger.kernel.org>; Fri, 03 Feb 2017 21:58:31 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=mime-version:in-reply-to:references:from:date:message-id:subject:to
         :cc;
        bh=5FtgsfqAIfrcN33hVFiHoIR00/ZLBfGm0vX8yTPlnAY=;
        b=IJ1sTOO18ZfxOHF3j2VodUuIPtoR0Qt6+DcIwi67NurjX70cyRpQqO5zxypQBOLeP9
         RVkpGqk2U5lPIG7Y7UCfUoG/63NLvvpqISLtRfvWTiWPnmOMLJaiDjKhNCYD1/6KwgRo
         6rKP29VO0gKGlkb4abrl0Ors+JpvQtJR+Fxxj9v7WDfjxH4EcPirRNHQu4w18H24G10+
         i8gHfehSUBvgiRxhbn3oapxis5iY7AJAgMfiCxJ6Xh80dL3IgjttM3Fb3bGevKcjpcZ5
         pLoSsUeX6qykn4LyS92d5sqjgJ/fRQQja6K0hbtz5i1z6b2wHeL8FnQemWtFfr7LB66c
         3/zQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:in-reply-to:references:from:date
         :message-id:subject:to:cc;
        bh=5FtgsfqAIfrcN33hVFiHoIR00/ZLBfGm0vX8yTPlnAY=;
        b=ACWHJQpSIj/HmT//f2AfaSn89HBK2CvIFP8aYmlFL4toWlnympPm/dxqELXnBvZGIO
         YgTUQ+LU5pBVmzOZR7pY2fkr0Mar4DTZSP9HYNEl8Y/8q62dHneQ2gn+6F3qpxDHDxg6
         2ufDqSsW7/1Z1hIRI2Dx/gPZrQiAwfV4ypn9ni/uNHsnawx6t8/W6AkG921/IOsWgO++
         X5QOlfCmfOK3XMEDdbI7XHp5CVfm0GW2qt5QWxZ6UcS3xVvXkrGP7w/2SgC0BIl5S8EW
         qxOIcCDDBnTYTT/b/QnJuCRNWl0D7fwUFW2Nw5PGP4NU9rPECUCB/EKJKotGAA2Mp2Jm
         GemA==
X-Gm-Message-State: AMke39mZ79GmYoTfw+56O9QEkuw1wM/Gzv5SlPfHXJHYsU4jRz/Iz8PCD8tSdTfRtRAR8brhKPeBnxy1gOV6Gw==
X-Received: by 10.25.10.6 with SMTP id 6mr239804lfk.88.1486187909865; Fri, 03
 Feb 2017 21:58:29 -0800 (PST)
MIME-Version: 1.0
Received: by 10.25.145.14 with HTTP; Fri, 3 Feb 2017 21:58:09 -0800 (PST)
In-Reply-To: <20170204025617.GA9221@arch-attack.localdomain>
References: <20170204025617.GA9221@arch-attack.localdomain>
From:   Jacob Keller <jacob.keller@gmail.com>
Date:   Fri, 3 Feb 2017 21:58:09 -0800
Message-ID: <CA+P7+xoXWP=Cuqw3Pa1sFCChiw6wbNTEpvNm3WDuBHQPc_OjnA@mail.gmail.com>
Subject: Re: [PATCH] Remove --no-gui option from difftool usage string
To:     Denton Liu <liu.denton@gmail.com>
Cc:     Git mailing list <git@vger.kernel.org>
Content-Type: text/plain; charset=UTF-8
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

On Fri, Feb 3, 2017 at 6:56 PM, Denton Liu <liu.denton@gmail.com> wrote:
> The --no-gui option not documented in the manpage, nor is it actually
> used in the source code. This change removes it from the usage help
> that's printed.
>
> Signed-off-by: Denton Liu <liu.denton@gmail.com>
> ---
>  git-difftool.perl | 4 ++--
>  1 file changed, 2 insertions(+), 2 deletions(-)
>
> diff --git a/git-difftool.perl b/git-difftool.perl
> index a5790d03a..657d5622d 100755
> --- a/git-difftool.perl
> +++ b/git-difftool.perl
> @@ -29,8 +29,8 @@ sub usage
>         print << 'USAGE';
>  usage: git difftool [-t|--tool=<tool>] [--tool-help]
>                      [-x|--extcmd=<cmd>]
> -                    [-g|--gui] [--no-gui]
> -                    [--prompt] [-y|--no-prompt]
> +                    [-g|--gui] [--prompt]
> +                    [-y|--no-prompt]
>                      [-d|--dir-diff]
>                      ['git diff' options]
>  USAGE
> --
> 2.11.0
>

Aren't "--no-foo" options automatically created for booleans when
using our option parsing code?

Thanks,
Jake
