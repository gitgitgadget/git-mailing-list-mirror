Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.1 (2015-04-28) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-4.3 required=3.0 tests=AWL,BAYES_00,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,RCVD_IN_DNSWL_HI
	shortcircuit=no autolearn=ham autolearn_force=no version=3.4.1
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id B9CEB1F403
	for <e@80x24.org>; Tue, 19 Jun 2018 10:26:57 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1757220AbeFSK0z (ORCPT <rfc822;e@80x24.org>);
        Tue, 19 Jun 2018 06:26:55 -0400
Received: from smtprelay02.ispgateway.de ([80.67.18.14]:41533 "EHLO
        smtprelay02.ispgateway.de" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1757199AbeFSK0y (ORCPT <rfc822;git@vger.kernel.org>);
        Tue, 19 Jun 2018 06:26:54 -0400
Received: from [84.46.92.130] (helo=book.hvoigt.net)
        by smtprelay02.ispgateway.de with esmtpsa (TLSv1.2:ECDHE-RSA-AES256-GCM-SHA384:256)
        (Exim 4.90_1)
        (envelope-from <hvoigt@hvoigt.net>)
        id 1fVDqc-0002QQ-LA; Tue, 19 Jun 2018 12:26:50 +0200
Date:   Tue, 19 Jun 2018 12:27:17 +0200
From:   Heiko Voigt <hvoigt@hvoigt.net>
To:     Kevin Daudt <me@ikke.info>
Cc:     git@vger.kernel.org
Subject: Re: Adding nested repository with slash adds files instead of gitlink
Message-ID: <20180619102717.GB10085@book.hvoigt.net>
References: <20180618111919.GA10085@book.hvoigt.net>
 <20180618155544.GB6958@alpha>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20180618155544.GB6958@alpha>
User-Agent: Mutt/1.9.0 (2017-09-02)
X-Df-Sender: aHZvaWd0QGh2b2lndC5uZXQ=
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Hi,

On Mon, Jun 18, 2018 at 05:55:44PM +0200, Kevin Daudt wrote:
> On Mon, Jun 18, 2018 at 01:19:19PM +0200, Heiko Voigt wrote:
> > I just discovered that when you have a slash at the end of a nested
> > repository, the files contained in the repository get added instead of
> > the gitlink.
[...]
> > 
> > I just thought I put this out there. Will have a look if I find the time
> > to cook up a proper testcase and investigate.
> > 
> > Cheers Heiko
> 
> This has been the case as far as I can remember, and is basically lore
> in the #git irc channel).
> 
> This can also be reproduced by just cloning a repo inside another repo
> and running `git add path/`.

Interesting and nobody complained to the mailinglist? IMO, there is no
reason 'git add path' and 'git add path/' should behave differently or
is there?

So it seems it is a very seldom operation (in my daily work it is at
least) and people just accepted it as a quirk of git.

If someone wants to look into changing this feel free, otherwise I will
have a look, but I am not sure when yet.

Cheers Heiko
