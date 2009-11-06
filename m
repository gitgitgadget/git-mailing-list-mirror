From: Dmitry Smirnov <divis1969@gmail.com>
Subject: Git drawbacks?
Date: Fri, 6 Nov 2009 16:17:30 +0000 (UTC)
Message-ID: <loom.20091106T160709-387@post.gmane.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
To: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Fri Nov 06 17:25:20 2009
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1N6Rcl-00079o-Sd
	for gcvg-git-2@lo.gmane.org; Fri, 06 Nov 2009 17:25:20 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1759424AbZKFQZF (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Fri, 6 Nov 2009 11:25:05 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1758787AbZKFQZF
	(ORCPT <rfc822;git-outgoing>); Fri, 6 Nov 2009 11:25:05 -0500
Received: from lo.gmane.org ([80.91.229.12]:55772 "EHLO lo.gmane.org"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1756217AbZKFQZD (ORCPT <rfc822;git@vger.kernel.org>);
	Fri, 6 Nov 2009 11:25:03 -0500
Received: from list by lo.gmane.org with local (Exim 4.50)
	id 1N6RcW-00072g-3H
	for git@vger.kernel.org; Fri, 06 Nov 2009 17:25:08 +0100
Received: from 212.92.145.7 ([212.92.145.7])
        by main.gmane.org with esmtp (Gmexim 0.1 (Debian))
        id 1AlnuQ-0007hv-00
        for <git@vger.kernel.org>; Fri, 06 Nov 2009 17:25:04 +0100
Received: from divis1969 by 212.92.145.7 with local (Gmexim 0.1 (Debian))
        id 1AlnuQ-0007hv-00
        for <git@vger.kernel.org>; Fri, 06 Nov 2009 17:25:04 +0100
X-Injected-Via-Gmane: http://gmane.org/
X-Complaints-To: usenet@ger.gmane.org
X-Gmane-NNTP-Posting-Host: sea.gmane.org
User-Agent: Loom/3.14 (http://gmane.org/)
X-Loom-IP: 212.92.145.7 (Mozilla/5.0 (Windows; U; Windows NT 5.1; en-US) AppleWebKit/532.0 (KHTML, like Gecko) Chrome/3.0.195.27 Safari/532.0)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/132310>

Hi,

Sorry if I selected the wrong place to discuss the drawbacks of the Git. Just 
point to the proper one...

I'm just trying to select the best VCS for me personally.
I have a very small experience with Git but I see is also not very sutable for 
me.

First, it seems to be very hard to setup some really big project (like Android, 
for example). Otherwise, why do they need to invent 'repo'? What purpose it 
solves? It looks like it
1. Integrates few subcomponents (projects) and checkout the code in the proper 
configuration. The question is why this is not the Git task? For me, it looks 
like the ClearCase client spec.
2.? What others (except integration with review tool)? 

The next issue with git is its clone. Why do I need the whole set of revisions? 
Why do I need to get 1GB of Android? You could say this should happen once. I 
would agree but when I tried to resync the Android tree after 2 months, I was 
struggled with many errors (both git and repo). Finally, I had decided to sync 
again. :-)
There is one point against clone. The typical situation in my office is to have 
few Perforce clients with the same or slightly  different code. This is just 
wasting a space since you need them all but versions of many files are the same. 
I'm trying to imagine the same situation with Git. Are there any benefits? It 
seems, no. Moreover, I will have not only few working trees but few repository 
clones!

It is obvious that configuration management with Git is very difficult (for ex, 
http://groups.google.com/group/repo-
discuss/browse_thread/thread/2fa368ed7cac5d79/64ced51656240ddc?
lnk=gst&q=create+android+bare+repository#64ced51656240ddc)

Let's consider the foolwing use case. Suppose I'm intending to create a new 
product that consists of specific versions (or branches) of some subcomponents 
(or directories). How can I do this with Git? Subsequent changes could either be 
submitted to the appropriate component branch or branched to the new one (this 
way is possible with Git, of course, if I will branch the code I need to this 
new branch).

So, I'm wondering, why Git (or any other VCS) is not trying to solve these 
problems? Perhaps, there is a simple solution with Git I'm not aware of?

Here is the wish list for the VCS I would prefer:
1. Atomit commits
2. The possibility to get any slice of the code repository with the possibility 
to commit my changes on tip or on separate branch.
3. The minimum footprint of the same code on my local machine.
4. No code/history on my machine untill I really need it.
5. Easy mirroring and replication

I would say, ClearCase might be my favorite if it is not commercial. :-)

Dmitry
