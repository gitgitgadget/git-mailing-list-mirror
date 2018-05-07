Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-3.5 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,RCVD_IN_DNSWL_HI,
	T_DKIM_INVALID shortcircuit=no autolearn=ham autolearn_force=no version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id E9296200B9
	for <e@80x24.org>; Mon,  7 May 2018 03:04:42 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1751878AbeEGDEk (ORCPT <rfc822;e@80x24.org>);
        Sun, 6 May 2018 23:04:40 -0400
Received: from mail-wr0-f194.google.com ([209.85.128.194]:45963 "EHLO
        mail-wr0-f194.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1751854AbeEGDEk (ORCPT <rfc822;git@vger.kernel.org>);
        Sun, 6 May 2018 23:04:40 -0400
Received: by mail-wr0-f194.google.com with SMTP id p5-v6so26884930wre.12
        for <git@vger.kernel.org>; Sun, 06 May 2018 20:04:39 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=sender:from:to:cc:subject:references:date:in-reply-to:message-id
         :user-agent:mime-version;
        bh=HsiFqcCThvONxFKOkePZCW5Vwtm6b83eQIMDPFDlow4=;
        b=DMNjiqt+LFhiNXyUDeHReDQNNQoEoiCRfjIReA8YG9K3aAp0nD51IrLITVs72/wxnW
         WqBiRxhejWM9qyTOB4meCqmJ32kGjSFmmsuG7yYC0aWZsKkhRjHvG+hJ66afErUOuEND
         rRFQPVX/2VlfDWMwuME6LmOTzz0Q/wNS2m/a3cTaAZuKVcLIEtDxrCRZHSKLLsA8W1KU
         8ZN3OjlsFj4B0QqL9giH8weIUVnIYxZtrqymMP16wj67xLKZp43zsA8ijbAisih0BedT
         uGnhwAjcpx8/XuSqXrOIphtD9vItDvhRGTE06TqLlEYxczNl52GEufwVIAOeF8YFsXjX
         g14w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:sender:from:to:cc:subject:references:date
         :in-reply-to:message-id:user-agent:mime-version;
        bh=HsiFqcCThvONxFKOkePZCW5Vwtm6b83eQIMDPFDlow4=;
        b=p9hdsWuG3P/gfNdodPng3+RffHDQtO/pPAAnhjTSKmwmW5r3Oid+vaMslvkQIECBjp
         UMh8k1egYF7s60vGOfkOxsp4yhQmeT6cImuDcuYUcOKmnDmMLMe2CVeBD95kVutrwg0y
         I5jGzHz7Xzxm6bEySCrgHdW4q8OhyiJmpOcctpbFblvLnF0YUdbd+60beFSPXUB77eMW
         KOyDUxYtcw+I0wX2Jel4ShLpz2YWsFBRngAbaPEBIf7o190zleSCrIUVS6BBnCV/T8Sc
         2k2DMaQ/Qf9l+E2Xt2/PXcVr+6VzIa4hXVNdfMTg1m0Miy7imReNYNl9iZd+ofr5txpl
         Vj5g==
X-Gm-Message-State: ALQs6tBw08PCIgAi964D8VneDhqgGphbrLaA7YlaO+e6aGOeVdjKDpnP
        Z9rh2AU6BgYX/semurvllqg=
X-Google-Smtp-Source: AB8JxZqJH3RiKeYYGlXUav4mbtxLi3/TmuAX9gWQthNZWsdaQzDr3sDLbeFykelaIdwpkkTl+OEEbQ==
X-Received: by 2002:adf:9bcd:: with SMTP id e13-v6mr30545568wrc.240.1525662278815;
        Sun, 06 May 2018 20:04:38 -0700 (PDT)
Received: from localhost (112.68.155.104.bc.googleusercontent.com. [104.155.68.112])
        by smtp.gmail.com with ESMTPSA id 123sm8707840wmt.19.2018.05.06.20.04.36
        (version=TLS1_2 cipher=ECDHE-RSA-CHACHA20-POLY1305 bits=256/256);
        Sun, 06 May 2018 20:04:36 -0700 (PDT)
From:   Junio C Hamano <gitster@pobox.com>
To:     "brian m. carlson" <sandals@crustytoothpaste.net>
Cc:     git@vger.kernel.org,
        Martin =?utf-8?Q?=C3=85gren?= <martin.agren@gmail.com>
Subject: Re: [PATCH 1/2] Documentation: use 8-space tabs with Asciidoctor
References: <20180504015202.GP13217@genre.crustytoothpaste.net>
        <20180506204226.955739-1-sandals@crustytoothpaste.net>
Date:   Mon, 07 May 2018 12:04:36 +0900
In-Reply-To: <20180506204226.955739-1-sandals@crustytoothpaste.net> (brian
        m. carlson's message of "Sun, 6 May 2018 20:42:25 +0000")
Message-ID: <xmqqefioqi7v.fsf@gitster-ct.c.googlers.com>
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/25.2.50 (gnu/linux)
MIME-Version: 1.0
Content-Type: text/plain
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

"brian m. carlson" <sandals@crustytoothpaste.net> writes:

> Asciidoctor expands tabs at the beginning of a line.  However, it does
> not expand them into 8 spaces by default.  Since we use 8-space tabs,
> tell Asciidoctor that we want 8 spaces by setting the tabsize attribute.
> This ensures that our ASCII art renders properly.
>
> Signed-off-by: brian m. carlson <sandals@crustytoothpaste.net>
> ---
>  Documentation/Makefile | 2 +-
>  1 file changed, 1 insertion(+), 1 deletion(-)

Wonderful.  Thanks.

>
> diff --git a/Documentation/Makefile b/Documentation/Makefile
> index 6232143cb9..bcd216d96c 100644
> --- a/Documentation/Makefile
> +++ b/Documentation/Makefile
> @@ -184,7 +184,7 @@ ASCIIDOC = asciidoctor
>  ASCIIDOC_CONF =
>  ASCIIDOC_HTML = xhtml5
>  ASCIIDOC_DOCBOOK = docbook45
> -ASCIIDOC_EXTRA += -acompat-mode
> +ASCIIDOC_EXTRA += -acompat-mode -atabsize=8
>  ASCIIDOC_EXTRA += -I. -rasciidoctor-extensions
>  ASCIIDOC_EXTRA += -alitdd='&\#x2d;&\#x2d;'
>  DBLATEX_COMMON =
