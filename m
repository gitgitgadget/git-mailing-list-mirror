Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.1 (2015-04-28) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-3.8 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,RCVD_IN_DNSWL_HI,
	T_DKIM_INVALID shortcircuit=no autolearn=ham autolearn_force=no version=3.4.1
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 119FD1F403
	for <e@80x24.org>; Fri,  8 Jun 2018 14:46:01 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1752927AbeFHOp7 (ORCPT <rfc822;e@80x24.org>);
        Fri, 8 Jun 2018 10:45:59 -0400
Received: from imap.thunk.org ([74.207.234.97]:50298 "EHLO imap.thunk.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1752913AbeFHOp4 (ORCPT <rfc822;git@vger.kernel.org>);
        Fri, 8 Jun 2018 10:45:56 -0400
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; d=thunk.org;
         s=ef5046eb; h=In-Reply-To:Content-Type:MIME-Version:References:Message-ID:
        Subject:Cc:To:From:Date:Sender:Reply-To:Content-Transfer-Encoding:Content-ID:
        Content-Description:Resent-Date:Resent-From:Resent-Sender:Resent-To:Resent-Cc
        :Resent-Message-ID:List-Id:List-Help:List-Unsubscribe:List-Subscribe:
        List-Post:List-Owner:List-Archive;
        bh=o+CHI/1cfxo1d23BIkNoiit8L1ssCPziIt+7Iy853Q0=; b=rMzFQfikocssKjFnk+/Tzqf5PW
        D6hu6WORTJ3V+3X/7NadS2w/Ke0v5nKkxAJzTY5Bz8tLTpTdMZJ6A6SDrSzgf2qqEr07Ylpl7gfTB
        tO/20jr7w2BGwX/D7h6Q5lScvwPl7IM8j+V1j4yu7FyfKedJFkjG9BFyPpR7QVKggT54=;
Received: from root (helo=callcc.thunk.org)
        by imap.thunk.org with local-esmtp (Exim 4.89)
        (envelope-from <tytso@thunk.org>)
        id 1fRIeG-0002de-0L; Fri, 08 Jun 2018 14:45:52 +0000
Received: by callcc.thunk.org (Postfix, from userid 15806)
        id 5641D7A417D; Fri,  8 Jun 2018 10:45:51 -0400 (EDT)
Date:   Fri, 8 Jun 2018 10:45:51 -0400
From:   "Theodore Y. Ts'o" <tytso@mit.edu>
To:     Peter Backes <rtc@helen.PLASMA.Xg8.DE>
Cc:     David Lang <david@lang.hm>, Philip Oakley <philipoakley@iee.org>,
        =?iso-8859-1?Q?=C6var_Arnfj=F6r=F0?= Bjarmason <avarab@gmail.com>,
        Git Mailing List <git@vger.kernel.org>
Subject: Re: GDPR compliance best practices?
Message-ID: <20180608144551.GB12749@thunk.org>
References: <6BE308009FFA4CCDB5B3B47C2AC53E20@PhilipOakley>
 <20180603174617.GA10900@helen.PLASMA.Xg8.DE>
 <alpine.DEB.2.02.1806061831340.7659@nftneq.ynat.uz>
 <20180607063225.GA28343@helen.PLASMA.Xg8.DE>
 <3EF5AC29192A4D179B6D8689ECB991CC@PhilipOakley>
 <20180607223442.GA5322@helen.PLASMA.Xg8.DE>
 <alpine.DEB.2.02.1806071535510.27871@nftneq.ynat.uz>
 <20180607232128.GA5879@helen.PLASMA.Xg8.DE>
 <20180608025313.GA12749@thunk.org>
 <20180608062657.GB9383@helen.PLASMA.Xg8.DE>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20180608062657.GB9383@helen.PLASMA.Xg8.DE>
User-Agent: Mutt/1.10.0 (2018-05-17)
X-SA-Exim-Connect-IP: <locally generated>
X-SA-Exim-Mail-From: tytso@thunk.org
X-SA-Exim-Scanned: No (on imap.thunk.org); SAEximRunCond expanded to false
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

On Fri, Jun 08, 2018 at 08:26:57AM +0200, Peter Backes wrote:
> 
> If you run a website where the world can access a repository, you are 
> responsible for obeying the GDPR with respect to that repository. If 
> you receive a request to be forgotten, you have to make sure you stop 
> publishing that author's identity as part of the repository.
>

*Anyone* can run a repository.  It's not just github and gitlab.  The
hobbiest in New Zealand, who might never visit Europe (so she can't
be arrested when she visits the fair shores of Europe) and who has no
business interests in Europe, can host such a web site.

So the person trying to engage in censorship would need to contact
*everyone*.  And someone who has a git note in their private repo who
then pushes to github/gitlab would end up pushing that note back up to
the web server.

> You do NOT need to
> 
> - delete it from a private copy you have
> - care about others who publish that data
> - or even make sure the data is deleted from private copies others may 
> have, even if the number of copies is in the thousands.

Great, so you can get github and gitlab to get rid of the information.
But it's *pointless*.  And given that real developers really do care
about who authored a patch, and regularly will do operations that
reference the authorship information, the fact that it is stored
somewhere else (e.g., in a git note, per your proposal), *will* slow
down those operations.

> In practical terms, if someone wishes to exercise his right to be 
> forgotten, he will usually send the request to the maintainer and stop 
> him from distributing the information, and perhaps to a third party he 
> might use as a platform for publication, such as github.

Your problem is in the word: "a"

							- Ted
