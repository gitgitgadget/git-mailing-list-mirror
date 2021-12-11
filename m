Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id D83FCC433F5
	for <git@archiver.kernel.org>; Sat, 11 Dec 2021 21:19:32 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229615AbhLKVTc (ORCPT <rfc822;git@archiver.kernel.org>);
        Sat, 11 Dec 2021 16:19:32 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:45548 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229455AbhLKVTb (ORCPT <rfc822;git@vger.kernel.org>);
        Sat, 11 Dec 2021 16:19:31 -0500
Received: from mail-ed1-x533.google.com (mail-ed1-x533.google.com [IPv6:2a00:1450:4864:20::533])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 74A73C061714
        for <git@vger.kernel.org>; Sat, 11 Dec 2021 13:19:31 -0800 (PST)
Received: by mail-ed1-x533.google.com with SMTP id g14so39592560edb.8
        for <git@vger.kernel.org>; Sat, 11 Dec 2021 13:19:31 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc:content-transfer-encoding;
        bh=T6MPZX8l8yltYfrVi9ijDRJhPE5yIcsOZ4/rDX0slfI=;
        b=AThSjBfpNkZc/wXIGCv2y5CyhBdEu+uQ6dsL8T7CImx97WK4L0JU0BN28C123hDMcs
         nkHzd+eGY+QWGyI/yLL4i7OVuk6dfSeP7wIcKQFc1jgy06BZ4TConbkVQNq5f3rikATk
         eIehsqI75CpmUWDYjbUxyTosACDDEiutR4CpSZaAottYJiwaW/eMSyKcZP2luIhaMJKt
         EoIv2/5TcE340T6oMQtxJmfQDcwQflZDV+2qWmfCcemCkkvxy5EfqTigEI2J3Rh0cqBb
         GntGVxYqwaspwe2N5onaDwSLsv4R/IaFEViaPvw9dXwv6NUYjTIg5w5kWYM6WiH0nIxS
         zwNw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc:content-transfer-encoding;
        bh=T6MPZX8l8yltYfrVi9ijDRJhPE5yIcsOZ4/rDX0slfI=;
        b=e2XxNLU7bL8IHu8MWwmuX82UDHNE8WXeylMJwGTJHRMu9TDWAJLYYeahte5QJASrOA
         vcIZpc/ajlsPpUoEGR+shB275sSf4zauezWQ3QySKWF1zUYpFNQw1nYxfp+km1ps0WtC
         UzGf4xpYdTBz5n1Qjt25EgTu20nBuEaa/5l16qwmVwv6xf3uIT8H5gFstIBG9at87p+H
         APOboBYO0Aa25T+Er+W2HkA2gZLXPKkSa9xmKNq10oQXsyBYbKPKFCaYSl1wZlitqee+
         v2aXgTX7CRJRUOfz8RKFmt25fB0Ck2cMzrcoyJxg5HQx+j/+W0ilOVikdN2s0NDGg4Kb
         6wyA==
X-Gm-Message-State: AOAM531YwcAsiQEu1hzR6NsBIZS8/W+6ZaBPEb6pmUkiq8oZ/xjU93rG
        Hs7BV4CIHSzirCdlD2JExXRvcD7NK6fP7XhbMKM=
X-Google-Smtp-Source: ABdhPJyH13ybmQUBFnpcC6qaodzutWf+mLGpxm0FErwHOtjGX/pgdDJtv1hitalRThDGyMsAKLwQb6+Dn5XqNyRr9eA=
X-Received: by 2002:a17:906:31c2:: with SMTP id f2mr33831808ejf.341.1639257569907;
 Sat, 11 Dec 2021 13:19:29 -0800 (PST)
