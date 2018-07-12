Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.1 (2015-04-28) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-3.8 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,RCVD_IN_DNSWL_HI
	shortcircuit=no autolearn=ham autolearn_force=no version=3.4.1
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 682FC1F85E
	for <e@80x24.org>; Thu, 12 Jul 2018 04:23:33 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1725786AbeGLEbM (ORCPT <rfc822;e@80x24.org>);
        Thu, 12 Jul 2018 00:31:12 -0400
Received: from mail-wr1-f52.google.com ([209.85.221.52]:44109 "EHLO
        mail-wr1-f52.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725748AbeGLEbM (ORCPT <rfc822;git@vger.kernel.org>);
        Thu, 12 Jul 2018 00:31:12 -0400
Received: by mail-wr1-f52.google.com with SMTP id r16-v6so20188556wrt.11
        for <git@vger.kernel.org>; Wed, 11 Jul 2018 21:23:30 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=1v/nOXqQcpLfYhKKFiWb2f0zG13l9Jb65O3IRBGBKC4=;
        b=iYe6T2CVF+jYfMru/zfkqXuNkUaZI5pV/vX4kOf+mUqi77d8Mzm/xPtr5BoZbEQu/K
         u5MnwrwLSWuecmORPNMJellOawsLiiaG0VnA20Ygl7oZjm3dxk1xlsCWBlpxfhePZSuo
         FRiNgQAPZBvq2pYNEanjGdcrkM6YhTyiTv94PPrGMBb8Mj6Mp3NN0Ib+1ikR4H/AaQVF
         5trgX4G3JiVVK7vt6TTZNoJ/GE6zhHVPpUThsAzNXQ02RivJhTOb+aC88nyWsd9AgxKc
         1qtrIiU5KXBR/qTNvsRsFAKtrXFQ3GV3rn7SX4xyve2aIAxWch2bcBOLNOUvzlFRBjM7
         /E0w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=1v/nOXqQcpLfYhKKFiWb2f0zG13l9Jb65O3IRBGBKC4=;
        b=JZZt6ErWfTjvc11kTsmUqvmCWTzLaBjZaOFg8Rh0cfPhwV1D+vKcwdRKE7BkoiOhoZ
         VGtEZHIjHDeC+FTC5BF/52UlLur/sdaPNRb+xrObLfw9FG/UDdbXe/XVNT8hMqUHUL3m
         +8nybjKcsUbREnpwqf2OiABduomQrm3k5h48ORyuAAIEpy4DMDHfW75ckopXKYWKT1xL
         fn6bB8VhXmbTBuD11HsfL6/wl4XH45oz2lMm36kgsuf2u3ISxpQ7EX86wtQwe51E31F+
         tVxIsquAp7n8P8QqH7aeckChK64CpTP5BiEz+hFsJ4lP/oK/OD2qGnbUg6SM4uMQ0Mfj
         HMCw==
X-Gm-Message-State: AOUpUlFyokU8rqHw7d0kRcpKBSAIsmPmz4Csq5nBppBpWvGkPbtWsyCF
        5PKRxUNTMhjSsXGnVs3LkRa2YE55ISRNS0ZT774=
X-Google-Smtp-Source: AAOMgpeBiWH6PgcxtMyPArdCdkM7SG67IsQ4KHemAsVxOn0jVz68apXKBUZ0Imui8JNCMFDT8PP3szpo+i5SVDvbix8=
X-Received: by 2002:adf:adae:: with SMTP id w43-v6mr384344wrc.251.1531369409378;
 Wed, 11 Jul 2018 21:23:29 -0700 (PDT)
MIME-Version: 1.0
References: <d6b9e84b-4d9e-ff1d-e726-56aa58a6b358@gmail.com>
In-Reply-To: <d6b9e84b-4d9e-ff1d-e726-56aa58a6b358@gmail.com>
From:   Pratik Karki <predatoramigo@gmail.com>
Date:   Thu, 12 Jul 2018 10:08:18 +0545
Message-ID: <CAOZc8M-CVgSqCByngV3DjQ0wNhDFOoWZuHVyRmoHiHZ9kuB-OQ@mail.gmail.com>
Subject: Re: [GSoC] GSoC with git, week 10
To:     Alban Gruin <alban.gruin@gmail.com>
Cc:     git <git@vger.kernel.org>,
        Christian Couder <christian.couder@gmail.com>,
        Stefan Beller <sbeller@google.com>,
        Johannes Schindelin <Johannes.Schindelin@gmx.de>,
        Paul-Sebastian Ungureanu <ungureanupaulsebastian@gmail.com>
Content-Type: text/plain; charset="UTF-8"
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Hi,

On Tue, Jul 10, 2018 at 10:05 PM Alban Gruin <alban.gruin@gmail.com> wrote:
>
> Hi,
>
> I published a new blog post:
>
>     https://blog.pa1ch.fr/posts/2018/07/10/en/gsoc2018-week-10.html
>
Nice work.

Sorry for late notification, my blog is up too.

https://prertik.github.io/post/week-10

Cheers,
Pratik
