Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.2 (2018-09-13) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-3.9 required=3.0 tests=BAYES_00,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,RCVD_IN_DNSWL_HI,
	SPF_HELO_NONE,SPF_NONE shortcircuit=no autolearn=ham
	autolearn_force=no version=3.4.2
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 42F151F4C1
	for <e@80x24.org>; Fri, 18 Oct 2019 10:06:00 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2633218AbfJRKF7 (ORCPT <rfc822;e@80x24.org>);
        Fri, 18 Oct 2019 06:05:59 -0400
Received: from cpanel4.indieserve.net ([199.212.143.9]:32975 "EHLO cck.ca"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1727249AbfJRKF6 (ORCPT <rfc822;git@vger.kernel.org>);
        Fri, 18 Oct 2019 06:05:58 -0400
X-Greylist: delayed 1020 seconds by postgrey-1.27 at vger.kernel.org; Fri, 18 Oct 2019 06:05:58 EDT
Received: from [216.208.232.130] (port=50898 helo=localhost.localdomain)
        by cpanel4.indieserve.net with esmtpsa (TLSv1.2:ECDHE-RSA-AES256-GCM-SHA384:256)
        (Exim 4.92)
        (envelope-from <rpjday@crashcourse.ca>)
        id 1iLOsS-00Ccl3-93
        for git@vger.kernel.org; Fri, 18 Oct 2019 05:48:56 -0400
Date:   Fri, 18 Oct 2019 05:48:55 -0400 (EDT)
From:   "Robert P. J. Day" <rpjday@crashcourse.ca>
X-X-Sender: rpjday@localhost.localdomain
To:     Git Mailing list <git@vger.kernel.org>
Subject: what *precisely* means "--depth" WRT a shallow clone?
Message-ID: <alpine.LFD.2.21.1910180544160.5751@localhost.localdomain>
User-Agent: Alpine 2.21 (LFD 202 2017-01-01)
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
X-OutGoing-Spam-Status: No, score=-0.2
X-AntiAbuse: This header was added to track abuse, please include it with any abuse report
X-AntiAbuse: Primary Hostname - cpanel4.indieserve.net
X-AntiAbuse: Original Domain - vger.kernel.org
X-AntiAbuse: Originator/Caller UID/GID - [47 12] / [47 12]
X-AntiAbuse: Sender Address Domain - crashcourse.ca
X-Get-Message-Sender-Via: cpanel4.indieserve.net: authenticated_id: rpjday+crashcourse.ca/only user confirmed/virtual account not confirmed
X-Authenticated-Sender: cpanel4.indieserve.net: rpjday@crashcourse.ca
X-Source: 
X-Source-Args: 
X-Source-Dir: 
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org


  i can see the standard use of "--depth" when set to precisely one,
for CI/CD systems that don't need any history. but what does it mean
to say, eg, "--depth 10"?

  the man page explains that as "a history truncated to the specified
number of commits", but what does mean in the sense of branching and
merging? will i get *precisely* 10 commits of history? and in the
context of merging, *which* 10 commits?

  sorry if this should be obvious.

rday

-- 

========================================================================
Robert P. J. Day                                 Ottawa, Ontario, CANADA
                         http://crashcourse.ca

Twitter:                                       http://twitter.com/rpjday
LinkedIn:                               http://ca.linkedin.com/in/rpjday
========================================================================
