Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.2 (2018-09-13) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-4.0 required=3.0 tests=AWL,BAYES_00,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,RCVD_IN_DNSWL_HI
	shortcircuit=no autolearn=ham autolearn_force=no version=3.4.2
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id D5303211B4
	for <e@80x24.org>; Sun,  2 Dec 2018 16:59:04 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1725791AbeLBQ7F (ORCPT <rfc822;e@80x24.org>);
        Sun, 2 Dec 2018 11:59:05 -0500
Received: from ikke.info ([178.21.113.177]:43298 "EHLO vps892.directvps.nl"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1725789AbeLBQ7F (ORCPT <rfc822;git@vger.kernel.org>);
        Sun, 2 Dec 2018 11:59:05 -0500
X-Greylist: delayed 378 seconds by postgrey-1.27 at vger.kernel.org; Sun, 02 Dec 2018 11:59:04 EST
Received: by vps892.directvps.nl (Postfix, from userid 1008)
        id 292F1440613; Sun,  2 Dec 2018 17:52:42 +0100 (CET)
Date:   Sun, 2 Dec 2018 17:52:42 +0100
From:   Kevin Daudt <me@ikke.info>
To:     "Robert P. J. Day" <rpjday@crashcourse.ca>
Cc:     Git Mailing list <git@vger.kernel.org>
Subject: Re: "git add -p" versus "git add -i", followed by "p"
Message-ID: <20181202165242.GA4823@alpha>
References: <alpine.LFD.2.21.1812021124350.5509@localhost.localdomain>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <alpine.LFD.2.21.1812021124350.5509@localhost.localdomain>
User-Agent: Mutt/1.10.1 (2018-07-13)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

On Sun, Dec 02, 2018 at 11:30:19AM -0500, Robert P. J. Day wrote:
> 
>   testing adding by patch for the very first time (i've just never
> needed this), and reading the "progit" book and reading the man page,
> and the impression i'm getting is that running "git add -p" (going
> straight to patch mode) is supposed to be equivalent to running "git
> add -i", then typing "p" to switch to patch mode.
> 
>   that is most emphatically not what i'm seeing. if i run "git add
> -p", then i get to what i expect -- the patch subsystem:
> 
>   $ git add -p
>   diff --git a/README.asc b/README.asc
>   index fa40bad..840e85b 100644
>   --- a/README.asc
>   +++ b/README.asc
>   @@ -1,3 +1,9 @@
>   +change 1
>   +
>   +
>   +
>   +
>   +
>    = Pro Git, Second Edition
> 
>    Welcome to the second edition of the Pro Git book.
>   Stage this hunk [y,n,q,a,d,j,J,g,/,e,?]?
> 
> but if i start with "git add -i", there seems to be no way to get to
> patch mode -- certainly "p" doesn't do it. am i stupidly missing
> something trivial? is the explanation misleading or inncomplete?
> 
> rday
> 
> -- 
> 

After selecting 'p', what do you get?

You should see a list of modified files. You can select the files you
want to stage by the listed numbers. After you selected those files, you
press enter, and then you will get the options you'll also see with git
add -p.

Kevin
