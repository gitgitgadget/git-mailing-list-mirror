From: Shawn Pearce <spearce@spearce.org>
Subject: Re: [RFC] get_sha1() shorthands for blob/tree objects
Date: Tue, 18 Apr 2006 20:21:59 -0400
Message-ID: <20060419002159.GD8915@spearce.org>
References: <Pine.LNX.4.64.0604181627101.3701@g5.osdl.org> <46a038f90604181714j6fce1867wc17952d898f8e7ae@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: Linus Torvalds <torvalds@osdl.org>,
	Junio C Hamano <junkio@cox.net>,
	Git Mailing List <git@vger.kernel.org>
X-From: git-owner@vger.kernel.org Wed Apr 19 02:22:17 2006
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by ciao.gmane.org with esmtp (Exim 4.43)
	id 1FW0SQ-0001wk-Uu
	for gcvg-git@gmane.org; Wed, 19 Apr 2006 02:22:11 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1750936AbWDSAWI (ORCPT <rfc822;gcvg-git@m.gmane.org>);
	Tue, 18 Apr 2006 20:22:08 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1750941AbWDSAWI
	(ORCPT <rfc822;git-outgoing>); Tue, 18 Apr 2006 20:22:08 -0400
Received: from corvette.plexpod.net ([64.38.20.226]:46021 "EHLO
	corvette.plexpod.net") by vger.kernel.org with ESMTP
	id S1750936AbWDSAWG (ORCPT <rfc822;git@vger.kernel.org>);
	Tue, 18 Apr 2006 20:22:06 -0400
Received: from cpe-72-226-60-173.nycap.res.rr.com ([72.226.60.173] helo=asimov.home.spearce.org)
	by corvette.plexpod.net with esmtpa (Exim 4.52)
	id 1FW0S7-0006FZ-DC; Tue, 18 Apr 2006 20:21:51 -0400
Received: by asimov.home.spearce.org (Postfix, from userid 1000)
	id A294F20FBB4; Tue, 18 Apr 2006 20:21:59 -0400 (EDT)
To: Martin Langhoff <martin.langhoff@gmail.com>
Content-Disposition: inline
In-Reply-To: <46a038f90604181714j6fce1867wc17952d898f8e7ae@mail.gmail.com>
User-Agent: Mutt/1.5.11
X-AntiAbuse: This header was added to track abuse, please include it with any abuse report
X-AntiAbuse: Primary Hostname - corvette.plexpod.net
X-AntiAbuse: Original Domain - vger.kernel.org
X-AntiAbuse: Originator/Caller UID/GID - [0 0] / [47 12]
X-AntiAbuse: Sender Address Domain - spearce.org
X-Source: 
X-Source-Args: 
X-Source-Dir: 
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org

Not that my voice carries much weight, but a coworker has been
asking for this feature to be added to pg for months.  I've just
been too lazy to get around to writing the shell code to do it.
Making it part of git cat-file seems like a good idea, making it
usable by other tools like git diff just rocks.  :-)

I think its a very worthwhile addition.

Martin Langhoff <martin.langhoff@gmail.com> wrote:
> On 4/19/06, Linus Torvalds <torvalds@osdl.org> wrote:
> 
> >   What do people think? Have you ever wanted to
> >   access individual files in some random revision? Do you think this is
> >   useful?
> 
> Definitely, I've several times had to go through contortions to do
> this easily, and I've ended up turning to gitweb often to quickly see
> the state of a file at a given revision.
> 
> > With this, you can do something like
> >
> >         git cat-file blob v1.2.4:Makefile
> >
> > to get the contents of "Makefile" at revision v1.2.4.
> >
> > Now, this isn't necessarily something you really need all that often, but
> > the concept itself is actually pretty powerful. We could, for example,
> > allow things like
> >
> >         git diff v0.99.6:git-commit-script..v1.3.0:git-commit.sh
> 
> These two examples are more than enough -- I buy ;-)

-- 
Shawn.
