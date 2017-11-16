Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-2.9 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_HI,RP_MATCHES_RCVD
	shortcircuit=no autolearn=ham autolearn_force=no version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 152DE202AF
	for <e@80x24.org>; Thu, 16 Nov 2017 10:49:38 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S933736AbdKPKtg (ORCPT <rfc822;e@80x24.org>);
        Thu, 16 Nov 2017 05:49:36 -0500
Received: from mail-pg0-f65.google.com ([74.125.83.65]:44658 "EHLO
        mail-pg0-f65.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S933687AbdKPKte (ORCPT <rfc822;git@vger.kernel.org>);
        Thu, 16 Nov 2017 05:49:34 -0500
Received: by mail-pg0-f65.google.com with SMTP id 4so11402410pge.1
        for <git@vger.kernel.org>; Thu, 16 Nov 2017 02:49:34 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=mime-version:in-reply-to:references:from:date:message-id:subject:to
         :cc;
        bh=XLGyU/p+hMBOW7EK3E6oY9I8qltYmwKCuvLjxU/Kqwc=;
        b=pYn2/Su1TSiDwwznED6S2G1Gp9ArjudlPVQFaZPwfc1IbQbVm75IhWdJN6Cn592XJw
         0YltWouCCjt/KmFUiycmDjkhIeP0n53KhrHD7pftZX9Yr8zA/GCN9927f4wECWhXGp+2
         yTexwsQ3ZwSHgrb6t6m9UKf5EcqoNoMj8yXdbpzBlCBTBx8Q+w1/dtG6owWwS8hXOgGj
         CjxtkjBBFBY5p0kRXk6zrDE6IMn/eIrgzXgk/BsNJ6wtVeaC/n5BYRUlSAvw6n8U9BFY
         f7VYOWdujk1JthLpsnt7rQtpubDHmMHMi52SdJQa11xmHiPR6v6/NpOHvWQ4lRV6g1ro
         EiJw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:in-reply-to:references:from:date
         :message-id:subject:to:cc;
        bh=XLGyU/p+hMBOW7EK3E6oY9I8qltYmwKCuvLjxU/Kqwc=;
        b=g0ej664fURSQi5mak9v2q+jyUZs1zELO8Yaz1J7zDRA/SaZJ6ESkmFnQKPzy3qPmCQ
         teSXA0IpQR2+DZsMkdVyvaEQVYawgY2oh1vSNDyVXQCt/QzVWOxdhRSEKxIcas3QaFtX
         l6Jmgjncjl7jV3Gj+5BbqOAwhFM/N6JGErMDe6LtIKZsXQVYWyML1LYUyfvIrZm2pQsR
         nw3DYRXYaKsNeeaxtG0bv9Ci/EFH3etqA5hUogMAiqmFH3jMMT3RJ7sJgHo+UWB3XsQ8
         0WQ7U2kx9SWMePEHa7hmk7KcyxbCVWUSeTK+h2OWKkohbLM1QVWde+3QKcZlohE6gPKg
         YGrw==
X-Gm-Message-State: AJaThX5LScgGnmMy86l9pNjikulQLUgoA1MyEGunIQMhONdTduk3Bija
        9EfwmxHDlms44MlRCyBu/ygjqHGwCG7qTcv62dWK4A==
X-Google-Smtp-Source: AGs4zMb4EAc/ohILcd/npu80hnM3Jfo0Th9n2sCKJ7vK9dJ210YataGHUHUo19aNXXSu17emZlAO1PsGLH8qNIc1Gp4=
X-Received: by 10.159.234.3 with SMTP id be3mr1320076plb.322.1510829374000;
 Thu, 16 Nov 2017 02:49:34 -0800 (PST)
MIME-Version: 1.0
Received: by 10.100.167.42 with HTTP; Thu, 16 Nov 2017 02:49:33 -0800 (PST)
In-Reply-To: <20171116074643.19614-1-tmz@pobox.com>
References: <20171116074643.19614-1-tmz@pobox.com>
From:   =?UTF-8?Q?Martin_=C3=85gren?= <martin.agren@gmail.com>
Date:   Thu, 16 Nov 2017 11:49:33 +0100
Message-ID: <CAN0heSpUm=U7aGVtRoUoGZCvNsOZ04wLqTOx8kMvZEa8GQUiLQ@mail.gmail.com>
Subject: Re: [PATCH] branch doc: remove --set-upstream from synopsis
To:     Todd Zullinger <tmz@pobox.com>
Cc:     Git Mailing List <git@vger.kernel.org>,
        Kaartic Sivaraam <kaartic.sivaraam@gmail.com>,
        Junio C Hamano <gitster@pobox.com>
Content-Type: text/plain; charset="UTF-8"
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

On 16 November 2017 at 08:46, Todd Zullinger <tmz@pobox.com> wrote:
> Support for the --set-upstream option was removed in 52668846ea
> (builtin/branch: stop supporting the "--set-upstream" option,
> 2017-08-17), after a long deprecation period.
>
> Remove the option from the command synopsis for consistency.  Replace
> another reference to it in the description of `--delete` with
> `--set-upstream-to`.
>
> Signed-off-by: Todd Zullinger <tmz@pobox.com>
> ---
>
> I noticed that --set-upstream was still in the synopsis for git branch.  I
> don't think it was left there intentionally.  I looked through the thread where
> support for the option was removed and didn't notice any comments suggesting
> otherwise[1].  With luck, I didn't miss the obvious while reading the thread.
>
> [1] https://public-inbox.org/git/20170807143938.5127-1-kaarticsivaraam91196@gmail.com/

Actually, the first version of the series did remove it from the
synopsis [2]. That hunk was later dropped. Kaartic mentioned it [3] and
I thought out loud about it [4].

I get the same initial thought now as then: It's a bit odd that we pique
the interest of the reader, but that when they try it out or read up on
it, we say "nope, this is not what you are looking for".

> diff --git a/Documentation/git-branch.txt b/Documentation/git-branch.txt
> index d6587c5e96..159ca388f1 100644
> --- a/Documentation/git-branch.txt
> +++ b/Documentation/git-branch.txt
> @@ -14,7 +14,7 @@ SYNOPSIS
>         [(--merged | --no-merged) [<commit>]]
>         [--contains [<commit]] [--no-contains [<commit>]]
>         [--points-at <object>] [--format=<format>] [<pattern>...]
> -'git branch' [--set-upstream | --track | --no-track] [-l] [-f] <branchname> [<start-point>]
> +'git branch' [--track | --no-track] [-l] [-f] <branchname> [<start-point>]

Personally, I think this is an improvement.

>  'git branch' (--set-upstream-to=<upstream> | -u <upstream>) [<branchname>]
>  'git branch' --unset-upstream [<branchname>]
>  'git branch' (-m | -M) [<oldbranch>] <newbranch>
> @@ -86,7 +86,7 @@ OPTIONS
>  --delete::
>         Delete a branch. The branch must be fully merged in its
>         upstream branch, or in `HEAD` if no upstream was set with
> -       `--track` or `--set-upstream`.
> +       `--track` or `--set-upstream-to`.

Good catch.

Martin

[2] https://public-inbox.org/git/20170807143938.5127-2-kaarticsivaraam91196@gmail.com/

[3] https://public-inbox.org/git/20170817025425.6647-2-kaarticsivaraam91196@gmail.com/

[4] https://public-inbox.org/git/CAN0heSquaXk421sR6Ry59C+er8n26nC93=3KG1wD0xNXZkuiGw@mail.gmail.com/
