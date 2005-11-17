From: Linus Torvalds <torvalds@osdl.org>
Subject: Re: [QUESTION] Access to a huge GIT repository.
Date: Thu, 17 Nov 2005 14:44:09 -0800 (PST)
Message-ID: <Pine.LNX.4.64.0511171443000.13959@g5.osdl.org>
References: <cda58cb80511160424j1acac7c6j@mail.gmail.com> 
 <Pine.LNX.4.64.0511160837000.13959@g5.osdl.org>  <cda58cb80511170236p4a7e2baay@mail.gmail.com>
  <Pine.LNX.4.64.0511170817480.13959@g5.osdl.org> <cda58cb80511171347yef4f090g@mail.gmail.com>
Mime-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Cc: Git Mailing List <git@vger.kernel.org>
X-From: git-owner@vger.kernel.org Thu Nov 17 23:47:08 2005
Return-path: <git-owner@vger.kernel.org>
Received: from vger.kernel.org ([209.132.176.167])
	by ciao.gmane.org with esmtp (Exim 4.43)
	id 1EcsUK-0004Bw-OM
	for gcvg-git@gmane.org; Thu, 17 Nov 2005 23:44:17 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S964938AbVKQWoN (ORCPT <rfc822;gcvg-git@m.gmane.org>);
	Thu, 17 Nov 2005 17:44:13 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S964944AbVKQWoN
	(ORCPT <rfc822;git-outgoing>); Thu, 17 Nov 2005 17:44:13 -0500
Received: from smtp.osdl.org ([65.172.181.4]:37326 "EHLO smtp.osdl.org")
	by vger.kernel.org with ESMTP id S964938AbVKQWoN (ORCPT
	<rfc822;git@vger.kernel.org>); Thu, 17 Nov 2005 17:44:13 -0500
Received: from shell0.pdx.osdl.net (fw.osdl.org [65.172.181.6])
	by smtp.osdl.org (8.12.8/8.12.8) with ESMTP id jAHMiAnO007655
	(version=TLSv1/SSLv3 cipher=EDH-RSA-DES-CBC3-SHA bits=168 verify=NO);
	Thu, 17 Nov 2005 14:44:10 -0800
Received: from localhost (shell0.pdx.osdl.net [10.9.0.31])
	by shell0.pdx.osdl.net (8.13.1/8.11.6) with ESMTP id jAHMi9B9014608;
	Thu, 17 Nov 2005 14:44:10 -0800
To: Franck <vagabon.xyz@gmail.com>
In-Reply-To: <cda58cb80511171347yef4f090g@mail.gmail.com>
X-Spam-Status: No, hits=0 required=5 tests=
X-Spam-Checker-Version: SpamAssassin 2.63-osdl_revision__1.55__
X-MIMEDefang-Filter: osdl$Revision: 1.127 $
X-Scanned-By: MIMEDefang 2.36
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/12164>



On Thu, 17 Nov 2005, Franck wrote:

> 2005/11/17, Linus Torvalds <torvalds@osdl.org>:
> >
> > What you probably _can_ do is to find whatever top-most commit you want
> > (say, the v2.6.0 commit), and use grafting to make that have no parents.
> > Then you can do git-prune to get rid of everything under it.
> >
> 
> ok that's what I was trying to do by killing the parent object.  Now
> when looking a the graph using gitk all old objects have been removed.
> But I'm suprised because the git repository is the same size as it was
> before pruning all old objects. Can you explain why ?

make sure you re-pack if it was packed. "git prune" will not remove packs 
at all, so..

		Linus
