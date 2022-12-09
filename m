Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id A2DBEC001B2
	for <git@archiver.kernel.org>; Fri,  9 Dec 2022 02:02:18 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230004AbiLICCR (ORCPT <rfc822;git@archiver.kernel.org>);
        Thu, 8 Dec 2022 21:02:17 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:60274 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230134AbiLICCG (ORCPT <rfc822;git@vger.kernel.org>);
        Thu, 8 Dec 2022 21:02:06 -0500
Received: from mail-pl1-x62e.google.com (mail-pl1-x62e.google.com [IPv6:2607:f8b0:4864:20::62e])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id C5D833056E
        for <git@vger.kernel.org>; Thu,  8 Dec 2022 18:02:05 -0800 (PST)
Received: by mail-pl1-x62e.google.com with SMTP id jl24so3373430plb.8
        for <git@vger.kernel.org>; Thu, 08 Dec 2022 18:02:05 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=mime-version:user-agent:message-id:in-reply-to:date:references
         :subject:cc:to:from:sender:from:to:cc:subject:date:message-id
         :reply-to;
        bh=5mvUsqkIrp0PcvHLxFjV6upEtJmXCs0VPOkXvQ02R+E=;
        b=NY70kbXAATN5IDjTnvqStTjE7AoAH5MrtZxdJDD4iUKk0vyqTLqgcdXaq7Dr5eLehJ
         Nft2TTlhuuI4hIPkFaSnjs8AJcIFza1lDgvqS2UWNhPTtObwpSYRM1Q6jArdW5aaXCT3
         7CPXnJ6o7i8lsy0pcLCGUVZ0UIKFx0mX8V2g3cUp4Df0BbGYMzbkxTktNy+YPIF2rSM+
         FZK6cnVosOlCI4cf/QmgIWus1K8jRnED2/t5cQSl3qheQj88aLAeX9JADwRhrwec6a+A
         Mds0wfJxHRQS17ANEubOYC/o95AHwZDPaUGJ+/DpZ3Mzk8WTOQrAlMXzqNq307TC7/jk
         4KaQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=mime-version:user-agent:message-id:in-reply-to:date:references
         :subject:cc:to:from:sender:x-gm-message-state:from:to:cc:subject
         :date:message-id:reply-to;
        bh=5mvUsqkIrp0PcvHLxFjV6upEtJmXCs0VPOkXvQ02R+E=;
        b=X+g81BLZ2egqpeGYJgXFgd1QR5iS+pABiRJuR6V1Cmx7JEGSRTgav41FquV3G04nae
         /KirezbxS9i3cjb9Eja3ruosaYGa4jCOQTvkcMug6JqjDAXHtMde3v0H4tNfQVOwkTfI
         P+rFcUsO4V2pRxunj8yoYo0Ig0QKIR0JkVAJBk2sjaL/ZdaxgeWttLf4aJTrt99j6ekr
         3QrpYfgI/TulqnjtXy6dyUr0pqEEXIqUQfizLJ8mWOLoNfMikAGVkx6TF6c9ozPYcZS0
         RCzbmrndxreNhnsqYVf8uzAmJT95jyjW25YPSdampZOr07JSSDcrmrLkqeEwAPMvg5Bn
         3b9w==
X-Gm-Message-State: ANoB5pmpSAdHwK3T0FRtKPrbUNrq5gENWCNgFnBvSb4LcBkxy6qImjfY
        LA8OQMMfOXF+FQFHoGt2Cx0=
X-Google-Smtp-Source: AA0mqf7Qyz5vNHjCFyztszZXn1xBHUpaJd9nT7WpFSKO7uPp09j9yaT2oMVAxn8ENvIDffUVe6sl6w==
X-Received: by 2002:a17:903:4d2:b0:186:aec7:ae6 with SMTP id jm18-20020a17090304d200b00186aec70ae6mr3799774plb.56.1670551325152;
        Thu, 08 Dec 2022 18:02:05 -0800 (PST)
