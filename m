Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.2 (2018-09-13) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-4.2 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,RCVD_IN_DNSWL_HI,
	SPF_HELO_NONE,SPF_NONE shortcircuit=no autolearn=ham
	autolearn_force=no version=3.4.2
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 25FBE1F462
	for <e@80x24.org>; Thu,  6 Jun 2019 22:44:56 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727120AbfFFWoz (ORCPT <rfc822;e@80x24.org>);
        Thu, 6 Jun 2019 18:44:55 -0400
Received: from mail-io1-f66.google.com ([209.85.166.66]:45992 "EHLO
        mail-io1-f66.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726567AbfFFWoy (ORCPT <rfc822;git@vger.kernel.org>);
        Thu, 6 Jun 2019 18:44:54 -0400
Received: by mail-io1-f66.google.com with SMTP id e3so1487911ioc.12
        for <git@vger.kernel.org>; Thu, 06 Jun 2019 15:44:54 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to:user-agent;
        bh=7fqih5UC2bPY1A0N3rbrh+DD6K9Llkop8TypJYrdejE=;
        b=NQRjNhSGY7Fi+9ilA6UgL8RlAnpR0SkCUB+CKe1RQH7iK/K16gSTtxSF1JDTjIReNl
         KUZAZvmGT1mvnKVf4XQ3MWzY9XsTUuwe0gYCKTwxXHdMKzprHPWON/MgcF/RzSRFAdQq
         XzkoozCPAs1dCCaMlo1c5s1Bo/jOrJVDUwZ7rv9MPoNEy4OQ6KuKXDoQIBqAZvGZbdE1
         5vz4+LshowDDiFioVoaaWPh/d2y4KgLBYhVE2+w12P5YUPaxfOBD3LeAAyOq+XJq1sH0
         dndE7hx1AdJ/es3eYU3d/6CWWNNmrhmMuzjBj7N6f79ZO2jiVv8SmZv04p+ce3dIXgOC
         CLyw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to:user-agent;
        bh=7fqih5UC2bPY1A0N3rbrh+DD6K9Llkop8TypJYrdejE=;
        b=E7hDVVUDdFFW8zUScU1yp9fgK7kMM/oX5qxJW4AC0ncZ30yGPpNA62HWOoh3xf01+M
         cdPRimf8WWdZQEEMsfPAgOa3l1qLTH1KQKdtBDfNEBqF5i2S8P281dDxIpT+KaUrSyES
         FAdgy9E+JbuxB/Gs7KH0/0nJgEgbZfmdH0TW5c+qo98P4xYTO1jpwbpQYuYxprdZEqjB
         NcmeUWYPAQ6gn8CULPSiORYP0Zt1rh4ArAI7yQ0kdXqiEvo81wOvQbg+G6Ck3ajR5u2f
         LG1Y4P8Wt+M0UySEHfNQYrjMoNo0O2ljIyI/kAkc0L+/NmJbeFvQqrjBkv4R1M87DQT2
         sRsA==
X-Gm-Message-State: APjAAAUxPDrYypKh/wlUZrzWQRd3mpFDXvNgbXPSImbALiM5GJ4SJwai
        FIphxQeIQ+onm7NV08EegMQ=
X-Google-Smtp-Source: APXvYqzKdg/4YSmWySfcN+P5oGfsBTMkWp/WR1bBJ3M0KWwtv33Zc+SzqRa0/Kz2H/ZWqk/noT5gSA==
X-Received: by 2002:a6b:7507:: with SMTP id l7mr12122822ioh.255.1559861093896;
        Thu, 06 Jun 2019 15:44:53 -0700 (PDT)
Received: from archbookpro.localdomain (ktnron0919w-grc-01-76-68-140-144.dsl.bell.ca. [76.68.140.144])
        by smtp.gmail.com with ESMTPSA id b142sm65702itb.28.2019.06.06.15.44.52
        (version=TLS1_3 cipher=AEAD-AES256-GCM-SHA384 bits=256/256);
        Thu, 06 Jun 2019 15:44:53 -0700 (PDT)
Date:   Thu, 6 Jun 2019 18:44:50 -0400
From:   Denton Liu <liu.denton@gmail.com>
To:     Durant Schoon <durant.schoon@gmail.com>
Cc:     git@vger.kernel.org
Subject: Re: [PATCH] completion (zsh): fix misleading install location
Message-ID: <20190606224450.GA31942@archbookpro.localdomain>
References: <0102016b2ebafc26-1bd39076-62e4-4b7e-9309-b08cc072fbdf-000000@eu-west-1.amazonses.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <0102016b2ebafc26-1bd39076-62e4-4b7e-9309-b08cc072fbdf-000000@eu-west-1.amazonses.com>
User-Agent: Mutt/1.12.0 (2019-05-25)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Hi Durant,

Just a couple of small things:

On Thu, Jun 06, 2019 at 09:38:54PM +0000, Durant Schoon wrote:
> When the code comment in the zsh completion suggests that this file
> should be copied to `~/.zsh`, many users might be misled to believe that
> this refers to a file location. But it refers to a directory, and won't
> work when it is a file.
> 
> Let's just add a slash, to make it abundantly clear that this must be a
> directory.
> 
> (thank you to Johannes Schindelin for the suggested wording and title)

Maybe this would be better incorporated as a Helped-by: or Suggested-by:
tag at the bottom?

> 
> Signed-off-by: B. Durant Schoon durant.schoon@gmail.com

The email in your sign-off line should be wrapped in <>, i.e. it should
be

	B. Durant Schoon <durant.schoon@gmail.com>

Other than that, the patch looks fine to me.

Thanks,

Denton

> ---
>  contrib/completion/git-completion.zsh | 4 ++--
>  1 file changed, 2 insertions(+), 2 deletions(-)
> 
> diff --git a/contrib/completion/git-completion.zsh b/contrib/completion/git-completion.zsh
> index 886bf95d1f594..0e63004e2613e 100644
> --- a/contrib/completion/git-completion.zsh
> +++ b/contrib/completion/git-completion.zsh
> @@ -11,8 +11,8 @@
>  #
>  #  zstyle ':completion:*:*:git:*' script ~/.git-completion.zsh
>  #
> -# The recommended way to install this script is to copy to '~/.zsh/_git', and
> -# then add the following to your ~/.zshrc file:
> +# The recommended way to install this script is to copy to '~/.zsh/_git/',
> +# and then add the following to your ~/.zshrc file:
>  #
>  #  fpath=(~/.zsh $fpath)
>  
> 
> --
> https://github.com/git/git/pull/609
