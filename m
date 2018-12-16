Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.2 (2018-09-13) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-3.9 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,RCVD_IN_DNSWL_HI
	shortcircuit=no autolearn=ham autolearn_force=no version=3.4.2
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 013361F405
	for <e@80x24.org>; Sun, 16 Dec 2018 14:34:56 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1730530AbeLPOey (ORCPT <rfc822;e@80x24.org>);
        Sun, 16 Dec 2018 09:34:54 -0500
Received: from mail-pg1-f193.google.com ([209.85.215.193]:35029 "EHLO
        mail-pg1-f193.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1729822AbeLPOey (ORCPT <rfc822;git@vger.kernel.org>);
        Sun, 16 Dec 2018 09:34:54 -0500
Received: by mail-pg1-f193.google.com with SMTP id s198so4877786pgs.2
        for <git@vger.kernel.org>; Sun, 16 Dec 2018 06:34:54 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc:content-transfer-encoding;
        bh=YuZcQAja/rO1UNwwKJFzUrugSNKJIl8JqIpj378D0jA=;
        b=jJq44jKaM53scLPCkraNLv7y+TIng0eCKt2OHkWwWf0/qymbjK9+w7ySCEqpNhEAEf
         alxN/9C62i0VirI4fwALqWzSL2fZwuIsVrdUP0Jwr1haiR3qNCO2ZGlpZpQ+KMx/OckQ
         0a8e8+R1/lx9o98mgfo3t0SlsBY+BGvT25NyrUy0gb7PKsdWNfEyNW6sqcwHJUphGKg5
         lvNdyso9K5ahYL8KDSiJvr8QLzBiKJLbQAAnZg7ZC8r9q4zQrRrRh0MlrXUS1P9PI6Se
         DARvvlsms8TsWDywIuyPHK3bmu5yge1Hp1k9aZpmXAvTCimrA8KIcLEfMeaLCPZAeC+d
         2iOA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc:content-transfer-encoding;
        bh=YuZcQAja/rO1UNwwKJFzUrugSNKJIl8JqIpj378D0jA=;
        b=lH56r2tjslnSHrGQ0f78PgcM9mhfHpS8jHVgmAEWXvh3uKFrvK8sr1ekeRmAGvJXLU
         q7/oGYRbtkhrb+tU3Sn8Z9pKHTcXIl+2ngw4kRs1zNxbYZa3gHd8zx1YPBS6ILKs+vw8
         uL08nT6p4n1QOdYfEpoTWbdtRj7iMO8OHrUimOl2n4+VVq6VjB0Hc3t6RVchVq2KPFmp
         xaYUtOGisMGfnSBqWULE6LGXDv1JWsm7K9ErU8yvYRQTHiyaRqYTqz+/nI3EgP/eofRR
         vKd6ELCZcy+eLZm/AOeEYD0BKPO2X4v8oMm6/g844RcMPpcPy/MK2ngQDFASBQ7CbDZh
         eTfg==
X-Gm-Message-State: AA+aEWZe7h7MnQR9mETU4oZH+ZtOtcIoSZsPnjfcv7HbyumzDyeVYTBm
        OYONNHO0gtC1oVCEQ1OZD0juQEE2hPWu2XK/KBs1LUeR
X-Google-Smtp-Source: AFSGD/Wi3aAdZskuJ5v2UjamSszn6hElqUHOw3mhTHoQZGC9oxp5BFZQoZ0cNL/ZSH4jJkWr3Ga1ONOjTUAzGjovgfk=
X-Received: by 2002:a63:1c09:: with SMTP id c9mr9026296pgc.200.1544970893857;
 Sun, 16 Dec 2018 06:34:53 -0800 (PST)
MIME-Version: 1.0
References: <20181215112742.1475882-1-martin.agren@gmail.com> <20181216104458.GC13704@sigill.intra.peff.net>
In-Reply-To: <20181216104458.GC13704@sigill.intra.peff.net>
From:   =?UTF-8?Q?Martin_=C3=85gren?= <martin.agren@gmail.com>
Date:   Sun, 16 Dec 2018 15:34:42 +0100
Message-ID: <CAN0heSrccWop+KRKFCTNHTB43XcAv+Q8X7p0hT1t2+rPjS1THA@mail.gmail.com>
Subject: Re: [PATCH 0/4] A few Asciidoctor-fixes
To:     Jeff King <peff@peff.net>
Cc:     Git Mailing List <git@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

On Sun, 16 Dec 2018 at 11:45, Jeff King <peff@peff.net> wrote:
>
> On Sat, Dec 15, 2018 at 12:27:38PM +0100, Martin =C3=85gren wrote:
> I think the relevant bits from [1] are:
>
>  * Use `make --always-make ... install-man` in doc-diff.
>  * ./doc-diff -f HEAD HEAD # note -f
>  * Add empty commit and tweak config.mak
>  * ./doc-diff HEAD^ HEAD # note no -f

Yes, that's it.

> To make this easier, it would make sense to me to:
>
>   - teach doc-diff a flag for marking one or both of the endpoints to be
>     built with asciidoctor versus asciidoc
>
>   - mark the asciidoc/asciidoctor in the directory name. That name
>     serves as a cache key for avoiding re-doing the work, you should be
>     able to just:
>
>       ./doc-diff --asciidoctor HEAD HEAD
>
>     and actually build and compare what you want.
>
>   - it sounds from "make --always-make" that our Makefile does not
>     properly rebuild when we switch from asciidoc to asciidoctor. That

Exactly.

>     might be nice to fix with a mechanism similar to the GIT-BUILD-FLAGS
>     we use in the top-level Makefile.

Agreed on all three points. The last one would supposedly be useful on
its own, beyond this doc-diff motivation.

Your list seems complete to me in terms of "how could we teach doc-diff
to diff asciidoctor vs asciidoc?". For the resulting diff to actually be
useful ;-) there are two more outstanding issues that I see:

  - Headers and footers. Asciidoc (driven by doc-diff) uses some
    boilerplate values which avoid timestamps and the like. Asciidoctor
    partly uses different values, partly interprets the ones given
    differently.

  - Asciidoctor introduces a space after linkgit:foo , e.g., before
    punctuation.

Both of these are problems in their own right, so they probably
shouldn't be suppressed in the resulting diff. But as long as these
issues remain, they produce a lot of noise which might hide more
interesting (IMHO) differences.

Martin
