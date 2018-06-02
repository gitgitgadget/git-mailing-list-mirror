Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-3.4 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,RCVD_IN_DNSWL_HI
	shortcircuit=no autolearn=ham autolearn_force=no version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 048441F42D
	for <e@80x24.org>; Sat,  2 Jun 2018 04:47:06 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1750776AbeFBErD (ORCPT <rfc822;e@80x24.org>);
        Sat, 2 Jun 2018 00:47:03 -0400
Received: from mail-ot0-f196.google.com ([74.125.82.196]:35578 "EHLO
        mail-ot0-f196.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1750748AbeFBErC (ORCPT <rfc822;git@vger.kernel.org>);
        Sat, 2 Jun 2018 00:47:02 -0400
Received: by mail-ot0-f196.google.com with SMTP id q17-v6so21054346otg.2
        for <git@vger.kernel.org>; Fri, 01 Jun 2018 21:47:02 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=mime-version:in-reply-to:references:from:date:message-id:subject:to
         :cc;
        bh=qxv10PJblo5obMVEE64ls/nAJbFIE3Nm90JX0g0436w=;
        b=Tu0VaY8cjyQCucq0ABGSYhhpJK4zZG9FDu5eJUoxAZ4GNQNGtdcQatN8/iBsq3yZHN
         3P4N0aKHFj/oZIVb5qKm30ztVhEDnMuFEpsgGZRlDj3iBqJ6sfoUfCQdZ4rnXrWgf+9r
         934vQ0RbCxVftQdUAbP8jbLNJDD0wlD/iftGRUO1TBqpbtzla6a+iTOqMFMAwr5aN8pI
         1y31iU/TSFnWZd7c9kofCDmA1ky1mjNV2aE+A9cwsD4rSBF7D44Saf9tgO+ROwpeEAuy
         0+WLwrtkR+rIfwN05x2N3fE64EP0kP5rBfNQWC0CJvllTYUAf+rg/z55QBAsxKX3u0jr
         0kng==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:in-reply-to:references:from:date
         :message-id:subject:to:cc;
        bh=qxv10PJblo5obMVEE64ls/nAJbFIE3Nm90JX0g0436w=;
        b=psnpTtelRNxmB7EuVGRjPKb6HT4y+js2HZThu4WlmhIlug4X4jO9xlx4QWGcKw2X6O
         PND+7hvRrmfGzvFpHSWGromvCiZ5rrEh6sjhSL3jwqlJ/5DROjwHjWXIikPx/V/StiER
         PVV309OAW2q8rrOD0EIrrE5aGaK2SinDIijh0gBzpuXFaoWEoDKumBEU86YLb7CeYzkV
         Yg3RcqumVyL9Mi0PquIoDhuqaGU+EYwzQ7q8HkHG8qKVc14737T9yODuG5vlc1p0NYjF
         NQzfRc7w6fK3iVyQ9mJOgtkCr++o4JqIjazUaIAmFbmu6B9lX5PqDV3NeWCNDwzy9LAn
         I7QQ==
X-Gm-Message-State: APt69E139QULypmIFiVwz7fPvYo0jtZQxH8yOGVoeSWHJsPYul77U8T+
        KAnDo4nrw4WW4PDP9g0wVCbatr6ntvhbLs26OuQ=
X-Google-Smtp-Source: ADUXVKJPU09GzExt8msTe5xUJBf7l560mFxXESr3TYGUz4AQXeYFbH8gqScCQ/s+KZQhG70F+gnFRmz5Avaozn3RSOg=
X-Received: by 2002:a9d:2c94:: with SMTP id p20-v6mr9573286otb.14.1527914822231;
 Fri, 01 Jun 2018 21:47:02 -0700 (PDT)
MIME-Version: 1.0
Received: by 2002:a4a:b285:0:0:0:0:0 with HTTP; Fri, 1 Jun 2018 21:46:31 -0700 (PDT)
In-Reply-To: <20180525024002.GA1998@sigill.intra.peff.net>
References: <xmqqvabm6csb.fsf@gitster-ct.c.googlers.com> <e440f6e0-6d7d-0e72-b875-de290cea6b94@gmail.com>
 <87fu2qbojy.fsf@evledraar.gmail.com> <20180517133601.GC17548@sigill.intra.peff.net>
 <1527174618.10589.4.camel@gmail.com> <20180524192214.GA21535@sigill.intra.peff.net>
 <20180524193105.GB21535@sigill.intra.peff.net> <xmqqh8mwpkgu.fsf@gitster-ct.c.googlers.com>
 <20180525024002.GA1998@sigill.intra.peff.net>
From:   Duy Nguyen <pclouds@gmail.com>
Date:   Sat, 2 Jun 2018 06:46:31 +0200
Message-ID: <CACsJy8AfCiJad8GD2xAWFp7WVFXZtZrqtE91awe0VS5Ni71rSw@mail.gmail.com>
Subject: Re: [PATCH] branch: issue "-l" deprecation warning after pager starts
To:     Jeff King <peff@peff.net>
Cc:     Junio C Hamano <gitster@pobox.com>,
        Kaartic Sivaraam <kaartic.sivaraam@gmail.com>,
        =?UTF-8?B?w4Z2YXIgQXJuZmrDtnLDsCBCamFybWFzb24=?= <avarab@gmail.com>,
        Git Mailing List <git@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

On Fri, May 25, 2018 at 4:40 AM, Jeff King <peff@peff.net> wrote:
> -- >8 --
> Subject: [PATCH] branch: customize "-l" warning in list mode
>
> People mistakenly use "git branch -l", thinking that it
> triggers list mode. It doesn't, but the lack of non-option
> arguments in that command does (and the "-l" becomes a
> silent noop).
>
> Since afc968e579 (branch: deprecate "-l" option, 2018-03-26)
> we've warned that "-l" is going away. But the warning text
> is primarily aimed at people who _meant_ to use "-l", as in
> "git branch -l foo". People who mistakenly said "git branch
> -l" may be left puzzled.
>
> Let's make it clear that:
>
>   1. No, "-l" didn't do what they thought here.
>
>   2. It's going away, and what they should do instead.
>
> Signed-off-by: Jeff King <peff@peff.net>
> ---
>  builtin/branch.c | 10 ++++++++--
>  1 file changed, 8 insertions(+), 2 deletions(-)
>
> diff --git a/builtin/branch.c b/builtin/branch.c
> index 55bfacd843..b0b33dab94 100644
> --- a/builtin/branch.c
> +++ b/builtin/branch.c
> @@ -701,8 +701,14 @@ int cmd_branch(int argc, const char **argv, const char *prefix)
>                 setup_auto_pager("branch", 1);
>
>         if (used_deprecated_reflog_option) {
> -               warning("the '-l' alias for '--create-reflog' is deprecated;");
> -               warning("it will be removed in a future version of Git");
> +               if (list) {
> +                       warning("the '-l' option is an alias for '--create-reflog' and");
> +                       warning("has no effect in list mode. This option will soon be");
> +                       warning("removed and you should omit it (or use '--list' instead).");
> +               } else {
> +                       warning("the '-l' alias for '--create-reflog' is deprecated;");
> +                       warning("it will be removed in a future version of Git");
> +               }

This is already in 'next', but could you do a follow up patch to mark
these strings for translation? While at there, concatenating them into
full sentences would also help translators.

>         }
>
>         if (delete) {
> --
> 2.17.0.1391.g6fdbf40724
>



-- 
Duy
