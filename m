Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-3.3 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,RCVD_IN_DNSWL_HI,
	T_RP_MATCHES_RCVD shortcircuit=no autolearn=ham autolearn_force=no
	version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id C04F81F42D
	for <e@80x24.org>; Fri,  6 Apr 2018 16:58:23 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1751529AbeDFQ6V (ORCPT <rfc822;e@80x24.org>);
        Fri, 6 Apr 2018 12:58:21 -0400
Received: from mail-qk0-f178.google.com ([209.85.220.178]:41223 "EHLO
        mail-qk0-f178.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1750962AbeDFQ6V (ORCPT <rfc822;git@vger.kernel.org>);
        Fri, 6 Apr 2018 12:58:21 -0400
Received: by mail-qk0-f178.google.com with SMTP id s78so1862396qkl.8
        for <git@vger.kernel.org>; Fri, 06 Apr 2018 09:58:20 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=mime-version:in-reply-to:references:from:date:message-id:subject:to
         :cc;
        bh=lkyhq/9TFHXhKAc69MbGBuZyfssftMLnq6P2Qwx850E=;
        b=ULWIX+zxm8HfRDKKyfmJNkOwzWNiw4lS0jFVUk0pZt4UjXOlboVsmJWxfIrV8Lcfe/
         ussJJDs4+aklwdyAlXWgJMRyMWDHgFLIvHglS56L85YzLudZgnQ05WOpYBGApz3IlWt9
         WcTbrN2kTABGqx8DMiegMzOx6VdDoJIxGpcdnAmbtPOsAHS2eJb1YelIxEJSSqQse8ze
         dox7wDb2LPVBjHeiUztmtal3g08spx8BPoPdnw4n1zq2i8paicZA/gormQUDfVKhpMIQ
         q4X8gvAhd2e4bdeMoAAvFFlZo5E5+l/bQQ9HIuagn8xepXNmiHxTUf7QjlhOSrr/7cBX
         cclg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:in-reply-to:references:from:date
         :message-id:subject:to:cc;
        bh=lkyhq/9TFHXhKAc69MbGBuZyfssftMLnq6P2Qwx850E=;
        b=qRqFdYTXsINn3rsDds3MuOsONmxOUJ/4B7BTaGChD32Q/9NhEXFn26z4XmtuDAAqop
         ogvhBbjC4Eyw6twYM+hDplM+27Dp2sJZsX3K3MIUcvcVtaVtXAcw56vWWcnOwF01e1ib
         qKBW6URhgmYrdXDF5Rv+Sv19J2KHWPW+rcwZo5umqY6/uCWUIeVLlDm9tX0uV9HCa+XD
         STK2zCcnMqtmXW4dWKyU0fJApSEzYS7of4wLnHLAcxwBcFBu8eiGPk4bIPfoD1rK382K
         ueugS28FFaUsR2P6B6VcEwNmebswvlosqYnknPg+XOwCF9bUdPWR6tYiCqCDgt4oIA7d
         rDsw==
X-Gm-Message-State: ALQs6tCGek68hFe2WNGZda1ZQhV10nEi6IwH8c/ZO8500aYL27XPCPGU
        Qx9ecAaplxIIl3ec2RdUEcmb92mkGp9A/gXUDrM=
X-Google-Smtp-Source: AIpwx497LTxQsnan9LsfM8QXhZdgEtPa3AwKT5N4gi1mCZoYvZGTAYlh/87fiGDNHYKTBd65CuqeuOhCI78pE88q148=
X-Received: by 10.55.78.86 with SMTP id c83mr36946548qkb.264.1523033900209;
 Fri, 06 Apr 2018 09:58:20 -0700 (PDT)
MIME-Version: 1.0
Received: by 10.12.203.129 with HTTP; Fri, 6 Apr 2018 09:57:39 -0700 (PDT)
In-Reply-To: <20180406175556.5b6e16f0.olaf@aepfle.de>
References: <20180405092358.569e0315.olaf@aepfle.de> <874lkq11ug.fsf@evledraar.gmail.com>
 <20180405104948.276de0ca.olaf@aepfle.de> <8737092929.fsf@evledraar.gmail.com>
 <20180405152525.13d1c776.olaf@aepfle.de> <20180405163227.GA25224@sigill.intra.peff.net>
 <20180406175556.5b6e16f0.olaf@aepfle.de>
From:   Rafael Ascensao <rafa.almas@gmail.com>
Date:   Fri, 6 Apr 2018 17:57:39 +0100
Message-ID: <CACUQV5_E+MOHVD2rGjcQY=iK+tqB3wV9Lh1nwiEP+q+M-1iXzA@mail.gmail.com>
Subject: Re: How to undo previously set configuration?
To:     Olaf Hering <olaf@aepfle.de>
Cc:     Jeff King <peff@peff.net>,
        =?UTF-8?B?w4Z2YXIgQXJuZmrDtnLDsCBCamFybWFzb24=?= <avarab@gmail.com>,
        Git Mailing List <git@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

On Fri, Apr 6, 2018 at 4:55 PM, Olaf Hering <olaf@aepfle.de> wrote:
>
> This does not work. Initially I copied the global config into the repo and set all unwanted values to <empty>, like 'smtpuser='. Perhaps the config parser recognized that fact, but the consumer does not?
>

Today someone asked on #git for a way to disable diff.external for a
single command.
Without thinking much I suggested $git -c diff.external= diff; which fails with:
`fatal: cannot run : No such file or directory`

In this particular case there was `--no-ext-diff` to get around this
and the case was promptly resolved.
Just another another example where setting configuration values to
"empty" doesn't translate to "disable this option".
