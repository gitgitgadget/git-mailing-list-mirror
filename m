From: Jeff Garzik <jeff@garzik.org>
Subject: Perserving permissions?
Date: Sat, 25 Mar 2006 05:48:11 -0500
Message-ID: <44251FEB.70008@garzik.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Content-Transfer-Encoding: 7bit
X-From: git-owner@vger.kernel.org Sat Mar 25 11:48:24 2006
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by ciao.gmane.org with esmtp (Exim 4.43)
	id 1FN6Jf-0001d7-SJ
	for gcvg-git@gmane.org; Sat, 25 Mar 2006 11:48:20 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751170AbWCYKsR (ORCPT <rfc822;gcvg-git@m.gmane.org>);
	Sat, 25 Mar 2006 05:48:17 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751162AbWCYKsR
	(ORCPT <rfc822;git-outgoing>); Sat, 25 Mar 2006 05:48:17 -0500
Received: from srv5.dvmed.net ([207.36.208.214]:28063 "EHLO mail.dvmed.net")
	by vger.kernel.org with ESMTP id S1751170AbWCYKsQ (ORCPT
	<rfc822;git@vger.kernel.org>); Sat, 25 Mar 2006 05:48:16 -0500
Received: from cpe-065-190-194-075.nc.res.rr.com ([65.190.194.75] helo=[10.10.10.99])
	by mail.dvmed.net with esmtpsa (Exim 4.60 #1 (Red Hat Linux))
	id 1FN6Jb-0005WL-C1
	for git@vger.kernel.org; Sat, 25 Mar 2006 10:48:15 +0000
User-Agent: Thunderbird 1.5 (X11/20060313)
To: Git Mailing List <git@vger.kernel.org>
X-Spam-Score: -2.5 (--)
X-Spam-Report: SpamAssassin version 3.0.5 on srv5.dvmed.net summary:
	Content analysis details:   (-2.5 points, 5.0 required)
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/17978>


I just started using git to maintain some of my server config files. 
Leagues better than subversion, which I was previously using, but git 
still suffers from a key problem that subversion also has:  lack of 
permission preservation.

I understand that versioning permissions might be a big request, but 
what about simply storing the permissions at 'git add' time, to be used 
at checkout time?

Right now I have to do 'git pull ; ./fix-perms' each time I update.

	Jeff
