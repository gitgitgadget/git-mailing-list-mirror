Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-6.0 required=3.0 tests=BAYES_00,
	HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_HI,RP_MATCHES_RCVD
	shortcircuit=no autolearn=ham autolearn_force=no version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id E16AF2022A
	for <e@80x24.org>; Mon,  7 Nov 2016 13:56:11 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1753293AbcKGN4A (ORCPT <rfc822;e@80x24.org>);
        Mon, 7 Nov 2016 08:56:00 -0500
Received: from slow1-d.mail.gandi.net ([217.70.178.86]:50096 "EHLO
        slow1-d.mail.gandi.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S932214AbcKGNz6 (ORCPT <rfc822;git@vger.kernel.org>);
        Mon, 7 Nov 2016 08:55:58 -0500
Received: from relay2-d.mail.gandi.net (relay2-d.mail.gandi.net [217.70.183.194])
        by slow1-d.mail.gandi.net (Postfix) with ESMTP id 5ABD147F336
        for <git@vger.kernel.org>; Mon,  7 Nov 2016 14:49:44 +0100 (CET)
Received: from mfilter5-d.gandi.net (mfilter5-d.gandi.net [217.70.178.132])
        by relay2-d.mail.gandi.net (Postfix) with ESMTP id C9B98C5A56
        for <git@vger.kernel.org>; Mon,  7 Nov 2016 14:49:42 +0100 (CET)
X-Virus-Scanned: Debian amavisd-new at mfilter5-d.gandi.net
Received: from relay2-d.mail.gandi.net ([IPv6:::ffff:217.70.183.194])
        by mfilter5-d.gandi.net (mfilter5-d.gandi.net [::ffff:10.0.15.180]) (amavisd-new, port 10024)
        with ESMTP id wScu3VMjCV2v for <git@vger.kernel.org>;
        Mon,  7 Nov 2016 14:49:41 +0100 (CET)
X-Originating-IP: 82.21.67.43
Received: from localhost.localdomain (cpc104452-irvi2-2-0-cust42.14-1.cable.virginm.net [82.21.67.43])
        (Authenticated sender: web@dhardy.name)
        by relay2-d.mail.gandi.net (Postfix) with ESMTPSA id 3AA80C5A99
        for <git@vger.kernel.org>; Mon,  7 Nov 2016 14:49:41 +0100 (CET)
From:   Diggory Hardy <lists@dhardy.name>
To:     git@vger.kernel.org
Subject: git push remote syntax
Date:   Mon, 07 Nov 2016 13:49:40 +0000
Message-ID: <1613741.x6i0st30av@localhost.localdomain>
User-Agent: KMail/5.3.2 (Linux/4.8.4-200.fc24.x86_64; KDE/5.27.0; x86_64; ; )
MIME-Version: 1.0
Content-Transfer-Encoding: 7Bit
Content-Type: text/plain; charset="us-ascii"
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Dear all,

One thing I find a little frustrating about git is that the syntax needed 
differs by command. I wish the 'remote/branch' syntax was more universal:

> git pull myremote/somebranch
complains about the syntax; IMO it should either pull from that branch (and 
merge if necessary) or complain instead that pulling from a different branch 
is not supported (and suggest using merge).

> git push myremote/somebranch
should push there, i.e. be equivalent to
> git push myremote HEAD:somebranch

These are just some comments about how I think git could be made easier to 
use. Apologies if the suggestions have already been discussed before.

Regards,

D Hardy
