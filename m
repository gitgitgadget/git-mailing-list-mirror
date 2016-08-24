Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-3.5 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_HI,RP_MATCHES_RCVD
	shortcircuit=no autolearn=ham autolearn_force=no version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 6DD6A1F6C1
	for <e@80x24.org>; Wed, 24 Aug 2016 18:28:26 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1755191AbcHXS2C (ORCPT <rfc822;e@80x24.org>);
        Wed, 24 Aug 2016 14:28:02 -0400
Received: from mail-wm0-f68.google.com ([74.125.82.68]:35040 "EHLO
        mail-wm0-f68.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1753270AbcHXS2C (ORCPT <rfc822;git@vger.kernel.org>);
        Wed, 24 Aug 2016 14:28:02 -0400
Received: by mail-wm0-f68.google.com with SMTP id i5so3745700wmg.2
        for <git@vger.kernel.org>; Wed, 24 Aug 2016 11:27:07 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20120113;
        h=mime-version:in-reply-to:references:from:date:message-id:subject:to
         :cc:content-transfer-encoding;
        bh=0voyjMUkLAA2cgU0PC3hKfSY7v084YGQ4FXMRgHpyE4=;
        b=goAHFrdKBV0u8Wqrmjg700uXJv7M7aRYNY05ZwsIJM+KZr5l39ITkZQKgIs7mxrhPC
         ClFGpCn6wC42Xjea5APVCeWKR2qt16lIk8ZVNVNyXJS7BnJjrqT9rOCUX1Q8nClsg5a5
         7r85GflI3huDleBPQB7Z75unDk2aKcL/iu2djyVrg7HEsYDUnYSa0fMcKLjgaFa8gDYJ
         P2fOnxFVSTWM8Pozgcai8X/BNbziYbvuZpF8YfsMiBNZnrW/wWnFbojo3DDGKpUv+Hkr
         W1ERH+J4suGODDdExrnAakDSnRJVhcCpcHny+y7syBTU5MVvMVTH6DtUuhkVTPpCb7bq
         JOzQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20130820;
        h=x-gm-message-state:mime-version:in-reply-to:references:from:date
         :message-id:subject:to:cc:content-transfer-encoding;
        bh=0voyjMUkLAA2cgU0PC3hKfSY7v084YGQ4FXMRgHpyE4=;
        b=iWxPO9AwKAsqtQGlux4ZrWm2Uhf1rE+y4CNfJk6Pz5wcDec7UHb2b84OJcR/dw5Roq
         LHBZUJJ8mo7vDJRhmgYSNKsFXhgl2UQ8CK5ylLwvI1A+YwZPIH9EBCtWKhGlI3nGf9jT
         E3oPsV0ERXbIIr2Kxw4S0pJPWw92eh/TMHFnE1lH7OlA/Uah25CR2QBQnL8ZwzehVeQJ
         Gbi5O/qngP8WYoHkyPtUZ9Quiuh3/RXiSD5g1YjVPkiuASW5KmPdI0BEjNzr2swlUYnq
         N0HnQs3ilM9inbW59moo4ER3DGwMydeYvgb+qsXCMIqtTjM6lhwlJugVCPFOZ/2aHr0T
         SRfA==
X-Gm-Message-State: AE9vXwM1mVXMdv7ckbKOhEhCxbFh1VzYXtaei4OfF1RkYSzLcyBinumANZ4xvsP+l71wYcpNnLzLc4ySt5gOLA==
X-Received: by 10.28.43.129 with SMTP id r123mr4209404wmr.1.1472063226948;
 Wed, 24 Aug 2016 11:27:06 -0700 (PDT)
MIME-Version: 1.0
Received: by 10.28.86.67 with HTTP; Wed, 24 Aug 2016 11:26:26 -0700 (PDT)
In-Reply-To: <20160824180730.mqlvhkthg4imd2vy@sigill.intra.peff.net>
References: <20160822173528.755-1-oystwa@gmail.com> <20160824180730.mqlvhkthg4imd2vy@sigill.intra.peff.net>
From:   =?UTF-8?Q?=C3=98ystein_Walle?= <oystwa@gmail.com>
Date:   Wed, 24 Aug 2016 20:26:26 +0200
Message-ID: <CAFaJEqvm9Xj34t+F=KMtwRDEYhwHZ7=MRwsZ22-Gt_UPd4r72A@mail.gmail.com>
Subject: Re: [PATCH v2] for-each-ref: add %(upstream:gone) to mark missing refs
To:     Jeff King <peff@peff.net>
Cc:     git@vger.kernel.org
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: quoted-printable
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Hi, Peff

On 24 August 2016 at 20:07, Jeff King <peff@peff.net> wrote
>
> Whoops, your v2 spurred me to review, but I accidentally read and
> responded to v1.
>

Thanks for the review! I was worried this patch had been buried :-)

In the mean time, however, I have discovered that this conflicts with
kn/ref-filter-branch-list in pu. In that topic this specific feature is
implemented as well. They incorporate it into %(upstream:track) instead
of having a separate "sub-atom" (what's the correct nomenclature, by the
way?) more in line with with branch -vv and your idea.

I recall seeing discussions about this work earlier, but I based my
patch on master and forgot to check pu. (It was a spur-of-the-moment
thing fueled by a question in #git about how to parse branch -vv to
delete all local branch who had their remote counter-parts removed after
a fetch --prune.)

Unless that topic gets rejected, or is known to not be merged for a
_long_ while, my patch doesn't add much value.

Regards,
=C3=98sse
