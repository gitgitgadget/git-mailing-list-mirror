Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-3.7 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_HI,RCVD_IN_SORBS_SPAM,
	RP_MATCHES_RCVD shortcircuit=no autolearn=no autolearn_force=no version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 5E8EE201B0
	for <e@80x24.org>; Sun, 19 Feb 2017 00:17:48 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1750922AbdBSARq (ORCPT <rfc822;e@80x24.org>);
        Sat, 18 Feb 2017 19:17:46 -0500
Received: from mail-lf0-f53.google.com ([209.85.215.53]:33404 "EHLO
        mail-lf0-f53.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1750859AbdBSARp (ORCPT <rfc822;git@vger.kernel.org>);
        Sat, 18 Feb 2017 19:17:45 -0500
Received: by mail-lf0-f53.google.com with SMTP id x1so35995506lff.0
        for <git@vger.kernel.org>; Sat, 18 Feb 2017 16:17:44 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=mime-version:in-reply-to:references:from:date:message-id:subject:to
         :cc;
        bh=QtjmREq0XjK+wY+9Qj4RKlnO0jN8V4zM/CFAQDiFt9Y=;
        b=jLBlxL4jD/9lbjcKUmt2TWAwKukMb/7xoVa3wwgJDp067p1E4gbIazG4eB2mJjSJaL
         v+EF1egIJPv0714DkRDWRwY+KVgiDuLKECIBatPtMAhFqF30W9CUMpHqxHWfdvM96DHs
         1/jyf9mvukEvVSiQzj63HRyrPep4cZLS71o5v0jyipG5cL0UTO17jLZhpmvX4JHQMANM
         hs9R2sElrrwilfTJ1K1Suht9V09YlP+JxNJVwPK8f1gQ4c6MOknMDoCd7QZQuEIHCdgB
         QnH2OErJ2mRk0bPCA7ecSNu84ayrVot2RfXlRZisR6lOtge98r4Ulni0ACAP9W9vG892
         FsAQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:in-reply-to:references:from:date
         :message-id:subject:to:cc;
        bh=QtjmREq0XjK+wY+9Qj4RKlnO0jN8V4zM/CFAQDiFt9Y=;
        b=MhsxOhw3hqgdQXqTLrr+kPo9xaV3oyzBt+zB3O/7hs9qW9Ne0tuTe81kxBphFDSLmt
         Jto8IaH5daLFK15QIAcmkLk7yP398SX81rDEVFfECkCXipIr8q/Tej6pudt3Kuc/1bf7
         LEWXLNoz8p+l4Dm7B2zM6J0oth1SgoNFXg1jKaWk48A8m//PJi1xXLRlSXhQNfPO25Cr
         gsIY3NVEnvWPlMkKuKPqBGy+L7sY1Z/7EYPkhecAEtDHl89QkKd9Cg2yxxLp62SsZTD2
         IoC4AWip1jAFY1Jpg+E15Vjq1zJVJV8c1z0AsLzNmdfBoTB9GxpgtjjltlnKohxm00xl
         S2vw==
X-Gm-Message-State: AMke39nVCG21cc+DfszXmmdaeIPwupqTFh7wZURGpLAOBpFKj2FxQHXaiTz7mvFxElMJeduFTDx13URcYb1lpg==
X-Received: by 10.25.87.196 with SMTP id l187mr4151574lfb.143.1487463463504;
 Sat, 18 Feb 2017 16:17:43 -0800 (PST)
MIME-Version: 1.0
Received: by 10.25.145.14 with HTTP; Sat, 18 Feb 2017 16:17:22 -0800 (PST)
In-Reply-To: <c27d7861-b161-a3eb-fcfc-bf766fc7b20b@gmail.com>
References: <c27d7861-b161-a3eb-fcfc-bf766fc7b20b@gmail.com>
From:   Jacob Keller <jacob.keller@gmail.com>
Date:   Sat, 18 Feb 2017 16:17:22 -0800
Message-ID: <CA+P7+xrNb8xdbjFFAVVRDNe4Mho764PKYCbrLWmu4ykzU9A5dA@mail.gmail.com>
Subject: Re: [PATCH] git-check-ref-format: fix typo in man page
To:     Damien Regad <dregad@mantisbt.org>
Cc:     Git mailing list <git@vger.kernel.org>
Content-Type: text/plain; charset=UTF-8
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

On Sat, Feb 18, 2017 at 2:47 PM, Damien Regad <dregad@mantisbt.org> wrote:
>
> ---
>  Documentation/git-check-ref-format.txt | 2 +-
>  1 file changed, 1 insertion(+), 1 deletion(-)
>
> diff --git a/Documentation/git-check-ref-format.txt
> b/Documentation/git-check-ref-format.txt
> index 8611a99..377c85a 100644
> --- a/Documentation/git-check-ref-format.txt
> +++ b/Documentation/git-check-ref-format.txt
> @@ -100,7 +100,7 @@ OPTIONS
>  --normalize::
>         Normalize 'refname' by removing any leading slash (`/`)
>         characters and collapsing runs of adjacent slashes between
> -       name components into a single slash.  Iff the normalized
> +       name components into a single slash.  If the normalized

I think this is a good change, but I do know in some contexts, "Iff"
is used intentionally to mean "If and only if". It's somewhat unlikely
that's what was going on here, and I don't think we need to be that
pedantic in our help documentation anyway.

Thanks,
Jake

>         refname is valid then print it to standard output and exit
>         with a status of 0.  (`--print` is a deprecated way to spell
>         `--normalize`.)
> --
> 2.7.4
>
>
