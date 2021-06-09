Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-13.8 required=3.0 tests=BAYES_00,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_CR_TRAILER,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 99BDFC48BCD
	for <git@archiver.kernel.org>; Wed,  9 Jun 2021 15:29:12 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 7F0A160E0B
	for <git@archiver.kernel.org>; Wed,  9 Jun 2021 15:29:12 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S236365AbhFIPbF (ORCPT <rfc822;git@archiver.kernel.org>);
        Wed, 9 Jun 2021 11:31:05 -0400
Received: from mail-ed1-f41.google.com ([209.85.208.41]:39835 "EHLO
        mail-ed1-f41.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S235379AbhFIPbE (ORCPT <rfc822;git@vger.kernel.org>);
        Wed, 9 Jun 2021 11:31:04 -0400
Received: by mail-ed1-f41.google.com with SMTP id dj8so29066531edb.6
        for <git@vger.kernel.org>; Wed, 09 Jun 2021 08:28:55 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=l52N71YkP7HS19h6c3co4mJ/cGvi+wVNOChO7uDZsxQ=;
        b=WLHkDLCM6F0NcqZjg/yhOYqFzOnn88dWtQJy2V2rcZNnRK/c9+grqJJPH5fji7Hpdx
         h2ruPlfsIrISZyAViMktWSAMDg48eG4uS45+ek37RkLD++SK2fkw6s6G2RcAXb+WRil9
         rFx1njS2a+TO9dPvXy8ixR1fE29NCpf9tfkU60g/sBE/LyBIzjvu5+p43hexbKbuWC6P
         PpyYD4HJUP/Inq8ieB2GHFuJanpJeJeH3c0Epn55zj57zI0+6MTyaHQ3d2gBzaAuBpiN
         FegcPwoVL+CfqGFz2+ID56tdUgjP5RTcSPhs9PfcqNWwAbFPkjZciLpWXpcjBjo/GM7x
         JQqw==
X-Gm-Message-State: AOAM533tTh7/oy95ZkHKa477Mce8fxOJGBTCzOHemEhhSribfDqmqhTs
        7QIoYKOxqz6lg9v3eUXelsrjZwu52SJsa9C4L6tEHaGMSmA=
X-Google-Smtp-Source: ABdhPJy4yHFCHPT4059aao20LP+wYPvjrhHgsC13HrmB7yeG/+TUm5s9x/2dmXUp3J0BYhCboEiftSkaSvBUsXBSKv8=
X-Received: by 2002:a50:eb08:: with SMTP id y8mr3817edp.89.1623252534731; Wed,
 09 Jun 2021 08:28:54 -0700 (PDT)
MIME-Version: 1.0
References: <20210609102641.3531183-1-rybak.a.v@gmail.com>
In-Reply-To: <20210609102641.3531183-1-rybak.a.v@gmail.com>
From:   Eric Sunshine <sunshine@sunshineco.com>
Date:   Wed, 9 Jun 2021 11:28:44 -0400
Message-ID: <CAPig+cTjjNrU9q8UPm+CRuTKq8_XNc+1z7-3F4bvetBi+NjKeQ@mail.gmail.com>
Subject: Re: [PATCH] fix typos which duplicate a word
To:     Andrei Rybak <rybak.a.v@gmail.com>
Cc:     Git List <git@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

On Wed, Jun 9, 2021 at 6:27 AM Andrei Rybak <rybak.a.v@gmail.com> wrote:
> Fix typos in documentation and code comments which repeat various words.
> These typos were found by searching using scripts like this:
> [...]
> Signed-off-by: Andrei Rybak <rybak.a.v@gmail.com>
> ---
> diff --git a/t/t6416-recursive-corner-cases.sh b/t/t6416-recursive-corner-cases.sh
> @@ -871,7 +871,7 @@ test_expect_failure 'merge of D2 & E4 merges a2s & reports conflict for a/file'
>  # it feels sound to say "B and C do not agree what the final pathname
>  # should be, but we know this content was derived from the common A:a so we
>  # use one path whose name is arbitrary in the virtual merge base X between
> -# D and E" and then further let the rename detection to notice that that
> +# D and E" and then further let the rename detection to notice that
>  # arbitrary path gets renamed between X-D to "newname" and X-E also to
>  # "newname" to resolve it as both sides renaming it to the same new
>  # name. It is akin to what we do at the content level, i.e. "B and C do not

All the other fixes for duplicate words look "obviously correct", but
in this case, the duplicate "that that" is likely intentional and
grammatically sensible, so perhaps drop this hunk from the patch?
