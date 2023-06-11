Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 6C51CC7EE29
	for <git@archiver.kernel.org>; Sun, 11 Jun 2023 02:36:47 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229869AbjFKCgp convert rfc822-to-8bit (ORCPT
        <rfc822;git@archiver.kernel.org>); Sat, 10 Jun 2023 22:36:45 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:34550 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229450AbjFKCgn (ORCPT <rfc822;git@vger.kernel.org>);
        Sat, 10 Jun 2023 22:36:43 -0400
Received: from mail-qv1-f44.google.com (mail-qv1-f44.google.com [209.85.219.44])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 3A67510A
        for <git@vger.kernel.org>; Sat, 10 Jun 2023 19:36:43 -0700 (PDT)
Received: by mail-qv1-f44.google.com with SMTP id 6a1803df08f44-62de651bcf0so1090396d6.2
        for <git@vger.kernel.org>; Sat, 10 Jun 2023 19:36:43 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1686451002; x=1689043002;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=0cZd3r4rFJdiE2DY12Sy0i9M0tjY4pEkuN4oRw5dFLo=;
        b=FiCqsYGPuspbSsc6UijtZgQKQALemCgKtmeKt+MYh9rErkwf7XeW7fKiyfBxuR1ov7
         2XvVLZEXgbYwhCYq7wgkoi4IUB/hG6oyiz9nJYzR32QUL37L0lnC2LjAumItgwPenjgN
         QLjNasC34MKx80Vw1x3ESaxYlPhtFRTXkgXacr9pKevNn3PAtQ8OYFrtOkBUgqr/9OzB
         GHKYDkmu7n3CMPoVKhmlpGwDjumUG4JIixb/QAhgU/I4P/i31z0d4cPp9ziT+Puv5AOg
         14n8V6hHCFqzoRdAymXQ/5xS9gR+hYMPpDofywgJr9Zwe74o0QCv1auv31XkcC3nh/as
         HIxQ==
X-Gm-Message-State: AC+VfDzEWDC4UypLDsywX2gqlHqdj0kIsz87uwmA1pvzCsHOXICQjGg7
        sPztbzrztatQDmqzOdCPCzUI/34Rv6wuMeaMANYzLTRG
X-Google-Smtp-Source: ACHHUZ72ebGDUdQKHwiYgjuhFpYtHFdE5Y5hhsBptgjRA+0127gB/JiEHmdbXhRATicKKfGueVGvWXo4bngJaYuPlo4=
X-Received: by 2002:ad4:5fca:0:b0:5af:af15:8d44 with SMTP id
 jq10-20020ad45fca000000b005afaf158d44mr7026966qvb.45.1686451002105; Sat, 10
 Jun 2023 19:36:42 -0700 (PDT)
MIME-Version: 1.0
References: <pull.1543.git.1686428484.gitgitgadget@gmail.com> <93b6233f0dd89d36c0eec7a4768f8b7d22db755b.1686428485.git.gitgitgadget@gmail.com>
In-Reply-To: <93b6233f0dd89d36c0eec7a4768f8b7d22db755b.1686428485.git.gitgitgadget@gmail.com>
From:   Eric Sunshine <sunshine@sunshineco.com>
Date:   Sat, 10 Jun 2023 22:36:31 -0400
Message-ID: <CAPig+cRPrf0dQbGKDvKkTBAXVVLWX_YcGEvg6Mcwuwe3k7bLnQ@mail.gmail.com>
Subject: Re: [PATCH 25/25] diff.c: mention completion above add_diff_options
To:     Philippe Blain via GitGitGadget <gitgitgadget@gmail.com>
Cc:     git@vger.kernel.org, Philippe Blain <levraiphilippeblain@gmail.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: 8BIT
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

On Sat, Jun 10, 2023 at 4:24 PM Philippe Blain via GitGitGadget
<gitgitgadget@gmail.com> wrote:
> Add a comment on top of add_diff_options, where common diff options are
> listed, mentioning __git_diff_common_options in the completion script,
> in the hope that contributors update it when they add new diff flags.
>
> Signed-off-by: Philippe Blain <levraiphilippeblain@gmail.com>
> ---
> diff --git a/diff.c b/diff.c
> @@ -5491,6 +5491,9 @@ static int diff_opt_rotate_to(const struct option *opt, const char *arg, int uns
>         return 0;
>  }
>
> +/* Consider adding new flags to __git_diff_common_options
> + * in contrib/completion/git-completion.bash
> + */

Style:

    /*
     * This is a multi-line
     * comment.
     */
