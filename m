Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-2.6 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_HI,RCVD_IN_SORBS_SPAM,
	RP_MATCHES_RCVD shortcircuit=no autolearn=no autolearn_force=no version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 4698E2027C
	for <e@80x24.org>; Thu,  1 Jun 2017 11:16:55 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1751587AbdFALQx (ORCPT <rfc822;e@80x24.org>);
        Thu, 1 Jun 2017 07:16:53 -0400
Received: from mail-it0-f54.google.com ([209.85.214.54]:35181 "EHLO
        mail-it0-f54.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1751556AbdFALQw (ORCPT <rfc822;git@vger.kernel.org>);
        Thu, 1 Jun 2017 07:16:52 -0400
Received: by mail-it0-f54.google.com with SMTP id f72so33900257ite.0
        for <git@vger.kernel.org>; Thu, 01 Jun 2017 04:16:52 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=mime-version:in-reply-to:references:from:date:message-id:subject:to
         :content-transfer-encoding;
        bh=vH4o2cK4TgRiqvW6F6HSLmGfoFuyWd/UKfpseBWUwEM=;
        b=lr2qtr1fPqEr0URRMFGXlGXMf9DqXGs5A7BCLhl0sPx4T6QT+44lA/9uHpsvtwm5IM
         iAcD+IwonOfQjn9XRjSJdvVNlWsR6zXaE5GfkZzBrtihqlRszhQlIgiwK18HVAjT5QEQ
         ARkh72jiS264EAnqZ1ah87l+4LBO3e6tL8N8Z/6rQLUgvFZWvNDFDFYLL7POhPByOMEK
         Da1D7jFY5YzDDhkSY5cO6hBengzPU2mXZUrAvEf8PmzIqXyFMKQb9dSBgiZT0D7Qkio5
         vIP6lns0P/0iwLaFIn8+uihMNSLhlIea7eW/LjWcmAi1DXSAQ4/rYStpAZYkqCh15kxC
         bWQQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:in-reply-to:references:from:date
         :message-id:subject:to:content-transfer-encoding;
        bh=vH4o2cK4TgRiqvW6F6HSLmGfoFuyWd/UKfpseBWUwEM=;
        b=Z/VoFI3y3x7aZANH9z3FvhFmBGpVSkB/TM742JbXCkR9nb4bvqK4DCwuNFa7qvEiD9
         8DxFHEWm+PvzLdMR3Ruygd2oHB9LOfSoxCiWi5U3d9I24uAFudDEcyhEM03ATB+416N9
         9eP/kv4FVpg4e4iiIDmjdleHDi+ofo0rn2ZPTfd6G0qwG1CCHBgEfSauIQ14Ot6bzjxG
         5QpUOh9G+hHlNRmH1CTTX5XwZJo2vvpwUB6LOT0jZ28tf59Y+6kQZoE1uN4XMaJLd4vV
         CmQnb1dpK5Wl3b681G2t5gD4PZMK+NRI5K7hag4YuOINsYis5g7gXaIV7doZNQsZ99G9
         PNxA==
X-Gm-Message-State: AODbwcDkfK3Vvef1swDIu1v/qtScmU0E+8M1eQc7LXRLUymNjLl2hnRj
        QMsuKtdbBIwP/gsY+YmhFJZk6mgo/A==
X-Received: by 10.36.222.69 with SMTP id d66mr13384876itg.14.1496315811472;
 Thu, 01 Jun 2017 04:16:51 -0700 (PDT)
MIME-Version: 1.0
Received: by 10.107.5.13 with HTTP; Thu, 1 Jun 2017 04:16:11 -0700 (PDT)
In-Reply-To: <CAMOGhMJyO=+EZz6qCejxeTe5FdE=RheJX9A5g3U6eKhUKj8_BQ@mail.gmail.com>
References: <CAMOGhMJyO=+EZz6qCejxeTe5FdE=RheJX9A5g3U6eKhUKj8_BQ@mail.gmail.com>
From:   SJR <haltekx@gmail.com>
Date:   Thu, 1 Jun 2017 13:16:11 +0200
Message-ID: <CAMOGhMLMo82RgH0HareB78KVWz2gMGzhB1i5s3SobW9wHk0zbg@mail.gmail.com>
Subject: Re: wrong language translation part7
To:     git@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

W dniu 1 czerwca 2017 09:43 u=C5=BCytkownik SJR <haltekx@gmail.com> napisa=
=C5=82:
>
> Hi,
>
> https://git-scm.com/book/pl/v1/Dostosowywanie-Gita-Konfiguracja-Gita
>
> part in polish part in english.
>
> Can You repair translation?
>
> Regards,
> JanR
