Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-3.8 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,RCVD_IN_DNSWL_HI,
	T_DKIM_INVALID shortcircuit=no autolearn=ham autolearn_force=no version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id B99131F42D
	for <e@80x24.org>; Sat,  2 Jun 2018 19:30:16 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1752051AbeFBTaP (ORCPT <rfc822;e@80x24.org>);
        Sat, 2 Jun 2018 15:30:15 -0400
Received: from cpanel4.indieserve.net ([199.212.143.9]:47668 "EHLO
        cpanel4.indieserve.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1751503AbeFBTaO (ORCPT <rfc822;git@vger.kernel.org>);
        Sat, 2 Jun 2018 15:30:14 -0400
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=crashcourse.ca; s=default; h=Content-Type:MIME-Version:Message-ID:Subject:
        To:From:Date:Sender:Reply-To:Cc:Content-Transfer-Encoding:Content-ID:
        Content-Description:Resent-Date:Resent-From:Resent-Sender:Resent-To:Resent-Cc
        :Resent-Message-ID:In-Reply-To:References:List-Id:List-Help:List-Unsubscribe:
        List-Subscribe:List-Post:List-Owner:List-Archive;
        bh=IoKAln8VFjzHa/Y0Cijwzg2LLUtBGP/PNRKmonH6H24=; b=YRyHn7LJEXApg/fMULfZUtyh/q
        xrn8X39f2ENXxWgHAHpryVlTS9yAlqU+w3QBtt4QD6RFqczg56LRp8g7ehS4XXaABll1BzCvd0jMS
        HSaSRMPlpKsNH11zSnb8P1P/Ip7UpQGstEvIi+iw14P38LEJZ38+/s2dzAgoI0s1/kiywrFYkMjwy
        iRoYnQQmojDJaF2JAjHHeyzJ+VGWpvT+03UO5Jz3UB0V0Kd/wg+AYTY3cFQDl6G4smzMTIPmmTK3c
        osUfZhjrvkpJ5ny1t9JkvF4zcqeDcflB5BTBzyZVdvozaK3+9SBllaIXWvrRNIlzy2qlBs+/MI1cZ
        o1WzQ1jw==;
Received: from cpef81d0f814063-cmf81d0f814060.cpe.net.cable.rogers.com ([174.114.57.56]:35556 helo=localhost.localdomain)
        by cpanel4.indieserve.net with esmtpsa (TLSv1.2:ECDHE-RSA-AES256-GCM-SHA384:256)
        (Exim 4.91)
        (envelope-from <rpjday@crashcourse.ca>)
        id 1fPCE8-0002Ef-IQ
        for git@vger.kernel.org; Sat, 02 Jun 2018 15:30:13 -0400
Date:   Sat, 2 Jun 2018 15:28:09 -0400 (EDT)
From:   "Robert P. J. Day" <rpjday@crashcourse.ca>
X-X-Sender: rpjday@localhost.localdomain
To:     Git Mailing list <git@vger.kernel.org>
Subject: does a stash *need* any reference to the branch on which it was
 created?
Message-ID: <alpine.LFD.2.21.1806021525120.19865@localhost.localdomain>
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


  i realize that, when you "git stash push", stash graciously saves
the branch you were on as part of the commit message, but does any
subsequent stash operation technically *need* that branch name?

  it doesn't seem like it -- even "git stash branch" really only needs
the commit that was the basis of that stash to create the new branch.

  so, does any stash operation actually need the originating branch
name? (i'm guessing no, but i've been wrong before.)

rday

-- 

========================================================================
Robert P. J. Day                                 Ottawa, Ontario, CANADA
                  http://crashcourse.ca/dokuwiki

Twitter:                                       http://twitter.com/rpjday
LinkedIn:                               http://ca.linkedin.com/in/rpjday
========================================================================
