Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-3.1 required=3.0 tests=AWL,BAYES_00,
	HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_HI,T_RP_MATCHES_RCVD
	shortcircuit=no autolearn=ham autolearn_force=no version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 774BF1F404
	for <e@80x24.org>; Tue, 13 Feb 2018 13:06:29 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S935205AbeBMNG1 (ORCPT <rfc822;e@80x24.org>);
        Tue, 13 Feb 2018 08:06:27 -0500
Received: from cpanel2.indieserve.net ([199.212.143.6]:47806 "EHLO
        cpanel2.indieserve.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S935203AbeBMNG0 (ORCPT <rfc822;git@vger.kernel.org>);
        Tue, 13 Feb 2018 08:06:26 -0500
Received: from cpec03f0ed08c7f-cm68b6fcf980b0.cpe.net.cable.rogers.com ([174.118.92.171]:38306 helo=localhost.localdomain)
        by cpanel2.indieserve.net with esmtpsa (TLSv1.2:ECDHE-RSA-AES256-GCM-SHA384:256)
        (Exim 4.89_1)
        (envelope-from <rpjday@crashcourse.ca>)
        id 1elaHx-00080Q-U0
        for git@vger.kernel.org; Tue, 13 Feb 2018 08:06:25 -0500
Date:   Tue, 13 Feb 2018 08:06:23 -0500 (EST)
From:   "Robert P. J. Day" <rpjday@crashcourse.ca>
X-X-Sender: rpjday@localhost.localdomain
To:     Git Mailing list <git@vger.kernel.org>
Subject: "git submodule" vs "git subtree" vs "repo" vs "git subdir" ... ?
Message-ID: <alpine.LFD.2.21.1802130746360.16738@localhost.localdomain>
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


  looking for general opinions ... i am (frighteningly :-) teaching a
git course later this week, and one of the topics on the list is git
submodules, which was specifically requested by the client as their
idea of how to start incorporating child repos in new projects.

  however, given the number of articles written about the drawbacks
with submodules, i wanted to throw in a section about "git subtree" as
well, even though (as discussed earlier) there is some minor dispute
as to whether "git subtree" is part of "core" git, but i'm not going
to let that stop me.

  going even beyond that, there is also google's "repo" command, which
i seem to see more and more often, like here for automotive grade
linux:

  https://wiki.automotivelinux.org/agl-distro/source-code

and it would be a shame to at least not mention that as yet another
possibility.

  and then there are unofficial, hand-rolled solutions, like
"git-subdir":

  https://github.com/andreyvit/git-subdir

given that the client does not appear to be wedded to any particular
solution yet, i'm open to recommendations or pointers to online
comparisons that i'll collect and post on a single wiki page, and they
can peruse the comparisons at their leisure.

  so ... thoughts? no need to be verbose, just links to decent online
discussions/comparisons would be massively useful.

rday

p.s. oh, pointers to well-designed usage of any of the above would be
handy as well. as i mentioned, for "repo", there's AGL. for
submodules, i might use boost:

  https://github.com/boostorg/boost/wiki/Getting-Started

and so on. thank you kindly.
