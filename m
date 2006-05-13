From: Elrond <elrond+kernel.org@samba-tng.org>
Subject: Re: Tracking branch history
Date: Sat, 13 May 2006 12:53:14 +0000 (UTC)
Message-ID: <loom.20060513T140528-554@post.gmane.org>
References: <Pine.LNX.4.64.0605121838490.6713@iabervon.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
X-From: git-owner@vger.kernel.org Sat May 13 15:00:44 2006
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by ciao.gmane.org with esmtp (Exim 4.43)
	id 1FetjX-0004pI-JK
	for gcvg-git@gmane.org; Sat, 13 May 2006 15:00:36 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932427AbWEMNAG (ORCPT <rfc822;gcvg-git@m.gmane.org>);
	Sat, 13 May 2006 09:00:06 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S932424AbWEMNAF
	(ORCPT <rfc822;git-outgoing>); Sat, 13 May 2006 09:00:05 -0400
Received: from main.gmane.org ([80.91.229.2]:54216 "EHLO ciao.gmane.org")
	by vger.kernel.org with ESMTP id S932427AbWEMNAD (ORCPT
	<rfc822;git@vger.kernel.org>); Sat, 13 May 2006 09:00:03 -0400
Received: from root by ciao.gmane.org with local (Exim 4.43)
	id 1Fetj0-0004jl-J7
	for git@vger.kernel.org; Sat, 13 May 2006 15:00:02 +0200
Received: from p54A70DA9.dip0.t-ipconnect.de ([84.167.13.169])
        by main.gmane.org with esmtp (Gmexim 0.1 (Debian))
        id 1AlnuQ-0007hv-00
        for <git@vger.kernel.org>; Sat, 13 May 2006 15:00:02 +0200
Received: from elrond+kernel.org by p54A70DA9.dip0.t-ipconnect.de with local (Gmexim 0.1 (Debian))
        id 1AlnuQ-0007hv-00
        for <git@vger.kernel.org>; Sat, 13 May 2006 15:00:02 +0200
X-Injected-Via-Gmane: http://gmane.org/
To: git@vger.kernel.org
X-Complaints-To: usenet@sea.gmane.org
X-Gmane-NNTP-Posting-Host: main.gmane.org
User-Agent: Loom/3.14 (http://gmane.org/)
X-Loom-IP: 84.167.13.169 (Mozilla/5.0 (X11; U; Linux i686; en-US; rv:1.8.0.3) Gecko/20060326 Firefox/1.5.0.3 (Debian-1.5.dfsg+1.5.0.3-2))
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/19935>

Daniel Barkalow <barkalow <at> iabervon.org> writes:

> 
> One feature that might make git more intuitive to people is if we were to 
> additionally track the history of what commit was the head of each branch 
> over time. This is only vaguely related to the history of the content, but 
> it's well-defined and sometimes significant.
> 
> E.g., if you know that two weeks ago, what you had worked, but it doesn't 
> work now, you can use git-bisect to figure out what happened, but first 
> you have to figure out what commit it was that you were using two weeks 
> ago. Two weeks ago, we had that information, but we didn't keep it.

On a related issue:

Looking at a commit:
   commit id-commit
   parent id-1
   parent id-2
   parent id-3

       Merge branch 'branch-2', 'branch-3'

One can tell the name of the branches for id-2 and id-3 (branch-2, 3),
but one can't tell the name of id-1.

At the time, those branches were not yet merged, this information was
available easily, even remotely via git-clone.
