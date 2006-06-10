From: Linus Torvalds <torvalds@osdl.org>
Subject: Re: Figured out how to get Mozilla into git
Date: Fri, 9 Jun 2006 18:33:00 -0700 (PDT)
Message-ID: <Pine.LNX.4.64.0606091825080.5498@g5.osdl.org>
References: <9e4733910606081917l11354e49q25f0c4aea40618ea@mail.gmail.com> 
 <46a038f90606082006t5c6a5623q4b9cf7b036dad1e5@mail.gmail.com>
 <46a038f90606091814n1922bf25l94d913238b260296@mail.gmail.com>
Mime-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Cc: Jon Smirl <jonsmirl@gmail.com>, git <git@vger.kernel.org>
X-From: git-owner@vger.kernel.org Sat Jun 10 03:33:10 2006
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by ciao.gmane.org with esmtp (Exim 4.43)
	id 1FosLd-0007YJ-P1
	for gcvg-git@gmane.org; Sat, 10 Jun 2006 03:33:10 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932257AbWFJBdG (ORCPT <rfc822;gcvg-git@m.gmane.org>);
	Fri, 9 Jun 2006 21:33:06 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S932295AbWFJBdG
	(ORCPT <rfc822;git-outgoing>); Fri, 9 Jun 2006 21:33:06 -0400
Received: from smtp.osdl.org ([65.172.181.4]:42884 "EHLO smtp.osdl.org")
	by vger.kernel.org with ESMTP id S932257AbWFJBdF (ORCPT
	<rfc822;git@vger.kernel.org>); Fri, 9 Jun 2006 21:33:05 -0400
Received: from shell0.pdx.osdl.net (fw.osdl.org [65.172.181.6])
	by smtp.osdl.org (8.12.8/8.12.8) with ESMTP id k5A1X2gt012347
	(version=TLSv1/SSLv3 cipher=EDH-RSA-DES-CBC3-SHA bits=168 verify=NO);
	Fri, 9 Jun 2006 18:33:02 -0700
Received: from localhost (shell0.pdx.osdl.net [10.9.0.31])
	by shell0.pdx.osdl.net (8.13.1/8.11.6) with ESMTP id k5A1X0aE005659;
	Fri, 9 Jun 2006 18:33:01 -0700
To: Martin Langhoff <martin.langhoff@gmail.com>
In-Reply-To: <46a038f90606091814n1922bf25l94d913238b260296@mail.gmail.com>
X-Spam-Status: No, hits=0 required=5 tests=
X-Spam-Checker-Version: SpamAssassin 2.63-osdl_revision__1.75__
X-MIMEDefang-Filter: osdl$Revision: 1.135 $
X-Scanned-By: MIMEDefang 2.36
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/21579>



On Sat, 10 Jun 2006, Martin Langhoff wrote:
> 
> Now I don't know how much memory or time this took, but it clearly
> completed ok. And, it's now a single pack, weighting a grand total of
> 617MB

Ok, that's more than reasonable. That should be fairly easily mapped on a 
32-bit architecture without any huge problems, even with some VM 
fragmentation going on. It might be borderline (and you definitely want a 
3:1 VM user:kernel split), but considering that the original CVS archive 
was apparently 3GB, having a single 617M pack-file is still pretty damn 
good.  That's like 20% of the original, with all the obvious distribution 
advantages.

Clearly this whole thing _does_ show that we could improve the process of 
importing things from CVS a whole lot, and I assume your 617MB pack 
doesn't have the nice name/email translations so it needs to be fixed up, 
but it sounds like on the whole the core git design came through with 
shining colors, even if we may want to polish things up a bit ;)

I'm downloading the thing right now.

			Linus
