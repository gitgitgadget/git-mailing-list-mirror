Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-2.8 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_HI,RCVD_IN_SORBS_SPAM,
	RP_MATCHES_RCVD shortcircuit=no autolearn=no autolearn_force=no version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id AC6821FAF4
	for <e@80x24.org>; Wed,  8 Feb 2017 17:11:44 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1752480AbdBHRLk (ORCPT <rfc822;e@80x24.org>);
        Wed, 8 Feb 2017 12:11:40 -0500
Received: from mail-ot0-f180.google.com ([74.125.82.180]:35577 "EHLO
        mail-ot0-f180.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1752021AbdBHRLj (ORCPT <rfc822;git@vger.kernel.org>);
        Wed, 8 Feb 2017 12:11:39 -0500
Received: by mail-ot0-f180.google.com with SMTP id 65so117746787otq.2
        for <git@vger.kernel.org>; Wed, 08 Feb 2017 09:11:30 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=mime-version:in-reply-to:references:from:date:message-id:subject:to
         :cc:content-transfer-encoding;
        bh=pCkAJYN75LRxHWgypjY9z/Odi2LhyJ4nkmNiH5nUXcM=;
        b=mUrUTJlF+trFTUDkS6yrTLwKMai4GwvUu9TphcnqqdIDDOu92MTc0lwmIkiHlQV6CE
         /Y9f1OZBtPT0qhoLlOUPDpn3XAF4goAWHfvGd/MXUb+1J5+dANfRSB7pU24wueBCCEaA
         2m5pNQkjz8ALfQNetnjqj0zwkAZusWNA2NO9kwFzkXSTXChu8n5gDzH5SzTy43bDiQP/
         tcoAtMmalG8+z8Vtmkq6MO4om1SIIMCdDkmGjdxAnWnljAqIhE2sUZdh3efGUwY9RmpC
         9hT+D7wBTbVyoaMvuDtKQ8sggGXOUS7V9NcVHGMZNL8hN4eq64dMCss3CFsr3mXD2t86
         xK3Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:in-reply-to:references:from:date
         :message-id:subject:to:cc:content-transfer-encoding;
        bh=pCkAJYN75LRxHWgypjY9z/Odi2LhyJ4nkmNiH5nUXcM=;
        b=SeWzDsSKacwcasBP8qS9Q1GISNnq0Cgv/fCs7sbrao0xe2YykSFoN3hJ+oAb/NXFfx
         ZhbODQiuoAJmXiHWWJ+2Vw1ACwSgo8N9H76N4irVqZGBBdUOb/wiHiKL27fy2JfisUKs
         mjCOFEwMLrrb3AiCbWwuOAY2OXVILTueZBvaKrxjmSplv8B1MoRWy4PxiYG7s8pAks4n
         7Dam5fZw6KHh9FRkouWveD24w81/0q6/yPPgbgNiglsd/76L/DBGE9+rzVx7FCjmLQmt
         qwvYvfdbalnopzKTzkr8UwlpqEoo2avevhGagOZj0BxXyHOc5QbaSG6x3lNFZ+ynlikW
         Sldw==
X-Gm-Message-State: AIkVDXL/+ECwvSJhGv43+yjIrE0tBzyTDg3b7Roa9pfgyBaih1AJ1cJ+qJGYc5YbNskZvT8Ogu6MZpPb78PznQ==
X-Received: by 10.157.8.178 with SMTP id 47mr13224155otf.188.1486573889971;
 Wed, 08 Feb 2017 09:11:29 -0800 (PST)
MIME-Version: 1.0
Received: by 10.157.13.38 with HTTP; Wed, 8 Feb 2017 09:11:29 -0800 (PST)
In-Reply-To: <271989d5-c383-0c0d-bfcb-f4118f9fa2aa@web.de>
References: <CAKepmajNz7TP_Z6p_Wj17tOpiMOpKkvQOBvVthBkEiKabAppjg@mail.gmail.com>
 <271989d5-c383-0c0d-bfcb-f4118f9fa2aa@web.de>
From:   Jack Adrian Zappa <adrianh.bsc@gmail.com>
Date:   Wed, 8 Feb 2017 12:11:29 -0500
Message-ID: <CAKepmagp2mXNviA2VdT=3EQtZi2LkA_5oG6=AbfkBGKP9Hqiiw@mail.gmail.com>
Subject: Re: Trying to use xfuncname without success.
To:     =?UTF-8?Q?Ren=C3=A9_Scharfe?= <l.s.r@web.de>
Cc:     git-mailing-list <git@vger.kernel.org>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: quoted-printable
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Thanks Rene, but you seem to have missed the point.  NOTHING is
working.  No matter what I put there, it doesn't seem to get matched.

Just to be sure, I tested your regex and again it didn't work.

Someone on the SO site stated they could get it to work on FreeBSD and
I'm on Windows, so this might be a platform thing.  Can anyone else on
Windows please confirm?

Thanks,


A

On Tue, Feb 7, 2017 at 6:18 PM, Ren=C3=A9 Scharfe <l.s.r@web.de> wrote:
> Am 07.02.2017 um 20:21 schrieb Jack Adrian Zappa:
>>
>> I'm trying to setup a hunk header for .natvis files. For some reason,
>> it doesn't seem to be working. I'm following their instructions from
>> here, which doesn't say much in terms of restrictions of the regex,
>> such as, is the matched item considered the hunk header or do I need a
>> group? I have tried both with no success. This is what I have:
>>
>> [diff "natvis"]
>>     xfuncname =3D "^[\\\t ]*<Type[\\\t ]+Name=3D\"([^\"])\".*$"
>
>
> The extra "\\" allow backslashes to be used for indentation as well as
> between Type and Name, which is probably not what you want.  And your
> expression only matches single-char Name attributes.  Try:
>
>         xfuncname =3D "^[\t ]*<Type[\t ]+Name=3D\"([^\"]+)\".*$"
>
> Ren=C3=A9
