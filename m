Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-2.7 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	FROM_EXCESS_BASE64,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,
	RCVD_IN_DNSWL_HI,T_RP_MATCHES_RCVD shortcircuit=no autolearn=ham
	autolearn_force=no version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 124BB1F424
	for <e@80x24.org>; Sun,  8 Apr 2018 11:48:59 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1752208AbeDHLs5 (ORCPT <rfc822;e@80x24.org>);
        Sun, 8 Apr 2018 07:48:57 -0400
Received: from mail-wm0-f52.google.com ([74.125.82.52]:38968 "EHLO
        mail-wm0-f52.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1752061AbeDHLs4 (ORCPT <rfc822;git@vger.kernel.org>);
        Sun, 8 Apr 2018 07:48:56 -0400
Received: by mail-wm0-f52.google.com with SMTP id f125so10496012wme.4
        for <git@vger.kernel.org>; Sun, 08 Apr 2018 04:48:55 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:references:user-agent:in-reply-to:date
         :message-id:mime-version;
        bh=rKVXPb7eno1Y2u/L+wJnjWTvqCxuzdosytdQfk1S5rc=;
        b=EN7SbQ0/8ypUZFEg1pHPg2gCiLIlE+o4KzN11qtliuyfFy3IxKt6oKQ0rCjGZ00kdb
         34nQtWrYernZj+pkkiJbwiOCTTejyPKhiah2fpM+nQMITk2wotOwAQiYAGzC9pyfS8LZ
         O1qQCLsjyAaxht0EStYtpnbwpogjHAcKZef3JzY6HTN2ebTS/Gt9twId3RNULMV0X32y
         Aaq/4A3hgVltzaoJgpLtQbWw1tnIFRSVNq0eot/TmuicggRodFtnzCcaWluh6rnMtZQ8
         bx86swFAj2u+wTmmM8DM1JXPm6MlIHJIi8FLNBa+PEcELjAAWt/6i4bwoX/Vi3HXnirz
         edSQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:references:user-agent
         :in-reply-to:date:message-id:mime-version;
        bh=rKVXPb7eno1Y2u/L+wJnjWTvqCxuzdosytdQfk1S5rc=;
        b=ROKppVsW/NOmnaxOthXZBp5d9oyCjXC9aM5qIj/gOhBUlmdpg9XIQJ9A+5oRRt/aeH
         h2kmXtZpdhlVEWEjJq8y3lrMUfKs0Ts6RDd5zWNfeNGec7jGZwN3ZtjXj7hioR+PFItO
         PvN8BsnIKR2XzNdQ3Z8+6HFGYK9hZT3x5dT1vBLZ1K1dGlaTLj5tQlvRoOhUQnOoffmR
         tKfN/XnbYZhu1eTUfoZPbTKiQ/09PqRB9ZIJztYvcblRd9w6WYDfRvEEvQOq+RKdkCiP
         Upx4zQA6bxIedSpbIY9JeXIaUUAV96ZUV7lOJFb0RU23MuqpK7RQqV7RKsggm6XtF+IU
         1efw==
X-Gm-Message-State: ALQs6tD0Z7GoAHLjimIeQhiQRG5uheD8VgSe+2tRyIcovHS04DIYY0pl
        DWNgsl3RcZVKobKam5Ez7Ae/eGLH
X-Google-Smtp-Source: AIpwx48kA1704x1ABhhpd/CFXCRCvjSq2OXMlZk5J33yyGPcm6AhE8qJIjQvBIhpxkTB5fTw7eDrnA==
X-Received: by 10.80.184.9 with SMTP id j9mr16332373ede.272.1523188135031;
        Sun, 08 Apr 2018 04:48:55 -0700 (PDT)
Received: from evledraar (dhcp-089-098-184-206.chello.nl. [89.98.184.206])
        by smtp.gmail.com with ESMTPSA id 94sm9593603edk.43.2018.04.08.04.48.53
        (version=TLS1_2 cipher=ECDHE-RSA-CHACHA20-POLY1305 bits=256/256);
        Sun, 08 Apr 2018 04:48:54 -0700 (PDT)
From:   =?utf-8?B?w4Z2YXIgQXJuZmrDtnLDsA==?= Bjarmason <avarab@gmail.com>
To:     jiangwei zhao <wei257429821@gmail.com>
Cc:     git@vger.kernel.org
Subject: Re: something about git clone
References: <CAJ1nrkCrvFAR4qD1ay9CCG80mRUf1BhcRtV21rOSh6BzVSoY6w@mail.gmail.com>
User-agent: Debian GNU/Linux 9.4 (stretch); Emacs 25.1.1; mu4e 1.1.0
In-reply-to: <CAJ1nrkCrvFAR4qD1ay9CCG80mRUf1BhcRtV21rOSh6BzVSoY6w@mail.gmail.com>
Date:   Sun, 08 Apr 2018 13:48:53 +0200
Message-ID: <87muydzzoa.fsf@evledraar.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org


On Sun, Apr 08 2018, jiangwei zhao wrote:

> hello!
>   i am a chinese.
>   i have some question for you ,i want to know how 'git clone'work,
> it likes downloader? or other things. i think it'sdown speed is
> heigher,so i email to you .
> thanks ,and my english is so poor.:P

You will not get the same speed from "git clone" as "wget" of a static
file, since the server may need to do a lot more work to serve you, so
it will be slower than downloading a static file.

