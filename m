Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-2.7 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_HI,RCVD_IN_SORBS_SPAM,
	RP_MATCHES_RCVD shortcircuit=no autolearn=no autolearn_force=no version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id C35642027C
	for <e@80x24.org>; Thu,  1 Jun 2017 11:47:38 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1751167AbdFALr2 (ORCPT <rfc822;e@80x24.org>);
        Thu, 1 Jun 2017 07:47:28 -0400
Received: from mail-it0-f50.google.com ([209.85.214.50]:38129 "EHLO
        mail-it0-f50.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1751060AbdFALr1 (ORCPT <rfc822;git@vger.kernel.org>);
        Thu, 1 Jun 2017 07:47:27 -0400
Received: by mail-it0-f50.google.com with SMTP id r63so32297322itc.1
        for <git@vger.kernel.org>; Thu, 01 Jun 2017 04:47:26 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=mime-version:in-reply-to:references:from:date:message-id:subject:to
         :cc:content-transfer-encoding;
        bh=kEyiNxdUTC6sf5ffwJWAwKV7T02EONC2b0Hrl7lm9kk=;
        b=TrYfwqchqpjhmAa3iPFPKMsZKrJmLKzGVuACkrB5NBX1Gj7ffl578RVwHNmc5F8oX6
         hvmNVBZdzGMmvwnHWHJ73z8dgQLKlKf1ljA6ftRCIOZjGjGZyUil7ZNRFHjY0bw5MFB/
         AT8vhH4Z18MhxlEh6AzlqJtybMwqjN3ruSGcMku3DeipaagMqjlPFYTXTG64aj4gpcH4
         8o761Zdb9Gi8QItca/Ogw++QFS9kOo/V1P20iz0tZjTg9YW/uMbdLg2+F5qggKs5jUvo
         mq/re9Q3quBIzyN5PAgehfzwrK7zye0ppePBdWPdDtCwi9vW9PmTVmaovdWasa4yr5gA
         DYcA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:in-reply-to:references:from:date
         :message-id:subject:to:cc:content-transfer-encoding;
        bh=kEyiNxdUTC6sf5ffwJWAwKV7T02EONC2b0Hrl7lm9kk=;
        b=U3+4VeLswAHFwBIDa5p8hMcyh+LWmX/Kpqm1rDhTaIcq3uLMyCpQ/qkQZ4OfkGVO0d
         Qiv+FB+2Y+ZMxl4q8B2gzoaGdp8LldogVhXKbCgxY2LspwsQQts7KdHsuxGVZK20UVAX
         mkG8jqZoHeD26FumfnW0vVh4ZSJiA9Zb5eGgke7kpCLOCx0z17x5WNGmw3dfS8Ml6+XY
         w0u0OxfNwff471VsyedBaIMMAZJtbY7cXJqep5a6/lEGbP+gXvI7J9EUy+i5d3DKTsO+
         GEu9qxKfSyI+RSGvX2a5zJ2PkbshUhXcRifeLDklHvTmi2GfZmcgmL9Fg6AFyBlgELnb
         2Chw==
X-Gm-Message-State: AODbwcDBJOrKqkF4T8hZLOhUDlAahnYEimMX14n19SJfETiHvWVvRYdr
        2I0FTtE+6jS8vqXDItjaXBPaVytHwehJ
X-Received: by 10.36.166.4 with SMTP id q4mr2391081ite.66.1496317645907; Thu,
 01 Jun 2017 04:47:25 -0700 (PDT)
MIME-Version: 1.0
Received: by 10.107.8.220 with HTTP; Thu, 1 Jun 2017 04:47:05 -0700 (PDT)
In-Reply-To: <CAMOGhMLMo82RgH0HareB78KVWz2gMGzhB1i5s3SobW9wHk0zbg@mail.gmail.com>
References: <CAMOGhMJyO=+EZz6qCejxeTe5FdE=RheJX9A5g3U6eKhUKj8_BQ@mail.gmail.com>
 <CAMOGhMLMo82RgH0HareB78KVWz2gMGzhB1i5s3SobW9wHk0zbg@mail.gmail.com>
From:   =?UTF-8?B?w4Z2YXIgQXJuZmrDtnLDsCBCamFybWFzb24=?= <avarab@gmail.com>
Date:   Thu, 1 Jun 2017 13:47:05 +0200
Message-ID: <CACBZZX4Zdgu=qsx5sX_THPdO5tuD+HTDAiMfLDhrB_J_VmENMQ@mail.gmail.com>
Subject: Re: wrong language translation part7
To:     SJR <haltekx@gmail.com>
Cc:     Git Mailing List <git@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

2017-06-01 13:16 GMT+02:00 SJR <haltekx@gmail.com>:
> W dniu 1 czerwca 2017 09:43 u=C5=BCytkownik SJR <haltekx@gmail.com> napis=
a=C5=82:
>>
>> Hi,
>>
>> https://git-scm.com/book/pl/v1/Dostosowywanie-Gita-Konfiguracja-Gita
>>
>> part in polish part in english.
>>
>> Can You repair translation?

The sidebar says the Polish translation is not 100% complete. So that
presumably means you get these partially translated pages.
