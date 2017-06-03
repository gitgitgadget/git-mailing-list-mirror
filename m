Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-2.7 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_HI,RCVD_IN_SORBS_SPAM,
	RP_MATCHES_RCVD shortcircuit=no autolearn=no autolearn_force=no version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 2DC73209FD
	for <e@80x24.org>; Sat,  3 Jun 2017 16:55:47 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1751168AbdFCQzp (ORCPT <rfc822;e@80x24.org>);
        Sat, 3 Jun 2017 12:55:45 -0400
Received: from mail-it0-f49.google.com ([209.85.214.49]:37805 "EHLO
        mail-it0-f49.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1750991AbdFCQzo (ORCPT <rfc822;git@vger.kernel.org>);
        Sat, 3 Jun 2017 12:55:44 -0400
Received: by mail-it0-f49.google.com with SMTP id m47so43874541iti.0
        for <git@vger.kernel.org>; Sat, 03 Jun 2017 09:55:44 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=mime-version:in-reply-to:references:from:date:message-id:subject:to
         :cc;
        bh=7tyHoJC2fAdn97/bvJQws/n/PXN62YhxgkaHDGhLFus=;
        b=ZmIC8bbMourGfeC8xN1VILwPlEkUvXsaRkMWjh1YVau33XhcNvrMl3HtYvla3qzOuF
         Bm5TgBHUTbTedxp4LT+WyCkiSokUDacdcnFWWbrDDljwDo8XyTfRKrwQ+wAdm84iEAqB
         TY8RU/S9BBgKrRFUlteTlpwo5Cdgj1LdoHRQIx0hJ0CinWN6v72dvi2NVv5/D9e41hPp
         fZn74yEs2TEH+6Ruk4JvGGsoPV6IO0N34kRnjmRl6JgqEang0gdzK45lM444u6GMTAXx
         Izmp0NEcwm5Tma5BeptmrVPa0hjOHDqeeAK1WxE7Rm4AIAU2b0ThFQcVde/iAONMMpBH
         dikg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:in-reply-to:references:from:date
         :message-id:subject:to:cc;
        bh=7tyHoJC2fAdn97/bvJQws/n/PXN62YhxgkaHDGhLFus=;
        b=SwwGJ9Woxs3bNzWgqzUYAwlg4cLYrwUsLULeiBwvdYSkfKP/9QMvAmB6q9rycrb3Wi
         W2D/1exjIQvYC1ETGAN9OiR/4PXBXZdvnPX8K1t7+wMpl27KMyeaPWySbGCKPZzd1jEA
         ZuvpiaNkOtIU5emRPvfMC4TrQlnjCRuQoSdrcFaIk02gshAS8fDuYLvSOcccrKQB4q51
         4SPcuQQDrurHSboXDRBt5N/1jO/dPQQJUy/wFp+1VGHYu4GJZM6MpHzFIwfXLmAeqLQQ
         m0ZJsWyv1MJTygA44ZV7wf/q1lN6/xiXQrJDImzLDu+tT64uZw3T0AGe7jnTYsizrgvh
         XQVQ==
X-Gm-Message-State: AODbwcCudJ4HRkIHEVqePVAuTKoUflcumatiDN3WzcppapAToJ6B/Plm
        zuqahwUo+YUWoE1azJyuQxUYTDGjCzJgFjc=
X-Received: by 10.36.91.212 with SMTP id g203mr4429886itb.94.1496508943316;
 Sat, 03 Jun 2017 09:55:43 -0700 (PDT)
MIME-Version: 1.0
Received: by 10.107.3.231 with HTTP; Sat, 3 Jun 2017 09:55:22 -0700 (PDT)
In-Reply-To: <20170603133120.715-1-jwilk@jwilk.net>
References: <20170603133120.715-1-jwilk@jwilk.net>
From:   =?UTF-8?B?w4Z2YXIgQXJuZmrDtnLDsCBCamFybWFzb24=?= <avarab@gmail.com>
Date:   Sat, 3 Jun 2017 18:55:22 +0200
Message-ID: <CACBZZX7Sz6VPLQgzyQ1Dk+-899y0NzqMjVYL5ry0n-0axmR35w@mail.gmail.com>
Subject: Re: [PATCH] git-p4: remove obsolete version check
To:     Jakub Wilk <jwilk@jwilk.net>
Cc:     Git Mailing List <git@vger.kernel.org>,
        Luke Diamand <luke@diamand.org>,
        "Eric S. Raymond" <esr@thyrsus.com>
Content-Type: text/plain; charset="UTF-8"
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

On Sat, Jun 3, 2017 at 3:31 PM, Jakub Wilk <jwilk@jwilk.net> wrote:
> The file is syntactically correct only in Python >= 2.6, so the
> version check never does anything.

[CC-ing Eric who added that check]

Your commit message doesn't give an example of this, but with e.g.
python 2.0 you get:

      File "git-p4.py", line 469
        yield pattern
                ^
    SyntaxError: invalid syntax

I checked the various other python files that had similar warnings,
they all work correctly with python 2.0.

One workaround to keep this would be to make git-p4.py import some
library to do all its work, and use some subset of python syntax to
just load and defer to that library. That works for me when I change
it like that locally. Alternatively, does Python have something like
Perl's BEGIN {} blocks where you can execute code right there before
the file has finished parsing?

Or we could just remove this, just wanted to note the above since I
dug into it, and the commit message light on details.



> Signed-off-by: Jakub Wilk <jwilk@jwilk.net>
> ---
>  git-p4.py | 4 ----
>  1 file changed, 4 deletions(-)
>
> diff --git a/git-p4.py b/git-p4.py
> index 8d151da91..4278cd9d4 100755
> --- a/git-p4.py
> +++ b/git-p4.py
> @@ -8,10 +8,6 @@
>  # License: MIT <http://www.opensource.org/licenses/mit-license.php>
>  #
>  import sys
> -if sys.hexversion < 0x02040000:
> -    # The limiter is the subprocess module
> -    sys.stderr.write("git-p4: requires Python 2.4 or later.\n")
> -    sys.exit(1)
>  import os
>  import optparse
>  import marshal
> --
> 2.13.0.506.g27d5fe0cd
>
