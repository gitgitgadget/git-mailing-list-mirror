Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-4.6 required=3.0 tests=AWL,BAYES_00,
	FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,HEADER_FROM_DIFFERENT_DOMAINS,
	RCVD_IN_DNSWL_HI,RP_MATCHES_RCVD shortcircuit=no autolearn=ham
	autolearn_force=no version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id BCC402095B
	for <e@80x24.org>; Tue, 21 Mar 2017 16:41:08 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1758247AbdCUQlF (ORCPT <rfc822;e@80x24.org>);
        Tue, 21 Mar 2017 12:41:05 -0400
Received: from continuum.iocl.org ([217.140.74.2]:57738 "EHLO
        continuum.iocl.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1758187AbdCUQlE (ORCPT <rfc822;git@vger.kernel.org>);
        Tue, 21 Mar 2017 12:41:04 -0400
X-Greylist: delayed 2109 seconds by postgrey-1.27 at vger.kernel.org; Tue, 21 Mar 2017 12:41:03 EDT
Received: (from krey@localhost)
        by continuum.iocl.org (8.11.3/8.9.3) id v2LG5Lx16935;
        Tue, 21 Mar 2017 17:05:21 +0100
Date:   Tue, 21 Mar 2017 17:05:20 +0100
From:   Andreas Krey <a.krey@gmx.de>
To:     git@vger.kernel.org
Subject: cherry-pick --message?
Message-ID: <20170321160520.GA15550@inner.h.apk.li>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
User-Agent: Mutt/1.4.2.1i
X-message-flag: What did you expect to see here?
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Hi all,

I have an slightly unusual usecase for cherry-pick:
I want to modify the commit message that is used in the process,
e.g. do an d/^PROP:/ on it, but unfortunately -m does something
else here.

And there is no --message here for good reason, as cherry-pick
can pick multiple commits and so on. Bad for me, though.

So, am I down to the combo of format-patch and apply, or is there
an easier way? (I'd also like to end up in the same state as with
cherry-pick should there be conflicts.)

- Andreas

-- 
"Totally trivial. Famous last words."
From: Linus Torvalds <torvalds@*.org>
Date: Fri, 22 Jan 2010 07:29:21 -0800
