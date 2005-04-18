From: Linus Torvalds <torvalds@osdl.org>
Subject: Re: full kernel history, in patchset format
Date: Sun, 17 Apr 2005 18:16:43 -0700 (PDT)
Message-ID: <Pine.LNX.4.58.0504171816040.7211@ppc970.osdl.org>
References: <20050416131528.GB19908@elte.hu> <Pine.LNX.4.58.0504160953310.7211@ppc970.osdl.org>
 <1113780698.11910.8.camel@localhost.localdomain> <20050417233936.GV1461@pasky.ji.cz>
 <1113782805.11910.36.camel@localhost.localdomain> <20050418003526.GD1461@pasky.ji.cz>
Mime-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Cc: David Woodhouse <dwmw2@infradead.org>, Ingo Molnar <mingo@elte.hu>,
	git@vger.kernel.org
X-From: git-owner@vger.kernel.org Mon Apr 18 03:11:20 2005
Return-path: <git-owner@vger.kernel.org>
Received: from vger.kernel.org ([12.107.209.244])
	by ciao.gmane.org with esmtp (Exim 4.43)
	id 1DNKn5-0004Ff-IM
	for gcvg-git@gmane.org; Mon, 18 Apr 2005 03:11:07 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261476AbVDRBO6 (ORCPT <rfc822;gcvg-git@m.gmane.org>);
	Sun, 17 Apr 2005 21:14:58 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261493AbVDRBO6
	(ORCPT <rfc822;git-outgoing>); Sun, 17 Apr 2005 21:14:58 -0400
Received: from fire.osdl.org ([65.172.181.4]:42699 "EHLO smtp.osdl.org")
	by vger.kernel.org with ESMTP id S261476AbVDRBO4 (ORCPT
	<rfc822;git@vger.kernel.org>); Sun, 17 Apr 2005 21:14:56 -0400
Received: from shell0.pdx.osdl.net (fw.osdl.org [65.172.181.6])
	by smtp.osdl.org (8.12.8/8.12.8) with ESMTP id j3I1Eks4002594
	(version=TLSv1/SSLv3 cipher=EDH-RSA-DES-CBC3-SHA bits=168 verify=NO);
	Sun, 17 Apr 2005 18:14:46 -0700
Received: from localhost (shell0.pdx.osdl.net [10.9.0.31])
	by shell0.pdx.osdl.net (8.13.1/8.11.6) with ESMTP id j3I1Ejw5016319;
	Sun, 17 Apr 2005 18:14:45 -0700
To: Petr Baudis <pasky@ucw.cz>
In-Reply-To: <20050418003526.GD1461@pasky.ji.cz>
X-Spam-Status: No, hits=0 required=5 tests=
X-Spam-Checker-Version: SpamAssassin 2.63-osdl_revision__1.35__
X-MIMEDefang-Filter: osdl$Revision: 1.109 $
X-Scanned-By: MIMEDefang 2.36
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org



On Mon, 18 Apr 2005, Petr Baudis wrote:

> Dear diary, on Mon, Apr 18, 2005 at 02:06:43AM CEST, I got a letter
> where David Woodhouse <dwmw2@infradead.org> told me that...
> > On Mon, 2005-04-18 at 01:39 +0200, Petr Baudis wrote:
> > > Of course an entirely different thing are _trees_ associated with those
> > > commits. As long as you stay with a simple three-way merge, you
> > > basically never want to look at trees which aren't heads and which you
> > > don't specifically request to look at. And the trees and what they carry
> > > inside is the main bulk of data.
> > 
> > If the trees are absent and you're trying to merge, what do you gain
> > from having the commit objects?
> 
> merge-base

Alternatively, you can have just the rev-tree cache of them. That's what
it was designed for (along with avoiding to have to read 60,000 commits).

		Linus
