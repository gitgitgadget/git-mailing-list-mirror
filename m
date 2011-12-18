From: DeMarcus <demarcus@hotmail.com>
Subject: How can I do an automatic stash when doing a checkout?
Date: Sun, 18 Dec 2011 12:19:56 +0100
Message-ID: <jcki8u$oip$1@dough.gmane.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Content-Transfer-Encoding: 7bit
To: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Sun Dec 18 12:25:52 2011
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1RcEsD-00070H-Ik
	for gcvg-git-2@lo.gmane.org; Sun, 18 Dec 2011 12:25:45 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751105Ab1LRLZY (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Sun, 18 Dec 2011 06:25:24 -0500
Received: from lo.gmane.org ([80.91.229.12]:45402 "EHLO lo.gmane.org"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1751371Ab1LRLZX (ORCPT <rfc822;git@vger.kernel.org>);
	Sun, 18 Dec 2011 06:25:23 -0500
Received: from list by lo.gmane.org with local (Exim 4.69)
	(envelope-from <gcvg-git-2@m.gmane.org>)
	id 1RcEre-0006RC-CG
	for git@vger.kernel.org; Sun, 18 Dec 2011 12:25:10 +0100
Received: from c83-251-142-66.bredband.comhem.se ([83.251.142.66])
        by main.gmane.org with esmtp (Gmexim 0.1 (Debian))
        id 1AlnuQ-0007hv-00
        for <git@vger.kernel.org>; Sun, 18 Dec 2011 12:25:10 +0100
Received: from demarcus by c83-251-142-66.bredband.comhem.se with local (Gmexim 0.1 (Debian))
        id 1AlnuQ-0007hv-00
        for <git@vger.kernel.org>; Sun, 18 Dec 2011 12:25:10 +0100
X-Injected-Via-Gmane: http://gmane.org/
X-Complaints-To: usenet@dough.gmane.org
X-Gmane-NNTP-Posting-Host: c83-251-142-66.bredband.comhem.se
User-Agent: Mozilla/5.0 (Windows NT 6.0; rv:8.0) Gecko/20111105 Thunderbird/8.0
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/187418>

Hi,

I'm new to git and currently I'm working with SVN and there it's a bit 
messier doing branching but once I've branched then all my development 
there is completely separated from any other branch. When I want to work 
on another branch I just change directory.

This is not how it works with git, where when I want to change branch I 
have to do a git checkout. However, that leaves all the modified and 
untracked files in the directory of the branch I switched to. This is 
seldom the behavior I want.

With the git stash command I can clean the directory the way I want but 
the stash command is not connected to a particular branch.

Is there a way to have git checkout do an automatic stash when doing a 
checkout to another branch, and then do an automatic git stash apply 
with the correct stash when changing back to the previous branch again?


Thanks,
Daniel
