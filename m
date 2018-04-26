Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-3.6 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,RCVD_IN_DNSWL_HI
	shortcircuit=no autolearn=ham autolearn_force=no version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 6DFF51F424
	for <e@80x24.org>; Thu, 26 Apr 2018 23:11:55 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1755550AbeDZXLx (ORCPT <rfc822;e@80x24.org>);
        Thu, 26 Apr 2018 19:11:53 -0400
Received: from mail-ua0-f194.google.com ([209.85.217.194]:36962 "EHLO
        mail-ua0-f194.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1754166AbeDZXLw (ORCPT <rfc822;git@vger.kernel.org>);
        Thu, 26 Apr 2018 19:11:52 -0400
Received: by mail-ua0-f194.google.com with SMTP id i3so19306uad.4
        for <git@vger.kernel.org>; Thu, 26 Apr 2018 16:11:52 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=mime-version:in-reply-to:references:from:date:message-id:subject:to
         :cc;
        bh=ikMO05RXykUBbZ7bcAurLAVG7Yw5OciwhP2DgaEUbLs=;
        b=DjqNqn1r1iMDwf3EUF0dXM+QzX/XQBWeK+vHZcGRu0GqNk2Y57U27aHizILY1GAeM4
         qAFFNB9wa8A9hD8OMYPoSYMjM92xJEWWSO5Y+qXwjimssCMPr81p3X/MJMsj57vbhCkm
         gA0/Z5vXUvPtxqYOTxAPVOm133SfOv/2nVV3m3FPJVzowN/AwLcLBQ/ytw5yVWIK2ftA
         zy0PgA4GuIwmxQalsmYd87BNETx5conbisc7YrRkCQ8wfv97a0H7+IbZ22H1or0spFmY
         YgPIaTKXbxxXJYklpqxBA0us/cs8oU/F6NOdfrrWe2aLfKAqwIjzAFOT1RIOmtywonSu
         RiCw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:in-reply-to:references:from:date
         :message-id:subject:to:cc;
        bh=ikMO05RXykUBbZ7bcAurLAVG7Yw5OciwhP2DgaEUbLs=;
        b=bRVjRG/tqsqKEuiSKSZ2k7hES5ruqR0UWDhxQ614mrOGtr1AD1dtg1jM5cgOtq+7sq
         Vnbm1+dZoM7SpMN6Byjr8voYoyZ0ESXOa+Nj73jD+kxlQG68TNv95ocXvZlYvgVPM64Q
         p5RheBR+wPPARar7NJVn+QIDa6GseTNtHVQ4cpmPyuxJZg6Ap4HIdm9u/4e+Q0SuX5U2
         2H9zwiO4yeGHeZcocrva1CjwiPHhjZmmjMgKrqEv4SDZ98VozIt/gDlEw5B0zqGsn2CY
         ipIN6zcdUBwTgU9N0snwxVpbrhXWGmy4rtlNoPGEdaHjppsJxKDwryYFUn2H78vb8GxK
         umQQ==
X-Gm-Message-State: ALQs6tBgrdAoiE1QLTadIke31pRoXKPuFp16YaOeqfP5+U/imu6jrzF/
        OtKbo20VE/3JvHA+mSTtcQ7VxudGZVFasKSkjx0=
X-Google-Smtp-Source: AIpwx48lzu2acNvtyhPIKDi6yA39XYJoaPIvNA0jQ1a0/m70Hp9M85aFRa2d1JKLSY/fyNtAXKwtMBxkf8Iq1ESxOu4=
X-Received: by 10.176.83.38 with SMTP id x35mr25541808uax.29.1524784311512;
 Thu, 26 Apr 2018 16:11:51 -0700 (PDT)
MIME-Version: 1.0
Received: by 10.176.95.4 with HTTP; Thu, 26 Apr 2018 16:11:50 -0700 (PDT)
In-Reply-To: <20180426205202.23056-2-benpeart@microsoft.com>
References: <20180420133632.17580-1-benpeart@microsoft.com>
 <20180426205202.23056-1-benpeart@microsoft.com> <20180426205202.23056-2-benpeart@microsoft.com>
From:   Elijah Newren <newren@gmail.com>
Date:   Thu, 26 Apr 2018 16:11:50 -0700
Message-ID: <CABPp-BEa2EDdeDfcXxRERKAuOPUYTsBGZB8XyTXDYN1JpHsbXA@mail.gmail.com>
Subject: Re: [PATCH v3 1/3] merge: update documentation for {merge,diff}.renameLimit
To:     Ben Peart <Ben.Peart@microsoft.com>
Cc:     "git@vger.kernel.org" <git@vger.kernel.org>,
        "peff@peff.net" <peff@peff.net>,
        "gitster@pobox.com" <gitster@pobox.com>,
        "pclouds@gmail.com" <pclouds@gmail.com>,
        "vmiklos@frugalware.org" <vmiklos@frugalware.org>,
        Kevin Willford <kewillf@microsoft.com>,
        "Johannes.Schindelin@gmx.de" <Johannes.Schindelin@gmx.de>,
        "eckhard.s.maass@googlemail.com" <eckhard.s.maass@googlemail.com>,
        Jonathan Tan <jonathantanmy@google.com>
Content-Type: text/plain; charset="UTF-8"
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

On Thu, Apr 26, 2018 at 1:52 PM, Ben Peart <Ben.Peart@microsoft.com> wrote:
> Update the documentation to better indicate that the renameLimit setting is
> ignored if rename detection is turned off via command line options or config
> settings.
>
> Signed-off-by: Ben Peart <benpeart@microsoft.com>
> ---
>  Documentation/diff-config.txt  | 3 ++-
>  Documentation/merge-config.txt | 3 ++-
>  2 files changed, 4 insertions(+), 2 deletions(-)
>
> diff --git a/Documentation/diff-config.txt b/Documentation/diff-config.txt
> index 5ca942ab5e..77caa66c2f 100644
> --- a/Documentation/diff-config.txt
> +++ b/Documentation/diff-config.txt
> @@ -112,7 +112,8 @@ diff.orderFile::
>
>  diff.renameLimit::
>         The number of files to consider when performing the copy/rename
> -       detection; equivalent to the 'git diff' option `-l`.
> +       detection; equivalent to the 'git diff' option `-l`. This setting
> +       has no effect if rename detection is turned off.
>
>  diff.renames::
>         Whether and how Git detects renames.  If set to "false",
> diff --git a/Documentation/merge-config.txt b/Documentation/merge-config.txt
> index 12b6bbf591..48ee3bce77 100644
> --- a/Documentation/merge-config.txt
> +++ b/Documentation/merge-config.txt
> @@ -35,7 +35,8 @@ include::fmt-merge-msg-config.txt[]
>  merge.renameLimit::
>         The number of files to consider when performing rename detection
>         during a merge; if not specified, defaults to the value of
> -       diff.renameLimit.
> +       diff.renameLimit. This setting has no effect if rename detection
> +       is turned off.
>
>  merge.renormalize::
>         Tell Git that canonical representation of files in the
> --
> 2.17.0.windows.1

Patch looks fine, but it's hard for me not to notice a separate issue
in this area independent of your series: I'm curious if we should
document that the value of 0 is special here (as per Jonathan Tan's
commit 89973554b52c ("diffcore-rename: make diff-tree -l0 mean
-l<large>", 2017-11-29)), and doesn't actually drop the limit to 0.
cc'ing Jonathan Tan for his thoughts.
