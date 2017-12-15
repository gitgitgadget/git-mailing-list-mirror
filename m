Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-3.4 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_HI,T_RP_MATCHES_RCVD
	shortcircuit=no autolearn=no autolearn_force=no version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 2586C1F404
	for <e@80x24.org>; Fri, 15 Dec 2017 03:00:23 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1754760AbdLODAU (ORCPT <rfc822;e@80x24.org>);
        Thu, 14 Dec 2017 22:00:20 -0500
Received: from mail-lf0-f50.google.com ([209.85.215.50]:40525 "EHLO
        mail-lf0-f50.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1754703AbdLODAT (ORCPT <rfc822;git@vger.kernel.org>);
        Thu, 14 Dec 2017 22:00:19 -0500
Received: by mail-lf0-f50.google.com with SMTP id c140so8889822lfg.7
        for <git@vger.kernel.org>; Thu, 14 Dec 2017 19:00:18 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=mime-version:from:date:message-id:subject:to;
        bh=tKlgPSYnauvdjvhQxWNWjvbss60ccJ1qCK6pC2mlibk=;
        b=vGYbDqoitD3AS/EetXp/audVkYAHFm7qi7OU4LFY3U2GfXjAYvLLHy3qEARN0lgpsY
         dblkuP2U8pwzOHqZMuqFfDWZPKWFl2+BQbQhdWbR1jQhmJzBJyWHMCKDhkfQ/rqeMUYw
         x0+ncsViUShpUhys0OYhpKhdxRia7m7ykIDMYyBWCjHl3zUm/APptXosAh9q1gAeLHOP
         +z3Oz/+zogrE82l1QZnHULal+aMkHjkBVLRlt9ay/FB8Lr1QSoogeb7/TLs7kaD6YV+Z
         GO2kvpl+rdzmpCsoUTQ6L3ku0yeeR254E2GFw16tDRD/MjQ2S0D8y238t0JlSxkPy5bH
         jDKw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:from:date:message-id:subject:to;
        bh=tKlgPSYnauvdjvhQxWNWjvbss60ccJ1qCK6pC2mlibk=;
        b=dRHnvKPl6CmQ1zLpI7MMUzxf8b1o9/bBPqY4kbbjtkHHlRv6Vv1TbFPRmwo4NRgwNb
         g3CtSEIxOXaNccRAnWu2GJxHAp46rUp9kQyq8dL8ovgAvLZJuALI8ilWquQDhPbtDvKM
         lxdZVZG8YX9oemuRp4WmHGlnMhJMILTWtLgvLh3TxWm9T9xqFKmdQG97GdTX9DR6jm8N
         u3losSK9x8k28qAbz0B2P2u0Vl73PWzWRaNJpck21Vc2ZeMmB+YJ7Xxin0RSNF40xcTh
         65HZ8U7kWPnBn08skz3eMZy6L5ZCGmgaAviLqX/TrD59gJ4V5zjYr58Wma0H9SLWVM2d
         VuWA==
X-Gm-Message-State: AKGB3mJX6De/pLEyIn9U04Zwbosz8bdQT40uknuvlq/+lu/dwa8duhFu
        I3u8ytoxtRI7o+JESA/gEkIHTMj+DB4rB2+9VcAVRgce
X-Google-Smtp-Source: ACJfBouJJZ7qBwa0Sk4zM/zvYfu7NhlFAMuNtBMnATJ9HBYcKBKa00gjw+bhBaMjt5tpgBJ8ZoMYxYCztLylsgc9+n8=
X-Received: by 10.46.55.20 with SMTP id e20mr5182286lja.118.1513306817795;
 Thu, 14 Dec 2017 19:00:17 -0800 (PST)
MIME-Version: 1.0
Received: by 10.46.27.20 with HTTP; Thu, 14 Dec 2017 18:59:57 -0800 (PST)
From:   Jonas Fonseca <jonas.fonseca@gmail.com>
Date:   Thu, 14 Dec 2017 21:59:57 -0500
Message-ID: <CAFuPQ1KJSrn5UsrxSSa1hfYS4-3+0rCBt=+qkk=VhjT6T12PWw@mail.gmail.com>
Subject: [ANNOUNCE] tig-2.3.1
To:     git <git@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Hello,

A new release is available fixing a few bugs and improving TTY management.

What is Tig?
------------
Tig is an ncurses-based text-mode interface for git. It functions mainly
as a Git repository browser, but can also assist in staging changes for
commit at chunk level and act as a pager for output from various Git
commands.

 - Homepage: https://jonas.github.io/tig/
 - Manual: https://jonas.github.io/tig/doc/manual.html
 - Tarballs: https://github.com/jonas/tig/releases
 - Gitter: https://gitter.im/jonas/tig
 - Q&A: https://stackoverflow.com/questions/tagged/tig

Release notes
-------------
Improvements:

 - Restore TTY attributes. (GH #725)
 - Handle `\n` like `\r`. (GH #758)

Bug fixes:

 - Add workaround that detects busy loops when Tig loses the TTY. This may
   happen if Tig does not receive the HUP signal (e.g. when started with
   `nohup`). (GH #164)
 - Fix compatibility with ncurses-5.4 which caused copy-pasting to not work
   in the prompt. (GH #767)
 - tig(1): document correct environment variable. (GH #752)

Change summary
--------------
The diffstat and log summary for changes made in this release.

 .travis.yml                     |  50 ++++++-------
 INSTALL.adoc                    |  13 +++-
 Makefile                        |   2 +-
 NEWS.adoc                       |  17 +++++
 doc/tig.1.adoc                  |   2 +-
 include/tig/tig.h               |   1 +
 src/display.c                   | 127 ++++++++++++++++++++++++++------
 test/README.adoc                |  17 +++++
 test/main/refresh-periodic-test |   2 +
 test/tools/libtest.sh           |  76 +++++++++++++++++--
 tools/aspell.dict               |  12 ++-
 tools/travis.sh                 |  32 ++++++++
 12 files changed, 293 insertions(+), 58 deletions(-)

Christian Brabandt (1):
      Handle \n like \r (#758)

David O'Trakoun (1):
      tig(1): Fix env var checked (#752)

Jonas Fonseca (6):
      Fix formatting of the Windows install documentation
      Move loop updating views to separate method
      Fix #164: Add workaround to detect busy event loops
      Use initscr to ensure proper TTY setup for the prompt (#768)
      Update NEWS
      tig-2.3.1

Matt (1):
      Added another installation method (#753)

-- 
Jonas Fonseca
