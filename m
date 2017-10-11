Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-2.7 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_HI,RCVD_IN_SORBS_SPAM,
	RP_MATCHES_RCVD shortcircuit=no autolearn=no autolearn_force=no version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 31EE01FA21
	for <e@80x24.org>; Wed, 11 Oct 2017 19:08:45 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1757528AbdJKTIn (ORCPT <rfc822;e@80x24.org>);
        Wed, 11 Oct 2017 15:08:43 -0400
Received: from mail-wm0-f68.google.com ([74.125.82.68]:43224 "EHLO
        mail-wm0-f68.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1757486AbdJKTIm (ORCPT <rfc822;git@vger.kernel.org>);
        Wed, 11 Oct 2017 15:08:42 -0400
Received: by mail-wm0-f68.google.com with SMTP id m72so21134927wmc.0
        for <git@vger.kernel.org>; Wed, 11 Oct 2017 12:08:41 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to:user-agent;
        bh=dv4/OdA5tPFBLzOBd1yAzwKcMCpEH5pJlETbduxItOI=;
        b=uIWuXJqiXnkMdgswuK0izQ174ZN/yQOXXfCyh6DUYXrrDc12QFcvZ5t6YdX8UMKj5d
         j3ArqEIlUuPqNhcJiJiJd6IA4n+bB37gyUy/e3opjMHifnbd4h96PEwlDh2R3aGK0lNR
         NqnYK6vv5bxwDBD+exlilfGudJfHK4/dBPZaJ7xkAtd8Dcby05xgpIIsPRc7T39z4FDX
         PpWxCrubmHS7sTRD+12pLTLIofI72meotifH4HdebP7FNz4nb6ZZwEeH+zavU9hTWnRX
         RpjCuYdEWMPoRdtYzoDdPFKxX11M8nMy5/bSCXtiBlM/GnsnROMNiEqTpWL0JO03Dk0b
         dVig==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to:user-agent;
        bh=dv4/OdA5tPFBLzOBd1yAzwKcMCpEH5pJlETbduxItOI=;
        b=JQuFbO+PBSWjMErL+MQ+BmIzxHpza/kX0qLFrCnPPMnc2dNuwCvW62LRxiW73oWt8D
         28W+z2Qfd8kQz59bUXM0narIite6XUlSdh7ZeAdkf/YwDuewS3fpGqMiw33mAAqE7Xbo
         zHv9nFfvIWiaHRtOS5wA7AE1EmzwJbCVDOoW/im9Y+fUjt7RCvxFXXXeyKN8PvBfyQtR
         OubdqPLCm3g/9VAg1ayUicpxqJMT8k8yVSZq5ce14YG1sV8kjjMB3YLpkFqZ4gtEV+fa
         8CViJaVLMswVdEh89a6XG/PAYC9skxsZMGbVwwvOx3PrE8RPgPOTRPjaR2MShuuqP149
         CFag==
X-Gm-Message-State: AMCzsaVdeAMRVRt4TcCA9rIuo/PCilYftzlWCcr4i4DWzEDvY0y/wtkC
        Qy1lZRnReslxWsMR4CbkYfM=
X-Google-Smtp-Source: AOwi7QCZfQd/GaC94BT2FjwHguBWFDbW6/Ri3I9bLCdLUWtANI/J5JK1UgYZcvsLbdckfIMVZu32cw==
X-Received: by 10.28.168.203 with SMTP id r194mr29007wme.2.1507748920972;
        Wed, 11 Oct 2017 12:08:40 -0700 (PDT)
Received: from localhost (cpc73832-dals21-2-0-cust969.20-2.cable.virginm.net. [81.110.231.202])
        by smtp.gmail.com with ESMTPSA id 38sm7592429wrl.76.2017.10.11.12.08.40
        (version=TLS1_2 cipher=ECDHE-RSA-CHACHA20-POLY1305 bits=256/256);
        Wed, 11 Oct 2017 12:08:40 -0700 (PDT)
Date:   Wed, 11 Oct 2017 20:09:35 +0100
From:   Thomas Gummerer <t.gummerer@gmail.com>
To:     Takahito Ogawa <aiueogawa217@gmail.com>
Cc:     git@vger.kernel.org
Subject: Re: [PATCH 1/1] git-stash.txt: correct "git stash" behavior with no
 arguments
Message-ID: <20171011190935.GA15399@hank>
References: <n>
 <20171011183718.2404-1-aiueogawa217@gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20171011183718.2404-1-aiueogawa217@gmail.com>
User-Agent: Mutt/1.5.23.1-rc1 (2014-03-12)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

On 10/12, Takahito Ogawa wrote:
> "git stash" behavior without any arguments was changed in
> 1ada5020b ("stash: use stash_push for no verb form", 2017-02-28).
> This is equivalent to "git stash push" but documents says
> "git stash save".
> 
> Correct it.

Thanks for fixing this!  I recently sent a patch that would advertise
git stash push more in general, which would also fix this occurrence [1], 
but it didn't seem like it got much interest.  However this is
obviously correct, and should definitely be fixed, while the other
places can still mention 'git stash save'.

For what it's worth this is

Reviewed-by: Thomas Gummerer <t.gummerer@gmail.com>


> Signed-off-by: Takahito Ogawa <aiueogawa217@gmail.com>
> ---
>  Documentation/git-stash.txt | 2 +-
>  1 file changed, 1 insertion(+), 1 deletion(-)
> 
> diff --git a/Documentation/git-stash.txt b/Documentation/git-stash.txt
> index 00f95fee1..63642c145 100644
> --- a/Documentation/git-stash.txt
> +++ b/Documentation/git-stash.txt
> @@ -33,7 +33,7 @@ and reverts the working directory to match the `HEAD` commit.
>  The modifications stashed away by this command can be listed with
>  `git stash list`, inspected with `git stash show`, and restored
>  (potentially on top of a different commit) with `git stash apply`.
> -Calling `git stash` without any arguments is equivalent to `git stash save`.
> +Calling `git stash` without any arguments is equivalent to `git stash push`.
>  A stash is by default listed as "WIP on 'branchname' ...", but
>  you can give a more descriptive message on the command line when
>  you create one.
> -- 
> 2.13.1
> 
