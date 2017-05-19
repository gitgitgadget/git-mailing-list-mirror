Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-2.6 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_HI,RCVD_IN_MSPIKE_H3,
	RCVD_IN_MSPIKE_WL,RCVD_IN_SORBS_SPAM,RP_MATCHES_RCVD shortcircuit=no
	autolearn=no autolearn_force=no version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id D15B92021E
	for <e@80x24.org>; Fri, 19 May 2017 15:22:02 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1754392AbdESPWA (ORCPT <rfc822;e@80x24.org>);
        Fri, 19 May 2017 11:22:00 -0400
Received: from mail-ua0-f178.google.com ([209.85.217.178]:34096 "EHLO
        mail-ua0-f178.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1751626AbdESPV7 (ORCPT <rfc822;git@vger.kernel.org>);
        Fri, 19 May 2017 11:21:59 -0400
Received: by mail-ua0-f178.google.com with SMTP id u10so27855224uaf.1
        for <git@vger.kernel.org>; Fri, 19 May 2017 08:21:59 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=mime-version:in-reply-to:references:from:date:message-id:subject:to
         :cc:content-transfer-encoding;
        bh=RS5V6jWbAidxQNdvKJfEcL1KZNiQiR6g6oM9pru99qk=;
        b=Z9Ps6CZaLgIGfLu77MoUaibyEPOrQ6NvuULESlErRftYjYS60HH8xAch8dAa/NH/1r
         IFdHKK3kTxH4XALUa6CKEuiLDbXujSzUdu8CXOdYYYUggwsKcJSD4P4JbXzddOZH+CEB
         SMzbigNC9x6pVtI4Z1QRrTtfX3btrBU5F0u14KODCD3BmhivjCCjZsI3wucSvF7gCU+1
         zrKatZaqPRcEHFE4kx3T0sxEO+hNW29jnp7FZkAfjKIRU3P/++CIVZqHSuXzlRRe5tJZ
         TL1uJ5tcIAoMOZX1Y/oO7V4MS8s/fJ+duM8omsrk7V8z926yBkWSlW6cfo/PO07G1WcZ
         pL0Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:in-reply-to:references:from:date
         :message-id:subject:to:cc:content-transfer-encoding;
        bh=RS5V6jWbAidxQNdvKJfEcL1KZNiQiR6g6oM9pru99qk=;
        b=bP6gNjTiZa2KzGSXOOt36QJ0NXs1rCBp8nk4rxof5uoi3DWBWAObIcO36hILVKmjD3
         ZoxcB/XO84jAcLzFJNUk0NcDEL62GFNcTe8OqFLa0RxeOqGufj5oBESmyBmecFIMaDiY
         KrnfmsS028mutERM0uCfGWexpm2Ol5s19JppAQiZrOQPEEnMYAfZIZLX3fyBfNptUIRO
         IjoYutnudlLxB3wsrgwWcz5xiQ7aBfxzHoikmm1Ls/W9BZwRmPPEB/OtUcv0kwbpXpvq
         xafia52CsgoLwYAMv2OtO83uYDCNP/gR4NhfkTTEO46h/iZ8MNBFy2hW9DKlRPOJ8TQt
         OW6A==
X-Gm-Message-State: AODbwcBcImLe35UxLZoEIUSOytBr4utJVl+CJ4qSBX+ztEwX+EINJZt/
        Q72eySrBI4QfGdBSTrLHefT8qvtaKQ==
X-Received: by 10.176.25.15 with SMTP id v15mr4953526uag.81.1495207318502;
 Fri, 19 May 2017 08:21:58 -0700 (PDT)
MIME-Version: 1.0
Received: by 10.159.54.233 with HTTP; Fri, 19 May 2017 08:21:58 -0700 (PDT)
In-Reply-To: <20170518155956.ecti4audvrqlj3pt@sigill.intra.peff.net>
References: <CAP96LmMtfO5DC6hGeqJdZvcqj+29H_7=8S+uua8YC7YwFRC9Nw@mail.gmail.com>
 <20170518155956.ecti4audvrqlj3pt@sigill.intra.peff.net>
From:   =?UTF-8?Q?Andr=C3=A9_Werlang?= <beppe85@gmail.com>
Date:   Fri, 19 May 2017 12:21:58 -0300
Message-ID: <CAP96LmN6zXEiRA+gMJoM4MhFDWhfMpUGszvthaRTuAT_RhXpTw@mail.gmail.com>
Subject: Re: [PATCH] doc: explain default option for rev-parse --short
To:     Jeff King <peff@peff.net>
Cc:     git@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Hey Jeff, I'll take a look at improving the text and the other commands.

Thanks for the response. I'll get back to you soonish.

Andr=C3=A9

2017-05-18 12:59 GMT-03:00 Jeff King <peff@peff.net>:
> On Thu, May 18, 2017 at 11:03:00AM -0300, Andr=C3=A9 Werlang wrote:
>
>> Git 2.11 introduced a computation to guess the default length
>> for commit short hashes. The documentation isn't updated.
>
> Thanks for the patch. I think this is going in the right direction, but
> I have a few minor comments.
>
>> From 2b1c229153a89c7608e64b87d2f933704c18b7ae Mon Sep 17 00:00:00 2001
>> From: =3D?UTF-8?q?Andr=3DC3=3DA9=3D20Werlang?=3D <beppe85@gmail.com>
>> Date: Thu, 18 May 2017 10:50:11 -0300
>> Subject: [PATCH] doc: explain default option for rev-parse --short
>> MIME-Version: 1.0
>> Content-Type: text/plain; charset=3DUTF-8
>> Content-Transfer-Encoding: 8bit
>
> These headers are redundant with what's in your email headers and can be
> dropped.
>
>> diff --git a/Documentation/git-rev-parse.txt b/Documentation/git-rev-par=
se.txt
>> index 7241e96..b49f053 100644
>> --- a/Documentation/git-rev-parse.txt
>> +++ b/Documentation/git-rev-parse.txt
>> @@ -139,8 +139,10 @@ can be used.
>>  --short::
>>  --short=3Dnumber::
>>   Instead of outputting the full SHA-1 values of object names try to
>> - abbreviate them to a shorter unique name. When no length is specified
>> - 7 is used. The minimum length is 4.
>> + abbreviate them to a shorter unique name. When no length is specified,
>> + it is guessed from the number of objects in the repository. In any cas=
e,
>> + the actual length will be enough to identify the object unambiguously
>> + in the current state of the repository. The minimum length is 4.
>
> This is definitely an improvement, though I wonder if we should mention
> that we default to core.abbrev (which in turn defaults to the "auto"
> behavior).
>
> It looks like there are a few other mentions of "7" with respect to
> "--abbrev": git-branch.txt, git-describe.txt, git-blame.txt. Those
> should probably get the same treatment.
>
> There are a few other "--abbrev" options (e.g., ls-files and ls-tree)
> that don't mention "7". But while we're fixing the others, it may be
> worth giving them all consistent text.
>
> -Peff



--=20
Andr=C3=A9 Werlang
