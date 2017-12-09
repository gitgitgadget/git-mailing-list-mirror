Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-2.8 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_HI,T_RP_MATCHES_RCVD
	shortcircuit=no autolearn=no autolearn_force=no version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 6AA121F407
	for <e@80x24.org>; Sat,  9 Dec 2017 08:07:14 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1751068AbdLIIHM (ORCPT <rfc822;e@80x24.org>);
        Sat, 9 Dec 2017 03:07:12 -0500
Received: from mail-wm0-f66.google.com ([74.125.82.66]:45542 "EHLO
        mail-wm0-f66.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1750952AbdLIIHL (ORCPT <rfc822;git@vger.kernel.org>);
        Sat, 9 Dec 2017 03:07:11 -0500
Received: by mail-wm0-f66.google.com with SMTP id 9so6508590wme.4
        for <git@vger.kernel.org>; Sat, 09 Dec 2017 00:07:11 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=mime-version:in-reply-to:references:from:date:message-id:subject:to
         :cc;
        bh=uwjbI8iNLBAna64qJ2EAly5dQUajZvPuliSR0N52GkI=;
        b=bF3v8o6On184qYh+4Igp71WYD2R9NVOnkJT0Dvs2/QIXc2UJNZuhVe2gxzP44Cvd3H
         VECfmaWYoPNrT32f7OMiNdXpcvqZAoJ7l2MocP1ojgqcwKr0RgWBgBRarcF64kOXAaKg
         S567xj2vOeiOQdJAPPXJ7QuzUFDeVfQOVHfYvcVztRe/GR+YqNSdlhq2IClNxKlhPq1e
         MPsHxPtep5f0qk9pNMv2ensA+UAmoGzRN72IXk4Ghlasn488PAL7F2KvrvPnW26znd8R
         LXniWv1v9Y3lRJtmgExFuEVuCTeIG9F9F4QwzU5ukzbyiE3uM9OmpqTm7f2FHzdyGC+t
         4m8w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:in-reply-to:references:from:date
         :message-id:subject:to:cc;
        bh=uwjbI8iNLBAna64qJ2EAly5dQUajZvPuliSR0N52GkI=;
        b=PQ4aMiliVAjqvbWBHh3upY0ZWbKU2mw3wJ9nWa6zST/pZ0ie8YsTo9SFSxQnLXOKSO
         GbubRL8OpBObCBEOZ03mvPEgI3Yvk5ov+vGN7DkE72Fg6I74JMy/uhBMnq6WHOSeZQPd
         7/OVrPGluadklvDNi0OO5xcGkKhWTbpPzDrZkAEvTTAOpuLKkIHMEQhO9O0ImBaAowK9
         JNvnAtHsiQ5eQZ568fq5KYCOoENFHW2Its0BS7DmQYw9q+g09+Z+7Bw//mFYdrcwgzPt
         VKs+4KuqYRHHcBYtfdYiwpEgQqJaA8C35YD3d9emaRCTf519YwVkszQqQhVF0+iY7Ymz
         NyNg==
X-Gm-Message-State: AJaThX79cRmHG+fXelQhfPCt8nr/mjg3WggkjJHuGknz83/Cn91iIfJI
        b171crySW/DurGDZnxLgch6WSurtlWC77kQD0RI=
X-Google-Smtp-Source: AGs4zMYrMxa4ddBWkRcq3k6jHN8ZBx72uR9dclidZ/oP+ZjZLbhePt9xearJ7JfTBG36gEtQ50VS37UTMOUW2RIxWXI=
X-Received: by 10.80.217.6 with SMTP id t6mr44870826edj.217.1512806830360;
 Sat, 09 Dec 2017 00:07:10 -0800 (PST)
MIME-Version: 1.0
Received: by 10.80.174.252 with HTTP; Sat, 9 Dec 2017 00:06:49 -0800 (PST)
In-Reply-To: <20171208051636.GA24693@sigill.intra.peff.net>
References: <20171208051636.GA24693@sigill.intra.peff.net>
From:   Jacob Keller <jacob.keller@gmail.com>
Date:   Sat, 9 Dec 2017 00:06:49 -0800
Message-ID: <CA+P7+xr6XhnrxSk-jR0HyGksFsjBFkBuEr-RR8U-nEFUpJNJvg@mail.gmail.com>
Subject: Re: [PATCH] docs/pretty-formats: mention commas in %(trailers) syntax
To:     Jeff King <peff@peff.net>
Cc:     Git mailing list <git@vger.kernel.org>,
        Taylor Blau <me@ttaylorr.com>,
        Junio C Hamano <gitster@pobox.com>
Content-Type: text/plain; charset="UTF-8"
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

On Thu, Dec 7, 2017 at 9:16 PM, Jeff King <peff@peff.net> wrote:
> Commit 84ff053d47 (pretty.c: delimit "%(trailers)" arguments
> with ",", 2017-10-01) switched the syntax of the trailers
> placeholder, but forgot to update the documentation in
> pretty-formats.txt.
>
> There's need to mention the old syntax; it was never in a
> released version of Git.
>
> Signed-off-by: Jeff King <peff@peff.net>
> ---
> This should go on top of tb/delimit-pretty-trailers-args-with-comma.
>
>  Documentation/pretty-formats.txt | 12 +++++++-----
>  1 file changed, 7 insertions(+), 5 deletions(-)
>
> diff --git a/Documentation/pretty-formats.txt b/Documentation/pretty-formats.txt
> index d433d50f81..e664c088a5 100644
> --- a/Documentation/pretty-formats.txt
> +++ b/Documentation/pretty-formats.txt
> @@ -204,11 +204,13 @@ endif::git-rev-list[]
>    than given and there are spaces on its left, use those spaces
>  - '%><(<N>)', '%><|(<N>)': similar to '% <(<N>)', '%<|(<N>)'
>    respectively, but padding both sides (i.e. the text is centered)
> -- %(trailers): display the trailers of the body as interpreted by
> -  linkgit:git-interpret-trailers[1]. If the `:only` option is given,
> -  omit non-trailer lines from the trailer block.  If the `:unfold`
> -  option is given, behave as if interpret-trailer's `--unfold` option
> -  was given. E.g., `%(trailers:only:unfold)` to do both.
> +- %(trailers[:options]): display the trailers of the body as interpreted
> +  by linkgit:git-interpret-trailers[1]. The `trailers` string may be
> +  followed by a colon and zero or more comma-separated options. If the
> +  `only` option is given, omit non-trailer lines from the trailer block.
> +  If the `unfold` option is given, behave as if interpret-trailer's
> +  `--unfold` option was given.  E.g., `%(trailers:only,unfold)` to do
> +  both.
>
>  NOTE: Some placeholders may depend on other options given to the
>  revision traversal engine. For example, the `%g*` reflog options will
> --
> 2.15.1.659.g8bd2eae3ea

HAH. I was recently looking at this documentation and going to send a
patch. Looks good besides the other reviewers comments.

Thanks,
Jake
