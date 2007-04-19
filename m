From: Linus Torvalds <torvalds@linux-foundation.org>
Subject: Re: GIT vs Other: Need argument
Date: Thu, 19 Apr 2007 09:43:50 -0700 (PDT)
Message-ID: <alpine.LFD.0.98.0704190940330.9964@woody.linux-foundation.org>
References: <aa69c80b0704170202r3f35acc7ydb81708e747c69ff@mail.gmail.com>
 <20070417104520.GB4946@moonlight.home> <8b65902a0704170841q64fe0828mdefe78963394a616@mail.gmail.com>
 <200704171818.28256.andyparkins@gmail.com> <20070417173007.GV2229@spearce.org>
 <462521C7.2050103@softax.com.pl> <Pine.LNX.4.64.0704181130150.12094@racer.site>
 <alpine.LFD.0.98.0704180851060.2828@woody.linux-foundation.org>
 <Pine.LNX.4.64.0704191118050.8822@racer.site>
Mime-Version: 1.0
Content-Type: TEXT/PLAIN; charset=us-ascii
Cc: Marcin Kasperski <Marcin.Kasperski@softax.com.pl>,
	git@vger.kernel.org
To: Johannes Schindelin <Johannes.Schindelin@gmx.de>
X-From: git-owner@vger.kernel.org Thu Apr 19 18:44:30 2007
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1HeZk6-0001HR-HC
	for gcvg-git@gmane.org; Thu, 19 Apr 2007 18:44:22 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1766870AbXDSQoR (ORCPT <rfc822;gcvg-git@m.gmane.org>);
	Thu, 19 Apr 2007 12:44:17 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1766873AbXDSQoR
	(ORCPT <rfc822;git-outgoing>); Thu, 19 Apr 2007 12:44:17 -0400
Received: from smtp1.linux-foundation.org ([65.172.181.25]:51269 "EHLO
	smtp1.linux-foundation.org" rhost-flags-OK-OK-OK-OK)
	by vger.kernel.org with ESMTP id S1766874AbXDSQoP (ORCPT
	<rfc822;git@vger.kernel.org>); Thu, 19 Apr 2007 12:44:15 -0400
Received: from shell0.pdx.osdl.net (fw.osdl.org [65.172.181.6])
	by smtp1.linux-foundation.org (8.13.5.20060308/8.13.5/Debian-3ubuntu1.1) with ESMTP id l3JGhri9004258
	(version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-SHA bits=256 verify=NO);
	Thu, 19 Apr 2007 09:43:54 -0700
Received: from localhost (shell0.pdx.osdl.net [10.9.0.31])
	by shell0.pdx.osdl.net (8.13.1/8.11.6) with ESMTP id l3JGhobv025266;
	Thu, 19 Apr 2007 09:43:51 -0700
In-Reply-To: <Pine.LNX.4.64.0704191118050.8822@racer.site>
X-Spam-Status: No, hits=-3.043 required=5 tests=AWL,BAYES_00
X-Spam-Checker-Version: SpamAssassin 3.1.0-osdl_revision__1.12__
X-MIMEDefang-Filter: osdl$Revision: 1.177 $
X-Scanned-By: MIMEDefang 2.53 on 65.172.181.25
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/45029>



On Thu, 19 Apr 2007, Johannes Schindelin wrote:
> 
> > Actually, at this stage, I really think cogito just *complicates* git 
> > usage.
> 
> Hmm. However, I have to say that cogito serves/d another purpose quite 
> well: Look at what came from cogito into git. Loads of useful 
> enhancements. So, I really have to point to "at this stage", because that 
> sure was not true 18 months ago.

Absolutely. I think there are still some pieces of cogito that we might 
want to migrate into git too, although they're fairly esoteric (ie the 
whole history rewriting thing). And I think we still have some places 
where git is influenced by cogito doing things differently (ie the whole 
branch tracking stuff) where we may want to change our default behaviour 
or extend on things.

So yes, "at this stage" was the operative word.

> I guess that we should not say that Git is complicated. People tend to 
> believe that, but it is simply not true. The basic steps are easy. Really 
> easy.
> 
> But Git does not keep you there.

I agree. And to some degree I suspect that the documentation pushes some 
of the advanced things a bit *too* eagerly.

Of course, with many of the projects that use git being very 
branch-oriented, I guess some of that is inevitable. You can't *not* 
mention branches, simply because even people who only track other peoples 
work do end up often needing to know about it, or at least hearing about 
them..

		Linus
