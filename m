Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.2 (2018-09-13) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-3.3 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	FROM_EXCESS_BASE64,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,
	RCVD_IN_DNSWL_HI shortcircuit=no autolearn=ham autolearn_force=no
	version=3.4.2
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id C99641F62E
	for <e@80x24.org>; Wed, 16 Jan 2019 10:17:03 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2389494AbfAPKRC (ORCPT <rfc822;e@80x24.org>);
        Wed, 16 Jan 2019 05:17:02 -0500
Received: from mail-wm1-f43.google.com ([209.85.128.43]:36123 "EHLO
        mail-wm1-f43.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1728999AbfAPKRC (ORCPT <rfc822;git@vger.kernel.org>);
        Wed, 16 Jan 2019 05:17:02 -0500
Received: by mail-wm1-f43.google.com with SMTP id p6so1354152wmc.1
        for <git@vger.kernel.org>; Wed, 16 Jan 2019 02:17:01 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:references:user-agent:in-reply-to:date
         :message-id:mime-version;
        bh=SvbLHMgmHWCe1HEfj+Dnzv9gW3gNZ48o3ESGBCEZwlg=;
        b=QWCvmR/XPtSxCsdP5nc8R0Xxxh+IevDH+H2YMb26XNDvfn/v+Q9XWZiSLVY97S+HQY
         IM1KoMaw3wUfyXX2nAn3LrTu8z7WsFe5lXmoT/eFzi7h2Wzdk38kuRZl9FPVCHs7o0NU
         uketU/FTM2aGyWsvVJ/7ScWjWMvCd9GaeVCa2HwoYN7D3ka4o+e+T73oRXQQ3en8QORX
         CnnvHFkGcDFyjSwNfqKkfr8hVK9ZVXVdCiC3SXOVY/GIDbPTlpRs0J6zQZybcCBQyrTm
         ugSOCuvBvL7MjxDybNdeEV+lsihPLZzegpt7BQrS/kmph0Acpaca21AitXDPFDjEn7gh
         tGBA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:references:user-agent
         :in-reply-to:date:message-id:mime-version;
        bh=SvbLHMgmHWCe1HEfj+Dnzv9gW3gNZ48o3ESGBCEZwlg=;
        b=Hk3w3AQD6HSjjdltdjdzTW3pLoVnfnGjGPG0dd5P9gHturkle8S2Pr3RmeT3BM9hUH
         U/kwsiaQvqpGOzzle/ubv8yWyTKf+aCXaHJ+yIHkAGSu8PO8dkyDRqgDfAs8AdykJKGQ
         EtNlFafQ/cXcnPQUgXzYnBUhRXaApZCyOxiHZIqvNrFkwXHaucO0xSH7Om3hhn9oaxf8
         R/ymfSuq1UjSKt3EA6NiH0i40depa7EuDHOducVTXlYDMqLADcLknYwNE5ni1NOeyjTh
         GWgR6pjEva7Cp0z+RnIjYMc6aBmHHegwuJpi30IWUU5lTP26SUbyHDmjQfdeOI1LhU9s
         9Vhg==
X-Gm-Message-State: AJcUukevgC7zfrlbYBYnu4qMzWiYHHLQps8nMuL53F/VyU0zUjF9/729
        QKBv8rgbrw2bPZKHF7mXHD4=
X-Google-Smtp-Source: ALg8bN7EOmgoGXfb2ZmN02G1nKB05I2S1R+kMmjWSTsVN/au/o8DCIYRXDXx94/OMr5e/h/a6jJ+tA==
X-Received: by 2002:a1c:c008:: with SMTP id q8mr6233639wmf.99.1547633820515;
        Wed, 16 Jan 2019 02:17:00 -0800 (PST)
Received: from evledraar (i40217.upc-i.chello.nl. [62.195.40.217])
        by smtp.gmail.com with ESMTPSA id 10sm43442966wmy.40.2019.01.16.02.16.59
        (version=TLS1_2 cipher=ECDHE-RSA-CHACHA20-POLY1305 bits=256/256);
        Wed, 16 Jan 2019 02:16:59 -0800 (PST)
From:   =?utf-8?B?w4Z2YXIgQXJuZmrDtnLDsA==?= Bjarmason <avarab@gmail.com>
To:     Kaustubh Shankar <kaustubhshan@gmail.com>
Cc:     unlisted-recipients <unlisted-recipients@evledraar>,
        git@vger.kernel.org
Subject: Re: New to git. Need help!
References: <CALM8fiaUqxscb0GWHTidXmaDv_2QqkzN4sybA377cr59G6+yCQ@mail.gmail.com>
User-agent: Debian GNU/Linux buster/sid; Emacs 26.1; mu4e 1.1.0
In-reply-to: <CALM8fiaUqxscb0GWHTidXmaDv_2QqkzN4sybA377cr59G6+yCQ@mail.gmail.com>
Date:   Wed, 16 Jan 2019 11:16:58 +0100
Message-ID: <87r2dc52lh.fsf@evledraar.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org


On Tue, Jan 15 2019, Kaustubh Shankar wrote:

> Hello everyone,
>
> I'm new to this mailing list and have also joined the IRC channel recently.
> I want to start contributing by possibly fixing small bugs or errors.
> I have gone through the suggested guidelines and documentation but it
> is too large and I don't know where to start.
> If anybody could help me out it would be much appreciated.

The recent https://public-inbox.org/git/86fttvcehs.fsf@matthieu-moy.fr/
thread should be of interest to you.

We also have a #git-devel IRC channel on Freenode, but if you're asking
questions there you need to be patient, you often (as on the ML) won't
get answers until a new timezone rolls around for someone, so you need a
24/7 connection to use it effectively.
