From: Linus Torvalds <torvalds@osdl.org>
Subject: Re: Figured out how to get Mozilla into git
Date: Fri, 9 Jun 2006 13:40:49 -0700 (PDT)
Message-ID: <Pine.LNX.4.64.0606091331170.5498@g5.osdl.org>
References: <9e4733910606081917l11354e49q25f0c4aea40618ea@mail.gmail.com> 
 <46a038f90606082006t5c6a5623q4b9cf7b036dad1e5@mail.gmail.com> 
 <9e4733910606091113vdc6ab06l2d3582cb82b8fd09@mail.gmail.com> 
 <Pine.LNX.4.64.0606091158460.5498@g5.osdl.org>
 <9e4733910606091317p26d66579mdf93db293f93fb50@mail.gmail.com>
Mime-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Cc: Martin Langhoff <martin.langhoff@gmail.com>,
	git <git@vger.kernel.org>
X-From: git-owner@vger.kernel.org Fri Jun 09 22:40:58 2006
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by ciao.gmane.org with esmtp (Exim 4.43)
	id 1Fonms-0005Dw-3J
	for gcvg-git@gmane.org; Fri, 09 Jun 2006 22:40:58 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S965155AbWFIUky (ORCPT <rfc822;gcvg-git@m.gmane.org>);
	Fri, 9 Jun 2006 16:40:54 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S965163AbWFIUky
	(ORCPT <rfc822;git-outgoing>); Fri, 9 Jun 2006 16:40:54 -0400
Received: from smtp.osdl.org ([65.172.181.4]:31410 "EHLO smtp.osdl.org")
	by vger.kernel.org with ESMTP id S965155AbWFIUky (ORCPT
	<rfc822;git@vger.kernel.org>); Fri, 9 Jun 2006 16:40:54 -0400
Received: from shell0.pdx.osdl.net (fw.osdl.org [65.172.181.6])
	by smtp.osdl.org (8.12.8/8.12.8) with ESMTP id k59Keogt029817
	(version=TLSv1/SSLv3 cipher=EDH-RSA-DES-CBC3-SHA bits=168 verify=NO);
	Fri, 9 Jun 2006 13:40:51 -0700
Received: from localhost (shell0.pdx.osdl.net [10.9.0.31])
	by shell0.pdx.osdl.net (8.13.1/8.11.6) with ESMTP id k59KenjK029071;
	Fri, 9 Jun 2006 13:40:49 -0700
To: Jon Smirl <jonsmirl@gmail.com>
In-Reply-To: <9e4733910606091317p26d66579mdf93db293f93fb50@mail.gmail.com>
X-Spam-Status: No, hits=0 required=5 tests=
X-Spam-Checker-Version: SpamAssassin 2.63-osdl_revision__1.75__
X-MIMEDefang-Filter: osdl$Revision: 1.135 $
X-Scanned-By: MIMEDefang 2.36
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/21552>



On Fri, 9 Jun 2006, Jon Smirl wrote:
>
> > Git is much better at packing than either CVS or SVN. Get used to it ;)
> 
> The git tree that Martin got from cvsps is much smaller that the git
> tree I got from going to svn then to git.  I don't why the trees are
> 700KB different, it may be different amounts of packing, or one of the
> conversion tools is losing something.

.. or one of them is adding something.

For example, it may well be that cvs2svn does a lot more commits or 
something like that.

That said, I don't even see where git-svn packs anythign at all, and 
you're absolutely right that when/how you repack can make a huge 
difference to disk usage, much more so than any importer details.

> > Do you have all the cvsps patches? There's a few important ones floating
> > around, and David Mansfield never did a 2.2 release..
> 
> I am running cvsps-2.1-3.fc5 so I may be wasting my time. Error out is
> 535MB now.
> He sent me some git patches, but none for cvsps.

I've got a couple, but I was hoping David would do a cvsps-2.2. I have 
this dim memory of him saying he had done some other improvements too.

> I haven't come up with anything that is likely to result in Mozilla
> switching over to git. Right now it takes three days to convert the
> tree. The tree will have to be run in parallel for a while to convince
> everyone to switch. I don't have a solution to keeping it in sync in
> near real time (commits would still go to CVS). Most Mozilla
> developers are interested but the infrastructure needs some help.

Sure. That said, I pretty much guarantee that the size issues will be much 
much worse for any other distributed SCM. 

If Mozilla doesn't need the distributed thing, then SVN is probably the 
best choice. It's still a total piece of crap, but hey, if crap (== 
centralized) is what people are used to, a few billion flies can't be 
wrong ;)

If you got your import done, is there some place I can rsync it from, and 
at least I can make sure that everything works fine for a repo that size.. 
One day the Mozilla people will notice that they really _really_ want the 
distribution, and they'll figure out quickly enough that SVK doesn't cut 
it, I suspect.

		Linus
