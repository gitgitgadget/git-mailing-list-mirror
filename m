Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-3.3 required=3.0 tests=AWL,BAYES_00,
	HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_HI,RP_MATCHES_RCVD
	shortcircuit=no autolearn=ham autolearn_force=no version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id E05A520A10
	for <e@80x24.org>; Sat, 30 Sep 2017 09:27:29 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1751351AbdI3J11 (ORCPT <rfc822;e@80x24.org>);
        Sat, 30 Sep 2017 05:27:27 -0400
Received: from cpanel2.indieserve.net ([199.212.143.6]:41459 "EHLO
        cpanel2.indieserve.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1751119AbdI3J10 (ORCPT <rfc822;git@vger.kernel.org>);
        Sat, 30 Sep 2017 05:27:26 -0400
Received: from cpec03f0ed08c7f-cm68b6fcf980b0.cpe.net.cable.rogers.com ([174.118.92.171]:51810 helo=localhost.localdomain)
        by cpanel2.indieserve.net with esmtpsa (TLSv1.2:ECDHE-RSA-AES256-GCM-SHA384:256)
        (Exim 4.89)
        (envelope-from <rpjday@crashcourse.ca>)
        id 1dyE3R-0007kY-MV
        for git@vger.kernel.org; Sat, 30 Sep 2017 05:27:25 -0400
Date:   Sat, 30 Sep 2017 05:27:22 -0400 (EDT)
From:   "Robert P. J. Day" <rpjday@crashcourse.ca>
X-X-Sender: rpjday@localhost.localdomain
To:     Git Mailing list <git@vger.kernel.org>
Subject: "man git-checkout", man page is inconsistent between SYNOPSIS and
 details
Message-ID: <alpine.LFD.2.21.1709300523190.27819@localhost.localdomain>
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


  just noticed that in "man git-checkout", the SYNOPSIS contains the
line:

  git checkout [-p|--patch] [<tree-ish>] [--] [<paths>...]

implying that <paths> is optional, but further down in the
DESCRIPTION, one reads:

  git checkout [-p|--patch] [<tree-ish>] [--] <pathspec>...

suggesting that <pathspec> is required.

rday

-- 

========================================================================
Robert P. J. Day                                 Ottawa, Ontario, CANADA
                        http://crashcourse.ca

Twitter:                                       http://twitter.com/rpjday
LinkedIn:                               http://ca.linkedin.com/in/rpjday
========================================================================
