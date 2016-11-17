Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-4.6 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_HI,RCVD_IN_SORBS_SPAM,
	RP_MATCHES_RCVD shortcircuit=no autolearn=ham autolearn_force=no version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id DDBC72042F
	for <e@80x24.org>; Thu, 17 Nov 2016 04:08:48 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1753147AbcKQEFT (ORCPT <rfc822;e@80x24.org>);
        Wed, 16 Nov 2016 23:05:19 -0500
Received: from mail-it0-f68.google.com ([209.85.214.68]:36320 "EHLO
        mail-it0-f68.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1751688AbcKQEFS (ORCPT <rfc822;git@vger.kernel.org>);
        Wed, 16 Nov 2016 23:05:18 -0500
Received: by mail-it0-f68.google.com with SMTP id n68so12186356itn.3
        for <git@vger.kernel.org>; Wed, 16 Nov 2016 20:05:17 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20120113;
        h=mime-version:from:date:message-id:subject:to;
        bh=9jMfLGpMOUVylf6HetyD1WOkfgGn/vD3Wyossad96tI=;
        b=CvhbQUXI3wgIi8Syoz5+l3KwEBDWLbSRZqb0ar/u+59XESH95It26y2Q53MaIpnqdG
         KFdfMBvixsS3GEVtklg0e3kfB+8iS58aXlqWP0ZXR+h0tiLYIdC4LHQM93S9Yr1r9hZs
         63pG47m6WRLPpLVCgmFCilodUjYdmYN24EuMfKulZ2Bb079i60cnI0Unqeuj2q4BOES4
         8wwWHIu9rNdsgTE1UXZwbKuSyzmQxMRoFpfu8vEcqV49xy9ABm6uTmG+QCNkSbhK5bKF
         pmsLOeRq5h3UH4RGRQUUSMOUgP2mxmostQGLWOXqLgetJTQlkcoIuu8nNTDjg5dbmSGr
         UI8g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20130820;
        h=x-gm-message-state:mime-version:from:date:message-id:subject:to;
        bh=9jMfLGpMOUVylf6HetyD1WOkfgGn/vD3Wyossad96tI=;
        b=WlXGjHUeex6gut94+QJQwtY8Ya0uBdf6MD9uE50sOu1yBfd8joyP9xMfdmTFTJd2q6
         cZXNrrbo3Tj2uCAbOCJKwS3Rn8pCJcOETfxP1AXoOWJdXz8VIObmkVfGNNVgwNglXcb2
         qnuFZpcHKqc+p741uxEU/wA57aFuQHycwfVO14RiusJ40ps3pcOVgfEvfgG0S7WcH0Sm
         2GflS0p+8AfaapvAvU4O9oLsewiHK8Y5Puv4dRl4wyxdHRr5b7nPtWC/nBz+JXeetAl1
         OjAuNvENQhriMzJixp2kP32NTpE3M0yiXWbcg7v4gZZQadOeE4haseK6/+SUmgR5N/Y5
         Gafg==
X-Gm-Message-State: AKaTC01tfl5FW/2Sh++ARL+l1hnfRQqJnxPNN1r2wR+i6AMJNuUwRd58LDIIp3ms0I5nKedjtus+N9hp9C7mQg==
X-Received: by 10.107.19.104 with SMTP id b101mr1210738ioj.150.1479355517228;
 Wed, 16 Nov 2016 20:05:17 -0800 (PST)
MIME-Version: 1.0
Received: by 10.36.130.65 with HTTP; Wed, 16 Nov 2016 20:04:56 -0800 (PST)
From:   Jonas Fonseca <jonas.fonseca@gmail.com>
Date:   Wed, 16 Nov 2016 23:04:56 -0500
Message-ID: <CAFuPQ1+NsEomHsuHvU7PLPPNrpfpfGEPmQ0r=ufovz_ztZ+EnA@mail.gmail.com>
Subject: [ANNOUNCE] tig-2.2.1
To:     git <git@vger.kernel.org>
Content-Type: text/plain; charset=UTF-8
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Hello,

A new minor version of tig is available which adds support for
diff-highlight (see instructions below) and navigation between merge
commits as well as several keybinding tweaks.

Tarballs should now be downloaded from GitHub. Either go to
https://github.com/jonas/tig/releases or use the following pattern:

    https://github.com/jonas/tig/releases/download/tig-VERSION/tig-VERSION.tar.gz

MD5 checksums can be found at:

    https://github.com/jonas/tig/releases/download/tig-VERSION/tig-VERSION.tar.gz.md5

Similarly, the home page is now also on GitHub at
https://jonas.github.io/tig/. A big thanks to Simon L. B. Nielsen for
generously hosting Tig on nitro.dk!

Release notes
-------------
Improvements:

 - Support Git's 'diff-highlight' program when `diff-highlight` is set
   to either true or the path of the script to use for post-processing.
 - Add navigation between merge commits. (GH #525)
 - Add 'A' as a binding to apply a stash without dropping it.
 - Bind 'Ctrl-D' and 'Ctrl-U' to half-page movements by default.
 - manual: Mention how to change default Up/Down behavior in diff view.

Bug fixes

 - Reorganize checking of libraries for termcap functions.
 - Fix `:goto <id>` error message.

Change summary
--------------
The short diffstat and log summary for changes made in this release.

 118 files changed, 3765 insertions(+), 3284 deletions(-)

    22  Jonas Fonseca
     1  Frank Fesevur
     1  Jelte Fennema
     1  Jeremy Lin
     1  Parker Coates
     1  Philipp Gesang
     1  Ramsay Jones
     1  David Lin
     1  lightside

-- 
Jonas Fonseca
