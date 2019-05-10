Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.2 (2018-09-13) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-3.0 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	FROM_EXCESS_BASE64,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,
	RCVD_IN_DNSWL_HI shortcircuit=no autolearn=ham autolearn_force=no
	version=3.4.2
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id B89331F45F
	for <e@80x24.org>; Fri, 10 May 2019 23:26:50 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727957AbfEJX0t (ORCPT <rfc822;e@80x24.org>);
        Fri, 10 May 2019 19:26:49 -0400
Received: from mail-ed1-f68.google.com ([209.85.208.68]:40642 "EHLO
        mail-ed1-f68.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727407AbfEJX0t (ORCPT <rfc822;git@vger.kernel.org>);
        Fri, 10 May 2019 19:26:49 -0400
Received: by mail-ed1-f68.google.com with SMTP id j12so6552016eds.7
        for <git@vger.kernel.org>; Fri, 10 May 2019 16:26:48 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:references:user-agent:in-reply-to:date
         :message-id:mime-version;
        bh=ckawVIMRIN939vYRjGU+FsgHli9qZhIIziZwKGO4VuE=;
        b=U0265KAh7WjzSAfVPiJFNBQW6E1mP7xXe8hOUEr1QhequUEN2rbJWrLYUfGwZXBR+H
         zIBfEBUKDbvVAT3+CLBvCg/Qh12oEk4ErVJzBNODKJEW//XlQ0LoYybo08E07g0jEmdP
         7t0wmNoe9VaCLoQXpvApLyu4GhTyE8B/6lWYkfjMYj/PuigQKlulsGoaVQBpt15MR0+H
         7ZeUNROTbaVaZutxBA8lNqhB/ri7G3Y1dnE056t1i4qU16ub84Hc80NofsHykxy21CWL
         Dn1L5RQBboduhY3iiae9RYX5vnLBUno7Lm5eeaAs7lv/C03Rr+ZpSsRY+GhtWegGpr35
         F18A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:references:user-agent
         :in-reply-to:date:message-id:mime-version;
        bh=ckawVIMRIN939vYRjGU+FsgHli9qZhIIziZwKGO4VuE=;
        b=RnX9cgk0LkGOR47q1+VH3j9+X6UX5SOqPHErt3SEJYXUmw27TqHHbWWGHT0cJBHynu
         WDxgZfoCsbrLsc1+E2PnU84vnjIElhbhmvKw1rfScg24Pf5qyUs7oRRqbIe/GCLJOLZy
         KUxi2JeuNhXIvu1b8PcE2mKxMPSYMXIH/nf3ForetT95UWARru+Y4Je6dSuGJrbI9ZOw
         g1wz/M3qVsYjoawjJ9spFl/ZOT7C4v42Yh1bdw0yxJTBHM+xfpD+rIbCVnebXmMpsl0T
         0k+FuntCe9gx5pz1T8bJ7gtt9PQFtdgKAhtLtxv3LK7j9cNi9lOBwsgWRHIJHNzdoAW1
         bBIA==
X-Gm-Message-State: APjAAAU5Spmk64nqBrv/2u2mk3wYINx5jrquIl6fNaHEyAGn5RLTQZ/G
        5Wdiu6cQ+8Bsd1ZYWkgi0szS69Ynytw=
X-Google-Smtp-Source: APXvYqzI/x7BUnOINTY7+za22zHl2AMbqZuYg3mVx1u5mb8ZIclYP+fs7Q90tsdYM1TZXLwWBxm8ag==
X-Received: by 2002:a17:906:6450:: with SMTP id l16mr11156288ejn.146.1557530807498;
        Fri, 10 May 2019 16:26:47 -0700 (PDT)
Received: from evledraar (dhcp-077-251-215-224.chello.nl. [77.251.215.224])
        by smtp.gmail.com with ESMTPSA id r20sm1784357edx.46.2019.05.10.16.26.46
        (version=TLS1_2 cipher=ECDHE-RSA-CHACHA20-POLY1305 bits=256/256);
        Fri, 10 May 2019 16:26:46 -0700 (PDT)
From:   =?utf-8?B?w4Z2YXIgQXJuZmrDtnLDsA==?= Bjarmason <avarab@gmail.com>
To:     Boxuan Li <liboxuan@connect.hku.hk>
Cc:     git@vger.kernel.org
Subject: Re: [PATCH] doc/gitattributes: add Octave
References: <20190510004715.29298-1-liboxuan@connect.hku.hk>
User-agent: Debian GNU/Linux buster/sid; Emacs 26.1; mu4e 1.1.0
In-reply-to: <20190510004715.29298-1-liboxuan@connect.hku.hk>
Date:   Sat, 11 May 2019 01:26:45 +0200
Message-ID: <87woixx556.fsf@evledraar.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org


On Fri, May 10 2019, Boxuan Li wrote:

> `matlab` pattern is also suitable for source code
> in the GNU Octave language.
>
> Signed-off-by: Boxuan Li <liboxuan@connect.hku.hk>
> ---
>  Documentation/gitattributes.txt | 2 +-
>  1 file changed, 1 insertion(+), 1 deletion(-)
>
> diff --git a/Documentation/gitattributes.txt b/Documentation/gitattributes.txt
> index 4fb20cd0e9..1b28381bda 100644
> --- a/Documentation/gitattributes.txt
> +++ b/Documentation/gitattributes.txt
> @@ -819,7 +819,7 @@ patterns are available:
>
>  - `java` suitable for source code in the Java language.
>
> -- `matlab` suitable for source code in the MATLAB language.
> +- `matlab` suitable for source code in the MATLAB/Octave language.
>
>  - `objc` suitable for source code in the Objective-C language.

I've never used either, but browsing our patterns I see:

         "^[[:space:]]*((classdef|function)[[:space:]].*)$|^%%[[:space:]].*$",

I.e. that last bit matches ^%%, and then here:
https://en.wikibooks.org/wiki/MATLAB_Programming/Differences_between_Octave_and_MATLAB

    MATLAB uses the percent sign '%' to begin a comment. Octave uses
    both the hash symbol # and the percent sign % interchangeably.

So here we have the "function" pattern matching a comment, right? (this
doesn't have any tests) and we'd want to add "#" to Octave, but not
MATLAB.

I see both tend to use the ".m" extension. Anyway, isn't it better to
add an "octave" pattern, and document that they're mostly the same
(although it looks like we can add #-comments, to future-proof
ourselves?
