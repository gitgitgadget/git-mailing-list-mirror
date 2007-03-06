From: Sergio Callegari <scallegari@arces.unibo.it>
Subject: Re: Git checkout preserve timestamp?
Date: Tue, 6 Mar 2007 18:39:17 +0000 (UTC)
Message-ID: <loom.20070306T190954-291@post.gmane.org>
References: <17895.18265.710811.536526@lisa.zopyra.com> <Pine.LNX.4.63.0703021618000.22628@wbgn013.biozentrum.uni-wuerzburg.de> <20070302162136.GA9593@diana.vm.bytemark.co.uk> <Pine.LNX.4.63.0703022018190.22628@wbgn013.biozentrum.uni-wuerzburg.de> <20070305072323.GA31169@diana.vm.bytemark.co.uk> <Pine.LNX.4.63.0703051230390.22628@wbgn013.biozentrum.uni-wuerzburg.de> <17900.27067.247950.419438@lisa.zopyra.com> <Pine.LNX.4.63.0703052014020.22628@wbgn013.biozentrum.uni-wuerzburg.de> <17900.30394.172067.743310@lisa.zopyra.com> <Pine.LNX.4.63.0703052143120.22628@wbgn013.biozentrum.uni-wuerzburg.de> <17900.36569.805689.922989@lisa.zopyra.com> <Pine.LNX.4.64.0703051347490.3998@woody.linux-foundation.org> <17900.39124.763603.695942@lisa.zopyra.com> <Pine.LNX.4.64.0703051431130.3998@woody.linux-foundation.org> <17900.42415.750335.329874@lisa.zopyra.com> <Pine.LNX.4.63.0703060026340.13683@wbgn013
 .biozentrum.uni-wuerzburg.de> <17900.43487.947400.649777@lisa.zopyra.com> <Pine.LNX.4.63.0703060042040.22628@wbgn013.biozentrum.uni-wuerzburg.de> <87zm6rqlpn.fsf@graviton.dyn.troilus.org> <7vodn7w6rz.fsf@assigned-by-dhcp.cox.net>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
To: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Tue Mar 06 19:40:24 2007
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1HOeaE-0001Zf-RI
	for gcvg-git@gmane.org; Tue, 06 Mar 2007 19:40:23 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S965993AbXCFSjs (ORCPT <rfc822;gcvg-git@m.gmane.org>);
	Tue, 6 Mar 2007 13:39:48 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S965997AbXCFSjs
	(ORCPT <rfc822;git-outgoing>); Tue, 6 Mar 2007 13:39:48 -0500
Received: from main.gmane.org ([80.91.229.2]:49190 "EHLO ciao.gmane.org"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S965993AbXCFSjr (ORCPT <rfc822;git@vger.kernel.org>);
	Tue, 6 Mar 2007 13:39:47 -0500
Received: from list by ciao.gmane.org with local (Exim 4.43)
	id 1HOeZY-0004xh-Pg
	for git@vger.kernel.org; Tue, 06 Mar 2007 19:39:40 +0100
Received: from st-a-2.ingfo.unibo.it ([137.204.201.23])
        by main.gmane.org with esmtp (Gmexim 0.1 (Debian))
        id 1AlnuQ-0007hv-00
        for <git@vger.kernel.org>; Tue, 06 Mar 2007 19:39:40 +0100
Received: from scallegari by st-a-2.ingfo.unibo.it with local (Gmexim 0.1 (Debian))
        id 1AlnuQ-0007hv-00
        for <git@vger.kernel.org>; Tue, 06 Mar 2007 19:39:40 +0100
X-Injected-Via-Gmane: http://gmane.org/
X-Complaints-To: usenet@sea.gmane.org
X-Gmane-NNTP-Posting-Host: main.gmane.org
User-Agent: Loom/3.14 (http://gmane.org/)
X-Loom-IP: 137.204.201.23 (Mozilla/5.0 (X11; U; Linux i686; en-US; rv:1.8.1.2) Gecko/20060601 Firefox/2.0.0.2 (Ubuntu-edgy))
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/41589>

Junio C Hamano <junkio <at> cox.net> writes:

> 
> Michael Poole <mdpoole <at> troilus.org> writes:
> 
> > This all sounds a lot like git-clone's "alternate" code.
> > ...
> > My own work habits are very similar to Bill Lear's, but my projects'
> > build times are small enough that it's less pain to rebuild half the
> > project than to propagate changes recorded under $GIT_DIR between
> > local branches.  I have not found a git workflow that makes me
> > entirely happy, but I suspect I just don't know the magic words.
> 
> These days I use a few working trees that are connected to my
> primary repository (which also has a working tree).  The primary
> repository is in /src/git, and other ones look like this:
> 
> : gitster git.wk0; ls -l .git/
> total 120
> drwxrwsr-x  3 junio src  4096 Mar  5 16:22 ./
> drwxrwsr-x 15 junio src 16384 Mar  5 16:23 ../
> -rw-rw-r--  1 junio src    41 Mar  5 16:22 HEAD
> lrwxrwxrwx  1 junio src    27 Mar  3 22:53 config -> /src/git/.git/config
> lrwxrwxrwx  1 junio src    26 Mar  3 22:53 hooks -> /src/git/.git/hooks/
> -rw-rw-r--  1 junio src 82455 Mar  5 16:22 index
> lrwxrwxrwx  1 junio src    25 Mar  3 22:53 info -> /src/git/.git/info/
> drwxrwsr-x  3 junio src  4096 Mar  3 22:59 logs/
> lrwxrwxrwx  1 junio src    28 Mar  3 22:53 objects -> /src/git/.git/objects/
> lrwxrwxrwx  1 junio src    32 Mar  3 22:53 packed-refs ->
/src/git/.git/packed-refs
> lrwxrwxrwx  1 junio src    25 Mar  3 22:53 refs -> /src/git/.git/refs/
> lrwxrwxrwx  1 junio src    28 Mar  3 22:53 remotes -> /src/git/.git/remotes/
> lrwxrwxrwx  1 junio src    29 Mar  3 22:53 rr-cache -> /src/git/.git/rr-cache/
> 
> It shares everything other than HEAD and the index (the reflog
> for branches are also shared by a symlink .git/logs/refs
> pointing at the one in the primary repository).
> 
> This risks confusion for an uninitiated if you update a ref that
> is checked out in another working tree, but modulo that caveat
> it works reasonably well.
> 
> We might want to add an option to 'git-clone' to create
> something like this, but I am somewhat worried about the newbie
> confusion factor.  Perhaps...
> 
> $ git clone --i-know-what-i-am-doing-give-me-an-alternate-working-tree \
>   /src/git /src/git.wk0
> 
> 


This looks very much like the .gitlink approach that was previously proposed on
the list, I think...

In that proposal, rather than having many symlinks in the .git repo, you would
have a single .gitlink one...  (plus, obviously a live index and HEAD). 
Possibly, the .gitlink approach could be better, since in case the *real* repo
needs for some reason to be moved, then you just need to update a single link
rather than many of them (this might also be safer... just imagine a scenario
where one updates the links by hand and forgets to update one of them... and
more friendly to OSes disliking symbolic links).

You mention the fact that the only possible confusion here is if a ref that is
checked out in another working tree gets updated... Something like I update
master on WT A, but another WT B has master checked out, so the status of the WT
in B gets old with regard to the new branch tip... I guess that in this case
committing in WT B could be a disaster...

However, if in HEAD we stored not just the branch-ref, but also its commit ID
this case could become very easy to spot... and we could start behaving as if we
were headless... (possibly safer)... or am I completely wrong?

Sergio
