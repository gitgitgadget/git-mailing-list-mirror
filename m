Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.2 (2018-09-13) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-3.0 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	FROM_EXCESS_BASE64,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,
	RCVD_IN_DNSWL_HI,SPF_HELO_NONE,SPF_NONE shortcircuit=no autolearn=ham
	autolearn_force=no version=3.4.2
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 2C8C31F462
	for <e@80x24.org>; Sat, 15 Jun 2019 08:20:48 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726334AbfFOITG (ORCPT <rfc822;e@80x24.org>);
        Sat, 15 Jun 2019 04:19:06 -0400
Received: from mail-ed1-f66.google.com ([209.85.208.66]:43271 "EHLO
        mail-ed1-f66.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725825AbfFOITG (ORCPT <rfc822;git@vger.kernel.org>);
        Sat, 15 Jun 2019 04:19:06 -0400
Received: by mail-ed1-f66.google.com with SMTP id e3so7076170edr.10
        for <git@vger.kernel.org>; Sat, 15 Jun 2019 01:19:05 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:references:user-agent:in-reply-to:date
         :message-id:mime-version;
        bh=uhucBgBFUX9+x1eyRErwJP21IuKwUUarG0hTEBm+pJ4=;
        b=viOpgoXTdisg2MvqTPyu+XEcrKLk7f13BkIr6TcGQ+LgEcpF14lS8dKmUu8fhjsbzm
         xfO4ZP4oscq6XRBLQWBDx/SavnqhnRPWD/0lGsBWEeQOrL8PW0qTQXGvTUU9BVPDqemw
         T8ieHmqUlg3KIeX67DLbI/6xvySoges9sAoH7UCiHdiMtMoYlBqwoCnzPa7qgAcfbvr/
         eWfR92wE2ho5cV7ZuY5801FKYJIfsuw3XchEBb6fQlg6qyQ8geAGJwg6Vr4gD+ILzhVw
         NQU9pmyREeQFrzMXnOTjvi3d0XgXExN8faAV6TCJgYoociIHOHR0nYE1DuNYeSoatbKW
         kVBw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:references:user-agent
         :in-reply-to:date:message-id:mime-version;
        bh=uhucBgBFUX9+x1eyRErwJP21IuKwUUarG0hTEBm+pJ4=;
        b=W1NT4t5lg9oB+CS0VZ85hwWaBZ8+xYUOsmtrslhFIaq76VMZk+fjfDVEQAe2VGaKd6
         NVqxp2ODTVwDxqjKCZsgPzzoWhbUqjjj8grFxif0ZvdJYBL84BGu9MZIJDf/xhn46abt
         brC24JslsmVTPIEXLrAm0YurZefviOZZUaOThipTjgw2OojjtBey56sd48dov6UzJIo7
         hvEyhrAcH3bW5qzKLpCGCzjFpX5AG/1CtqlcmTZVOqbhwOOhR/SwYx4lqPZk6o2Pmfp5
         GyAt1qS1DSG5gjKBAYL7fW42weRYo/1a508SfnOinohjXtqYoYllgyPMlgd7J71azF3j
         AnWA==
X-Gm-Message-State: APjAAAWOuVCo5DXoLHxnEx7UxJm87j1cc/oNDwybyEBJ+PzuqAdEwEbD
        jnqp61XoNPFFxVfF1ZdsXFs=
X-Google-Smtp-Source: APXvYqxmhV9AcFfJu0WxsEDgEpaMnxgNZYWaqIopdZ5Z7nC6bdrHYtwBgHrSiEjZ+02hw87LG/IZ2g==
X-Received: by 2002:a17:906:5042:: with SMTP id e2mr19021394ejk.220.1560586744208;
        Sat, 15 Jun 2019 01:19:04 -0700 (PDT)
Received: from evledraar (i237193.upc-i.chello.nl. [62.195.237.193])
        by smtp.gmail.com with ESMTPSA id w17sm1554077edi.15.2019.06.15.01.19.03
        (version=TLS1_3 cipher=AEAD-AES256-GCM-SHA384 bits=256/256);
        Sat, 15 Jun 2019 01:19:03 -0700 (PDT)
From:   =?utf-8?B?w4Z2YXIgQXJuZmrDtnLDsA==?= Bjarmason <avarab@gmail.com>
To:     Phil Hord <phil.hord@gmail.com>
Cc:     Git <git@vger.kernel.org>, CB Bailey <cb@hashpling.org>
Subject: Re: Deadname rewriting
References: <CABURp0poUjSBTTFUXP8dAmJ=37qvpe64=o+t_+mHOiK9Cv+=kg@mail.gmail.com>
User-agent: Debian GNU/Linux 10 (buster); Emacs 26.1; mu4e 1.1.0
In-reply-to: <CABURp0poUjSBTTFUXP8dAmJ=37qvpe64=o+t_+mHOiK9Cv+=kg@mail.gmail.com>
Date:   Sat, 15 Jun 2019 10:19:02 +0200
Message-ID: <87sgsb8dmx.fsf@evledraar.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org


On Sat, Jun 15 2019, Phil Hord wrote:

> I know name-scrubbing is already covered in filter-branch and other
> places. But we have a scenario becoming more common that makes it a
> more sensitive topic.
>
> At $work we have a long time employee who has changed their name from
> Alice to Bob.  Bob doesn't want anyone to call him "Alice" anymore and
> is prone to be offended if they do.  This is called "deadnaming".
>
> We are able to convince most of our work tools to expunge the deadname
> from usage anywhere, but git stubbornly calls Bob "Alice" whenever
> someone asks for "git blame" or checks in "git log".
>
> We could rewrite history with filter-branch, but that's quite
> disruptive.  I found some alternatives.
>
> .mailmap seems perfect for this task, but it doesn't work everywhere
> (blame, log, etc.).  Also, it requires the deadname to be forever
> proclaimed in the .mailmap file itself.
>
> `git replace` works rather nicely, except all of Bob's old commits
> show "replaced" in the decorator list. Also, it doesn't propagate well
> from the central server since `refs/replaces` namespace isn't fetched
> normally.  But in case anyone wants it, here's what I did:
>
> git log --author=alice.smith --format="%h" --all |
>    while read hash ; do
>       GIT_EDITOR='sed -i -e s/Alice Smith/Bob Smith/g' -e
> 's/alice.smith/bob.smith/' \
>       git replace --edit $hash
>    done
> git push origin 'refs/replace/*:refs/replace/*'
>
> I'd quite like the .mailmap solution to work, and I might flesh that
> out that some day.
>
> It feels like `.git/info/grafts` would work the best if it could be
> distributed with the project, but I'm pretty sure that's a non-starter
> for many reasons.
>
> Any other ideas?  Has anyone here encountered this already?

What should be done is to extend the .mailmap support to other
cases. I.e. make tools like blame, shortlog etc. show the equivalent of
%aN and %aE by default.

This topic was discussed at the last git contributor summit (brought up
by CB Bailey) resulting in this patch, which I see didn't make it in &
needs to be resurrected again:
https://public-inbox.org/git/20181212171052.13415-1-cb@hashpling.org/

So, patches welcome :)

What's not going to be supported is some notion of 100% forgetting that
there was ever an Alice that's now called Bob. They did in fact create
commit objects with "Alice" in them, and low-level plumbing like
"cat-file -p <commit>" is always going to show that, and there's going
to be the mapping in .mailmap.

But as far as porcelain UI things that would show the mailmapped value
goes those can be made to always show "Bob".

Unless of course your $work is willing to completely rewrite the repo...
