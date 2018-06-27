Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.1 (2015-04-28) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-3.6 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,RCVD_IN_DNSWL_HI,
	T_DKIM_INVALID shortcircuit=no autolearn=ham autolearn_force=no version=3.4.1
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id B97751F516
	for <e@80x24.org>; Wed, 27 Jun 2018 19:16:47 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S934850AbeF0TQp (ORCPT <rfc822;e@80x24.org>);
        Wed, 27 Jun 2018 15:16:45 -0400
Received: from mail-wm0-f65.google.com ([74.125.82.65]:37628 "EHLO
        mail-wm0-f65.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S934387AbeF0TQp (ORCPT <rfc822;git@vger.kernel.org>);
        Wed, 27 Jun 2018 15:16:45 -0400
Received: by mail-wm0-f65.google.com with SMTP id n17-v6so6089461wmh.2
        for <git@vger.kernel.org>; Wed, 27 Jun 2018 12:16:44 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=sender:from:to:cc:subject:references:date:in-reply-to:message-id
         :user-agent:mime-version;
        bh=F54qRgB/YHnB8OAgE2fScycxuZlsI3ks5Q67SVqr4gw=;
        b=EKMiS0CbR65U7i91cA1VAMm21DrtPlrsq5IvM35dEv/wbsk/Eh+haAWiHnSUN1eRRL
         x1kQKAc9Z55cTymDi+e29WBDnEV1R2pDApHnXGpJ3IzmBOei3ar3jT+AgPuWEjaS/4Zv
         9YPTtuCejzHluYudcU8BenQja8t2qCulFc0a0jaZ6SJvSKrnkgIpfM+OHsBxdgQtrglv
         2GHFsOkmVpr5V4hknE6g8hsFE3lpn7ClPfewsn9y0NhOTFHSr/nDt2QmYeXh/3lmsJuT
         Y5Nvep2hF0A6L6ZK7XnVpzaNEk+lG2KDXtAqMwLm59/StIBBRrsDcCQVNMPLl2g5g7s9
         eV9Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:sender:from:to:cc:subject:references:date
         :in-reply-to:message-id:user-agent:mime-version;
        bh=F54qRgB/YHnB8OAgE2fScycxuZlsI3ks5Q67SVqr4gw=;
        b=am4h9nnrYHjSsPOMmDQ+FOLpEAaBAJkfdKuqmwIF8hlCeMCvAzUTSTSC3i3PD2jSQ1
         P5nwzmUObZTGA6o0Ed1uaXzGaDKxjD6lAHhnFM3fPHCNXBZp5Wr5iBGueKN5rhAsFaWR
         VN4YbiWu3X47CWtBQroCjNtRnd/luLMiibKk5KvqAqI/mfa5lfaNvwypBka+wnfRbSyr
         0dhOfKrCfVSy86K4knLXnf7SBmGHQRPJuNuY5vauG5ZvzrTWbQg+l3n+KQbb0yxnVSMD
         zxzwVvsvFZWlTKAzbIokzwaFQH/roAQMWQL3z4Dcui2UhfDotwOGDg9YuQCX9n5uxSMF
         95gA==
X-Gm-Message-State: APt69E0u6KVRNk8pENsMrUBwm9jquUNmK3K58UhFc3gXnXhv5Scr3xfd
        lOUXxmRuMdI7lhpx4MzEYj7PWq14
X-Google-Smtp-Source: AAOMgpf5B4cD2CZRSpW7w80XKxMk1r5JxH4LCrJLUUvhypIFB+y4UoT6LFaIsaRvKlLmEQe74rRhqA==
X-Received: by 2002:a1c:2dd5:: with SMTP id t204-v6mr6155571wmt.94.1530127003545;
        Wed, 27 Jun 2018 12:16:43 -0700 (PDT)
Received: from localhost (168.50.187.35.bc.googleusercontent.com. [35.187.50.168])
        by smtp.gmail.com with ESMTPSA id k82-v6sm9640946wmg.10.2018.06.27.12.16.42
        (version=TLS1_2 cipher=ECDHE-RSA-CHACHA20-POLY1305 bits=256/256);
        Wed, 27 Jun 2018 12:16:42 -0700 (PDT)
From:   Junio C Hamano <gitster@pobox.com>
To:     Todd Zullinger <tmz@pobox.com>
Cc:     git@vger.kernel.org
Subject: Re: [PATCH 1/2] gitignore.txt: clarify default core.excludesfile path
References: <20180627044652.12080-1-tmz@pobox.com>
Date:   Wed, 27 Jun 2018 12:16:42 -0700
In-Reply-To: <20180627044652.12080-1-tmz@pobox.com> (Todd Zullinger's message
        of "Wed, 27 Jun 2018 00:46:51 -0400")
Message-ID: <xmqqvaa4dopx.fsf@gitster-ct.c.googlers.com>
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/26.1 (gnu/linux)
MIME-Version: 1.0
Content-Type: text/plain
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Todd Zullinger <tmz@pobox.com> writes:

> The default core.excludesfile path is $XDG_CONFIG_HOME/git/ignore.
> $HOME/.config/git/ignore is used if XDG_CONFIG_HOME is empty or unset,

... because $HOME/.config is the default value for XDG_CONFIG_HOME
when it is unset, that is?  If so, the change makes sense.

> as described later in the document.



> Signed-off-by: Todd Zullinger <tmz@pobox.com>
> ---
>  Documentation/gitignore.txt | 2 +-
>  1 file changed, 1 insertion(+), 1 deletion(-)
>
> diff --git a/Documentation/gitignore.txt b/Documentation/gitignore.txt
> index ff5d7f9ed6..d107daaffd 100644
> --- a/Documentation/gitignore.txt
> +++ b/Documentation/gitignore.txt
> @@ -7,7 +7,7 @@ gitignore - Specifies intentionally untracked files to ignore
>  
>  SYNOPSIS
>  --------
> -$HOME/.config/git/ignore, $GIT_DIR/info/exclude, .gitignore
> +$XDG_CONFIG_HOME/git/ignore, $GIT_DIR/info/exclude, .gitignore
>  
>  DESCRIPTION
>  -----------
