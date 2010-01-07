From: martinvz <martin.von.zweigbergk@gmail.com>
Subject: Re: Difference between pull --rebase and fetch+rebase
Date: Thu, 7 Jan 2010 04:58:04 -0800 (PST)
Message-ID: <27059574.post@talk.nabble.com>
References: <27059158.post@talk.nabble.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
To: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Thu Jan 07 13:58:16 2010
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1NSrwN-0006ZQ-WA
	for gcvg-git-2@lo.gmane.org; Thu, 07 Jan 2010 13:58:16 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1752547Ab0AGM6K (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Thu, 7 Jan 2010 07:58:10 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1752235Ab0AGM6J
	(ORCPT <rfc822;git-outgoing>); Thu, 7 Jan 2010 07:58:09 -0500
Received: from kuber.nabble.com ([216.139.236.158]:35450 "EHLO
	kuber.nabble.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751912Ab0AGM6G (ORCPT <rfc822;git@vger.kernel.org>);
	Thu, 7 Jan 2010 07:58:06 -0500
Received: from isper.nabble.com ([192.168.236.156])
	by kuber.nabble.com with esmtp (Exim 4.63)
	(envelope-from <lists@nabble.com>)
	id 1NSrwC-0006B7-Tq
	for git@vger.kernel.org; Thu, 07 Jan 2010 04:58:04 -0800
In-Reply-To: <27059158.post@talk.nabble.com>
X-Nabble-From: martin.von.zweigbergk@gmail.com
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/136340>


Forgot to say that I am using version 1.6.5.1.1367.gcd48 (Cygwin). I should
also say that I can see no particular reason why exactly two extra commits
were picked.


martinvz wrote:
> 
> I have a branch configured to track a remote branch by rebasing. I
> excepted that "git pull" would therefore be equivalent to fetching from
> the remote repository followed by rebasing the remote branch, but it
> isn't. When doing "git rebase <remote>/<branch>", it applies only the
> commits after the merge base. When doing "git pull", it tries to apply two
> more commits (the two commits preceding the merge base). Why is this?
> 
> I get the same result even if I do "git pull --rebase <remote> <branch>",
> it doesn't seem to have anything to do with incorrect configuration of the
> branch.
> 

-- 
View this message in context: http://old.nabble.com/Difference-between-pull---rebase-and-fetch%2Brebase-tp27059158p27059574.html
Sent from the git mailing list archive at Nabble.com.
