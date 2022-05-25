Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 9A02BC433EF
	for <git@archiver.kernel.org>; Wed, 25 May 2022 05:30:08 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S243976AbiEYFaH (ORCPT <rfc822;git@archiver.kernel.org>);
        Wed, 25 May 2022 01:30:07 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:57292 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S237184AbiEYFaF (ORCPT <rfc822;git@vger.kernel.org>);
        Wed, 25 May 2022 01:30:05 -0400
Received: from mail-yb1-xb2b.google.com (mail-yb1-xb2b.google.com [IPv6:2607:f8b0:4864:20::b2b])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 47C5E5522B
        for <git@vger.kernel.org>; Tue, 24 May 2022 22:30:03 -0700 (PDT)
Received: by mail-yb1-xb2b.google.com with SMTP id z7so13171064ybf.7
        for <git@vger.kernel.org>; Tue, 24 May 2022 22:30:03 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=9NjEJ7Ee25R/C9OMq7JmJ+mhFL5b/rp0JjdfynG06Ro=;
        b=gAbMYGUtbEp6dg9V76IXKxRduHP+WkOWMIJq3U1sa3EBbDFQzvgoCJYzOcMmr0WYHf
         SIKVLaf14YGNM8+3KXdVRJYL6tHY0cvTbowCSux96xHAyBTgAxndmn3/dzfGhB79xJW7
         ytXMRuEzKkPl0zpzhtRG1vNAocU6RSADNHj9SOwjdyX3Xpst5rdtZAJLT/84BynItn+K
         tDPAj7dajIy6G+ZauT62M4ZCX7Mr6b/nodyh8xuAC8g5Kb4uCwazNWGzSq4dxQ1CsjT/
         NSuQ6FtTSjww1oOeqRQykKN7Y2w4Gb+LHkrgx1Qt8ZAJzinGc01X/OCLZNGNpZZjFGUR
         P30g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=9NjEJ7Ee25R/C9OMq7JmJ+mhFL5b/rp0JjdfynG06Ro=;
        b=sEZJV7Wgf/fe/kFDqwshQCqJsXYsPm7yBu8UjAON6n2o2P7VV4WsH7ZwGHOAXS1AQK
         avVVUMZBPEmzcme4mPEuWzURFc2DTDfON/YfAjEJHpBKyGHSwauLE1nF8RmIbisMs4p+
         yZishBTxZ29gYHX6njPhsxBfZNqv0vxaQBmoSYnYbxLvMHwQsV8X5jhLJkfTac1T4oCV
         dAyA3KFPC/mSVtuvCBRrTxw/cTJSeShKZCgQ6Y7YMVMeJudZt+1XhCejk2GD59i7MCmq
         OsXNxCXzHZLy6HBsndvg6uqkcSE9cNdJdBKENg5HjBp79UX22Pj5psfg/hVc+xX/xIbR
         HiYw==
X-Gm-Message-State: AOAM530eH5BTB/g4/1TvqMpF/1ZxiYSJ5vcWze+fRyz7t4T7Asi/4DlZ
        tJA9PVvqvJgKAMiBmPW33AKM5AqiMPPmIWs6+f0=
X-Google-Smtp-Source: ABdhPJyx7YcsSeNnHDhY1zRvP79pwxdktp4RIKOY29OpVNFcaXWp48jXhimUiJC3VP9Ie9xD29E463NF2uppbLs1qDU=
X-Received: by 2002:a05:6902:1242:b0:64f:9d9c:eaab with SMTP id
 t2-20020a056902124200b0064f9d9ceaabmr17850815ybu.346.1653456602422; Tue, 24
 May 2022 22:30:02 -0700 (PDT)
MIME-Version: 1.0
References: <pull.1241.git.1653424998869.gitgitgadget@gmail.com>
In-Reply-To: <pull.1241.git.1653424998869.gitgitgadget@gmail.com>
From:   Christian Couder <christian.couder@gmail.com>
Date:   Wed, 25 May 2022 07:29:50 +0200
Message-ID: <CAP8UFD2BS3OuJD7xhb6M+bX3ojLqM8ZuXK_h4w0CvdYRfmzVqg@mail.gmail.com>
Subject: Re: [PATCH] Fix wrong info in `INSTALL`
To:     Shao-Ce SUN via GitGitGadget <gitgitgadget@gmail.com>
Cc:     git <git@vger.kernel.org>, Shao-Ce SUN <sunshaoce@iscas.ac.cn>
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

On Wed, May 25, 2022 at 6:35 AM Shao-Ce SUN via GitGitGadget
<gitgitgadget@gmail.com> wrote:
>
> From: Shao-Ce SUN <sunshaoce@iscas.ac.cn>
>
> The user prompt should be `$` instead of `#`.

On the following lines:

$ make prefix=/usr all doc info ;# as yourself
# make prefix=/usr install install-doc install-html install-info ;# as root

the '$' or '#' before "make" is indeed a prompt, but the '#' before
"as" starts a single line comment. So there is no need to change it
into a '$'.

See for example:

https://tldp.org/LDP/abs/html/abs-guide.html#SPECIAL-CHARS

One issue with the above lines could be that there is no space
character before the '#' that starts the comments. The ';' is a
command separator character though, and I think that when a new
command starts with '#' it's considered a comment.

So we could perhaps get rid of the ';', but on the other hand ";#"
should make it extra clear that the command before it ended and that
the rest of the line is a comment.

> Signed-off-by: Shao-Ce SUN <sunshaoce@iscas.ac.cn>
> ---
>     Fix wrong info in INSTALL

Instead of "info" you could say something more specific like "prompt character".

Also we start commit subjects with the area of the code, so maybe
"INSTALL: fix wrong prompt character".

> diff --git a/INSTALL b/INSTALL
> index 4140a3f5c8b..7bb3f48311d 100644
> --- a/INSTALL
> +++ b/INSTALL
> @@ -5,8 +5,8 @@ Normally you can just do "make" followed by "make install", and that
>  will install the git programs in your own ~/bin/ directory.  If you want
>  to do a global install, you can do
>
> -       $ make prefix=/usr all doc info ;# as yourself
> -       # make prefix=/usr install install-doc install-html install-info ;# as root
> +       $ make prefix=/usr all doc info ; $ as yourself

Here a '#' is changed into a '$' but also a space character is
inserted before the '$' without any explanation.

> +       # make prefix=/usr install install-doc install-html install-info ; # as root

Here only a space character is inserted before the second '#' without
any explanation.
