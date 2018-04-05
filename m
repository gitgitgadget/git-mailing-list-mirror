Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-3.4 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_HI,
	T_RP_MATCHES_RCVD shortcircuit=no autolearn=ham autolearn_force=no
	version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 70CA01F404
	for <e@80x24.org>; Thu,  5 Apr 2018 17:49:24 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1751518AbeDERtW (ORCPT <rfc822;e@80x24.org>);
        Thu, 5 Apr 2018 13:49:22 -0400
Received: from mail-yb0-f195.google.com ([209.85.213.195]:38323 "EHLO
        mail-yb0-f195.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1751399AbeDERtV (ORCPT <rfc822;git@vger.kernel.org>);
        Thu, 5 Apr 2018 13:49:21 -0400
Received: by mail-yb0-f195.google.com with SMTP id k1-v6so5828275yba.5
        for <git@vger.kernel.org>; Thu, 05 Apr 2018 10:49:21 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20161025;
        h=mime-version:in-reply-to:references:from:date:message-id:subject:to
         :cc;
        bh=AfRSlc+fS3sZXNTqDL1gzllep0fd4rgze/h7/WY9QTE=;
        b=SQ+8Ws33SHV2l2z+okW9U/jlgomzfmh1uMLxvwwJJJWWJffTpP3YyhMtyMt12lJB7X
         JaPkvUI27Wa4HWYlVlMna6I+yOOEDG+UIs2YtxLZ3F2T9Y44EIeWUxnsLPPzODQYGlPL
         hNrn6dvw/5FWOZ5MiSBhBHB70IgN0trikgGGw51nrqDK8Lla6BloPtMeO4SyJkHjgOQT
         y9arPh5mdka2HY/nuzxDfxhtuXKPXNRaxFyfshCQtx6cX3lkSwNMp9nnlyeeERSu33Kn
         rUJ3lzWkBN6epbpN8lH/UR+2aOTTO+z9BkE6So9Jpyg9HPL8uP1ewqxw8PLnhs0XjtO8
         2MlA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:in-reply-to:references:from:date
         :message-id:subject:to:cc;
        bh=AfRSlc+fS3sZXNTqDL1gzllep0fd4rgze/h7/WY9QTE=;
        b=T6m708uF4SmQW9hPgF7oGoXots17iAbfO+85LgNJPyi5m5g/bGo0ZTKGDGLdxdz4yV
         mLeTSs1xeTAREDBQYLCUiGzcED/bErYw/5CghiNM5zYLUf5vZRbzTSIXsQsfJUu814+I
         7dUKIFgLLH44oV07WKkyNGrdIXh/QgZajhXuZG3pRb78wMUNjYg/Ja4iMGMWyAyMUAdT
         QIp+ccU0FqKQwBeOLTHsnuA66zbjKwOe6tcNFyqUb2anEocSioffbCXbJvTpo+CvtIK8
         sw0ylrBcyjr64Skl48T5zA8HZTKpTh8MO5ZXPPEisXEJJPXXNXxOO9DjIsYUduFLVg4v
         M84g==
X-Gm-Message-State: ALQs6tDY4i7p6VN1KeHVBgobHE+yRdaDOsQ3MJcLoexvSNoYo1BLWTCF
        QTG8HbxLS936bxuPe99GPrd9JCaEQxCk3ug7h5hdJw==
X-Google-Smtp-Source: AIpwx490dDAiviziSqJo3V+vclxFtL6Kj8WAZB5TQV4Shdq4oWzCKXVId7ZFTQYjuN4M0AgjmzCt9FVj1aODasNj9Uw=
X-Received: by 2002:a25:ba51:: with SMTP id z17-v6mr10877141ybj.334.1522950560759;
 Thu, 05 Apr 2018 10:49:20 -0700 (PDT)
MIME-Version: 1.0
Received: by 2002:a25:cf81:0:0:0:0:0 with HTTP; Thu, 5 Apr 2018 10:49:20 -0700 (PDT)
In-Reply-To: <20180405172027.31515-2-newren@gmail.com>
References: <20180405172027.31515-1-newren@gmail.com> <20180405172027.31515-2-newren@gmail.com>
From:   Stefan Beller <sbeller@google.com>
Date:   Thu, 5 Apr 2018 10:49:20 -0700
Message-ID: <CAGZ79kZQ-14nCb-eV0O2vtqf3fwJBSTQHm5g_7_m-aVZ80mdpQ@mail.gmail.com>
Subject: Re: [PATCH 2/2] Documentation: Normalize spelling of 'normalised'
To:     Elijah Newren <newren@gmail.com>
Cc:     git <git@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

On Thu, Apr 5, 2018 at 10:20 AM, Elijah Newren <newren@gmail.com> wrote:
> This could be a localization issue, but we had about four dozen
> "normalize"s (or variants, e.g. normalized, renormalize, etc.), and only
> one "normalised" (no other variants), so normalize normalised into
> normalized.

This and the previous patch are
Reviewed-by: Stefan Beller <sbeller@google.com>

> Signed-off-by: Elijah Newren <newren@gmail.com>
> ---
>  Documentation/git-mktree.txt | 2 +-
>  1 file changed, 1 insertion(+), 1 deletion(-)
>
> diff --git a/Documentation/git-mktree.txt b/Documentation/git-mktree.txt
> index c3616e7711..27fe2b32e1 100644
> --- a/Documentation/git-mktree.txt
> +++ b/Documentation/git-mktree.txt
> @@ -14,7 +14,7 @@ SYNOPSIS
>  DESCRIPTION
>  -----------
>  Reads standard input in non-recursive `ls-tree` output format, and creates
> -a tree object.  The order of the tree entries is normalised by mktree so
> +a tree object.  The order of the tree entries is normalized by mktree so
>  pre-sorting the input is not required.  The object name of the tree object
>  built is written to the standard output.
>
> --
> 2.17.0.7.g0b50f94d69
>
