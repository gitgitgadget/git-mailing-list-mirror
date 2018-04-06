Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-2.8 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_HI,T_RP_MATCHES_RCVD
	shortcircuit=no autolearn=no autolearn_force=no version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 8766D1F404
	for <e@80x24.org>; Fri,  6 Apr 2018 05:40:36 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1751447AbeDFFke (ORCPT <rfc822;e@80x24.org>);
        Fri, 6 Apr 2018 01:40:34 -0400
Received: from mail-wm0-f65.google.com ([74.125.82.65]:35446 "EHLO
        mail-wm0-f65.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1750749AbeDFFkd (ORCPT <rfc822;git@vger.kernel.org>);
        Fri, 6 Apr 2018 01:40:33 -0400
Received: by mail-wm0-f65.google.com with SMTP id r82so511504wme.0
        for <git@vger.kernel.org>; Thu, 05 Apr 2018 22:40:33 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=mime-version:in-reply-to:references:from:date:message-id:subject:to
         :cc;
        bh=hFTnQ39HiTOKoz7NzE/nOalvd9G4/xhGaqct8sX7QVs=;
        b=ZWDuPHwBF94jyNcjxsTYdSf/aLTvfiqjYWAxYmtlPl9ryTNICnwKvKMlHKrgbun433
         D5I02b89KwRqmdvEeSNQaCvMGcdzetvSj5FSFoJrSGyFx+gZFaakg8REt+6+sWkc+375
         AKOuGHjhREnKdUFly4DVlwtQ0VlaqWv+xg8hQBySO6s38Yar7889rpgyyNFHXcgMzbNR
         P5H75AR+kmZpU9fPQX/dCnWzohOjIFTc2UYarBzPqFmF/2dENwF4TZsr6eEKzQ7yBJJq
         J2L5gEEFhsB+Em8oVjLOssD5SEZ+Cu2/b0aothmjk0koBWrWWmAxfC9DT9YkAjDUvPGX
         5cXg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:in-reply-to:references:from:date
         :message-id:subject:to:cc;
        bh=hFTnQ39HiTOKoz7NzE/nOalvd9G4/xhGaqct8sX7QVs=;
        b=DeXPVjMGtNolIMnxEIUYMRxEkvJJYQ3qXkH8d21+KAKTXGj9/TDBHf8vrM+kUHkXUK
         Q25BPA4XWGUvi2IAl0e6hztj2nd+zT7qZ9MxxLp9UOhIKeTvvyR/JY0QX2VduYrpDoTe
         8rC6/zrVr7xKZCJ8JKxEbrvoFSt3HI3Pu6Wd63DAF3PH2NDkS8sGp1NQL4gfvOww4agr
         XnMsWlAHT6jnUN/72Uu/odhTojD2g0E2xyElmC8/0rf+RaGoFCj/S/lywiy1YskIn4As
         eLjEes53S2SPwPyaiqghZCXv4P/jQ6Lwmd//45Y4BEhffVfL0UlDfqohg/IK99vSMvse
         si5Q==
X-Gm-Message-State: ALQs6tBItSMD6ZP6am8MBlZskRG8qE9IY38KOo7D1YRL+dXC+ubJAyi6
        Audt7DwMF/jo01IUwdyF2ZbS+869qkwtZuLT7A6jmQ==
X-Google-Smtp-Source: AIpwx4+umBXohDq3Z7jGeelRypH5XpSO5Ju1fL857zy3TFYMw/T89z6WoKKpduJ0BwNrbOz9sk4RSzWFHT3c3Vyfl4w=
X-Received: by 10.80.153.9 with SMTP id k9mr5440456edb.303.1522993232543; Thu,
 05 Apr 2018 22:40:32 -0700 (PDT)
MIME-Version: 1.0
Received: by 10.80.201.196 with HTTP; Thu, 5 Apr 2018 22:40:12 -0700 (PDT)
In-Reply-To: <20180406052724.GA60769@syl.local>
References: <20180329011634.68582-1-me@ttaylorr.com> <20180406052724.GA60769@syl.local>
From:   Jacob Keller <jacob.keller@gmail.com>
Date:   Thu, 5 Apr 2018 22:40:12 -0700
Message-ID: <CA+P7+xpjsmuuDBBgUDswBkMbUONEmPh8Nd4hnu5j52hYyhTjmw@mail.gmail.com>
Subject: Re: [PATCH v5 0/2] *** SUBJECT HERE ***
To:     Taylor Blau <me@ttaylorr.com>
Cc:     Git mailing list <git@vger.kernel.org>,
        Junio C Hamano <gitster@pobox.com>,
        Jeff King <peff@peff.net>,
        Eric Sunshine <sunshine@sunshineco.com>
Content-Type: text/plain; charset="UTF-8"
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

On Thu, Apr 5, 2018 at 10:27 PM, Taylor Blau <me@ttaylorr.com> wrote:
> *** BLURB HERE ***
>

Missing subject and cover letter stuff.. did you submit before you
were ready? or did you not mean to include the cover letter? :)

-Jake

> Taylor Blau (2):
>   builtin/config.c: treat type specifiers singularly
>   builtin/config.c: prefer `--type=bool` over `--bool`, etc.
>
>  Documentation/git-config.txt | 74 +++++++++++++++++++---------------
>  builtin/config.c             | 77 +++++++++++++++++++++++-------------
>  t/t1300-repo-config.sh       | 29 ++++++++++++++
>  3 files changed, 121 insertions(+), 59 deletions(-)
>
> --
> 2.17.0
