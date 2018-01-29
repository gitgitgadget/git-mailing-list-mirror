Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-2.8 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_HI,T_RP_MATCHES_RCVD
	shortcircuit=no autolearn=no autolearn_force=no version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 2E6D61FAE2
	for <e@80x24.org>; Mon, 29 Jan 2018 15:17:38 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1752019AbeA2PRg (ORCPT <rfc822;e@80x24.org>);
        Mon, 29 Jan 2018 10:17:36 -0500
Received: from mail-wm0-f48.google.com ([74.125.82.48]:37679 "EHLO
        mail-wm0-f48.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1751704AbeA2PRf (ORCPT <rfc822;git@vger.kernel.org>);
        Mon, 29 Jan 2018 10:17:35 -0500
Received: by mail-wm0-f48.google.com with SMTP id v71so34423265wmv.2
        for <git@vger.kernel.org>; Mon, 29 Jan 2018 07:17:34 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:references:user-agent:in-reply-to:date
         :message-id:mime-version;
        bh=M10ecXvCl6qM2rAPNfcvdZ3koBndhRphrv/+EoDVYyk=;
        b=u6HM5XyWw8N6LMxBzilaoUCRxXCKoqUOj5UlB8fUCOyycqLtZuwx4qyOdc6QJud2hu
         /lcbwJzPT1y1NPMTPh8PeP8IVT49/Ic6MFtgU+T8bRJRvhuDietHciiHcBsybzXfuEXC
         edtc1dM4S5Kb1Xi3IFLfU+SkD8VKDS2jLP2rnTjfw/68k4gDsBzPI8gi1iAAk6Gm7fzn
         H6ERykFhaz7FMuZ6AJ52bHdojq8dMPyfMk6Vp0Wqiz5lBPzsi8laVaAe9fZx7ua8TNnb
         iNcVOEgP4R+XQ5nwBHkiIWJKLqHabdD41T2fOglTjvd/wXCcS72cBPWnu4tMh9JKv/Ic
         i5kQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:references:user-agent
         :in-reply-to:date:message-id:mime-version;
        bh=M10ecXvCl6qM2rAPNfcvdZ3koBndhRphrv/+EoDVYyk=;
        b=uOAOh5RsFeIhP4IWeqMbQpvdHUQqb7+PWvCjSIcl8Z4PvXAu3Vx2UaXSfyVn1yiVXV
         LjhO+KoauOaeyn1mmAwuSqHNAJpZRCCo1E2cF1NPXZCj6VFOd/awxK5UhHVVLbQyIDqs
         gC+KGLTKWv3vpV7J1AzqLd//ubiPpL/aCvlN6kOJ2QYRHI+RK6wdJ0Y8pXIC4VAV5l4D
         9gDDm8a4LKcyfhTMB/qSBCZcPlMZmrLzc7wwjKoThBopVtizvg9MmanFEaimIj9MYto5
         vJ3vtqRhrbGQhhHH6fHPU4CAv5UxUAjadPba65R8M6WMg4dIY3+/0WqvrP0qbB7vn4zz
         080A==
X-Gm-Message-State: AKwxytdPNSn64riuoewV2QgvRt3zZRerDmeFa5CPlfiQ+XQ/+lHWz/rx
        muX31xPqhEqXe+qaqgiME4E=
X-Google-Smtp-Source: AH8x224mgbhyJ6dNLTVZLd1PnZ2TnzOV5G6t+ax9LmwTY6i1MunidMNfLdSMboK/7h4RRQSLrNBgIQ==
X-Received: by 10.80.170.157 with SMTP id q29mr49047773edc.43.1517239053991;
        Mon, 29 Jan 2018 07:17:33 -0800 (PST)
Received: from evledraar (proxy-gw-a.booking.com. [5.57.21.8])
        by smtp.gmail.com with ESMTPSA id g59sm6161359ede.19.2018.01.29.07.17.32
        (version=TLS1_2 cipher=ECDHE-RSA-CHACHA20-POLY1305 bits=256/256);
        Mon, 29 Jan 2018 07:17:33 -0800 (PST)
From:   =?utf-8?B?w4Z2YXIgQXJuZmrDtnLDsA==?= Bjarmason <avarab@gmail.com>
To:     Johannes Schindelin <Johannes.Schindelin@gmx.de>
Cc:     git@vger.kernel.org, chris@dibona.com, Scott@gasch.org
Subject: Re: Shawn Pearce has died
References: <nycvar.QRO.7.76.6.1801291031040.35@ZVAVAG-6OXH6DA.rhebcr.pbec.zvpebfbsg.pbz>
User-agent: Debian GNU/Linux 9.3 (stretch); Emacs 25.1.1; mu4e 1.0-alpha3
In-reply-to: <nycvar.QRO.7.76.6.1801291031040.35@ZVAVAG-6OXH6DA.rhebcr.pbec.zvpebfbsg.pbz>
Date:   Mon, 29 Jan 2018 16:17:32 +0100
Message-ID: <87bmhcsnhv.fsf@evledraar.booking.com>
MIME-Version: 1.0
Content-Type: text/plain
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org


On Mon, Jan 29 2018, Johannes Schindelin jotted:

> Hey fellow gitters,
>
> I found these sad news in my timeline today:
>
> https://twitter.com/cdibona/status/957822400518696960

I've been staring at this E-Mail client for tens of minutes and should
probably start writing something. It's hard to know what to say.

Most of my (comparatively small) involvement with git post-dates Shawn.

It's always a bit strange to contribute to projects and feel like you're
getting to know people you've never met except through their work and
E-Mail correspondence.

I've met many of you, but never met Shawn, but feel like I know him from
all his work for which I and others are thankful for.

I'm sorry he's gone, and have all the best hopes for his family and
children.

They don't want any flowers sent over to them, but I wonder if we
couldn't make some sort of tribute to Shawn at the upcoming developer
meeting in Barcelona (and find some way to have remote people contribute
to it).

E.g. a short video/audio of different people in the dev community
sharing some story about Shawn, or a written list of memories
contributed by and signed by various people.

I don't know what that would look like exactly, but I think it would be
a good thing for his family and especially for his children when they're
grown to remember him by, to know that their father contributed to these
software projects with people all over the world, and that all these
people appreciated his work and him personally.
