Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-2.8 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_HI,T_DKIM_INVALID,
	T_RP_MATCHES_RCVD shortcircuit=no autolearn=no autolearn_force=no
	version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 8742F1F404
	for <e@80x24.org>; Fri,  9 Feb 2018 19:15:12 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1752446AbeBITPK (ORCPT <rfc822;e@80x24.org>);
        Fri, 9 Feb 2018 14:15:10 -0500
Received: from mail-wr0-f196.google.com ([209.85.128.196]:44491 "EHLO
        mail-wr0-f196.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1752436AbeBITPJ (ORCPT <rfc822;git@vger.kernel.org>);
        Fri, 9 Feb 2018 14:15:09 -0500
Received: by mail-wr0-f196.google.com with SMTP id v65so2492404wrc.11
        for <git@vger.kernel.org>; Fri, 09 Feb 2018 11:15:09 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=sender:from:to:cc:subject:references:date:in-reply-to:message-id
         :user-agent:mime-version;
        bh=iZe+LBR6a6JGgW8C4By328RRE+Cd9LrnMwSyagRarSc=;
        b=VrL8BweOCvXkiuSfGbp8oPyWpfb8avpBLs6H2bnOVq9Pkod0ZaAMmZ920eGPza8iEx
         NZTQ8+efSqFD0GBLtlyk0UD+xfKSnp09FNOtk10EiyTfmdzW0rtC0ag9blyaBER1bF+R
         ftVsHcz6vkx8mxJeF7mljZHHFMGuvkxoKePt6RlUjgBjZewHn/r2nQ+HN/rZn3CQeRcU
         xwlG4LSOQJNgQYqo4vi1YAFD0W645bfGQMuiN9zvrB0NaJIpAZttYeR0QA9lgSPfdW5s
         AsbIR1Ir0Sx53Mw/gMMIURke72rnSc+OPbTCOMzYPNn3cR5YShPjdtmsTxrJF3btWI/h
         E0jw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:sender:from:to:cc:subject:references:date
         :in-reply-to:message-id:user-agent:mime-version;
        bh=iZe+LBR6a6JGgW8C4By328RRE+Cd9LrnMwSyagRarSc=;
        b=cOpyBFmoB6Vj9BNW1V2HxIu/SxUJq20rz0//fTIVBF754lVgMGD/ne673fkyEZCreH
         8vc291cOoPVBuRsNsQHV5syKRx0ClOKhnN1izDwcAAmu6MPncOV8xdooLR0mIFNcYSaA
         u142SNPqhb1b/6KhCDwzpn3bpO+B1DiqqPrzrWyH33KHDaTGEA/BvQ1iMfTOBKnwffFm
         hc8tet6vulFbHOkAZ7sdKvCNb5pIuRnpO33vaeRQR0eYdHkHdii3Xs1za558DEHjgFGY
         sNniYMHPJXTKzWr9v7VFVLZopHE5GbNpP8NG3KpuNkChCmSaXPlUIpPBHx9n99V/ukKf
         BCXw==
X-Gm-Message-State: APf1xPBTLxd7CUfPbmSbreBxMPFtH7X1anZMw0zRiBlJDr6RdvluqPaR
        4CK1YCyYDyS8g6QsGLcVdrX8UGl9
X-Google-Smtp-Source: AH8x224BnMAVYcIBESV0JQojNq2f/IGuY6YFACWcdA86IDc3puA/kMpq0OQ2q7N+RvcDNKQVx0tZDA==
X-Received: by 10.223.156.205 with SMTP id h13mr3700798wre.123.1518203708137;
        Fri, 09 Feb 2018 11:15:08 -0800 (PST)
Received: from localhost (168.50.187.35.bc.googleusercontent.com. [35.187.50.168])
        by smtp.gmail.com with ESMTPSA id y6sm2841062wmy.14.2018.02.09.11.15.07
        (version=TLS1_2 cipher=ECDHE-RSA-CHACHA20-POLY1305 bits=256/256);
        Fri, 09 Feb 2018 11:15:07 -0800 (PST)
From:   Junio C Hamano <gitster@pobox.com>
To:     Alexander Shopov <ash@kambanaria.org>
Cc:     git@vger.kernel.org, martin.agren@gmail.com, bmwill@google.com,
        peff@peff.net, sandals@crustytoothpaste.net,
        worldhello.net@gmail.com, j6t@kdbg.org, sunshine@sunshineco.com,
        pclouds@gmail.com
Subject: Re: [PATCH 1/1] Mark messages for translations
References: <20180209074404.2902-1-ash@kambanaria.org>
        <20180206073812.GA14133@sigill.intra.peff.net>
        <20180209074404.2902-2-ash@kambanaria.org>
        <xmqqlgg2xbx0.fsf@gitster-ct.c.googlers.com>
Date:   Fri, 09 Feb 2018 11:15:06 -0800
In-Reply-To: <xmqqlgg2xbx0.fsf@gitster-ct.c.googlers.com> (Junio C. Hamano's
        message of "Fri, 09 Feb 2018 10:20:27 -0800")
Message-ID: <xmqqwozmvuth.fsf@gitster-ct.c.googlers.com>
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/25.2.50 (gnu/linux)
MIME-Version: 1.0
Content-Type: text/plain
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Junio C Hamano <gitster@pobox.com> writes:

>> -	if ! grep "Invalid gitfile format" .err
>> +	if ! test_i18ngrep "invalid gitfile format" .err
>
> Shouldn't this rather be like so instead?
>
> 	if test_i18ngrep ! "invalid gitfile format" .err
>
> Ditto for the other negated use of test_i18ngrep we see in the same
> file in this patch.

Sorry, my thinko.  These two ones want to be written in the patch
as-is.

