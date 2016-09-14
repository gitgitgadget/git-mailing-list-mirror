Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-4.9 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_HI,RCVD_IN_SORBS_SPAM,
	RP_MATCHES_RCVD shortcircuit=no autolearn=ham autolearn_force=no version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 69F741FCA9
	for <e@80x24.org>; Wed, 14 Sep 2016 12:52:29 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1762037AbcINMw1 (ORCPT <rfc822;e@80x24.org>);
        Wed, 14 Sep 2016 08:52:27 -0400
Received: from mail-wm0-f66.google.com ([74.125.82.66]:34275 "EHLO
        mail-wm0-f66.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1762008AbcINMwY (ORCPT <rfc822;git@vger.kernel.org>);
        Wed, 14 Sep 2016 08:52:24 -0400
Received: by mail-wm0-f66.google.com with SMTP id g141so2448191wmd.1
        for <git@vger.kernel.org>; Wed, 14 Sep 2016 05:52:24 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20120113;
        h=mime-version:from:date:message-id:subject:to:cc;
        bh=ZteNg/fRazWh0InOnajHphOtafPEkeRpIkLsltZ5Nrc=;
        b=Kt83D598P7WdJ9reDjamnjw4lDOnJLXMG7AeGibJ6mZ2JQowe353Bat8ZF+aOO7S60
         wai+0vlKYJef0P/gSVVVZGc6fk3Ku3N+sP+nz51IHpkNjHg4NT10illZyvpWtFL2AWDh
         l9BnB1qk03awr013f+kxxB8rHVEWUIBMWEGRAcFVtVs25xJbSUlkjDegexy/Gq+No60b
         74MFBGhna55+MD7CyHcdda4GfwHbOANfSnuwDMgJMwAKCBzu0Y6S8ma8wqlGgoT1l/ig
         /G+kvJRVMZbED5D4T0IkfY4nXl2340PNMF7GdA7bKvLkkfgDAE4VgvBcHX+Dm7Leat3u
         +OLQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20130820;
        h=x-gm-message-state:mime-version:from:date:message-id:subject:to:cc;
        bh=ZteNg/fRazWh0InOnajHphOtafPEkeRpIkLsltZ5Nrc=;
        b=N2i32dmLbdmutmRaLUsVlZdAMkWQ+Xlx0KtVin9Scuniq17QrRSPe5zsFDpRxJYEo0
         7QI12PmN8LhZw6Q3vGh+40rb1MJg2QCih+UhyHIMcJSPDMqfmXIXebWeOAiPB4vPfDVw
         ncFh1i+eRPQxMEpMlYbYp51EiYcx1LWCS0Lbe77zmFh7gT/gOPsgQ7oXRyXC7tGdbTBH
         LYdVsoRpuazxhkVboA5p5KqNxP/6t6Gb8f8/ZwYHHjn5JeOQs9Hm3f6hFchFqxoExIP7
         uSQy8HGNK5Wp6rNoVSp1muxK2jj9YQ0JZ2g3KQFmDVR5Y7setpS6PDuWxOI3D6YbN8al
         xp1w==
X-Gm-Message-State: AE9vXwPxlC1X5uXL2wkPzn3woxLOr94ST8GDd59PwVTFSIBOt2aATeVfLEH7XYWidS/AF7Lz0WSBFq8RBH3UJA==
X-Received: by 10.194.246.8 with SMTP id xs8mr2484617wjc.64.1473857543166;
 Wed, 14 Sep 2016 05:52:23 -0700 (PDT)
MIME-Version: 1.0
Received: by 10.194.38.132 with HTTP; Wed, 14 Sep 2016 05:52:22 -0700 (PDT)
From:   Christian Couder <christian.couder@gmail.com>
Date:   Wed, 14 Sep 2016 14:52:22 +0200
Message-ID: <CAP8UFD2vDOZ_puseEx5zjYCKtxYhZKetVx+EyC+Kdap=jOw26A@mail.gmail.com>
Subject: [ANNOUNCE] Git Rev News edition 19
To:     git <git@vger.kernel.org>
Cc:     Thomas Ferris Nicolaisen <tfnico@gmail.com>,
        Nicola Paolucci <durden@gmail.com>,
        Junio C Hamano <gitster@pobox.com>,
        Jeff King <peff@peff.net>,
        =?UTF-8?Q?Jakub_Nar=C4=99bski?= <jnareb@gmail.com>,
        Josh Triplett <josh@joshtriplett.org>,
        Lars Schneider <larsxschneider@gmail.com>,
        "brian m. carlson" <sandals@crustytoothpaste.net>,
        Matthieu Moy <Matthieu.Moy@grenoble-inp.fr>,
        Kevin Willford <kcwillford@gmail.com>,
        Johannes Schindelin <Johannes.Schindelin@gmx.de>,
        Pranit Bauva <pranit.bauva@gmail.com>, lwn@lwn.net
Content-Type: text/plain; charset=UTF-8
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Hi everyone,

I'm happy announce that the 19th edition of Git Rev News is now published:

https://git.github.io/rev_news/2016/09/14/edition-19/

Thanks a lot to all the contributors and helpers, especially Brian,
Jakub, Lars and Josh!

Enjoy,
Christian and Thomas.
