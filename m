Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-2.6 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_HI,RCVD_IN_SORBS_SPAM,
	RP_MATCHES_RCVD shortcircuit=no autolearn=no autolearn_force=no version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 7D7751F71C
	for <e@80x24.org>; Sun,  7 May 2017 22:15:45 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1754100AbdEGWPm (ORCPT <rfc822;e@80x24.org>);
        Sun, 7 May 2017 18:15:42 -0400
Received: from mail-ua0-f196.google.com ([209.85.217.196]:33187 "EHLO
        mail-ua0-f196.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1751412AbdEGWPl (ORCPT <rfc822;git@vger.kernel.org>);
        Sun, 7 May 2017 18:15:41 -0400
Received: by mail-ua0-f196.google.com with SMTP id z47so1150074uaz.0
        for <git@vger.kernel.org>; Sun, 07 May 2017 15:15:41 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=mime-version:from:date:message-id:subject:to:cc;
        bh=IYRKJeKNGDMo08TMzWvzsSBwp9NZihF4c2icyub2Mkw=;
        b=L3MSzbpRMdjOgZbRdNTb2Ff/Sl9GQoYvHpH/DkT0mspOOIyNBVuo+wtTcVUWXGXEXM
         avTVKlk4BH55LU5vVaHMdHGcdv/BB9ichyvQbJMHM870mBnHUv0UJD+ChVdb/XXyRd97
         EcZUcyP/TT1Oz/xApq72GJIQf8n0D4fObplZzN+br+D4XwTiEkglZ0V3A2vXvtNwxGaR
         QXrj8uCyWlGZpmyDDQU03/YHQEfCXBv7K4jO+3qUSD3Ofb4mbYThuKXUXqRrGC/ZS9qj
         ZDmLOf1YmFivsFOEq4oiSAw3AGdvvfxx8N7jSdiJDIB24uh6JB5kLD+GeYrgFgSn94J8
         UHUQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:from:date:message-id:subject:to:cc;
        bh=IYRKJeKNGDMo08TMzWvzsSBwp9NZihF4c2icyub2Mkw=;
        b=nvisQxQtOiAvZopLNbEbXNwai9PCFTgIaNHXWqkh2I8IHkBiQt3leEgCk+GinIj9mF
         GfN1aNeJ/KSZWKBt8DvrWpNekEXKZBAtBjmPBwuOPYkjEqBG01yAx7gDGhINuDZBybAs
         BWxfW84AGtzhyEAl/IBZ9ESDOU8yoSqDZsQhB2mPZBjHMgI2P1WsHeFDV+9iVV8gSEI1
         K7BjpEmJEIswYUuVip5uCNDua3LI5oakJuHAdj2SqFdodWX2kSxrpiA3+amgN3YOVVam
         LqxcZk9uU8JXDHdk2e2+oiaTcboELb19TsccwWi5jsVkcfeDCl9i8jTpneEY1IM71YNz
         T6eg==
X-Gm-Message-State: AN3rC/7VPlwKzbomVUu6IMhab7At3l5HiRKxrAL0q2rMXq7f5y6g6I10
        iq6j+p3wue+upCjYyIFwLH8gVBWREmkV
X-Received: by 10.176.69.206 with SMTP id u72mr20876762uau.69.1494187017167;
 Sun, 07 May 2017 12:56:57 -0700 (PDT)
MIME-Version: 1.0
Received: by 10.159.38.44 with HTTP; Sun, 7 May 2017 12:56:56 -0700 (PDT)
From:   Prathamesh Chavan <pc44800@gmail.com>
Date:   Mon, 8 May 2017 01:26:56 +0530
Message-ID: <CAME+mvXtA6iZNfErTX5tYB-o-5xa1yesAG5h=iP_Z2_zL_kOnQ@mail.gmail.com>
Subject: [GSoC] Project Selected: Incremental rewrite of git-submodules
To:     git <git@vger.kernel.org>
Cc:     Stefan Beller <sbeller@google.com>,
        Christian Couder <christian.couder@gmail.com>
Content-Type: text/plain; charset=UTF-8
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Hey everyone,

I am Prathamesh Chavan, an undergraduate student from the department
of Computer Science and Engineering, at Indian Institue of Technology,
Kharagpur. I applied for Google Summer of Code 2017 and my project
"Incremental rewrite of git-submodules" has been selected.
This project will be done under the guidance of the mentors:
Stefan Beller and Christian Couder.

Brief introduction of the Project:

Git submodule subcommands are currently implemented by using shell script
'git-submodule.sh'. There are several reasons why we'll prefer not to
use the shell script. My project intends to convert the subcommands into
C code, thus making them builtins. This will increase Git's portability
and hence the efficiency of working with the git-submodule commands.
Link to the complete proposal: [1]

Before I discuss my future plan, first I would like to thank everyone
who was involved in helping me apply to GSoC and reviewing my patches.
I would especially like to thank Stefan Beller, Christian Couder and
Junio C Hamano for reviewing my patches and helping me get my first
patch(microproject) merged.

Current status of my patches:

1. t2027: avoid using pipes:
This patch has been merged to the master branch and also has
been included in the Git v2.13.0

2. Disallow git commands from within unpopulated submodules:
This patch was reviewed by Stefan Bellar and since to disallow
the git commands in unpopulated submodules required git commands
to identify whether the user has entered the command in
an unpopulated or uninitialized submodule individually at
low level than catching them for a complete group of
builtin commands. I found the review useful and
understood what needs to be done. Also, I wish to work on
it, but currently I would like to work on my project first.
I have included this issue in my wishlist and will
work on this after completing my project.

3. submodule: port subcommand foreach from shell to C
I have started implementing the suggestion in the previous
reviews and currently I'm adding more test-cases which my
patch still fails. Also, still this patch is failing tests
6, 7, 8 and 9 from t7407-submodule-foreach and test 64 from
t3600-rm.
Link to the patch: [2]

Plan for this week:

According to my proposal, time till 15th May is allocated as
community bonding period and hence I have
resumed taking a brief overview of the files:
1. strbuf.h
2. Various API files from Documentation/technical
since some functions from these may be used in every future porting.

I'm also aiming to read carefully:
1. submodule.h and submodule.c
2. git-submodule.sh
3. builtin/submodule--helper.c
since in every submodule subcommand's porting I'll be using the
functions from these files and it will also help me avoid code
duplication in future.

Along with this, I'm also working on porting of the subcommand
foreach and wish to complete it before the end of the community
bonding period.

I'll officially start coding from 16th May, as per my proposed
schedule and will be pushing my work on GitHub [3] regularly so
that the mentors can monitor the progress of the project. Also, I'll
be posting a weekly update on changes made throughout the week
and my plan for the next week.

Thanks,
Prathamesh Chavan

[1]: https://public-inbox.org/git/CAME+mvXBuLbbRJu1DAA8o-u6DeZATKypH=W=hPEks3KL5WMX+Q@mail.gmail.com/
[2]: https://public-inbox.org/git/20170422195804.18477-1-pc44800@gmail.com/T/#u
[3]: https://github.com/pratham-pc/git/
