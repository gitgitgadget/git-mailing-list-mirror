Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-3.3 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_HI,RCVD_IN_SORBS_SPAM,
	RP_MATCHES_RCVD shortcircuit=no autolearn=no autolearn_force=no version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 402592023D
	for <e@80x24.org>; Tue, 23 May 2017 06:06:59 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S936187AbdEWGGw (ORCPT <rfc822;e@80x24.org>);
        Tue, 23 May 2017 02:06:52 -0400
Received: from mail-qk0-f177.google.com ([209.85.220.177]:36146 "EHLO
        mail-qk0-f177.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S932903AbdEWGGv (ORCPT <rfc822;git@vger.kernel.org>);
        Tue, 23 May 2017 02:06:51 -0400
Received: by mail-qk0-f177.google.com with SMTP id u75so122964642qka.3
        for <git@vger.kernel.org>; Mon, 22 May 2017 23:06:50 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=mime-version:in-reply-to:references:from:date:message-id:subject:to
         :cc;
        bh=qMeRKdF9ShPiZttBQC2kf6UDXtEITmN4hiy5+a7M6Q8=;
        b=DhPVfg2V7V83JwxrPbmXb5zrBsFDYHbeyszxguI1iyCruy6878mAoxfnwIQ3FqKBQU
         F8beBm9DzqUxVKw3WEHs4W41mbp5wPjJWlgs0nAqe+dFLXmIPnVpsUu7HD7DoVe1eq0F
         IHCW7M49gvyrO7bCVR/6YDa6RILoZIcV6SB0bQtuQsZ/e/DIywAMSs69mjcQtzCTxX5v
         4LiZluGrfK19zDBUcTKAF86jXqXea+q1HkGw7Y+4Zc33RTYC17hQdjuPoA2os32q7+ry
         HK5Ri1iclsK+VqyY5wzVCqkleaqMajs0nVGBTPPYKsLvvxFCnx2CkwPfUulaAEET4MJv
         u6IA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:in-reply-to:references:from:date
         :message-id:subject:to:cc;
        bh=qMeRKdF9ShPiZttBQC2kf6UDXtEITmN4hiy5+a7M6Q8=;
        b=bAAYzT9tqK6EY+BcXujkQQ9E8KcgyNM7joAsNYOgLPVtp8U4ZmqecsyNPtxIua2iQL
         O1ws2z/N1EM24kL7MEEfk4SPWl9BsWU3VbM0i8TO+Vm1JzgCThdfyJZZjE+9EB6NLtMz
         J32FnrC6ZClCsOUmCkGX/2tHeLWeEbpDhig3iFu3FlSsMlePxXFjVWpcr9ulgTjeySY5
         2gYN/CJ0yeZfL5ync+4Mh67dXJ/XzQE0k75DRVB0Kt8ZjBwhEjosZKEXzZKDr4YlJ9bn
         mEOkk1T8uZHpStJUf2efgtcPdbfhUv1/ZLWjBbGakEv8whyvAQn4VHVfirfrFzhzmEM8
         JTWw==
X-Gm-Message-State: AODbwcB3t36WceWvYtCT+hC2Tonfav6AyGszx6xoaPSkVJviFHuIEYOT
        kTC86mBAFtI+KYrbesY4aV/v1Y94GA==
X-Received: by 10.55.68.81 with SMTP id r78mr28022757qka.102.1495519610128;
 Mon, 22 May 2017 23:06:50 -0700 (PDT)
MIME-Version: 1.0
Received: by 10.55.78.212 with HTTP; Mon, 22 May 2017 23:06:49 -0700 (PDT)
In-Reply-To: <20170522194533.6394-1-asheiduk@gmail.com>
References: <20170522194533.6394-1-asheiduk@gmail.com>
From:   Christian Couder <christian.couder@gmail.com>
Date:   Tue, 23 May 2017 08:06:49 +0200
Message-ID: <CAP8UFD1shjAxoT2Zr+fvzoaF7cgrE-U1BOycuV4zAkNDbJwKQA@mail.gmail.com>
Subject: Re: [PATCH] Documentation: Fix reference to isExists for interpret-trailers
To:     Andreas Heiduk <asheiduk@gmail.com>
Cc:     Junio C Hamano <gitster@pobox.com>, git <git@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

On Mon, May 22, 2017 at 9:45 PM, Andreas Heiduk <asheiduk@gmail.com> wrote:
> The manual for "git interpret-trailers" mentioned a non-existing
> literal `overwrite` for its config option `trailer.ifexists`. Fixed
> by using `replace` instead.

Yeah, I forgot to change it to `replace` there.

> Signed-off-by: Andreas Heiduk <asheiduk@gmail.com>
> ---
>  Documentation/git-interpret-trailers.txt | 2 +-
>  1 file changed, 1 insertion(+), 1 deletion(-)
>
> diff --git a/Documentation/git-interpret-trailers.txt b/Documentation/git-interpret-trailers.txt
> index 09074c75a..31cdeaecd 100644
> --- a/Documentation/git-interpret-trailers.txt
> +++ b/Documentation/git-interpret-trailers.txt
> @@ -123,7 +123,7 @@ trailer.ifexists::
>         same <token> in the message.
>  +
>  The valid values for this option are: `addIfDifferentNeighbor` (this
> -is the default), `addIfDifferent`, `add`, `overwrite` or `doNothing`.
> +is the default), `addIfDifferent`, `add`, `replace` or `doNothing`.

Yeah, this looks obviously good to me.

Thanks,
Christian.
