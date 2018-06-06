Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.1 (2015-04-28) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-3.8 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,RCVD_IN_DNSWL_HI,
	T_DKIM_INVALID shortcircuit=no autolearn=ham autolearn_force=no version=3.4.1
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 3B7BC1F403
	for <e@80x24.org>; Wed,  6 Jun 2018 19:54:13 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1752055AbeFFTyL (ORCPT <rfc822;e@80x24.org>);
        Wed, 6 Jun 2018 15:54:11 -0400
Received: from cpanel4.indieserve.net ([199.212.143.9]:41400 "EHLO
        cpanel4.indieserve.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1752026AbeFFTyK (ORCPT <rfc822;git@vger.kernel.org>);
        Wed, 6 Jun 2018 15:54:10 -0400
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=crashcourse.ca; s=default; h=Content-Type:MIME-Version:References:
        Message-ID:In-Reply-To:Subject:cc:To:From:Date:Sender:Reply-To:
        Content-Transfer-Encoding:Content-ID:Content-Description:Resent-Date:
        Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Id:
        List-Help:List-Unsubscribe:List-Subscribe:List-Post:List-Owner:List-Archive;
         bh=lodYul2pjAjk/4FJxsRV3XLB9Umah112kD23ZKIDx8k=; b=A70qaE3hjSOu9e8gYhHn4Omom
        /j0Jd7/PsjAAGFtNEmBmLSi+8RXj6YcNIsgajRauvdYL5kGIedmLjz+5V0hA4yueGulPIJjt4zhCF
        ZSqjImKrZGh4U7va6O5n6lJuxGv6cn9GSGlZH1Pkot4UiLUurtlnFicCueC3MaK8alfhAIbWhFQfj
        G+YI6Fo46b+j3OnYuQrNzKw4aTWcTggS9UKEy4KWVTqxLRrE7rsK9YknNbalgj5Ezld+GvQgwgEAi
        Z5p9GISnYv0udUaSpsFqEUHbH3gxN/GTN3g19SbzQWzzEYqYVDS+DQZFv60SXX2VQhrNBmIxabDfc
        0gUJVX0bQ==;
Received: from cpef81d0f814063-cmf81d0f814060.cpe.net.cable.rogers.com ([174.114.57.56]:54416 helo=localhost.localdomain)
        by cpanel4.indieserve.net with esmtpsa (TLSv1.2:ECDHE-RSA-AES256-GCM-SHA384:256)
        (Exim 4.91)
        (envelope-from <rpjday@crashcourse.ca>)
        id 1fQeVU-009oAt-Fz; Wed, 06 Jun 2018 15:54:09 -0400
Date:   Wed, 6 Jun 2018 15:51:54 -0400 (EDT)
From:   "Robert P. J. Day" <rpjday@crashcourse.ca>
X-X-Sender: rpjday@localhost.localdomain
To:     Thomas Fischer <thomasfischer@fastmail.com>
cc:     git@vger.kernel.org
Subject: Re: git rm bug
In-Reply-To: <1528314421.2665575.1398886712.579F37CE@webmail.messagingengine.com>
Message-ID: <alpine.LFD.2.21.1806061550530.9562@localhost.localdomain>
References: <1528313557.2662346.1398855328.3E0F8023@webmail.messagingengine.com> <alpine.LFD.2.21.1806061532420.9259@localhost.localdomain> <1528314421.2665575.1398886712.579F37CE@webmail.messagingengine.com>
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

On Wed, 6 Jun 2018, Thomas Fischer wrote:

> I agree that the entire chain of empty directories should not be
> tracked, as git tracks content, not files.
>
> However, when I run 'rm path/to/some/file', I expect path/to/some/
> to still exist.

  why?

> Similarly, when I run 'git rm path/to/some/file', I expect
> path/to/some/ to exist, *albeit untracked*.

  again, why?

> I do NOT expect git to *track* empty directories. But I also do NOT
> expect it to remove untracked directories.

  why not?

rday

-- 

========================================================================
Robert P. J. Day                                 Ottawa, Ontario, CANADA
                  http://crashcourse.ca/dokuwiki

Twitter:                                       http://twitter.com/rpjday
LinkedIn:                               http://ca.linkedin.com/in/rpjday
========================================================================
