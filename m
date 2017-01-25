Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-5.8 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_HI,RCVD_IN_SORBS_SPAM,
	RP_MATCHES_RCVD,T_DKIM_INVALID shortcircuit=no autolearn=ham
	autolearn_force=no version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 891E41F437
	for <e@80x24.org>; Wed, 25 Jan 2017 00:54:04 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1751087AbdAYAyC (ORCPT <rfc822;e@80x24.org>);
        Tue, 24 Jan 2017 19:54:02 -0500
Received: from mail-ot0-f195.google.com ([74.125.82.195]:33356 "EHLO
        mail-ot0-f195.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1751022AbdAYAyB (ORCPT <rfc822;git@vger.kernel.org>);
        Tue, 24 Jan 2017 19:54:01 -0500
Received: by mail-ot0-f195.google.com with SMTP id f9so21745739otd.0
        for <git@vger.kernel.org>; Tue, 24 Jan 2017 16:54:01 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=mime-version:sender:in-reply-to:references:from:date:message-id
         :subject:to:cc;
        bh=UfyFqGglcfPCQ7lNK200azdeo6tR/5PLpO7SMk0825o=;
        b=C4BqK1VRX4UqOU7Ye1JyFh5Vj4eVsdGSfF8aa867+TbP4GcpCGPWgscdSuO26r797M
         8i5GP/t3+9fbu6u93zsYfn8Jhfipx//FYr/1g/BjWyMs49sIz402xbRSV5cmFbLNuyQG
         UCT2p6WNlIKycs9RmUztSpeasYpglV+ZJ+nK4ITeut43XVyuIHn1UR101EcW+nlqY2xs
         Hc9k9kVgtBtTa+/zsybgHRe9liJL1WgM+qEnbTaNkyoNX9EPUtKWrAFN/eHvkyODdxlX
         2AJe1kPx3OMLWMW/2LJkLl9uHAP0JCdFhg2apYFAKhgNR0FE9S4i12rqieblwAT+x1SS
         tgkw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:sender:in-reply-to:references:from
         :date:message-id:subject:to:cc;
        bh=UfyFqGglcfPCQ7lNK200azdeo6tR/5PLpO7SMk0825o=;
        b=fQB3hVb4NOlRY5NXj2JYc/ZXFQ6wi/3KudCwQ4A6r8aRjUHVaXk9W0t02ZVHNTVekC
         KGj0Opds7Ij9InxJl6Li3pt9kxpdwWWTZydRoDSpOcL9OZMinwXHLIbb1HZjflLM0hcb
         HAdZD1P6IvPiBj3ONHrgVAPw5d1jqlFcyh83GGZdseCPE9g2HvpgeWoNMS3nbFGdgs0s
         BN+jICsDdPyT+y6J7P5xiTeYfZGkEFbO6tHMHVLdjnWtSLWh9KH8q9KE5oSKTv4+5ncm
         RgPoljcv0PS8+5RdaZKAgY5AhjZwCggfCKUXmFDy7ilqC/4CtqqhIKFgNHQUStAyqqFu
         vAxg==
X-Gm-Message-State: AIkVDXK+CCzCS5u50/3jtTI6d5ySj+xvGwEOEEjlobd4eH8RbkxikNf4aSFgtJcR84k6AcqWIYl4hCEmjeqGNA==
X-Received: by 10.157.4.141 with SMTP id 13mr20237443otm.243.1485305640557;
 Tue, 24 Jan 2017 16:54:00 -0800 (PST)
MIME-Version: 1.0
Received: by 10.182.63.13 with HTTP; Tue, 24 Jan 2017 16:54:00 -0800 (PST)
In-Reply-To: <20170125002116.22111-1-sbeller@google.com>
References: <923cd4e4-5c9c-4eaf-0fea-6deff6875b88@tngtech.com> <20170125002116.22111-1-sbeller@google.com>
From:   Linus Torvalds <torvalds@linux-foundation.org>
Date:   Tue, 24 Jan 2017 16:54:00 -0800
X-Google-Sender-Auth: Qhy_s1SmQEeKmKRXTKmAKoRrNgE
Message-ID: <CA+55aFx_W500Ct6HuG18owG37FviirjsrJ_4zZpRcDD-0tmpFg@mail.gmail.com>
Subject: Re:
To:     Stefan Beller <sbeller@google.com>
Cc:     cornelius.weig@tngtech.com, Johannes Sixt <j6t@kdbg.org>,
        bitte.keine.werbung.einwerfen@googlemail.com,
        Git Mailing List <git@vger.kernel.org>,
        Junio C Hamano <gitster@pobox.com>,
        thomas.braun@virtuell-zuhause.de, John Keeping <john@keeping.me.uk>
Content-Type: text/plain; charset=UTF-8
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

On Tue, Jan 24, 2017 at 4:21 PM, Stefan Beller <sbeller@google.com> wrote:
>
> +Do not PGP sign your patch. Most likely, your maintainer or other
> +people on the list would not have your PGP key and would not bother
> +obtaining it anyway.

I think even that could be further simplified - by just removing all
comments about pgp email

Because it's not that the PGP keys would be hard to get, it's that
PGP-signed email is an abject failure, and nobody sane does it.

Google for "phil zimmerman doesn't use pgp email".

It's dead. So I'm not sure it's worth mentioning at all.

You might as well talk about how you shouldn't use EBCDIC encoding for
your patches, or about why git assumes that an email address has an
'@' sign in it, instead of being an UUCP bang path address.

              Linus
