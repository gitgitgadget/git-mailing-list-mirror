Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-3.1 required=3.0 tests=AWL,BAYES_00,
	HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_HI,T_RP_MATCHES_RCVD
	shortcircuit=no autolearn=ham autolearn_force=no version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 4D8C31F404
	for <e@80x24.org>; Wed, 14 Feb 2018 00:30:06 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S966284AbeBNAaE (ORCPT <rfc822;e@80x24.org>);
        Tue, 13 Feb 2018 19:30:04 -0500
Received: from cpanel2.indieserve.net ([199.212.143.6]:53706 "EHLO
        cpanel2.indieserve.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S966180AbeBNAaD (ORCPT <rfc822;git@vger.kernel.org>);
        Tue, 13 Feb 2018 19:30:03 -0500
Received: from cpec03f0ed08c7f-cm68b6fcf980b0.cpe.net.cable.rogers.com ([174.118.92.171]:52630 helo=localhost.localdomain)
        by cpanel2.indieserve.net with esmtpsa (TLSv1.2:ECDHE-RSA-AES256-GCM-SHA384:256)
        (Exim 4.89_1)
        (envelope-from <rpjday@crashcourse.ca>)
        id 1elkxW-0001Y7-Sf
        for git@vger.kernel.org; Tue, 13 Feb 2018 19:30:02 -0500
Date:   Tue, 13 Feb 2018 19:30:00 -0500 (EST)
From:   "Robert P. J. Day" <rpjday@crashcourse.ca>
X-X-Sender: rpjday@localhost.localdomain
To:     Git Mailing list <git@vger.kernel.org>
Subject: should "--recurse-submodule" be "--recurse-submodules"?
Message-ID: <alpine.LFD.2.21.1802131927310.17903@localhost.localdomain>
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


  also just noticed the following:

Documentation/RelNotes/2.13.0.txt:489: * A few commands that recently learned the "--recurse-submodule"
Documentation/RelNotes/2.12.0.txt:226: * "git push --dry-run --recurse-submodule=on-demand" wasn't
Documentation/RelNotes/2.11.1.txt:27: * "git push --dry-run --recurse-submodule=on-demand" wasn't
t/t5531-deep-submodule-push.sh:366:		git push --recurse-submodule=check origin master
t/t5572-pull-submodule.sh:45:test_expect_success 'pull --recurse-submodule setup' '

  should some of those be corrected?

rday
