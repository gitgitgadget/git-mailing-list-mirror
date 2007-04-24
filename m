From: Linus Torvalds <torvalds@linux-foundation.org>
Subject: Re: GIT vs Other: Need argument
Date: Tue, 24 Apr 2007 08:01:50 -0700 (PDT)
Message-ID: <alpine.LFD.0.98.0704240752030.9964@woody.linux-foundation.org>
References: <alpine.LFD.0.98.0704180851060.2828@woody.linux-foundation.org>
 <Pine.LNX.4.64.0704191118050.8822@racer.site>
 <alpine.LFD.0.98.0704190940330.9964@woody.linux-foundation.org>
 <4627ABBB.8060709@softax.com.pl> <alpine.LFD.0.98.0704191341370.9964@woody.linux-foundation.org>
 <877is29b1l.wl%cworth@cworth.org> <7vps5ud91x.fsf@assigned-by-dhcp.cox.net>
 <87vefm7l6g.wl%cworth@cworth.org> <alpine.LFD.0.98.0704231609440.9964@woody.linux-foundation.org>
 <7v1wiabbfr.fsf@assigned-by-dhcp.cox.net>
 <20070424142309.GD18538@fieldses.org>
Mime-Version: 1.0
Content-Type: TEXT/PLAIN; charset=us-ascii
Cc: Junio C Hamano <junkio@cox.net>, Carl Worth <cworth@cworth.org>,
	Marcin Kasperski <Marcin.Kasperski@softax.com.pl>,
	git@vger.kernel.org
To: "J. Bruce Fields" <bfields@fieldses.org>
X-From: git-owner@vger.kernel.org Tue Apr 24 17:02:57 2007
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1HgMXZ-0006IM-O7
	for gcvg-git@gmane.org; Tue, 24 Apr 2007 17:02:50 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1752929AbXDXPCm (ORCPT <rfc822;gcvg-git@m.gmane.org>);
	Tue, 24 Apr 2007 11:02:42 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1752904AbXDXPCm
	(ORCPT <rfc822;git-outgoing>); Tue, 24 Apr 2007 11:02:42 -0400
Received: from smtp1.linux-foundation.org ([65.172.181.25]:52542 "EHLO
	smtp1.linux-foundation.org" rhost-flags-OK-OK-OK-OK)
	by vger.kernel.org with ESMTP id S1752897AbXDXPCl (ORCPT
	<rfc822;git@vger.kernel.org>); Tue, 24 Apr 2007 11:02:41 -0400
Received: from shell0.pdx.osdl.net (fw.osdl.org [65.172.181.6])
	by smtp1.linux-foundation.org (8.13.5.20060308/8.13.5/Debian-3ubuntu1.1) with ESMTP id l3OF1pix025838
	(version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-SHA bits=256 verify=NO);
	Tue, 24 Apr 2007 08:01:52 -0700
Received: from localhost (shell0.pdx.osdl.net [10.9.0.31])
	by shell0.pdx.osdl.net (8.13.1/8.11.6) with ESMTP id l3OF1orC010760;
	Tue, 24 Apr 2007 08:01:51 -0700
In-Reply-To: <20070424142309.GD18538@fieldses.org>
X-Spam-Status: No, hits=-3.036 required=5 tests=AWL,BAYES_00
X-Spam-Checker-Version: SpamAssassin 3.1.0-osdl_revision__1.12__
X-MIMEDefang-Filter: osdl$Revision: 1.177 $
X-Scanned-By: MIMEDefang 2.53 on 65.172.181.25
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/45458>



On Tue, 24 Apr 2007, J. Bruce Fields wrote:
> 
> Note that we almost have the tutorials for the "two very simple cases"
> that Linus identifies:
> 
> 	- case #1, the "anonymous CVS" replacement: chapter 2 of
> 	  user-manual.txt (the first chapter after the quick start) covers
> 	  this.  Perhaps in greater generality than necessary, and maybe
> 	  detached heads and/or --track should be mentioned earlier.
> 
> 	- tutorial.txt, the "how to start tracking your own project"
> 	  case, starts with git-init, git-add, etc.
> 
> One problem is that it's not immediately obvious which one to look at
> for each case.

Well, I think they really should be documents of their own, so that you 
can read about the "CVS tracking" or so without even worrying about the 
fact that you didn't read the whole thing.

And they should be easy to find. I agree that we do actually have a fair 
amount of docs, but it seems that people don't tend to *find* them. The 
user-manual, for example, is great, but I've seen people on the #git logs 
apparently not realize it exists ;)

For example, the git homepage has a "documentation" thing, which only 
lists the tutorial, not the user manual explicitly. You _can_ get to the 
user manual (go to the online version of the Documentation directory and 
note the "still work in progress"), but even if you do actually find 
yourself there, the user manual itself is actually a bit scary to start 
with.

So I think we could just make the initial impression a bit easier. The 
tutorial comes fairly close to the "tracking your own" thing, I agree, 
but maybe we could have the documentation listed in order of complexity, 
and having a way for people to know *which* doc they should start with 
when they are at http://git.or.cz/ (or the wikipedia page), so that if 
you're only interested in the "tracking somebody else", you could easily 
find and read just a single simple documentation thing. Hmm?

			Linus
