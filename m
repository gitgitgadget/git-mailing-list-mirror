Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-2.8 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_HI,RCVD_IN_MSPIKE_H3,
	RCVD_IN_MSPIKE_WL,RCVD_IN_SORBS_SPAM,RP_MATCHES_RCVD shortcircuit=no
	autolearn=no autolearn_force=no version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id CB2CC1FAA8
	for <e@80x24.org>; Tue, 16 May 2017 19:11:24 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1752154AbdEPTLW (ORCPT <rfc822;e@80x24.org>);
        Tue, 16 May 2017 15:11:22 -0400
Received: from mail-it0-f44.google.com ([209.85.214.44]:37131 "EHLO
        mail-it0-f44.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1751272AbdEPTLV (ORCPT <rfc822;git@vger.kernel.org>);
        Tue, 16 May 2017 15:11:21 -0400
Received: by mail-it0-f44.google.com with SMTP id g126so93971420ith.0
        for <git@vger.kernel.org>; Tue, 16 May 2017 12:11:21 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=mime-version:in-reply-to:references:from:date:message-id:subject:to
         :cc;
        bh=rutzmMsDTABFQivy0FeMhxVcUVpGT3ULB0pRsjOxOgY=;
        b=PaCDPQ62ABFJbHZgUk+dokGKJB8igLOCa0SKvPZIplxkdDYbJlBzhAtRWsG2CepRmY
         /BYkMQUMeq2bcKn7NanYj5vnKI0o1mwc3nY8jC9rUn8BHosjQ9O9QIhl9IWuo/NqpGYY
         S1PUhs0jvkyus8Da9M7PQKdj9xM85JCPGDz9tblopxplH96VqHt63j2EEnSELgpro8YU
         bjebeEwW8m+IhlmfWQ+iWoSVWCldG6RYikr+2flgepUEDjob+q0tb1Fwr3RHtJb9zDtL
         duoJ4o2BWvc22msOHiy7qhTTGHdcxI37kUi2jef6LF6WsyFPIv1NA4qiV/NtsZBSP15Q
         9Hqg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:in-reply-to:references:from:date
         :message-id:subject:to:cc;
        bh=rutzmMsDTABFQivy0FeMhxVcUVpGT3ULB0pRsjOxOgY=;
        b=JasTnhYrswhH7KPTyMJK3pOwaBfCAa9I/JPDW0QdaXSqVqYLIxn3vE6akO9QPCmQWR
         MK15l5zd/0u3tJrxYvVf2m8nA76Yu13KzwlKCGhg850QuhZ/6CKBO2cjEg2mwYYVHzzy
         PiRBOUweixdCw3IyXefkWoLzXXHAIUv2ZNGK6C2xxnyrUsoNV56dVpl07M9tN87MjW30
         sFaJ4c7t0zbtUcP+H2THqCqcpOPgFwqXm+w9GA/8gy+SJOqZV8Kruc6pzp+WSEQXFI0l
         Jdi00VcpUcaAPFSZQiRB4DsUPeyCrQ1FalTemV28C7LmjDD/YMzC2Ots7qoFHalepQOa
         hNNw==
X-Gm-Message-State: AODbwcBGsJn7YHyRPt4C+gQRtiPO/9TPQ5mwxj638j2TshC2fqyYye96
        Su6xpsfYVI/hNFlIabbRUrbeSjxiBA==
X-Received: by 10.36.210.193 with SMTP id z184mr270086itf.86.1494961880964;
 Tue, 16 May 2017 12:11:20 -0700 (PDT)
MIME-Version: 1.0
Received: by 10.79.150.90 with HTTP; Tue, 16 May 2017 12:10:40 -0700 (PDT)
In-Reply-To: <CAGHpTBLGwGXZk=xAB+Pb4GvtqN8+K=8BuaA-zov9sZZat-OYHQ@mail.gmail.com>
References: <CAGHpTBLGwGXZk=xAB+Pb4GvtqN8+K=8BuaA-zov9sZZat-OYHQ@mail.gmail.com>
From:   Samuel Lijin <sxlijin@gmail.com>
Date:   Tue, 16 May 2017 15:10:40 -0400
Message-ID: <CAJZjrdUPU8bGji9yCv-8CWN2zaV8WSkvTv+9c3Q5pmnrgyaEXw@mail.gmail.com>
Subject: Re: bug with git add and .gitignore
To:     Orgad Shaneh <orgads@gmail.com>
Cc:     git <git@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

On Wed, May 10, 2017 at 9:44 AM, Orgad Shaneh <orgads@gmail.com> wrote:
> Hi,
>
> When a not-ignored file inside an ignore directory is added along with
> other files, a false alarm is shown:
>
> git init
> echo /d/ > .gitignore
> mkdir d
> touch d/file foo
> git add -f d/file foo
> git add d/file
> # fine
> git add d/file foo
> # The following paths are ignored by one of your .gitignore files:
> # d
> # Use -f if you really want to add them.

For anyone who wants to take a shot at this, the reason this happens
is because when "add d/file foo" is invoked, when add.c:cmd_add()
calls fill_directory(), d/ gets added to dir->ignored, so add_files()
complains. I'm not sure if that's *supposed* to happen, and the issue
is somewhere else, or the call to read_directory_recursive() from
fill_directory() doesn't properly respect the pathspec.

> I did not try to add a new file in d. It's the same file that is
> already indexed.
>
> - Orgad
