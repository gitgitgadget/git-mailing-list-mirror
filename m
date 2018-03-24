Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-3.0 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_HI,T_RP_MATCHES_RCVD
	shortcircuit=no autolearn=ham autolearn_force=no version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 3145D1F404
	for <e@80x24.org>; Sat, 24 Mar 2018 05:43:30 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1751715AbeCXFn2 (ORCPT <rfc822;e@80x24.org>);
        Sat, 24 Mar 2018 01:43:28 -0400
Received: from mail-ot0-f193.google.com ([74.125.82.193]:35810 "EHLO
        mail-ot0-f193.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1750801AbeCXFn1 (ORCPT <rfc822;git@vger.kernel.org>);
        Sat, 24 Mar 2018 01:43:27 -0400
Received: by mail-ot0-f193.google.com with SMTP id r30-v6so15522164otr.2
        for <git@vger.kernel.org>; Fri, 23 Mar 2018 22:43:27 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=hackers-mu.20150623.gappssmtp.com; s=20150623;
        h=mime-version:in-reply-to:references:from:date:message-id:subject:to
         :cc;
        bh=t+Z4wibB52kiiKl8rUv2aDQ6mUTHRYHxvJD5tqroAyo=;
        b=aQKIj7bRBR9/I/NKNjvRUFXHmN1+dB5labCLINlly+ENNSoxU1IL+snOsHxdvdu/Td
         cwuoTWIxg2Lh2EL8SBPiAV9pTip86X2IXq1ltoM6r5AbF1gD//jDAbHwVsdDJFkRlhfv
         gxJoRLy5KyVGDsJgLFBmmju9GbcMDxNRevOuzuNuFPZ6gH57u33ZGbMd83EgIHmTz4A7
         OLV+kGqQd/93E1dmIg021CaCOzEaAmlolt+3jzMvgvRQ3mLFO2YE6dVXzqB5Hk1ALk9U
         Dwlj2wvA9qu42RpUrXzX3SHWsyEzVw52ACBYRnFDReaGjrNoMp8B5rllyyogDzQdj4TP
         sncw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:in-reply-to:references:from:date
         :message-id:subject:to:cc;
        bh=t+Z4wibB52kiiKl8rUv2aDQ6mUTHRYHxvJD5tqroAyo=;
        b=R2YhuJPvnW8Ofkm6UzLJa+M9a2loZlbgT6ZfOTrGtwbepRmfRZDN4MY68uhyD2GQfB
         Zgzd6t/X8K7cLcGxl+YewWWhGF+uUQ59R1KuZAVKDPacF3WEL5cQoGA7QGuuQ87EA2gr
         LovuAUNKc1ZPb5WgtyfhcWXhXfjpb71fYQm6KR35ri1GyjHbyuQ7ykMAGQStmb5RZZUb
         SOCOkEwmboldxwRoKxtvCZfCkVTbIcMAXPQdlasL3cM46gpu7kjV24VQ9XJ3nj5q4QzZ
         Rg7V2PEg8BoSSProa1BQuPPLayhwo4N3n+FyiyI2tcjB2wFMKqnP8syVuwYtX3oMzI5b
         v7xQ==
X-Gm-Message-State: AElRT7FR9rAcn60Tyz2A/q3NDanomdP6//ZXlGVvAnJMNPWIJhvjPOFX
        LGBaxNpQN+C1Mzv6oY8dA+22lr8vrAnVvVSheYoyoozT
X-Google-Smtp-Source: AIpwx4/lHbSfozdlZL6wYpRTdyiHjvsl3i/X5ahz3E5ZgurBVo2QKC8G2MGbMMv7mXwSb3+brqHlvnjpEJCnC1ARuYM=
X-Received: by 2002:a9d:213c:: with SMTP id i57-v6mr1828554otb.85.1521870206810;
 Fri, 23 Mar 2018 22:43:26 -0700 (PDT)
MIME-Version: 1.0
Received: by 10.74.197.137 with HTTP; Fri, 23 Mar 2018 22:43:26 -0700 (PDT)
In-Reply-To: <alpine.DEB.2.20.1803232246020.16250@tvnag.unkk.fr>
References: <20180323193435.GA21971@voidlinux> <alpine.DEB.2.20.1803232246020.16250@tvnag.unkk.fr>
From:   Loganaden Velvindron <logan@hackers.mu>
Date:   Sat, 24 Mar 2018 09:43:26 +0400
Message-ID: <CAFDEUTfxnJdVunuEJ9VWPy_T4yByv3cCGZZbW7iDfoq3kYy17Q@mail.gmail.com>
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

Here's the error i get when I use a recent libcurl, but the OpenSSL
wasn't built with tls 1.3:

 using : GIT_SSL_VERSION=tlsv1.3

Error:
OpenSSL was built without TLS 1.3 support


> --
>
>  / daniel.haxx.se
