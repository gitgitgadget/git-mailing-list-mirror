From: Johannes Schindelin <Johannes.Schindelin@gmx.de>
Subject: Re: Deleting remote branches with git-branch and reflog questions
Date: Tue, 23 Jan 2007 22:35:00 +0100 (CET)
Message-ID: <Pine.LNX.4.63.0701232232480.22628@wbgn013.biozentrum.uni-wuerzburg.de>
References: <200701231259.27719.andyparkins@gmail.com> <45B6076F.5060503@op5.se>
 <200701231314.53361.andyparkins@gmail.com> <7v1wllo2p6.fsf@assigned-by-dhcp.cox.net>
Mime-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Cc: Andy Parkins <andyparkins@gmail.com>, git@vger.kernel.org
X-From: git-owner@vger.kernel.org Tue Jan 23 22:35:13 2007
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1H9TIP-0002S1-Al
	for gcvg-git@gmane.org; Tue, 23 Jan 2007 22:35:13 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S965479AbXAWVfI (ORCPT <rfc822;gcvg-git@m.gmane.org>);
	Tue, 23 Jan 2007 16:35:08 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S965493AbXAWVfH
	(ORCPT <rfc822;git-outgoing>); Tue, 23 Jan 2007 16:35:07 -0500
Received: from mail.gmx.net ([213.165.64.20]:54791 "HELO mail.gmx.net"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with SMTP
	id S965479AbXAWVfE (ORCPT <rfc822;git@vger.kernel.org>);
	Tue, 23 Jan 2007 16:35:04 -0500
Received: (qmail invoked by alias); 23 Jan 2007 21:35:00 -0000
Received: from wbgn013.biozentrum.uni-wuerzburg.de (EHLO dumbo2) [132.187.25.13]
  by mail.gmx.net (mp010) with SMTP; 23 Jan 2007 22:35:00 +0100
X-Authenticated: #1490710
X-X-Sender: gene099@wbgn013.biozentrum.uni-wuerzburg.de
To: Junio C Hamano <junkio@cox.net>
In-Reply-To: <7v1wllo2p6.fsf@assigned-by-dhcp.cox.net>
X-Y-GMX-Trusted: 0
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/37573>

Hi,

On Tue, 23 Jan 2007, Junio C Hamano wrote:

> Andy Parkins <andyparkins@gmail.com> writes:
> 
> > Aren't /all/ the logged refs under "refs/" these 
> > days?
> 
> Yes, so what.  It's not a big deal, and it's too late to change,
> isn't it?
> 
> Seriously, I think with addition of 'git log --walk-reflogs' and
> 'git show-branch --reflog', there is less reason for an end user
> to look at the raw .git/logs/ directory these days.

How about introducing the shortcut "-g" for "--walk-reflogs"? It is not 
yet taken AFAICT.

> And we might want to allow reflogs on detached HEAD someday, although I 
> personally think it goes against what detached HEAD is -- it is of a 
> very temporary nature.

But so are reflogs. They go away after some time.

Disk space is cheap.

Ciao,
Dscho
