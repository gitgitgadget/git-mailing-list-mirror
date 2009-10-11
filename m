From: Fabian Molder <fm122@arcor.de>
Subject: Re: git svn with non-standard svn layout
Date: Sun, 11 Oct 2009 19:00:19 +0000 (UTC)
Message-ID: <loom.20091011T205226-197@post.gmane.org>
References: <loom.20091010T001433-536@post.gmane.org> <20091011070937.GC16264@dcvr.yhbt.net>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
To: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Sun Oct 11 21:06:16 2009
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1Mx3jv-0006U7-Kn
	for gcvg-git-2@lo.gmane.org; Sun, 11 Oct 2009 21:05:56 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751452AbZJKTBX (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Sun, 11 Oct 2009 15:01:23 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751442AbZJKTBX
	(ORCPT <rfc822;git-outgoing>); Sun, 11 Oct 2009 15:01:23 -0400
Received: from lo.gmane.org ([80.91.229.12]:34452 "EHLO lo.gmane.org"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1751430AbZJKTBW (ORCPT <rfc822;git@vger.kernel.org>);
	Sun, 11 Oct 2009 15:01:22 -0400
Received: from list by lo.gmane.org with local (Exim 4.50)
	id 1Mx3ev-0004WD-FT
	for git@vger.kernel.org; Sun, 11 Oct 2009 21:00:45 +0200
Received: from p579FC859.dip.t-dialin.net ([87.159.200.89])
        by main.gmane.org with esmtp (Gmexim 0.1 (Debian))
        id 1AlnuQ-0007hv-00
        for <git@vger.kernel.org>; Sun, 11 Oct 2009 21:00:45 +0200
Received: from fm122 by p579FC859.dip.t-dialin.net with local (Gmexim 0.1 (Debian))
        id 1AlnuQ-0007hv-00
        for <git@vger.kernel.org>; Sun, 11 Oct 2009 21:00:45 +0200
X-Injected-Via-Gmane: http://gmane.org/
X-Complaints-To: usenet@ger.gmane.org
X-Gmane-NNTP-Posting-Host: sea.gmane.org
User-Agent: Loom/3.14 (http://gmane.org/)
X-Loom-IP: 87.159.200.89 (Mozilla/5.0 (X11; U; Linux i686; en-US; rv:1.9.1.3) Gecko/20090909 Fedora/3.5.3-1.fc11 Firefox/3.5.3)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/129946>

Eric Wong <normalperson <at> yhbt.net> writes:

...
> 
> Hi Fabian,
> 
> Since you don't want to track the entire repo and these seem like
> unrelated (history-wise) trees, you probably want the simplest cases:
> 
>   git svn clone svn://example.com/path/to/xapplication2
>   git svn clone svn://example.com/path/to/aa/bb/cc/xapplication1
> 
> These commands are like doing the following with plain old svn:
> 
>   svn co svn://example.com/path/to/xapplication2
>   svn co svn://example.com/path/to/aa/bb/cc/xapplication1
> 
> > I tried to use "git config svn-remote.svn.branches" to do this,
> >  please see in function "do_git_svn" in bash-script - but no success
> 
> svn-remote.svn.branches and tags are really only for repos with
> standard layouts.
> 

Hello Eric,
  hmm, understand,
  but this just does an checkout to the working dir

  the reason for using git is:
    - work offline, with (at least read) access to all the svn branches
    - have some more (privat, not commit back to svn) branches for experiments
    - all the nice git stuff ..
regards,
Fabian
