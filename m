From: Jason Riedy <ejr@EECS.Berkeley.EDU>
Subject: Re: Git 1.3.2 on Solaris
Date: Tue, 23 May 2006 11:03:34 -0700
Message-ID: <19270.1148407414@lotus.CS.Berkeley.EDU>
References: <Pine.LNX.4.64.0605230744350.5623@g5.osdl.org>
Cc: Git Mailing List <git@vger.kernel.org>
X-From: git-owner@vger.kernel.org Tue May 23 20:03:49 2006
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by ciao.gmane.org with esmtp (Exim 4.43)
	id 1FibEQ-0007RR-5O
	for gcvg-git@gmane.org; Tue, 23 May 2006 20:03:46 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751147AbWEWSDn (ORCPT <rfc822;gcvg-git@m.gmane.org>);
	Tue, 23 May 2006 14:03:43 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751150AbWEWSDn
	(ORCPT <rfc822;git-outgoing>); Tue, 23 May 2006 14:03:43 -0400
Received: from lotus.CS.Berkeley.EDU ([128.32.36.222]:62390 "EHLO
	lotus.CS.Berkeley.EDU") by vger.kernel.org with ESMTP
	id S1751147AbWEWSDm (ORCPT <rfc822;git@vger.kernel.org>);
	Tue, 23 May 2006 14:03:42 -0400
Received: from lotus.CS.Berkeley.EDU (localhost [127.0.0.1])
	by lotus.CS.Berkeley.EDU (8.12.8/8.12.8/3.141592645) with ESMTP id k4NI3ZgH019272;
	Tue, 23 May 2006 11:03:35 -0700 (PDT)
Received: from lotus.CS.Berkeley.EDU (ejr@localhost)
	by lotus.CS.Berkeley.EDU (8.12.8/8.12.8/Submit) with ESMTP id k4NI3YfQ019271;
	Tue, 23 May 2006 11:03:35 -0700 (PDT)
To: Linus Torvalds <torvalds@osdl.org>
In-reply-to: <Pine.LNX.4.64.0605230744350.5623@g5.osdl.org> 
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/20615>

And Linus Torvalds writes:
 - 
 - What kind of CRAP has Solaris become?

Become?  heh.  Check mount's output; it's "mountpoint
on device".  Always has been.  I think there might be
a reason why certain other OSes have eaten their lunch,
and it ain't the price.

 - It wasn't about what was "allowed by the standards", 
 - that was the HP-SUX and AIX's excuses.

No, AIX's excuse is that it's "dictated by these three
standards over here and disallowed by those two, so
clearly we have to support both behaviors depending
on some footnote in our 1e9 page manual."  wheee...

 - Have Sun people forgotten the difference between "quality" and "crap that 
 - passes standards tests"? 

As far as I've been told, Sun's more interested in
near-perfect backwards compatibility than external
standards tests.  It worked for Intel, right? ;)

 - Btw, even SuS says:
[...]
 -      New implementations are discouraged from returning X_OK unless at 
 -      least one execution permission bit is set."

Now there is one possible, cross-OS problem that I
haven't tested.  You can chmod a-x and then use
setfacl to grant one person execute access.  I'm not
sure if access works in that case, but that might
possibly just say that current ACL systems are crap.

Hmm.  Does access handle SELinux or the other systems?
That might be interesting for a public git server, but
I don't know enough about it.

 - Somebody hit some Solaris engineers with a 2x4 clue-stick, please.

I think you're targetting the wrong department...
Their hands are tied.

Jason, wondering if you could resist the SUS bait...
