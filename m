Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-3.2 required=3.0 tests=AWL,BAYES_00,
	HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_HI,RP_MATCHES_RCVD
	shortcircuit=no autolearn=ham autolearn_force=no version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 121AA201C8
	for <e@80x24.org>; Tue, 14 Nov 2017 09:43:56 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1754497AbdKNJny (ORCPT <rfc822;e@80x24.org>);
        Tue, 14 Nov 2017 04:43:54 -0500
Received: from cpanel2.indieserve.net ([199.212.143.6]:42951 "EHLO
        cpanel2.indieserve.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1754492AbdKNJnt (ORCPT <rfc822;git@vger.kernel.org>);
        Tue, 14 Nov 2017 04:43:49 -0500
Received: from cpec03f0ed08c7f-cm68b6fcf980b0.cpe.net.cable.rogers.com ([174.118.92.171]:40482 helo=localhost.localdomain)
        by cpanel2.indieserve.net with esmtpsa (TLSv1.2:ECDHE-RSA-AES256-GCM-SHA384:256)
        (Exim 4.89)
        (envelope-from <rpjday@crashcourse.ca>)
        id 1eEXky-0006cR-9N; Tue, 14 Nov 2017 04:43:48 -0500
Date:   Tue, 14 Nov 2017 04:43:14 -0500 (EST)
From:   "Robert P. J. Day" <rpjday@crashcourse.ca>
X-X-Sender: rpjday@localhost.localdomain
To:     Bryan Turner <bturner@atlassian.com>
cc:     Git Mailing list <git@vger.kernel.org>
Subject: Re: why can *some* git commands not be run from within .git
 directory?
In-Reply-To: <CAGyf7-FSHW4DqMXt1043FjmOO8tRQHq=xFGwQgKTK06Gi+a-PA@mail.gmail.com>
Message-ID: <alpine.LFD.2.21.1711140442180.14378@localhost.localdomain>
References: <alpine.LFD.2.21.1711140409020.13653@localhost.localdomain> <CAGyf7-FSHW4DqMXt1043FjmOO8tRQHq=xFGwQgKTK06Gi+a-PA@mail.gmail.com>
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

On Tue, 14 Nov 2017, Bryan Turner wrote:

> On Tue, Nov 14, 2017 at 1:18 AM, Robert P. J. Day <rpjday@crashcourse.ca> wrote:
> >
> >   just noticed something i was unaware of -- some git commands can't
> > be run if i'm in the .git directory, while others can. for example,
> > if i "cd .git", commands like this work just fine:
> >
> >   $ git show
> >   $ git branch
> >   $ git log
> >
> > but others seem unwilling to determine the "working tree":
>
> Once Git finds a .git directory, or determines it's in one, it
> doesn't look "higher"; instead, it runs like it's in a bare clone.
> That means any command that requires a work tree or an index
> generally won't work. Of course, you can still tell Git where the
> work tree is and then the commands work fine from the .git
> directory:

  ah, thank you, that clarifies it.

rday

-- 

========================================================================
Robert P. J. Day                                 Ottawa, Ontario, CANADA
                        http://crashcourse.ca

Twitter:                                       http://twitter.com/rpjday
LinkedIn:                               http://ca.linkedin.com/in/rpjday
========================================================================
