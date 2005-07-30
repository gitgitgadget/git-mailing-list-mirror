From: barkalow@iabervon.org
Subject: Re: Last mile to 1.0?
Date: Sat, 30 Jul 2005 01:40:53 -0400 (EDT)
Message-ID: <Pine.LNX.4.62.0507300118060.25709@iabervon.org>
Mime-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII; format=flowed
Cc: barkalow@andor.org
X-From: git-owner@vger.kernel.org Sat Jul 30 07:38:45 2005
Return-path: <git-owner@vger.kernel.org>
Received: from vger.kernel.org ([12.107.209.244])
	by ciao.gmane.org with esmtp (Exim 4.43)
	id 1Dyk3V-0003Y5-Oh
	for gcvg-git@gmane.org; Sat, 30 Jul 2005 07:38:42 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S262913AbVG3FiS (ORCPT <rfc822;gcvg-git@m.gmane.org>);
	Sat, 30 Jul 2005 01:38:18 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S262915AbVG3FiR
	(ORCPT <rfc822;git-outgoing>); Sat, 30 Jul 2005 01:38:17 -0400
Received: from iabervon.org ([66.92.72.58]:11273 "EHLO iabervon.org")
	by vger.kernel.org with ESMTP id S262913AbVG3FiA (ORCPT
	<rfc822;git@vger.kernel.org>); Sat, 30 Jul 2005 01:38:00 -0400
Received: (qmail 15094 invoked by uid 1000); 30 Jul 2005 01:40:53 -0400
Received: from localhost (sendmail-bs@127.0.0.1)
  by localhost with SMTP; 30 Jul 2005 01:40:53 -0400
To: git@vger.kernel.org
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org

I've been missing for a couple of weeks due to my server dying and needing 
to be replaced; I think stuff is mostly back in order now. (But I'm not 
yet resubscribed, and I suspect only dumb mailers are currently willing 
to talk to my mail server, for some reason I don't yet understand; I'm 
sort of reading the archives, at least.)

I still have the patch to make git-http-pull download packs, and I should 
be able to get it to read the objects/info/packs file without too much 
trouble.

I was also in progress on a series to rearrange the code in pull.c such 
that it passes the objects it needs through a list such that it can 
request them in parallel. I'd gotten as far as making it blast out 
requests for objects over git-ssh-pull (and then break because it doesn't 
expect to be able to accidentally read part of the next object while 
reading the current object); it shouldn't be too hard to make the HTTP 
version use this to parallelize requests as well.

I expect I'll get to work on this on Sunday, in any case.

 	-Daniel
*This .sig left intentionally blank*
