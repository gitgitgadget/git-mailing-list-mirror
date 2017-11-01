Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-2.8 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_HI,RCVD_IN_SORBS_SPAM,
	RP_MATCHES_RCVD shortcircuit=no autolearn=no autolearn_force=no version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id CA3DE202A0
	for <e@80x24.org>; Wed,  1 Nov 2017 19:54:57 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S933155AbdKATyz (ORCPT <rfc822;e@80x24.org>);
        Wed, 1 Nov 2017 15:54:55 -0400
Received: from mail-wm0-f45.google.com ([74.125.82.45]:55304 "EHLO
        mail-wm0-f45.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S933035AbdKATyz (ORCPT <rfc822;git@vger.kernel.org>);
        Wed, 1 Nov 2017 15:54:55 -0400
Received: by mail-wm0-f45.google.com with SMTP id y83so6956150wmc.4
        for <git@vger.kernel.org>; Wed, 01 Nov 2017 12:54:54 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=mime-version:in-reply-to:references:from:date:message-id:subject:to
         :cc;
        bh=lWEAFGb1Z4O+ZP82IM77OQ3RXRx7jx+Ltas3z9b0Gb0=;
        b=EQmFsqCFGTOZ/fGVdpIjfLAnUqVhMOFt85yqmAGYHKDwm3kRhHnHdDWfJDHpm75Ovr
         NZGPk3SgwKOm1x+rUZ62cbE8ne47uJDWGjZjdxhazxGjHqsqr4HTJS+Y0SL6Dv5WzHzl
         bJKDAvOPxDhnsyLjk6oOwrSNuHIKJXEPpPW8cXuOI29HbdiZ/Lm8kTDfSLIZIi1cwuY+
         k820g6Ax5D/EBhCc/YuHATEzN0aNIBRRZ1oyzrNWS4GEapaAhwJZG1Ss5vb9HsqyuRox
         drLwCsrcLZzmZA/r0tkn9G77Zalto+83zaLr+wIdBLBncbLyNsLEoW0v4ANF+QcatyCT
         jK4g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:in-reply-to:references:from:date
         :message-id:subject:to:cc;
        bh=lWEAFGb1Z4O+ZP82IM77OQ3RXRx7jx+Ltas3z9b0Gb0=;
        b=kBwyYeqWAz7wTCncOHTFDkoU3DRPDt1Mv6sV/lpG3qESgWHVoJJTxJ++pC8MlI1EvK
         YktmJ8l/ckggPBe/w+hcIBwdPS5HNh8531L/5mKPEnf2cBObRbpRbr0HvZnCeFHzd4dY
         kyS0m7uWaRyZX6CUHu4gKYuaPNswi7+auT0KVO3DaPaMKgU6B57p/uTpiBFBn0vCPOIo
         C2JwDIKSN9YbJZAUu9BkL22wmPFqJQRkDs3b63w26keuoH86eUtWcbSEbwX7GKnxxhjC
         m0ebFhbIoYS3BvjScRL+ABDVLcbAidBj6VaLwQVBLTox0Jd6UaUTJYZI3hrAhobkzp6N
         toWQ==
X-Gm-Message-State: AMCzsaVDouqDguXErjPraLf1WTnZqbc5H/0U3XHepktD2MLMe2M9ZdEM
        xhereFVYx1dm/5tloqXstSOkLOY4Qb+dKRB+tzo=
X-Google-Smtp-Source: ABhQp+QxfPLh14g4ItT2Nc5flIse6+ygB49oOgzyjIYK/3jedQO7zQJfY879TEspt8dYy488I6W+ZjyMuggw5YmBtMU=
X-Received: by 10.28.28.201 with SMTP id c192mr1147516wmc.71.1509566093997;
 Wed, 01 Nov 2017 12:54:53 -0700 (PDT)
MIME-Version: 1.0
Received: by 10.28.15.194 with HTTP; Wed, 1 Nov 2017 12:54:53 -0700 (PDT)
In-Reply-To: <20171101185026.d4ljyywz3fepgoth@sigill.intra.peff.net>
References: <otc9a3$h9a$1@blaine.gmane.org> <20171101185026.d4ljyywz3fepgoth@sigill.intra.peff.net>
From:   Sebastian Schuberth <sschuberth@gmail.com>
Date:   Wed, 1 Nov 2017 20:54:53 +0100
Message-ID: <CAHGBnuPspJ6xsZ9dymet2Woku3PkD9fCHy2qMj7cLACCF3UXLQ@mail.gmail.com>
Subject: Re: Colorize matches for git log --grep=pattern?
To:     Jeff King <peff@peff.net>
Cc:     Git Mailing List <git@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

On Wed, Nov 1, 2017 at 7:50 PM, Jeff King <peff@peff.net> wrote:

> The best workaround I could come up with is passing the output through a
> highlighting script:
>
>   git log --grep=foo --color |
>   perl -pe 's/foo/\x1b[1;31m$&\x1b[m/' |
>   less
>
> Pretty hacky.

Thanks anyway. I was also considering something like this, but
likewise found it to be too hacky.

-- 
Sebastian Schuberth
