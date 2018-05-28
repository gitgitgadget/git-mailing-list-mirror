Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-3.4 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,RCVD_IN_DNSWL_HI
	shortcircuit=no autolearn=ham autolearn_force=no version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 17DD31F42D
	for <e@80x24.org>; Mon, 28 May 2018 18:40:51 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S933486AbeE1Sks (ORCPT <rfc822;e@80x24.org>);
        Mon, 28 May 2018 14:40:48 -0400
Received: from mail-ot0-f195.google.com ([74.125.82.195]:46366 "EHLO
        mail-ot0-f195.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S933255AbeE1Skr (ORCPT <rfc822;git@vger.kernel.org>);
        Mon, 28 May 2018 14:40:47 -0400
Received: by mail-ot0-f195.google.com with SMTP id t1-v6so14337053ott.13
        for <git@vger.kernel.org>; Mon, 28 May 2018 11:40:47 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=mime-version:in-reply-to:references:from:date:message-id:subject:to
         :cc:content-transfer-encoding;
        bh=oMV9kCB2J9f/tAJE+Djsqu/2/Rq0kQWuytdfzNqp0ho=;
        b=lejWm8BYntAijFTulvEuQjBDspwvgSMCMLltOwHzvKRLm+Y1Ik8iTEejCT3fd/OX7C
         cpQDC20Gd0iwrfjU6mbtGktBKsJQjtTxAwRnv6FcUe2OifzNlKspUHLZevP1y2KpCGXA
         FGWJ8SvdQZiH7Cd2SZAO0G8JNtQHzI7xFsfKHjxy1BSnSctSzCbwT/yEXS+h5ayIcNBR
         czjpoJyLmBQNpKf77ha2syiEIIa/uNrLB/3tVJLoqkyg/7Q1H6hcwG+kPOCRpJwJgNPi
         M46IHvqeBXPxVvzC87GGJyvBEJS6QUD0xTcWtoGC4XuyDK5O3qJQND/BWn616xFywVZx
         oTFw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:in-reply-to:references:from:date
         :message-id:subject:to:cc:content-transfer-encoding;
        bh=oMV9kCB2J9f/tAJE+Djsqu/2/Rq0kQWuytdfzNqp0ho=;
        b=EhAVC+NXf/8ZBxfP5Ayqh+ID3s8cNxeatOv3Pe8J4iklrjIZ7z3S/jEIYyvMqK7Lxs
         vlZhhOMRbS3YvGrFx5TODOSPrHXxAGQ7U2qjeAXarBRgGcRpEQwkVqMO3E8bh10VGaob
         UJ9TWopDjcN+QtCrZ1ayTjrE6T6GUfGXojrbPjI8UPnTdh/Y/zR1G4pc/5gmJrx1HvtK
         K2aTCqb40YsC1ouDLB9/3PxCPd1S2HFlSrvCBxGetXX1AX+E1IzDgfKViMyD8gjIUEve
         bL64XgPj0b15LH/67vWm26HHbK7YC2/WkpiK/i2/EljN2IcNA94CsGAfSnAgN/KMNqpG
         NmfQ==
X-Gm-Message-State: ALKqPwdqBLR6UDS2x1G6wxsJ/iOSBs0HZ3xyYJbh6a5YOpZKQLhDE93+
        836y7LSIPsVRxybVU39bRMPfCenZo6Bdc2tQ+fU=
X-Google-Smtp-Source: ADUXVKL/TK+qVowHvfW2L3hmOwTwjyO3+0lNge43SYc08g/7E0AwcV5nqpFKQZBn04dQJFRmm4EDlv/DvmZX88Y3ncY=
X-Received: by 2002:a9d:2c94:: with SMTP id p20-v6mr4657825otb.14.1527532847112;
 Mon, 28 May 2018 11:40:47 -0700 (PDT)
MIME-Version: 1.0
Received: by 2002:a4a:b285:0:0:0:0:0 with HTTP; Mon, 28 May 2018 11:40:16
 -0700 (PDT)
In-Reply-To: <90ac0a41563f070a840076521d8935ad7c21beb9.1527279322.git.martin.agren@gmail.com>
References: <xmqq8t88nllj.fsf@gitster-ct.c.googlers.com> <cover.1527279322.git.martin.agren@gmail.com>
 <90ac0a41563f070a840076521d8935ad7c21beb9.1527279322.git.martin.agren@gmail.com>
From:   Duy Nguyen <pclouds@gmail.com>
Date:   Mon, 28 May 2018 20:40:16 +0200
Message-ID: <CACsJy8CZQLxU5TPx=M0NV_xTR_9qyjbOWnVcdX9-Tz+BCb24VA@mail.gmail.com>
Subject: Re: [RFC PATCH 1/3] usage: extract `prefix_suffix_lines()` from `advise()`
To:     =?UTF-8?Q?Martin_=C3=85gren?= <martin.agren@gmail.com>
Cc:     Git Mailing List <git@vger.kernel.org>,
        Junio C Hamano <gitster@pobox.com>,
        Jeff King <peff@peff.net>,
        Kaartic Sivaraam <kaartic.sivaraam@gmail.com>,
        =?UTF-8?B?w4Z2YXIgQXJuZmrDtnLDsCBCamFybWFzb24=?= <avarab@gmail.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

On Fri, May 25, 2018 at 11:00 PM, Martin =C3=85gren <martin.agren@gmail.com=
> wrote:
> advice.c contains a useful code snippet which takes a multi-line string
> and prints the lines, prefixing and suffixing each line with two
> constant strings. This was originally added in 23cb5bf3b3 (i18n of
> multi-line advice messages, 2011-12-22) to produce such output:
>
> hint: some multi-line advice
> hint: prefixed with "hint: "
>
> The prefix is actually colored after 960786e761 (push: colorize errors,
> 2018-04-21) and each line has a suffix for resetting the color.
>
> The next commit will teach the same "prefix all the lines"-trick to the
> code that produces, e.g., "warning: "-messages. In preparation for that,
> extract the code for printing the individual lines and expose it through
> git-compat-util.h.
>
> Signed-off-by: Martin =C3=85gren <martin.agren@gmail.com>
> ---
> I'm open for suggestions on the naming of `prefix_suffix_lines()`...

I think the important verb, print (to FILE*), is somehow missing. This
current name would be great if it produces another str(buf).
--=20
Duy