MIME-Version: 1.0
References: <20211210153101.35433-1-jholdsworth@nvidia.com> <20211210153101.35433-4-jholdsworth@nvidia.com>
In-Reply-To: <20211210153101.35433-4-jholdsworth@nvidia.com>
From:   Elijah Newren <newren@gmail.com>
Date:   Sat, 11 Dec 2021 13:19:18 -0800
Message-ID: <CABPp-BEyBLzWY2andDXZV6AgkQpnt1sp_rSThy84=qXMt2D8nA@mail.gmail.com>
Subject: Re: [PATCH v2 3/3] git-p4: add "Nvidia Corporation" to copyright header
To:     Joel Holdsworth <jholdsworth@nvidia.com>
Cc:     Git Mailing List <git@vger.kernel.org>,
        Tzadik Vanderhoof <tzadik.vanderhoof@gmail.com>,
        Dorgon Chang <dorgonman@hotmail.com>,
        Joachim Kuebart <joachim.kuebart@gmail.com>,
        Daniel Levin <dendy.ua@gmail.com>,
        Johannes Schindelin <johannes.schindelin@gmx.de>,
        Luke Diamand <luke@diamand.org>,
        Ben Keene <seraphire@gmail.com>,
        Andrew Oakley <andrew@adoakley.name>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

On Fri, Dec 10, 2021 at 12:30 PM Joel Holdsworth <jholdsworth@nvidia.com> w=
rote:
>
> The inclusion of the coorporate copyright is a stipulation of the
> company code release process.
> ---
>  git-p4.py | 1 +
>  1 file changed, 1 insertion(+)
>
> diff --git a/git-p4.py b/git-p4.py
> index 5568d44c72..17e18265dc 100755
> --- a/git-p4.py
> +++ b/git-p4.py
> @@ -5,6 +5,7 @@
>  # Author: Simon Hausmann <simon@lst.de>
>  # Copyright: 2007 Simon Hausmann <simon@lst.de>
>  #            2007 Trolltech ASA
> +#            2021 Nvidia Corporation
>  # License: MIT <http://www.opensource.org/licenses/mit-license.php>
>  #
>  # pylint: disable=3Dinvalid-name,missing-docstring,too-many-arguments,br=
oad-except
> --
> 2.33.0

Can we just get rid of all these copyright notices from all files in
Git?  They're obviously out-of-date and not even close to an accurate
indicator of authorship.  For example, builtin/branch.c has:

 * Copyright (c) 2006 Kristian H=C3=B8gsberg <krh@redhat.com>
 * Based on git-branch.sh by Junio C Hamano.

Kristian only authored 1 patch for this file (though that one patch
was submitted and attributed to Lars Hjemli in c31820c26b ("Make
git-branch a builtin", 2006-10-23) with a note in the commit message
about Kristian being the real author).  I added a simple replace
object to change the author attribution on Kristian's commit back to
him, and then...

Looking at shortlog, there are 86 different authors, with the top 7
having this many commits:

$ git shortlog -sn --no-merges -- builtin/branch.c builtin-branch.c | head =
-n 7
    42 Junio C Hamano
    37 Jeff King
    30 Nguy=E1=BB=85n Th=C3=A1i Ng=E1=BB=8Dc Duy
    16 Karthik Nayak
    12 Ren=C3=A9 Scharfe
    11 Lars Hjemli
    11 =C3=86var Arnfj=C3=B6r=C3=B0 Bjarmason

Looking at git blame, there are 61 different authors who have lines of
code surviving until today, with the top 7 being:

$ git blame -C -C builtin/branch.c | awk '{print $3 " " $4}' | sort |
uniq -c | sort -rn | head -n 7
    139 (Junio C
    129 (Nguy=E1=BB=85n Th=C3=A1i
    122 (Karthik Nayak
     40 (Jeff King
     38 (Kristian H=EF=BF=BDgsberg
     36 (Sahil Dua
     35 (Ren=C3=A9 Scharfe

So the copyright notice is horribly misleading at best.  It also seems
like the wrong way to figure out the answer to _any_ question I can
think of.  (Some examples: "Who can review my changes to this file?",
"Who do I need to contact for permission to relicense?", "Who should I
praise for doing the work of making this code so great for me?", etc.)
-- in all cases, shortlog, log, and blame are better tools.

Can we just git rid of these lines entirely?
