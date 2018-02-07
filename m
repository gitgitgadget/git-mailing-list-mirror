Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-3.1 required=3.0 tests=AWL,BAYES_00,
	HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_HI,T_RP_MATCHES_RCVD
	shortcircuit=no autolearn=ham autolearn_force=no version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 364DD1F404
	for <e@80x24.org>; Wed,  7 Feb 2018 18:10:01 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1754048AbeBGSJ7 (ORCPT <rfc822;e@80x24.org>);
        Wed, 7 Feb 2018 13:09:59 -0500
Received: from cpanel2.indieserve.net ([199.212.143.6]:59207 "EHLO
        cpanel2.indieserve.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1754002AbeBGSJ6 (ORCPT <rfc822;git@vger.kernel.org>);
        Wed, 7 Feb 2018 13:09:58 -0500
Received: from cpec03f0ed08c7f-cm68b6fcf980b0.cpe.net.cable.rogers.com ([174.118.92.171]:33132 helo=localhost.localdomain)
        by cpanel2.indieserve.net with esmtpsa (TLSv1.2:ECDHE-RSA-AES256-GCM-SHA384:256)
        (Exim 4.89_1)
        (envelope-from <rpjday@crashcourse.ca>)
        id 1ejUAP-0005bC-Bs; Wed, 07 Feb 2018 13:09:57 -0500
Date:   Wed, 7 Feb 2018 13:09:55 -0500 (EST)
From:   "Robert P. J. Day" <rpjday@crashcourse.ca>
X-X-Sender: rpjday@localhost.localdomain
To:     Todd Zullinger <tmz@pobox.com>
cc:     Git Mailing list <git@vger.kernel.org>
Subject: Re: categorization, documentation and packaging of "git core"
 commands
In-Reply-To: <20180207172902.GL1427@zaya.teonanacatl.net>
Message-ID: <alpine.LFD.2.21.1802071308250.9047@localhost.localdomain>
References: <alpine.LFD.2.21.1802070801470.19185@android-a172fe96dd584b41> <20180207172902.GL1427@zaya.teonanacatl.net>
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

On Wed, 7 Feb 2018, Todd Zullinger wrote:

> Robert P. J. Day wrote:
> > first, here are the executables under /usr/libexec/git-core/ that
> > are unreferenced by that web page, but that should be fine as
> > almost all of them would be considered underlying helpers or
> > utilities (except for things like git-subtree, but we're still
> > unclear on its status, right?):
>
> I don't think there's anything unclear about git subtree's status.
> It's in contrib/ within the source, so it's not part of the core git
> suite.  Some distributions (Fedora being one of them) ship a
> git-subtree package to provide it for users who want it.

  not true, "git-subtree" is part of fedora's lowest-level
"git-core" package.

rday

-- 

========================================================================
Robert P. J. Day                                 Ottawa, Ontario, CANADA
                        http://crashcourse.ca

Twitter:                                       http://twitter.com/rpjday
LinkedIn:                               http://ca.linkedin.com/in/rpjday
========================================================================
