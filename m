Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 62DEDC4332F
	for <git@archiver.kernel.org>; Fri, 30 Dec 2022 03:13:25 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234415AbiL3DNX (ORCPT <rfc822;git@archiver.kernel.org>);
        Thu, 29 Dec 2022 22:13:23 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:56806 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229607AbiL3DNW (ORCPT <rfc822;git@vger.kernel.org>);
        Thu, 29 Dec 2022 22:13:22 -0500
Received: from mail-pg1-x534.google.com (mail-pg1-x534.google.com [IPv6:2607:f8b0:4864:20::534])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id DB23813D48
        for <git@vger.kernel.org>; Thu, 29 Dec 2022 19:13:18 -0800 (PST)
Received: by mail-pg1-x534.google.com with SMTP id w37so13472224pga.5
        for <git@vger.kernel.org>; Thu, 29 Dec 2022 19:13:18 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=mime-version:user-agent:message-id:in-reply-to:date:references
         :subject:cc:to:from:sender:from:to:cc:subject:date:message-id
         :reply-to;
        bh=LkgbhfT4hGqavIC8xbClZyowbFYCOcLLGbUPDfsrBR8=;
        b=cHhgolzQ84BSOZMtvK3QVluHrsBsgVFiei+chUCPSQSbbxd6yuK1/UhaB2V58vNpYo
         l96zCfrEberygDdXDbA4o0kmQ6Ceo55aIlajFNWDLJWbdctOnC5aRMQ6PG96RM51s9m2
         3g3YgCEM0uRjvuLZt2qOI124pIjAc+FGyH0PtpreRdG1rVXG39SdpRqZK8m0LAsXjz8t
         dJQ412tOx944HIGnDr32FpYdHaDbSRJiKl+p3LSBkPFViyCXUWYUQaVnI9WVaVPYT4jz
         4DaRelg8Av8e/B55gSyii0NISrq9lN22b6eg2B9hz+pASVxJ5Tv4480rFmaqeZcrnB5G
         tlGA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=mime-version:user-agent:message-id:in-reply-to:date:references
         :subject:cc:to:from:sender:x-gm-message-state:from:to:cc:subject
         :date:message-id:reply-to;
        bh=LkgbhfT4hGqavIC8xbClZyowbFYCOcLLGbUPDfsrBR8=;
        b=YHwFdPDE/04/pKFlA2w0xinR/og+m0G/l4Dfmae1ZgDbYd6VOXoAEQRF9qOprdsMR7
         hlGvX7QWZksRZXTJ+qqxKT6dGZDbzvSP5fJbm4IEnmYMUQCyV32D9rRYd3pR1xx4hLYk
         Ez92+Pg8AuSvjLaVleGACuXbt2imhFlyN1i/R4LR9FvO1ACRYQn6/XE3KDwZuHzuxHb0
         TJGKdykO+K36ixPP+RqAFvLpIi0lEqiKm90tppfCwbTWjTluLQWGeaSj8NVXy1qhrqNX
         8G/Ly3CD6T2ZIIsEXIOjh+MTDGdvp6ouSzJ33SYEVeigZcqsVTNRU3VmgQaVXP7Y3MBM
         1nDg==
X-Gm-Message-State: AFqh2koV9n9fDioRRRF8eZr2HoTCSDcVJrcNsmscXBFf3GY5fBvSc+Gw
        EI/fp0NZXT1Gbukw4M9jmnDjFczIXFYaLg==
X-Google-Smtp-Source: AMrXdXvDlwsa31VFy99+87BVi5ArEnmDrbIIgkvKnFpR6tNTsU61SbDxoHSBsUjSqtJvEXzHNy6aTA==
X-Received: by 2002:aa7:8215:0:b0:580:9151:afe5 with SMTP id k21-20020aa78215000000b005809151afe5mr23948276pfi.22.1672369997805;
        Thu, 29 Dec 2022 19:13:17 -0800 (PST)
