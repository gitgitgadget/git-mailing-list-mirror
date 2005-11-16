From: Alex Riesen <raa.lkml@gmail.com>
Subject: Re: [PATCH 1/3] C implementation of the 'git' program, take two.
Date: Wed, 16 Nov 2005 22:04:49 +0100
Message-ID: <20051116210449.GA4191@steel.home>
References: <20051115233125.3153B5BF76@nox.op5.se> <Pine.LNX.4.64.0511151603510.11232@g5.osdl.org> <437A8067.9050308@op5.se> <Pine.LNX.4.64.0511151751520.13959@g5.osdl.org> <Pine.LNX.4.63.0511160316510.14820@wbgn013.biozentrum.uni-wuerzburg.de>
Reply-To: Alex Riesen <raa.lkml@gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: Linus Torvalds <torvalds@osdl.org>, Andreas Ericsson <ae@op5.se>,
	git@vger.kernel.org
X-From: git-owner@vger.kernel.org Wed Nov 16 22:07:24 2005
Return-path: <git-owner@vger.kernel.org>
Received: from vger.kernel.org ([209.132.176.167])
	by ciao.gmane.org with esmtp (Exim 4.43)
	id 1EcUSt-00057F-Tt
	for gcvg-git@gmane.org; Wed, 16 Nov 2005 22:05:12 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932606AbVKPVFI (ORCPT <rfc822;gcvg-git@m.gmane.org>);
	Wed, 16 Nov 2005 16:05:08 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S932607AbVKPVFI
	(ORCPT <rfc822;git-outgoing>); Wed, 16 Nov 2005 16:05:08 -0500
Received: from devrace.com ([198.63.210.113]:33284 "EHLO devrace.com")
	by vger.kernel.org with ESMTP id S932606AbVKPVFG (ORCPT
	<rfc822;git@vger.kernel.org>); Wed, 16 Nov 2005 16:05:06 -0500
Received: from tigra.home (p54A0CE2A.dip.t-dialin.net [84.160.206.42])
	(authenticated bits=0)
	by devrace.com (8.12.11/8.12.11) with ESMTP id jAGL4qar097749;
	Wed, 16 Nov 2005 15:04:54 -0600 (CST)
	(envelope-from fork0@users.sourceforge.net)
Received: from steel.home ([192.168.1.2])
	by tigra.home with esmtp (Exim 3.36 #1 (Debian))
	id 1EcUSZ-0000WO-00; Wed, 16 Nov 2005 22:04:51 +0100
Received: from raa by steel.home with local (Exim 4.42 #1 (Debian))
	id 1EcUSX-0003cu-VO; Wed, 16 Nov 2005 22:04:49 +0100
To: Johannes Schindelin <Johannes.Schindelin@gmx.de>
Content-Disposition: inline
In-Reply-To: <Pine.LNX.4.63.0511160316510.14820@wbgn013.biozentrum.uni-wuerzburg.de>
User-Agent: Mutt/1.5.6i
X-Spam-Status: No, score=1.8 required=4.5 tests=AWL,BAYES_50,
	RCVD_IN_NJABL_DUL,RCVD_IN_SORBS_DUL autolearn=no version=3.0.2
X-Spam-Level: *
X-Spam-Checker-Version: SpamAssassin 3.0.2 (2004-11-16) on devrace.com
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/12057>

Johannes Schindelin, Wed, Nov 16, 2005 03:18:05 +0100:
> > Then, you just prepend it to the PATH, with a : in between (and if the 
> > pathname has a ":" in it, tough, there's nothing we can do about it).
> 
> You mean like "c:/cygwin/git"? Yes, I know, the default is 
> "/cygdrive/c/cygwin/git", but there are people out there with ":" in their 
> pathname.
> 

and you can't possibly be hinting at "\" as path element separator...

Cygwin rewrites values in PATH (well, poorly: there are things like
"z:.", which admins of another stupid thing, novel netware, are so much
fond of).
