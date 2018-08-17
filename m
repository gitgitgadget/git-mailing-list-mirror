Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.1 (2015-04-28) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-3.2 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	FROM_EXCESS_BASE64,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,
	RCVD_IN_DNSWL_HI shortcircuit=no autolearn=ham autolearn_force=no
	version=3.4.1
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 236721F954
	for <e@80x24.org>; Fri, 17 Aug 2018 13:22:30 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726545AbeHQQZv (ORCPT <rfc822;e@80x24.org>);
        Fri, 17 Aug 2018 12:25:51 -0400
Received: from mail-ed1-f42.google.com ([209.85.208.42]:35342 "EHLO
        mail-ed1-f42.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725800AbeHQQZv (ORCPT <rfc822;git@vger.kernel.org>);
        Fri, 17 Aug 2018 12:25:51 -0400
Received: by mail-ed1-f42.google.com with SMTP id e6-v6so4526436edr.2
        for <git@vger.kernel.org>; Fri, 17 Aug 2018 06:22:27 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:references:user-agent:in-reply-to:date
         :message-id:mime-version;
        bh=Q90U1F+lyc0Kf/JYtf6aCqR7en51qmekG35QokHU4e8=;
        b=hRUFqBcdIbHvgJ8Y3nMRXRxQwettgtM5mAfPiWyhlUc32WFu2MiyptlGujpf2SF6rj
         UlqLimTHP/OIOrAHUJRchnfu6G8h1ijpSUlfTKRRWfvdrKURVLVIKO6Kd10N1HuPLQPg
         JqzmRMFHXTHr5W6VCvA0WmVe98nulm3aZkV2S7VHvRnkX6TCvTsM+zGWYqWuJWLgeAuO
         bMVfMdmNQvThcgjMcnVFzhCDIvtok6YD+TVwC/wyfY9LgBP6mDthN3hEUut91ee+OYrc
         Nw6CxEA5locJNx/ZpVTAciGkqGc7dbmWc9ETRAQTkN/Vj5pLy9SyGPExqY3T0mEvJdvN
         AKFg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:references:user-agent
         :in-reply-to:date:message-id:mime-version;
        bh=Q90U1F+lyc0Kf/JYtf6aCqR7en51qmekG35QokHU4e8=;
        b=R6s18+OD17K7zbp1WJkWH2iO0Z/7N2ZIOthi3bmijSbeabol8w9cO2x89sCo+V2sqC
         +/+LBn/gVMIrVGcU1pmwOl616RAYpcmimbFPo+1cKmSNUGwOmlcQcTzZd9Sq/uuiXdSn
         U28VoJM0l60azE5q5vxgccpSz7fvwSvzpu2KUCrPBQOOWMj/MBhdQnXmZJ8ATLODp3gS
         344QFKS55Qx6cjql1uO36juXhXEZoe1LgnsfSiKjgrLwcV6xouvNjkgEQwyIjru4JVQY
         X0i/f6sJrdM/0TKpvf07SQG19Xl16ZCt+rP1udGOF0QeOz2S+jGL+a+3PcVcUrNTB162
         M/kA==
X-Gm-Message-State: AOUpUlFkIy6A1xayBTwllN/OrfByt6FipkMJLZOkDGEl9x29svAR0YzK
        G6rmAT2orKRSalNJrvUsb+SzBwhvo9g=
X-Google-Smtp-Source: AA+uWPynndoGgXyb88O2iKwOq0CGqaj6xgPXw/0s7CnKS4RGNciGmZJ72eBdfUW4OuiiC/YqZnzrcA==
X-Received: by 2002:a50:8dcb:: with SMTP id s11-v6mr41393210edh.86.1534512146888;
        Fri, 17 Aug 2018 06:22:26 -0700 (PDT)
Received: from evledraar (h98111.upc-h.chello.nl. [62.194.98.111])
        by smtp.gmail.com with ESMTPSA id q26-v6sm2417433eda.35.2018.08.17.06.22.25
        (version=TLS1_2 cipher=ECDHE-RSA-CHACHA20-POLY1305 bits=256/256);
        Fri, 17 Aug 2018 06:22:26 -0700 (PDT)
From:   =?utf-8?B?w4Z2YXIgQXJuZmrDtnLDsA==?= Bjarmason <avarab@gmail.com>
To:     Samuel Maftoul <samuel.maftoul@gmail.com>
Cc:     git <git@vger.kernel.org>
Subject: Re: [RFC] git send-email hashbang
References: <CAFj+z07x=X0_8Tdg6KsVwyRhcaUTGrSA2=t5W91m9b702A0xUA@mail.gmail.com>
User-agent: Debian GNU/Linux testing (buster); Emacs 25.2.2; mu4e 1.1.0
In-reply-to: <CAFj+z07x=X0_8Tdg6KsVwyRhcaUTGrSA2=t5W91m9b702A0xUA@mail.gmail.com>
Date:   Fri, 17 Aug 2018 15:22:25 +0200
Message-ID: <878t55qga6.fsf@evledraar.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org


On Fri, Aug 17 2018, Samuel Maftoul wrote:

> I recently contributed for the first time patches on this maillist and
> used for the first time `git format-patch` and `git send-email`.
> I had hard times making `git send-email` work on my mac, because the
> OSX bundled perl was missing the Net::SMTP::SSL module.
> So I did `cpan -f Net::SMTP::SSL` (I'm using gmail with smtps/ssl)
> which asked me some questions (to setup cpan, I'm not really using
> perl usually), and installed the module.
> Still `git send-email` wasn't able to find the module.
> Actually, during the setup of cpan, I have been asked this:
>
> --------------------------
> Warning: You do not have write permission for Perl library directories.
>
> To install modules, you need to configure a local Perl library directory or
> escalate your privileges.  CPAN can help you by bootstrapping the local::lib
> module or by configuring itself to use 'sudo' (if available).  You may also
> resolve this problem manually if you need to customize your setup.
>
> What approach do you want?  (Choose 'local::lib', 'sudo' or 'manual')
> --------------------------
>
> I have naturally choosed the default ('local::lib'), but it still didn't worked.
>
> So I choose to not use the system bundled perl and installed my own
> perl with homebrew, installed the Net::SMTP::SSL module ... but still
> , it didn't worked.
> I looked at the send-email script, changed the hashbang to use
> /usr/local/bin/perl instead of /usr/bin/perl and it worked !
>
> Then I wondered what happened, and I discovered that using the bundled
> cpan's "sudo" approach works, but I'm not very satisfied that I need
> to be root to make this script work.
> I also found several stackoverflow questions, gists and other
> discussiond with people having this exact problem (on osx) with some
> different solution (mostly not working, using `sudo cpan` or
> whatever).

Yeah this experience sucks.

> It seems strange to me that the script doesn't uses "the perl I use in
> my environment", that is, I would have thought the `git-send-email.pl`
> script had `#!/usr/bin/env perl` as hashbang.
> Then, I read that some environment (namely busybox) don't bundle
> `/usr/bin/env`, so I understood this might not be portable.
> I think there is a solution involving using a combination of /bin/sh
> as hashbang and there executing perl with probably the `-x` flag (see
> `perldoc perlrun`).
> Is it worth proposing a solution for this problem ?

The reason not to use the "perl" in the env is because you just get the
other side of this problem. I.e. I install "git" on some linux distro,
but I also do perl development so I install a perlbrew version of it
into my ~/ which doesn't know how to do ssl or whatever else.

Now send-email, "git add -p" and the like will break because the perl I
have doesn't have the required modules etc.

This is why we pick a perl at compile-time, just as we link to libraries
etc. at compile-time.

But perhaps this trade-off isn't the right one to make on OSX.
