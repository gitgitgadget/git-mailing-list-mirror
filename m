Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-2.8 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_HI,RCVD_IN_SORBS_SPAM,
	RP_MATCHES_RCVD shortcircuit=no autolearn=no autolearn_force=no version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id ACC5E20966
	for <e@80x24.org>; Wed,  5 Apr 2017 13:41:47 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1755127AbdDENlh (ORCPT <rfc822;e@80x24.org>);
        Wed, 5 Apr 2017 09:41:37 -0400
Received: from mail-it0-f68.google.com ([209.85.214.68]:33953 "EHLO
        mail-it0-f68.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1755000AbdDENl2 (ORCPT <rfc822;git@vger.kernel.org>);
        Wed, 5 Apr 2017 09:41:28 -0400
Received: by mail-it0-f68.google.com with SMTP id e75so1400341itd.1
        for <git@vger.kernel.org>; Wed, 05 Apr 2017 06:41:22 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=mime-version:in-reply-to:references:from:date:message-id:subject:to
         :cc;
        bh=m+ps08ESyl77aMTRgJ+JfjA/eNqFQtmkb9iy7FDW6hU=;
        b=Bq2QVA5SzBfUi05qsLdQzo0hmaz0V1ApIAQ6UVqApF0cMsHTvXNJoFRR0/Xlh12TSO
         NokMZjCW7s8wu9R7kT3BgdVZo1dBoNK0sOy00Mvo+t5lhTNkuAprozDY//ClE7USLOpl
         Vky5t+2u7BOhjxfjSD5oQdSaLQDbLTCa7/cL7cujLt28IYzvuOPHAoSGQdQN12xf0zKy
         7wGToV1oX7FCEuevdNyQtrqs8HT3QGI3j19uBLf6s8FQyY38ehJd3Z+vKqtSUj25y4KK
         aNEtb4A8nYuHRnX04b9rNvKtIXJfnF/XEOgVIxwwRHhE6OqSordApAlC1JpS+Ep8XZGz
         RSAg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:in-reply-to:references:from:date
         :message-id:subject:to:cc;
        bh=m+ps08ESyl77aMTRgJ+JfjA/eNqFQtmkb9iy7FDW6hU=;
        b=lERTu0hg722NCGJJtg7K8rlmK+LEtGz6dN8T6yA6DIa9I/CWt25WVqYTlfKIfC31Iu
         sFD0DhXbd8N+VZPsJnyklKanRosMSpDJCQcsJqW+X1Ouh8o2R0pVZMvKVIQJ/Zu9B+bh
         kgH4e6zcJDyUDXCpNo+N9tPEfju25/Rb8bmQybaLOf3lUnY8f3wlZTh0fwNCJ58sOO5D
         of501fwmnVX4a/4Ly9ISI8aG8p34rRrbwZ1/DUZzNCNUgCK/45AF1X8ho800SfN2XERe
         7ElMDEif5FnncClSUYSPT1S6gDFCX00SYHRXEZ4W6sGpZq7MZ8615EjUxz7D4hRPEgof
         I6VA==
X-Gm-Message-State: AFeK/H0TgdhdXMnrFviawdO1toq4Hxttci91oO47HdX3wvyTDYDVjVwp
        fSvEmoUWwCJnR6DQq5Bk2QyE9pTDAA==
X-Received: by 10.36.65.203 with SMTP id b72mr21365874itd.24.1491399677309;
 Wed, 05 Apr 2017 06:41:17 -0700 (PDT)
MIME-Version: 1.0
Received: by 10.107.130.208 with HTTP; Wed, 5 Apr 2017 06:40:56 -0700 (PDT)
In-Reply-To: <20170405130424.13803-4-tgc@jupiterrise.com>
References: <CACBZZX450tRRsy-Sj8igZthYov7UxFMRJ51M-b1cgYBLo782jQ@mail.gmail.com>
 <20170405130424.13803-1-tgc@jupiterrise.com> <20170405130424.13803-4-tgc@jupiterrise.com>
From:   =?UTF-8?B?w4Z2YXIgQXJuZmrDtnLDsCBCamFybWFzb24=?= <avarab@gmail.com>
Date:   Wed, 5 Apr 2017 15:40:56 +0200
Message-ID: <CACBZZX7_tH-Q6PWdj=2BryLnSw-dX__fuR8hvbwXG4sSaM61bg@mail.gmail.com>
Subject: Re: [PATCH 3/7] Allow svnrdump_sim.py to be used with Python 2.2
To:     "Tom G. Christensen" <tgc@jupiterrise.com>
Cc:     Git Mailing List <git@vger.kernel.org>,
        "Eric S. Raymond" <esr@thyrsus.com>
Content-Type: text/plain; charset=UTF-8
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

On Wed, Apr 5, 2017 at 3:04 PM, Tom G. Christensen <tgc@jupiterrise.com> wrote:
> This allows running the git-svn testsuite with Python 2.2.

+CC-ing Eric S. Raymond who added these version limitations in a33faf2827.

Also, in his patch contrib/svn-fe/svnrdump_sim.py,
git_remote_helpers/git/__init__.py & git-p4.py is set to >=2.4 or
later.

Are you skipping those tests & they don't work under 2.2?

> Signed-off-by: Tom G. Christensen <tgc@jupiterrise.com>
> ---
>  contrib/svn-fe/svnrdump_sim.py | 4 ++--
>  1 file changed, 2 insertions(+), 2 deletions(-)
>
> diff --git a/contrib/svn-fe/svnrdump_sim.py b/contrib/svn-fe/svnrdump_sim.py
> index 11ac6f692..86bf4a742 100755
> --- a/contrib/svn-fe/svnrdump_sim.py
> +++ b/contrib/svn-fe/svnrdump_sim.py
> @@ -8,9 +8,9 @@ to the highest revision that should be available.
>  import sys
>  import os
>
> -if sys.hexversion < 0x02040000:
> +if sys.hexversion < 0x02020000:
>      # The limiter is the ValueError() calls. This may be too conservative
> -    sys.stderr.write("svnrdump-sim.py: requires Python 2.4 or later.\n")
> +    sys.stderr.write("svnrdump-sim.py: requires Python 2.2 or later.\n")
>      sys.exit(1)
>
>
> --
> 2.12.2
>
