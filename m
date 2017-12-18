Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-3.2 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_HI,T_RP_MATCHES_RCVD
	shortcircuit=no autolearn=no autolearn_force=no version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id B3FB41F424
	for <e@80x24.org>; Mon, 18 Dec 2017 22:07:47 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S937687AbdLRWHp (ORCPT <rfc822;e@80x24.org>);
        Mon, 18 Dec 2017 17:07:45 -0500
Received: from mail-lf0-f45.google.com ([209.85.215.45]:39252 "EHLO
        mail-lf0-f45.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S935054AbdLRWHh (ORCPT <rfc822;git@vger.kernel.org>);
        Mon, 18 Dec 2017 17:07:37 -0500
Received: by mail-lf0-f45.google.com with SMTP id m20so6345643lfi.6
        for <git@vger.kernel.org>; Mon, 18 Dec 2017 14:07:37 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=mime-version:from:date:message-id:subject:to;
        bh=qnNUrHgQ/NvsoGs5NJ2K3DUrvb1OSQ0nxRlOVLpHXZw=;
        b=S/l6nMCt3B0PWhht88kPPu6/t/qouYWtjg5swlBeSTwfQRMcTXsl2CpojrU9Fg9GMA
         aLB7VbHBbFMkA9bMfrBGNB1Lmg7mjNj5b/UfWy+k9NwjmI7k3ejOCAIdy67RTs6MNGmu
         G3F01w8axbzWNKygZBDrcKrPTbHRqPPPArnsio5iLAnpXd3xzkrChdaJqcKg3wlLq6v2
         iVlQ+ExPL1xVkTPqu5d+mmaSlXoU7L13+tCmUaLgKYQDidChAkhiDfnabWvK0IP6hb1g
         NQa+rO+UOV1JLymAJUAILWdGfql8xqndKzp5GfFu6tdcB1NRSlFGorgwCcj4mzteA05N
         iVOQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:from:date:message-id:subject:to;
        bh=qnNUrHgQ/NvsoGs5NJ2K3DUrvb1OSQ0nxRlOVLpHXZw=;
        b=lVdXnCj4N5vCuFpBRl2f8tnregCN1McJCbLrbHU4QRdXjLcq3XanenvMfDv3fImMlw
         UcO/WlRNjS++Tr1mgwVRDXvOp4w7P7E3zDx1Fe/SLpYT5uPj8ZKMZ2EaGy2rQVFgRKHj
         ++DuHIeZxx++Y1zKs/pRib11lVGYUdgM6a/9k2Cyh0DYkkW+2LeBkaGuLdHhFWUFladU
         AC8C1GpMLzTQGJbpvlExF/8WwwSg15Rqew2uhVlSJ1swoYLy4pRFXnCDVeIMamJZGr+C
         EMdFzG1wCbRE9nqGE57e5HJruwC/hmowwe2/83I7/OUP1F6OP2aa7MmMsuq9GMOUQ5t/
         Bl/A==
X-Gm-Message-State: AKGB3mKcFSTw4PJTFpqSVO0fJL4Sq200/hpdpAU3CjI8uuXj1ul7Rcwi
        FZRVJNUYbu/6B1Lf8MoydgP3n/cn9ndVqRARqtu8NG+f
X-Google-Smtp-Source: ACJfBotYitan4mvltHOn5szqGnapD/9Sm2stLxaIoDAS6gvvknFaT8fmi6OYplErxtfbbiVVNvG2FUoAzp5+7gHw0EM=
X-Received: by 10.46.14.9 with SMTP id 9mr876474ljo.148.1513634856039; Mon, 18
 Dec 2017 14:07:36 -0800 (PST)
MIME-Version: 1.0
Received: by 10.46.27.20 with HTTP; Mon, 18 Dec 2017 14:07:15 -0800 (PST)
From:   Jonas Fonseca <jonas.fonseca@gmail.com>
Date:   Mon, 18 Dec 2017 17:07:15 -0500
Message-ID: <CAFuPQ1+JwRy11-NA=pRN38GHt5Bk+KswzYNTba=JRFoZZ62byA@mail.gmail.com>
Subject: [ANNOUNCE] tig-2.3.2
To:     git <git@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Hello,

A regression in 2.3.1 related with the detection of busy loops has
been fixed in version 2.3.2.

Release notes
-------------
Bug fixes:

 - Fix busy loop detection to handle large repos. (GH #164)

Change summary
--------------
The diffstat and log summary for changes made in this release.

 INSTALL.adoc      | 4 ++--
 Makefile          | 2 +-
 NEWS.adoc         | 7 +++++++
 src/display.c     | 4 +++-
 tools/aspell.dict | 2 +-
 5 files changed, 14 insertions(+), 5 deletions(-)

Jonas Fonseca (2):
      Only check for busy loop when no views are updating
      tig-2.3.2

-- 
Jonas Fonseca
