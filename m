From: Kevin Geiss <kevin@desertsol.com>
Subject: git rebase conflict help?
Date: Thu, 17 Nov 2005 15:20:25 -0700
Message-ID: <33D6F7FB-7864-471B-A111-9991C768577A@desertsol.com>
Mime-Version: 1.0 (Apple Message framework v746.2)
Content-Type: text/plain; charset=US-ASCII; delsp=yes; format=flowed
Content-Transfer-Encoding: 7bit
X-From: git-owner@vger.kernel.org Thu Nov 17 23:22:32 2005
Return-path: <git-owner@vger.kernel.org>
Received: from vger.kernel.org ([209.132.176.167])
	by ciao.gmane.org with esmtp (Exim 4.43)
	id 1Ecs7Y-00019T-96
	for gcvg-git@gmane.org; Thu, 17 Nov 2005 23:20:44 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S964877AbVKQWUb (ORCPT <rfc822;gcvg-git@m.gmane.org>);
	Thu, 17 Nov 2005 17:20:31 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S964874AbVKQWUb
	(ORCPT <rfc822;git-outgoing>); Thu, 17 Nov 2005 17:20:31 -0500
Received: from 12-219-167-192.client.mchsi.com ([12.219.167.192]:60640 "EHLO
	desertsol.com") by vger.kernel.org with ESMTP id S964848AbVKQWUa
	(ORCPT <rfc822;git@vger.kernel.org>);
	Thu, 17 Nov 2005 17:20:30 -0500
Received: from [205.132.171.76] (helo=[29.6.1.216])
	by desertsol.com with esmtpsa (TLSv1:RC4-SHA:128)
	(Exim 4.50)
	id 1Ecs7K-0000HA-EG
	for git@vger.kernel.org; Thu, 17 Nov 2005 15:20:30 -0700
To: git@vger.kernel.org
X-Mailer: Apple Mail (2.746.2)
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/12163>

I fetched my origin branch, then tried to run 'git rebase origin'.  
one of my commits from master which is not yet in origin got a  
conflict, so git rebase origin told me that the Simple cherry-pick  
failed, and the Automatic cherry-pick got conflicts. and it saved the  
commit message for me in .msg and my offending commit's id in .rebase- 
tmp32409.

I'm not sure how to proceed from here. actually, I know what the  
offending changes are, and I could re-do the changes by hand and  
commit them again, but I'd like to know what git tools I'm supposed  
to use in this case...

thanks.
