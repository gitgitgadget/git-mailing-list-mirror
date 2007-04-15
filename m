From: Alex Riesen <raa.lkml@gmail.com>
Subject: Re: fatal: Out of memory, malloc failed
Date: Sun, 15 Apr 2007 23:40:50 +0200
Message-ID: <20070415214050.GA4417@steel.home>
References: <461FBD02.6050105@eircom.net> <Pine.LNX.4.64.0704131143130.28042@woody.linux-foundation.org> <462277CD.5020609@eircom.net>
Reply-To: Alex Riesen <raa.lkml@gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: git@vger.kernel.org, Linus Torvalds <torvalds@linux-foundation.org>
To: Alan Larkin <nobrow@eircom.net>
X-From: git-owner@vger.kernel.org Sun Apr 15 23:40:58 2007
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1HdCSv-0008B4-OY
	for gcvg-git@gmane.org; Sun, 15 Apr 2007 23:40:58 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1753981AbXDOVky (ORCPT <rfc822;gcvg-git@m.gmane.org>);
	Sun, 15 Apr 2007 17:40:54 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1753982AbXDOVky
	(ORCPT <rfc822;git-outgoing>); Sun, 15 Apr 2007 17:40:54 -0400
Received: from mo-p07-ob.rzone.de ([81.169.146.190]:40493 "EHLO
	mo-p07-ob.rzone.de" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1753981AbXDOVkx (ORCPT <rfc822;git@vger.kernel.org>);
	Sun, 15 Apr 2007 17:40:53 -0400
Received: from tigra.home (Fcb1d.f.strato-dslnet.de [195.4.203.29])
	by post.webmailer.de (klopstock mo64) (RZmta 5.5)
	with ESMTP id G02300j3FITrB0 ; Sun, 15 Apr 2007 23:40:51 +0200 (MEST)
Received: from steel.home (steel.home [192.168.1.2])
	by tigra.home (Postfix) with ESMTP id 142C6277BD;
	Sun, 15 Apr 2007 23:40:51 +0200 (CEST)
Received: by steel.home (Postfix, from userid 1000)
	id 7AD19D439; Sun, 15 Apr 2007 23:40:50 +0200 (CEST)
Content-Disposition: inline
In-Reply-To: <462277CD.5020609@eircom.net>
User-Agent: Mutt/1.5.13 (2006-08-11)
X-RZG-AUTH: z4gQVF2k5XWuW3CcuQaHqBg2oA==
X-RZG-CLASS-ID: mo07
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/44531>

Alan Larkin, Sun, Apr 15, 2007 21:06:53 +0200:
> >> Its not a huge push Im trying to do here (<about 150Mb) but
> >> always malloc fails!
> > 
> > Any huge objects?
> > 
> 
> There were a couple of big files. I removed a 72Mb one (making 47Mb
> the biggest one left in the project) and made the push and it
> worked. I later pulled the project down to a different machine,
> added the 72Mb file back in, and pushed to the server and it worked.
> So apparently it's a platform specific problem. If anybody's
> particularly interested I could replicate it under gdb and pass on
> any info, but if not I wont ... job's done, Im happy.

72Mb is nothing. Is it Windows/cygwin, by any chance? (I see the
problem there sometimes. Tried debugging it, got into some ugly
cygwin-windows interactions, threw up, did the same you did and tried
to forget it all).
