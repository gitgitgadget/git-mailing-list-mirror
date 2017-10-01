Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-3.3 required=3.0 tests=AWL,BAYES_00,
	HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_HI,RP_MATCHES_RCVD
	shortcircuit=no autolearn=ham autolearn_force=no version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 432A920A10
	for <e@80x24.org>; Sun,  1 Oct 2017 21:30:04 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1751915AbdJAVaC (ORCPT <rfc822;e@80x24.org>);
        Sun, 1 Oct 2017 17:30:02 -0400
Received: from cpanel2.indieserve.net ([199.212.143.6]:35796 "EHLO
        cpanel2.indieserve.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1751437AbdJAVaB (ORCPT <rfc822;git@vger.kernel.org>);
        Sun, 1 Oct 2017 17:30:01 -0400
Received: from cpec03f0ed08c7f-cm68b6fcf980b0.cpe.net.cable.rogers.com ([174.118.92.171]:50872 helo=localhost.localdomain)
        by cpanel2.indieserve.net with esmtpsa (TLSv1.2:ECDHE-RSA-AES256-GCM-SHA384:256)
        (Exim 4.89)
        (envelope-from <rpjday@crashcourse.ca>)
        id 1dyloG-0001tD-Dm; Sun, 01 Oct 2017 17:30:00 -0400
Date:   Sun, 1 Oct 2017 17:29:58 -0400 (EDT)
From:   "Robert P. J. Day" <rpjday@crashcourse.ca>
X-X-Sender: rpjday@localhost.localdomain
To:     Johannes Sixt <j6t@kdbg.org>
cc:     Bryan Turner <bturner@atlassian.com>,
        Git Mailing list <git@vger.kernel.org>
Subject: Re: what is git's position on "classic" mac <CR>-only end of
 lines?
In-Reply-To: <a8cb7c82-4598-5dce-0e0e-b0f18157cc56@kdbg.org>
Message-ID: <alpine.LFD.2.21.1710011723360.27763@localhost.localdomain>
References: <alpine.LFD.2.21.1710011349560.23227@localhost.localdomain> <CAGyf7-H+1Djb_dmzfOO3qqM9+2VKvbqVedn4mof9Hq4huDTsqw@mail.gmail.com> <a8cb7c82-4598-5dce-0e0e-b0f18157cc56@kdbg.org>
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

On Sun, 1 Oct 2017, Johannes Sixt wrote:

> Am 01.10.2017 um 21:29 schrieb Bryan Turner:
> > On Sun, Oct 1, 2017 at 10:52 AM, Robert P. J. Day <rpjday@crashcourse.ca>
> > wrote:
> > >
> > >    sorry for more pedantic nitpickery, but i'm trying to write a
> > > section on how to properly process mixtures of EOLs in git, and
> > > when i read "man git-config", everything seems to refer to Mac
> > > OS X and macOS (and linux, of course) using <LF> for EOL, with
> > > very little mention of what one does if faced with "classic" mac
> > > EOL of just <CR>.
> >
> >   No command in Git that I'm aware of considers a standalone <CR>
> > to be a line ending. A file containing only <CR>s is treated as a
> > single line by every Git command I've used. I'm not sure whether
> > that behavior is configurable. For files with standalone <CR>s
> > mixed with other line endings (<CRLF> or <LF>, either or both),
> > the <CRLF> and <LF> endings are both considered line endings while
> > the standalone <CR>s are not.
>
> That's true, AFAIK. In addition, when Git auto-detects whether a
> file is binary or text, then a file with a bare CR is treated as
> binary:
>
> https://github.com/git/git/blob/master/convert.c#L91
>
> That basically amounts to: "it [is] considered not important enough
> to deal with" ;)

  that's fine, that's all i was after -- basically, git handles Mac OS
X and macOS, and if you're dealing with mac "classic" EOLs, well ...

  http://i.imgur.com/z96dZ0x.jpg

rday

-- 

========================================================================
Robert P. J. Day                                 Ottawa, Ontario, CANADA
                        http://crashcourse.ca

Twitter:                                       http://twitter.com/rpjday
LinkedIn:                               http://ca.linkedin.com/in/rpjday
========================================================================
