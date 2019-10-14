Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.2 (2018-09-13) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-3.9 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,RCVD_IN_DNSWL_HI,
	SPF_HELO_NONE,SPF_NONE shortcircuit=no autolearn=ham
	autolearn_force=no version=3.4.2
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id B8FD51F4C0
	for <e@80x24.org>; Mon, 14 Oct 2019 23:44:47 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726674AbfJNXop (ORCPT <rfc822;e@80x24.org>);
        Mon, 14 Oct 2019 19:44:45 -0400
Received: from mail-wm1-f68.google.com ([209.85.128.68]:34090 "EHLO
        mail-wm1-f68.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726638AbfJNXop (ORCPT <rfc822;git@vger.kernel.org>);
        Mon, 14 Oct 2019 19:44:45 -0400
Received: by mail-wm1-f68.google.com with SMTP id y135so1033581wmc.1
        for <git@vger.kernel.org>; Mon, 14 Oct 2019 16:44:43 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to:user-agent;
        bh=az//9EwJQns4gmGITshCDxgmy3XNiom4W7sGaVYDT4I=;
        b=kTCD1vTL8Yeuo76RGZIBGUMjT/+629ljZvXGBAvUkxYmbX6n6AVAGVqqjsYVDqk8NE
         AXKp7OyYMxXFEjFCt/BRypKhV0shqGucS4G2jm11+dJ/NaJGB/UaG8KklKDl8L5DnhY8
         c2Wz8V0wja/25Cw9llOGeBdgPoqZ0cDSBuACo39tUA22q4hWkPYUSgO5GA9GUd68NLei
         mcLokQSd64h4dcE0UNYLu2L8gzWAIu0aSes1111PsQXqY7NLGG6uSquA59uo8JsQzpc3
         Q8EgMf1xbRu3AiCf1JtCSNScP90gl0jMXJgonXC4jpYC274Bi1mxPs8mWXTiTNsxiuzz
         wc0g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to:user-agent;
        bh=az//9EwJQns4gmGITshCDxgmy3XNiom4W7sGaVYDT4I=;
        b=McNfROw2OGw67hYmWTPxY39/3ZgOxGvcIN/EKIi3lhvsZlzb8Hui7Sr1xhOvvjPxcv
         Cv3+A7k8HBbyeyaYndFZNYy7gcTcM/EOCLgGCGS8OsdpbEtQyMz94iFJpa+Pba6IEWd9
         Dqxe7MCmUXA4Xk8UZxkx2iyXo/YjL9YoVPYNm8OyDrEKEeCPBgJFCRr7e19/HHa6pGeD
         0ANmTCvB0qLsIU1UM9EVSVv2rwQVpooowz6YvhtI6VMKaew1xZKx99UdjfL7ny7ydMhV
         JSngkWsp5gSmNhYcwrJUhNn+hF2+WjWMQGAdGUqSzDJ06dDEQeUIBitGVGBKT/Mc4zKm
         8UDw==
X-Gm-Message-State: APjAAAWYLSulcSKMbqhhZgo9/fhORSZJGowdSj5f38Sf1hF9oThYozvH
        xfuE5AVvtgrVgy9LZmVL/Ujv+l46
X-Google-Smtp-Source: APXvYqzFmzJ4o0UJh9XCYJ6T0zw6E6COSfwaZnndHrvIVxZY052yjfN7KUyusbPSonNEsLrc1oYBkw==
X-Received: by 2002:a7b:c049:: with SMTP id u9mr16496054wmc.12.1571096682786;
        Mon, 14 Oct 2019 16:44:42 -0700 (PDT)
Received: from szeder.dev (x4db61e2a.dyn.telefonica.de. [77.182.30.42])
        by smtp.gmail.com with ESMTPSA id y19sm18392059wmi.13.2019.10.14.16.44.40
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Mon, 14 Oct 2019 16:44:41 -0700 (PDT)
Date:   Tue, 15 Oct 2019 01:44:39 +0200
From:   SZEDER =?utf-8?B?R8OhYm9y?= <szeder.dev@gmail.com>
To:     Maxim Belsky via GitGitGadget <gitgitgadget@gmail.com>
Cc:     git@vger.kernel.org, Max Belsky <public.belsky@gmail.com>,
        Junio C Hamano <gitster@pobox.com>
Subject: Re: [PATCH v2 1/1] doc: Change zsh git completion file name
Message-ID: <20191014234439.GT29845@szeder.dev>
References: <pull.367.git.gitgitgadget@gmail.com>
 <pull.367.v2.git.gitgitgadget@gmail.com>
 <3f994f3b9a49c42bb8b605459817e54479327dc7.1570816467.git.gitgitgadget@gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <3f994f3b9a49c42bb8b605459817e54479327dc7.1570816467.git.gitgitgadget@gmail.com>
User-Agent: Mutt/1.5.24 (2015-08-30)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

On Fri, Oct 11, 2019 at 10:54:28AM -0700, Maxim Belsky via GitGitGadget wrote:
> From: Maxim Belsky <public.belsky@gmail.com>
> 
> The original comment does not describe type of ~/.zsh/_git explicitly
> and zsh does not warn or fail if a user create it as a dictionary.
> So unexperienced users could be misled by the original comment.
> 
> There is a small update to clarify it.
> 
> Signed-off-by: Maxim Belsky <public.belsky@gmail.com>
> Helped-by: Johannes Schindelin <Johannes.Schindelin@gmx.de>
> Helped-by: Junio C Hamano <gitster@pobox.com>
> ---
>  contrib/completion/git-completion.zsh | 5 +++--
>  1 file changed, 3 insertions(+), 2 deletions(-)
> 
> diff --git a/contrib/completion/git-completion.zsh b/contrib/completion/git-completion.zsh
> index 886bf95d1f..eef4eff53d 100644
> --- a/contrib/completion/git-completion.zsh
> +++ b/contrib/completion/git-completion.zsh
> @@ -11,8 +11,9 @@
>  #
>  #  zstyle ':completion:*:*:git:*' script ~/.git-completion.zsh
>  #
> -# The recommended way to install this script is to copy to '~/.zsh/_git', and
> -# then add the following to your ~/.zshrc file:
> +# The recommended way to install this script is to make a copy of it in
> +# ~/.zsh/ directory as ~/.zsh/git-completion.zsh and then add the following

These updated instructions don't work for me, following them gives me
zsh's git completion instead of ours:

  $ ls -l /etc/bash_completion.d/git
  -rwxr-xr-x 1 root root 72165 Oct 15 01:27 /etc/bash_completion.d/git
  $ ls -l ~/.zsh/
  total 8
  -rw-r--r-- 1 szeder szeder 6013 Oct 15 01:27 git-completion.zsh
  $ cat ~/.zshrc 
  # Use modern completion system
  autoload -Uz compinit
  compinit
  
  fpath=(~/.zsh $fpath)
  $ zsh
  % git init --<TAB>
  --bare              -- create a bare repository
  --quiet             -- do not print any results to stdout
  --separate-git-dir  -- create git dir elsewhere and link it using the gitdir
  --shared            -- share repository amongst several users
  --template          -- directory to use as a template for the object databas

That's clearly zsh's fancy completion.

As a non-zsh user I had the impression that it's a well-established
convention that the completion script of a command for zsh is called
'_command', see e.g. all the scripts in:

  https://github.com/zsh-users/zsh-completions/tree/master/src

Instructing users to copy our completion script to
'~/.zsh/git-completion.zsh' goes against this convention.

More importantly, it appears that this is more than a mere convention,
maybe a requirement even; at least renaming our zsh completion script
to follow the convention (IOW following the current install
instructions) makes it work all of a sudden:

  $ mv .zsh/git-completion.zsh .zsh/_git
  $ zsh
  % git init --
  --                      --no-separate-git-dir   --shared 
  --bare                  --no-template           --template=
  --no-bare               --quiet                 
  --no-quiet              --separate-git-dir=     

Now that's our Bash completion script used by zsh.

