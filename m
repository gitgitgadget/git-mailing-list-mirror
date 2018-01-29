Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-2.9 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_HI,T_RP_MATCHES_RCVD
	shortcircuit=no autolearn=no autolearn_force=no version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 73F0E1F404
	for <e@80x24.org>; Mon, 29 Jan 2018 19:36:13 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1752000AbeA2TgL (ORCPT <rfc822;e@80x24.org>);
        Mon, 29 Jan 2018 14:36:11 -0500
Received: from mail-wm0-f46.google.com ([74.125.82.46]:51953 "EHLO
        mail-wm0-f46.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1751539AbeA2TgJ (ORCPT <rfc822;git@vger.kernel.org>);
        Mon, 29 Jan 2018 14:36:09 -0500
Received: by mail-wm0-f46.google.com with SMTP id r71so16624222wmd.1
        for <git@vger.kernel.org>; Mon, 29 Jan 2018 11:36:09 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:references:user-agent:in-reply-to:date
         :message-id:mime-version:content-transfer-encoding;
        bh=cn1yhcIzcHBDycBnp9v9QeAdWrpaM/clC7/j1dssY1M=;
        b=iM/tUxOKqaRrjUZG+vBoxSqh4V/1CS7kCUUjqrkBKPNSOqx+2mwETUCgFtS4gZmEwM
         vtS/i5IhQEvF7nkfIopMqTPhFBSSlBeTxSpnVIGd7I0V+Edg7zyfvEZkbJ1uDvmEkqDB
         nMgZiDg6/GxAghBWNIjSu3qxMm/fFoGLNJHz1HxbxyTCxzI1AFrcmROoIvgRT8Z/e+3v
         apgyAMPQIfH/SuXzW9GE8qaqsVXCRfrhu0fxWywMQTKtZJkeRHVZBGkBQWAenRdymDVU
         3NFlMIlxsvKcDxF60sL9dQYuOOzSlvoTtBgU9l77cApOKoBfpdRDI1VDa3wGsLAz4gNH
         RYTw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:references:user-agent
         :in-reply-to:date:message-id:mime-version:content-transfer-encoding;
        bh=cn1yhcIzcHBDycBnp9v9QeAdWrpaM/clC7/j1dssY1M=;
        b=IWf5LstkG0jmTWBEUYzg8Sj7SHZQVEg4DxF2IkLzb0rxsl576Bfixzuu9YA+vl/JNg
         McQBylFEispxD3amSFE3ioJhUHEYS4pnm3XqP0osNZi0619mdua14aGz+kQtkFg6JpK/
         QkozcZXm4jFG9c4T8UCYKzAZe6f58cg9hWLdBLeAqbavfyQCuZr/yOXrOXbI0Jbf6XiV
         gmnaiZPqSJPSFGmfYD7lf1xpyF/MVVBT/Rn+Wi0D+BB9PFlvEvGh93UY4FqM0z1OKJ0K
         DiyK6MNVLz4DRNfgYF0g/mSohLD3GRcecd0/izFioqZ8eU5oZP9mNn7USXS5a76JP+CW
         J52Q==
X-Gm-Message-State: AKwxytcgzThNCXjaZ57MSrVvZFQlVbKUc6wihlafbEPUZ3s22WDPpWWO
        NspRTTvJKImy60PBoXrxbVM=
X-Google-Smtp-Source: AH8x227PriBMhoEDOsO8XXADtWblmUOk2Y2ZjsdciVfenIVaLMpj1zKpuomJuGurNxhx5Wy73Rrw4Q==
X-Received: by 10.80.170.69 with SMTP id p5mr49727291edc.10.1517254568541;
        Mon, 29 Jan 2018 11:36:08 -0800 (PST)
Received: from evledraar (178-84-79-100.dynamic.upc.nl. [178.84.79.100])
        by smtp.gmail.com with ESMTPSA id c45sm6626442edb.17.2018.01.29.11.36.07
        (version=TLS1_2 cipher=ECDHE-RSA-CHACHA20-POLY1305 bits=256/256);
        Mon, 29 Jan 2018 11:36:07 -0800 (PST)
From:   =?utf-8?B?w4Z2YXIgQXJuZmrDtnLDsA==?= Bjarmason <avarab@gmail.com>
To:     Jeff King <peff@peff.net>
Cc:     Johannes Schindelin <Johannes.Schindelin@gmx.de>,
        git@vger.kernel.org, chris@dibona.com, Scott@gasch.org
Subject: Re: Shawn Pearce has died
References: <nycvar.QRO.7.76.6.1801291031040.35@ZVAVAG-6OXH6DA.rhebcr.pbec.zvpebfbsg.pbz> <87bmhcsnhv.fsf@evledraar.booking.com> <20180129172452.GB4185@sigill.intra.peff.net>
User-agent: Debian GNU/Linux 9.3 (stretch); Emacs 25.1.1; mu4e 1.0-alpha3
In-reply-to: <20180129172452.GB4185@sigill.intra.peff.net>
Date:   Mon, 29 Jan 2018 20:36:07 +0100
Message-ID: <87372oo3tk.fsf@evledraar.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: 8bit
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org


On Mon, Jan 29 2018, Jeff King jotted:

> On Mon, Jan 29, 2018 at 04:17:32PM +0100, Ævar Arnfjörð Bjarmason wrote:
>
>> They don't want any flowers sent over to them, but I wonder if we
>> couldn't make some sort of tribute to Shawn at the upcoming developer
>> meeting in Barcelona (and find some way to have remote people contribute
>> to it).
>>
>> E.g. a short video/audio of different people in the dev community
>> sharing some story about Shawn, or a written list of memories
>> contributed by and signed by various people.
>>
>> I don't know what that would look like exactly, but I think it would be
>> a good thing for his family and especially for his children when they're
>> grown to remember him by, to know that their father contributed to these
>> software projects with people all over the world, and that all these
>> people appreciated his work and him personally.
>
> I like this direction (though like you, I'm not sure exactly what it
> should look like). I'm not sure what kind of video presence GitHub will
> have at the contrib summit, but I'll see about getting some interview
> footage there.
>
> Doing something written, though, may make it easier for remote people to
> collaborate.

Since I suspect many people will want to participate in text form that
wouldn't via video, here's an idea (not mutually exclusive with the
video).

We gather text from people involved in git about Shawn. This gets added
to a git repo, we fast-export it, have it printed as hardcover in
fixed-width font, in "a format your dad made".
