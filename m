Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-3.1 required=3.0 tests=AWL,BAYES_00,
	HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_HI,T_RP_MATCHES_RCVD
	shortcircuit=no autolearn=ham autolearn_force=no version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 264191F404
	for <e@80x24.org>; Fri,  9 Feb 2018 13:52:00 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1753189AbeBINv6 (ORCPT <rfc822;e@80x24.org>);
        Fri, 9 Feb 2018 08:51:58 -0500
Received: from cpanel2.indieserve.net ([199.212.143.6]:58852 "EHLO
        cpanel2.indieserve.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1751090AbeBINv4 (ORCPT <rfc822;git@vger.kernel.org>);
        Fri, 9 Feb 2018 08:51:56 -0500
Received: from 69-196-158-250.dsl.teksavvy.com ([69.196.158.250]:43924 helo=android-a172fe96dd584b41)
        by cpanel2.indieserve.net with esmtpsa (TLSv1.2:ECDHE-RSA-AES256-GCM-SHA384:256)
        (Exim 4.89_1)
        (envelope-from <rpjday@crashcourse.ca>)
        id 1ek95n-000734-Fb; Fri, 09 Feb 2018 08:51:55 -0500
Date:   Fri, 9 Feb 2018 08:51:53 -0500 (EST)
From:   "Robert P. J. Day" <rpjday@crashcourse.ca>
X-X-Sender: rpjday@android-a172fe96dd584b41
To:     Todd Zullinger <tmz@pobox.com>
cc:     Git Mailing list <git@vger.kernel.org>
Subject: Re: categorization, documentation and packaging of "git core"
 commands
In-Reply-To: <20180207211830.GO1427@zaya.teonanacatl.net>
Message-ID: <alpine.LFD.2.21.1802090848250.7128@android-a172fe96dd584b41>
References: <alpine.LFD.2.21.1802070801470.19185@android-a172fe96dd584b41> <20180207172902.GL1427@zaya.teonanacatl.net> <alpine.LFD.2.21.1802071529080.14481@localhost.localdomain> <20180207211830.GO1427@zaya.teonanacatl.net>
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
> > not to belabour this (and i'm sure it's *way* too late for that),
> > but fedora has the following packaging scheme.  first, there's a
> > bunch of stuff in "git-core", which has no dependencies on any
> > other git-related packages.
>
> The split in Fedora between git and git-core is done to minimize the
> dependencies required for a minimal git install.  The initial reason
> was to to allow installing the git-core package on systems, in
> containers, etc. without requiring perl and its various dependencies
> to be installed.
>
> The name git-core was not chosen to imply any official status as
> core versus contrib from upstream.

  ... snip ...

  oh, i understand completely (i particularly like that fedora
supports a "git-extras" package with loads of cool stuff). remember
that this all started when i pointed out that, over at
https://git-scm.com/doc, there is a link entitled "Reference Manual"
(https://git-scm.com/docs) that assures the reader, "The official and
comprehensive man pages that are included in the Git package itself",
so it's just a matter of someone deciding what *exactly* corresponds
to "the Git package itself" to make sure all relevant man pages can be
found there.

  just being pedantic, as is my wont.

rday
