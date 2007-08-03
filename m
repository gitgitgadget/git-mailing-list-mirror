From: Johannes Schindelin <Johannes.Schindelin@gmx.de>
Subject: Re: Git on MSys (or how to make it easy for Windows users to compile
 git)
Date: Fri, 3 Aug 2007 13:47:50 +0100 (BST)
Message-ID: <Pine.LNX.4.64.0708031347160.14781@racer.site>
References: <Pine.LNX.4.64.0708022206130.14781@racer.site> 
 <460B6BF8541C4D9B916F02A12E0576F5@ntdev.corp.microsoft.com> 
 <46B2D4D9.4020103@trolltech.com> <a1bbc6950708030258h16a6514kf5c637af13874fb7@mail.gmail.com>
 <Pine.LNX.4.64.0708031243330.14781@racer.site>
Mime-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Cc: Marius Storm-Olsen <marius@trolltech.com>, git@vger.kernel.org
To: Dmitry Kakurin <dmitry.kakurin@gmail.com>
X-From: git-owner@vger.kernel.org Fri Aug 03 14:48:24 2007
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1IGwZr-0004FA-Qf
	for gcvg-git@gmane.org; Fri, 03 Aug 2007 14:48:24 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1755143AbXHCMsV (ORCPT <rfc822;gcvg-git@m.gmane.org>);
	Fri, 3 Aug 2007 08:48:21 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1754888AbXHCMsV
	(ORCPT <rfc822;git-outgoing>); Fri, 3 Aug 2007 08:48:21 -0400
Received: from mail.gmx.net ([213.165.64.20]:48687 "HELO mail.gmx.net"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with SMTP
	id S1755143AbXHCMsU (ORCPT <rfc822;git@vger.kernel.org>);
	Fri, 3 Aug 2007 08:48:20 -0400
Received: (qmail invoked by alias); 03 Aug 2007 12:48:19 -0000
Received: from unknown (EHLO [138.251.11.74]) [138.251.11.74]
  by mail.gmx.net (mp052) with SMTP; 03 Aug 2007 14:48:19 +0200
X-Authenticated: #1490710
X-Provags-ID: V01U2FsdGVkX19xP2QPTp1xTxDEk+R3udzjWud5vvQjKy8XvhLyie
	rpumL1+2i3bmxB
X-X-Sender: gene099@racer.site
In-Reply-To: <Pine.LNX.4.64.0708031243330.14781@racer.site>
X-Y-GMX-Trusted: 0
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/54716>

Hi,

On Fri, 3 Aug 2007, Johannes Schindelin wrote:

> Completely forgot: we might want to do something like this at the end of 
> /etc/profile:
> 
> 	test ! -d /git || {
> 		mv /git $HOME/ &&
> 		cd $HOME/git &&
> 		make install &&
> 		git config remote.origin.url \
> 			git://repo.or.cz/git/mingw.git
> 		git config remote.origin.fetch \
> 			'+refs/heads/*:refs/remotes/origin/*'
> 		git config remote.mob.url \
> 			repo.or.cz:/srv/git/git/mingw.git
> 		git config remote.mob.fetch \
> 			+refs/remote/mob:refs/remotes/origin/mob
> 		git config remote.mob.push \
> 			master:mob
> 		git fetch
> 		git reset 51785010a4d3e7f6c3
> 	}
> 
> Please test that, and include it if it works.

Oh well, I downloaded your archive, and making the adjustments right now.

Ciao,
Dscho
