Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-2.8 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_HI,T_RP_MATCHES_RCVD
	shortcircuit=no autolearn=no autolearn_force=no version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 386EC1F406
	for <e@80x24.org>; Tue, 12 Dec 2017 14:08:27 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1753045AbdLLOIY (ORCPT <rfc822;e@80x24.org>);
        Tue, 12 Dec 2017 09:08:24 -0500
Received: from mail-qt0-f169.google.com ([209.85.216.169]:41537 "EHLO
        mail-qt0-f169.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1752685AbdLLOHr (ORCPT <rfc822;git@vger.kernel.org>);
        Tue, 12 Dec 2017 09:07:47 -0500
Received: by mail-qt0-f169.google.com with SMTP id i40so47409442qti.8
        for <git@vger.kernel.org>; Tue, 12 Dec 2017 06:07:47 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=mime-version:in-reply-to:references:from:date:message-id:subject:to
         :cc;
        bh=dpPOz1Kc1FJnVvXbBYfLMpQpAEbEab7mnqGrjfxxjPw=;
        b=TbXo26ani5ilV7GHwNhV9XQ11B0A4mSoYMhtF7x03V5O1nsAv5CXs7AN4e0nnn7f2/
         sg/UHFIuvWAS1fP4ZTqx9wdC8Hu5L6QTcPdzAo08T30A48Ck2GDrQLZ8zfP7c2kX59OY
         oK5chAYIh59Ls5Nx5l0O3z+XVycQ4Mqx8czG8bXh+lQc9piWAChzyoMDLDZfds6FjlA+
         lGj57mzMuhmDDjrG+3VHi4KpLAYNu0OzKLorwwxq3LbcuXBzBj/cBW1SXKkpaQkQWpmw
         dCh1VRE/gWtIPUU+fJY1xRYXoAxsZjJ4YRetqUe/6TXeWzMpIG44ye2bpOA7qSqCIJZC
         KEGQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:in-reply-to:references:from:date
         :message-id:subject:to:cc;
        bh=dpPOz1Kc1FJnVvXbBYfLMpQpAEbEab7mnqGrjfxxjPw=;
        b=ChSqKzYBtWSaGK8Q7MLC2vjFzOdBDRl3iA5hmLdEyIB8Onc2rj6uRTtkP/AfDQYFSo
         7pPYQiGim+7Y0tKqPI3F/SAC7DiPoccVEWt3SNkV24t0ryQrNOwANxGQhbe+OX3QlNuI
         YfdzZaEanlMG3sx0nYdF3IY6B17I75jEiOQGNVTgB83dVj79JJmqCQLkPYez+7aJ8iDi
         Gmxm7LViJM1ciKf0pbZksSpVuk8akjQXXgNudB9ZXPbGYRsWZDBcx+iZJ0WMFp0hd0yI
         L7lEqSq39+ndutCV6lljoY7dLKdvTiSTA6cOLPdCmhuEVq+zi/HP7yWpArvRwQW8hztE
         wM8w==
X-Gm-Message-State: AKGB3mIj8lOhLcXOe/jQrl7MUtgGDayVQt1X+/Wez97JGH2+S0txBXgN
        5jJgZN52iOxo9rOQXMl6VT5xrmhS+ByPHJW1ReVJuA==
X-Google-Smtp-Source: ACJfBoufsl+KeB6X/mhtK4GwGfwl1J7p8BS0Q+aQCO0L4vR6BHdCNBFFbHDT2XPVTZr48Yq4v4NU057ui7UzM0YrMPw=
X-Received: by 10.55.99.214 with SMTP id x205mr5657645qkb.34.1513087667206;
 Tue, 12 Dec 2017 06:07:47 -0800 (PST)
MIME-Version: 1.0
Received: by 10.200.16.154 with HTTP; Tue, 12 Dec 2017 06:07:46 -0800 (PST)
In-Reply-To: <20171112161617.fhysws3idztguu23@sigill.intra.peff.net>
References: <1510423606-9616-1-git-send-email-gs051095@gmail.com>
 <20171112095435.f4o662ygtt2taf5y@sigill.intra.peff.net> <CAOCi2DGYQr4jFf5ObY2buyhNJeaAPQKF8tbojn2W0b18Eo+Wgw@mail.gmail.com>
 <20171112161617.fhysws3idztguu23@sigill.intra.peff.net>
From:   =?UTF-8?B?0J7Qu9GPINCi0LXQu9C10LbQvdCw0Y8=?= 
        <olyatelezhnaya@gmail.com>
Date:   Tue, 12 Dec 2017 17:07:46 +0300
Message-ID: <CAL21BmmF2=+UVnuVZprn0vKh+PP=wz3QpH_=AOfUsY9K0AfWzA@mail.gmail.com>
Subject: Re: [PATCH] mru: Replace mru.[ch] with list.h implementation
To:     Gargi Sharma <gs051095@gmail.com>
Cc:     git <git@vger.kernel.org>, Jeff King <peff@peff.net>
Content-Type: text/plain; charset="UTF-8"
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Gargi,
If you have some difficulties - please feel free to ask questions
(here or you can write me directly). I will be happy to help you.
As I understand, you are super close to finish your first patch.

Olga
