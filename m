Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-3.1 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_HI,RP_MATCHES_RCVD
	shortcircuit=no autolearn=ham autolearn_force=no version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 4F404207B3
	for <e@80x24.org>; Fri,  5 May 2017 21:07:17 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1755323AbdEEVHO (ORCPT <rfc822;e@80x24.org>);
        Fri, 5 May 2017 17:07:14 -0400
Received: from mail-io0-f175.google.com ([209.85.223.175]:35152 "EHLO
        mail-io0-f175.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1753123AbdEEVHN (ORCPT <rfc822;git@vger.kernel.org>);
        Fri, 5 May 2017 17:07:13 -0400
Received: by mail-io0-f175.google.com with SMTP id f102so22638442ioi.2
        for <git@vger.kernel.org>; Fri, 05 May 2017 14:07:13 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=mime-version:in-reply-to:references:from:date:message-id:subject:to
         :cc:content-transfer-encoding;
        bh=7uWlvH2NVZ6MQs8Z6L9kWHx5o0xxxLjeOyrmKHwhS+0=;
        b=df3ZscREzU/czOmnYDv8Q5zcl6fBTZ13cGKrDMmICU/Tu3C4mvmGRCvIm0vluu69Jg
         2b9aWcxa6A42FJeTi7w+s/9Tj8YKTLNQ0P44AoVCGSKUZ10uhEMNxMiIN0bzBKbFoHXx
         jBe6MHZYBWW3asM9M6NiBQFqVYAq47sGrs3ppB9Nx4SQsNOlX2IDBxJ7cRbgXhUthWMp
         USQugqBxaKJBhlIrHPl/fSOrRbqgamyhaAZ4WjaI7mGn/tg6m0w3YLflzIkXfyL2JOZC
         CqtiyHapy0C69DnAmmfGiHx4NaeSQ9YOue3yPZdRAvoC8Tzv+EW3bSP6Zp1qUfawRbB/
         97eA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:in-reply-to:references:from:date
         :message-id:subject:to:cc:content-transfer-encoding;
        bh=7uWlvH2NVZ6MQs8Z6L9kWHx5o0xxxLjeOyrmKHwhS+0=;
        b=qy7c8AJANOlM6bhAQgf3D/pVOwEFjSD4r1zeELjwWf1J3ehX4xvqraxR81Zz6G3zDt
         B6o6xm7luYYAd9g2RayVrG2IksMTJj48lflMFEg4S/G0vPhj9L1EIa3HYxoGeM3Vkgf6
         H7+mQiHV+lgkHcvjciKHG/7AFXN8NHoDjCiXXS2z1a7dtjFcId42E4mpoVACVYZixa2z
         j6DFO8xcGyrmz0pomIpYzuqDeT0b9QlJ7UWThUWyMnLAOqqaLJzijlnV3/anuRSBVtJw
         Bi3kvlsyuhpznjz5MdjMH2YbZBvooLCsMJcAgrczjGhzAr8kYSnte8LnQk3QAHIHMxkq
         K04Q==
X-Gm-Message-State: AODbwcAlfdR+D8ZNZGUjskI5qtonI2/ZM5T9eseehEaKtIwSmetpW2+6
        cBLYn1+h4ZT3BdD1ScIXOc29UXdIJQ==
X-Received: by 10.107.35.75 with SMTP id j72mr4549775ioj.180.1494018433065;
 Fri, 05 May 2017 14:07:13 -0700 (PDT)
MIME-Version: 1.0
Received: by 10.79.150.90 with HTTP; Fri, 5 May 2017 14:06:32 -0700 (PDT)
In-Reply-To: <CACBZZX7Q36rFiO9SwBCzM2M3ae=vOPJ2dfaVQ6=geZLgkLAuWA@mail.gmail.com>
References: <86bmr7xuy9.fsf@local.lan> <CACBZZX7Q36rFiO9SwBCzM2M3ae=vOPJ2dfaVQ6=geZLgkLAuWA@mail.gmail.com>
From:   Samuel Lijin <sxlijin@gmail.com>
Date:   Fri, 5 May 2017 16:06:32 -0500
Message-ID: <CAJZjrdVSX_HB0O_eiQk6bg_UF0=71PNVa1rBwSbpHFCbOrpAOQ@mail.gmail.com>
Subject: Re: How to `git status' without scrambling modified with new, etc
To:     =?UTF-8?B?w4Z2YXIgQXJuZmrDtnLDsCBCamFybWFzb24=?= <avarab@gmail.com>
Cc:     Harry Putnam <reader@newsguy.com>,
        Git Mailing List <git@vger.kernel.org>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: quoted-printable
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

On Fri, May 5, 2017 at 9:24 AM, =C3=86var Arnfj=C3=B6r=C3=B0 Bjarmason
<avarab@gmail.com> wrote:
> On Fri, May 5, 2017 at 4:02 PM, Harry Putnam <reader@newsguy.com> wrote:
>> This is probably what everyone sees:
>>
>> When I run `git status'; I see  modified and newfiles scrambled together
>>
>> Is there a trick or technique to make that output show each category
>> separately?

You can use `git status -s` and match on the modification type (M
corresponds to modified, A to new files). See the man page for more
details on the interface.

>> Or do folks just a throw a `sort' in there (git status|sort) and lose
>> the color ouput?
>
> If you set color.ui=3Dauto it'll disable coloring when it detects that
> the output isn't to a terminal, i.e. being piped.
>
> It sounds like you want:
>
>     git -c color.ui=3Dalways status --short|sort
>
> But there's no native option to sort the status output, but that'll do
> it for you.
