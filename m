From: Sergio Callegari <scallegari@arces.unibo.it>
Subject: Re: fsck missing dangling commits that are candidate heads?
Date: Tue, 3 Apr 2007 19:56:53 +0000 (UTC)
Message-ID: <loom.20070403T215123-220@post.gmane.org>
References: <loom.20070403T213135-68@post.gmane.org> <20070403194750.GG27706@spearce.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
To: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Tue Apr 03 21:57:11 2007
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1HYp7u-0000Po-V0
	for gcvg-git@gmane.org; Tue, 03 Apr 2007 21:57:11 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S934031AbXDCT5H (ORCPT <rfc822;gcvg-git@m.gmane.org>);
	Tue, 3 Apr 2007 15:57:07 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S934032AbXDCT5H
	(ORCPT <rfc822;git-outgoing>); Tue, 3 Apr 2007 15:57:07 -0400
Received: from main.gmane.org ([80.91.229.2]:50528 "EHLO ciao.gmane.org"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S934031AbXDCT5G (ORCPT <rfc822;git@vger.kernel.org>);
	Tue, 3 Apr 2007 15:57:06 -0400
Received: from list by ciao.gmane.org with local (Exim 4.43)
	id 1HYp7n-00041q-BW
	for git@vger.kernel.org; Tue, 03 Apr 2007 21:57:03 +0200
Received: from mars-fw.arces.unibo.it ([137.204.143.2])
        by main.gmane.org with esmtp (Gmexim 0.1 (Debian))
        id 1AlnuQ-0007hv-00
        for <git@vger.kernel.org>; Tue, 03 Apr 2007 21:57:03 +0200
Received: from scallegari by mars-fw.arces.unibo.it with local (Gmexim 0.1 (Debian))
        id 1AlnuQ-0007hv-00
        for <git@vger.kernel.org>; Tue, 03 Apr 2007 21:57:03 +0200
X-Injected-Via-Gmane: http://gmane.org/
X-Complaints-To: usenet@sea.gmane.org
X-Gmane-NNTP-Posting-Host: main.gmane.org
User-Agent: Loom/3.14 (http://gmane.org/)
X-Loom-IP: 137.204.143.2 (Mozilla/5.0 (X11; U; Linux i686; en-US; rv:1.8.1.3) Gecko/20060601 Firefox/2.0.0.3 (Ubuntu-edgy))
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/43649>

Shawn O. Pearce <spearce <at> spearce.org> writes:

>
> Right.  This is the reflog in action.  Your current branch has two
> reflogs, .git/logs/HEAD and .git/logs/refs/heads/$foo, where $foo
> is your current branch name.  Both of these logs mention the commit
> you are looking for, so they aren't considered dangling garbage,
> nor are they pruneable.
> 
> Use `git log -g` or `git log -g $foo` to look at the reflog for
> HEAD and $foo to locate the commit in question.
> 

Many thanks! I was quite sure I was missing something...
At least I am in good company since the fsck man page does not mention the 
logs :-)

Then... is there any shorthand for finding candidate branch-heads (i.e. for
having something like fsck without looking at the logs) ?
