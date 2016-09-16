Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-5.5 required=3.0 tests=BAYES_00,
	HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_HI,RP_MATCHES_RCVD
	shortcircuit=no autolearn=ham autolearn_force=no version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 92D7D207DF
	for <e@80x24.org>; Fri, 16 Sep 2016 22:27:15 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1755524AbcIPW1O (ORCPT <rfc822;e@80x24.org>);
        Fri, 16 Sep 2016 18:27:14 -0400
Received: from imap.imec.msu.ru ([93.180.3.203]:45490 "EHLO imap.imec.msu.ru"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1753821AbcIPW1M (ORCPT <rfc822;git@vger.kernel.org>);
        Fri, 16 Sep 2016 18:27:12 -0400
X-Greylist: delayed 514 seconds by postgrey-1.27 at vger.kernel.org; Fri, 16 Sep 2016 18:27:12 EDT
Received: from localhost (localhost [127.0.0.1])
        by imap.imec.msu.ru (Postfix) with ESMTP id BB163C21C
        for <git@vger.kernel.org>; Sat, 17 Sep 2016 01:17:55 +0300 (MSK)
X-Virus-Scanned: Debian amavisd-new at imap.imec.msu.ru
Received: from imap.imec.msu.ru ([127.0.0.1])
        by localhost (imap.imec.msu.ru [127.0.0.1]) (amavisd-new, port 10024)
        with ESMTP id lCKfX1o4WM-f for <git@vger.kernel.org>;
        Sat, 17 Sep 2016 01:17:55 +0300 (MSK)
Received: from mx.imec.msu.ru (mx.imec.msu.ru [93.180.3.199])
        by imap.imec.msu.ru (Postfix) with ESMTP id 8AE7EC0FF
        for <git@vger.kernel.org>; Sat, 17 Sep 2016 01:17:55 +0300 (MSK)
Received: from shurick.grid.su (shurick.grid.su [93.180.3.251])
        by mx.imec.msu.ru (Postfix) with ESMTPSA id 6FD10A2A5
        for <git@vger.kernel.org>; Sat, 17 Sep 2016 01:17:55 +0300 (MSK)
Date:   Sat, 17 Sep 2016 01:17:53 +0300
From:   Alexander Inyukhin <shurick@sectorb.msk.ru>
To:     git@vger.kernel.org
Subject: [wishlist] disable boring messages
Message-ID: <20160916221753.pvqdwb7vspkosyxu@shurick.grid.su>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
User-Agent: NeoMutt/ (1.7.0)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Hi,

is it possible to make git silent, when nothing interesting
is happening?

I have a lot of repos and a batch script to update them all,
and I want to get rid of 'Fetching origin' and 'Already up-to-date.'
messages leaving only new refs and tags.
