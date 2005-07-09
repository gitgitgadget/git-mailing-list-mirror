From: Marc Singer <elf@buici.com>
Subject: Converting commits to patch files?  HEAD vs HEAD^
Date: Fri, 8 Jul 2005 18:38:59 -0700
Message-ID: <20050709013859.GA11947@buici.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
X-From: git-owner@vger.kernel.org Sat Jul 09 03:39:39 2005
Return-path: <git-owner@vger.kernel.org>
Received: from vger.kernel.org ([12.107.209.244])
	by ciao.gmane.org with esmtp (Exim 4.43)
	id 1Dr4JM-0000So-5p
	for gcvg-git@gmane.org; Sat, 09 Jul 2005 03:39:20 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S263041AbVGIBjF (ORCPT <rfc822;gcvg-git@m.gmane.org>);
	Fri, 8 Jul 2005 21:39:05 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261586AbVGIBjF
	(ORCPT <rfc822;git-outgoing>); Fri, 8 Jul 2005 21:39:05 -0400
Received: from florence.buici.com ([206.124.142.26]:42986 "HELO
	florence.buici.com") by vger.kernel.org with SMTP id S263043AbVGIBjC
	(ORCPT <rfc822;git@vger.kernel.org>); Fri, 8 Jul 2005 21:39:02 -0400
Received: (qmail 12273 invoked by uid 1000); 9 Jul 2005 01:38:59 -0000
To: git@vger.kernel.org
Content-Disposition: inline
User-Agent: Mutt/1.5.6+20040907i
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org

Jeff Garzik's guide doesn't appear to explain how to get patches back
out of the system.  

I've successfully commited a set of changes.

 # git diff HEAD^ HEAD

This command will produce a diff of the changes I've made.  What is
the HEAD^?  Does it refer to the commit before the last one made?

If I've made several commits, I'd like to be able to gather several
together and produce a patch file.  Better still, I'd like to be able
to pick a set of discontiguous commits an bundle them into a single
patch.  Ought I be using tags?

Finally, given that the upstream repository is git, what is the way to
push commits upstream?
