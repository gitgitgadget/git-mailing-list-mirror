From: GittyUser <xtelligence@gmail.com>
Subject: Re: How to update from remote origin with local modified branch?
Date: Wed, 2 Dec 2009 08:20:19 -0800 (PST)
Message-ID: <1259770819546-4100678.post@n2.nabble.com>
References: <1259752954810-4099323.post@n2.nabble.com> <4B167925.8080307@drmicha.warpmail.net>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
To: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Wed Dec 02 17:20:32 2009
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1NFrwI-0007Es-SJ
	for gcvg-git-2@lo.gmane.org; Wed, 02 Dec 2009 17:20:27 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1754177AbZLBQUO (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Wed, 2 Dec 2009 11:20:14 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1754158AbZLBQUN
	(ORCPT <rfc822;git-outgoing>); Wed, 2 Dec 2009 11:20:13 -0500
Received: from kuber.nabble.com ([216.139.236.158]:40034 "EHLO
	kuber.nabble.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1753707AbZLBQUN (ORCPT <rfc822;git@vger.kernel.org>);
	Wed, 2 Dec 2009 11:20:13 -0500
Received: from jim.nabble.com ([192.168.236.80])
	by kuber.nabble.com with esmtp (Exim 4.63)
	(envelope-from <lists+1217463532682-661346@n2.nabble.com>)
	id 1NFrwB-0001FZ-Hh
	for git@vger.kernel.org; Wed, 02 Dec 2009 08:20:19 -0800
In-Reply-To: <4B167925.8080307@drmicha.warpmail.net>
X-Nabble-From: GittyUser <xtelligence@gmail.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/134344>



Michael J Gruber-2 wrote:
> 
> 
> I think you want to read up on workflows with git and decide whether you
> want to rebase or merge. In short, git fetch --all (which is called by
> git pull) will update your remote tracking branches (origin/*), and then
> you can decide what to do with your local branch (probably master): Do
> you merge origin/master into master, or do you rebase master onto
> origin/master?
> 

Thnx for your response,

What I want is merge origin/master to local branch master.  My mistake is to
have some uncommited files and I guess that's the reason why it's not,
pardon me, it could not be updated. So I try to commit the files, but still
had issues about unmerged files. So as advised I did "git add -f
unmergedfile" and than they were added to the Index. Did finally the commit
and now get the "Already up-to-date" message after a pull command.

Still need to practice a lot to know what is exactly going on.

-- 
View this message in context: http://n2.nabble.com/How-to-update-from-remote-origin-with-local-modified-branch-tp4099323p4100678.html
Sent from the git mailing list archive at Nabble.com.
