Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.2 (2018-09-13) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-3.9 required=3.0 tests=AWL,BAYES_00,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,RCVD_IN_DNSWL_HI
	shortcircuit=no autolearn=ham autolearn_force=no version=3.4.2
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id C55FB1F609
	for <e@80x24.org>; Wed, 28 Nov 2018 21:51:32 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726324AbeK2Iyd convert rfc822-to-8bit (ORCPT
        <rfc822;e@80x24.org>); Thu, 29 Nov 2018 03:54:33 -0500
Received: from mail-qk1-f176.google.com ([209.85.222.176]:39176 "EHLO
        mail-qk1-f176.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726307AbeK2Iyd (ORCPT <rfc822;git@vger.kernel.org>);
        Thu, 29 Nov 2018 03:54:33 -0500
Received: by mail-qk1-f176.google.com with SMTP id q70so17793790qkh.6
        for <git@vger.kernel.org>; Wed, 28 Nov 2018 13:51:30 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc:content-transfer-encoding;
        bh=xMLnO4goWoOH/9lPsZaOAC4kYr89BE3uv+oQ40MBI38=;
        b=WPV7DBjJtEylEilQxftb43gYBTCYlTLWaWmE4iv7GWswOahn+QJI9hxfg5KdHsUXs+
         SIk2USkFKRk9O77OnhBIRVlTaaGgydEWHxr3H6h6I8OYgBA/15YlUxMMDbz92D5o+vcl
         NEKODPJK96/fWeMGsRSfE39H010F7tV+IdMLQLaEohfK6Sk18bBDnynmxnBVeINQJW9o
         sbO4cdxruSEeWAL8mgqxhEpC/H88ceu5uFrrMlpns0QJV8mmkkfhKk4cz9RG5EoeGoyt
         bX7z3nrRUzQGXCFLOtgaB0dUP13D0JLNSYi7pZys5JMieeuXRdU18Z/VIO158kRxGQAl
         0YJQ==
X-Gm-Message-State: AA+aEWZlJTvoNGjG8OiwbPGAqcILzFiSK8jFM9T0YavBpqwC0O91LMEX
        Nn6iy9UOuLcX1paIZ0EOYeLnmPXoQ+dSkCJdCkrTQg==
X-Google-Smtp-Source: AFSGD/UeFPVP5pR9oezsoJuOnTkxF9aMb5p5bsOEv072TwbjzC+vM6+gyHPuuPQ6BgidLNAFMdCtIEWWxKldh9q1jQI=
X-Received: by 2002:a37:66c1:: with SMTP id a184mr35499984qkc.314.1543441890127;
 Wed, 28 Nov 2018 13:51:30 -0800 (PST)
MIME-Version: 1.0
References: <20181128214309.23523-1-jn.avila@free.fr>
In-Reply-To: <20181128214309.23523-1-jn.avila@free.fr>
From:   Eric Sunshine <sunshine@sunshineco.com>
Date:   Wed, 28 Nov 2018 16:51:19 -0500
Message-ID: <CAPig+cQpLipj6=A9PUV43+erZYTuQVUWZj1GqL8Od-K0Y1d_Xg@mail.gmail.com>
Subject: Re: [PATCH] i18n: fix small typos
To:     Jean-Noel Avila <jn.avila@free.fr>
Cc:     Git List <git@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: 8BIT
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

On Wed, Nov 28, 2018 at 4:43 PM Jean-Noël Avila <jn.avila@free.fr> wrote:
> Translating the new strings introduced for v2.20 showed some typos.

Hard to spot by eyeball when looking at the diff, but both fixes make
sense. Thanks.

> Signed-off-by: Jean-Noël Avila <jn.avila@free.fr>
