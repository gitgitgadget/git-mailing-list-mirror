Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 4517BE75459
	for <git@archiver.kernel.org>; Tue,  3 Oct 2023 18:30:54 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S240723AbjJCSaz convert rfc822-to-8bit (ORCPT
        <rfc822;git@archiver.kernel.org>); Tue, 3 Oct 2023 14:30:55 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:55076 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232004AbjJCSay (ORCPT <rfc822;git@vger.kernel.org>);
        Tue, 3 Oct 2023 14:30:54 -0400
Received: from mail-qv1-f48.google.com (mail-qv1-f48.google.com [209.85.219.48])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id D161790
        for <git@vger.kernel.org>; Tue,  3 Oct 2023 11:30:50 -0700 (PDT)
Received: by mail-qv1-f48.google.com with SMTP id 6a1803df08f44-65cff6a6878so7619286d6.1
        for <git@vger.kernel.org>; Tue, 03 Oct 2023 11:30:50 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1696357850; x=1696962650;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=p2aRDqCz/zKrWraNgbLbpj/CBSVWARLsV5jS9L9LBVg=;
        b=L7vAZl4Q0f+q6PD0Sou9tqxpftC5M0GqO+sccdtYceIOJQhKZuU3tDMGhKojoOq9jd
         fj8OMZ0JixVOZaTSk2fpb/hB4z+PhHJUoGKYHe/60TH25Be5I68nZd8+QtNCqTFj9Cay
         cXRCORQ5jxdIs9auOkc1x3TlOhv1lBR22RM6Z02bv++WuGO5H3eCDhzJ0ec+B0ySgUWs
         FUpEMLhyCnxbE+vIFw2IADzXfbM1Q1uQO3c8hrjftaq/NaEdWStAUJtgwfWNT4ULGquB
         O6kbCepY7JF+6oJaP4Yv3Rq5ovAyAAz3oEk6j9Q/JSLs7x0uRnkfUlcvBLcHUWAYvklE
         esBA==
X-Gm-Message-State: AOJu0YzDCTyb0wwMLUvj2xXyC0p4XiPwlhcMQf+q8ywm4h2zV+83dsP/
        iKbWhjrlZcvuwKp4H3TJL58SqCJZwGw8ruVHpglP8Bh0DVo=
X-Google-Smtp-Source: AGHT+IFs8sbsh0FpdTkkH66t1auPvFc1e805oaqIHJq3hiMOaz1fgQcGRhHOnz/Bx+O3o6jo9PydBCJOA6xt8K2DQjk=
X-Received: by 2002:a0c:f04c:0:b0:64f:43e9:b34d with SMTP id
 b12-20020a0cf04c000000b0064f43e9b34dmr133962qvl.50.1696357849828; Tue, 03 Oct
 2023 11:30:49 -0700 (PDT)
MIME-Version: 1.0
References: <20231003082107.3002173-1-stepnem@smrk.net>
In-Reply-To: <20231003082107.3002173-1-stepnem@smrk.net>
From:   Eric Sunshine <sunshine@sunshineco.com>
Date:   Tue, 3 Oct 2023 14:30:38 -0400
Message-ID: <CAPig+cR2wgAsGCTphqHsf_pbM0q_xLcMx=acVD6MDKhpEt3HNA@mail.gmail.com>
Subject: Re: [PATCH 1/5] Fix some typos, grammar or wording issues in the documentation
To:     =?UTF-8?B?xaB0xJtww6FuIE7Em21lYw==?= <stepnem@smrk.net>
Cc:     git@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: 8BIT
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

On Tue, Oct 3, 2023 at 4:28 AM Štěpán Němec <stepnem@smrk.net> wrote:
> Fix some typos, grammar or wording issues in the documentation

SubmittingPatches suggests: s/Fix/fix

Overall, these changes are welcome improvements. I've left a few minor
comments below which may or may not be actionable.

