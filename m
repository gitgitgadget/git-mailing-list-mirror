Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-3.2 required=3.0 tests=BAYES_00,
	HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_HI,RP_MATCHES_RCVD
	shortcircuit=no autolearn=ham autolearn_force=no version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 2C9E21F42B
	for <e@80x24.org>; Fri, 10 Nov 2017 13:58:10 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1752356AbdKJN6I (ORCPT <rfc822;e@80x24.org>);
        Fri, 10 Nov 2017 08:58:08 -0500
Received: from cpanel2.indieserve.net ([199.212.143.6]:55774 "EHLO
        cpanel2.indieserve.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1751117AbdKJN6H (ORCPT <rfc822;git@vger.kernel.org>);
        Fri, 10 Nov 2017 08:58:07 -0500
Received: from 69-196-158-250.dsl.teksavvy.com ([69.196.158.250]:46312 helo=DESKTOP-1GPMCEJ)
        by cpanel2.indieserve.net with esmtpsa (TLSv1.2:ECDHE-RSA-AES256-GCM-SHA384:256)
        (Exim 4.89)
        (envelope-from <rpjday@crashcourse.ca>)
        id 1eD9os-0002hm-Ez
        for git@vger.kernel.org; Fri, 10 Nov 2017 08:58:06 -0500
Date:   Fri, 10 Nov 2017 08:57:45 -0500 (EST)
From:   "Robert P. J. Day" <rpjday@crashcourse.ca>
X-X-Sender: rpjday@DESKTOP-1GPMCEJ
To:     Git Mailing list <git@vger.kernel.org>
Subject: is there a stylistic preference for a trailing "--" on a command?
Message-ID: <alpine.LFD.2.21.1711100855140.3617@DESKTOP-1GPMCEJ>
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


  just noticed these examples in "man git-bisect":

EXAMPLES
  $ git bisect start HEAD v1.2 --      # HEAD is bad, v1.2 is good
  ...
  $ git bisect start HEAD origin --    # HEAD is bad, origin is good
  ...
  $ git bisect start HEAD HEAD~10 --   # culprit is among the last 10

is there some rationale or stylistic significance to those trailing
"--" on those commands? i assume they have no effect, just curious as
to why they're there.

rday

-- 

========================================================================
Robert P. J. Day                                 Ottawa, Ontario, CANADA
                        http://crashcourse.ca

Twitter:                                       http://twitter.com/rpjday
LinkedIn:                               http://ca.linkedin.com/in/rpjday
========================================================================
