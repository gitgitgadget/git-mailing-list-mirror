From: Johannes Schindelin <Johannes.Schindelin@gmx.de>
Subject: Re: Something wrong with next in main git repository?
Date: Fri, 7 Mar 2008 12:51:02 +0100 (CET)
Message-ID: <alpine.LSU.1.00.0803071249400.19395@racer.site>
References: <200803071129.21551.andyparkins@gmail.com>
Mime-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Cc: Git Mailing List <git@vger.kernel.org>
To: Andy Parkins <andyparkins@gmail.com>
X-From: git-owner@vger.kernel.org Fri Mar 07 12:51:46 2008
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1JXb70-0005sP-TW
	for gcvg-git-2@gmane.org; Fri, 07 Mar 2008 12:51:43 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1758161AbYCGLvE (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Fri, 7 Mar 2008 06:51:04 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1757986AbYCGLvD
	(ORCPT <rfc822;git-outgoing>); Fri, 7 Mar 2008 06:51:03 -0500
Received: from mail.gmx.net ([213.165.64.20]:56004 "HELO mail.gmx.net"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with SMTP
	id S1756755AbYCGLvB (ORCPT <rfc822;git@vger.kernel.org>);
	Fri, 7 Mar 2008 06:51:01 -0500
Received: (qmail invoked by alias); 07 Mar 2008 11:50:59 -0000
Received: from host86-138-198-40.range86-138.btcentralplus.com (EHLO racer.home) [86.138.198.40]
  by mail.gmx.net (mp042) with SMTP; 07 Mar 2008 12:50:59 +0100
X-Authenticated: #1490710
X-Provags-ID: V01U2FsdGVkX19pa0VZnhBpF0mraYU7C3Mim9Rp5ExM/aTXS5/0G5
	ZCTwCqhyjM9EGW
X-X-Sender: gene099@racer.site
In-Reply-To: <200803071129.21551.andyparkins@gmail.com>
User-Agent: Alpine 1.00 (LSU 882 2007-12-20)
X-Y-GMX-Trusted: 0
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/76479>

Hi,

On Fri, 7 Mar 2008, Andy Parkins wrote:

> I've been keeping up with development only intermittently lately, and 
> just got a warning from git fetch (in my git directory) that the update 
> to my 'next' tracking branch was rejected as not being a fast forward.

Junio announced this (IIRC a couple of times), and you can also read in 
MaintNotes:

> The two branches "master" and "maint" are never rewound, and "next" 
> usually will not be either (this automatically means the topics that 
> have been merged into "next" are usually not rebased, and you can find 
> the tip of topic branches you are interested in from the output of "git 
> log next"). You should be able to safely track them.

> After a feature release is made from "master", however, "next" will be 
> rebuilt from the tip of "master" using the surviving topics. The commit 
> that replaces the tip of the "next" will have the identical tree, but it 
> will have different ancestry from the tip of "master". An announcement 
> will be made to warn people about such a rebasing.

Hth,
Dscho