Received: from localhost (33.5.83.34.bc.googleusercontent.com. [34.83.5.33])
        by smtp.gmail.com with ESMTPSA id b67-20020a621b46000000b0053e38ac0ff4sm12674440pfb.115.2022.12.29.19.13.17
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 29 Dec 2022 19:13:17 -0800 (PST)
Sender: Junio C Hamano <jch2355@gmail.com>
From:   Junio C Hamano <gitster@pobox.com>
To:     Samanta Navarro <ferivoz@riseup.net>
Cc:     git@vger.kernel.org
Subject: Re: [PATCH] maintenance: fix typos
References: <20221229125012.cp5tjdlnvxbln44l@localhost>
Date:   Fri, 30 Dec 2022 12:13:16 +0900
In-Reply-To: <20221229125012.cp5tjdlnvxbln44l@localhost> (Samanta Navarro's
        message of "Thu, 29 Dec 2022 12:50:12 +0000")
Message-ID: <xmqqmt75lh2r.fsf@gitster.g>
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/28.1 (gnu/linux)
MIME-Version: 1.0
Content-Type: text/plain
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Samanta Navarro <ferivoz@riseup.net> writes:

> Subject: Re: [PATCH] maintenance: fix typos

What's "maintenance:" doing here?  This touches all over the tree,
not only the part that are related to "git maintenance" subcommand.

>  git-gui/lib/themed.tcl                   | 2 +-

This is part of a separately managed project and a patch wants to go
there first, not mixed with changes to my tree.

> diff --git a/Documentation/CodingGuidelines b/Documentation/CodingGuidelines
> index 9d5c27807a..6c7465d690 100644
> --- a/Documentation/CodingGuidelines
> +++ b/Documentation/CodingGuidelines
> @@ -683,7 +683,7 @@ Writing Documentation:
> - Don't use spacing around "|" tokens when they're used to seperate the
> + Don't use spacing around "|" tokens when they're used to separate the

Good.

> diff --git a/Documentation/config.txt b/Documentation/config.txt
> index 0e93aef862..229b63a454 100644
> --- a/Documentation/config.txt
> +++ b/Documentation/config.txt
> @@ -182,7 +182,7 @@ included, Git breaks the cycle by prohibiting thes
> -As for the naming of this keyword, it is for forwards compatibiliy with
> +As for the naming of this keyword, it is for forwards compatibility with

Good.

> diff --git a/Documentation/fsck-msgids.txt b/Documentation/fsck-msgids.txt
> index 7af76ff99a..841ffeee38 100644
> --- a/Documentation/fsck-msgids.txt
> +++ b/Documentation/fsck-msgids.txt
> @@ -155,7 +155,7 @@
> -	(ERROR) Found a zero padded date in an author/commiter line.
> +	(ERROR) Found a zero padded date in an author/committer line.

Good.

> diff --git a/Documentation/git-cvsserver.txt b/Documentation/git-cvsserver.txt
> index 53f111bc0a..cf4a5a283e 100644
> --- a/Documentation/git-cvsserver.txt
> +++ b/Documentation/git-cvsserver.txt
> @@ -118,7 +118,7 @@ for example:
> -files, but only with the -d option (or -B if your system suports it).
> +files, but only with the -d option (or -B if your system supports it).

Good.

> diff --git a/Documentation/git-describe.txt b/Documentation/git-describe.txt
> index c6a79c2a0f..8ace8fb78a 100644
> --- a/Documentation/git-describe.txt
> +++ b/Documentation/git-describe.txt
> @@ -140,7 +140,7 @@ at the end.
> -The hash suffix is "-g" + an unambigous abbreviation for the tip commit
> +The hash suffix is "-g" + an unambiguous abbreviation for the tip commit

Good.

> diff --git a/Documentation/git-format-patch.txt b/Documentation/git-format-patch.txt
> index dfcc7da4c2..f4b6dbd2e1 100644
> --- a/Documentation/git-format-patch.txt
> +++ b/Documentation/git-format-patch.txt
> @@ -246,7 +246,7 @@ populated with placeholder text.
> -	version the new interation is compared against.
> +	version the new iteration is compared against.

Good.

