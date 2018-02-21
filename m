Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-2.8 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_HI,T_RP_MATCHES_RCVD
	shortcircuit=no autolearn=no autolearn_force=no version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id EC31E1F404
	for <e@80x24.org>; Wed, 21 Feb 2018 22:53:44 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1750805AbeBUWxn (ORCPT <rfc822;e@80x24.org>);
        Wed, 21 Feb 2018 17:53:43 -0500
Received: from mail-wr0-f172.google.com ([209.85.128.172]:42234 "EHLO
        mail-wr0-f172.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1750738AbeBUWxl (ORCPT <rfc822;git@vger.kernel.org>);
        Wed, 21 Feb 2018 17:53:41 -0500
Received: by mail-wr0-f172.google.com with SMTP id k9so8675715wre.9
        for <git@vger.kernel.org>; Wed, 21 Feb 2018 14:53:41 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:references:user-agent:in-reply-to:date
         :message-id:mime-version;
        bh=xD8no8H+hLdbrnitVVrXwgMds7jGG8FFFud+rIiqCk0=;
        b=DZKedoltWmsV+PiiTGqGTbFuHT+RaX417KZTRu64+XGkpO1Y7RHIRZyxuGFKWw4oZy
         8zUGD4o/WcF3U0RwKOW0RWB3J+cOqXAA6+NKDE4tDcmvS0RqXx4D0m0BpX/gBXAesJZ9
         doWNnn9cYbWlBG6uWOHVuJWv6cVJL7Hdutfp04w23TcAM32t4rPz93Jznf9GNhFpW7aA
         maqesrWyu/gUfXFmaQJyB6gM48KT5xBsd6mvqfA6goHzSy3cmLno2gSH+TOPdv1PDShf
         9sBBAya0nKPpZ2ibfHIObAL+Un5KKcPIRC4+kfUJRU3zvdajKi7xatHNuoYCMpNQUejN
         tMgA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:references:user-agent
         :in-reply-to:date:message-id:mime-version;
        bh=xD8no8H+hLdbrnitVVrXwgMds7jGG8FFFud+rIiqCk0=;
        b=rGG7v8iGLDMns6mk1C+JgCkn3LPYOLvmdGDohMnaPETDbXm4sSAAoEPWCR1tWXuuqj
         xuvFOLnQzOonTgKEfQ8DD/fzeqOlqVKZyZB+R41b2+J5j1pyOnjMA+AB70auC0Z9yO7s
         QgKOz1Y8lJO2nqI4bEmo3V8RCZZ4XW0Gpl8xCWZbmmcKm2ACHGIyy5uR/sulsXJ45rrU
         gHHQRcL/CZNmcjdd4NbefjweB+xDsIwMbgIQs4mWbECM+gw1vls29YP28l9ZbRZnj34N
         qjNuMA7GjmN5hlSnRKnFBZqQ2Cj3j21lBMiAX0i3M8rL1YDat4eucilEy/oOYhfGMFlv
         O13Q==
X-Gm-Message-State: APf1xPDYg+cpeJhcqatAWE3XoNdc+RyeP/ltdT5JlG1J1CRuUznY4Ahh
        JjDvQg4/dAYzUWtkWiUDhPxFCn/w
X-Google-Smtp-Source: AH8x2269jifX8jXS+0AOIEz5RRJHOH7d9NIwliZxkxgKhzGWhrElH90Ws+l3yqWnGC/yMX7EhYWFRA==
X-Received: by 10.223.187.199 with SMTP id z7mr4430186wrg.58.1519253620534;
        Wed, 21 Feb 2018 14:53:40 -0800 (PST)
Received: from evledraar (178-84-79-100.dynamic.upc.nl. [178.84.79.100])
        by smtp.gmail.com with ESMTPSA id u22sm36252551wrf.86.2018.02.21.14.53.38
        (version=TLS1_2 cipher=ECDHE-RSA-CHACHA20-POLY1305 bits=256/256);
        Wed, 21 Feb 2018 14:53:39 -0800 (PST)
From:   =?utf-8?B?w4Z2YXIgQXJuZmrDtnLDsA==?= Bjarmason <avarab@gmail.com>
To:     Basin Ilya <basinilya@gmail.com>
Cc:     git@vger.kernel.org
Subject: Re: test bare repository for unit tests
References: <b8afa3d7-dc65-1abf-062a-a503f0c0f38d@gmail.com>
User-agent: Debian GNU/Linux 9.3 (stretch); Emacs 25.1.1; mu4e 1.1.0
In-reply-to: <b8afa3d7-dc65-1abf-062a-a503f0c0f38d@gmail.com>
Date:   Wed, 21 Feb 2018 23:53:37 +0100
Message-ID: <878tbmeyz2.fsf@evledraar.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org


On Wed, Feb 21 2018, Basin Ilya jotted:

> Hi.
> I want to the test-repo-git under https://github.com/apache/maven-wagon/tree/master/wagon-providers/wagon-scm/src/test/resources/
> just like test-repo-cvs and test-repo-svn
>
> Which configuation options would suit that?
> I think core.compression 0 for human readable diffs.
> also, I need to force loose, gc after each push.

It looks like you have unit tests that are going to do integration tests
of some SVN/CVS repos as used by some other tool, and want to add git to
that.

Since you have git already, the most straightforward thing to do would
be to ship the output of git-fast-export in the repo, and have the test
setup code create a repo locally out of that, then test it.

Or do you really need to commit the raw repo files as-is for some reason
I've missed?
