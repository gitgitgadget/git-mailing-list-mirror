Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-13.7 required=3.0 tests=BAYES_00,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_CR_TRAILER,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id D1A5BC433ED
	for <git@archiver.kernel.org>; Fri, 23 Apr 2021 21:52:06 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 97CD46141C
	for <git@archiver.kernel.org>; Fri, 23 Apr 2021 21:52:06 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232466AbhDWVwm (ORCPT <rfc822;git@archiver.kernel.org>);
        Fri, 23 Apr 2021 17:52:42 -0400
Received: from mail-ej1-f53.google.com ([209.85.218.53]:37752 "EHLO
        mail-ej1-f53.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231218AbhDWVwm (ORCPT <rfc822;git@vger.kernel.org>);
        Fri, 23 Apr 2021 17:52:42 -0400
Received: by mail-ej1-f53.google.com with SMTP id w3so75930611ejc.4
        for <git@vger.kernel.org>; Fri, 23 Apr 2021 14:52:05 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=foeSiekScXDxk/ID64yG3B19E0qjZDJ/u5t8xnkAkZ0=;
        b=pLzUvZUGgRGo0+9Jzt4VBc6CpQHXIWO5NM0nOyGEhfAm/zN0H6lWgnqQ/bXa2DzEUq
         qZKb0cb3jBqIS9VYodKWD2ds2PDJtwiYIpr/TF1M4No8Yc/bzdSsLke5Yzgyt0ue70Kg
         DvvAwNQwHUdC/Olp8oMlyXCe5cafZyFJlZbRdzJb3xeqNGDTuXjGqFDCspteRRegcmvv
         P6CvnEprJRJjLjKanebC3WZfdRcXaQb7J001AUKgICkFD5lOg996S+30nkQ5hp2Xq733
         mXby+uKPyfWHqW9Db9mS4hFXZGlpHTlBkW8LltSzVt7VyJ8nxKUqxfLuDnnBzkbrXUU8
         +TJQ==
X-Gm-Message-State: AOAM530A+6rz+fM3+7+h67C2IuBx41ZpcGfVWrKsNE5Udv+NG20hmAh7
        181YNVeeteT39gYcm1UYn/nXQJZ5Ls+lLuYd5xE=
X-Google-Smtp-Source: ABdhPJy3E3CjbK6Zrnc0c/TcIzB9J7VaeZBX79LS/iR4fcSRNHFPTVH5KvRLFUdFQxsiszCXypDWTOqwRazZVUYprK4=
X-Received: by 2002:a17:906:90b:: with SMTP id i11mr6472470ejd.168.1619214724501;
 Fri, 23 Apr 2021 14:52:04 -0700 (PDT)
MIME-Version: 1.0
References: <20210423194230.1388945-1-lukeshu@lukeshu.com> <20210423194230.1388945-5-lukeshu@lukeshu.com>
In-Reply-To: <20210423194230.1388945-5-lukeshu@lukeshu.com>
From:   Eric Sunshine <sunshine@sunshineco.com>
Date:   Fri, 23 Apr 2021 17:51:53 -0400
Message-ID: <CAPig+cT=jZdq=oDSHRF6DnvqZVo4OiPGy7x7AzTzdcy6RV76kw@mail.gmail.com>
Subject: Re: [PATCH 04/30] subtree: t7900: use consistent formatting
To:     Luke Shumaker <lukeshu@lukeshu.com>
Cc:     Git List <git@vger.kernel.org>,
        Avery Pennarun <apenwarr@gmail.com>,
        Charles Bailey <cbailey32@bloomberg.net>,
        Danny Lin <danny0838@gmail.com>,
        "David A . Greene" <greened@obbligato.org>,
        David Aguilar <davvid@gmail.com>,
        Jakub Suder <jakub.suder@gmail.com>,
        James Denholm <nod.helm@gmail.com>, Jeff King <peff@peff.net>,
        Jonathan Nieder <jrnieder@gmail.com>,
        Junio C Hamano <gitster@pobox.com>,
        =?UTF-8?B?Tmd1eeG7hW4gVGjDoWkgTmfhu41jIER1eQ==?= 
        <pclouds@gmail.com>, Roger L Strain <roger.strain@swri.org>,
        Techlive Zheng <techlivezheng@gmail.com>,
        Luke Shumaker <lukeshu@datawire.io>
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

On Fri, Apr 23, 2021 at 3:43 PM Luke Shumaker <lukeshu@lukeshu.com> wrote:
> The formatting in t7900-subtree.sh isn't even consistent throughout the
> file.  Fix that; make it consistent throughout the file.
>
> Signed-off-by: Luke Shumaker <lukeshu@datawire.io>
> ---
> diff --git a/contrib/subtree/t/t7900-subtree.sh b/contrib/subtree/t/t7900-subtree.sh
> @@ -23,26 +21,24 @@ subtree_test_create_repo()
> -check_equal()
> -{
> +check_equal () {
>         test_debug 'echo'
>         test_debug "echo \"check a:\" \"{$1}\""
>         test_debug "echo \"      b:\" \"{$2}\""
> -       if [ "$1" = "$2" ]; then
> +       if [ "$1" = "$2" ]
> +       then

We prefer `test` over `[`, so it might make sense to update that, as
well, along with these other style cleanups.