> diff --git a/Documentation/git-ls-tree.txt b/Documentation/git-ls-tree.txt
> index 0240adb8ee..fa9a6b9f2c 100644
> --- a/Documentation/git-ls-tree.txt
> +++ b/Documentation/git-ls-tree.txt
> @@ -145,7 +145,7 @@ FIELD NAMES
> -into the resulting output. For each outputing line, the following
> +into the resulting output. For each outputting line, the following
>  names can be used:

The updated may use the correct spelling, but neither the original
or the updated sounds correct, neither gramatically or semantically.

 * Is "output" an intransitive verb (i.e. "The line outputs." is a
   complete sentence)?  I do not think so, but "each outputting
   line" implies so.  Like "InkJet printers output lines very
   slowly", "line" is an object of verb "output".  To make it
   readable, "for each line that is output" might work.

 * But the fields have nothing to do with "each line".  As described
   by an earlier paragraph, "--format" can take multiple fieldname
   and it is not like each fieldname substitutes to its one line.

Probably

    FIELD NAMES
    -----------

    Values from various structured fields can be interpolated into
    the resulting output.  The following can be used to name the
    fields in the `--format=<format>` option.

or something would work.

In any case, such a correction is beyond a typofix and should be
done outside the scope of this already unreadably big patch.

> diff --git a/Documentation/git-mktag.txt b/Documentation/git-mktag.txt
> index 466a697519..b2a2e80d42 100644
> --- a/Documentation/git-mktag.txt
> +++ b/Documentation/git-mktag.txt
> @@ -33,7 +33,7 @@ from warnings to errors (so e.g. a missing "tagger" line is an error).
> -the appropriate `fsck.<msg-id>` varible:
> +the appropriate `fsck.<msg-id>` variable:

Good.

> diff --git a/Documentation/git-sparse-checkout.txt b/Documentation/git-sparse-checkout.txt
> index 68392d2a56..d6d4d42fbd 100644
> --- a/Documentation/git-sparse-checkout.txt
> +++ b/Documentation/git-sparse-checkout.txt
> @@ -263,7 +263,7 @@ patterns in non-cone mode has a number of shortcomings:
> -    it complete "/pro" to "/proc" (in the root filesytem) rather than to
> +    it complete "/pro" to "/proc" (in the root filesystem) rather than to

Good.

> diff --git a/Documentation/git-stash.txt b/Documentation/git-stash.txt
> index f4bb6114d9..06fb7f1d18 100644
> --- a/Documentation/git-stash.txt
> +++ b/Documentation/git-stash.txt
> @@ -366,7 +366,7 @@ only the commit ends-up being in the stash
> -# ... hack hack hack, finish curent changes ...
> +# ... hack hack hack, finish current changes ...

Good.

> diff --git a/Documentation/gitformat-commit-graph.txt b/Documentation/gitformat-commit-graph.txt
> index 31cad585e2..76312fa249 100644
> --- a/Documentation/gitformat-commit-graph.txt
> +++ b/Documentation/gitformat-commit-graph.txt
> @@ -122,7 +122,7 @@ All multi-byte numbers are in network byte order.
> -      chunk is present and atleast one corrected commit date offset cannot
> +      chunk is present and at least one corrected commit date offset cannot

Good.

> diff --git a/Documentation/gitweb.txt b/Documentation/gitweb.txt
> index 7cee9d3689..74c35e8953 100644
> --- a/Documentation/gitweb.txt
> +++ b/Documentation/gitweb.txt
> @@ -234,7 +234,7 @@ from the template during repository creation, usually installed in
> -	Singe line category of a project, used to group projects if
> +	Single line category of a project, used to group projects if

Good.

As the patch is unreably long and boring to review for any sane
person in a single sitting, I would suggest splitting the above into
at least two patches, i.e.

 * [PATCH 1/n] doc: clarify ls-tree '--format' placeholders
 * [PATCH 2/n] Documentation: fix various typos

I haven't read the rest so I do not know what value 'n' will become,
but I would imagine fixes to typos in in-code comments may be one,
or it may need more than one.

I'll stop here, at least for now.  Thanks for working on it.
