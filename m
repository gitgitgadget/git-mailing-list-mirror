Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.2 (2018-09-13) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-3.9 required=3.0 tests=AWL,BAYES_00,DKIM_INVALID,
	DKIM_SIGNED,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,
	RCVD_IN_DNSWL_HI shortcircuit=no autolearn=ham autolearn_force=no
	version=3.4.2
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id C033A20248
	for <e@80x24.org>; Tue,  5 Mar 2019 23:44:24 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728592AbfCEXoY (ORCPT <rfc822;e@80x24.org>);
        Tue, 5 Mar 2019 18:44:24 -0500
Received: from mail-wr1-f68.google.com ([209.85.221.68]:39030 "EHLO
        mail-wr1-f68.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1728370AbfCEXoX (ORCPT <rfc822;git@vger.kernel.org>);
        Tue, 5 Mar 2019 18:44:23 -0500
Received: by mail-wr1-f68.google.com with SMTP id l5so11347659wrw.6
        for <git@vger.kernel.org>; Tue, 05 Mar 2019 15:44:22 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=sender:from:to:cc:subject:references:date:in-reply-to:message-id
         :user-agent:mime-version;
        bh=d31X5nQoSeRwojObUFLagjAK+VOHPBuBboN9ahktgyg=;
        b=jPGSv3LhbiO+qatD3mwGNI7iKP5WVmSePOlFgO+KLNbDsNXqJjyEp6wJVCg+co3yey
         sVdK8a7fS2wMS61mj42T1wgOxlEIOtlTag36Pj3T+bnOSUETx+jK2Ld4pDYMDjQOAVGX
         R2MGeeQzKto5YfuVqNSc2gJxnnALz2X+/s/FWP8NKUE7ea4BqljfLC8Sr7lNnS+v+sXx
         q+NfgSEbB/irL4WIhNVWDBzRyEjuVZ4xRQ0ccbGVatmYwDSQ4b0QA41rU6N3A01VBGKu
         EDk2Q0U3ENnOtjNB8ZR/NVRSlR3iVKFSqQNPOHuPZfyzduBH3ehyNeYtG6ab2plNzgKI
         TZAA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:sender:from:to:cc:subject:references:date
         :in-reply-to:message-id:user-agent:mime-version;
        bh=d31X5nQoSeRwojObUFLagjAK+VOHPBuBboN9ahktgyg=;
        b=p+zuqfAjiy/Xbq03gKdDnT9ZiAu7HNbRzriMiZqAN3BhG0POC6Fwt31f7u1dLzgzK2
         BSiekH81+IhDeXZJWrcimOIULGwJ2u5fUfP8mfME3XZtzzosx7M/FWtXN1Tg0gc/VNDk
         NawBGG/855VHMMKfoerPpgnmvjzhgC9kVln5S3f/LWhALpn/40OAPfJByqyKHH1qjuUF
         m1fmP0qCkgLb6ewF2joJ2nQO0cXpfCFc1j/T0Ya4O8zHc+grFQTAef2KMTzhDZh5fthA
         v9DmSH27DocBKmj2/4GBtPGeFVCn8/GT0g2Jq5vfAV20wilcw8lB3xB+1aEh9W/ZpESB
         Nxnw==
X-Gm-Message-State: APjAAAVHbIG6kWeIg4PRfVsUodXziTyYYPcauOIcoqaz8lFA6qS2tR9W
        9bAYk8MORPebt3F2Xlt2/ks=
X-Google-Smtp-Source: APXvYqz20nzD6l8QQV78pRpwdjvePTJmiZ21WuY5klqD9iw5z3j3jXf+2MP4ov8Kqjv2mjdAQNZg7w==
X-Received: by 2002:a5d:4887:: with SMTP id g7mr847841wrq.51.1551829461400;
        Tue, 05 Mar 2019 15:44:21 -0800 (PST)
Received: from localhost (112.68.155.104.bc.googleusercontent.com. [104.155.68.112])
        by smtp.gmail.com with ESMTPSA id d1sm19683227wrs.13.2019.03.05.15.44.20
        (version=TLS1_2 cipher=ECDHE-RSA-CHACHA20-POLY1305 bits=256/256);
        Tue, 05 Mar 2019 15:44:20 -0800 (PST)
From:   Junio C Hamano <gitster@pobox.com>
To:     Jeff King <peff@peff.net>
Cc:     =?utf-8?Q?Jean-No=C3=ABl?= Avila <jn.avila@free.fr>,
        git@vger.kernel.org
Subject: Re: [PATCH] Doc: fix misleading asciidoc formating
References: <20190305214423.27820-1-jn.avila@free.fr>
        <20190305223655.GA27535@sigill.intra.peff.net>
        <xmqq4l8hszj7.fsf@gitster-ct.c.googlers.com>
        <20190305230227.GA22901@sigill.intra.peff.net>
        <20190305231142.GA359@sigill.intra.peff.net>
Date:   Wed, 06 Mar 2019 08:44:20 +0900
In-Reply-To: <20190305231142.GA359@sigill.intra.peff.net> (Jeff King's message
        of "Tue, 5 Mar 2019 18:11:42 -0500")
Message-ID: <xmqqy35ssx7v.fsf@gitster-ct.c.googlers.com>
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/26.1 (gnu/linux)
MIME-Version: 1.0
Content-Type: text/plain
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Jeff King <peff@peff.net> writes:

> TBH, I still have mixed feelings on rendering these technical docs with
> asciidoc at all. It seems like few enough people bother to render them
> that bugs persist for a long time. It kind of seems like make-work
> getting them to format correctly.

I thought about resisting when some people started pushing for
rendering everything under the Sun, but went with the flow as I
lacked the energy to fight every battle in sight.

Good to see somebody shares a similar sense of trade-off, better
late than never ;-).
