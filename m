Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.1 (2015-04-28) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-4.0 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,RCVD_IN_DNSWL_HI
	shortcircuit=no autolearn=ham autolearn_force=no version=3.4.1
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 3C86B1F453
	for <e@80x24.org>; Sat, 29 Sep 2018 13:54:07 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728278AbeI2UWi (ORCPT <rfc822;e@80x24.org>);
        Sat, 29 Sep 2018 16:22:38 -0400
Received: from mail-io1-f67.google.com ([209.85.166.67]:40972 "EHLO
        mail-io1-f67.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1728202AbeI2UWi (ORCPT <rfc822;git@vger.kernel.org>);
        Sat, 29 Sep 2018 16:22:38 -0400
Received: by mail-io1-f67.google.com with SMTP id q4-v6so6210597iob.8
        for <git@vger.kernel.org>; Sat, 29 Sep 2018 06:54:05 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=CBK9qFxB5CdcyrFE5zF/S+Ts0cp6q8WGLEuN3Oz1jsw=;
        b=TUKo+VpiDwXd7zBjEZSzJODQ2cY3h/I6TtLN2N74Uiwf4st4681uJjHKojX1LBJu7q
         zfNC1SHYblNDAyEkuY8pYQBV8eSAU8ODWU30u4WYNhNExSwVY6WGUjhniwkBztlBJXXw
         hP3NdPyd+FpXha0EOqLEj+Q6II12ksbYKtjhNL5UnMK6aY+PI32nTllWDkyzgkEYuXNR
         qTJXmd5epfL4dLz9IHhK4C2B+Hn5qDYfvf9xUsglGrfLxcIIkKgc6Hbdc1/o/OUgVrmL
         pmhokNHaAJUKv68st0fMNwd2C+tNyhrc8+pNr7gf5eXEusRxGCXdfe6ZXn6K8LAaVl2E
         zuyw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=CBK9qFxB5CdcyrFE5zF/S+Ts0cp6q8WGLEuN3Oz1jsw=;
        b=d3NCu7P0677x4xA5CW7gB3FXeTOwsS2BmDJpFMC5HPDeGMEJThRNxss7xiQkJW3Uu8
         uMVkakwh/RZxCBfqXYvZa/FxRTAOIzSvFbZ5SuFruzw18enjevnOHPwk+/hCjwoyJwTT
         aEgXAC4DOSOMhz8T6yag0Jq7+p5y97grAu05W7kB6g7UQEJQ3UhajmixhMTke4iKXxAS
         uFaBuzXRAhQIRdZewj5IYRHbNYfAoX61h0TF/w5NU3XYTF1c/1WlXukdXviVgEgalQZF
         fqjaqfy04bXAcouSzH+g7n9cE0HLbqG0z/UjhijGwf7ulFFZzMssgpB0+WEA0gMU3LMC
         0i0A==
X-Gm-Message-State: ABuFfojx3V2kYoLW3AgHBYADO1hhqC0hlNTPFVYk9XX7/SY6I8tcxgs8
        je6cICrThTTGrWVOUsEBKSMM9P4dsaxK5fMFEqY=
X-Google-Smtp-Source: ACcGV60TO1c13dwgdgJH5ZHJFA+Jl9R9DqMu4ohnrC+ojngGwcO5N7vQ/vg0c1dJ3c0tc1TphJXlPYzG34wA5CQAHC4=
X-Received: by 2002:a6b:6f0f:: with SMTP id k15-v6mr924805ioc.236.1538229245027;
 Sat, 29 Sep 2018 06:54:05 -0700 (PDT)
MIME-Version: 1.0
References: <20180923170438.23610-1-pclouds@gmail.com> <20180924142143.GD68796@syl>
In-Reply-To: <20180924142143.GD68796@syl>
From:   Duy Nguyen <pclouds@gmail.com>
Date:   Sat, 29 Sep 2018 15:53:38 +0200
Message-ID: <CACsJy8AqX+ckqxLpf5HtpfSJi=gkfodTNQP_mQb=LC-Dgvih=Q@mail.gmail.com>
Subject: Re: [PATCH] worktree: add per-worktree config files
To:     Taylor Blau <me@ttaylorr.com>
Cc:     Git Mailing List <git@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

On Mon, Sep 24, 2018 at 4:21 PM Taylor Blau <me@ttaylorr.com> wrote:
> > @@ -602,6 +605,7 @@ int cmd_config(int argc, const char **argv, const char *prefix)
> >                            PARSE_OPT_STOP_AT_NON_OPTION);
> >
> >       if (use_global_config + use_system_config + use_local_config +
> > +         use_worktree_config +
> >           !!given_config_source.file + !!given_config_source.blob > 1) {
>
> I feel like we're getting into "let's extract a function" territory,
> here, since this line is growing in width. Perhaps:
>
>   static int config_files_count()
>   {
>     return use_global_config + use_system_config + use_local_config +
>                 use_worktree_config +
>                 !!given_config_source.file +
>                 !!given_config_source.blob;
>   }
>
> Simplifying the call to:

I think there's a bigger problem here because we have no good way to
describe that a bunch of options are mutually exclusive. We get by ok
if the number of options is two, but when it gets bigger (and this is
not the only place), it gets messier. Besides the long "if" condition,
I consider the error message "only one config file at a time"
inadequate. We should tell the user what exact options are
conflicting.

So, I'm going to bury my head in the sand this time and ignore the
problem, including adding config_files_count(). It could be a
interesting mini project if someone wants to jump in. Meanwhile it'll
go to the very bottom of my long long backlog.
-- 
Duy
