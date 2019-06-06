Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.2 (2018-09-13) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-4.3 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,RCVD_IN_DNSWL_HI,
	SPF_HELO_NONE,SPF_NONE shortcircuit=no autolearn=ham
	autolearn_force=no version=3.4.2
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 92D7E1F462
	for <e@80x24.org>; Thu,  6 Jun 2019 22:52:16 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726873AbfFFWwP (ORCPT <rfc822;e@80x24.org>);
        Thu, 6 Jun 2019 18:52:15 -0400
Received: from mail-vs1-f65.google.com ([209.85.217.65]:38448 "EHLO
        mail-vs1-f65.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726352AbfFFWwP (ORCPT <rfc822;git@vger.kernel.org>);
        Thu, 6 Jun 2019 18:52:15 -0400
Received: by mail-vs1-f65.google.com with SMTP id b10so69781vsp.5
        for <git@vger.kernel.org>; Thu, 06 Jun 2019 15:52:14 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=r5fw8PgGm9Qeq7KAA96jFZmgGEBbOX8m0+jSJ/EpPP0=;
        b=dUT8DIhMKOuv5H7cU9NOHQTu5Xsr/D891+renlFtO7ynxUbDIwmFgt7qHwtLSadFGl
         4mXjfIK/beyTpSuFjkM6WAEtFeST63TyT0f2vN0lmmFweCQCM1uGj7ex03p6yNHcofJj
         wYRpsgGOhRgmR2wzsA8ebxWgYnSZ28Mr1+bE++E5bwGKcIZ0O1g/CdNdGHhUntjVK3v2
         XtwnC+uSs7mVTwJuy1vMPxVGyuVPnk1kkg0uJgtUq/eztPwLm96t6Mu9HBj2f7h2EKjD
         N0lTzxfAlCRfzTPfg3+iAk5O8FoJDR8Knt5IcyuT9xyuwY4qQIOLUJkiwwOXABgQBWpA
         BGng==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=r5fw8PgGm9Qeq7KAA96jFZmgGEBbOX8m0+jSJ/EpPP0=;
        b=eOclr4clkGOQB+BZWYFxxim8yiLW4lawftY1BaLA7T6+1va5fUIhnu5/mce+dzSJmj
         aavxWAlifk+MbUnEReY91xJHqITOrVciynpNMJ6QIGaAoSenWcnSenJgX9a2J6KxODWL
         VYsHZM1whLhJx1QluTN/LOEdDM0EMNr8Erpu6CTBUySGRa2tdGluiCwi+jgu8ZT1L93e
         WyjV8vYtUpa92dwMFwlXBu2XB/M6+WuOTJSyUwY3LA2I3rSYQVAkKFdsSUbmOV7t5e+m
         Ll8QDFFbyMOCsJxtii4RN7NYGsvJShiApoJ3FRK948iXWNm2e24ocuQ1oeIE82FkmBTz
         LtDg==
X-Gm-Message-State: APjAAAWGLnOP0jSNHc7wHZIHXOiaIu3+tc/mVZqFN4tRT7r2m5lbc4ae
        rVmLReLSW1O512rmkqY0/gjIG1C0L0Vl2xu9qI7HAsib
X-Google-Smtp-Source: APXvYqwsTACMbbsPogUrP4osTegzZSmxxGBmTAdo3nxRZ6lf8Qd/vOFMFF/91YZItxDFLc331C8WIdgJzoziUyk2pt4=
X-Received: by 2002:a67:fc50:: with SMTP id p16mr6773670vsq.79.1559861534482;
 Thu, 06 Jun 2019 15:52:14 -0700 (PDT)
MIME-Version: 1.0
References: <0102016b2ebafc26-1bd39076-62e4-4b7e-9309-b08cc072fbdf-000000@eu-west-1.amazonses.com>
In-Reply-To: <0102016b2ebafc26-1bd39076-62e4-4b7e-9309-b08cc072fbdf-000000@eu-west-1.amazonses.com>
From:   Felipe Contreras <felipe.contreras@gmail.com>
Date:   Thu, 6 Jun 2019 17:52:03 -0500
Message-ID: <CAMP44s2w2ByBAx5rdc+M7Z=CWN7+CXMLECcpfYGHBxO277xFdg@mail.gmail.com>
Subject: Re: [PATCH] completion (zsh): fix misleading install location
To:     Durant Schoon <durant.schoon@gmail.com>
Cc:     Git <git@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

On Thu, Jun 6, 2019 at 5:37 PM Durant Schoon <durant.schoon@gmail.com> wrote:

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

~/.zsh/_git should be a file, not a directory.

-- 
Felipe Contreras
