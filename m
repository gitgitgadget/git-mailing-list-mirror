Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.2 (2018-09-13) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-3.8 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,RCVD_IN_DNSWL_HI,
	SPF_HELO_NONE,SPF_NONE shortcircuit=no autolearn=ham
	autolearn_force=no version=3.4.2
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id B0A9F1F4C0
	for <e@80x24.org>; Fri, 25 Oct 2019 17:35:41 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1731050AbfJYRfk (ORCPT <rfc822;e@80x24.org>);
        Fri, 25 Oct 2019 13:35:40 -0400
Received: from mail-qt1-f194.google.com ([209.85.160.194]:44407 "EHLO
        mail-qt1-f194.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1731004AbfJYRfk (ORCPT <rfc822;git@vger.kernel.org>);
        Fri, 25 Oct 2019 13:35:40 -0400
Received: by mail-qt1-f194.google.com with SMTP id z22so4379346qtq.11
        for <git@vger.kernel.org>; Fri, 25 Oct 2019 10:35:39 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=subject:to:cc:references:from:message-id:date:user-agent
         :mime-version:in-reply-to:content-language:content-transfer-encoding;
        bh=Hmsdnqo4DmmhGnaMbn4p/ueLCdhnkMKWsQX1eeAdJxo=;
        b=GfyTz5eLXRWGHR5QCnlKmLogdRuflfGnRjTMXnkM5aeAAkzpauRT4tJA+2HXTTXhct
         rBnvozlmzM6N/n2Tv6GzZyZDTt+DY/IG1wvlw9zwfN+g+br85nK6jUTKTCQ7vdgxtESR
         kbTu4CcmjNMywNr/QmOFWWkSGcl1zJTgZXLEkDH254BMOGXduxp7mx4zkxZQOM3MRpGu
         ++Wac1resg93XrU2gHrE1dwA8fwx1x6nqVF1TDOjzto1pHOCRUieavEXsrdYP3cOpkYh
         vFxHf1bhccfBMWhlZETP6aZeBdyCU6pZSaUykLq2NcmfMr0o7BuqybQPhn+PIEFuBkP0
         zxIw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:subject:to:cc:references:from:message-id:date
         :user-agent:mime-version:in-reply-to:content-language
         :content-transfer-encoding;
        bh=Hmsdnqo4DmmhGnaMbn4p/ueLCdhnkMKWsQX1eeAdJxo=;
        b=snNa9wCE5MU+mXIFDKau68o5B5aAyQGhw7+ouLgsOtfp3XuLFsp3ee0mvR+9SqKx/U
         SsoyyFotB8QS45bi64xjUG5mwC42J2B83+Vbz2gRATxzLHNzYqhJ+A0ex7BSa8HjX1sl
         jhHAXack2jtPoZj+hU5drdv+F33NA96glxr1AGh/CRo1zRuz8CZhUNT3A2NKtjptfExs
         ++Qmx6CVW+XYAvuutd4rvVGhakqOEUfNMnZ7gsDUJ8nADYLPrMXd2ksWjOBK6zYtFosV
         Lx/ywPabWrYZGDUkLm6yLgHsop1fLg4wrxY+hqChk3dEyZ4IMfuYMIt/BtAEnSx/oSFJ
         r+YA==
X-Gm-Message-State: APjAAAW9knCjIsNUvEeFpocjeDMboOWeFDRcQ+/QqvHt5skdqAXqhwa2
        0nbd2rxe+qSXxB44eBeNDGrAUdsBe78=
X-Google-Smtp-Source: APXvYqwy93DYo/zca28OFcIfPmM0NpDh97EnXHGiTQdSOAatBnYcIZqVQMpURpOIQs+zokVbD9PlnQ==
X-Received: by 2002:ad4:53c8:: with SMTP id k8mr671027qvv.240.1572024938804;
        Fri, 25 Oct 2019 10:35:38 -0700 (PDT)
Received: from [10.0.1.19] ([98.122.173.75])
        by smtp.gmail.com with ESMTPSA id u18sm2815643qth.20.2019.10.25.10.35.37
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Fri, 25 Oct 2019 10:35:38 -0700 (PDT)
Subject: Re: [PATCH] builtin/commit-graph.c: remove subcommand-less usage
 string
To:     =?UTF-8?Q?SZEDER_G=c3=a1bor?= <szeder.dev@gmail.com>,
        Junio C Hamano <gitster@pobox.com>
Cc:     git@vger.kernel.org
References: <20191025164909.354-1-szeder.dev@gmail.com>
From:   Derrick Stolee <stolee@gmail.com>
Message-ID: <0ba48f8e-3869-ff08-b46d-53feb7675d2b@gmail.com>
Date:   Fri, 25 Oct 2019 13:35:31 -0400
User-Agent: Mozilla/5.0 (Windows NT 10.0; Win64; x64; rv:70.0) Gecko/20100101
 Thunderbird/70.0
MIME-Version: 1.0
In-Reply-To: <20191025164909.354-1-szeder.dev@gmail.com>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 8bit
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

On 10/25/2019 12:49 PM, SZEDER Gábor wrote:
> The first line in 'git commit-graph's usage string indicates that this
> command can be invoked without specifying a subcommand.  However, this
> is not the case:
> 
>   $ git commit-graph
>   usage: git commit-graph [--object-dir <objdir>]
>      or: git commit-graph read [--object-dir <objdir>]
>   [...]
>   $ echo $?
>   129
> 
> Remove this line from the usage string.
> 
> The synopsis in the manpage doesn't contain this line.
> 
> Signed-off-by: SZEDER Gábor <szeder.dev@gmail.com>
> ---
>  builtin/commit-graph.c | 1 -
>  1 file changed, 1 deletion(-)
> 
> diff --git a/builtin/commit-graph.c b/builtin/commit-graph.c
> index c6219ebe11..4d9b9c862f 100644
> --- a/builtin/commit-graph.c
> +++ b/builtin/commit-graph.c
> @@ -8,7 +8,6 @@
>  #include "object-store.h"
>  
>  static char const * const builtin_commit_graph_usage[] = {
> -	N_("git commit-graph [--object-dir <objdir>]"),
>  	N_("git commit-graph read [--object-dir <objdir>]"),
>  	N_("git commit-graph verify [--object-dir <objdir>] [--shallow] [--[no-]progress]"),
>  	N_("git commit-graph write [--object-dir <objdir>] [--append|--split] [--reachable|--stdin-packs|--stdin-commits] [--[no-]progress] <split options>"),

Good catch! Thanks for cleaning this up.

-Stolee

