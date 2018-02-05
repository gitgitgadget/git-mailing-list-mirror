Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-2.9 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_HI,T_RP_MATCHES_RCVD
	shortcircuit=no autolearn=no autolearn_force=no version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id E56201F404
	for <e@80x24.org>; Mon,  5 Feb 2018 20:11:44 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1750872AbeBEULm (ORCPT <rfc822;e@80x24.org>);
        Mon, 5 Feb 2018 15:11:42 -0500
Received: from mail-wm0-f52.google.com ([74.125.82.52]:34254 "EHLO
        mail-wm0-f52.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1751617AbeBEULX (ORCPT <rfc822;git@vger.kernel.org>);
        Mon, 5 Feb 2018 15:11:23 -0500
Received: by mail-wm0-f52.google.com with SMTP id j21-v6so14769188wmh.1
        for <git@vger.kernel.org>; Mon, 05 Feb 2018 12:11:22 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:references:user-agent:in-reply-to:date
         :message-id:mime-version:content-transfer-encoding;
        bh=hX2h8ng+GSdYCPuVNTQIsUSR97HvPdUDxgC0443hwBU=;
        b=D7F+5YD2U2jNB0aoihvPTmta3lsNOOz7SxIQTMYbnxtUaIdRAeoY0h7rWIjJEL+IKw
         cyHMkC5JGgOZc5ZL0pHkTzckblIYV3gDCLpmq7/BbgXC3sXg3IkM039veO0zw1bnzet4
         Mrd61etr7p02r6AVvvZnatsMESKPLwQD8K4hUcoK/iMov8XP5eZWOL1KXnv2SRv1cjWW
         GheFaTZOWtTtrEw8u4R9Y4la7lS2fF2Qxjrv8TO8pqPrDV8jvppfhUgrafMInqQpiavI
         FUOyrWxqDDZZiVubXQLTz3F+1y0AFTlBm6p/KEjVRs6Yp5p9kA5H9+SumAHFOebxfgWQ
         yA4A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:references:user-agent
         :in-reply-to:date:message-id:mime-version:content-transfer-encoding;
        bh=hX2h8ng+GSdYCPuVNTQIsUSR97HvPdUDxgC0443hwBU=;
        b=KAZwsZkrponsune79gmVScICb5mQpl7KW5PtO2k3W676Lx4jGY8Cxxo4jv+oys6io3
         P3tuLSOENar7u6UcJPMl54ZnkVo6Ezb4r/8L7ZkYLo1l40ucswpdiTTVnqtSd4UjZmr+
         qR8HAyO1MeoQIFTgo/W4VbAODEsQIWyEaUTJk3iBIkr0k6deDzvEYF3/Q8XZPFm90yrs
         HYjIjlpafE4xGxBF2XxDz84kgLEghSve2MyxiA4vaO5pLGR00TOLGNvQ60QHgdtOnQM1
         6PVB8kERSwL/cPZLb0kCr0LMYSMSnSoi8snRRc0fHKvAr8Qn7oKqvASCRyPw84bvDnTA
         yrdg==
X-Gm-Message-State: APf1xPDJrkouFQ5f13PXSkcZJl5LE5aXGoXm7RdOzWxRJ6GpPNkTbAZQ
        YXadtrYeqV7oopkDxm4uddDbxM1o
X-Google-Smtp-Source: AH8x226I/qjwFJuCn0yiUWXWr6jlAcQPaZG8oOilCqQd0SNBjnT8bQui7gRZEfeqvLljzzFrrXSy5w==
X-Received: by 10.80.144.92 with SMTP id z28mr573444edz.235.1517861481939;
        Mon, 05 Feb 2018 12:11:21 -0800 (PST)
Received: from evledraar (178-84-79-100.dynamic.upc.nl. [178.84.79.100])
        by smtp.gmail.com with ESMTPSA id s26sm7304420eds.49.2018.02.05.12.11.20
        (version=TLS1_2 cipher=ECDHE-RSA-CHACHA20-POLY1305 bits=256/256);
        Mon, 05 Feb 2018 12:11:21 -0800 (PST)
From:   =?utf-8?B?w4Z2YXIgQXJuZmrDtnLDsA==?= Bjarmason <avarab@gmail.com>
To:     Martin =?utf-8?Q?H=C3=A4cker?= <mhaecker@schwarz-online.org>
Cc:     git@vger.kernel.org
Subject: Re: Missing git options
References: <AD196D8E-04DB-4274-ADEB-D914A79628B3@schwarz-online.org>
User-agent: Debian GNU/Linux 9.3 (stretch); Emacs 25.1.1; mu4e 1.0-alpha3
In-reply-to: <AD196D8E-04DB-4274-ADEB-D914A79628B3@schwarz-online.org>
Date:   Mon, 05 Feb 2018 21:11:20 +0100
Message-ID: <87tvuvkxhz.fsf@evledraar.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: 8bit
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org


On Mon, Feb 05 2018, Martin Häcker jotted:

> Hi there,
>
> I just recently learned that not all command line switches seem to automatically correlate to options in the git configuration.
>
> This seems something that should be relatively easy to fix.
>
> What I’m most missing is
>
> — snip —
> [log]
> 	graph = true
> 	patch = true
> — snap —
>
> which would / should correspond to `git log —graph —patch`.
>
> What do you guys think?

FWIW my WIP
https://public-inbox.org/git/20170328131316.32516-1-avarab@gmail.com/
had some discussion around this.

