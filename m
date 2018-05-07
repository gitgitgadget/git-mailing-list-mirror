Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-3.4 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,RCVD_IN_DNSWL_HI
	shortcircuit=no autolearn=ham autolearn_force=no version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 28133200B9
	for <e@80x24.org>; Mon,  7 May 2018 15:29:29 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1752342AbeEGP31 (ORCPT <rfc822;e@80x24.org>);
        Mon, 7 May 2018 11:29:27 -0400
Received: from mail-ot0-f194.google.com ([74.125.82.194]:39991 "EHLO
        mail-ot0-f194.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1752007AbeEGP3Z (ORCPT <rfc822;git@vger.kernel.org>);
        Mon, 7 May 2018 11:29:25 -0400
Received: by mail-ot0-f194.google.com with SMTP id n1-v6so32441799otf.7
        for <git@vger.kernel.org>; Mon, 07 May 2018 08:29:25 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=mime-version:in-reply-to:references:from:date:message-id:subject:to
         :cc;
        bh=1tB5nZ8MX9D2J4CCIRuIxkLkPkIm6r8uya+6ZxzEpgE=;
        b=osZvdX0qCmopXewyYvo37+rgGGB2hVzpvogkyFavotM/DRLbQViR4k9l6VzZW+g19Y
         Vc4QYMHt1QyNSRUu9oTkY+QM/XHxDUfDSk+RlPPT5FbFkncxQQIJ7UWSM5UmeG6GOy7b
         Eqwa9PAWii7nD7rEeQhQIAG7G9Kc3RRKIxZy0jIg7bl7wNNEJJSFakB8hWYATiN8gkQ/
         OkkHzO8fICgRcPX/pySUsyVlIzA7p0iI/P1t6mwrLvheazkZMk4ukS4S1k/skTZJOPiZ
         Rr3YNqJJAO/MXFmkPZC5/GOoVATM3D+Ti6uj3kzStYVnK8pGD8MTG02oA7I8EUJSTTKo
         IeZQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:in-reply-to:references:from:date
         :message-id:subject:to:cc;
        bh=1tB5nZ8MX9D2J4CCIRuIxkLkPkIm6r8uya+6ZxzEpgE=;
        b=cXQO9K7seB2CqbCwgX5rwnBpkobNXrzwIQIpkuSTZVKi19MSvy3EmTRVpJ3+ahvaZk
         lf7J4K6xSs4TpmJa8DrLx2dJR+ei9nYDwDhdzm7yOL36mhC4Bn8E1n5QkEh3sjihoaGc
         +4PJIhHG8VnsgQuyBsabWZlkQmAAdNKXH2G9czPorQltVZWXy6oaYc1p3XGEOieEnb6P
         hGnenRjjDri3JVnUHcG+FadIsdkf4D+gbPyBJO0R6q0tsl92ystK6btUQA2r73HmzR12
         kQVr0N3eLlq/XpvUUSHFe+R1srjTvxOQ02h5vKjZ7ghwuPSdhcR3ltdlIqpVSeSmHSyp
         zT2A==
X-Gm-Message-State: ALQs6tBnVAwQaWfb+GsZVXbt7DzNfDSUf3Okqjg3hEiLYAFsvMvZDWKC
        FO9EIIdoVdC67SbdMnHkLnLwugCwGeoEm0oDfm8=
X-Google-Smtp-Source: AB8JxZqHIe2+AYGREwV2PqLArgEfyMX2vq4BpYx3w6vGRaRYUbwU8RChSCBSyGWfE7Q24XiUtEw6oM1X3YM795ojGFM=
X-Received: by 2002:a9d:c61:: with SMTP id 88-v6mr18318958otr.173.1525706965458;
 Mon, 07 May 2018 08:29:25 -0700 (PDT)
MIME-Version: 1.0
Received: by 10.74.178.133 with HTTP; Mon, 7 May 2018 08:28:54 -0700 (PDT)
In-Reply-To: <20180507075006.GD31170@sigill.intra.peff.net>
References: <cover.1525361419.git.johannes.schindelin@gmx.de>
 <cover.1525448066.git.johannes.schindelin@gmx.de> <a1ea0320b64527ee6ce9856dcf359513d13052b7.1525448066.git.johannes.schindelin@gmx.de>
 <20180505182631.GC17700@sigill.intra.peff.net> <nycvar.QRO.7.76.6.1805052355190.77@tvgsbejvaqbjf.bet>
 <20180507075006.GD31170@sigill.intra.peff.net>
From:   Duy Nguyen <pclouds@gmail.com>
Date:   Mon, 7 May 2018 17:28:54 +0200
Message-ID: <CACsJy8DabOE_6BKorQmO=E9m5QBbXW2hKLswiZ21Qg9z7H++cg@mail.gmail.com>
Subject: Re: [PATCH v2 02/18] Add a new builtin: branch-diff
To:     Jeff King <peff@peff.net>
Cc:     Johannes Schindelin <Johannes.Schindelin@gmx.de>,
        Git Mailing List <git@vger.kernel.org>,
        Junio C Hamano <gitster@pobox.com>,
        Thomas Rast <tr@thomasrast.ch>,
        Thomas Gummerer <t.gummerer@gmail.com>,
        =?UTF-8?B?w4Z2YXIgQXJuZmrDtnLDsCBCamFybWFzb24=?= <avarab@gmail.com>,
        Ramsay Jones <ramsay@ramsayjones.plus.com>,
        Stefan Beller <sbeller@google.com>,
        Jacob Keller <jacob.keller@gmail.com>,
        Eric Sunshine <sunshine@sunshineco.com>
Content-Type: text/plain; charset="UTF-8"
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

On Mon, May 7, 2018 at 9:50 AM, Jeff King <peff@peff.net> wrote:
> On Sat, May 05, 2018 at 11:57:26PM +0200, Johannes Schindelin wrote:
>
>> > It feels really petty complaining about the name, but I just want to
>> > raise the point, since it will never be easier to change than right now.
>>
>> I do hear you. Especially since I hate `git cherry` every single time that
>> I try to tab-complete `git cherry-pick`.
>
> Me too. :)

Just so you know I'm also not happy with that "git cherry". Since I'm
updating git-completion.bash in this area and we got 3 "me too" votes
(four if we count Szeder in another thread), I'm going to implementing
something to at least let you exclude "cherry" from the completion
list if you want.
-- 
Duy
