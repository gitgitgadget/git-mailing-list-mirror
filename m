Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-3.7 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_HI,T_RP_MATCHES_RCVD
	shortcircuit=no autolearn=no autolearn_force=no version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 0AEC81F576
	for <e@80x24.org>; Mon, 29 Jan 2018 09:48:04 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1751297AbeA2JsB (ORCPT <rfc822;e@80x24.org>);
        Mon, 29 Jan 2018 04:48:01 -0500
Received: from mail-oi0-f45.google.com ([209.85.218.45]:41801 "EHLO
        mail-oi0-f45.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1750913AbeA2JsA (ORCPT <rfc822;git@vger.kernel.org>);
        Mon, 29 Jan 2018 04:48:00 -0500
Received: by mail-oi0-f45.google.com with SMTP id m83so4592880oik.8
        for <git@vger.kernel.org>; Mon, 29 Jan 2018 01:48:00 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=mime-version:in-reply-to:references:from:date:message-id:subject:to
         :cc;
        bh=J/OQoX07u0hvZxcLwVlMhzBJbNQZ4egqR9UG0PDsmXE=;
        b=CHh6TZ5iAuoSnHqJV50iICJv6+1gtLptGbfwhmrbNgZFxZxRDcXo+oOopylseXUJnZ
         ZPFXfxRjg3W0fZo88PbYaDsK0vzWpj+wJVYktF4dkx7eU+GryGR5KGoBtWqurc/sOCdD
         lHdAOiTjZzfhHZgkk92Dd4Df0ZOYcK1Q9W31Y1gT3PLKK7pKoydmD5r68bwZ6j0wgxyY
         i7JXn6X9ax0A57muVR8SUff5W7lmkwu2yrhpTFDw21M75KzNapkxlkiRyH7f3BFUjK22
         4tQRRhSsG4bMGeyAtu8DS6vGnxzmPpLcYQ/13iJTNFZrTzk6fcoRuMae7jWR3fcou5jh
         Pv/g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:in-reply-to:references:from:date
         :message-id:subject:to:cc;
        bh=J/OQoX07u0hvZxcLwVlMhzBJbNQZ4egqR9UG0PDsmXE=;
        b=VZxB3vTEPf1mU2u1n7QgbCYUFBaUJX7IJZFfslULyXQzHFvmHp0kEFfkVrQNgWd3bo
         qCfe34CEQ5Hd/+W0A/8/Llug/YK5xe9aidY6eCPL+piYVd8anP77UYpfysXzLcIJPnXI
         9fX+mia5yfFdkqclXmsUEWhu6BZrAaxqjks2+MwCdScdS0jy2MSSseZyg+2ZK0m1k9dt
         TmFzMutVoCi7vfzBcivqL1WMK8vaTkTebbTlnpf79MFBLgejN1+TK7x/kANt0kBbwnPM
         rg/SgVxdgMwE4t1zkNgPAGXoM34Mu9Dg74bzFzUcmKuPj3AhkjyqDJ33/KOw5LiMg/TJ
         AWBg==
X-Gm-Message-State: AKwxyteITB4Ga4diaYwc+iNxLhfP0yXlJeY76fA7PCOR/kH58xZgysuf
        LsB6suED66Pev/j1FnShkoPoYIpbqFY4DiWgCeg=
X-Google-Smtp-Source: AH8x225u4P2uOIl469cWV3jkH7mre/L1DBrBU+5Net233Y/X7DwHxG1MU6wu9Xf4ArsK0ZbczUhi7+WhE9RtsRMjNvU=
X-Received: by 10.202.49.73 with SMTP id x70mr2098870oix.351.1517219280441;
 Mon, 29 Jan 2018 01:48:00 -0800 (PST)
MIME-Version: 1.0
Received: by 10.74.102.205 with HTTP; Mon, 29 Jan 2018 01:47:30 -0800 (PST)
In-Reply-To: <nycvar.QRO.7.76.6.1801291031040.35@ZVAVAG-6OXH6DA.rhebcr.pbec.zvpebfbsg.pbz>
References: <nycvar.QRO.7.76.6.1801291031040.35@ZVAVAG-6OXH6DA.rhebcr.pbec.zvpebfbsg.pbz>
From:   Duy Nguyen <pclouds@gmail.com>
Date:   Mon, 29 Jan 2018 16:47:30 +0700
Message-ID: <CACsJy8Dgn=Yu+Aw8_YLKiNLSji0O+QOH3Kq-M3pUb2pnpi2ifw@mail.gmail.com>
Subject: Re: Shawn Pearce has died
To:     Johannes Schindelin <Johannes.Schindelin@gmx.de>
Cc:     Git Mailing List <git@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

On Mon, Jan 29, 2018 at 4:33 PM, Johannes Schindelin
<Johannes.Schindelin@gmx.de> wrote:
> Hey fellow gitters,
>
> I found these sad news in my timeline today:
>
> https://twitter.com/cdibona/status/957822400518696960
>

At first I didn't believe the subject line I just read. So sorry to
hear this. Thanks Shawn for all the contributions you made in git and
libgit2.
-- 
Duy
