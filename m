Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-3.2 required=3.0 tests=AWL,BAYES_00,
	HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_HI,RP_MATCHES_RCVD
	shortcircuit=no autolearn=ham autolearn_force=no version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 6039A1F42B
	for <e@80x24.org>; Fri, 10 Nov 2017 21:14:12 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1750973AbdKJVOK (ORCPT <rfc822;e@80x24.org>);
        Fri, 10 Nov 2017 16:14:10 -0500
Received: from cpanel2.indieserve.net ([199.212.143.6]:57659 "EHLO
        cpanel2.indieserve.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1753805AbdKJVOJ (ORCPT <rfc822;git@vger.kernel.org>);
        Fri, 10 Nov 2017 16:14:09 -0500
Received: from cpec03f0ed08c7f-cm68b6fcf980b0.cpe.net.cable.rogers.com ([174.118.92.171]:57516 helo=localhost.localdomain)
        by cpanel2.indieserve.net with esmtpsa (TLSv1.2:ECDHE-RSA-AES256-GCM-SHA384:256)
        (Exim 4.89)
        (envelope-from <rpjday@crashcourse.ca>)
        id 1eDGcq-0007lk-L5; Fri, 10 Nov 2017 16:14:08 -0500
Date:   Fri, 10 Nov 2017 16:13:46 -0500 (EST)
From:   "Robert P. J. Day" <rpjday@crashcourse.ca>
X-X-Sender: rpjday@localhost.localdomain
To:     Eric Sunshine <sunshine@sunshineco.com>
cc:     Git Mailing list <git@vger.kernel.org>
Subject: Re: [PATCH] bisect: mention "view" as an alternative to
 "visualize"
In-Reply-To: <CAPig+cRtpmtD8XqhdXrn1iWOEf9Yx=TXQB=yvXBZ+uR_+XRcPg@mail.gmail.com>
Message-ID: <alpine.LFD.2.21.1711101609240.6187@localhost.localdomain>
References: <alpine.LFD.2.21.1711101123280.6717@DESKTOP-1GPMCEJ> <CAPig+cRtpmtD8XqhdXrn1iWOEf9Yx=TXQB=yvXBZ+uR_+XRcPg@mail.gmail.com>
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

On Fri, 10 Nov 2017, Eric Sunshine wrote:

> Thanks for the patch. Some comments below...
>
> On Fri, Nov 10, 2017 at 11:32 AM, Robert P. J. Day
> <rpjday@crashcourse.ca> wrote:
> > Tweak a number of files to mention "view" as an alternative to
> > "visualize":
>
> You probably want to end this sentence with a period, not a colon.

  not sure about that, what's the standard when you're introducing a
code snippet?

> >  Documentation/git-bisect.txt           | 9 ++++-----
> >  Documentation/user-manual.txt          | 3 ++-
> >  builtin/bisect--helper.c               | 2 +-
> >  contrib/completion/git-completion.bash | 2 +-
> >  git-bisect.sh                          | 4 ++--
> >  5 files changed, 10 insertions(+), 10 deletions(-)
>
> The diffstat belongs below the "---" separator, otherwise this text
> will (undesirably) become part of the commit message proper.

  no, i actually want that as part of the commit message. my standard
is, if there are 5 or more files that get changed, i like to include a
diff --stat in the commit message so people viewing the log can get a
quick idea of how much has changed. if that's not desired here, i can
remove it.

> > + git bisect visualize|view
>
> I think you need parentheses around these terms (see "git bisect
> skip", for example):
>
>     git bisect (visualize | view)

  ah, quite so.

> However, in this case, it might be easier for readers if each is
> presented on its own line (and subsequent discussion can make it clear
> that they are synonyms).
>
>     git bisect visualize
>     git bisect view
>
> But, that's a matter of taste...

  given the precedent already established:

   git bisect (bad|new|<term-new>) [<rev>]
   git bisect (good|old|<term-old>) [<rev>...]

i'll go with the parentheses and no intervening spaces. i'll let that
posting simmer for a bit longer before posting "v2".

rday

-- 

========================================================================
Robert P. J. Day                                 Ottawa, Ontario, CANADA
                        http://crashcourse.ca

Twitter:                                       http://twitter.com/rpjday
LinkedIn:                               http://ca.linkedin.com/in/rpjday
========================================================================
