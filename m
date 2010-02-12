From: Ron Garret <ron1@flownet.com>
Subject: Re: Individual file snapshots
Date: Fri, 12 Feb 2010 13:57:08 -0800
Organization: Amalgamated Widgets
Message-ID: <ron1-62D136.13570812022010@news.gmane.org>
References: <ron1-CD3223.04030512022010@news.gmane.org> <4B75BD06.1010802@lsrfire.ath.cx> <ron1-519083.13253112022010@news.gmane.org> <12B5BDAB-DD9C-4CED-9489-0773BF577DF3@silverinsanity.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
To: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Fri Feb 12 22:57:49 2010
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1Ng3WF-00057V-4v
	for gcvg-git-2@lo.gmane.org; Fri, 12 Feb 2010 22:57:47 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1757546Ab0BLV5Z (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Fri, 12 Feb 2010 16:57:25 -0500
Received: from lo.gmane.org ([80.91.229.12]:52828 "EHLO lo.gmane.org"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1757494Ab0BLV5V (ORCPT <rfc822;git@vger.kernel.org>);
	Fri, 12 Feb 2010 16:57:21 -0500
Received: from list by lo.gmane.org with local (Exim 4.69)
	(envelope-from <gcvg-git-2@m.gmane.org>)
	id 1Ng3Vo-0004lu-AO
	for git@vger.kernel.org; Fri, 12 Feb 2010 22:57:20 +0100
Received: from 68-190-211-184.dhcp.gldl.ca.charter.com ([68.190.211.184])
        by main.gmane.org with esmtp (Gmexim 0.1 (Debian))
        id 1AlnuQ-0007hv-00
        for <git@vger.kernel.org>; Fri, 12 Feb 2010 22:57:20 +0100
Received: from ron1 by 68-190-211-184.dhcp.gldl.ca.charter.com with local (Gmexim 0.1 (Debian))
        id 1AlnuQ-0007hv-00
        for <git@vger.kernel.org>; Fri, 12 Feb 2010 22:57:20 +0100
X-Injected-Via-Gmane: http://gmane.org/
X-Complaints-To: usenet@ger.gmane.org
X-Gmane-NNTP-Posting-Host: 68-190-211-184.dhcp.gldl.ca.charter.com
User-Agent: MT-NewsWatcher/3.5.1 (Intel Mac OS X)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/139753>

In article <12B5BDAB-DD9C-4CED-9489-0773BF577DF3@silverinsanity.com>,
 Brian Gernhardt <benji@silverinsanity.com> wrote:

> On Feb 12, 2010, at 4:25 PM, Ron Garret wrote:
> 
> > Yeah, I considered that.  The problem with that is that the actual 
> > process turns out to be pretty obtrusive.  The scenario is that I've 
> > done a bunch of hacking on the main branch and I realize that it's going 
> > nowhere.  Nothing is working, everything is a horrible mess that's 
> > spinning wildly out of control.  I want to get rid of everything I've 
> > done and start over from an earlier snapshot that I knew was working.  
> > But I also want to keep a copy of this current messy state around for 
> > reference just in case there's a snippet here and there that might be 
> > salvageable later on.  I don't know of any easy way to save the messed 
> > up file onto another branch.  I'd have to save the file somewhere (in 
> > the stash maybe?), check out the snapshot branch, retrieve the saved 
> > file, do the commit, and then switch back to the main branch.
> 
> Have you tried creating a new branch without saving the state?
> 
> git checkout -b failed-experiment
> git commit -a -m "Back to the drawing board"
> git checkout master
> 
> Or if a series of commits seem to have gone bad:
> 
> git commit -a -m "Well, that didn't work."
> git branch failed-experiment
> git reset --hard origin/master # or other good state
> 
> You can of course replace the -a to commit with the needed "git add <file>" 
> commands and leave off the -m to leave real messages about why it went bad 
> using $EDITOR.

That would require a separate branch for every snapshot, no?  I want 
this to be lightweight.  It's not so much the creation of a zillion 
branches that bothers me, but having to come up with a new name every 
time would be a real hassle.

rg
