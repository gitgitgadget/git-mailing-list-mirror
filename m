From: Daniel Barkalow <barkalow@iabervon.org>
Subject: Re: .gitlink for Summer of Code
Date: Tue, 27 Mar 2007 14:09:38 -0400 (EDT)
Message-ID: <Pine.LNX.4.64.0703271338210.6485@iabervon.org>
References: <1174825838.12540.5.camel@localhost> <20070326220302.GH22773@admingilde.org>
 <7vfy7rvct2.fsf@assigned-by-dhcp.cox.net> <200703270117.59205.Josef.Weidendorfer@gmx.de>
 <Pine.LNX.4.64.0703270952020.6730@woody.linux-foundation.org>
Mime-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Cc: Josef Weidendorfer <Josef.Weidendorfer@gmx.de>,
	Junio C Hamano <junkio@cox.net>,
	Martin Waitz <tali@admingilde.org>,
	Eric Lesh <eclesh@ucla.edu>,
	Matthieu Moy <Matthieu.Moy@imag.fr>, git@vger.kernel.org
To: Linus Torvalds <torvalds@linux-foundation.org>
X-From: git-owner@vger.kernel.org Tue Mar 27 20:10:21 2007
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1HWG7e-00027l-Jt
	for gcvg-git@gmane.org; Tue, 27 Mar 2007 20:10:18 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S934142AbXC0SJl (ORCPT <rfc822;gcvg-git@m.gmane.org>);
	Tue, 27 Mar 2007 14:09:41 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S934124AbXC0SJk
	(ORCPT <rfc822;git-outgoing>); Tue, 27 Mar 2007 14:09:40 -0400
Received: from iabervon.org ([66.92.72.58]:2751 "EHLO iabervon.org"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S934142AbXC0SJj (ORCPT <rfc822;git@vger.kernel.org>);
	Tue, 27 Mar 2007 14:09:39 -0400
Received: (qmail 1997 invoked by uid 1000); 27 Mar 2007 14:09:38 -0400
Received: from localhost (sendmail-bs@127.0.0.1)
  by localhost with SMTP; 27 Mar 2007 14:09:38 -0400
In-Reply-To: <Pine.LNX.4.64.0703270952020.6730@woody.linux-foundation.org>
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/43291>

On Tue, 27 Mar 2007, Linus Torvalds wrote:

> Think of it this way: if you think people find it a bit annoying that you 
> currently have to get all the history when you do clone (and why people 
> have worked on "shallow clones" in git), imagine just *how* frustrating it 
> is if you have to get all five-hundred subprojects when you only want to 
> work on one small one!

Is it fair to say that subproject support means that there's a use case 
where everybody will need shallow clones? And that it points out natural 
triggers for shallowness?

I don't see that the "shallow clone" mechanism is special for subprojects 
(and I don't think that a solution that depends on subprojects being what 
causes it is a good idea), but clearly it makes sense to support: (1) no 
clone of submodules, (2) shallow clone of submodules, and (3) full clone 
of submodules.

Somebody working on gcc for *BSD would presumably want to get all of gcc 
and a shallow clone of the other 1000 submodules, right? Or they'd just 
clone the submodule and ignore the superproject. At least, they'd need 
shallow clones of a bunch of the submodules, because it's not interesting 
to have the superproject otherwise.

	-Daniel
*This .sig left intentionally blank*
