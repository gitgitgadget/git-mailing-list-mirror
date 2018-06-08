Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.1 (2015-04-28) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-3.8 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,RCVD_IN_DNSWL_HI,
	T_DKIM_INVALID shortcircuit=no autolearn=ham autolearn_force=no version=3.4.1
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 772791F403
	for <e@80x24.org>; Fri,  8 Jun 2018 13:20:56 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1751616AbeFHNUy (ORCPT <rfc822;e@80x24.org>);
        Fri, 8 Jun 2018 09:20:54 -0400
Received: from cpanel4.indieserve.net ([199.212.143.9]:44888 "EHLO
        cpanel4.indieserve.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1751133AbeFHNUx (ORCPT <rfc822;git@vger.kernel.org>);
        Fri, 8 Jun 2018 09:20:53 -0400
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=crashcourse.ca; s=default; h=Content-Type:MIME-Version:Message-ID:Subject:
        To:From:Date:Sender:Reply-To:Cc:Content-Transfer-Encoding:Content-ID:
        Content-Description:Resent-Date:Resent-From:Resent-Sender:Resent-To:Resent-Cc
        :Resent-Message-ID:In-Reply-To:References:List-Id:List-Help:List-Unsubscribe:
        List-Subscribe:List-Post:List-Owner:List-Archive;
        bh=wBlQC5z89z4rv7YmXVLHKA1/Wnp4JOI3OpHVlEuZJBU=; b=YklB5m8C4FwuxPH96R6ZfC4l98
        LDwthcYqvF8JHpfmGYmpYRu5RO5zSdHN29uTty/rvo+UEW2SIIly8jd97MxuYBvlStEWx70jSTSm7
        fmwCu9yG5xK8YJTQGh1MsSKD4VbOWKyTWnTtd0nbY670oWIMYikqVFG+rkhCq1Mx5qgNbTSEOs8HE
        pKAKRoauJ49APkiqBrmkkH7GFhCCIL+HtUCNM7M5d9iwBLXKwD5LZhHbwWhcqtXvA1YNUO08lNiFD
        ZsjKTx1OtjkYdcxdKVtD7R2bPAuSYYnuuVREPyM6Gx/eoPqR40+v+njd3LYm3aQKMoSqkLJ66WpDo
        gvQsNW1g==;
Received: from cpeac202e043973-cmac202e043970.cpe.net.cable.rogers.com ([174.112.22.87]:48440 helo=localhost.localdomain)
        by cpanel4.indieserve.net with esmtpsa (TLSv1.2:ECDHE-RSA-AES256-GCM-SHA384:256)
        (Exim 4.91)
        (envelope-from <rpjday@crashcourse.ca>)
        id 1fRHJz-0036iW-IX
        for git@vger.kernel.org; Fri, 08 Jun 2018 09:20:52 -0400
Date:   Fri, 8 Jun 2018 09:18:20 -0400 (EDT)
From:   "Robert P. J. Day" <rpjday@crashcourse.ca>
X-X-Sender: rpjday@localhost.localdomain
To:     Git Mailing list <git@vger.kernel.org>
Subject: is there a canonical doc about how to deal with whitespace issues?
Message-ID: <alpine.LFD.2.21.1806080914520.20892@localhost.localdomain>
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


  for one of my courses, i wanted to write a section about the various
techniques for dealing with whitespace issues in git, so i started
making a list, things like:

  - running "git diff --check"
  - "git commit --cleanup=" possibilities
  - config options like core.{eol,safecrlf,autocrlf}
  - i'm sure there are client-side hooks that can be mentioned

etc, etc.

  has anyone ever written a doc that collects these things in one
place? if not, i guess i have to write one.

rday

-- 

========================================================================
Robert P. J. Day                                 Ottawa, Ontario, CANADA
                  http://crashcourse.ca/dokuwiki

Twitter:                                       http://twitter.com/rpjday
LinkedIn:                               http://ca.linkedin.com/in/rpjday
========================================================================
