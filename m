From: Sergio <sergio.callegari@gmail.com>
Subject: Re: can I use multiple worktree in same git repo ?
Date: Fri, 22 Jul 2011 09:06:44 +0000 (UTC)
Message-ID: <loom.20110722T105732-905@post.gmane.org>
References: <20110720182438.3c40cf1d@shiva.selfip.org> <m3sjpzsdll.fsf@localhost.localdomain> <20110721182215.GA9505@kolya> <201107212050.20108.jnareb@gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
To: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Fri Jul 22 11:07:02 2011
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1QkBhF-0003Kl-Vz
	for gcvg-git-2@lo.gmane.org; Fri, 22 Jul 2011 11:07:02 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1752586Ab1GVJG5 (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Fri, 22 Jul 2011 05:06:57 -0400
Received: from lo.gmane.org ([80.91.229.12]:59162 "EHLO lo.gmane.org"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1751527Ab1GVJG4 (ORCPT <rfc822;git@vger.kernel.org>);
	Fri, 22 Jul 2011 05:06:56 -0400
Received: from list by lo.gmane.org with local (Exim 4.69)
	(envelope-from <gcvg-git-2@m.gmane.org>)
	id 1QkBh8-0003Ia-Kb
	for git@vger.kernel.org; Fri, 22 Jul 2011 11:06:54 +0200
Received: from mars-fw.arces.unibo.it ([137.204.143.2])
        by main.gmane.org with esmtp (Gmexim 0.1 (Debian))
        id 1AlnuQ-0007hv-00
        for <git@vger.kernel.org>; Fri, 22 Jul 2011 11:06:54 +0200
Received: from sergio.callegari by mars-fw.arces.unibo.it with local (Gmexim 0.1 (Debian))
        id 1AlnuQ-0007hv-00
        for <git@vger.kernel.org>; Fri, 22 Jul 2011 11:06:54 +0200
X-Injected-Via-Gmane: http://gmane.org/
X-Complaints-To: usenet@dough.gmane.org
X-Gmane-NNTP-Posting-Host: sea.gmane.org
User-Agent: Loom/3.14 (http://gmane.org/)
X-Loom-IP: 137.204.143.2 (Mozilla/5.0 (X11; Linux x86_64) AppleWebKit/535.1 (KHTML, like Gecko) Chrome/13.0.782.99 Safari/535.1)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/177638>

Jakub Narebski <jnareb <at> gmail.com> writes:

> 
> On Thu, 21 Jul 2011, Fredrik Gustafsson wrote:
> > On Thu, Jul 21, 2011 at 11:17:57AM -0700, Jakub Narebski wrote:
> 
> > > Actually with git-new-workdir you can have multiple working
> > > directories associated with single repository, by the way of symlinks.
> > > 
> > > Note however that if you intend to *work* in those workdirs, they
> > > better correspond to different branches... or you can mess something
> > > heavy.
> > 
> > It would be possible to use the .git-file feature here. Then symlinks are
> > avoided and the solution is portable.
> 
> Actually it wouldn't.  Each new workdir has a separate HEAD and a
> separate index; it is contents of .git that is symlinked, not .git
> itself.
> 

Is there any means to separate worktree info from the object repository? E.g., 
having a .git dir identical to that of a bare repo and a .git_workdir dir with 
the head, head logs, index and all what makes a nonbare repo different from a 
bare one? That might make it easier to transform a repo from bare to nonbare in 
addition to simplifying the logic of git-new-workdir.
