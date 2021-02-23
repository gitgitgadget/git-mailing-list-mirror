Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-13.8 required=3.0 tests=BAYES_00,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_CR_TRAILER,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 5880AC433DB
	for <git@archiver.kernel.org>; Tue, 23 Feb 2021 06:45:55 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 072CE60C41
	for <git@archiver.kernel.org>; Tue, 23 Feb 2021 06:45:54 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231259AbhBWGpy (ORCPT <rfc822;git@archiver.kernel.org>);
        Tue, 23 Feb 2021 01:45:54 -0500
Received: from mail-ej1-f51.google.com ([209.85.218.51]:35597 "EHLO
        mail-ej1-f51.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231268AbhBWGpw (ORCPT <rfc822;git@vger.kernel.org>);
        Tue, 23 Feb 2021 01:45:52 -0500
Received: by mail-ej1-f51.google.com with SMTP id g5so32926103ejt.2
        for <git@vger.kernel.org>; Mon, 22 Feb 2021 22:45:36 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=UelZhRoWv4e1I4sN6XDmoUUwwNWeeRgXI4dHkUbhVuw=;
        b=UltQnyBN/q7HT1TlN+L2x7POS9duMYLjvE31FzptLO/W3+aW8QdpvnNRPzwSxk9UEn
         KfZd/mhzTICsZCfWPUURn1+UytL6LmdFHDfafxEdSrUwHb4JBMqFIQJ9waT4hhnvQv63
         9dQvcWecW1nm60xWFxatT171G6gFjtd0UiKtz0VnKbCWVLVwwBH7fUT9J2t7/4y0qjhx
         lX3Z7NjgPxVJlqC4moJOIf6RDS28oy8b0X7NDgKVqLsUHv8XQN2NH1Oxa59HwFw4te5x
         ZIUHu8b25zY6Bv/l43ZpIqXucddABO+DoM+Q+VuMGxTB5yiEMKIKwias0J/4dvx5dtuL
         uajA==
X-Gm-Message-State: AOAM532B008DU5IgfN0Zu16I33VTn4lEq+Ag+5NkQJEFcces3JwMMTZW
        a5NEf51WOk1HQEjjSioXM3Ffh2ds9kZr6F9l7f45hxoG
X-Google-Smtp-Source: ABdhPJy/1KpLzONfbkhAavsGp6X5XOYcGk70LNl7NEMKiHc5yh9MYknhgPNMeIKU82UBTaWcHB3GogC0GK8mttE02tc=
X-Received: by 2002:a17:906:3105:: with SMTP id 5mr24699011ejx.168.1614062710586;
 Mon, 22 Feb 2021 22:45:10 -0800 (PST)
MIME-Version: 1.0
References: <cover.1614062288.git.liu.denton@gmail.com> <1ab7ca7fc0928b40c47b53d97695ae911ba93c39.1614062288.git.liu.denton@gmail.com>
In-Reply-To: <1ab7ca7fc0928b40c47b53d97695ae911ba93c39.1614062288.git.liu.denton@gmail.com>
From:   Eric Sunshine <sunshine@sunshineco.com>
Date:   Tue, 23 Feb 2021 01:44:59 -0500
Message-ID: <CAPig+cSgmNZ0woVyP5i9Oy0Rwh8v_7NPu9_LJzCwTV-1mK1vWg@mail.gmail.com>
Subject: Re: [PATCH 2/3] git-cat-file.txt: monospace args and placeholders
To:     Denton Liu <liu.denton@gmail.com>
Cc:     Git Mailing List <git@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

On Tue, Feb 23, 2021 at 1:41 AM Denton Liu <liu.denton@gmail.com> wrote:
> In modern documentation, args and placeholders are monospaced. Format
> all remaining args and placeholders as monospace.
>
> Signed-off-by: Denton Liu <liu.denton@gmail.com>
> ---
> diff --git a/Documentation/git-cat-file.txt b/Documentation/git-cat-file.txt
> @@ -115,7 +115,7 @@ OPTIONS
>  --allow-unknown-type::
> -       Allow -s or -t to query broken/corrupt objects of unknown type.
> +       Allow `-s` or `-t` to query broken/corrupt objects of unknown type.
>
>  --follow-symlinks::
>         With --batch or --batch-check, follow symlinks inside the

Missed these? `--batch`, `--batch-check`
