Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.2 (2018-09-13) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-3.8 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,RCVD_IN_DNSWL_HI
	shortcircuit=no autolearn=ham autolearn_force=no version=3.4.2
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id D646A20248
	for <e@80x24.org>; Wed,  3 Apr 2019 09:26:58 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726360AbfDCJ05 (ORCPT <rfc822;e@80x24.org>);
        Wed, 3 Apr 2019 05:26:57 -0400
Received: from mail-pg1-f194.google.com ([209.85.215.194]:44700 "EHLO
        mail-pg1-f194.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725940AbfDCJ05 (ORCPT <rfc822;git@vger.kernel.org>);
        Wed, 3 Apr 2019 05:26:57 -0400
Received: by mail-pg1-f194.google.com with SMTP id i2so8007217pgj.11
        for <git@vger.kernel.org>; Wed, 03 Apr 2019 02:26:57 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=jAZ2dR7M0JNv1WAXbs/Ws6FuoZTO0US5LkA/xU241ww=;
        b=S9b+IVy91feHfVaesAU9UEB6mzt69TjQq86sgp0epGQDb5qBSEeN1gr/jd/0ycCBFu
         cf4RMjYUcVkenyteK9tW5ex8BFMOSc4fXQkD6JxVESC9BZ/bjC+D2K1M6JsqRU8vG/Pc
         d35hDaxADyL0TkM0Z2cWeSAOpfs7sd1NBASlH903y3qVCfeUtQ7pYEdHPorKDW8rB+ob
         g/ZDZGIbbWRrnekoJdnl73tD1jDku+ecNSvnuK8b+5gSLTtxxeCcBCNFKjMM9CQ4iCrS
         JZZp3BCy69fwLIjrIv8lfg/J+N1gtaucaN8NY4JWtX1v1x6Ih/7VgvKNKQX05Vd1xWoy
         Kprw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=jAZ2dR7M0JNv1WAXbs/Ws6FuoZTO0US5LkA/xU241ww=;
        b=rUo7xp8nSyhlcncKXhJIfw2641k9Kx+QaE5YXBGFZyeZLf6nkNyD576JLlHFMuh8dN
         bwG6SSrq9w6rGzPyLLxRQ6UjTc6n9Dhf1dQ/LOP0HlVQQ5WKRYIAcbp/bE4DGjpMZ78R
         UyqDP9drfALsQvcqlA4ryzfuWneAMxt6TlluUu7p6fp2WbL2IMZ07Pn1pCklLj6Xxz6c
         Fbzyzaz7jtUfxQBZXvuEyPrcMGb9MmHtoONqBYYKbYE7+efKiSBmqTkMHJmaqySBNj6t
         sjMp4dSYDa06bXc43Z9cs9mwy+GBtbLLNGAT0eZGUAKYSZSstYYOR5rgPnXDcX4lO2o0
         XxpQ==
X-Gm-Message-State: APjAAAWTx/eTVDw435ZyqsYK/v7TAKYJa4IaEdwUu9fVk8IaT+A8kMQ4
        vceVd/6g09KojyRgEl6FVeR889nUJzQIMFgi2aw=
X-Google-Smtp-Source: APXvYqx6B2n9YW3ynIFTbCdRW9wcSDT425fV8qHLJP5gnUyj4vDOeDcEfwVIKtV4NlGV1Mpae8vw2lsFrpw1iR8V8nk=
X-Received: by 2002:a63:2b0d:: with SMTP id r13mr22489148pgr.400.1554283616782;
 Wed, 03 Apr 2019 02:26:56 -0700 (PDT)
MIME-Version: 1.0
References: <20190330183001.16624-1-tmz@pobox.com>
In-Reply-To: <20190330183001.16624-1-tmz@pobox.com>
From:   =?UTF-8?Q?Martin_=C3=85gren?= <martin.agren@gmail.com>
Date:   Wed, 3 Apr 2019 11:26:43 +0200
Message-ID: <CAN0heSpB_0Hi2zCA+gmiaARpSYM7fKayB2rs6wFi_VeXevqd+Q@mail.gmail.com>
Subject: Re: [PATCH v1 0/2] minor asciidoc/tor formatting fixes
To:     Todd Zullinger <tmz@pobox.com>
Cc:     Git Mailing List <git@vger.kernel.org>,
        "brian m. carlson" <sandals@crustytoothpaste.net>,
        Jeff King <peff@peff.net>,
        =?UTF-8?Q?SZEDER_G=C3=A1bor?= <szeder.dev@gmail.com>
Content-Type: text/plain; charset="UTF-8"
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

On Sat, 30 Mar 2019 at 19:30, Todd Zullinger <tmz@pobox.com> wrote:
>
> Just chipping away at the remaining differences between asciidoc and
> asciidoctor.
>
> Todd Zullinger (2):
>   Documentation/rev-list-options: wrap --date=<format> block with "--"
>   Documentation/git-status: fix titles in porcelain v2 section

Nice. I've tested and diffed across various dimensions. Looks good to me.

Martin
