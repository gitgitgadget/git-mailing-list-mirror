From: Johannes Schindelin <Johannes.Schindelin@gmx.de>
Subject: Re: Cherry-picking to remote branches
Date: Fri, 6 Jul 2007 15:26:00 +0100 (BST)
Message-ID: <Pine.LNX.4.64.0707061524180.4093@racer.site>
References: <a2e879e50707060709oc9fe8b3k8e594f1cb6e10437@mail.gmail.com>
Mime-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Cc: git@vger.kernel.org
To: Sean Kelley <svk.sweng@gmail.com>
X-From: git-owner@vger.kernel.org Fri Jul 06 16:33:24 2007
connect(): Connection refused
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1I6os6-0001Ad-7W
	for gcvg-git@gmane.org; Fri, 06 Jul 2007 16:33:22 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1753845AbXGFOdK (ORCPT <rfc822;gcvg-git@m.gmane.org>);
	Fri, 6 Jul 2007 10:33:10 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1753481AbXGFOdK
	(ORCPT <rfc822;git-outgoing>); Fri, 6 Jul 2007 10:33:10 -0400
Received: from mail.gmx.net ([213.165.64.20]:35234 "HELO mail.gmx.net"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with SMTP
	id S1752464AbXGFOdJ (ORCPT <rfc822;git@vger.kernel.org>);
	Fri, 6 Jul 2007 10:33:09 -0400
Received: (qmail invoked by alias); 06 Jul 2007 14:33:06 -0000
Received: from unknown (EHLO [138.251.11.74]) [138.251.11.74]
  by mail.gmx.net (mp049) with SMTP; 06 Jul 2007 16:33:06 +0200
X-Authenticated: #1490710
X-Provags-ID: V01U2FsdGVkX19t1yExaYxtZ0M4UPTcy7gy7dZyLackqFcX3vgzar
	zQygBSs7lM4ulG
X-X-Sender: gene099@racer.site
In-Reply-To: <a2e879e50707060709oc9fe8b3k8e594f1cb6e10437@mail.gmail.com>
X-Y-GMX-Trusted: 0
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/51752>

Hi,

On Fri, 6 Jul 2007, Sean Kelley wrote:

> [...]
>
> git checkout -b stable linux-stable/master
> 
> git cherry-pick  b3b1eea69a   (a commit from linux-devel)
> 
> git push linux-stable
> 
> error: remote 'refs/heads/master' is not a strict subset of local ref
> 'refs/heads/master'. maybe you are not up-to-date and need to pull
> first?
> error: failed to push to 'git://mysite.com/data/git/linux-stable.git'

Since you are obviously only interested in pushing the stable branch, why 
don't you

	git push linux-stable stable

Hm?

If you do not specify which branches to push, "git push" will find all 
refnames which are present both locally and remotely, and push those. 
Evidently, however, your local "master" disagrees with the remote 
"master".

Hth,
Dscho
