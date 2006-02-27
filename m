From: MIke Galbraith <efault@gmx.de>
Subject: Re: the war on trailing whitespace
Date: Mon, 27 Feb 2006 03:50:33 +0100
Message-ID: <1141008633.7593.13.camel@homer>
References: <20060225174047.0e9a6d29.akpm@osdl.org>
	 <7v1wxq7psj.fsf@assigned-by-dhcp.cox.net>
	 <20060225210712.29b30f59.akpm@osdl.org>
	 <Pine.LNX.4.64.0602260925170.22647@g5.osdl.org>
	 <20060226103604.2d97696c.akpm@osdl.org>
	 <Pine.LNX.4.64.0602261213340.22647@g5.osdl.org>
	 <20060226202617.GH7851@redhat.com>
Mime-Version: 1.0
Content-Type: text/plain
Content-Transfer-Encoding: 7bit
Cc: Linus Torvalds <torvalds@osdl.org>, Andrew Morton <akpm@osdl.org>,
	junkio@cox.net, git@vger.kernel.org
X-From: git-owner@vger.kernel.org Mon Feb 27 03:50:54 2006
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by ciao.gmane.org with esmtp (Exim 4.43)
	id 1FDYTE-0000EG-Ae
	for gcvg-git@gmane.org; Mon, 27 Feb 2006 03:50:45 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1750712AbWB0CuT (ORCPT <rfc822;gcvg-git@m.gmane.org>);
	Sun, 26 Feb 2006 21:50:19 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1750802AbWB0CuT
	(ORCPT <rfc822;git-outgoing>); Sun, 26 Feb 2006 21:50:19 -0500
Received: from mail.gmx.net ([213.165.64.20]:36579 "HELO mail.gmx.net")
	by vger.kernel.org with SMTP id S1750712AbWB0CuR (ORCPT
	<rfc822;git@vger.kernel.org>); Sun, 26 Feb 2006 21:50:17 -0500
Received: (qmail invoked by alias); 27 Feb 2006 02:50:15 -0000
Received: from dialin-212.223.97.193.germany.ecore.net (EHLO homer) [212.223.97.193]
  by mail.gmx.net (mp019) with SMTP; 27 Feb 2006 03:50:15 +0100
X-Authenticated: #14349625
To: Dave Jones <davej@redhat.com>
In-Reply-To: <20060226202617.GH7851@redhat.com>
X-Mailer: Evolution 2.4.0 
X-Y-GMX-Trusted: 0
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/16821>

On Sun, 2006-02-26 at 15:26 -0500, Dave Jones wrote:

> I think I have the same anal-retentive problem Andrew has, because I have ..
> 
> highlight RedundantSpaces term=standout ctermbg=red guibg=red
> match RedundantSpaces /\s\+$\| \+\ze\t/
> 
> in my .vimrc, which highlights this (and other trailing whitespace) as
> a big red blob.  I do this in part for the same reason Andrew does,
> so that when someone sends me a diff with a zillion spaces at the EOL,
> it screams at me, I spot them, and chop them out.

Dang, I'm _not_ perfect after all ;-).  I just tried this on a patch of
mine, and up popped a few angry red blobs even though I try to be
careful.  Perhaps someone should add more pet peeve thingies to it and
post it to lkml, or put it some place people can be pointed at.

	-Mike