Received: from localhost (33.5.83.34.bc.googleusercontent.com. [34.83.5.33])
        by smtp.gmail.com with ESMTPSA id h13-20020a170902680d00b00186b758c9fasm107526plk.33.2022.12.08.18.02.04
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 08 Dec 2022 18:02:04 -0800 (PST)
Sender: Junio C Hamano <jch2355@gmail.com>
From:   Junio C Hamano <gitster@pobox.com>
To:     "Johannes Schindelin via GitGitGadget" <gitgitgadget@gmail.com>
Cc:     git@vger.kernel.org,
        Johannes Schindelin <johannes.schindelin@gmx.de>
Subject: Re: [PATCH] Fix a couple of typos in the v2.39.0 release notes
References: <pull.1442.git.1670510887255.gitgitgadget@gmail.com>
Date:   Fri, 09 Dec 2022 11:02:04 +0900
In-Reply-To: <pull.1442.git.1670510887255.gitgitgadget@gmail.com> (Johannes
        Schindelin via GitGitGadget's message of "Thu, 08 Dec 2022 14:48:07
        +0000")
Message-ID: <xmqqwn711gir.fsf@gitster.g>
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/28.1 (gnu/linux)
MIME-Version: 1.0
Content-Type: text/plain
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

"Johannes Schindelin via GitGitGadget" <gitgitgadget@gmail.com>
writes:

> From: Johannes Schindelin <johannes.schindelin@gmx.de>
>
> Signed-off-by: Johannes Schindelin <johannes.schindelin@gmx.de>
> ---
>     Fix a couple of typos in the v2.39.0 release notes
>     
>     I cheated: I used VS Code's "Code Spell Checker" ;-)

Cheating is good.  Automation is good.  Thanks.

> diff --git a/Documentation/RelNotes/2.39.0.txt b/Documentation/RelNotes/2.39.0.txt
> index 3b8b0c010f9..1eb16534776 100644
> --- a/Documentation/RelNotes/2.39.0.txt
> +++ b/Documentation/RelNotes/2.39.0.txt
> @@ -194,7 +194,7 @@ Fixes since v2.38
>   * Force C locale while running tests around httpd to make sure we can
>     find expected error messages in the log.
>  
> - * Fix a logic in "mailinfo -b" that miscomputed the length of a
> + * Fix a logic in "mailinfo -b" that mis-computed the length of a

I'd scatch this, as we'd rather keep a spelling that we can even
find at https://m-w.com/dictionary/miscompute without the dash in
between.

> @@ -214,7 +214,7 @@ Fixes since v2.38
>   * Clarify that "the sentence after <area>: prefix does not begin with
>     a capital letter" rule applies only to the commit title.
>  
> - * "git branch --edit-description" on an unborh branch misleadingly
> + * "git branch --edit-description" on an unborn branch misleadingly

Thanks.  'h' and 'n' not just sit next to each other on my keyboard,
they look somewhat similar ;-)

> @@ -264,7 +264,7 @@ Fixes since v2.38
>  
>   * "git diff --stat" etc. were invented back when everything was ASCII
>     and strlen() was a way to measure the display width of a string;
> -   adjust them to compute the display width assuming UTF-8 pathnames.
> +   adjust them to compute the display width assuming UTF-8 path names.
>     (merge ce8529b2bb tb/diffstat-with-utf8-strwidth later to maint).

I dunno.  Even without trying to get accurate counts, we can see the
general trend of which one we prefer:

 $ git grep -e 'pathname' Documentation ':!Documentation/RelNotes' | wc -l
 124
 $ git grep -e 'path name' Documentation ':!Documentation/RelNotes' | wc -l
 28
	
In the above, RelNotes/ subhierarchy is excluded to avoid counting _my_
preference too much.

I didn't manage to find any authoritative reference, but the snippets
given on a query

https://letmegooglethat.com/?q=%22pathname%22%20vs%20%22path%20name%22

were fun.  I even saw some claims that "pathnames are sometimes
spelled as path names", which is pretty much in line with what I saw
in these snippets.

>   * "git branch --edit-description" can exit with status -1 which is
> @@ -289,7 +289,7 @@ Fixes since v2.38
>     option now implies --reapply-cherry-picks and --no-fork-point
>     options.
>  
> - * The way "git repack" creared temporary files when it received a
> + * The way "git repack" created temporary files when it received a

Thanks.  That's another good one.

