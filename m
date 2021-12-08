Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id A0178C433EF
	for <git@archiver.kernel.org>; Wed,  8 Dec 2021 18:06:07 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S238555AbhLHSJg (ORCPT <rfc822;git@archiver.kernel.org>);
        Wed, 8 Dec 2021 13:09:36 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:36496 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232619AbhLHSJc (ORCPT <rfc822;git@vger.kernel.org>);
        Wed, 8 Dec 2021 13:09:32 -0500
Received: from mail-ed1-x531.google.com (mail-ed1-x531.google.com [IPv6:2a00:1450:4864:20::531])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 51F0BC061746
        for <git@vger.kernel.org>; Wed,  8 Dec 2021 10:06:00 -0800 (PST)
Received: by mail-ed1-x531.google.com with SMTP id r11so10920036edd.9
        for <git@vger.kernel.org>; Wed, 08 Dec 2021 10:06:00 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=w/xU6guEd+JcvcQ1UodxeX6DBlNOJvUXv6KGOuUML9M=;
        b=IsAXsC4In9QyPgNO6SqxzHpGirZiXgMsCGYJC5SvguL6xwRdSGarpqu0+S4avFKTDt
         dFUu49SjW69EnL92GgHNI+SEomT+YRJhL4bpviGKbT41BDRHErQppFNieTaRhjIzAmmb
         3x6iYP1L86OJWy28yPzwrtKNqdz63pIdh3gyfLnFQkSbGzGLUcNjQ2SWRbbGD3tXI6z8
         j/2bVWtMR523OiJqnMYxQapkU9HxEG/HTGZPuFwwduatzgZagjY1Sn5P/FrSy4GPjpJQ
         rwOeEz5ClUIIjKmbPXBQowHLZ5It8Wtoa6zQr/84k7GVo/jUN0LjDtP6oFsACFkPTJUG
         igiA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=w/xU6guEd+JcvcQ1UodxeX6DBlNOJvUXv6KGOuUML9M=;
        b=XKpExwMdWaofrPMvxikmHYHRv4lS5RKxYrsr/IuHqptLEOaG/FUr6AC1R9r/sR9bJu
         kCLzwZG3K2Cw85RpCI0eFKQ/1pdaml/B5xj8OWPfJSOKyuePycCV27SCAy2+MASzPqYq
         dHnbcyVHSBryAQFqDenf9o9ETKqQ1mSaWYLIpT5SMgZTrWWUXxZbLP6aaaIZ51MjkQ0J
         ZtKRRus+8N58VJ2E1DdnkVppDdEHXRscQctBLWkhgQFlOvpv/SYYXmru84PipMMx6XTD
         qdJU5pPo/9eR/Xj2vXFnwNkDTrqklp+iw2CMVcgrTUhVFgCxN2o3659+26yb9jVxeZlN
         VkcA==
X-Gm-Message-State: AOAM532sumWMVWDprjE1GJo/txKOkrF0wAia4P0Lqfy1F/AllJeLrM1g
        JCrfTLVsvIXOxZoySvmlS+Arw30qIQMxgl/Xn7W2ox/GTQk=
X-Google-Smtp-Source: ABdhPJwb5LfxePf5gYZbc5QOPwNOezoTLRv43TsWzb3B22g4vI8tBqe++ZIVZsLS3YrNPAeAf0F0AZBzym5t8614PIw=
X-Received: by 2002:a17:907:75d3:: with SMTP id jl19mr9371148ejc.520.1638986758827;
 Wed, 08 Dec 2021 10:05:58 -0800 (PST)
MIME-Version: 1.0
References: <xmqq8rwv6e0a.fsf@gitster.g>
In-Reply-To: <xmqq8rwv6e0a.fsf@gitster.g>
From:   Elijah Newren <newren@gmail.com>
Date:   Wed, 8 Dec 2021 10:05:47 -0800
Message-ID: <CABPp-BEd-CLaAJvLpcE=zSinz1up17zh+iUrG--4AXUe765BBA@mail.gmail.com>
Subject: Re: What's cooking in git.git (Dec 2021, #02; Tue, 7)
To:     Junio C Hamano <gitster@pobox.com>
Cc:     Git Mailing List <git@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

On Wed, Dec 8, 2021 at 1:28 AM Junio C Hamano <gitster@pobox.com> wrote:
>
> Needs an Ack or Reviewed-by.
>  - ns/tmp-objdir                                                12-06          #2

Provided: https://lore.kernel.org/git/CABPp-BEJbS=5i+d-Aa_fCH-WAjSOhX+nSZk5Q9Kb6RiizFg7ZQ@mail.gmail.com/

> Will merge to 'next'?
>  - ld/sparse-diff-blame                                         12-06          #8

I'm in favor.

>  - js/scalar                                                    12-04         #15

Yes, please.  I think everyone agrees there are additional things
wanted, but the current patch series is good (and is already on the
longer side), and it was always designed as the initial submission
with 4-5 additional series coming.  Those additional things can come
in one of the future series.

>  - en/name-rev-shorter-output                                   12-04          #1

Dscho spoke up in favor of merging down
(https://lore.kernel.org/git/nycvar.QRO.7.76.6.2112081237310.90@tvgsbejvaqbjf.bet/),
and you did too 3 weeks ago when you commented,

"""
In any case, this seems to give us a much better results than the
current code, so let's take it and leave further futzing outside the
scope.
"""
(from https://lore.kernel.org/git/xmqq35nv416j.fsf@gitster.g/)

I haven't changed the code since this comment of yours, just added
some additional pointers in the commit message for future readers who
want to tackle that "further futzing".  :-)
