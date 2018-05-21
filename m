Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-3.5 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,RCVD_IN_DNSWL_HI,
	T_DKIM_INVALID shortcircuit=no autolearn=ham autolearn_force=no version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 69729200B9
	for <e@80x24.org>; Mon, 21 May 2018 16:26:27 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1753238AbeEUQ0S (ORCPT <rfc822;e@80x24.org>);
        Mon, 21 May 2018 12:26:18 -0400
Received: from cpanel4.indieserve.net ([199.212.143.9]:34440 "EHLO
        cpanel4.indieserve.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1752869AbeEUQ0Q (ORCPT <rfc822;git@vger.kernel.org>);
        Mon, 21 May 2018 12:26:16 -0400
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=crashcourse.ca; s=default; h=Content-Type:MIME-Version:Message-ID:Subject:
        To:From:Date:Sender:Reply-To:Cc:Content-Transfer-Encoding:Content-ID:
        Content-Description:Resent-Date:Resent-From:Resent-Sender:Resent-To:Resent-Cc
        :Resent-Message-ID:In-Reply-To:References:List-Id:List-Help:List-Unsubscribe:
        List-Subscribe:List-Post:List-Owner:List-Archive;
        bh=t3y7zb74uLOcKsiFD1CEra0nJYmleho7iPI7zxGObbs=; b=H543HNX+A/yS2HfpUpE59vsEzl
        eQAa8j6U3K10yvXn/kh8lTZCNUuyLa9jaRxB6Qii/4rvel8tmX+lU1Grdg/zojtFY/7kfZmxz1c25
        Ei1yc+yx6U8LzKu/+ciDlniV89z81ZCsslVrYCmQb89NR0um8wr/PnMcgCZNaFZ39pK9N4V3ns/y6
        TMSN12i2LJ6JhNvMwT+nOQFMAw6J/ddgql+TyxMGKFUNegPccsNKL66tkoNjGiZ/xM8NekbXtGLNL
        bS0ERZ+SozLDQkD2pUPbDFPyjm02rjpkRJk2xc5jL52RK38ggQ6f37fkggc5++7NmcxBgmY98ZFon
        Y9X3CTLw==;
Received: from cpec03f0ed08c7f-cm68b6fcf980b0.cpe.net.cable.rogers.com ([174.118.92.171]:52182 helo=localhost.localdomain)
        by cpanel4.indieserve.net with esmtpsa (TLSv1.2:ECDHE-RSA-AES256-GCM-SHA384:256)
        (Exim 4.91)
        (envelope-from <rpjday@crashcourse.ca>)
        id 1fKndV-00GP0x-Sj
        for git@vger.kernel.org; Mon, 21 May 2018 12:26:14 -0400
Date:   Mon, 21 May 2018 12:24:43 -0400 (EDT)
From:   "Robert P. J. Day" <rpjday@crashcourse.ca>
X-X-Sender: rpjday@localhost.localdomain
To:     Git Mailing list <git@vger.kernel.org>
Subject: why does "man git-clean" not mention files ignored by
 core.excludesFile?
Message-ID: <alpine.LFD.2.21.1805211221180.18665@localhost.localdomain>
User-Agent: Alpine 2.21 (LFD 202 2017-01-01)
MIME-Version: 1.0
Content-Type: multipart/mixed; boundary="8323328-1587092341-1526919884=:18665"
X-OutGoing-Spam-Status: No, score=-1.0
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

  This message is in MIME format.  The first part should be readable text,
  while the remaining parts are likely unreadable without MIME-aware tools.

--8323328-1587092341-1526919884=:18665
Content-Type: text/plain; charset=ISO-8859-7
Content-Transfer-Encoding: 8BIT


  sort of related to my previous post, but in "man git-clean", one
reads:

  -e <pattern>, --exclude=<pattern>
     In addition to those found in .gitignore (per directory)
     and $GIT_DIR/info/exclude, also consider these patterns to
     be in the set of the ignore rules in effect.

  -x
     Don¢t use the standard ignore rules read from .gitignore
     (per directory) and $GIT_DIR/info/exclude, but do still use
     the ignore rules given with -e options. This allows
     removing all untracked files, including build products.
     This can be used (possibly in conjunction with git reset)
     to create a pristine working directory to test a clean
     build.

  why is there no mention of files ignored via a user's
core.excludesFile configuration? those sections seem sufficiently
comprehensive to list all of the other ways to ignore files, is there
a reason that that config setting is not mentioned?

rday
--8323328-1587092341-1526919884=:18665--
