Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-3.6 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_HI,RCVD_IN_SORBS_SPAM,
	RP_MATCHES_RCVD shortcircuit=no autolearn=no autolearn_force=no version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 37B3A1FC44
	for <e@80x24.org>; Mon, 13 Feb 2017 23:15:05 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1751310AbdBMXPD (ORCPT <rfc822;e@80x24.org>);
        Mon, 13 Feb 2017 18:15:03 -0500
Received: from mail-ua0-f169.google.com ([209.85.217.169]:35621 "EHLO
        mail-ua0-f169.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1750975AbdBMXPC (ORCPT <rfc822;git@vger.kernel.org>);
        Mon, 13 Feb 2017 18:15:02 -0500
Received: by mail-ua0-f169.google.com with SMTP id y9so76263799uae.2
        for <git@vger.kernel.org>; Mon, 13 Feb 2017 15:15:02 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=mime-version:from:date:message-id:subject:to;
        bh=pVSRFBf/2bxGlF4a4hEBQvTGfXGEqZAi7HlaHWqloM8=;
        b=eDcnHbocdazt9sDOIr6qm93krK/llCNA8nWUNg5q/q0gtUCBcqyULGWj4ePLdg5Xjv
         GGH2+mibV1/lM2e1MLDMk6fLhrowJTU2UtyRc3yX+Z6LiVfdVdO6cYXk3JTlpUlxRUIl
         i1hoskJonvNQskwtdYg7sotGwaO7pqXhxKeUlEYPvcAquWQ8vp/aDiii3eynLrntF7Wd
         t3tVGfgH+jzYTWUb09GshcirA9sNdJjF63ve2Yd5V0TvT2uq8s6ayn9YyDr4mQOEfSev
         hwWEX2PJKYF2JpT36n9OlViCm9fXFXVJqTpWhLrHKX3nw9JF0p1xsKTqlgVeb0QXcbly
         /r1g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:from:date:message-id:subject:to;
        bh=pVSRFBf/2bxGlF4a4hEBQvTGfXGEqZAi7HlaHWqloM8=;
        b=ieGaHbj71+Zxye9o6kvakubmc38EB63LdryYk4zdutUGUObp7QY6sYoG0FkhIsKl1h
         TBmBRFL9Nqi6PTNptq4PMYBLocE1fUzxm+wZAm6nbLtleTZmbQPRZ24ZLd9VDtUeVrN8
         wH5QMMMF5yWdAbFc/tcFobVNB9+qQMTNfM5wieGmyR4wD1cIDKZ0EM4Sd7NKOhvU2IwQ
         x8AkvcQA2gqIlNw4uiPlD+GumpCIVHJEVKfrXkpBLJGj2DnDauytFjLWtBDW0jc0DCnD
         nt15M2aTpn2pu7vtZVWP+cfkLzdYQORZewApYLwEfPQPW4v0uo2jOARv+8koQNTx0qhA
         Vrbg==
X-Gm-Message-State: AMke39k7uBaAKYovpfgMV84cg+kAEkzhhoUj5LRUkAXwb68P4xqhernd0gKPdbR5RXXz/8z4AN22Bj/UcXdaaA==
X-Received: by 10.159.49.25 with SMTP id m25mr13769232uab.87.1487027701267;
 Mon, 13 Feb 2017 15:15:01 -0800 (PST)
MIME-Version: 1.0
Received: by 10.31.242.11 with HTTP; Mon, 13 Feb 2017 15:15:00 -0800 (PST)
From:   Oleg Taranenko <olegtaranenko@gmail.com>
Date:   Tue, 14 Feb 2017 00:15:00 +0100
Message-ID: <CABEd3j-kxA+ap7vqr85X-4HpQCvShPJUsS2Qq0BrMEK09BYS7A@mail.gmail.com>
Subject: Developing git with IDE
To:     git <git@vger.kernel.org>
Content-Type: text/plain; charset=UTF-8
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Hi *,

being last decade working with java & javascript I completely lost
relation to c/c++ world. Trying to get into git internals I'm facing
with issue what IDE is more suitable for developing git @ macos ?

Have googled, but any my search queries following to non-relevant
themes, like supporting git in IDEs etc.

my first attempt - CLion (as far as I'm Jetbrains fan) - got failed,
as far as doesn't support makefile-based projects, only CMake.

There are a number of free C/C++ dev tools: Xcode, CodeBlocks,
CodeLite. Gnat, Qt creator, Dev C++, C++ Builder (Borland? :),
Eclipse, NetBeans... what else?

Because of  lack my modern C experience, could somebody share his own
attempts/thoughts/use cases how more convenient dive into the git
development process on the Mac?

Tried to find in the git distribution Documentation more information
about this, nothing as well...  Would be nice to have a kind of
'Getting Started Manual'


Thanks for your time,

Oleg Taranenko
