From: Alex Riesen <raa.lkml@gmail.com>
Subject: Re: Quick question
Date: Mon, 13 Feb 2006 21:17:09 +0100
Message-ID: <20060213201709.GB5935@steel.home>
References: <43F0B577.4070608@gorzow.mm.pl> <Pine.LNX.4.64.0602130848220.3691@g5.osdl.org> <43F0CF3B.6040807@gorzow.mm.pl>
Reply-To: Alex Riesen <raa.lkml@gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: Linus Torvalds <torvalds@osdl.org>,
	Git Mailing List <git@vger.kernel.org>
X-From: git-owner@vger.kernel.org Mon Feb 13 21:18:32 2006
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by ciao.gmane.org with esmtp (Exim 4.43)
	id 1F8k8f-00058Q-By
	for gcvg-git@gmane.org; Mon, 13 Feb 2006 21:17:38 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S964854AbWBMURd (ORCPT <rfc822;gcvg-git@m.gmane.org>);
	Mon, 13 Feb 2006 15:17:33 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S964855AbWBMURd
	(ORCPT <rfc822;git-outgoing>); Mon, 13 Feb 2006 15:17:33 -0500
Received: from devrace.com ([198.63.210.113]:32272 "EHLO devrace.com")
	by vger.kernel.org with ESMTP id S964854AbWBMURd (ORCPT
	<rfc822;git@vger.kernel.org>); Mon, 13 Feb 2006 15:17:33 -0500
Received: from tigra.home (p54A0590F.dip.t-dialin.net [84.160.89.15])
	(authenticated bits=0)
	by devrace.com (8.12.11/8.12.11) with ESMTP id k1DKHDDu096909;
	Mon, 13 Feb 2006 14:17:15 -0600 (CST)
	(envelope-from fork0@users.sourceforge.net)
Received: from steel.home ([192.168.1.2])
	by tigra.home with esmtp (Exim 3.36 #1 (Debian))
	id 1F8k8G-0001Bv-00; Mon, 13 Feb 2006 21:17:12 +0100
Received: from raa by steel.home with local (Exim 4.42 #1 (Debian))
	id 1F8k8F-0001vA-1E; Mon, 13 Feb 2006 21:17:11 +0100
To: Radoslaw Szkodzinski <astralstorm@gorzow.mm.pl>
Content-Disposition: inline
In-Reply-To: <43F0CF3B.6040807@gorzow.mm.pl>
User-Agent: Mutt/1.5.6i
X-Spam-Status: No, score=0.9 required=4.5 tests=AWL,RCVD_IN_NJABL_DUL 
	autolearn=no version=3.0.2
X-Spam-Checker-Version: SpamAssassin 3.0.2 (2004-11-16) on devrace.com
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/16079>

Radoslaw Szkodzinski, Mon, Feb 13, 2006 19:26:03 +0100:
> Linus Torvalds wrote:
> > 
> > Well, since you're telling it to only show excluded files, it will also 
> > only show excluded directories.
> > 
> > Which is admittedly insane. You don't want to exclude directories. Or 
> > maybe you do, but then we should add the "/" to the end before we do the 
> > exclusion.
> > 
> > This patch (untested) will never exclude directories. Which may or may not 
> > be the right thing. 

I actually quiet like it how it is.

> > Junio? Others? Comments?
> > 
> 
> For me it seems to do the right thing, although I have no need to exclude directories.
> If I really needed to, I'd say something like:
> 
> /excluded_dir/*
> 
> in .git/info/exclude, and it would show the files as being excluded.
> 

What's wrong with .gitignore in the excluded_dir containing everything
you don't want to see, or even just "*"?
