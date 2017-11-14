Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-3.2 required=3.0 tests=AWL,BAYES_00,
	HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_HI,RP_MATCHES_RCVD
	shortcircuit=no autolearn=ham autolearn_force=no version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 02A72201C8
	for <e@80x24.org>; Tue, 14 Nov 2017 08:47:41 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1752809AbdKNIrj (ORCPT <rfc822;e@80x24.org>);
        Tue, 14 Nov 2017 03:47:39 -0500
Received: from cpanel2.indieserve.net ([199.212.143.6]:55471 "EHLO
        cpanel2.indieserve.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1752729AbdKNIri (ORCPT <rfc822;git@vger.kernel.org>);
        Tue, 14 Nov 2017 03:47:38 -0500
Received: from cpec03f0ed08c7f-cm68b6fcf980b0.cpe.net.cable.rogers.com ([174.118.92.171]:39898 helo=localhost.localdomain)
        by cpanel2.indieserve.net with esmtpsa (TLSv1.2:ECDHE-RSA-AES256-GCM-SHA384:256)
        (Exim 4.89)
        (envelope-from <rpjday@crashcourse.ca>)
        id 1eEWsa-0003Sf-SL; Tue, 14 Nov 2017 03:47:36 -0500
Date:   Tue, 14 Nov 2017 03:47:05 -0500 (EST)
From:   "Robert P. J. Day" <rpjday@crashcourse.ca>
X-X-Sender: rpjday@localhost.localdomain
To:     Eric Sunshine <sunshine@sunshineco.com>
cc:     Git Mailing list <git@vger.kernel.org>,
        =?VISCII?Q?Nguy=ADn_Th=E1i_Ng=F7c_Duy?= <pclouds@gmail.com>
Subject: Re: man page for "git-worktree" is a bit confusing WRT "prune"
In-Reply-To: <CAPig+cR2W2zKcjLYjd1E4jhMkad3O2ioncCZhkExGopxa_0_xg@mail.gmail.com>
Message-ID: <alpine.LFD.2.21.1711140345430.12112@localhost.localdomain>
References: <alpine.LFD.2.21.1711130938080.5262@DESKTOP-1GPMCEJ> <CAPig+cRLcJ2a=QKyKAkaNiewoWMQvKr_AWePKYVpGS5S9g-i1Q@mail.gmail.com> <alpine.LFD.2.21.1711131603340.6299@localhost.localdomain>
 <CAPig+cR2W2zKcjLYjd1E4jhMkad3O2ioncCZhkExGopxa_0_xg@mail.gmail.com>
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

On Mon, 13 Nov 2017, Eric Sunshine wrote:

> On Mon, Nov 13, 2017 at 4:06 PM, Robert P. J. Day <rpjday@crashcourse.ca> wrote:

... snip ...

> >   how is this "expire time" measured? relative to what? i've
> > looked under .git/worktrees/<wtname>, and i see a bunch of files
> > defining that worktree, but it's not clear how a worktree stores
> > the relevant time to be used for the determination of when a
> > worktree "expires".
>
> According to Documentation/gitrepository-layout.txt:
>
>     worktrees/<id>/gitdir::
>         A text file containing the absolute path back to the .git file
>         that points to here. This is used to check if the linked
>         repository has been manually removed and there is no need to
>         keep this directory any more. The mtime of this file should be
>         updated every time the linked repository is accessed.
>
> So, the expire time is relative to the mtime of the 'gitdir' file for
> that worktree...

  yup, that clears it up, thanks.

rday

-- 

========================================================================
Robert P. J. Day                                 Ottawa, Ontario, CANADA
                        http://crashcourse.ca

Twitter:                                       http://twitter.com/rpjday
LinkedIn:                               http://ca.linkedin.com/in/rpjday
========================================================================
