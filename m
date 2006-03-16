From: Alex Riesen <raa.lkml@gmail.com>
Subject: Re: First dumb question to the list :)
Date: Thu, 16 Mar 2006 23:11:04 +0100
Message-ID: <20060316221104.GA5898@steel.home>
References: <4d8e3fd30603160949l655c4f9blb1e202eaf22fbfe@mail.gmail.com>
Reply-To: Alex Riesen <raa.lkml@gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Thu Mar 16 23:11:22 2006
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by ciao.gmane.org with esmtp (Exim 4.43)
	id 1FK0gh-00015p-L9
	for gcvg-git@gmane.org; Thu, 16 Mar 2006 23:11:20 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S964872AbWCPWLP (ORCPT <rfc822;gcvg-git@m.gmane.org>);
	Thu, 16 Mar 2006 17:11:15 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S964874AbWCPWLO
	(ORCPT <rfc822;git-outgoing>); Thu, 16 Mar 2006 17:11:14 -0500
Received: from devrace.com ([198.63.210.113]:55564 "EHLO devrace.com")
	by vger.kernel.org with ESMTP id S964872AbWCPWLO (ORCPT
	<rfc822;git@vger.kernel.org>); Thu, 16 Mar 2006 17:11:14 -0500
Received: from tigra.home (p54A06E62.dip.t-dialin.net [84.160.110.98])
	(authenticated bits=0)
	by devrace.com (8.12.11/8.12.11) with ESMTP id k2GMB6tH094550;
	Thu, 16 Mar 2006 16:11:07 -0600 (CST)
	(envelope-from fork0@users.sourceforge.net)
Received: from steel.home ([192.168.1.2])
	by tigra.home with esmtp (Exim 3.36 #1 (Debian))
	id 1FK0gS-0005gw-00; Thu, 16 Mar 2006 23:11:04 +0100
Received: from raa by steel.home with local (Exim 4.42 #1 (Debian))
	id 1FK0gS-0002bk-GJ; Thu, 16 Mar 2006 23:11:04 +0100
To: Paolo Ciarrocchi <paolo.ciarrocchi@gmail.com>
Content-Disposition: inline
In-Reply-To: <4d8e3fd30603160949l655c4f9blb1e202eaf22fbfe@mail.gmail.com>
User-Agent: Mutt/1.5.6i
X-Spam-Status: No, score=1.9 required=4.5 tests=AWL,RCVD_IN_NJABL_DUL,
	RCVD_IN_SORBS_DUL autolearn=no version=3.0.2
X-Spam-Level: *
X-Spam-Checker-Version: SpamAssassin 3.0.2 (2004-11-16) on devrace.com
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/17648>

Paolo Ciarrocchi, Thu, Mar 16, 2006 18:49:16 +0100:
> What I want to do is to simply keep my repository aligned with Linus
> so I simply have to do:
> cd linus2.6
> cg-fetch

Or "git pull"

> How can I confg git in order to, by default,  use git instead of rsync ?

By editing .git/remotes/origin and replacing "rsync://rsync." with
"git://git." (I think the rest is identical, but you better check).

> Now my dumb question is... since I want to build that kernel do I have
> to locally clone/copy it in order to don't modify any file on my local
> tree?

No. As long you don't modify anything under .git you can always get to
any state of your kernel tree you ever had (assuming you _use_ git, of
course).

Or you can just revert your changes after you've played enough with
them: "git reset --hard".
