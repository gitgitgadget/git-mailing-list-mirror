From: Christoph Bartoschek <bartoschek@gmx.de>
Subject: Re: [PATCH] Proof-of-concept patch to remember what the detached HEAD was
Date: Sat, 17 Oct 2009 00:36:37 +0200
Organization: =?UTF-8?B?VW5pdmVyc2l0w6R0?= Bonn
Message-ID: <m49nq6-uk5.ln1@burns.bruehl.pontohonk.de>
References: <alpine.LNX.2.00.0910140037570.32515@iabervon.org>
Mime-Version: 1.0
Content-Type: text/plain; charset="ISO-8859-1"
Content-Transfer-Encoding: 7Bit
To: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Sat Oct 17 09:00:32 2009
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1Mz3HE-0006v5-8t
	for gcvg-git-2@lo.gmane.org; Sat, 17 Oct 2009 09:00:32 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751760AbZJQHAT (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Sat, 17 Oct 2009 03:00:19 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751615AbZJQHAT
	(ORCPT <rfc822;git-outgoing>); Sat, 17 Oct 2009 03:00:19 -0400
Received: from lo.gmane.org ([80.91.229.12]:53749 "EHLO lo.gmane.org"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1751577AbZJQHAS (ORCPT <rfc822;git@vger.kernel.org>);
	Sat, 17 Oct 2009 03:00:18 -0400
Received: from list by lo.gmane.org with local (Exim 4.50)
	id 1Mz3H4-0006rW-K0
	for git@vger.kernel.org; Sat, 17 Oct 2009 09:00:22 +0200
Received: from p54baf8f1.dip.t-dialin.net ([84.186.248.241])
        by main.gmane.org with esmtp (Gmexim 0.1 (Debian))
        id 1AlnuQ-0007hv-00
        for <git@vger.kernel.org>; Sat, 17 Oct 2009 09:00:22 +0200
Received: from bartoschek by p54baf8f1.dip.t-dialin.net with local (Gmexim 0.1 (Debian))
        id 1AlnuQ-0007hv-00
        for <git@vger.kernel.org>; Sat, 17 Oct 2009 09:00:22 +0200
X-Injected-Via-Gmane: http://gmane.org/
Followup-To: gmane.comp.version-control.git
X-Complaints-To: usenet@ger.gmane.org
X-Gmane-NNTP-Posting-Host: p54baf8f1.dip.t-dialin.net
User-Agent: KNode/4.3.2
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/130545>

Daniel Barkalow wrote:

> The upshot of the messages should be:
> 
>  $ git checkout origin/master
>  Since you can't actually change "origin/master" yourself, you'll just
>  be sightseeing unless you create a local branch to hold new local work.
> 
>  $ git branch
>  * (not a local branch, but "origin/master")
> 
>  $ git commit
>  You've been sightseeing "origin/master". The commit can't change that
>  value, so your commit isn't held in any branch. If you want to create
>  a branch to hold it, here's how.


I appreciate such a message for git branch as a user. Today I had the 
following problem:

I wanted to compile Qt Creator 1.3 from their repository. I cloned it with 
git clone and then issued git checkout origin/1.3.0-beta. First there came a 
the warning and I was not sure whether the checkout succeeded at all. I had 
to ask in the IRC channel whether the checkout was ok.

But then I was not able to verify that the checkout indeed matched the 
1.3.0-beta.  "git status" and "git branch" did not help here. 

Having an improved "git branch" would help a lot, especially if one returns 
some weeks later to the directory and wants to know what the checkout is.

Christoph
