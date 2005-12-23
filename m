From: Alex Riesen <raa.lkml@gmail.com>
Subject: Re: [PATCH] whatchanged: customize diff-tree output
Date: Fri, 23 Dec 2005 19:12:49 +0100
Message-ID: <20051223181249.GA3165@steel.home>
References: <Pine.LNX.4.63.0512212336230.18908@wbgn013.biozentrum.uni-wuerzburg.de> <7vvexhr6rc.fsf@assigned-by-dhcp.cox.net> <Pine.LNX.4.64.0512212245440.4827@g5.osdl.org> <Pine.LNX.4.63.0512221200190.7112@wbgn013.biozentrum.uni-wuerzburg.de> <20051222210620.GA4679@steel.home> <Pine.LNX.4.63.0512222323110.12241@wbgn013.biozentrum.uni-wuerzburg.de>
Reply-To: Alex Riesen <raa.lkml@gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Fri Dec 23 19:13:06 2005
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by ciao.gmane.org with esmtp (Exim 4.43)
	id 1EprPY-0005uY-5y
	for gcvg-git@gmane.org; Fri, 23 Dec 2005 19:13:00 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1030595AbVLWSM5 (ORCPT <rfc822;gcvg-git@m.gmane.org>);
	Fri, 23 Dec 2005 13:12:57 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1030596AbVLWSM5
	(ORCPT <rfc822;git-outgoing>); Fri, 23 Dec 2005 13:12:57 -0500
Received: from devrace.com ([198.63.210.113]:16 "EHLO devrace.com")
	by vger.kernel.org with ESMTP id S1030595AbVLWSM4 (ORCPT
	<rfc822;git@vger.kernel.org>); Fri, 23 Dec 2005 13:12:56 -0500
Received: from tigra.home (p5081616F.dip.t-dialin.net [80.129.97.111])
	(authenticated bits=0)
	by devrace.com (8.12.11/8.12.11) with ESMTP id jBNICoNY064372;
	Fri, 23 Dec 2005 12:12:52 -0600 (CST)
	(envelope-from fork0@users.sourceforge.net)
Received: from steel.home ([192.168.1.2])
	by tigra.home with esmtp (Exim 3.36 #1 (Debian))
	id 1EprPN-0006hw-00; Fri, 23 Dec 2005 19:12:49 +0100
Received: from raa by steel.home with local (Exim 4.42 #1 (Debian))
	id 1EprPN-0003jC-FE; Fri, 23 Dec 2005 19:12:49 +0100
To: Johannes Schindelin <Johannes.Schindelin@gmx.de>
Content-Disposition: inline
In-Reply-To: <Pine.LNX.4.63.0512222323110.12241@wbgn013.biozentrum.uni-wuerzburg.de>
User-Agent: Mutt/1.5.6i
X-Spam-Status: No, score=3.9 required=4.5 tests=RCVD_IN_DSBL,
	RCVD_IN_NJABL_DUL autolearn=no version=3.0.2
X-Spam-Level: ***
X-Spam-Checker-Version: SpamAssassin 3.0.2 (2004-11-16) on devrace.com
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/13997>

Johannes Schindelin, Thu, Dec 22, 2005 23:24:48 +0100:
> > A script from ~user1/bin, which calls git-whatchanged suddenly stops 
> > working in ~user2/repo.
> > [...]
> > 
> > Maybe such configuration better left to environment variables?
> 
> And that makes the script not stop how?
> 

It is another user, who does not have the variable set, or just unsets
the variable in his scripts (now he _can_ rely upon git-whatchanged
always doing the same)
