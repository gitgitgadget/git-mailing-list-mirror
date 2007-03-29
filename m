From: Guennadi Liakhovetski <g.liakhovetski@gmx.de>
Subject: basics... when reading docs doesn't help
Date: Thu, 29 Mar 2007 22:50:51 +0200 (CEST)
Message-ID: <Pine.LNX.4.60.0703292225100.10351@poirot.grange>
Mime-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
To: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Thu Mar 29 22:50:59 2007
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1HX1aC-0007FT-OG
	for gcvg-git@gmane.org; Thu, 29 Mar 2007 22:50:57 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1030694AbXC2Uuy (ORCPT <rfc822;gcvg-git@m.gmane.org>);
	Thu, 29 Mar 2007 16:50:54 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1030716AbXC2Uuy
	(ORCPT <rfc822;git-outgoing>); Thu, 29 Mar 2007 16:50:54 -0400
Received: from mail.gmx.net ([213.165.64.20]:35192 "HELO mail.gmx.net"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with SMTP
	id S1030694AbXC2Uux (ORCPT <rfc822;git@vger.kernel.org>);
	Thu, 29 Mar 2007 16:50:53 -0400
Received: (qmail invoked by alias); 29 Mar 2007 20:50:51 -0000
Received: from dynamic-unidsl-85-197-31-110.westend.de (EHLO poirot.grange) [85.197.31.110]
  by mail.gmx.net (mp020) with SMTP; 29 Mar 2007 22:50:51 +0200
X-Authenticated: #20450766
X-Provags-ID: V01U2FsdGVkX1+AQ2EjxhKAe8vCsuZhiWVlo9+VkvhdLr1r3GGOjh
	adIKflOVyhdRH0
Received: from lyakh (helo=localhost)
	by poirot.grange with local-esmtp (Exim 3.36 #1 (Debian))
	id 1HX1a7-0003Fe-00
	for <git@vger.kernel.org>; Thu, 29 Mar 2007 22:50:51 +0200
X-Y-GMX-Trusted: 0
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/43470>

Hi all

Since it's a basic question, I couldn't search archives - cannot come up 
with good enough search keywords, but would be greatful for pointers.

I've been using CVS for a few years now, briefly tried a couple of other 
CMS, but only briefly. Now trying to get to grisps with the git... And 
just cannot understand how everybody does it.

The package I'm trying to handle with git is the Linux kernel.

1. Ok, I clone a repository from Linus or some else.

2. as my internet connection is not very fast, although I do have 
flatrate, I prefer keeping a virgin cloned copy somewhere, where I only do 
pulls from the original clone source, no edits.

3. then I do git clone <path to original cloned tree> <new tree>

4. create a new branch in <new tree>

5. go hack / compile in the <new tree>

6. then I decide to build practically the same kernel for another machine, 
i.e., another configuration, maybe a couple of local changes...

Now, that's the first question: suppose I want to build kernels for about 
4 machines. Do you __really__ clone the whole tree 4 times??? And then I 
want try new versions for the same 4 machines without deleting the first 
ones - 4 more clones??? Now, my copy of Linus' tree was ATM 1.5GiB big... 
Slowly it's getting scary. Ok, if I build all that stuff on one 
filesystem, I can use --local to use hard links, right? But is it REALLY 
what everybody does?

The next thing is - I don't need all versions since 2.6.x in every copy I 
use to compile / test / hack - in most cases I only compare to the basis 
version, from which I branched. I might pull further updates into this 
repository, merge, etc., but I don't need all PAST commits! Can I clone 
starting from version x?

Ok, enough for starters:-)

Thanks
Guennadi
---
Guennadi Liakhovetski
