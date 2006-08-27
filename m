From: Linus Torvalds <torvalds@osdl.org>
Subject: Re: [PATCH 00/19] gitweb: Remove dependency on external diff and
 need for temporary files
Date: Sat, 26 Aug 2006 20:54:25 -0700 (PDT)
Message-ID: <Pine.LNX.4.64.0608262051050.11811@g5.osdl.org>
References: <200608240015.15071.jnareb@gmail.com> <200608252315.57181.jnareb@gmail.com>
 <Pine.LNX.4.64.0608262026230.11811@g5.osdl.org> <20060826.204208.85688529.davem@davemloft.net>
Mime-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Cc: jnareb@gmail.com, git@vger.kernel.org
X-From: git-owner@vger.kernel.org Sun Aug 27 05:54:49 2006
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by ciao.gmane.org with esmtp (Exim 4.43)
	id 1GHBjR-0000JQ-Rg
	for gcvg-git@gmane.org; Sun, 27 Aug 2006 05:54:46 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751184AbWH0Dyd (ORCPT <rfc822;gcvg-git@m.gmane.org>);
	Sat, 26 Aug 2006 23:54:33 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751277AbWH0Dyd
	(ORCPT <rfc822;git-outgoing>); Sat, 26 Aug 2006 23:54:33 -0400
Received: from smtp.osdl.org ([65.172.181.4]:18850 "EHLO smtp.osdl.org")
	by vger.kernel.org with ESMTP id S1751184AbWH0Dyd (ORCPT
	<rfc822;git@vger.kernel.org>); Sat, 26 Aug 2006 23:54:33 -0400
Received: from shell0.pdx.osdl.net (fw.osdl.org [65.172.181.6])
	by smtp.osdl.org (8.12.8/8.12.8) with ESMTP id k7R3sRnW028801
	(version=TLSv1/SSLv3 cipher=EDH-RSA-DES-CBC3-SHA bits=168 verify=NO);
	Sat, 26 Aug 2006 20:54:27 -0700
Received: from localhost (shell0.pdx.osdl.net [10.9.0.31])
	by shell0.pdx.osdl.net (8.13.1/8.11.6) with ESMTP id k7R3sPC6013926;
	Sat, 26 Aug 2006 20:54:26 -0700
To: David Miller <davem@davemloft.net>
In-Reply-To: <20060826.204208.85688529.davem@davemloft.net>
X-Spam-Status: No, hits=-0.935 required=5 tests=AWL,OSDL_HEADER_SUBJECT_BRACKETED
X-Spam-Checker-Version: SpamAssassin 2.63-osdl_revision__1.94__
X-MIMEDefang-Filter: osdl$Revision: 1.143 $
X-Scanned-By: MIMEDefang 2.36
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/26086>



On Sat, 26 Aug 2006, David Miller wrote:
> 
> > Ok, can we now please fix my final annouyance, which is that gitweb from 
> > the very beginning has apparently believed that the "Signed-off-by:" etc 
> > lines are not important, and they get stripped away when looking at the 
> > "commit-diff".
> 
> Isn't this to keep the email address from being published on the web
> and thus harvested by spammers?

Well, since gitweb already exposes all of those in the "commit" thing (in 
a different color, but they are there), I don't see why "commit-diff" 
wouldn't show the same data..

I would certainly _hope_ that every developer has a spam blocker. I don't 
think not showing email addresses is the answer to _that_ particular 
problem (and if somebody wants to harvest the email addresses for a git 
project that is exposed with gitweb, there are more efficient ways to do 
that ;)

		Linus
