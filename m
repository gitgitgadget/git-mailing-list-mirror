Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-3.2 required=3.0 tests=AWL,BAYES_00,
	HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_HI,RP_MATCHES_RCVD
	shortcircuit=no autolearn=ham autolearn_force=no version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 72ACC1F42B
	for <e@80x24.org>; Sun, 12 Nov 2017 09:17:53 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1752276AbdKLJRt (ORCPT <rfc822;e@80x24.org>);
        Sun, 12 Nov 2017 04:17:49 -0500
Received: from cpanel2.indieserve.net ([199.212.143.6]:45836 "EHLO
        cpanel2.indieserve.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1751916AbdKLJRr (ORCPT <rfc822;git@vger.kernel.org>);
        Sun, 12 Nov 2017 04:17:47 -0500
Received: from cpec03f0ed08c7f-cm68b6fcf980b0.cpe.net.cable.rogers.com ([174.118.92.171]:55252 helo=localhost.localdomain)
        by cpanel2.indieserve.net with esmtpsa (TLSv1.2:ECDHE-RSA-AES256-GCM-SHA384:256)
        (Exim 4.89)
        (envelope-from <rpjday@crashcourse.ca>)
        id 1eDoOf-0001gV-Jn; Sun, 12 Nov 2017 04:17:45 -0500
Date:   Sun, 12 Nov 2017 04:17:20 -0500 (EST)
From:   "Robert P. J. Day" <rpjday@crashcourse.ca>
X-X-Sender: rpjday@localhost.localdomain
To:     Theodore Ts'o <tytso@mit.edu>
cc:     Junio C Hamano <gitster@pobox.com>,
        Christian Couder <christian.couder@gmail.com>,
        Git Mailing list <git@vger.kernel.org>,
        Stephan Beyer <s-beyer@gmx.net>
Subject: Re: should "git bisect" support "git bisect next?"
In-Reply-To: <20171111194616.a2hl4dwz5cycuzdh@thunk.org>
Message-ID: <alpine.LFD.2.21.1711120415190.28956@localhost.localdomain>
References: <alpine.LFD.2.21.1711110639120.5632@localhost.localdomain> <CAP8UFD3az17BpB0nA+35p3BP95sBuOY0Yvce3cgbh0L3YH7+rQ@mail.gmail.com> <xmqq4lq0ev8g.fsf@gitster.mtv.corp.google.com> <20171111194616.a2hl4dwz5cycuzdh@thunk.org>
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

On Sat, 11 Nov 2017, Theodore Ts'o wrote:

> On Sat, Nov 11, 2017 at 11:38:23PM +0900, Junio C Hamano wrote:
> >
> > Thanks for saving me time to explain why 'next' is still a very
> > important command but the end users do not actually need to be
> > strongly aware of it, because most commands automatically invokes
> > it as their final step due to the importance of what it does ;-)
>
> This reminds me; is there a way to suppress it because I'm about to
> give a large set of good and bit commits (perhaps because I'm
                      ^^^^^^^^^^^^^^^^^^^^
> replaying part of a git biset log, minus one or two lines that are
> suspected of being bogus thanks to flaky reproduction), and so
> there's no point having git bisect figure the "next" commit to try
> until I'm done giving it a list of good/bad commits?

  i'm sure i'll regret asking this, but (assuming "bit" should read
"bad") is this suggesting one can hand bisect more than one bad
commit? i thought we just went through that discussion where there
could be only one bad commit but multiple good commits. clarification?

rday

-- 

========================================================================
Robert P. J. Day                                 Ottawa, Ontario, CANADA
                        http://crashcourse.ca

Twitter:                                       http://twitter.com/rpjday
LinkedIn:                               http://ca.linkedin.com/in/rpjday
========================================================================