> Signed-off-by: Štěpán Němec <stepnem@smrk.net>
> ---
> diff --git a/Documentation/SubmittingPatches b/Documentation/SubmittingPatches
> @@ -393,8 +393,8 @@ mailing list{security-ml}, instead of the public mailing list.
>  Learn to use format-patch and send-email if possible.  These commands
>  are optimized for the workflow of sending patches, avoiding many ways
> -your existing e-mail client that is optimized for "multipart/*" mime
> -type e-mails to corrupt and render your patches unusable.
> +your existing e-mail client (often optimized for "multipart/*" MIME
> +type e-mails) might render your patches unusable.

A subjective alternative would have been to use commas to set off the
newly-parenthesized comment. Not worth a reroll.

> diff --git a/Documentation/git.txt b/Documentation/git.txt
> @@ -96,7 +96,7 @@ foo.bar= ...`) sets `foo.bar` to the empty string which `git config
>  This is useful for cases where you want to pass transitory
> -configuration options to git, but are doing so on OS's where
> +configuration options to git, but are doing so on OSes where

Since you're touching this anyhow, it could probably be made clearer
by simply spelling it out: "operating systems"

>  other processes might be able to read your cmdline
>  (e.g. `/proc/self/cmdline`), but not your environ
>  (e.g. `/proc/self/environ`). That behavior is the default on

I wonder if "cmdline" and "environ" would be better spelled out, as
well, since the examples which immediately follow them give the
necessary context.

    other processes might be able to read your command-line
    (e.g. `/proc/self/cmdline`), but not your environment
    (e.g. `/proc/self/environ`).

But perhaps that's outside the scope of this patch?

> diff --git a/Documentation/gitattributes.txt b/Documentation/gitattributes.txt
> @@ -1151,7 +1151,7 @@ will be stored via placeholder `%P`.
>  This attribute controls the length of conflict markers left in
> -the work tree file during a conflicted merge.  Only setting to
> +the work tree file during a conflicted merge.  Only setting
>  the value to a positive integer has any meaningful effect.

Or, more simply:

    Only a positive integer has a meaningful effect.

> diff --git a/contrib/README b/contrib/README
> @@ -24,14 +24,14 @@ lesser degree various foreign SCM interfaces, so you know the
>  I expect that things that start their life in the contrib/ area
> -to graduate out of contrib/ once they mature, either by becoming
> +graduate out of contrib/ once they mature, either by becoming

You probably want to add a comma after "area".

Do we want to correct the formatting of this pathname:

    ...in the `contrib/` area...
    ...out of `contrib/` once...

or is that outside the scope of this patch?

> diff --git a/strbuf.h b/strbuf.h
> @@ -12,9 +12,9 @@
> - * strbuf's are meant to be used with all the usual C string and memory
> + * strbufs are meant to be used with all the usual C string and memory

Alternatively:

    strbuf is meant to be used...

>   * APIs. Given that the length of the buffer is known, it's often better to
> - * use the mem* functions than a str* one (memchr vs. strchr e.g.).
> + * use the mem* functions than a str* one (e.g., memchr vs. strchr).
>   * Though, one has to be careful about the fact that str* functions often
>   * stop on NULs and that strbufs may have embedded NULs.

Similar:

    ... and that a strbuf may have...

> diff --git a/t/README b/t/README
> @@ -262,8 +262,8 @@ The argument for --run, <test-selector>, is a list of description
>  suite to include (or exclude, if negated) in the run.  A range is two
> -numbers separated with a dash and matches a range of tests with both
> -ends been included.  You may omit the first or the second number to
> +numbers separated with a dash and matches an inclusive range of tests
> +to run.  You may omit the first or the second number to

Not the fault of this patch, but "matches" seems an odd choice.
Perhaps "specifies" would feel more natural.

>  The argument to --run is split on commas into separate strings,
> @@ -579,11 +579,10 @@ This test harness library does the following things:
> -Here are some recommented styles when writing test case.

Do you want to fix the spelling error while you're here or is that
done in a later patch?

    s/recommented/recommended/

> - - Keep test title the same line with test helper function itself.
> + - Keep test titles and helper function invocations on the same line.

This would be clearer if it was switched around. Either:

    Keep the test_expect_* function call and test title on the same line.

or, more verbosely:

   Place the test title on the same line as the test_expect_* call
   which precedes it.
