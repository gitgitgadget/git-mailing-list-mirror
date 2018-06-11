Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.1 (2015-04-28) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-11.4 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,
	RCVD_IN_DNSWL_HI,T_DKIMWL_WL_MED,USER_IN_DEF_DKIM_WL shortcircuit=no
	autolearn=ham autolearn_force=no version=3.4.1
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id BC3031F403
	for <e@80x24.org>; Mon, 11 Jun 2018 21:31:52 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S934586AbeFKVbu (ORCPT <rfc822;e@80x24.org>);
        Mon, 11 Jun 2018 17:31:50 -0400
Received: from mail-yb0-f196.google.com ([209.85.213.196]:34902 "EHLO
        mail-yb0-f196.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S932840AbeFKVbu (ORCPT <rfc822;git@vger.kernel.org>);
        Mon, 11 Jun 2018 17:31:50 -0400
Received: by mail-yb0-f196.google.com with SMTP id f79-v6so7218387ybg.2
        for <git@vger.kernel.org>; Mon, 11 Jun 2018 14:31:49 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20161025;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=2iEnF8Ze0Q2C0FZcCXpW3LBrxJcj2NRe9vHKe3m+U/Y=;
        b=VZI1HxOFx2JfArr2LQMroNMUaTjnVsT1Jvy6ywn2bkC9ip4hbPe+2mpWTyev2k/GYI
         SpJ1VQsRKVv5lFtso4fPhB5+gTx3VdGXw+cpLRDPGRtW3R7+fFs2UjBnpVRO+ZGipOIX
         jy+GB9iQpomLz5bqOCJZWVGpyjOmsRyLpI0WLonmAkxvnubA4p/qK7izZFqnEb9turog
         OKC4fQrFFjNIb0j8Tnr1dk4Oke1KnRC3PKYtObP33XpA4ZP4J2qcJ71NvEzeFFMbdzvk
         4iy3B8nkDvQM0gBB/i/do10NkrLpjdS4iiaNh6M0lpf8k9tCj0gtEL0sHL34EMFp/jzc
         XL6w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=2iEnF8Ze0Q2C0FZcCXpW3LBrxJcj2NRe9vHKe3m+U/Y=;
        b=UeHU1A1sbRWeLwoixF3JzXtnOBJaLCtBWNe5WcLrz7QL/J8/fidkr/PwyPbCvgAFTK
         wa3gaK8J7I0A/uG/z+aPvKtnkRzWfdBTs0jBSzv3toNAUUyEd8uDM8MG0BD4rg1qUWQi
         4H0Ruv1CITqLFdqcvv/t7zWn8/9E66NDBxb+Fl5Hk1YZfy9v+pEN+9hyHpg6FfUJJ46Z
         eA5WSF6XLIqlynPhzmQ1fvpAV0W0RrMtaSawa1AD+TgwuZ8CTkj5pTESPXwYbPd4XoUC
         v6wsXBiyvP+IJUaqSnIf5I6jC/8s9nDJ57390ALdM4S8oy0LfsKAR3EguIBDhooPliip
         tnYQ==
X-Gm-Message-State: APt69E2OEnM1I8SPLJrxli+70SW5tsK9rgwKSdR/ntuYanc2Yh0UN1CM
        NxMe64bv+I7+vu9TSOhsXeB64eM0gyvYqeC80UNCjNk5
X-Google-Smtp-Source: ADUXVKLdD4QZIClfv/5FlhLN8u6oLKhrqGh89OckrA+4kVfaxGYurk6dcw0dNqIhJPNpFqo6iSW16Zk+8rxMhtZdAV8=
X-Received: by 2002:a25:cc54:: with SMTP id l81-v6mr427386ybf.334.1528752708958;
 Mon, 11 Jun 2018 14:31:48 -0700 (PDT)
MIME-Version: 1.0
References: <alpine.LFD.2.21.1806110954470.14784@localhost.localdomain>
In-Reply-To: <alpine.LFD.2.21.1806110954470.14784@localhost.localdomain>
From:   Stefan Beller <sbeller@google.com>
Date:   Mon, 11 Jun 2018 14:31:37 -0700
Message-ID: <CAGZ79kYh2An4GXH3EQiXtNfCEaCMnHdWa9pt8k=d6FP1JM_+iQ@mail.gmail.com>
Subject: Re: [PATCH] diff-options.txt: fix minor typos, font inconsistencies,
 in docs
To:     "Robert P. J. Day" <rpjday@crashcourse.ca>
Cc:     git <git@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

On Mon, Jun 11, 2018 at 6:58 AM Robert P. J. Day <rpjday@crashcourse.ca> wrote:
>
> Signed-off-by: Robert P. J. Day <rpjday@crashcourse.ca>

The code is
Reviewed-by: Stefan Beller <sbeller@google.com>

Is this patch missing three dashes between commit message and the patch itself?
How did you send this patch?

>
> diff --git a/Documentation/diff-options.txt b/Documentation/diff-options.txt
> index f466600972..30aad8396d 100644
> --- a/Documentation/diff-options.txt
> +++ b/Documentation/diff-options.txt
> @@ -64,7 +64,7 @@ ifndef::git-format-patch[]
>  endif::git-format-patch[]
>
>  --indent-heuristic::
> -       Enable the heuristic that shift diff hunk boundaries to make patches
> +       Enable the heuristic that shifts diff hunk boundaries to make patches
>         easier to read. This is the default.
>
>  --no-indent-heuristic::
> @@ -106,7 +106,7 @@ diff" algorithm internally.
>         low-occurrence common elements".
>  --
>  +
> -For instance, if you configured diff.algorithm variable to a
> +For instance, if you configured the `diff.algorithm` variable to a
>  non-default value and want to use the default one, then you
>  have to use `--diff-algorithm=default` option.
>
> @@ -350,7 +350,7 @@ ifndef::git-format-patch[]
>         Warn if changes introduce conflict markers or whitespace errors.
>         What are considered whitespace errors is controlled by `core.whitespace`
>         configuration.  By default, trailing whitespaces (including
> -       lines that solely consist of whitespaces) and a space character
> +       lines that consist solely of whitespaces) and a space character
>         that is immediately followed by a tab character inside the
>         initial indent of the line are considered whitespace errors.
>         Exits with non-zero status if problems are found. Not compatible
> @@ -364,7 +364,7 @@ ifndef::git-format-patch[]
>         this option is not given, and the configuration variable
>         `diff.wsErrorHighlight` is not set, only whitespace errors in
>         `new` lines are highlighted. The whitespace errors are colored
> -       whith `color.diff.whitespace`.
> +       with `color.diff.whitespace`.
>
>  endif::git-format-patch[]
