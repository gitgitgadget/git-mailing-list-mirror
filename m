Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.2 (2018-09-13) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-4.0 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,RCVD_IN_DNSWL_HI
	shortcircuit=no autolearn=ham autolearn_force=no version=3.4.2
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 4910F20248
	for <e@80x24.org>; Mon,  1 Apr 2019 21:54:49 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726775AbfDAVys (ORCPT <rfc822;e@80x24.org>);
        Mon, 1 Apr 2019 17:54:48 -0400
Received: from mail-wm1-f68.google.com ([209.85.128.68]:51312 "EHLO
        mail-wm1-f68.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725869AbfDAVys (ORCPT <rfc822;git@vger.kernel.org>);
        Mon, 1 Apr 2019 17:54:48 -0400
Received: by mail-wm1-f68.google.com with SMTP id 4so1017551wmf.1
        for <git@vger.kernel.org>; Mon, 01 Apr 2019 14:54:47 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:subject:to:cc:references:message-id:date:user-agent
         :mime-version:in-reply-to:content-language:content-transfer-encoding;
        bh=Sb0X65UEYKZ7rVsJGlcjzuj4jd7AuWivUAjvpAhdJuo=;
        b=ZJtWxOC/xGPB6d3ppMbSX3Tg9EJcPBSTqMw56bhElZUzvzIwRlmQ+kvh6rh/wb1jOp
         njOsoDBIMm/p2nJchWmb+dm1S9AaW/N9HHpFQETKJbP5eC1cSumOwZawSraFM2vKnxfw
         JfmG6a5JZmF95P8+4IYmNYC1t5j1aJVcMv8/wDz926Eww9XV5S+Kpsm8U1cIt8iROsC3
         o9FzEmmOmd+FWTAaikodWA6Ep/0bL3pNCQkpQM7C38DHWsH8RvDr+QRQqwqgBnHc4k2j
         l222Y9imUuB7JxVvEIN1dAHCkTYAw76gtoasW5nU/AMon885h/1BgrnpOthaXO+Kg6U4
         pFMw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:subject:to:cc:references:message-id:date
         :user-agent:mime-version:in-reply-to:content-language
         :content-transfer-encoding;
        bh=Sb0X65UEYKZ7rVsJGlcjzuj4jd7AuWivUAjvpAhdJuo=;
        b=RToJjo6W/R56LJDg2LEYm62EyMv3K79EGCIduco/B9DTOCqkP8NbcvClB+pUwjOSn5
         7nv9IZE4PAtLNbYcpcLl2z6epOD7C+84eiGBFyAKFdUNPrGZqHgmWGHUhAhlzIEStoaf
         2IL9XXhNnPIVmbr7iRHUzfZ9hItkG9tJY2ocNhW2keEsne62M+DK1FnZnzdI4GD8qlfr
         Hlcoiulp6rnHFEh+t/P1fKqkMWNdr20aBmFxOkK0Z5xk9V6cKmySJzbf4BkYWXvUDGc1
         mHO6W5bKHC7rRMVjuIp9JfxVe5bt0c/qCn1bFAqseF0d47FEZ+AeycsqbPoTdrjvGHDC
         TylQ==
X-Gm-Message-State: APjAAAXns83ey9w3n45xpe1rGH+DHjD6d1uK1ElTVKcBuF6F6vjtEMCR
        L/+cJ4VIiCA3XyBbXobMUzRK/ghLtyY=
X-Google-Smtp-Source: APXvYqx7R+BFC1WJ4j9P9qiP5yPnjaV2umw2Kk03HfvyTW/3jE6hjN1dPBao4TW+vZeOpRrEhrkyMg==
X-Received: by 2002:a1c:80cd:: with SMTP id b196mr1109160wmd.84.1554155686501;
        Mon, 01 Apr 2019 14:54:46 -0700 (PDT)
Received: from [10.42.1.10] ([185.220.70.166])
        by smtp.gmail.com with ESMTPSA id x18sm11311264wmi.6.2019.04.01.14.54.45
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Mon, 01 Apr 2019 14:54:45 -0700 (PDT)
From:   Andrei Rybak <rybak.a.v@gmail.com>
Subject: Re: [PATCH] mailinfo: support Unicode scissors
To:     Duy Nguyen <pclouds@gmail.com>
Cc:     Git Mailing List <git@vger.kernel.org>
References: <20190331220104.31628-1-rybak.a.v@gmail.com>
 <CACsJy8As7_qS-JRdMSNJco_=F4r21sjPR32thVrAB_CTrRdz8Q@mail.gmail.com>
Message-ID: <9481b5c1-5fe0-2d83-a721-72cb2a9e6d18@gmail.com>
Date:   Mon, 1 Apr 2019 23:54:44 +0200
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:60.0) Gecko/20100101
 Thunderbird/60.6.1
MIME-Version: 1.0
In-Reply-To: <CACsJy8As7_qS-JRdMSNJco_=F4r21sjPR32thVrAB_CTrRdz8Q@mail.gmail.com>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 8bit
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

On Mon, 1 Apr 2019 16:27:02 +0700, Duy Nguyen wrote:
> On Mon, Apr 1, 2019 at 5:03 AM Andrei Rybak <rybak.a.v@gmail.com> wrote:
>> Support UTF-8 encoding of '✂' in function is_scissors_line, for 'git am
>> --scissors' to be able to cut at Unicode perforation lines in emails.
>> Note, that Unicode character '✂' is three bytes in UTF-8 encoding.
> 
> On top of what was already said in this thread. For some reason (bad
> font?) these scissors are drawn cutting _down_ for me instead of left
> or right. It looks a bit strange.

This might be an indication that the font used is rendering the
symbol as an emoji. Most scissors in emoji fonts are vertical:
https://emojipedia.org/black-scissors/
