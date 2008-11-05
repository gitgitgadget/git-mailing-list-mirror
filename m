From: Francis Galiegue <fg@one2team.net>
Subject: Need help for migration from CVS to git in one go (ie, FORGETTING CVS history)
Date: Thu, 6 Nov 2008 00:14:56 +0100
Organization: One2team
Message-ID: <200811060014.57046.fg@one2team.net>
Mime-Version: 1.0
Content-Type: text/plain;
  charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Thu Nov 06 00:18:06 2008
connect(): Connection refused
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1KxrdU-0006hj-Su
	for gcvg-git-2@gmane.org; Thu, 06 Nov 2008 00:18:05 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1752475AbYKEXQt (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Wed, 5 Nov 2008 18:16:49 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1752427AbYKEXQt
	(ORCPT <rfc822;git-outgoing>); Wed, 5 Nov 2008 18:16:49 -0500
Received: from ns35774.ovh.net ([213.251.185.197]:60761 "EHLO ns35774.ovh.net"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1752135AbYKEXQs (ORCPT <rfc822;git@vger.kernel.org>);
	Wed, 5 Nov 2008 18:16:48 -0500
Received: from erwin.kitchen.eel (AOrleans-157-1-121-89.w90-20.abo.wanadoo.fr [90.20.196.89])
	(Authenticated sender: fg@one2team.net)
	by ns35774.ovh.net (Postfix) with ESMTP id 5F48092C011
	for <git@vger.kernel.org>; Thu,  6 Nov 2008 00:16:34 +0100 (CET)
User-Agent: KMail/1.9.9
Content-Disposition: inline
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/100199>

Hello list,

Since my first email where I said that we wanted to migrate from CVS to a 
distributed SCM, we have had a lot of discussions with developers and my 
chief (which happens to be a developer too). We have come to the following 
conclusions:

* git has credentials (heck, it "runs" the Linux kernel, Wine, Samba, and 
other);
* the "distributed" part of it is indeed an advantage (planned developments 
with huge technical/functional impacts);
* 52 CVS modules, fine; but then this can become one and 52 subdirectories in 
them and still act as separate modules from the build system point of view 
(which I have implemented, so I can change it);
* we have enough resources that the old CVS tree can be kept, even on tape, 
the day we decide to "scrap it all" and start anew;
* CVS "good practices" have barely been observed, so "we" might as well start 
again from a sane base.

So, git looks like a great solution. The Eclipse plugin evolves nicely, you 
still can decide on a "central" repository... Looks good.

There are, however, a few problems:
* first: I am not an Eclipse user, and the two main developers use Eclipse 
extensively (but even they are lost because of CVS, which is to "my" 
advantage), so some questions below will focus on the Eclipse plugin;
* second: even though this may be a "non problem", we use Bonsai, which has 
the ability to see what was commited by whom, given a time interval (from d1 
to d2): the base gitweb allows to search by commiter, which is good, but it 
has no date boundaries: do tools exist for git that can do this? If not, that 
wouldn't be a big deal, however...
* third: also Bonsai-related; Bonsai can link to Bugzilla by matching (wild 
guess) /\b(?:#?)(\d+)\b/ and transforming this into 
http://your.bugzilla.fqdn.here/show_bug.cgi?id=$1. Does gitweb have this 
built-in? (haven't looked yet) Is this planned, or has it been discussed and 
been considered not worth the hassle?

Finally, about the Eclipse plugin:
* the README says that it has no push capacity, the popup menu says otherwise 
(last checked last Saturday)... What should I believe?
* if the plugin can push, can you configure from within the plugin what 
branches can be pushed where, or should you edit .git/config by hand?
* "git stash": is it supported?
* can you "copy" a commit, or even a set of commits, and "cherry-pick" them 
into another branch? Or even rebase a branch onto antoher?

Thanks,
-- 
fge
