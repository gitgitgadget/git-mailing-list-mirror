Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.1 (2015-04-28) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-3.9 required=3.0 tests=AWL,BAYES_00,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,RCVD_IN_DNSWL_HI
	shortcircuit=no autolearn=ham autolearn_force=no version=3.4.1
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 42D6D1F453
	for <e@80x24.org>; Sun,  4 Nov 2018 17:42:38 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1731312AbeKEC4J (ORCPT <rfc822;e@80x24.org>);
        Sun, 4 Nov 2018 21:56:09 -0500
Received: from mail-qk1-f173.google.com ([209.85.222.173]:45221 "EHLO
        mail-qk1-f173.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1729529AbeKEC4I (ORCPT <rfc822;git@vger.kernel.org>);
        Sun, 4 Nov 2018 21:56:08 -0500
Received: by mail-qk1-f173.google.com with SMTP id d135so11041552qkc.12
        for <git@vger.kernel.org>; Sun, 04 Nov 2018 09:40:24 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=TpQBX+3H+qQGfKXLNCdbdEJTDr5Q5STDvrKBVunEA/g=;
        b=GCKzY2wwLIPKfHCiaZIH3rgbUidyGQzWJEiHog+kz6fOhuhyfX6QAgVLEjcq/KR1rV
         ne6RlLv47c8EUjCz2MgMof9x/T051ASdbTT+u3xDwwQHx+3/I/J+fcVYvSEDNMt9rE26
         EbPqutxaFM4kjAzkbo4bwfAeaY8W7UC0RUGqCGZPHACyURWiLGJi27kOO6Y89Kp8mlFI
         F5q0CKwSWY9snyJCUYPptNDr1vo2LKMpIZu76whjT5pXjOqiQI1mRGi2f4FkwURoGXjm
         BkqTtuXF0ksLrB5WX1jhV2CpLB6UXttO0n90JUcNX22sHgULrviBMVp3FjHBlB3HH+7z
         R0Tw==
X-Gm-Message-State: AGRZ1gISy31KrL5k5mj0bA2MGB0n0d1H5I5Z7LUxYesbdQxihWGGEnkh
        bQ+GGJ6xTTtgbNXSqjMnp62+/JMUzRZRlITkJt4=
X-Google-Smtp-Source: AJdET5eDOPmZ89fE0gHv7ks8+9ZO0rMM2sdYvndFwIPQzH4eha7pracUhrhXSQ1Y9zIeusEuqAL52UTvDHCRtPBAbA8=
X-Received: by 2002:ac8:592:: with SMTP id a18-v6mr18676145qth.184.1541353223778;
 Sun, 04 Nov 2018 09:40:23 -0800 (PST)
MIME-Version: 1.0
References: <20181028125025.30952-1-anders@0x63.nu> <20181104152232.20671-1-anders@0x63.nu>
In-Reply-To: <20181104152232.20671-1-anders@0x63.nu>
From:   Eric Sunshine <sunshine@sunshineco.com>
Date:   Sun, 4 Nov 2018 12:40:12 -0500
Message-ID: <CAPig+cSfwUJ8thYW+dq1qjT8X_f78DzAzfb_Xd3CMxO=9juz=w@mail.gmail.com>
Subject: Re: [PATCH v2 0/5] %(trailers) improvements in pretty format
To:     anders@0x63.nu
Cc:     Git List <git@vger.kernel.org>, Junio C Hamano <gitster@pobox.com>,
        Jeff King <peff@peff.net>,
        Olga Telezhnaya <olyatelezhnaya@gmail.com>
Content-Type: text/plain; charset="UTF-8"
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

On Sun, Nov 4, 2018 at 10:23 AM Anders Waldenborg <anders@0x63.nu> wrote:
> This adds support for three new options to %(trailers):
>  * key -- show only trailers with specified key
>  * nokey -- don't show key part of trailers
>  * separator -- allow specifying custom separator between trailers

If "key" is for including particular trailers, intuition might lead
people to think that "nokey" is for excluding certain trailers.
Perhaps a different name for "nokey", such as "valueonly" or
"stripkey", would be better.
