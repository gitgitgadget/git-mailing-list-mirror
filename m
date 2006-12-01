X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.176.0/21
X-Spam-Status: No, score=-3.5 required=3.0 tests=AWL,BAYES_00,
	HEADER_FROM_DIFFERENT_DOMAINS,MSGID_FROM_MTA_HEADER,RP_MATCHES_RCVD
	shortcircuit=no autolearn=ham autolearn_force=no version=3.4.0
From: Linus Torvalds <torvalds@osdl.org>
Subject: Re: [PATCH 0/2] Making "git commit" to mean "git commit -a".
Date: Thu, 30 Nov 2006 17:32:22 -0800 (PST)
Message-ID: <Pine.LNX.4.64.0611301720240.3513@woody.osdl.org>
References: <7virgzuf38.fsf@assigned-by-dhcp.cox.net> <87ejrlvn7r.wl%cworth@cworth.org>
 <7vodqpn3t4.fsf@assigned-by-dhcp.cox.net> <7vk61dn2yj.fsf@assigned-by-dhcp.cox.net>
 <Pine.LNX.4.63.0611300310520.30004@wbgn013.biozentrum.uni-wuerzburg.de>
 <Pine.LNX.4.64.0611291859070.3513@woody.osdl.org> <456EBBE7.8030404@op5.se>
 <Pine.LNX.4.64.0611300749560.3513@woody.osdl.org> <20061130164046.GB17715@thunk.org>
 <Pine.LNX.4.64.0611300903080.3513@woody.osdl.org> <Pine.LNX.4.64.0611301229290.9647@xanadu.home>
 <87irgwu6e6.wl%cworth@cworth.org> <87hcwgu5t1.wl%cworth@cworth.org>
 <Pine.LNX.4.64.0611301132350.3513@woody.osdl.org> <Pine.LNX.4.64.0611301521320.9647@xanadu.home>
 <7vhcwgiqer.fsf@assigned-by-dhcp.cox.net> <Pine.LNX.4.64.0611301624430.9647@xanadu.home>
 <7vlklsfsgz.fsf@assigned-by-dhcp.cox.net> <Pine.LNX.4.64.0611301520370.3513@woody.osdl.org>
 <873b80tqvv.wl%cworth@cworth.org> <Pine.LNX.4.64.0611301618490.3513@woody.osdl.org>
 <871wnkh142.wl%cworth@cworth.org>
Mime-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
NNTP-Posting-Date: Fri, 1 Dec 2006 01:33:48 +0000 (UTC)
Cc: Junio C Hamano <junkio@cox.net>, Nicolas Pitre <nico@cam.org>,
	Theodore Tso <tytso@mit.edu>, Andreas Ericsson <ae@op5.se>,
	Johannes Schindelin <Johannes.Schindelin@gmx.de>,
	git@vger.kernel.org
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git@gmane.org
In-Reply-To: <871wnkh142.wl%cworth@cworth.org>
X-MIMEDefang-Filter: osdl$Revision: 1.161 $
X-Scanned-By: MIMEDefang 2.36
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/32843>
Received: from vger.kernel.org ([209.132.176.167]) by ciao.gmane.org with
 esmtp (Exim 4.43) id 1GpxH3-0003kc-LQ for gcvg-git@gmane.org; Fri, 01 Dec
 2006 02:33:10 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand id
 S1031723AbWLABdG (ORCPT <rfc822;gcvg-git@m.gmane.org>); Thu, 30 Nov 2006
 20:33:06 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1031725AbWLABdG
 (ORCPT <rfc822;git-outgoing>); Thu, 30 Nov 2006 20:33:06 -0500
Received: from smtp.osdl.org ([65.172.181.25]:7885 "EHLO smtp.osdl.org") by
 vger.kernel.org with ESMTP id S1031723AbWLABdD (ORCPT
 <rfc822;git@vger.kernel.org>); Thu, 30 Nov 2006 20:33:03 -0500
Received: from shell0.pdx.osdl.net (fw.osdl.org [65.172.181.6]) by
 smtp.osdl.org (8.12.8/8.12.8) with ESMTP id kB11WOjQ025343
 (version=TLSv1/SSLv3 cipher=EDH-RSA-DES-CBC3-SHA bits=168 verify=NO); Thu, 30
 Nov 2006 17:32:24 -0800
Received: from localhost (shell0.pdx.osdl.net [10.9.0.31]) by
 shell0.pdx.osdl.net (8.13.1/8.11.6) with ESMTP id kB11WM6E027939; Thu, 30 Nov
 2006 17:32:23 -0800
To: Carl Worth <cworth@cworth.org>
Sender: git-owner@vger.kernel.org



On Thu, 30 Nov 2006, Carl Worth wrote:
> 
> The difference there is very subtle and really does prevent a
> reasonable, "just ignore the index and you can use git comfortably".

If you want to ignore the index, you'd always use "git commit -a".

So what's your point?

> But it is strange, and I cannot see how the first case is at all useful.

The old argument by incredulity. The fact that you cannot see it doesnt' 
change the fact that I use it all the time. Usually not for the same file, 
but committing something that is different in the index and in the working 
tree is my normal behaviour - it's how any number of things work (like 
merging while you have dirty state, or applying patches while you have 
changes).

So, let me condense the argument:

 - your argument is that cannot understand how anybody would ever want to 
   use this.

That's really what it all boils down to. That's your ONLY argument. You 
didn't actually answer any of me explaining _why_ it's how it works, and 
why it _has_ to be why it works. Your argument just boils down to "I can't 
believe it's useful to be consistent".

My argument is:

 - the current behaviour is actually very powerful, and I've given 
   examples of when I actually do use it (and whether you know it or not, 
   they are also things you've probably done - the "pull from somebody 
   else with dirty files" is actually exactly the same thing, you just 
   never realized it just because it happened to be the same thing on two 
   different files)

 - the "git add file ; change file ; git commit" behaviour is absolutely 
   REQUIRED once you get the whole "git tracks content" logic. Doing 
   anything but committing the old version (the one you added) would be 
   illogical and wrong, because it's strictly against the whole POINT of 
   tracking content.

So. That's what it boils down to. Your personal incredulity against 
fundamental concepts and real usage.

The reason I like UNIX is that it has "fundamental concepts". And 
surprise, surprise, a lot of the same issues are at play in "git" too. 
Pretty much _all_ the behaviour (apart from actual _naming_ issues) really 
come from fundamental concepts, and _not_ doing special cases.

I guarantee you, in the end you're better off building a world-view on a 
coherent guiding logic, than on "personal incredulity" or "I can't believe 
that anybody would actually ever want to do that".

As an X developer, don't you get tired of hearing people saying "I can't 
believe anybody would ever want to use a network transparent protocol and 
do graphics from another machine"? The non-X people (and every single 
"let's replace X with something more efficient" discussion) always tend to 
take that approach. 

Same thing. It really doesn't matter what you think is "normal". What 
matters a lot more in the end is that you keep a coherent set of concepts, 
so that once you really learn the concepts, it all makes sense.

And in git, the over-arching concept for just about _anything_ is "git 
tracks contents, and filenames don't matter". The behaviour of "git add" 
and "git commit" is just a small detail in that whole picture.

