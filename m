From: Tim Mazid <timmazid@hotmail.com>
Subject: Re: Tracking a remote branch in git
Date: Thu, 29 Oct 2009 17:26:20 -0700 (PDT)
Message-ID: <26123156.post@talk.nabble.com>
References: <26119537.post@talk.nabble.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
To: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Fri Oct 30 01:26:28 2009
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1N3fJz-0002Ps-92
	for gcvg-git-2@lo.gmane.org; Fri, 30 Oct 2009 01:26:27 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1756048AbZJ3A0Q (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Thu, 29 Oct 2009 20:26:16 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1756041AbZJ3A0Q
	(ORCPT <rfc822;git-outgoing>); Thu, 29 Oct 2009 20:26:16 -0400
Received: from kuber.nabble.com ([216.139.236.158]:48722 "EHLO
	kuber.nabble.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1753721AbZJ3A0Q (ORCPT <rfc822;git@vger.kernel.org>);
	Thu, 29 Oct 2009 20:26:16 -0400
Received: from isper.nabble.com ([192.168.236.156])
	by kuber.nabble.com with esmtp (Exim 4.63)
	(envelope-from <lists@nabble.com>)
	id 1N3fJs-0005Qi-L3
	for git@vger.kernel.org; Thu, 29 Oct 2009 17:26:20 -0700
In-Reply-To: <26119537.post@talk.nabble.com>
X-Nabble-From: timmazid@hotmail.com
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/131666>



Sips wrote:
> 
> Then I created a branch in the repository on the removable drive W and
> named it newfeature. The question is: How can I work with this branch on
> the local repository as well? I mean, I need the same 'relationship'
> between branches as in case of the master branch.
> 
> ...
> 
> I mean, I am able to track the master branch from the remote repository.
> Why can't I track some other branch as well? Any ideas what I'm doing
> wrong?
> 

Have you tried doing 'git fetch'? That should get and track all new remote
branches automatically.

Once you have a remote branch, if you've deleted the local branch, you can
just do 'git branch LOCAL REMOTE', and that should set up a tracking branch.

If this doesn't work for you, check your git version with 'git --version'.
It works for v1.6.5.2.

Good luck,
Tim.
-- 
View this message in context: http://www.nabble.com/Tracking-a-remote-branch-in-git-tp26119537p26123156.html
Sent from the git mailing list archive at Nabble.com.
