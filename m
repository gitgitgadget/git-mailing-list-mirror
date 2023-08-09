Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 40D28C001B0
	for <git@archiver.kernel.org>; Wed,  9 Aug 2023 17:46:34 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230421AbjHIRqd (ORCPT <rfc822;git@archiver.kernel.org>);
        Wed, 9 Aug 2023 13:46:33 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:39074 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229456AbjHIRqc (ORCPT <rfc822;git@vger.kernel.org>);
        Wed, 9 Aug 2023 13:46:32 -0400
X-Greylist: delayed 2756 seconds by postgrey-1.37 at lindbergh.monkeyblade.net; Wed, 09 Aug 2023 10:46:32 PDT
Received: from mail.alien8.de (mail.alien8.de [65.109.113.108])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 6D36A10D2
        for <git@vger.kernel.org>; Wed,  9 Aug 2023 10:46:32 -0700 (PDT)
Received: from localhost (localhost.localdomain [127.0.0.1])
        by mail.alien8.de (SuperMail on ZX Spectrum 128k) with ESMTP id BCEC940E01A1;
        Wed,  9 Aug 2023 17:46:30 +0000 (UTC)
X-Virus-Scanned: Debian amavisd-new at mail.alien8.de
Authentication-Results: mail.alien8.de (amavisd-new); dkim=pass (4096-bit key)
        header.d=alien8.de
Received: from mail.alien8.de ([127.0.0.1])
        by localhost (mail.alien8.de [127.0.0.1]) (amavisd-new, port 10026)
        with ESMTP id FRrPlzG77H91; Wed,  9 Aug 2023 17:46:29 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=alien8.de; s=alien8;
        t=1691603188; bh=jG+Bb+F3auJcmc9aGuFfJaL+Wt7paT58GNAYM5Jrils=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=jxzxnx+93uvb7U13lwBcrpzPtfDBRnFvFxUAPdY1pDaBkB6SppPzPiOtozzxGD2Mv
         0MbELirazh5w+wPs/FDZCmfK6sxBcTSzJUcP8U1Fgc2JgCDE+is39k8acDiGjA58PU
         sgwNLoBFZqubLIamtq7LMK4PZjBrCz4Xo65vElNSWzR4vxC3fhDVRXX1caTosE3URA
         G5kdODlyPolgAoohQDP2LHh8hGGD2H4iRyrdOyh6cbQax0h3+S6kh9UxuNTN+XDAWk
         nkXDeKBDXDqxX1VVioFqyZofmYJm/mj4bIfAmrCPC7b5a2Dv40J+yV5v03b4cEcSRM
         cDz86aRYvJBicamjCq77CZSbXdBZQ/uSJeHDTLEJDdU11AN94PrwowXQCPIOMap093
         p4Dr8PabP1oNVCSlpOS4KFvCz2u2U6HIIzkSDjK/Kw9gNRjuWPkxVJbfOYzrSWkkua
         WMLDUX1LT2hQ0AYwvGYFl9FeBSN6M6RQL7ouX13vLbo1YKT2qlBPT10go95YSqxoMW
         YuKFKCVYr3v+qb4zhJ4VL0ujbQrZktQ/to/A0xW0CKAiuvD2k9uB4e5mExqpSLF7k2
         pd6ZGYGlZUqYeAyB1lGgNt4wRfz9I0QwPR57E/eJ1EAG+uaEWwxNcaG8RkDecHjxI0
         72TyowksST6YS75BOMb9aEQc=
Received: from zn.tnic (pd9530d32.dip0.t-ipconnect.de [217.83.13.50])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange ECDHE (P-256) server-signature ECDSA (P-256) server-digest SHA256)
        (No client certificate requested)
        by mail.alien8.de (SuperMail on ZX Spectrum 128k) with ESMTPSA id C035340E0195;
        Wed,  9 Aug 2023 17:46:26 +0000 (UTC)
Date:   Wed, 9 Aug 2023 19:46:21 +0200
From:   Borislav Petkov <bp@alien8.de>
To:     Jacob Keller <jacob.keller@gmail.com>
Cc:     git@vger.kernel.org
Subject: Re: git send-email -v
Message-ID: <20230809174621.GNZNPQ7VGaAbC9V+mu@fat_crate.local>
References: <20230809170028.GKZNPGLM93GYB+7Ej9@fat_crate.local>
 <CA+P7+xrGBNO-JNfHvbVUV9AgY_Q8PgYSr5EVycGzC5+ZB7Cv3A@mail.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <CA+P7+xrGBNO-JNfHvbVUV9AgY_Q8PgYSr5EVycGzC5+ZB7Cv3A@mail.gmail.com>
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

On Wed, Aug 09, 2023 at 10:42:54AM -0700, Jacob Keller wrote:
> -v is a valid option to git format-patch:
> 
>       -v <n>, --reroll-count=<n>
>            Mark the series as the <n>-th iteration of the topic. The
> output filenames have v<n> prepended to them, and the subject prefix
> ("PATCH" by
>            default, but configurable via the --subject-prefix option)
> has ` v<n>` appended to it. E.g.  --reroll-count=4 may produce
>            v4-0001-add-makefile.patch file that has "Subject: [PATCH
> v4 1/20] Add makefile" in it.  <n> does not have to be an integer
> (e.g.
>            "--reroll-count=4.4", or "--reroll-count=4rev2" are
> allowed), but the downside of using such a reroll-count is that the
> range-diff/interdiff with
>            the previous version does not state exactly which version
> the new interation is compared against.
> 
> it takes a required argument, and inserts "v<argument>" into the
> [PATCH] block to describe the version.

Aaaah.

> Typically the argument should be a number, but you happened to provide
> it "--dry-run". Presumably assuming that the -v means "verbose" as it
> might in most other applications.

Yap.

> In short: this is working as intended, but it is somewhat confusing
> that it doesn't validate the argument at all. It is intentional to
> allow non-numeric strings, but maybe we ought to validate that it
> doesn't start with -- to avoid such confusion here.

Yes, the non-intuitiveness is kinda confusing.

> In short: -v doesn't mean verbose, it is a valid option, and while its
> a bit non-intuitive in this case, I think it is working as designed
> now.

Thanks for explaining!

:-)

-- 
Regards/Gruss,
    Boris.

https://people.kernel.org/tglx/notes-about-netiquette
