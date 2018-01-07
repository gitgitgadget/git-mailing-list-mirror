Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-3.0 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_HI,T_DKIM_INVALID,
	T_RP_MATCHES_RCVD shortcircuit=no autolearn=no autolearn_force=no
	version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 594711F406
	for <e@80x24.org>; Sun,  7 Jan 2018 00:36:31 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1753202AbeAGAg3 (ORCPT <rfc822;e@80x24.org>);
        Sat, 6 Jan 2018 19:36:29 -0500
Received: from mail-qt0-f175.google.com ([209.85.216.175]:35223 "EHLO
        mail-qt0-f175.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1752760AbeAGAg2 (ORCPT <rfc822;git@vger.kernel.org>);
        Sat, 6 Jan 2018 19:36:28 -0500
Received: by mail-qt0-f175.google.com with SMTP id u10so9937163qtg.2
        for <git@vger.kernel.org>; Sat, 06 Jan 2018 16:36:28 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=mime-version:sender:in-reply-to:references:from:date:message-id
         :subject:to:cc;
        bh=hUaLLgzY9pzGeMHRiZfjGyvg3BrKtfU9Czt+dR9mcto=;
        b=bkSSzugm7TDOqB8XPz8r5+WEJQtxbTk18X2+2RUl0kLZJ7EEHoqJE+3Tp37QSWE6bS
         XF5fX4vMe5M20nRJCieBh+yVW3R2LRw9wWcNH+EFzjfcZNzM8T7+VxnUwnHlWuzB2dYB
         7StDOy/g0Ez6JG5Ti2pURnBPHCRFjbvVO4sfI1v/QBcvBYXSLaHGxUhGl2Eu9wNA+91x
         iZ72GZNftG1/LkCi2e0WBcDKx0XNmP0rms4Y5QKiArZpGxqTW6hxKkJi1og7b/D8e3ec
         pJ9lB2IbvSV/3Z8lz5k5Gyiw25Do9bQiMydQT16HSkzMrztOLCk8xYcIZoC9c2cdKsk5
         a6/Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:sender:in-reply-to:references:from
         :date:message-id:subject:to:cc;
        bh=hUaLLgzY9pzGeMHRiZfjGyvg3BrKtfU9Czt+dR9mcto=;
        b=D9DWEtIkR2ebZCwdHAJAA8a1O+gkKqBPuTBmhL5qPd2tS/iDKFqwS0fTCtXl+aet6W
         pTrkTPn30QjVvLzmAsK+eZ2vJpzS03VGzSo0OAPkX3xUueUk366jZXwgarjWJKSSowU7
         TUx3wbpjGMJtfuHVAWM93r2LFIBWU/VQeY5iqDl71KIcrolhpHAkLUY6i2b/Wns0dtLi
         28wb6gI7UWPLlatHnxkJtAwmQ73papnmgD1qHkfmYJkhJ8HcYHeFAj6urAANJ36PiWFM
         d/nKgkT9pGBoV/gTMTeov7TFDkR3JU//qFtOHDx5dknkSUwTn4w+44YzGO4/nLInN9DJ
         JXpg==
X-Gm-Message-State: AKwxytcfy6QPzU2FqfW/aUJYTqGQuhomc1Yt3zHdhLcLtl81vqfh0bMf
        Cka76aqdHRiotWprnMUvOyPtM0LSqWel3yrfGps=
X-Google-Smtp-Source: ACJfBougA6ZMj6FCp5yRfiXhmzTb/rzWP+yzqRqz8IvSKq0kpvtGgwZPfhvwbgF7Q8ka3q0gngkKFCxJdwpeePCXync=
X-Received: by 10.200.44.248 with SMTP id 53mr11000350qtx.55.1515285387853;
 Sat, 06 Jan 2018 16:36:27 -0800 (PST)
MIME-Version: 1.0
Received: by 10.12.198.2 with HTTP; Sat, 6 Jan 2018 16:36:27 -0800 (PST)
In-Reply-To: <20180106184614.20115-5-kaartic.sivaraam@gmail.com>
References: <20180106184614.20115-1-kaartic.sivaraam@gmail.com> <20180106184614.20115-5-kaartic.sivaraam@gmail.com>
From:   Eric Sunshine <sunshine@sunshineco.com>
Date:   Sat, 6 Jan 2018 19:36:27 -0500
X-Google-Sender-Auth: ZrlA29j8cxkYHvKW-_P9ZiTo0mk
Message-ID: <CAPig+cS2PAGm1OfQLOv+MOOvbUnFOUtfzXLOFfVNAD_VOhfntQ@mail.gmail.com>
Subject: Re: [PATCH 4/8] Doc/gitsubmodules: avoid abbreviations
To:     Kaartic Sivaraam <kaartic.sivaraam@gmail.com>
Cc:     Git mailing list <git@vger.kernel.org>,
        Stefan Beller <sbeller@google.com>
Content-Type: text/plain; charset="UTF-8"
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

On Sat, Jan 6, 2018 at 1:46 PM, Kaartic Sivaraam
<kaartic.sivaraam@gmail.com> wrote:
> Signed-off-by: Kaartic Sivaraam <kaartic.sivaraam@gmail.com>
> ---
> diff --git a/Documentation/gitsubmodules.txt b/Documentation/gitsubmodules.txt
> @@ -76,9 +76,9 @@ The configuration of submodules
> - * The command line for those commands that support taking submodule specs.
> -   Most commands have a boolean flag '--recurse-submodules' whether to
> -   recurse into submodules. Examples are `ls-files` or `checkout`.
> + * The command line for those commands that support taking submodule
> +   specifications. Most commands have a boolean flag '--recurse-submodules
> +   whether to recurse into submodules. Examples are `ls-files` or `checkout`.

Your change loses the closing quote on --recurse-submodules.

Also, since you're touching this, it wouldn't hurt to address the
grammatical shortcoming(s), as well. To wit: Something is missing
between "--recurse-submodules" and "whether".
