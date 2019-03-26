Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.2 (2018-09-13) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-3.0 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	FROM_EXCESS_BASE64,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,
	RCVD_IN_DNSWL_HI shortcircuit=no autolearn=ham autolearn_force=no
	version=3.4.2
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id A461820248
	for <e@80x24.org>; Tue, 26 Mar 2019 10:17:01 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1730362AbfCZKRA (ORCPT <rfc822;e@80x24.org>);
        Tue, 26 Mar 2019 06:17:00 -0400
Received: from mail-ed1-f65.google.com ([209.85.208.65]:38215 "EHLO
        mail-ed1-f65.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725948AbfCZKQ7 (ORCPT <rfc822;git@vger.kernel.org>);
        Tue, 26 Mar 2019 06:16:59 -0400
Received: by mail-ed1-f65.google.com with SMTP id q14so10220961edr.5
        for <git@vger.kernel.org>; Tue, 26 Mar 2019 03:16:58 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:references:user-agent:in-reply-to:date
         :message-id:mime-version;
        bh=+FiCt8KSLKT7tLJcQPtklxH0bCM3E2fgMEMikrBoCZ8=;
        b=CT5dHbkTG1vSQ/J9MoVGrrUZyfgXwrb3KTfYcRLDpagXjSFx6jhetvRmBQJyNEH7AC
         2LlBFeBLKAhm7WM22WX+Kx2qTo7pKeVOMDFwq/QVVNwTLH2+ViTa6uRTdjkrYv1uxVjd
         peux0i6yBLVjyYX1hZlD70bPOxwit89B2qKUe8lzB+2HAzjKuVZFq53iVCTKFrC3H0WF
         A0WJJ1CblMTxgD19BSryiVVERPBjOz1QmG799gV2TB9yIonDx7v5LraT3ZVuaBDATVJb
         YF0d/DXol/bbob8kTXQz1J5SF4dvzuzURVUYZyReQV1Qoc2G2TgTc1/eZUKPUKhb4IcS
         cM+Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:references:user-agent
         :in-reply-to:date:message-id:mime-version;
        bh=+FiCt8KSLKT7tLJcQPtklxH0bCM3E2fgMEMikrBoCZ8=;
        b=GKR5VPHo/Lj4Kg/9WtOqwlaUzdR5Wvli0c4GGb8pv5U7iSv7dNGmuTxsvnshQPXC7k
         ojsMZYOlvHfbxBgcAhXkXwyrjQeYZbEe8Jo2GEg7p6aVJBD7Xt0xX3RWr8VWGstzHBZb
         pbK3oosZqCBR6J00GxtGliMo/K+Vpj3jb2BudzeoMfjYI+huDdfQPzLSXJ2kG0AeYZGa
         dUtmaBtXtiG3FtIDKpFJ4GvvPwf4sW12puMFZbVQA2gVMPp/3yU++vhNcZueTFzU9D8o
         n8vJ0s1+Nk7NQViu9e7ycgfjuMHJSUaJEaitoHBpapHHwgasRLo98KRFZjD0QesQZYYA
         JfgA==
X-Gm-Message-State: APjAAAUylteaHYkugvqNC9w4bsenDh/pLcSZ+qjHkeJIRmI3c2UI0/r3
        o4PyhXDSySQI5pPZqH7mGMQk9cv22tE=
X-Google-Smtp-Source: APXvYqwEm/8HHz96jrcLVsix0BrREqoLj1ycoNny0FiqKbmtvIONMeuMA9LxggCY5D6b3vPUMpPFsg==
X-Received: by 2002:a17:906:33c5:: with SMTP id w5mr17133506eja.61.1553595417898;
        Tue, 26 Mar 2019 03:16:57 -0700 (PDT)
Received: from evledraar ([5.57.21.49])
        by smtp.gmail.com with ESMTPSA id x54sm2807494edd.35.2019.03.26.03.16.57
        (version=TLS1_2 cipher=ECDHE-RSA-CHACHA20-POLY1305 bits=256/256);
        Tue, 26 Mar 2019 03:16:57 -0700 (PDT)
From:   =?utf-8?B?w4Z2YXIgQXJuZmrDtnLDsA==?= Bjarmason <avarab@gmail.com>
To:     Denton Liu <liu.denton@gmail.com>
Cc:     Git Mailing List <git@vger.kernel.org>, Jeff King <peff@peff.net>,
        Robert Dailey <rcdailey.lists@gmail.com>
Subject: Re: [PATCH 3/3] git-tag.txt: document --allow-recursive-tag option
References: <20190325233723.GD23728@sigill.intra.peff.net> <cover.1553586707.git.liu.denton@gmail.com> <fe503ddc8f01f3c0c598b00da22c201a7f16ba7f.1553586707.git.liu.denton@gmail.com>
User-agent: Debian GNU/Linux buster/sid; Emacs 26.1; mu4e 1.1.0
In-reply-to: <fe503ddc8f01f3c0c598b00da22c201a7f16ba7f.1553586707.git.liu.denton@gmail.com>
Date:   Tue, 26 Mar 2019 11:16:56 +0100
Message-ID: <87ftraaqjr.fsf@evledraar.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org


On Tue, Mar 26 2019, Denton Liu wrote:

> Signed-off-by: Denton Liu <liu.denton@gmail.com>
> ---
>  Documentation/git-tag.txt | 7 ++++++-
>  1 file changed, 6 insertions(+), 1 deletion(-)
>
> diff --git a/Documentation/git-tag.txt b/Documentation/git-tag.txt
> index a74e7b926d..7e7eb9a7e9 100644
> --- a/Documentation/git-tag.txt
> +++ b/Documentation/git-tag.txt
> @@ -10,7 +10,7 @@ SYNOPSIS
>  --------
>  [verse]
>  'git tag' [-a | -s | -u <keyid>] [-f] [-m <msg> | -F <file>] [-e]
> -	<tagname> [<commit> | <object>]
> +	[--allow-recursive-tag] <tagname> [<commit> | <object>]
>  'git tag' -d <tagname>...
>  'git tag' [-n[<num>]] -l [--contains <commit>] [--no-contains <commit>]
>  	[--points-at <object>] [--column[=<options>] | --no-column]
> @@ -193,6 +193,11 @@ This option is only applicable when listing tags without annotation lines.
>  	that of linkgit:git-for-each-ref[1].  When unspecified,
>  	defaults to `%(refname:strip=2)`.
>
> +--allow-recursive-tag::
> +	Usually recursively tagging a tag object is a mistake and the
> +	command prevents you from making such a tag. This option
> +	bypasses the safety and allows this to happen.
> +
>  <tagname>::
>  	The name of the tag to create, delete, or describe.
>  	The new tag name must pass all checks defined by

Like 1/3 I this should just be squashed into the one patch. No reason to
leave the doc change in another change.

I see the existing --allow-unrelated-histories uses a similar tone, but
maybe something closer to noting that there's nothing wrong with doing
this, and maybe even point out the signed "chain of custody" tagging as
one use-case, then finally noting that since people usually don't really
want this it's disabled by default.

Finally, since "git tag" gets used by scripts a lot in practice, maybe
note that this behavior changed in "Git version 2.22.0".
