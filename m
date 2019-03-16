Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.2 (2018-09-13) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-2.9 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	FROM_EXCESS_BASE64,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,
	RCVD_IN_DNSWL_HI shortcircuit=no autolearn=ham autolearn_force=no
	version=3.4.2
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 0531320248
	for <e@80x24.org>; Sat, 16 Mar 2019 13:16:21 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726512AbfCPNNS (ORCPT <rfc822;e@80x24.org>);
        Sat, 16 Mar 2019 09:13:18 -0400
Received: from mail-ed1-f46.google.com ([209.85.208.46]:45255 "EHLO
        mail-ed1-f46.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726376AbfCPNNS (ORCPT <rfc822;git@vger.kernel.org>);
        Sat, 16 Mar 2019 09:13:18 -0400
Received: by mail-ed1-f46.google.com with SMTP id m16so3297345edd.12
        for <git@vger.kernel.org>; Sat, 16 Mar 2019 06:13:16 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:references:user-agent:in-reply-to:date
         :message-id:mime-version;
        bh=g69Ug9i9efP8WEXCgAwA5ZDuPli6vfJVo2Ocx6vCdhE=;
        b=sF06cRwGRZMoni5DXAZTzHHlyEljQaswWjSg8xPhDSesTy7fkcMEBnwQykPOgiVXHw
         LKEJ1fFStWU47liMG9MXzcWsH6O+3x9JfN39LyEvJaXfwbdRzmMo7RytDratjdkUwe/s
         iq8aMdwiMtZ5HYqhOy+XBsyGDdRtZNrntIz8+anYdnBwERRNxTzuZPaaizSerC4EbY7Z
         GfWQbg39evD+n8VLATdJ/TkdgIYPu/xNgvdn991Z2wRTkOdrCrZPt+kF13r82YvXTZLi
         z+ngvc6079jhKTEkTJlaqivKyvPdbQhMNth90qSJedOXKaHlGnFzVbriey21zK38RiKj
         ADTQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:references:user-agent
         :in-reply-to:date:message-id:mime-version;
        bh=g69Ug9i9efP8WEXCgAwA5ZDuPli6vfJVo2Ocx6vCdhE=;
        b=fPM/Gn9AuwuabPLTvM3oHv/2xBrUQcZqMAhr3ssDLbNU/I6EgD1+tH6Lzlehjff6Or
         FKm+ncg4VPwdSlDMM/JcTzbxHXETAaIu4eb5V1un0ukgdFxSbubbz2sMb5YRqPd4ol/h
         IuKFTPORcGacxOe0X4GSokzADLfY5KXAN0tebLWcVb3GSAro0qKMX9+AT4OPHznbWlFS
         RZvJqVEksxIbgeNQ/6AG7PYq0vQdraRHbRMBAdssT3mZt9aGFEjyJvUIUr/uc6VlqlnZ
         TIeJTUMxBYwFmqNw4XG1ou9+jRfxc5L5hOnGiGd+nRtNpYXaC8ph6Q8LuMGSNpvWP6ql
         alwg==
X-Gm-Message-State: APjAAAXANbcgjVSMjUFV6/djISJBfTluIyuhhSWjd1Ajm8D7SnuSDxZn
        nfg7Nxt+f9GRgrYaAcykgX5bEm5NND8=
X-Google-Smtp-Source: APXvYqwdCjkI2Zt/IagyikYHz/e3iIx1jXHjtAI85qf9bwsu2yTJyZFa+EvFGJ4rOqxviGbPGTwNTg==
X-Received: by 2002:aa7:c419:: with SMTP id j25mr6286395edq.195.1552741996173;
        Sat, 16 Mar 2019 06:13:16 -0700 (PDT)
Received: from evledraar (dhcp-077-251-215-224.chello.nl. [77.251.215.224])
        by smtp.gmail.com with ESMTPSA id w6sm1493556eds.0.2019.03.16.06.13.14
        (version=TLS1_2 cipher=ECDHE-RSA-CHACHA20-POLY1305 bits=256/256);
        Sat, 16 Mar 2019 06:13:15 -0700 (PDT)
From:   =?utf-8?B?w4Z2YXIgQXJuZmrDtnLDsA==?= Bjarmason <avarab@gmail.com>
To:     "Robert P. J. Day" <rpjday@crashcourse.ca>
Cc:     Git Mailing list <git@vger.kernel.org>
Subject: Re: "man gitattributes" doesn't explain comma-separated attribute values
References: <alpine.LFD.2.21.1903160816410.10724@localhost.localdomain>
User-agent: Debian GNU/Linux buster/sid; Emacs 26.1; mu4e 1.1.0
In-reply-to: <alpine.LFD.2.21.1903160816410.10724@localhost.localdomain>
Date:   Sat, 16 Mar 2019 14:13:14 +0100
Message-ID: <87r2b79d3p.fsf@evledraar.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org


On Sat, Mar 16 2019, Robert P. J. Day wrote:

>   more nitpicking, but i'm working my way through the intricacies of
> attributes and putting together some (allegedly) simple examples for a
> class i'm giving on monday, and i noted a couple possible shortcomings
> in "man gitattributes".
>
>   as a working example, i looked at the top-level .gitattributes file
> in the git source code itself, which opens with:
>
>   * whitespace=!indent,trail,space
>   *.[ch] whitespace=indent,trail,space diff=cpp
>   *.sh whitespace=indent,trail,space eol=lf
>   ... snip ...
>
> first observation is that i see nothing in the man page that explains
> the notion of a comma-separated list of attribute values. maybe i
> missed it or maybe it's supposed to be intuitively obvious, but
> there's nothing i can see that mentions the possibility.
>
>   related to that is that there is no explanation as to how to
> interpret:
>
>   * whitespace=!indent,trail,space
>
> does the "!" apply to "indent" or to the entire list? the man page
> doesn't say.
>
>   just being pedantic again.
>
> rday

It's documented in gitglossary, search for "attr". That's not an excuse
or a statement that that doesn't suck, just a pointer for anyone
interested in fixing the docs.
