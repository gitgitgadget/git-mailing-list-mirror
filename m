Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-5.6 required=3.0 tests=AWL,BAYES_00,
	HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_HI,RP_MATCHES_RCVD
	shortcircuit=no autolearn=ham autolearn_force=no version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 2FE482022D
	for <e@80x24.org>; Fri,  4 Nov 2016 20:24:37 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1756109AbcKDUYQ (ORCPT <rfc822;e@80x24.org>);
        Fri, 4 Nov 2016 16:24:16 -0400
Received: from chiark.greenend.org.uk ([212.13.197.229]:36625 "EHLO
        chiark.greenend.org.uk" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1753998AbcKDUW2 (ORCPT <rfc822;git@vger.kernel.org>);
        Fri, 4 Nov 2016 16:22:28 -0400
Received: from [172.18.45.5] (helo=zealot.relativity.greenend.org.uk)
        by chiark.greenend.org.uk (Debian Exim 4.84_2 #1) with esmtp
        (return-path ijackson@chiark.greenend.org.uk)
        id 1c2jwF-0004WX-SX; Fri, 04 Nov 2016 19:14:08 +0000
From:   Ian Jackson <ijackson@chiark.greenend.org.uk>
To:     git@vger.kernel.org
Subject: [PATCH 0/5] git check-ref-format --stdin --report-errors
Date:   Fri,  4 Nov 2016 19:13:53 +0000
Message-Id: <20161104191358.28812-1-ijackson@chiark.greenend.org.uk>
X-Mailer: git-send-email 2.10.1
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

I wanted to be able to syntax check lots of proposed refs quickly
(please don't ask why - it's complicated!)

So I added a --stdin option to git-check-ref-format.  Also it has
--report-errors now too so you can get some kind of useful error
message if it complains.

It's still not really a good batch mode but it's good enough for my
use case.  To improve it would involve a new command line option to
offer a suitable stdout output format.

There are three small refactoring patches and the two patches with new
options and corresponding docs.

Thanks for your attention.

FYI I am not likely to need this again in the near future: it's a
one-off use case.  So my effort for rework is probably limited.  I
thought I'd share what I'd done in what I hope is a useful form,
anyway.

Regards,
Ian.
