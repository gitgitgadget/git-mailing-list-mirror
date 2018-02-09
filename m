Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-3.1 required=3.0 tests=AWL,BAYES_00,
	HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_HI,T_RP_MATCHES_RCVD
	shortcircuit=no autolearn=ham autolearn_force=no version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 263271F404
	for <e@80x24.org>; Fri,  9 Feb 2018 13:20:30 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1751029AbeBINU1 (ORCPT <rfc822;e@80x24.org>);
        Fri, 9 Feb 2018 08:20:27 -0500
Received: from cpanel2.indieserve.net ([199.212.143.6]:49106 "EHLO
        cpanel2.indieserve.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1750924AbeBINU1 (ORCPT <rfc822;git@vger.kernel.org>);
        Fri, 9 Feb 2018 08:20:27 -0500
Received: from 69-196-158-250.dsl.teksavvy.com ([69.196.158.250]:43470 helo=android-a172fe96dd584b41)
        by cpanel2.indieserve.net with esmtpsa (TLSv1.2:ECDHE-RSA-AES256-GCM-SHA384:256)
        (Exim 4.89_1)
        (envelope-from <rpjday@crashcourse.ca>)
        id 1ek8bK-0007by-FK
        for git@vger.kernel.org; Fri, 09 Feb 2018 08:20:26 -0500
Date:   Fri, 9 Feb 2018 08:20:24 -0500 (EST)
From:   "Robert P. J. Day" <rpjday@crashcourse.ca>
X-X-Sender: rpjday@android-a172fe96dd584b41
To:     Git Mailing list <git@vger.kernel.org>
Subject: "git bisect run make" adequate to locate first unbuildable commit?
Message-ID: <alpine.LFD.2.21.1802090817550.6248@android-a172fe96dd584b41>
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


  writing a short tutorial on "git bisect" and, all the details of
special exit code 125 aside, if one wanted to locate the first
unbuildable commit, would it be sufficient to just run?

  $ git bisect run make

  as i read it, make returns either 0, 1 or 2 so there doesn't appear
to be any possibility of weirdness with clashing with a 125 exit code.
am i overlooking some subtle detail here i should be aware of? thanks.

rday
