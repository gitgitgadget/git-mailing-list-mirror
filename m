Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-3.0 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_HI,T_DKIM_INVALID,
	T_RP_MATCHES_RCVD shortcircuit=no autolearn=no autolearn_force=no
	version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 6C5A51F406
	for <e@80x24.org>; Sun,  7 Jan 2018 00:44:39 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1750990AbeAGAoh (ORCPT <rfc822;e@80x24.org>);
        Sat, 6 Jan 2018 19:44:37 -0500
Received: from mail-qt0-f180.google.com ([209.85.216.180]:34466 "EHLO
        mail-qt0-f180.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1750739AbeAGAog (ORCPT <rfc822;git@vger.kernel.org>);
        Sat, 6 Jan 2018 19:44:36 -0500
Received: by mail-qt0-f180.google.com with SMTP id 33so9958999qtv.1
        for <git@vger.kernel.org>; Sat, 06 Jan 2018 16:44:36 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=mime-version:sender:in-reply-to:references:from:date:message-id
         :subject:to:cc;
        bh=wVz5KafDf5ULeseOfLfckXpY+zwAngVNk9BXG0pj4u0=;
        b=lhOJfJDHx/4h33EEsBW0N4U8oxTIrrrZkwaE25WyyK9M4bkePAb2RHAe+xtAq6SXLB
         OLOnwqwu28FOVQGf8bIgE+ts/VKggRUJNSbfsucgCjtYIrPHzHDujaWFzrECsCdyzOrH
         uL4OdAsusCFoPbPPSabldpUgehRO85P0FpucMvUQ48b9QqMBzPjRbwJKvfOQe+s32Tdc
         JLijKDz6BVCQ1ZCokvtvrIOp4zLzcNbrV1a50fpV/eD46o7KlD2ByY4RSMqDv0PisU5u
         B+KKiSCTRNp64j5OCg6gaEM7gWQuA1YMLD3tq4ICDnshDaTOSWGfRDWzSUHKgAsULmJU
         94gA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:sender:in-reply-to:references:from
         :date:message-id:subject:to:cc;
        bh=wVz5KafDf5ULeseOfLfckXpY+zwAngVNk9BXG0pj4u0=;
        b=AOfMx7+sOCm19UGWOKhPky7C+KnvFMehjisxkYwChG2JlLTbu3JACnd1UaBYiaFu1C
         yYru/ZvE1EXkuqjcwzNx2hVYvO4VaL6UJdazJfCoznSnpzCkIF+oOEwutTk6y8mKMImb
         Ofx/5e/vAQp4UIb3qk/8cSBJeOeKQlg9oD5WobuDyna+Ev6gYXvGo1PUIB6TjvbMMPLG
         gzuOvHAkt9nYnebHTdy3Co0vlZTpRgsAlduIpkhfXU22annvEPUhuKnr9azOfndUG9Sq
         19wU6XY6+WxxCmuaUx/byvCrIqx6P64f3W6FsFA7mL5xG9RhmdCnBovfIhP24oG7oQuK
         xUHg==
X-Gm-Message-State: AKwxytdWbwpOlOz0QST2vUsZEd78N4RsGtKO0ta05Ia4vURdsHbt+x4Q
        GtqRzvz8u+K0pVpa5CpRMzpexKoKw6BwdaBFzSg=
X-Google-Smtp-Source: ACJfBovlmUi1duY1q+Ja1p2/6uA1ITO4fMl/Vvd7DU9dyeRPqHZdcwf2Leo59u+GZEm8Jtrw6l/XI9XY0O6a4051nD8=
X-Received: by 10.237.38.71 with SMTP id z65mr10418100qtc.114.1515285875657;
 Sat, 06 Jan 2018 16:44:35 -0800 (PST)
MIME-Version: 1.0
Received: by 10.12.198.2 with HTTP; Sat, 6 Jan 2018 16:44:35 -0800 (PST)
In-Reply-To: <20180106184614.20115-7-kaartic.sivaraam@gmail.com>
References: <20180106184614.20115-1-kaartic.sivaraam@gmail.com> <20180106184614.20115-7-kaartic.sivaraam@gmail.com>
From:   Eric Sunshine <sunshine@sunshineco.com>
Date:   Sat, 6 Jan 2018 19:44:35 -0500
X-Google-Sender-Auth: -33YMFDEpHBBDz4vcA4wDdzxAqw
Message-ID: <CAPig+cSqq508-mTCpMW62DvE90a_vK7cOQ5xJD9Krj1BL3=d3Q@mail.gmail.com>
Subject: Re: [PATCH 6/8] Doc/gitsubmodules: improve readability of certain lines
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
> @@ -76,9 +76,10 @@ The configuration of submodules
> - * The command line for those commands that support taking submodule
> -   specifications. Most commands have a boolean flag '--recurse-submodules
> -   whether to recurse into submodules. Examples are `ls-files` or `checkout`.
> + * The command line arguments of those commands that support taking submodule
> +   specifications. Most commands have a boolean flag '--recurse-submodules'
> +   which specify whether they should recurse into submodules. Examples are
> +   `ls-files` or `checkout`.

So, this is addressing issues pointed out in my review of 4/8. It's
actually fixing a problem -- missing closing quote -- introduced by
4/8. Therefore, it probably would make sense either to move this hunk
into 4/8 or drop 4/8 altogether.
