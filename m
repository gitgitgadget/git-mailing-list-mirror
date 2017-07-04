Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-4.2 required=3.0 tests=AWL,BAYES_00,
	FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,HEADER_FROM_DIFFERENT_DOMAINS,
	RCVD_IN_DNSWL_HI,RP_MATCHES_RCVD shortcircuit=no autolearn=ham
	autolearn_force=no version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 35344202A7
	for <e@80x24.org>; Tue,  4 Jul 2017 08:10:55 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1752100AbdGDIKw (ORCPT <rfc822;e@80x24.org>);
        Tue, 4 Jul 2017 04:10:52 -0400
Received: from continuum.iocl.org ([217.140.74.2]:55161 "EHLO
        continuum.iocl.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1752141AbdGDIKw (ORCPT <rfc822;git@vger.kernel.org>);
        Tue, 4 Jul 2017 04:10:52 -0400
X-Greylist: delayed 770 seconds by postgrey-1.27 at vger.kernel.org; Tue, 04 Jul 2017 04:10:51 EDT
Received: (from krey@localhost)
        by continuum.iocl.org (8.11.3/8.9.3) id v647vwD22637;
        Tue, 4 Jul 2017 09:57:58 +0200
Date:   Tue, 4 Jul 2017 09:57:58 +0200
From:   Andreas Krey <a.krey@gmx.de>
To:     git@vger.kernel.org
Subject: Flurries of 'git reflog expire'
Message-ID: <20170704075758.GA22249@inner.h.apk.li>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
User-Agent: Mutt/1.4.2.1i
X-message-flag: What did you expect to see here?
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Hi everyone,

how is 'git reflog expire' triggered? We're occasionally seeing a lot
of the running in parallel on a single of our repos (atlassian bitbucket),
and this usually means that the machine is not very responsive for
twenty minutes, the repo being as big as it is.

The server is still on git 2.6.2 (and bitbucket 4.14.5).

Questions:

What can be done about this? Cronjob 'git reflog expire' at midnight,
so the heuristic don't trigger during the day? (The relnotes don't
mention anything after 2.4.0, so I suppose a git upgrade won't help.)

What is the actual cause? Bad heuristics in git itself, or does
bitbucket run them too often (improbable)?

Andreas

-- 
"Totally trivial. Famous last words."
From: Linus Torvalds <torvalds@*.org>
Date: Fri, 22 Jan 2010 07:29:21 -0800
