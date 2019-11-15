Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.2 (2018-09-13) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-3.8 required=3.0 tests=AWL,BAYES_00,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,RCVD_IN_DNSWL_HI,
	SPF_HELO_NONE,SPF_NONE shortcircuit=no autolearn=ham
	autolearn_force=no version=3.4.2
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 8AD691F4B5
	for <e@80x24.org>; Fri, 15 Nov 2019 18:22:24 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726549AbfKOSWX (ORCPT <rfc822;e@80x24.org>);
        Fri, 15 Nov 2019 13:22:23 -0500
Received: from mail-wr1-f67.google.com ([209.85.221.67]:43815 "EHLO
        mail-wr1-f67.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726131AbfKOSWX (ORCPT <rfc822;git@vger.kernel.org>);
        Fri, 15 Nov 2019 13:22:23 -0500
Received: by mail-wr1-f67.google.com with SMTP id n1so11964211wra.10
        for <git@vger.kernel.org>; Fri, 15 Nov 2019 10:22:22 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=S3KsD5+XsHHxEY/aa73zvYOtLWS+B79eSrSh4NNIBU0=;
        b=dGX+BMlUO+6b6LfbEFOaRqA/z0iF9U+locNta1o2ycAE1uHxl9HKN06xigNfCFBHNQ
         wN4fGXqYwe/iW/tLOgVEG8NvgFqTuemGr3F7tJ+zeQcAbBfeMWsJfO48cWBTJO9xPU5G
         AnV07zs3lqKuGc/gvzS3PB1FPHiHHgxTdQQy+WSj7b3hqEP5t1iS3M5+XZ/pDk4FE8Cb
         x0QiFD1a8R7zAjWgdDoBnWQuX1bxiaO6SrBQwVP32mBLE/Z0Z8aiW2xKFEn+9DuG9Q3+
         PMp5nO+880BvkLkkNa9ljrtxfu8cimdg7clyGaSHOu8/Btd9eu+2zW1e9FBBTpocIOG4
         1vag==
X-Gm-Message-State: APjAAAXRxBv0MaQvfIf9SOT9ZzrfhJV7Qw/3hpNwR9N3ErKfYhaY0SOh
        A8nOxP5Q4tDa+lNDtk5Z0RdBbo7w4u3WUjEgpPg=
X-Google-Smtp-Source: APXvYqyLigCBc+0w2d5sb1BSkwpDaFXi4l4AtDUQvC0RQrkW8s3GNEaO0vyCGBZ9nsOfNMVRcRCHZh3y7ZtIQLeTbdc=
X-Received: by 2002:a5d:42d1:: with SMTP id t17mr4503510wrr.56.1573842141556;
 Fri, 15 Nov 2019 10:22:21 -0800 (PST)
MIME-Version: 1.0
References: <cover.1573779465.git.liu.denton@gmail.com> <b4442fb408c80cf6c4d8fd05b474c0094e243126.1573779465.git.liu.denton@gmail.com>
In-Reply-To: <b4442fb408c80cf6c4d8fd05b474c0094e243126.1573779465.git.liu.denton@gmail.com>
From:   Eric Sunshine <sunshine@sunshineco.com>
Date:   Fri, 15 Nov 2019 13:22:09 -0500
Message-ID: <CAPig+cQx=kOZrsR9d05qK9KTnR5X8gAXf0jMysK+njPbX-_6SQ@mail.gmail.com>
Subject: Re: [PATCH 01/27] lib-bash.sh: move `then` onto its own line
To:     Denton Liu <liu.denton@gmail.com>
Cc:     Git Mailing List <git@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

On Thu, Nov 14, 2019 at 8:00 PM Denton Liu <liu.denton@gmail.com> wrote:
> The code style for tests is to have statements on their own line if
> possible. Move the `then` onto its own line so that it conforms with the
> test style.
>
> Signed-off-by: Denton Liu <liu.denton@gmail.com>
> ---
> diff --git a/t/lib-bash.sh b/t/lib-bash.sh
> @@ -2,7 +2,8 @@
> -if test -n "$BASH" && test -z "$POSIXLY_CORRECT"; then
> +if test -n "$BASH" && test -z "$POSIXLY_CORRECT"
> +then

Okay...

>         # we are in full-on bash mode
>         true
>  elif type bash >/dev/null 2>&1; then

... but why not move this 'then' to its own line, as well?
