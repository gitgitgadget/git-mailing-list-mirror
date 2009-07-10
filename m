From: Graeme Geldenhuys <graemeg@gmail.com>
Subject: Re: Pushing to GitHub doesn't push all branches
Date: Fri, 10 Jul 2009 17:07:43 +0200
Message-ID: <h37lh2$q3s$1@ger.gmane.org>
References: <h37fga$5ie$1@ger.gmane.org> <4A575416.2090304@drmicha.warpmail.net>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
To: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Fri Jul 10 17:08:41 2009
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1MPHiK-0006Bp-0B
	for gcvg-git-2@gmane.org; Fri, 10 Jul 2009 17:08:40 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1753017AbZGJPIe (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Fri, 10 Jul 2009 11:08:34 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1752214AbZGJPId
	(ORCPT <rfc822;git-outgoing>); Fri, 10 Jul 2009 11:08:33 -0400
Received: from main.gmane.org ([80.91.229.2]:55685 "EHLO ciao.gmane.org"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1751449AbZGJPIc (ORCPT <rfc822;git@vger.kernel.org>);
	Fri, 10 Jul 2009 11:08:32 -0400
Received: from list by ciao.gmane.org with local (Exim 4.43)
	id 1MPHiA-0003xz-36
	for git@vger.kernel.org; Fri, 10 Jul 2009 15:08:30 +0000
Received: from 41.177.20.228 ([41.177.20.228])
        by main.gmane.org with esmtp (Gmexim 0.1 (Debian))
        id 1AlnuQ-0007hv-00
        for <git@vger.kernel.org>; Fri, 10 Jul 2009 15:08:30 +0000
Received: from graemeg by 41.177.20.228 with local (Gmexim 0.1 (Debian))
        id 1AlnuQ-0007hv-00
        for <git@vger.kernel.org>; Fri, 10 Jul 2009 15:08:30 +0000
X-Injected-Via-Gmane: http://gmane.org/
X-Complaints-To: usenet@ger.gmane.org
X-Gmane-NNTP-Posting-Host: 41.177.20.228
User-Agent: Thunderbird 2.0.0.22 (X11/20090608)
In-Reply-To: <4A575416.2090304@drmicha.warpmail.net>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/123056>

Michael J Gruber wrote:
> 
> You really mirrored your repo: All your "lost" branches are remotes on
> the github side as well. That has two consequences:

The two branches that are of most importance to me, is "trunk" and 
"fixes_2_2" as found in the SubVersion repository.

refs/remotes/trunk
refs/remotes/fixes_2_2


So should I have only pushed the above mentioned branches, but as "true" 
heads in GitHub. Geesh, I hope I am understanding what I am typing, 
because I feel a bit lost now. :-)

Is there any way to clean up the mess available on GitGub? So that 'git 
ls-remote ...' will only show the real remotes.... Or should there be no 
remotes on GitHub?

Sorry, I'm fairly new to Git and it feels like I jumped into the deap 
end here. ;-)

> (assuming there are only svn branches) into proper heads on github, i.e.
> a refspec like '+refs/remotes/*:refs/*' for your pushes.

I'll read the man pages on what that refspec means...  If I manage to 
only push 'trunk' which is master under git and 'fixes_2_2' which will 
be some other name under git, how to I keep both those in sync with the 
SubVersion repository.

At the moment I have a cronjob that executes the following every 30 minutes.
====================
cd /mnt/samba/git/fpc.git/
$GIT checkout master
$GIT svn rebase
$GIT gc --auto
$GIT push origin master
====================

Does 'git svn rebase' get all branch or does it just update "master" 
(Trunk from SubVersion)?

I apologise for all the questions...

Regards,
   - Graeme -

-- 
fpGUI Toolkit - a cross-platform GUI toolkit using Free Pascal
http://opensoft.homeip.net/fpgui/
