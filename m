From: Linus Torvalds <torvalds@osdl.org>
Subject: Re: Figured out how to get Mozilla into git
Date: Fri, 9 Jun 2006 16:43:17 -0700 (PDT)
Message-ID: <Pine.LNX.4.64.0606091640200.5498@g5.osdl.org>
References: <9e4733910606081917l11354e49q25f0c4aea40618ea@mail.gmail.com> 
 <46a038f90606082006t5c6a5623q4b9cf7b036dad1e5@mail.gmail.com> 
 <9e4733910606091113vdc6ab06l2d3582cb82b8fd09@mail.gmail.com> 
 <Pine.LNX.4.64.0606091158460.5498@g5.osdl.org> 
 <9e4733910606091317p26d66579mdf93db293f93fb50@mail.gmail.com> 
 <Pine.LNX.4.64.0606091331170.5498@g5.osdl.org> 
 <9e4733910606091356w391b4fdao23db5b2ce3c3e282@mail.gmail.com> 
 <Pine.LNX.4.64.0606091450180.5498@g5.osdl.org>
 <46a038f90606091637o6a0194d5yb413237253a372fc@mail.gmail.com>
Mime-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Cc: Jon Smirl <jonsmirl@gmail.com>, git <git@vger.kernel.org>
X-From: git-owner@vger.kernel.org Sat Jun 10 01:43:26 2006
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by ciao.gmane.org with esmtp (Exim 4.43)
	id 1FoqdR-0001wT-VL
	for gcvg-git@gmane.org; Sat, 10 Jun 2006 01:43:26 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932589AbWFIXnX (ORCPT <rfc822;gcvg-git@m.gmane.org>);
	Fri, 9 Jun 2006 19:43:23 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S932591AbWFIXnX
	(ORCPT <rfc822;git-outgoing>); Fri, 9 Jun 2006 19:43:23 -0400
Received: from smtp.osdl.org ([65.172.181.4]:31199 "EHLO smtp.osdl.org")
	by vger.kernel.org with ESMTP id S932589AbWFIXnW (ORCPT
	<rfc822;git@vger.kernel.org>); Fri, 9 Jun 2006 19:43:22 -0400
Received: from shell0.pdx.osdl.net (fw.osdl.org [65.172.181.6])
	by smtp.osdl.org (8.12.8/8.12.8) with ESMTP id k59NhIgt007314
	(version=TLSv1/SSLv3 cipher=EDH-RSA-DES-CBC3-SHA bits=168 verify=NO);
	Fri, 9 Jun 2006 16:43:18 -0700
Received: from localhost (shell0.pdx.osdl.net [10.9.0.31])
	by shell0.pdx.osdl.net (8.13.1/8.11.6) with ESMTP id k59NhHSo002510;
	Fri, 9 Jun 2006 16:43:18 -0700
To: Martin Langhoff <martin.langhoff@gmail.com>
In-Reply-To: <46a038f90606091637o6a0194d5yb413237253a372fc@mail.gmail.com>
X-Spam-Status: No, hits=0 required=5 tests=
X-Spam-Checker-Version: SpamAssassin 2.63-osdl_revision__1.75__
X-MIMEDefang-Filter: osdl$Revision: 1.135 $
X-Scanned-By: MIMEDefang 2.36
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/21569>



On Sat, 10 Jun 2006, Martin Langhoff wrote:
> 
> Exactly. The dog at this time is cvsps -- I also remember vague
> promises from a list regular of publishing a git repo with cvsps2.1 +
> some patches from the list.

Ahh. cvsps doesn't do anything incrementally, does it?

Although it _does_ build up a cache of sorts, I think. That's not the 
parts I actually ever ended up looking at.

But yeah, a cvsps that blows up to a gig of VM and takes half an hour to 
parse things just for an incremental update would be a problem.

> In any case, and for the record, my cvsps is 2.1 pristine. It handles
> the mozilla repo alright, as long as I give it a lot of RAM. I _think_
> it slurped 3GB with the mozilla cvs.

Oh, wow. Every single repo I've seen ends up having tons of complaints 
from pristine cvsps, but maybe that's because I only end up looking at the 
ones with problems ;)

> I'm coming down to the office now to pick up my laptop, and I'll rsync
> it out to our git machine (also NZ kernel mirror, bandwidth should be
> good). That's one of the things I've discovered with these large
> trees: for the initial publish action, I just use rsync or scp.
> Perhaps I'm doing it wrong, but git-push doesn't optimise the
> 'initialise repo', and it take ages (and it this case, it'd probably
> OOM).
> 
> > So it will take me quite some time to download 2GB+, regardless of how fat
> > a pipe the other end has ;)
> 
> Right-o. Linus, Jon, can you guys then ping me when you have cloned it
> safely so I can take it down again?

Tell me where/when it is, and I'll start slurping. Will let you know when 
I'm done.

		Linus
