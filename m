Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.2 (2018-09-13) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-3.9 required=3.0 tests=AWL,BAYES_00,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,RCVD_IN_DNSWL_HI
	shortcircuit=no autolearn=ham autolearn_force=no version=3.4.2
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 291C61F453
	for <e@80x24.org>; Mon, 11 Feb 2019 01:16:39 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726663AbfBKBQi (ORCPT <rfc822;e@80x24.org>);
        Sun, 10 Feb 2019 20:16:38 -0500
Received: from mail-qt1-f193.google.com ([209.85.160.193]:45616 "EHLO
        mail-qt1-f193.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726130AbfBKBQh (ORCPT <rfc822;git@vger.kernel.org>);
        Sun, 10 Feb 2019 20:16:37 -0500
Received: by mail-qt1-f193.google.com with SMTP id e5so10383554qtr.12
        for <git@vger.kernel.org>; Sun, 10 Feb 2019 17:16:37 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=luZgT0Kjdk6/gB0IXfV7GfUIV5KLl0UENdKWtm1y+h4=;
        b=KjCc5pcZ/7DFxwBIepmT6DYzUonLWoy6CdO9f/jNIcz2wwRDOt91Bh3W4jMdYLndLz
         PkRKjKsifAevPg1Fo7ZHpOV+HixqjvNItKztXYGQ8WYQHgl7ZLWN3Y12EcSfkYxHNsUY
         XrayJPueOzQyNZQmmoKdT5+cYRypN7DoeAJxdQ3ibvWtirnlqyOclWWtDC5A75iAyvhk
         mj3tBy9vMFg52MRlmlhB0nNPeE7iko3cWYbgTNkH9GDoWkh3g8sPZGRdZSr9URRd7q85
         gv2dc1ckFtplDzi4gPMXxUN4dzSL00S0auFiiGUBqfYgX0AnJbXsTbhMrnTGJxnPia9w
         fGoA==
X-Gm-Message-State: AHQUAuY5u+q6JRyEs7+JzKUJR40UwNMUKtor572Z2L5iP1oBFzuvnhWe
        MOhQNQeXhXufalOSNPBPlKisrGZ9UlpGicRwGmdzEg==
X-Google-Smtp-Source: AHgI3IZb9KUMJPIWLCu3H5R0uscs1FVFKURXvvPGP6/kwXLWhvEshz/FwrjIqJHVeYf2j+vGfFtP9oy9/xMy0xiAswE=
X-Received: by 2002:a0c:981b:: with SMTP id c27mr25757710qvd.184.1549847796910;
 Sun, 10 Feb 2019 17:16:36 -0800 (PST)
MIME-Version: 1.0
References: <20190209200802.277139-1-sandals@crustytoothpaste.net> <20190211002307.686048-1-sandals@crustytoothpaste.net>
In-Reply-To: <20190211002307.686048-1-sandals@crustytoothpaste.net>
From:   Eric Sunshine <sunshine@sunshineco.com>
Date:   Sun, 10 Feb 2019 20:16:26 -0500
Message-ID: <CAPig+cRTRCeGZ115gJGGNPtQ7WyFWg4Y45WOPec-8CmnG6ZRMQ@mail.gmail.com>
Subject: Re: [PATCH v2] utf8: handle systems that don't write BOM for UTF-16
To:     "brian m. carlson" <sandals@crustytoothpaste.net>
Cc:     Git List <git@vger.kernel.org>,
        Lars Schneider <larsxschneider@gmail.com>,
        Junio C Hamano <gitster@pobox.com>,
        =?UTF-8?Q?Torsten_B=C3=B6gershausen?= <tboegi@web.de>,
        Rich Felker <dalias@libc.org>, Kevin Daudt <me@ikke.info>
Content-Type: text/plain; charset="UTF-8"
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

On Sun, Feb 10, 2019 at 7:23 PM brian m. carlson
<sandals@crustytoothpaste.net> wrote:
> When serializing UTF-16 (and UTF-32), there are three possible ways to
> write the stream. One can write the data with a BOM in either big-endian
> or little-endian format, or one can write the data without a BOM in
> big-endian format.
> [...]
> Signed-off-by: brian m. carlson <sandals@crustytoothpaste.net>

Premature git-send-email invocation? The commit message of v2 seems to
be a bit different from v1, but the patch itself is identical.
