Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-3.4 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,RCVD_IN_DNSWL_HI,
	T_DKIM_INVALID shortcircuit=no autolearn=ham autolearn_force=no version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 678981F404
	for <e@80x24.org>; Mon, 16 Apr 2018 12:44:07 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1753051AbeDPMoE (ORCPT <rfc822;e@80x24.org>);
        Mon, 16 Apr 2018 08:44:04 -0400
Received: from cpanel4.indieserve.net ([199.212.143.9]:33684 "EHLO
        cpanel4.indieserve.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1752497AbeDPMoE (ORCPT <rfc822;git@vger.kernel.org>);
        Mon, 16 Apr 2018 08:44:04 -0400
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=crashcourse.ca; s=default; h=Content-Type:MIME-Version:Message-ID:Subject:
        To:From:Date:Sender:Reply-To:Cc:Content-Transfer-Encoding:Content-ID:
        Content-Description:Resent-Date:Resent-From:Resent-Sender:Resent-To:Resent-Cc
        :Resent-Message-ID:In-Reply-To:References:List-Id:List-Help:List-Unsubscribe:
        List-Subscribe:List-Post:List-Owner:List-Archive;
        bh=/KWZTAnbUhKwB/2aBF/J66JUabkWgOTdXLbkorIuZ8M=; b=qJgDeEye+JymHv9TZTXSpJ2o+W
        Hjw+6QlfkNSe5gpfDERJ/ygYCljZiS8CZ5b6aYq5FypSJcTB1f6cxo26ZQ76FWa2QNbvPHXfwGfsx
        W+xR+hwNbw4XIPOhFyNGkZWITC1N8MlOalryp+97RE5t2qxofy66BORT/07qTgvS7LnPhEj2g7Jlh
        tOAv9Y6meuIFbz181jIZYWZifL1FYTJVS7IgoEjB4lqjWFzO/ys8FCi4f4AGzJNSbzyoRMFsksO4M
        UxwItjE2T9NGhCi9MZ6R747vHEEsZUovrO5Yg0firKuno5QUATeUpdkc77LEZU/O/cgm4ZBYQnKzH
        cGuBmDng==;
Received: from [209.37.255.2] (port=41202 helo=localhost.localdomain)
        by cpanel4.indieserve.net with esmtpsa (TLSv1.2:ECDHE-RSA-AES256-GCM-SHA384:256)
        (Exim 4.89_1)
        (envelope-from <rpjday@crashcourse.ca>)
        id 1f83UH-0005pc-Mo
        for git@vger.kernel.org; Mon, 16 Apr 2018 08:44:02 -0400
Date:   Mon, 16 Apr 2018 05:43:59 -0700 (PDT)
From:   "Robert P. J. Day" <rpjday@crashcourse.ca>
X-X-Sender: rpjday@localhost.localdomain
To:     Git Mailing list <git@vger.kernel.org>
Subject: man page for "git remote set-url" seems confusing/contradictory
Message-ID: <alpine.LFD.2.21.1804160538100.3564@localhost.localdomain>
User-Agent: Alpine 2.21 (LFD 202 2017-01-01)
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
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


  never had cause to examine "git remote set-url" before so i'm a bit
puzzled by this part of the man page:

  set-url

  Changes URLs for the remote. Sets first URL for remote
  <name> that matches regex <oldurl> ...

  With --push, push URLs are manipulated instead of fetch URLs.
 .. snip ...

  Note that the push URL and the fetch URL, even though they can be
  set differently, must still refer to the same place. What you pushed to
  the push URL should be what you would see if you immediately fetched
  from the fetch URL. If you are trying to fetch from one place (e.g.
  your upstream) and push to another (e.g. your publishing
  repository), use two separate remotes.

i don't understand how you can clearly set the fetch and push URLs of
a remote independently, while the man page nonetheless insists that
"even though they can be set differently, must still refer to the same
place". how can they be set differently yet still must refer to the
same place?

  i suspect i'll have a couple more questions related to this shortly
after i do a bit more reading.

rday
