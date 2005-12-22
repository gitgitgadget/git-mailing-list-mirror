From: Alex Riesen <raa.lkml@gmail.com>
Subject: Re: [PATCH] whatchanged: customize diff-tree output
Date: Thu, 22 Dec 2005 22:06:20 +0100
Message-ID: <20051222210620.GA4679@steel.home>
References: <Pine.LNX.4.63.0512212336230.18908@wbgn013.biozentrum.uni-wuerzburg.de> <7vvexhr6rc.fsf@assigned-by-dhcp.cox.net> <Pine.LNX.4.64.0512212245440.4827@g5.osdl.org> <Pine.LNX.4.63.0512221200190.7112@wbgn013.biozentrum.uni-wuerzburg.de>
Reply-To: Alex Riesen <raa.lkml@gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: Linus Torvalds <torvalds@osdl.org>,
	Junio C Hamano <junkio@cox.net>, git@vger.kernel.org
X-From: git-owner@vger.kernel.org Thu Dec 22 22:07:25 2005
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by ciao.gmane.org with esmtp (Exim 4.43)
	id 1EpXem-0002mV-8u
	for gcvg-git@gmane.org; Thu, 22 Dec 2005 22:07:24 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1030321AbVLVVGp (ORCPT <rfc822;gcvg-git@m.gmane.org>);
	Thu, 22 Dec 2005 16:06:45 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1030322AbVLVVGp
	(ORCPT <rfc822;git-outgoing>); Thu, 22 Dec 2005 16:06:45 -0500
Received: from devrace.com ([198.63.210.113]:25106 "EHLO devrace.com")
	by vger.kernel.org with ESMTP id S1030321AbVLVVGo (ORCPT
	<rfc822;git@vger.kernel.org>); Thu, 22 Dec 2005 16:06:44 -0500
Received: from tigra.home (p54A0F507.dip.t-dialin.net [84.160.245.7])
	(authenticated bits=0)
	by devrace.com (8.12.11/8.12.11) with ESMTP id jBML6MFk051787;
	Thu, 22 Dec 2005 15:06:23 -0600 (CST)
	(envelope-from fork0@users.sourceforge.net)
Received: from steel.home ([192.168.1.2])
	by tigra.home with esmtp (Exim 3.36 #1 (Debian))
	id 1EpXdl-0005ed-00; Thu, 22 Dec 2005 22:06:21 +0100
Received: from raa by steel.home with local (Exim 4.42 #1 (Debian))
	id 1EpXdk-0001Du-NL; Thu, 22 Dec 2005 22:06:20 +0100
To: Johannes Schindelin <Johannes.Schindelin@gmx.de>
Content-Disposition: inline
In-Reply-To: <Pine.LNX.4.63.0512221200190.7112@wbgn013.biozentrum.uni-wuerzburg.de>
User-Agent: Mutt/1.5.6i
X-Spam-Status: No, score=1.9 required=4.5 tests=AWL,RCVD_IN_NJABL_DUL,
	RCVD_IN_SORBS_DUL autolearn=no version=3.0.2
X-Spam-Level: *
X-Spam-Checker-Version: SpamAssassin 3.0.2 (2004-11-16) on devrace.com
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/13971>

Johannes Schindelin, Thu, Dec 22, 2005 12:16:00 +0100:
> > I'm certainly ok with the short format by default. And making it 
> > configurable per repo sounds fine, although at the same time I wonder if 
> > that perhaps confuses people more (something that works in one project one 
> > way works subtly differently in another project..)
> 
> I cannot think of a saner way to have an overridable policy. Just provide 
> a template config, and you're done. Everyone gets those flags per default, 
> and if someone does not like it: go ahead, change it yourself!
> 
> Besides, you are usually calling git-whatchanged in your private working 
> tree, where not many people can change the config.
> 

That's the point, isn't it? A script from ~user1/bin, which calls
git-whatchanged suddenly stops working in ~user2/repo.
Besides, how can user1 know what he has to specify to git-whatchanged
(I assume the command line overrides .git/config) so that his script
works everywhere?

Maybe such configuration better left to environment variables?
