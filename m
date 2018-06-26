Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.1 (2015-04-28) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-3.8 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,RCVD_IN_DNSWL_HI,
	T_DKIM_INVALID shortcircuit=no autolearn=ham autolearn_force=no version=3.4.1
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 8C5081F516
	for <e@80x24.org>; Tue, 26 Jun 2018 10:18:32 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S934080AbeFZKSa (ORCPT <rfc822;e@80x24.org>);
        Tue, 26 Jun 2018 06:18:30 -0400
Received: from cpanel4.indieserve.net ([199.212.143.9]:60256 "EHLO
        cpanel4.indieserve.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S933785AbeFZKS3 (ORCPT <rfc822;git@vger.kernel.org>);
        Tue, 26 Jun 2018 06:18:29 -0400
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=crashcourse.ca; s=default; h=Content-Type:MIME-Version:Message-ID:Subject:
        To:From:Date:Sender:Reply-To:Cc:Content-Transfer-Encoding:Content-ID:
        Content-Description:Resent-Date:Resent-From:Resent-Sender:Resent-To:Resent-Cc
        :Resent-Message-ID:In-Reply-To:References:List-Id:List-Help:List-Unsubscribe:
        List-Subscribe:List-Post:List-Owner:List-Archive;
        bh=zcTuq2TzZ2LP6zx4XDgY4+l3Rtj4/yH97R0g1wo/Qe0=; b=Zg0T57drwzjPXJeJCUf2jyxR2E
        yMKjP8yeKheLhBonwxVi2N/xH0RDo1mTbta2MGbNKwJrZAabovka8atgfD+6uR7hLNEMcTN6DgcHw
        52vLUAR/MZGdQbwliV3tDH/6DhbSqbHQifFVOsjoDWy25ghRGz3ssHGTUUDdERjrpJFNo4nd5yKcG
        ASiOBKKHZvMlR/0eRrW8fsHG8pU2ZbWlnY8W0bsR3nG7Zp9kZ8/4/3NxtVI6Z+oyZy3Wk8bFHdvjY
        pK3ERaHcwAsISCH45Z7E4TR2hgLvdbtn5qJxHjoMNvW1A4C7f/acaZ5PPZDqRNdR1NFkGhcmS41R3
        sGv5Y5uQ==;
Received: from cpeac202e043973-cmac202e043970.cpe.net.cable.rogers.com ([174.112.22.87]:52684 helo=localhost.localdomain)
        by cpanel4.indieserve.net with esmtpsa (TLSv1.2:ECDHE-RSA-AES256-GCM-SHA384:256)
        (Exim 4.91)
        (envelope-from <rpjday@crashcourse.ca>)
        id 1fXl3L-00GSeJ-31
        for git@vger.kernel.org; Tue, 26 Jun 2018 06:18:28 -0400
Date:   Tue, 26 Jun 2018 06:18:26 -0400 (EDT)
From:   "Robert P. J. Day" <rpjday@crashcourse.ca>
X-X-Sender: rpjday@localhost.localdomain
To:     Git Mailing list <git@vger.kernel.org>
Subject: curious about wording in "man git-config", ENVIRONMENT
Message-ID: <alpine.LFD.2.21.1806260608270.6007@localhost.localdomain>
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


  ENVIRONMENT
    GIT_CONFIG
      Take the configuration from the given file instead of
      .git/config. Using the "--global" option forces this to
      ~/.gitconfig. Using the "--system" option forces this to
      $(prefix)/etc/gitconfig.

  is the phrase "forces this to" really what you want to use here?
maybe i misunderstand what this option does, doesn't it simply mean
that it will use a different (specified) file from the default,
depending on the context (local, global, system)?

  it just seems weird to say that the option "forces" the use of what
are clearly the default files. thoughts?

rday

-- 

========================================================================
Robert P. J. Day                                 Ottawa, Ontario, CANADA
                  http://crashcourse.ca/dokuwiki

Twitter:                                       http://twitter.com/rpjday
LinkedIn:                               http://ca.linkedin.com/in/rpjday
========================================================================
