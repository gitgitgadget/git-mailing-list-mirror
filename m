Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-2.8 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_HI,RCVD_IN_SORBS_SPAM,
	RP_MATCHES_RCVD,T_DKIM_INVALID shortcircuit=no autolearn=no
	autolearn_force=no version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id B8CE31FC44
	for <e@80x24.org>; Mon, 13 Feb 2017 22:06:34 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1751297AbdBMWGc (ORCPT <rfc822;e@80x24.org>);
        Mon, 13 Feb 2017 17:06:32 -0500
Received: from mail-it0-f68.google.com ([209.85.214.68]:34282 "EHLO
        mail-it0-f68.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1750943AbdBMWGc (ORCPT <rfc822;git@vger.kernel.org>);
        Mon, 13 Feb 2017 17:06:32 -0500
Received: by mail-it0-f68.google.com with SMTP id r141so780924ita.1
        for <git@vger.kernel.org>; Mon, 13 Feb 2017 14:06:31 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=sender:from:to:cc:subject:references:date:in-reply-to:message-id
         :user-agent:mime-version;
        bh=og6dlcvjtikibtqOGy5iuJWMV4dcr4lHDEcyRgC4gWQ=;
        b=j3ZMnFL/EaGMVT6sHuv1xpYh8i42xW0KMYWoaoT+XiArz58xOqffx6C50lMhmacbes
         FoEpl+Bu9fXmuAM2Vb3sJVeTrjrHtnTsegYIbct+BZg5xI7/CdUWoEblp/v3aH/2i+j/
         xqSwItXdRZROT33XU2KRdqYgIIu68DWhN67ECksmT+yigcnL6ta2OVLWpJUN4wGpus7U
         8xIQXimKTVR6isyjlO8qpaItFP4s4SZiVFbbrxqMVWAsBRhbtzK8h46Ra+vRmZFOPbK4
         t/DVKn4a0APZpaoXwRGpF6vrOOLjOF3AoSzBdD1s8CgYF9DHHp3Kx/UlXuSBgMqDOuSZ
         bx6Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:sender:from:to:cc:subject:references:date
         :in-reply-to:message-id:user-agent:mime-version;
        bh=og6dlcvjtikibtqOGy5iuJWMV4dcr4lHDEcyRgC4gWQ=;
        b=X9k0nDmhe93wZ7+I6n99hfWPXBDYYKG8ItiM3gQ+LHFWiMP1hmwMoIPxxwB/lzedx3
         vMcy4EgRznauaI48n6rl6B6ChXNEmCapWTm2mdMXv0+dsJZeX+5GfbTnwrHksH0MwQCq
         yKupCkkEk5YbDS1GNG7ANVckDgL8vhHSw29uO2yxyqLrfl8js72JJuxzP2VOXKJDvvv7
         zC8GwkAQlNj0NWspoBCmW/pD/FCeXcUE6t8xTD9yqdODVVvlMwQT+0hpKqkNnU/8dWTL
         fpad4gLSesPyXe89+s+/NZrqJTgFWDNQB5r8GY4elI1lYDHMDq9b1b7z+MdK/UVmaUxS
         jiqQ==
X-Gm-Message-State: AMke39mOV2gH3V+tHplVW/ZXue47cmybaHxjU5biaJTkpPSBYLQj1lBcvjQg6o/2kRtALA==
X-Received: by 10.99.247.83 with SMTP id f19mr28855385pgk.158.1487023591117;
        Mon, 13 Feb 2017 14:06:31 -0800 (PST)
Received: from localhost ([2620:0:1000:8622:d0e0:42a7:601f:5154])
        by smtp.gmail.com with ESMTPSA id p17sm16419525pfi.97.2017.02.13.14.06.30
        (version=TLS1_2 cipher=AES128-SHA bits=128/128);
        Mon, 13 Feb 2017 14:06:30 -0800 (PST)
From:   Junio C Hamano <gitster@pobox.com>
To:     Jeff King <peff@peff.net>
Cc:     git@vger.kernel.org
Subject: Re: [PATCH] docs/git-submodule: fix unbalanced quote
References: <20170213203835.vssj64tcvuq35dny@sigill.intra.peff.net>
        <20170213210549.jns7asrvjp3lb5wc@sigill.intra.peff.net>
Date:   Mon, 13 Feb 2017 14:06:29 -0800
In-Reply-To: <20170213210549.jns7asrvjp3lb5wc@sigill.intra.peff.net> (Jeff
        King's message of "Mon, 13 Feb 2017 16:05:49 -0500")
Message-ID: <xmqqtw7xbva2.fsf@gitster.mtv.corp.google.com>
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/25.1.91 (gnu/linux)
MIME-Version: 1.0
Content-Type: text/plain
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Jeff King <peff@peff.net> writes:

> However, let's take a step back. Even when rendered
> correctly, it's hard to read a long command stuck into the
> middle of a paragraph, and the important punctuation is hard
> to notice.

Yes, I like this reasoning behind the solution very much.

Thanks.

>  Documentation/git-submodule.txt | 9 ++++++---
>  1 file changed, 6 insertions(+), 3 deletions(-)
>
> diff --git a/Documentation/git-submodule.txt b/Documentation/git-submodule.txt
> index 918bd1d1b..a8eb1c7ce 100644
> --- a/Documentation/git-submodule.txt
> +++ b/Documentation/git-submodule.txt
> @@ -228,9 +228,12 @@ foreach::
>  	the processing to terminate. This can be overridden by adding '|| :'
>  	to the end of the command.
>  +
> -As an example, +git submodule foreach \'echo $path {backtick}git
> -rev-parse HEAD{backtick}'+ will show the path and currently checked out
> -commit for each submodule.
> +As an example, the command below will show the path and currently
> +checked out commit for each submodule:
> ++
> +--------------
> +git submodule foreach 'echo $path `git rev-parse HEAD`'
> +--------------
>  
>  sync::
>  	Synchronizes submodules' remote URL configuration setting
