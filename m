From: Michael J Gruber <git@drmicha.warpmail.net>
Subject: Re: How to update from remote origin with local modified branch?
Date: Wed, 02 Dec 2009 15:26:45 +0100
Message-ID: <4B167925.8080307@drmicha.warpmail.net>
References: <1259752954810-4099323.post@n2.nabble.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: 7bit
Cc: git@vger.kernel.org
To: GittyUser <xtelligence@gmail.com>
X-From: git-owner@vger.kernel.org Wed Dec 02 15:28:07 2009
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1NFqBa-0003VQ-9C
	for gcvg-git-2@lo.gmane.org; Wed, 02 Dec 2009 15:28:06 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1752503AbZLBO1w (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Wed, 2 Dec 2009 09:27:52 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751824AbZLBO1v
	(ORCPT <rfc822;git-outgoing>); Wed, 2 Dec 2009 09:27:51 -0500
Received: from out1.smtp.messagingengine.com ([66.111.4.25]:51284 "EHLO
	out1.smtp.messagingengine.com" rhost-flags-OK-OK-OK-OK)
	by vger.kernel.org with ESMTP id S1750815AbZLBO1v (ORCPT
	<rfc822;git@vger.kernel.org>); Wed, 2 Dec 2009 09:27:51 -0500
Received: from compute1.internal (compute1.internal [10.202.2.41])
	by gateway1.messagingengine.com (Postfix) with ESMTP id A7803C58DF;
	Wed,  2 Dec 2009 09:27:57 -0500 (EST)
Received: from heartbeat2.messagingengine.com ([10.202.2.161])
  by compute1.internal (MEProxy); Wed, 02 Dec 2009 09:27:57 -0500
DKIM-Signature: v=1; a=rsa-sha1; c=relaxed/relaxed; d=messagingengine.com; h=message-id:date:from:mime-version:to:cc:subject:references:in-reply-to:content-type:content-transfer-encoding; s=smtpout; bh=siqlObJFEVAftPHDfaH+gJoKuRA=; b=KaZTXfHm40X5tn3AD8AH+0KHIeulLs1bOxVDORCGlQjcL2hlQlrUeHpQGyYXy/2Y/1I7/2Z5+Vo8RD7X7HIu+tAJAc6me9yLjV0SbLyCFopCnlTjX8IaqRUoL066QIA7RVh99QcgMo8Q73/Hv+WCZsu2GmV6+pRzTi5RFeDQMJ4=
X-Sasl-enc: lJm+Wl3yKZEDpBSuW+V99SJRnYTIZIYbBhw+XJYa9xWv 1259764077
Received: from localhost.localdomain (whitehead.math.tu-clausthal.de [139.174.44.12])
	by mail.messagingengine.com (Postfix) with ESMTPSA id 0D6461B60F;
	Wed,  2 Dec 2009 09:27:56 -0500 (EST)
User-Agent: Mozilla/5.0 (X11; U; Linux x86_64; en-US; rv:1.9.1.6pre) Gecko/20091127 Lightning/1.0b1pre Shredder/3.0.1pre
In-Reply-To: <1259752954810-4099323.post@n2.nabble.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/134336>

GittyUser venit, vidit, dixit 02.12.2009 12:22:
> 
> I have once cloned a a project from a remote repository:
> git cloned http://repo.or.cz/r/openbsc.git
> 
> After that I modified some files and commited.
> In the mean time the remote repository had several commits. Now I want to
> update my local repo from the remote repo but I also want to keep my own
> commits. So, when doing "git pull" I get the message that certain files
> needs to be updated.
> 
> Now, how can I get my local repo, with my own modification, updated by the
> remote repo?
> I know I need to be aware that those updates (or commits) from remote must
> not conflict with my local.
> 
> Thank you.

I think you want to read up on workflows with git and decide whether you
want to rebase or merge. In short, git fetch --all (which is called by
git pull) will update your remote tracking branches (origin/*), and then
you can decide what to do with your local branch (probably master): Do
you merge origin/master into master, or do you rebase master onto
origin/master?

Michael
