Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.1 (2015-04-28) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-3.5 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,RCVD_IN_DNSWL_HI
	shortcircuit=no autolearn=ham autolearn_force=no version=3.4.1
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id B07631F453
	for <e@80x24.org>; Thu, 27 Sep 2018 06:37:41 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726820AbeI0MyS (ORCPT <rfc822;e@80x24.org>);
        Thu, 27 Sep 2018 08:54:18 -0400
Received: from mail-pg1-f196.google.com ([209.85.215.196]:43371 "EHLO
        mail-pg1-f196.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726708AbeI0MyS (ORCPT <rfc822;git@vger.kernel.org>);
        Thu, 27 Sep 2018 08:54:18 -0400
Received: by mail-pg1-f196.google.com with SMTP id q19-v6so1144276pgn.10
        for <git@vger.kernel.org>; Wed, 26 Sep 2018 23:37:39 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:content-transfer-encoding:in-reply-to
         :user-agent;
        bh=e6lJQic+C/nJpQlqh+Ftxlr7vEvzFtpi5E78fjOu/sk=;
        b=FSL71fXWghuP0q6fSFHNuXMOnIyjvYpySobKk4cSo5Fq5wzzYmHaQUGY2dBxBFxnEA
         D000ulLtECUReTY9UNFjCZjNF9oc5+4ptuVyqwSWAxgD8tca3YdTRLxx4UiUzKjESK/5
         lgxLnKsIfzE/mRfkv3tLBn2Lk9WWjCZ5idBAV4/YwovNaMNOaBX+foiuN5XxIf+x7hBo
         U0i7klD/+x/zL3GzbTvTAmx+MUrgmgmTDOBPVRQwPdIna69OEE0CXwP7oXjhERt4nw4W
         xNq3KmYfqqn3WGs0QWKpbQKq0QK2Z0JzzUZ9MWqsXD9HxiJh/GREvRcF+rzk4YpMw8O4
         OMBQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:content-transfer-encoding
         :in-reply-to:user-agent;
        bh=e6lJQic+C/nJpQlqh+Ftxlr7vEvzFtpi5E78fjOu/sk=;
        b=qFKWrnOpphkQ2uChs5a+wxCI/Z/hoPg1eBIdECjbP+UdbLtDfGxmMZUUbFkSm2Zvgp
         4tQ5++pqohA4NH3giwndRoYjL0v6TDw/LfSFS3IYDa5ctiM93vsV7Ei90pmMFjo6cyjW
         1bfFW2tQkdjIk91URoIP/9xWQE/tQdbbGImSGLd1OWxMFEx837DYNgA+6ttqo1/gVSqH
         m306ynBR8rGHw9vmoaJzXaECu8J+S9iZ30fJHI/qKwmHWPJuSBgo1L/xFPCr/GHBtbTr
         mcoQMXUTKy5NyDvSswiJJedMYIJQM2yNUHKyNOKFLX1MZgSHUy23/8FayAfO+hWZlurL
         iUYg==
X-Gm-Message-State: ABuFfogZI2m5xbHSxd+atXkI+2zLCeNdNQYB+tB8O475YgeAoHxCIZJR
        vx50T/mG9YfiZ9Xx9pdbVsM=
X-Google-Smtp-Source: ACcGV631adnLMgcfgIP91II6EWi4CYlEqvu8H9YqU8D2jhHGnIuX+bCnohxOI5pzVOwvo+VWMcFMSA==
X-Received: by 2002:a63:d40c:: with SMTP id a12-v6mr8665637pgh.394.1538030259076;
        Wed, 26 Sep 2018 23:37:39 -0700 (PDT)
Received: from aiede.svl.corp.google.com ([2620:0:100e:422:4187:1d6c:d3d6:9ce6])
        by smtp.gmail.com with ESMTPSA id p19-v6sm1366161pgh.60.2018.09.26.23.37.37
        (version=TLS1_2 cipher=ECDHE-RSA-CHACHA20-POLY1305 bits=256/256);
        Wed, 26 Sep 2018 23:37:38 -0700 (PDT)
Date:   Wed, 26 Sep 2018 23:37:35 -0700
From:   Jonathan Nieder <jrnieder@gmail.com>
To:     Martin =?utf-8?B?w4VncmVu?= <martin.agren@gmail.com>
Cc:     git@vger.kernel.org, Junio C Hamano <gitster@pobox.com>,
        Taylor Blau <me@ttaylorr.com>
Subject: Re: [PATCH v2] git.txt: mention mailing list archive
Message-ID: <20180927063735.GC220288@aiede.svl.corp.google.com>
References: <20180926134717.GC25697@syl>
 <20180927055018.6683-1-martin.agren@gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <20180927055018.6683-1-martin.agren@gmail.com>
User-Agent: Mutt/1.10.1 (2018-07-13)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Hi,

Martin Ågren wrote:

> --- a/Documentation/git.txt
> +++ b/Documentation/git.txt
> @@ -859,6 +859,9 @@ Reporting Bugs
>  Report bugs to the Git mailing list <git@vger.kernel.org> where the
>  development and maintenance is primarily done.  You do not have to be
>  subscribed to the list to send a message there.
> +If you want to check to see if the issue has
> +been reported already, the list archive can be found at
> +<https://public-inbox.org/git/> and other places.

Hm.  I think this encourages a behavior that I want to discourage:
assuming that if a bug has already been reported then there's nothing
more for the new user to add.

Especially because the mailing list is not an issue tracker, this
would make it too easy for the project to miss important bugs.

Can this say something more neutral, like

	See the list archive at https://public-inbox.org/git/ for
	previous bug reports and other discussions.

?  Or if we want to encourage a particular behavior, should we say
something about "To coordinate with others experiencing the same
problem" or something else that encourages joining in with the
thread instead of assuming it's taken care of?

Thanks,
Jonathan
