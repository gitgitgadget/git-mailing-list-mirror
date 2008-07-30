From: Linus Torvalds <torvalds@linux-foundation.org>
Subject: Re: Bizarre missing changes (git bug?)
Date: Tue, 29 Jul 2008 20:35:54 -0700 (PDT)
Message-ID: <alpine.LFD.1.10.0807292028290.3334@nehalem.linux-foundation.org>
References: <alpine.LFD.1.10.0807261249430.4188@nehalem.linux-foundation.org> <Pine.LNX.4.64.0807270049290.6791@localhost.localdomain> <alpine.LFD.1.10.0807271144520.3486@nehalem.linux-foundation.org> <Pine.LNX.4.64.0807272101470.6791@localhost.localdomain>
 <alpine.LFD.1.10.0807271613440.3486@nehalem.linux-foundation.org> <Pine.LNX.4.64.0807280141140.6791@localhost.localdomain> <alpine.LFD.1.10.0807272148030.3486@nehalem.linux-foundation.org> <Pine.LNX.4.64.0807281241180.6791@localhost.localdomain>
 <20080729053108.GH26997@sigill.intra.peff.net> <Pine.LNX.4.64.0807291339580.6791@localhost.localdomain> <20080729125247.GC12069@sigill.intra.peff.net> <Pine.LNX.4.64.0807300430590.6791@localhost.localdomain>
 <alpine.LFD.1.10.0807292002520.3334@nehalem.linux-foundation.org>
Mime-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Cc: Jeff King <peff@peff.net>, Tim Harper <timcharper@gmail.com>,
	git@vger.kernel.org
To: Roman Zippel <zippel@linux-m68k.org>
X-From: git-owner@vger.kernel.org Wed Jul 30 05:40:33 2008
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1KO2YC-0005AD-Qc
	for gcvg-git-2@gmane.org; Wed, 30 Jul 2008 05:40:33 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1752679AbYG3DjO (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Tue, 29 Jul 2008 23:39:14 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1752644AbYG3DjO
	(ORCPT <rfc822;git-outgoing>); Tue, 29 Jul 2008 23:39:14 -0400
Received: from smtp1.linux-foundation.org ([140.211.169.13]:59406 "EHLO
	smtp1.linux-foundation.org" rhost-flags-OK-OK-OK-OK)
	by vger.kernel.org with ESMTP id S1752007AbYG3DjO (ORCPT
	<rfc822;git@vger.kernel.org>); Tue, 29 Jul 2008 23:39:14 -0400
Received: from imap1.linux-foundation.org (imap1.linux-foundation.org [140.211.169.55])
	by smtp1.linux-foundation.org (8.14.2/8.13.5/Debian-3ubuntu1.1) with ESMTP id m6U3crnm018401
	(version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-SHA bits=256 verify=NO);
	Tue, 29 Jul 2008 20:38:54 -0700
Received: from localhost (localhost [127.0.0.1])
	by imap1.linux-foundation.org (8.13.5.20060308/8.13.5/Debian-3ubuntu1.1) with ESMTP id m6U3cr1E005159;
	Tue, 29 Jul 2008 20:38:53 -0700
In-Reply-To: <alpine.LFD.1.10.0807292002520.3334@nehalem.linux-foundation.org>
User-Agent: Alpine 1.10 (LFD 962 2008-03-14)
X-Spam-Status: No, hits=-3.405 required=5 tests=AWL,BAYES_00
X-Spam-Checker-Version: SpamAssassin 3.2.4-osdl_revision__1.47__
X-MIMEDefang-Filter: lf$Revision: 1.188 $
X-Scanned-By: MIMEDefang 2.63 on 140.211.169.13
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/90731>



On Tue, 29 Jul 2008, Linus Torvalds wrote:
> 
> In other words, that change - in a VERY REAL WAY - never actually mattered 
> for the current state of kernel/printk.c. And the history simplification 
> sees that, and avoids showing the whole pointless branch.

Btw, Roman, this is a really really important thing for you to realize. 

You need to realize that your "perfect" output really REALLY is totally 
inferior, if what you are actually interested in is "how did things get to 
be the way they are".

It's a _feature_. It's not a bug. And it's a really good one.

If side branches didn't matter for the contents of the file, those side 
branches simply don't matter, and showing them is just a distraction.

Yes, you can ask for the history that doesn't matter for the end result. 
And yes, I acknowledge freely that it would be good to then have a 
separate cleanup phase to make that thing more readable. In fact, in the 
very first reply to you I pointed you to a thread where I said exactly 
that, long before this thread even started.

But no, the current default isn't broken. No, it's not "lazy" either. No, 
it was not an "accident". And no, it's not "incorrect".

And until you can see that (along with all the reasons I've outlined why 
your "fixed" approach is a total piece of sh*t from a performance angle), 
you're just being stupid.

				Linus
