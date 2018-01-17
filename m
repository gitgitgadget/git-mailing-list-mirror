Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-3.1 required=3.0 tests=AWL,BAYES_00,
	HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_HI,T_RP_MATCHES_RCVD
	shortcircuit=no autolearn=ham autolearn_force=no version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id C462C1F406
	for <e@80x24.org>; Wed, 17 Jan 2018 12:58:40 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1753041AbeAQM6i (ORCPT <rfc822;e@80x24.org>);
        Wed, 17 Jan 2018 07:58:38 -0500
Received: from cpanel2.indieserve.net ([199.212.143.6]:35250 "EHLO
        cpanel2.indieserve.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1753032AbeAQM6h (ORCPT <rfc822;git@vger.kernel.org>);
        Wed, 17 Jan 2018 07:58:37 -0500
Received: from [209.37.255.2] (port=29720 helo=localhost.localdomain)
        by cpanel2.indieserve.net with esmtpsa (TLSv1.2:ECDHE-RSA-AES256-GCM-SHA384:256)
        (Exim 4.89_1)
        (envelope-from <rpjday@crashcourse.ca>)
        id 1ebnIa-0001u9-Md
        for git@vger.kernel.org; Wed, 17 Jan 2018 07:58:36 -0500
Date:   Wed, 17 Jan 2018 04:58:33 -0800 (PST)
From:   "Robert P. J. Day" <rpjday@crashcourse.ca>
X-X-Sender: rpjday@localhost.localdomain
To:     Git Mailing list <git@vger.kernel.org>
Subject: misleading "man git-worktree", is last "add" argument necessarily
 a "branch"?
Message-ID: <alpine.LFD.2.21.1801170455380.16166@localhost.localdomain>
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


  perusing "git worktree", and man page reads:

  SYNOPSIS
       git worktree add [-f] [--detach] [--checkout] [--lock]   \
                        [-b <new-branch>] <path> [<branch>]
                                                 ^^^^^^^^^^

however, can't that last optional argument be any arbitrary commit,
not just a "branch"?

rday
