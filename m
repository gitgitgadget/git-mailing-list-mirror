From: Nicolas Pitre <nico@cam.org>
Subject: Re: [PATCH] add a diff-files command (revised)
Date: Wed, 27 Apr 2005 22:39:00 -0400 (EDT)
Message-ID: <Pine.LNX.4.62.0504272229290.14033@localhost.localdomain>
References: <Pine.LNX.4.62.0504272141560.14033@localhost.localdomain>
 <20050428021547.GB8612@pasky.ji.cz>
Mime-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Content-Transfer-Encoding: 7BIT
Cc: Linus Torvalds <torvalds@osdl.org>,
	Junio C Hamano <junkio@cox.net>, git@vger.kernel.org
X-From: git-owner@vger.kernel.org Thu Apr 28 04:35:25 2005
Return-path: <git-owner@vger.kernel.org>
Received: from vger.kernel.org ([12.107.209.244])
	by ciao.gmane.org with esmtp (Exim 4.43)
	id 1DQyrn-0002oo-6Q
	for gcvg-git@gmane.org; Thu, 28 Apr 2005 04:35:03 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261740AbVD1Cjz (ORCPT <rfc822;gcvg-git@m.gmane.org>);
	Wed, 27 Apr 2005 22:39:55 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261782AbVD1Cje
	(ORCPT <rfc822;git-outgoing>); Wed, 27 Apr 2005 22:39:34 -0400
Received: from relais.videotron.ca ([24.201.245.36]:13414 "EHLO
	relais.videotron.ca") by vger.kernel.org with ESMTP id S261740AbVD1Cj1
	(ORCPT <rfc822;git@vger.kernel.org>);
	Wed, 27 Apr 2005 22:39:27 -0400
Received: from xanadu.home ([24.200.213.96]) by VL-MO-MR011.ip.videotron.ca
 (iPlanet Messaging Server 5.2 HotFix 1.21 (built Sep  8 2003))
 with ESMTP id <0IFM00GSYY10WY@VL-MO-MR011.ip.videotron.ca> for
 git@vger.kernel.org; Wed, 27 Apr 2005 22:39:00 -0400 (EDT)
In-reply-to: <20050428021547.GB8612@pasky.ji.cz>
X-X-Sender: nico@localhost.localdomain
To: Petr Baudis <pasky@ucw.cz>
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org

On Thu, 28 Apr 2005, Petr Baudis wrote:

> Dear diary, on Thu, Apr 28, 2005 at 04:06:29AM CEST, I got a letter
> where Nicolas Pitre <nico@cam.org> told me that...
> > In the same spirit as diff-tree and diff-cache, here is a diff-files 
> > command that processes differences between the index cache and the 
> > working directory content.  It produces lists of files that are either 
> > changed, deleted and/or unknown with regards to the current cache, 
> > content. The -p option can also be used to generate a patch describing 
> > the differences in patch form.
> 
> Except some usage enhancement, how does this differ from show-diff?

This is intended to supercede show-diff.  But since its argument list is 
different I thought creating a new command would be nicer while 
show-diff usage (which has accumulated cruft already with now unused 
switches) is phased out.  Also the name "diff-files" is more inline with 
the other diff commands.

> Also, for some reason you have update-cache.c in your patch too.

Huh!?


Nicolas
