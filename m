Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-3.2 required=3.0 tests=BAYES_00,
	HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_HI,RP_MATCHES_RCVD
	shortcircuit=no autolearn=ham autolearn_force=no version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 9DFAC1F43C
	for <e@80x24.org>; Tue, 14 Nov 2017 15:00:21 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1754802AbdKNPAU (ORCPT <rfc822;e@80x24.org>);
        Tue, 14 Nov 2017 10:00:20 -0500
Received: from cpanel2.indieserve.net ([199.212.143.6]:58003 "EHLO
        cpanel2.indieserve.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1754234AbdKNPAT (ORCPT <rfc822;git@vger.kernel.org>);
        Tue, 14 Nov 2017 10:00:19 -0500
Received: from 69-196-158-250.dsl.teksavvy.com ([69.196.158.250]:33672 helo=DESKTOP-1GPMCEJ)
        by cpanel2.indieserve.net with esmtpsa (TLSv1.2:ECDHE-RSA-AES256-GCM-SHA384:256)
        (Exim 4.89)
        (envelope-from <rpjday@crashcourse.ca>)
        id 1eEchG-0007ro-ET
        for git@vger.kernel.org; Tue, 14 Nov 2017 10:00:18 -0500
Date:   Tue, 14 Nov 2017 09:59:43 -0500 (EST)
From:   "Robert P. J. Day" <rpjday@crashcourse.ca>
X-X-Sender: rpjday@DESKTOP-1GPMCEJ
To:     Git Mailing list <git@vger.kernel.org>
Subject: missing entries in "git help repository-layout"
Message-ID: <alpine.LFD.2.21.1711140950120.4521@DESKTOP-1GPMCEJ>
User-Agent: Alpine 2.21 (LFD 202 2017-01-01)
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
X-AntiAbuse: This header was added to track abuse, please include it with any abuse report
X-AntiAbuse: Primary Hostname - cpanel2.indieserve.net
X-AntiAbuse: Original Domain - vger.kernel.org
X-AntiAbuse: Originator/Caller UID/GID - [47 12] / [47 12]
X-AntiAbuse: Sender Address Domain - crashcourse.ca
X-Get-Message-Sender-Via: cpanel2.indieserve.net: authenticated_id: rpjday+crashcourse.ca/only user confirmed/virtual account not confirmed
X-Authenticated-Sender: cpanel2.indieserve.net: rpjday@crashcourse.ca
X-Source: 
X-Source-Args: 
X-Source-Dir: 
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org


  while writing up a cheat sheet with a visual layout of .git for my
students, i compared "git help repository-layout" to my git clone of
the kernel source tree, and noted the following things are not
mentioned in the repo layout help page -- i have no idea how complete
that page is supposed to be so it's entirely possible that these
omissions are deliberate:

  - ORIG_HEAD
  - FETCH_HEAD
  - description
  - gitk.cache
  - refs/
	bisect
	stash
  - logs/
	HEAD
	refs/
		stash
		remotes
  - worktrees/<id>/
	commondir
	HEAD
	index
	logs
	ORIG_HEAD

  as i said, i have no idea whether the entries above are deliberately
omitted from the layout page, i just made a list of them.

rday

-- 

========================================================================
Robert P. J. Day                                 Ottawa, Ontario, CANADA
                        http://crashcourse.ca

Twitter:                                       http://twitter.com/rpjday
LinkedIn:                               http://ca.linkedin.com/in/rpjday
========================================================================
