Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-2.8 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	FROM_EXCESS_BASE64,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,
	RCVD_IN_DNSWL_HI shortcircuit=no autolearn=ham autolearn_force=no
	version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id DE84E1F42D
	for <e@80x24.org>; Thu, 17 May 2018 09:48:40 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1751334AbeEQJsi (ORCPT <rfc822;e@80x24.org>);
        Thu, 17 May 2018 05:48:38 -0400
Received: from mail-wm0-f68.google.com ([74.125.82.68]:53717 "EHLO
        mail-wm0-f68.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1751017AbeEQJsg (ORCPT <rfc822;git@vger.kernel.org>);
        Thu, 17 May 2018 05:48:36 -0400
Received: by mail-wm0-f68.google.com with SMTP id a67-v6so7229103wmf.3
        for <git@vger.kernel.org>; Thu, 17 May 2018 02:48:36 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:references:user-agent:in-reply-to:date
         :message-id:mime-version;
        bh=p2H+3QQ7trhzySKl1VmPXp9mYove5ZT0Rezv+ZjOCUw=;
        b=Px0Tq1mkzYQ03GQflZGIzcfEilXLyj5cKrhZINStmjg+LPWjdCnO465V4msQAm6RfV
         IUHM/Ck0Sdr8bJ02eZkiFshgF+jQIj+Ni9xTcynD4Z0D020PnjeyHHyULEa6jgFHlNHz
         o+grnZQgxsNkkuBwE+N5HcWkpDlLLZCbDzwyCcy/3s1jpaV+9BvYabhy9cxGugT2aLEx
         Gg0Em107wQP6kpLBEfrns73chDNMtY17mbIy9q2IDnXxanSgfrhwDLY0HMU6pA6ZLens
         TJDDSqGTvT7yBAidfilt8j6BMUM8DrBkALHZlkcop2JCJUgAprGMIvsunPyg26iIois2
         DxiQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:references:user-agent
         :in-reply-to:date:message-id:mime-version;
        bh=p2H+3QQ7trhzySKl1VmPXp9mYove5ZT0Rezv+ZjOCUw=;
        b=Jd71gPefcXKSiGDcdfI0qkE1J9tn/Sqf7j5o4KPGf52/rqiTIvEtYg5lh9Yy1aiPM4
         TF3f+LqlJdkns4ORkYUkkjh9fG55iHNmfi+lk4ZnUWsS4+j9URFkHb1efoUji95qCgw4
         9jjF0rLLbi1RDzpBOb2J+bJiLm0F5t+lUc7qX+1yI3scxx0am+RmOxFgWQ8ocozwW/4N
         qtDppPUlIeFQ/D9/TLR3p/wdaKAXrzKPWSIFZ36sw0at+hbVlvs+qh+SpZQ3Xue5xmp5
         h2rg1uncLYWO3dZ8JIJDzBuHriNRRVnd/gibaYIo5dR1yc1E/uvJYUc6CZ4d6v/X0d2n
         0aAw==
X-Gm-Message-State: ALKqPwfdjXTx8lbfHxjnOo24RI3Avq4VhtWu39k+J23kKen6GG0UGDHB
        CEJRkijjBjQNGj3A7lXXKj4MT/wY
X-Google-Smtp-Source: AB8JxZqCrlRQZE+9MamEQma/4R7qZNWUjzoAzkLs5SgEZ5OtOn7FZeNj0xZ8JfVIjTapvgL52mB7LA==
X-Received: by 2002:a50:97d8:: with SMTP id f24-v6mr6058258edb.256.1526550515861;
        Thu, 17 May 2018 02:48:35 -0700 (PDT)
Received: from evledraar (proxy-gw-a.booking.com. [5.57.21.8])
        by smtp.gmail.com with ESMTPSA id e6-v6sm2258570edr.23.2018.05.17.02.48.34
        (version=TLS1_2 cipher=ECDHE-RSA-CHACHA20-POLY1305 bits=256/256);
        Thu, 17 May 2018 02:48:34 -0700 (PDT)
From:   =?utf-8?B?w4Z2YXIgQXJuZmrDtnLDsA==?= Bjarmason <avarab@gmail.com>
To:     Kaartic Sivaraam <kaartic.sivaraam@gmail.com>
Cc:     Junio C Hamano <gitster@pobox.com>, git@vger.kernel.org,
        Jeff King <peff@peff.net>
Subject: Re: jk/branch-l-0-deprecation (was Re: What's cooking in git.git (May 2018, #02; Thu, 17))
References: <xmqqvabm6csb.fsf@gitster-ct.c.googlers.com> <e440f6e0-6d7d-0e72-b875-de290cea6b94@gmail.com>
User-agent: Debian GNU/Linux testing (buster); Emacs 25.2.2; mu4e 1.1.0
In-reply-to: <e440f6e0-6d7d-0e72-b875-de290cea6b94@gmail.com>
Date:   Thu, 17 May 2018 11:48:33 +0200
Message-ID: <87fu2qbojy.fsf@evledraar.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org


On Thu, May 17 2018, Kaartic Sivaraam wrote:

> On Thursday 17 May 2018 11:31 AM, Junio C Hamano wrote:
>> * jk/branch-l-0-deprecation (2018-03-26) 3 commits
>>
>> ...
>>
>>  The "-l" option in "git branch -l" is an unfortunate short-hand for
>>  "--create-reflog", but many users, both old and new, somehow expect
>>  it to be something else, perhaps "--list".  This step deprecates
>>  the short-hand and warns about the future removal of the it when it
>>  is used.
>>
>>  Will cook in 'next'.
>>  Perhaps merge to 'master' immediately after 2.18 release?
>
> I still have a slight feeling that we shouldn't list the branches for
> "git branch -l" during the deprecation period. If feel this because
>
> 	i) It would avoid confusions for the users during the
> 	   deprecation period
>
> 	ii) The warning message seems to add to the confusion:
>
> 	    $ git branch -l
> 	    warning: the '-l' alias for '--create-reflog' is deprecated;
> 	    warning: it will be removed in a future version of Git
> 	    * master
> 	    ...
>
>
> 	    If there are ample branches, the warning message might be
> 	    hidden out of screen but we shouldn't rely on that, I
> 	    suppose.

Also if we have lots of branches, depending on your pager settings you
won't see this at all, I have:

    PAGER=less LESS="--IGNORE-CASE --LONG-PROMPT --QUIET --chop-long-lines --RAW-CONTROL-CHARS --no-init --quit-if-one-screen"

I've ended up with that $LESS setting via hackery over the years, so
maybe I'm doing something retarded, minimal test case:

    PAGER=less  LESS="--no-init --quit-if-one-screen" git branch -l

So with those two options I don't get the stderr output at all, but if I
remove either one of those options once I quit the pager I get the
output at the end.

So I think this is probably OK for most users, if the have very few
branches they'll see it, and then if they use default pager settings
they'll see the stderr output once they quit the pager. I don't know how
common my (mis)configuration is.
