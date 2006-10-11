From: Pazu <pazu@pazu.com.br>
Subject: Re: core-git and porcelains
Date: Wed, 11 Oct 2006 14:13:33 -0300
Message-ID: <egj8ot$eq6$1@sea.gmane.org>
References: <egivn8$5mf$1@sea.gmane.org> <20061011150842.GA31298@spearce.org> <egj73t$80e$1@sea.gmane.org> <20061011165403.GC31298@spearce.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Content-Transfer-Encoding: 7bit
X-From: git-owner@vger.kernel.org Wed Oct 11 19:17:23 2006
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by ciao.gmane.org with esmtp (Exim 4.43)
	id 1GXhh4-00076U-Ss
	for gcvg-git@gmane.org; Wed, 11 Oct 2006 19:16:35 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1161135AbWJKRQH (ORCPT <rfc822;gcvg-git@m.gmane.org>);
	Wed, 11 Oct 2006 13:16:07 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1161157AbWJKRQH
	(ORCPT <rfc822;git-outgoing>); Wed, 11 Oct 2006 13:16:07 -0400
Received: from main.gmane.org ([80.91.229.2]:52142 "EHLO ciao.gmane.org")
	by vger.kernel.org with ESMTP id S1161135AbWJKRQD (ORCPT
	<rfc822;git@vger.kernel.org>); Wed, 11 Oct 2006 13:16:03 -0400
Received: from list by ciao.gmane.org with local (Exim 4.43)
	id 1GXhf6-0006Ob-KB
	for git@vger.kernel.org; Wed, 11 Oct 2006 19:14:32 +0200
Received: from 201.37.98.50 ([201.37.98.50])
        by main.gmane.org with esmtp (Gmexim 0.1 (Debian))
        id 1AlnuQ-0007hv-00
        for <git@vger.kernel.org>; Wed, 11 Oct 2006 19:14:32 +0200
Received: from pazu by 201.37.98.50 with local (Gmexim 0.1 (Debian))
        id 1AlnuQ-0007hv-00
        for <git@vger.kernel.org>; Wed, 11 Oct 2006 19:14:32 +0200
X-Injected-Via-Gmane: http://gmane.org/
To: git@vger.kernel.org
X-Complaints-To: usenet@sea.gmane.org
X-Gmane-NNTP-Posting-Host: 201.37.98.50
User-Agent: Thunderbird 1.5.0.7 (Macintosh/20060909)
In-Reply-To: <20061011165403.GC31298@spearce.org>
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/28727>

Shawn Pearce wrote:

> I don't use multiple upstream branches in SVN fortunately, but the
> git-svn documentation suggests there is a way to change the Git
> branch name from 'refs/remotes/git-svn' to another name such that
> you can create one Git branch for each remote SVN branch.  Of course
> you need to set that environment variable before invoking git-svn.

I was reading git-svn documentation and just found about multi-init. 
Seems like you're describing, execept that no branch get init'ed as the 
"default" branch, and you always need to specify the the branch name 
before doing a fetch/dcomic/etc. I hope this works for me -- I'll need 
to switch between two or three remote branches quite frequently.

> As for my daily work with git-svn, I run "git svn fetch" to fetch any
> changes that had occurred in SVN along the branch I follow, then if
> any changes did exist I merge them into my Git working branch with
> "git pull . refs/remotes/git-svn".  When I'm ready to send stuff
> back up to SVN I do "git svn dcommit refs/remotes/git-svn..master",
> where master is the name of the Git branch I want to send.

Sounds a lot like what I do today with svk. If git works for me just as 
good as svk, the speed increase alone will make the switch worth.

-- Marcus
