Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-2.9 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_HI,RCVD_IN_SORBS_SPAM,
	RP_MATCHES_RCVD,T_DKIM_INVALID shortcircuit=no autolearn=no
	autolearn_force=no version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 195FC1FAF4
	for <e@80x24.org>; Wed,  8 Feb 2017 21:31:09 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1751759AbdBHVbG (ORCPT <rfc822;e@80x24.org>);
        Wed, 8 Feb 2017 16:31:06 -0500
Received: from mail-it0-f66.google.com ([209.85.214.66]:36273 "EHLO
        mail-it0-f66.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1751040AbdBHVbF (ORCPT <rfc822;git@vger.kernel.org>);
        Wed, 8 Feb 2017 16:31:05 -0500
Received: by mail-it0-f66.google.com with SMTP id f200so305932itf.3
        for <git@vger.kernel.org>; Wed, 08 Feb 2017 13:30:12 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=sender:from:to:cc:subject:references:date:in-reply-to:message-id
         :user-agent:mime-version;
        bh=LvTYx4sAZAxy4nhEQrRSsqK0vrBJf87EEKarlkd6Ysg=;
        b=tRduntZ+Q4ngbHis9AbKC1NNllr7i/6+twq6Q6ddTZJNmWsND6OSx9hbdO4IZg84Pm
         3xlXpPEedzK/SVIvXOihWJpCZJe1LAKQHjAIaIrhBBXY9byIBIQTDXv28W2C4JviaO2l
         B6FTqLtGb2WPJ0fb1aBmQvyLx1AbZTTF7X1jgkWFoEliYpRnEFWi9SdZKGPqo08FHEoS
         /oVfe0+fH6HdH9cXA54Lx77h54QjNNkM+zOGmG9V/54S9m4SwwPr00U/gkVQuCQvNB+t
         ZVpEKgNDHMMGlOP7Py53DDtL2BLx4hWSUqeRpvJPrtCXrBd7SAr7NXmVqfl3nrDSdPH8
         DQNg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:sender:from:to:cc:subject:references:date
         :in-reply-to:message-id:user-agent:mime-version;
        bh=LvTYx4sAZAxy4nhEQrRSsqK0vrBJf87EEKarlkd6Ysg=;
        b=bOsSzJzouPuySXiyQSmeWTU178GI5sSQ1mj+GodTd7nCRrKgdo2xGUovxS2IkO8a+Y
         dDJs/49km0MAkwncWMgmRG1Lp7oVL5nFfH2BiZFo2fMy/zb9nHuOvCGHcTpZfA1ibnfa
         rT67w1/JQ+FADaF9zmJY/wwUB5dI+H8YpqHFU2IgEcubm1zfCg62C1qajiY4Mop8UIFG
         H1YbjPI4uubPkhMQjgOtoWwZwZw086xE12sGcMFXlD1TfrKS8p4kx24FatAYhtU0xoas
         nrrtRwDP0o2p7Chv4d3Kbama3CahYFQif38lKntafj+1EbxLiP1rDQVbYTcQO6sIJSvJ
         sjOg==
X-Gm-Message-State: AIkVDXLWSm0hrabEawvvSD4uWtrVI5rz4mzBTtHtHG+qfw8i40BnCg8oLlD8DoVZtx3aFQ==
X-Received: by 10.99.210.81 with SMTP id t17mr28966806pgi.95.1486589406637;
        Wed, 08 Feb 2017 13:30:06 -0800 (PST)
Received: from localhost ([2620:0:1000:8622:7c20:fa7c:46cb:2209])
        by smtp.gmail.com with ESMTPSA id p25sm22806332pfd.0.2017.02.08.13.30.05
        (version=TLS1_2 cipher=AES128-SHA bits=128/128);
        Wed, 08 Feb 2017 13:30:06 -0800 (PST)
From:   Junio C Hamano <gitster@pobox.com>
To:     Denton Liu <liu.denton@gmail.com>
Cc:     git@vger.kernel.org, davvid@gmail.com
Subject: Re: [PATCH v2] Document the --no-gui option in difftool
References: <20170207063207.GA12746@arch-attack.localdomain>
Date:   Wed, 08 Feb 2017 13:30:05 -0800
In-Reply-To: <20170207063207.GA12746@arch-attack.localdomain> (Denton Liu's
        message of "Mon, 6 Feb 2017 22:32:07 -0800")
Message-ID: <xmqqo9ycv09u.fsf@gitster.mtv.corp.google.com>
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/25.1.91 (gnu/linux)
MIME-Version: 1.0
Content-Type: text/plain
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Denton Liu <liu.denton@gmail.com> writes:

> Prior to this, the `--no-gui` option was not documented in the manpage.
> This commit introduces this into the manpage
>
> Signed-off-by: Denton Liu <liu.denton@gmail.com>
> ---

Looks good, thanks.

>  Documentation/git-difftool.txt | 5 +++--
>  1 file changed, 3 insertions(+), 2 deletions(-)
>
> diff --git a/Documentation/git-difftool.txt b/Documentation/git-difftool.txt
> index 224fb3090..96c26e6aa 100644
> --- a/Documentation/git-difftool.txt
> +++ b/Documentation/git-difftool.txt
> @@ -86,10 +86,11 @@ instead.  `--no-symlinks` is the default on Windows.
>  	Additionally, `$BASE` is set in the environment.
>  
>  -g::
> ---gui::
> +--[no-]gui::
>  	When 'git-difftool' is invoked with the `-g` or `--gui` option
>  	the default diff tool will be read from the configured
> -	`diff.guitool` variable instead of `diff.tool`.
> +	`diff.guitool` variable instead of `diff.tool`. The `--no-gui`
> +	option can be used to override this setting.
>  
>  --[no-]trust-exit-code::
>  	'git-difftool' invokes a diff tool individually on each file.
