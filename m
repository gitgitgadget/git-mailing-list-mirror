Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-3.0 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_HI,T_RP_MATCHES_RCVD
	shortcircuit=no autolearn=ham autolearn_force=no version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id C08A91F404
	for <e@80x24.org>; Sat, 24 Mar 2018 04:21:50 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1750763AbeCXEVs (ORCPT <rfc822;e@80x24.org>);
        Sat, 24 Mar 2018 00:21:48 -0400
Received: from mail-ot0-f194.google.com ([74.125.82.194]:40516 "EHLO
        mail-ot0-f194.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1750727AbeCXEVr (ORCPT <rfc822;git@vger.kernel.org>);
        Sat, 24 Mar 2018 00:21:47 -0400
Received: by mail-ot0-f194.google.com with SMTP id l12-v6so15425227otj.7
        for <git@vger.kernel.org>; Fri, 23 Mar 2018 21:21:47 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=hackers-mu.20150623.gappssmtp.com; s=20150623;
        h=mime-version:in-reply-to:references:from:date:message-id:subject:to
         :cc;
        bh=9tW1oLL8uBiqlrn968JqbJNg9DT+PDdPZnXOEjKmntw=;
        b=NVVK9J8aHc+EV1F7ziyjMqgpOcW33ELnc59vvQ5eqLqDVtpBO2k2xwVrn/mQCitpso
         87D6rRQ6CcUw+0RF5MmQCB9AVHNaiOLTSFcExISjPrtV3nx/jSZ8vqx6jB4tJHASdGH1
         e+7Sv6a2hf/Au41F2ZssMmFupy8vJipO9c4H6IMeHnTtzuolSB2KiK0c5rBa/9UFESyz
         xwfAW10kCzxkqmSOCuInWLp/x/m9o1hkukB2ube7XTKA14oZ/cBjrcQufrZAqOELeJGn
         FhPTZofj6QmPKMfWC5uUKDF/vZzZ6qLsknzDpQOulGpyffm9FjxoWLzPh6HavpUCRm9q
         NW7g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:in-reply-to:references:from:date
         :message-id:subject:to:cc;
        bh=9tW1oLL8uBiqlrn968JqbJNg9DT+PDdPZnXOEjKmntw=;
        b=RXxjCXslYkZg89h1oY/oQW2mlW4qE/HstpUFpUFAvbqXgfThon63+FweocrFK3/CrC
         HXwl+f0vXfgbwjr2/YkCk2D/PSLlo09KOo5ai4+glITo6a/OAHB/Fzj91h5Jd9fAc7Wt
         eZVshwtc/cuHACCWx0jiQQUmq/Qh5QOWvGSwuGaVTXb1hZdsArKAV6HiEJ4q2MNO7doO
         rqljnYUg+bXD2R6W9C+bd41D+aqsrS+rqnZiTuIiwg43zGoCxdB7INhTxZ3jVIDtCGVu
         EIbs/pAozvtubcA12Wk7cBmWe5bg166PHcTaKjqyfP4wV+CAXC1oep8so7nnrc9bybuM
         c1yQ==
X-Gm-Message-State: AElRT7ErpgNDH1xxSASnUVOoS4UkyK+cs4C6jmzm8cBkt1Lz4JrNNkUx
        QK6zoICGhVzAR4vUgkj1ycG4S9Z1pIPNR+KcyzDp0Q==
X-Google-Smtp-Source: AG47ELt4uG2imUTipBdaqxKsgFzwE1Mmu3UhueN+FcHT1xoMwDijyQXxxx9OtmVtKNJeJoGw5hm4vyFeTDqIvYFSk/Y=
X-Received: by 2002:a9d:419a:: with SMTP id p26-v6mr14100868ote.350.1521865306914;
 Fri, 23 Mar 2018 21:21:46 -0700 (PDT)
MIME-Version: 1.0
Received: by 10.74.197.137 with HTTP; Fri, 23 Mar 2018 21:21:46 -0700 (PDT)
In-Reply-To: <alpine.DEB.2.20.1803232246020.16250@tvnag.unkk.fr>
References: <20180323193435.GA21971@voidlinux> <alpine.DEB.2.20.1803232246020.16250@tvnag.unkk.fr>
From:   Loganaden Velvindron <logan@hackers.mu>
Date:   Sat, 24 Mar 2018 08:21:46 +0400
Message-ID: <CAFDEUTeggKUbjAHdO6wG9uOk01o2atbqf8MB=VHF_XGgXmBQzQ@mail.gmail.com>
Subject: Re: [PATCH v2] Allow use of TLS 1.3
To:     Daniel Stenberg <daniel@haxx.se>
Cc:     git@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

On Sat, Mar 24, 2018 at 1:47 AM, Daniel Stenberg <daniel@haxx.se> wrote:
> On Fri, 23 Mar 2018, Loganaden Velvindron wrote:
>
>> +#ifdef CURL_SSLVERSION_TLSv1_3
>> +       { "tlsv1.3", CURL_SSLVERSION_TLSv1_3 }
>> +#endif
>
>
> Unfortunately, CURL_SSLVERSION_TLSv1_3 is an enum so this construct won't
> work.
>
> Also, let me just point out that 7.52.0 is 0x073400 in hex and not the one
> used for the first version of this patch.
>

Thanks, will fix it.

> --
>
>  / daniel.haxx.se
