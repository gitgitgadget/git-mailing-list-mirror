Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 824E2C433F5
	for <git@archiver.kernel.org>; Wed,  5 Oct 2022 19:23:47 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230167AbiJETXo (ORCPT <rfc822;git@archiver.kernel.org>);
        Wed, 5 Oct 2022 15:23:44 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:43812 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231343AbiJETXX (ORCPT <rfc822;git@vger.kernel.org>);
        Wed, 5 Oct 2022 15:23:23 -0400
Received: from mail-pl1-x62d.google.com (mail-pl1-x62d.google.com [IPv6:2607:f8b0:4864:20::62d])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 96D1080E80
        for <git@vger.kernel.org>; Wed,  5 Oct 2022 12:23:07 -0700 (PDT)
Received: by mail-pl1-x62d.google.com with SMTP id 10so12645930pli.0
        for <git@vger.kernel.org>; Wed, 05 Oct 2022 12:23:07 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=mime-version:user-agent:message-id:in-reply-to:date:references
         :subject:cc:to:from:sender:from:to:cc:subject:date:message-id
         :reply-to;
        bh=sKYEIYOWrRKXhpHKL66v87WIB2GVYJEtyRNZaTKr5So=;
        b=p/1MyKnv4qLpLby+U7rdUX4d3nAgitJHrs04v5SRevDMvyQ/OHvijcHPEsNkKr+ErP
         RIfGj6z/seFJiiwKdQJqHXkfqiwXuW/f5X+8nkRnNwTxciwK4NBYvwhe32QuGQAPWjuG
         BH+ahHiceSKhrvjiXePFxKDlN9rFCEZ08/eaKn7476meZREzPOdPrkq95Lgt7200AGDL
         rA3e5YCoaz+uH5FYMuf1Ahj9fpbW7JFdPld3wkq3lxiRCGgJ5QGIJmISjYMrwK63yNo5
         B3HpLEBIp5TqjAVu7YRNwv0gVAl8QIGjLF0cKLqm14oAF4igkrPb9zhc03FufHgwXIoc
         XyfA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=mime-version:user-agent:message-id:in-reply-to:date:references
         :subject:cc:to:from:sender:x-gm-message-state:from:to:cc:subject
         :date:message-id:reply-to;
        bh=sKYEIYOWrRKXhpHKL66v87WIB2GVYJEtyRNZaTKr5So=;
        b=OtmxSdV+8KGoWSroUDiqFzL8T/sG3NtW/WhCXgQM2ntmaZi4DKzRf3pWy1omtZFdKG
         NS68BdZFUMJ9V5Ao/XG2UZSRyP0SBavAQWYNs0YoBBmZ/xJG3IhxOL/hzpvwcLO2vXGX
         6XUhPP5N+JSZAbh7RW7rsNpCxAT63USmjdKLEeiXoBGQUzkK6ZviaKr03SQith8aqD2u
         Q8q+jmOnFDrtU//R6meQdzETYKAEL5mREnK5UGB74O0moOH3qN8bPfKQXcAHkOQuER74
         cnE6hZ0wy+ppHxpWdVPozWztvbno5iUm9DAvVzTvIwZNk1rT07Yw+3icNgScqGfYxY6C
         1qaQ==
X-Gm-Message-State: ACrzQf1ovvD48AMxIa/kXcufES0VBJ4wiCCTpvyKp6bNwkkfr7ePLvMK
        RMPS3ZDFIfq3JpDzzV+NajA3bOXLL8g=
X-Google-Smtp-Source: AMsMyM65GC6v4qngeeKgqUW7r83mJIuADgaDAHr/S+ig8xOX86xqmm2jI+lEDmABWM6nIJ8PrRVjeA==
X-Received: by 2002:a17:902:da8a:b0:179:e022:5f6 with SMTP id j10-20020a170902da8a00b00179e02205f6mr1182134plx.80.1664997786999;
        Wed, 05 Oct 2022 12:23:06 -0700 (PDT)
Received: from localhost (33.5.83.34.bc.googleusercontent.com. [34.83.5.33])
        by smtp.gmail.com with ESMTPSA id s33-20020a17090a69a400b0020aacde1964sm1469164pjj.32.2022.10.05.12.23.06
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 05 Oct 2022 12:23:06 -0700 (PDT)
Sender: Junio C Hamano <jch2355@gmail.com>
From:   Junio C Hamano <gitster@pobox.com>
To:     "Noah Betzen via GitGitGadget" <gitgitgadget@gmail.com>
Cc:     git@vger.kernel.org, Noah Betzen <noah@nezteb.net>
Subject: Re: [PATCH] Fix minor typo in mergetool.txt: 'overwriten' ->
 'overwritten'
References: <pull.1350.git.git.1664844924663.gitgitgadget@gmail.com>
Date:   Wed, 05 Oct 2022 12:23:05 -0700
In-Reply-To: <pull.1350.git.git.1664844924663.gitgitgadget@gmail.com> (Noah
        Betzen via GitGitGadget's message of "Tue, 04 Oct 2022 00:55:24
        +0000")
Message-ID: <xmqqh70ioz1i.fsf@gitster.g>
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/28.1 (gnu/linux)
MIME-Version: 1.0
Content-Type: text/plain
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

"Noah Betzen via GitGitGadget" <gitgitgadget@gmail.com> writes:

> From: Noah Betzen <noah@nezteb.net>
>
> Signed-off-by: Noah Betzen <noah@nezteb.net>
> ---
>     Fix minor typo in mergetool.txt
>     
>     I only learned of mergetool.hideResolved today, and while reading the
>     docs I noticed a tiny typo, so I figured I'd fix it.

Thanks.  Will apply.

>
> Published-As: https://github.com/gitgitgadget/git/releases/tag/pr-git-1350%2FNezteb%2Fpatch-1-v1
> Fetch-It-Via: git fetch https://github.com/gitgitgadget/git pr-git-1350/Nezteb/patch-1-v1
> Pull-Request: https://github.com/git/git/pull/1350
>
>  Documentation/config/mergetool.txt | 2 +-
>  1 file changed, 1 insertion(+), 1 deletion(-)
>
> diff --git a/Documentation/config/mergetool.txt b/Documentation/config/mergetool.txt
> index 90b38097002..e779a122d8a 100644
> --- a/Documentation/config/mergetool.txt
> +++ b/Documentation/config/mergetool.txt
> @@ -59,7 +59,7 @@ mergetool.hideResolved::
>  	possible and write the 'MERGED' file containing conflict markers around
>  	any conflicts that it cannot resolve; 'LOCAL' and 'REMOTE' normally
>  	represent the versions of the file from before Git's conflict
> -	resolution. This flag causes 'LOCAL' and 'REMOTE' to be overwriten so
> +	resolution. This flag causes 'LOCAL' and 'REMOTE' to be overwritten so
>  	that only the unresolved conflicts are presented to the merge tool. Can
>  	be configured per-tool via the `mergetool.<tool>.hideResolved`
>  	configuration variable. Defaults to `false`.
>
> base-commit: bcd6bc478adc4951d57ec597c44b12ee74bc88fb
