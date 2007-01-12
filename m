From: Jakub Narebski <jnareb@gmail.com>
Subject: Re: [PATCH] git-status: wording update to deal with deleted files.
Date: Fri, 12 Jan 2007 20:48:34 +0100
Organization: At home
Message-ID: <eo8ols$ja$2@sea.gmane.org>
References: <87bql5cok3.fsf@morpheus.local> <7vejq12nlu.fsf@assigned-by-dhcp.cox.net> <7vsleh16ey.fsf_-_@assigned-by-dhcp.cox.net> <87ac0pxgl2.wl%cworth@cworth.org> <7v1wm114rx.fsf@assigned-by-dhcp.cox.net> <878xg9xcca.wl%cworth@cworth.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 7Bit
X-From: git-owner@vger.kernel.org Fri Jan 12 20:48:44 2007
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1H5SO6-0003dR-CV
	for gcvg-git@gmane.org; Fri, 12 Jan 2007 20:48:30 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1030180AbXALTs1 (ORCPT <rfc822;gcvg-git@m.gmane.org>);
	Fri, 12 Jan 2007 14:48:27 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1030183AbXALTs1
	(ORCPT <rfc822;git-outgoing>); Fri, 12 Jan 2007 14:48:27 -0500
Received: from main.gmane.org ([80.91.229.2]:52336 "EHLO ciao.gmane.org"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1030180AbXALTs0 (ORCPT <rfc822;git@vger.kernel.org>);
	Fri, 12 Jan 2007 14:48:26 -0500
Received: from list by ciao.gmane.org with local (Exim 4.43)
	id 1H5SNy-0007P4-Jf
	for git@vger.kernel.org; Fri, 12 Jan 2007 20:48:23 +0100
Received: from host-81-190-18-73.torun.mm.pl ([81.190.18.73])
        by main.gmane.org with esmtp (Gmexim 0.1 (Debian))
        id 1AlnuQ-0007hv-00
        for <git@vger.kernel.org>; Fri, 12 Jan 2007 20:48:22 +0100
Received: from jnareb by host-81-190-18-73.torun.mm.pl with local (Gmexim 0.1 (Debian))
        id 1AlnuQ-0007hv-00
        for <git@vger.kernel.org>; Fri, 12 Jan 2007 20:48:22 +0100
X-Injected-Via-Gmane: http://gmane.org/
To: git@vger.kernel.org
X-Complaints-To: usenet@sea.gmane.org
X-Gmane-NNTP-Posting-Host: host-81-190-18-73.torun.mm.pl
Mail-Copies-To: jnareb@gmail.com
User-Agent: KNode/0.10.2
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/36698>

Carl Worth wrote:

> commit after stage
> ------------------
> git stage: stage content for new, modified, or removed files
> 
> commit -a
> ---------
> git add: mark new files to be committed
> 
> Compare that to the above description. Isn't it beautiful from a
> conceptual point-of-view? The "git rm" command isn't needed at all,
> (though we could certainly still provide it). And now the "git add"
> command only has one conceptual use, for (of all thing!) adding new
> files, not updating content for files that have been modified.

Without "git rm" (or "git update-index --force-remove") you cannot
make file to be untracked by git, i.e. remove it from the files
tracked by git but not remove it from directory.

With current version of git-rm (modulo bugs), if you do "git rm <file>"
the file would be removed from index, and if recoverable from working
directory. Without git-rm you would have to use plumbing to remove it from
index but preserve changes.
-- 
Jakub Narebski
Warsaw, Poland
ShadeHawk on #git
