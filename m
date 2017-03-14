Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-3.0 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_HI,
	RCVD_IN_SORBS_SPAM,RP_MATCHES_RCVD shortcircuit=no autolearn=no
	autolearn_force=no version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 2ED5B20951
	for <e@80x24.org>; Tue, 14 Mar 2017 22:49:49 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1751268AbdCNWtr (ORCPT <rfc822;e@80x24.org>);
        Tue, 14 Mar 2017 18:49:47 -0400
Received: from mail-pg0-f52.google.com ([74.125.83.52]:33535 "EHLO
        mail-pg0-f52.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1750932AbdCNWtr (ORCPT <rfc822;git@vger.kernel.org>);
        Tue, 14 Mar 2017 18:49:47 -0400
Received: by mail-pg0-f52.google.com with SMTP id n190so249458pga.0
        for <git@vger.kernel.org>; Tue, 14 Mar 2017 15:49:46 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20161025;
        h=mime-version:in-reply-to:references:from:date:message-id:subject:to
         :cc;
        bh=Knodgg7FJyBwI3np7uGZw3n1GlFQd0MN2APhINSwwFc=;
        b=nTpasO6NcmJwtUQTeYgcaKGMYOoXvkbdaOnLMHoB2nAQSBiNH6hI37UuaOl8LOo6v/
         4EyvVkmWDBClEzmuiqyzU1vbJJsEVfD3KGWZNiZb3lerVync74vrDURbi4rnL+CXjX1n
         yshQOtbej1yqbTTKDqPNyaEVn6Pb0R6PHSlAPCtC4WAQ9sfbPTGLcQ1gN98PyMdNRXwp
         4FWUJmmdevJnzgmI95xTbIXXKXaGR4lEGbGwJThpkBrQsnQ5ZmxC7Yw8UgTOnzYY4W6s
         0i8pAt9OndVy5klsodGKRxlF/hyeryL5QvIcfAXWtHO+VzoMmRi44bDhMcktdDtkGxAh
         gmCw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:in-reply-to:references:from:date
         :message-id:subject:to:cc;
        bh=Knodgg7FJyBwI3np7uGZw3n1GlFQd0MN2APhINSwwFc=;
        b=siAUyoEn3DbbS4wUGaeXCrn675MlpDXWVK4aMMuTBbSrdCwnjAKFQX66qSTVa/F2fh
         SRCjX17x46itWf1xW5VJzrEZkQmQwxM39wu+mxy0/3dxiDAwbIRwwSaUD0kWj5swstqV
         hszUauuMzkO3SEINBvzGaaYqKTVvSGOOKjzMrJUsudabKhgLIBRHfM4/nLELEHm7agmT
         qT164Nxzv/CoKQMoNkjB3D13E8F19omWlsiIenUrD8thVLanhawYo0ZCq8tDztoWr4Ep
         ZQRsADEOMN0YkDTOcdCDkatEISwCu5Q0cdwBIjlIn/okRdtqFbV4QVUhXxTBl3R4P9l4
         BraA==
X-Gm-Message-State: AFeK/H3Xy3lXrfjVtt6ooWt4sneH/nyxAgiWzf+W6CPH9IJWH963Bev63Ql+oGCnNffuCrKatn0v612jLuQ9aWgA
X-Received: by 10.98.69.86 with SMTP id s83mr77717pfa.232.1489531785599; Tue,
 14 Mar 2017 15:49:45 -0700 (PDT)
MIME-Version: 1.0
Received: by 10.100.187.5 with HTTP; Tue, 14 Mar 2017 15:49:45 -0700 (PDT)
In-Reply-To: <20170314221100.24856-2-bmwill@google.com>
References: <20170224235100.52627-1-bmwill@google.com> <20170314221100.24856-1-bmwill@google.com>
 <20170314221100.24856-2-bmwill@google.com>
From:   Stefan Beller <sbeller@google.com>
Date:   Tue, 14 Mar 2017 15:49:45 -0700
Message-ID: <CAGZ79kZwUcNB=ZKAb38CBMX1Y-EoP_CbXOzEod6wAaKnATghrg@mail.gmail.com>
Subject: Re: [PATCH v2 1/4] grep: fix help text typo
To:     Brandon Williams <bmwill@google.com>
Cc:     "git@vger.kernel.org" <git@vger.kernel.org>,
        Junio C Hamano <gitster@pobox.com>,
        Jeff King <peff@peff.net>,
        Johannes Schindelin <johannes.schindelin@gmx.de>,
        Duy Nguyen <pclouds@gmail.com>
Content-Type: text/plain; charset=UTF-8
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

On Tue, Mar 14, 2017 at 3:10 PM, Brandon Williams <bmwill@google.com> wrote:

Missing SoB here, too.

> ---
>  builtin/grep.c | 2 +-
>  1 file changed, 1 insertion(+), 1 deletion(-)
>
> diff --git a/builtin/grep.c b/builtin/grep.c
> index 9304c33e7..4694e68f3 100644
> --- a/builtin/grep.c
> +++ b/builtin/grep.c
> @@ -979,7 +979,7 @@ int cmd_grep(int argc, const char **argv, const char *prefix)
>                 OPT_SET_INT(0, "exclude-standard", &opt_exclude,
>                             N_("ignore files specified via '.gitignore'"), 1),
>                 OPT_BOOL(0, "recurse-submodules", &recurse_submodules,
> -                        N_("recursivley search in each submodule")),
> +                        N_("recursively search in each submodule")),
>                 OPT_STRING(0, "parent-basename", &parent_basename,
>                            N_("basename"),
>                            N_("prepend parent project's basename to output")),
> --
> 2.12.0.367.g23dc2f6d3c-goog
>
