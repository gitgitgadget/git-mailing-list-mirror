From: Linus Torvalds <torvalds@osdl.org>
Subject: Re: Updated Kernel Hacker's guide to git
Date: Thu, 21 Dec 2006 20:13:52 -0800 (PST)
Message-ID: <Pine.LNX.4.64.0612212009370.3536@woody.osdl.org>
References: <38b2ab8a0612210424o4ec5fcd5kb5086c52ccd76491@mail.gmail.com>
 <Pine.LNX.4.64.0612211013500.3394@woody.osdl.org> <87slf83erg.wl%cworth@cworth.org>
Mime-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Cc: Francis Moreau <francis.moro@gmail.com>,
	Jay Cliburn <jacliburn@bellsouth.net>, git@vger.kernel.org,
	Jeff Garzik <jeff@garzik.org>
X-From: git-owner@vger.kernel.org Fri Dec 22 05:14:21 2006
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by dough.gmane.org with esmtp (Exim 4.50)
	id 1GxbnP-0008Qr-Rs
	for gcvg-git@gmane.org; Fri, 22 Dec 2006 05:14:12 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1945925AbWLVEOI (ORCPT <rfc822;gcvg-git@m.gmane.org>);
	Thu, 21 Dec 2006 23:14:08 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1945924AbWLVEOI
	(ORCPT <rfc822;git-outgoing>); Thu, 21 Dec 2006 23:14:08 -0500
Received: from smtp.osdl.org ([65.172.181.25]:41861 "EHLO smtp.osdl.org"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1945926AbWLVEOH (ORCPT <rfc822;git@vger.kernel.org>);
	Thu, 21 Dec 2006 23:14:07 -0500
Received: from shell0.pdx.osdl.net (fw.osdl.org [65.172.181.6])
	by smtp.osdl.org (8.12.8/8.12.8) with ESMTP id kBM4Dr2J001806
	(version=TLSv1/SSLv3 cipher=EDH-RSA-DES-CBC3-SHA bits=168 verify=NO);
	Thu, 21 Dec 2006 20:13:53 -0800
Received: from localhost (shell0.pdx.osdl.net [10.9.0.31])
	by shell0.pdx.osdl.net (8.13.1/8.11.6) with ESMTP id kBM4DqTd013529;
	Thu, 21 Dec 2006 20:13:52 -0800
To: Carl Worth <cworth@cworth.org>
In-Reply-To: <87slf83erg.wl%cworth@cworth.org>
X-Spam-Status: No, hits=-0.653 required=5 tests=AWL
X-Spam-Checker-Version: SpamAssassin 2.63-osdl_revision__1.107__
X-MIMEDefang-Filter: osdl$Revision: 1.164 $
X-Scanned-By: MIMEDefang 2.36
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/35126>



On Thu, 21 Dec 2006, Carl Worth wrote:
>
> On Thu, 21 Dec 2006 10:23:30 -0800 (PST), Linus Torvalds wrote:
> > In short, for git diff (and ONLY) git diff, all of these are the same:
> >
> > 	git diff a..b
> > 	git diff a b
> 
> I admit that I had had never passed a range of commits to git diff,
> nor even given any thought to what it might do, but I definitely find
> the above very surprising---and not necessarily very useful. Why is
> anyone ever typing those two dots here if they have no effect on the
> result?

I do it all the time, I never even use the old-fashioned syntax any more. 
It's much more concise and easy to read, and it has all the nice shortcuts 
(like empty meaning "HEAD", so you can do "git diff ..next" to see the 
diff from HEAD to another branch).

It's also useful exactly because of the semantics of things like "...".

In other words, sure, "git diff a b" works, but it just _looks_ more 
pleasing to use "a..b" and you mentally always pronounce the ".." as "to".

So "git diff a b" doesn't even look good to me any more, because it's 
literally missing that mental "to" that the ".." adds for me when I read 
it.

		Linus
