Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.2 (2018-09-13) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-3.7 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,RCVD_IN_DNSWL_HI,
	SPF_HELO_NONE,SPF_NONE shortcircuit=no autolearn=ham
	autolearn_force=no version=3.4.2
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 6C8871F463
	for <e@80x24.org>; Thu, 26 Sep 2019 18:26:00 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728011AbfIZSZ7 (ORCPT <rfc822;e@80x24.org>);
        Thu, 26 Sep 2019 14:25:59 -0400
Received: from mail-vs1-f68.google.com ([209.85.217.68]:37888 "EHLO
        mail-vs1-f68.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727502AbfIZSZ7 (ORCPT <rfc822;git@vger.kernel.org>);
        Thu, 26 Sep 2019 14:25:59 -0400
Received: by mail-vs1-f68.google.com with SMTP id b123so71103vsb.5
        for <git@vger.kernel.org>; Thu, 26 Sep 2019 11:25:58 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=googlemail.com; s=20161025;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=5yWR9cw5BlL/gALKTCxK8q0jJmLxaA2i6ceo6b7cHTE=;
        b=sV2btQ5McB2+6eMbhMyYWO4asAKURmVsLkPKE2SKQjKHFPf6ASe28Mt6A0Nc48ojsW
         6h4ji4G3U/y9tnsjgSGNBfKWrYCEW6eOn7x7VJYYcRQwwa9sxntiuRvIyYI7WuVRVn4K
         lHV8Gu+BasfdeQe5EAB46xlAXQcWTl/2alBv5K5uS+S7u++t6Hq1uxSm9rtD7yjA+8nv
         p+3iCDH34Rd1KoyjrOPQOgqCOBIbXIV2KtiZKFJxqPK7UWnWPjTBSVN1rjCVFRnOfa8M
         gA33M5lEIP1adqszutQGnkC/x4SatGE1DFGziAJfVAzrMDB3avGxjrQ5BIfa6tLpZRf6
         AG2Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=5yWR9cw5BlL/gALKTCxK8q0jJmLxaA2i6ceo6b7cHTE=;
        b=D96/zshnZoQbQKtrsM4P4S3vzm5ie3wMeVE9Qq6zlRLR/5iF8rDoI3HJWR78VDFb3c
         g/Klq6MLb+2VPOri9N5VSA680hw5S27uH95j6xCU/QdphTGsnLC1spNXua9eyLN9P0zi
         0faLd98YR7cZlvXum8tMSV2ZT3ZBq25kSCvwbErEcdnZ+uOYk0J/aRa6MSlwApeUpRew
         TYDn+/GU0Hlx8mfV25FkgCj8W5F6Bu5ly3kPeX+PWi5kTd/fMOfPHrjCX5KY5jORN9Ru
         ItaKjo59hTmzOxjVsmbQKm089qcMgEovta4hevyQN+uafglkPwambJ3IJCWqv0E3POO7
         qxaw==
X-Gm-Message-State: APjAAAUJU8PUEK8hlXvro5nUhR00tcFit7VumjtxxW2jOxF0bfpSIpXd
        8TP+uwyqvMPjWDs1pj5cF5AoaXmLGXl7pbge/sM=
X-Google-Smtp-Source: APXvYqxBtgAZG+Wf2fgS0aqBNduMGuapW1DrdCcA7q30xyReZFaPJq80rW7piWV3ihFgpWs/Gm/C0D9/kCuxMKG4CT0=
X-Received: by 2002:a67:c991:: with SMTP id y17mr85436vsk.85.1569522357975;
 Thu, 26 Sep 2019 11:25:57 -0700 (PDT)
MIME-Version: 1.0
References: <pull.359.git.gitgitgadget@gmail.com> <02ec6c5bde2f15c51e946c6806d8231fb5abffe5.1569519804.git.gitgitgadget@gmail.com>
In-Reply-To: <02ec6c5bde2f15c51e946c6806d8231fb5abffe5.1569519804.git.gitgitgadget@gmail.com>
From:   Bert Wesarg <bert.wesarg@googlemail.com>
Date:   Thu, 26 Sep 2019 20:25:46 +0200
Message-ID: <CAKPyHN1XJHtcdzhaaeACFfb9=7PxdyHvrdafwJxDwQjbW_hbcA@mail.gmail.com>
Subject: Re: [PATCH 1/1] git gui: fix staging a second line to a 1-line file
To:     Johannes Schindelin via GitGitGadget <gitgitgadget@gmail.com>
Cc:     Git Mailing List <git@vger.kernel.org>,
        Pratyush Yadav <me@yadavpratyush.com>,
        Johannes Schindelin <johannes.schindelin@gmx.de>,
        Junio C Hamano <gitster@pobox.com>
Content-Type: text/plain; charset="UTF-8"
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

On Thu, Sep 26, 2019 at 7:43 PM Johannes Schindelin via GitGitGadget
<gitgitgadget@gmail.com> wrote:
>
> From: Johannes Schindelin <johannes.schindelin@gmx.de>
>
> When a 1-line file is augmented by a second line, and the user tries to
> stage that single line via the "Stage Line" context menu item, we do not
> want to see "apply: corrupt patch at line 5".
>
> The reason for this error was that the hunk header looks like this:
>
>         @@ -1 +1,2 @@
>
> but the existing code expects the original range always to contain a
> comma. This problem is easily fixed by cutting the string "1 +1,2"
> (that Git GUI formerly mistook for the starting line) at the space.
>
> This fixes https://github.com/git-for-windows/git/issues/515
>
> Signed-off-by: Johannes Schindelin <johannes.schindelin@gmx.de>
> ---
>  lib/diff.tcl | 1 +
>  1 file changed, 1 insertion(+)
>
> diff --git a/lib/diff.tcl b/lib/diff.tcl
> index 4cae10a4c7..68c4a6c736 100644
> --- a/lib/diff.tcl
> +++ b/lib/diff.tcl
> @@ -698,6 +698,7 @@ proc apply_range_or_line {x y} {
>                 set hh [$ui_diff get $i_l "$i_l + 1 lines"]
>                 set hh [lindex [split $hh ,] 0]
>                 set hln [lindex [split $hh -] 1]
> +               set hln [lindex [split $hln " "] 0]

this is already in that master

https://github.com/prati0100/git-gui/blob/60c60b627e81bf84e1cb01729d2ae882178f079d/lib/diff.tcl#L727

>
>                 # There is a special situation to take care of. Consider this
>                 # hunk:
> --
> gitgitgadget
