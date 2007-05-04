From: Junio C Hamano <junkio@cox.net>
Subject: Re: [PATCH] Support ent:relative_path
Date: Fri, 04 May 2007 12:38:01 -0700
Message-ID: <7vwszos7l2.fsf@assigned-by-dhcp.cox.net>
References: <463ADE51.2030108@gmail.com>
	<56b7f5510705040022x2e4903d3hbe4ac1ee1a2e096f@mail.gmail.com>
	<7v7irpuhhr.fsf@assigned-by-dhcp.cox.net>
	<81b0412b0705040147h1bab8f6ao3ce2c486637a0d4f@mail.gmail.com>
	<463AFAAE.853DEF7B@eudaptics.com>
	<7vabwktsng.fsf@assigned-by-dhcp.cox.net>
	<Pine.LNX.4.64.0705042104370.4015@racer.site>
	<7v1whwtmvj.fsf@assigned-by-dhcp.cox.net>
	<Pine.LNX.4.64.0705042127390.4015@racer.site>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: Johannes Sixt <J.Sixt@eudaptics.com>, git@vger.kernel.org
To: Johannes Schindelin <Johannes.Schindelin@gmx.de>
X-From: git-owner@vger.kernel.org Fri May 04 21:38:09 2007
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1Hk3bU-0004EC-Vg
	for gcvg-git@gmane.org; Fri, 04 May 2007 21:38:09 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1161894AbXEDTiF (ORCPT <rfc822;gcvg-git@m.gmane.org>);
	Fri, 4 May 2007 15:38:05 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1161895AbXEDTiF
	(ORCPT <rfc822;git-outgoing>); Fri, 4 May 2007 15:38:05 -0400
Received: from fed1rmmtao104.cox.net ([68.230.241.42]:47919 "EHLO
	fed1rmmtao104.cox.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1161894AbXEDTiE (ORCPT <rfc822;git@vger.kernel.org>);
	Fri, 4 May 2007 15:38:04 -0400
Received: from fed1rmimpo02.cox.net ([70.169.32.72])
          by fed1rmmtao104.cox.net
          (InterMail vM.7.05.02.00 201-2174-114-20060621) with ESMTP
          id <20070504193803.DKNH24310.fed1rmmtao104.cox.net@fed1rmimpo02.cox.net>;
          Fri, 4 May 2007 15:38:03 -0400
Received: from assigned-by-dhcp.cox.net ([68.5.247.80])
	by fed1rmimpo02.cox.net with bizsmtp
	id v7e11W00K1kojtg0000000; Fri, 04 May 2007 15:38:02 -0400
In-Reply-To: <Pine.LNX.4.64.0705042127390.4015@racer.site> (Johannes
	Schindelin's message of "Fri, 4 May 2007 21:31:42 +0200 (CEST)")
User-Agent: Gnus/5.110006 (No Gnus v0.6) Emacs/21.4 (gnu/linux)
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/46205>

Johannes Schindelin <Johannes.Schindelin@gmx.de> writes:

> For me, "v1.5.1:" means something similar to ssh: it is a distant 
> revision. It is not a complete filesystem. I think of revisions as 
> something more general than a directory, but less general than a 
> filesystem. And thus, it makes perfect sense to me that "v1.5.1:Makefile" 
> means the main Makefile, no matter where I am in the current repository.

I see merits in both sides' arguments.  

Saying "path out of THIS version" anchors your mindset at the
top of that version, so in that sense v1.5.1:Makefile should
mean the toplevel no matter where you are.  However...

> Now, I agree that often you want to compare some file in the current 
> directory to the corresponding file in a certain revision. That is why 
> git-diff has a different idea, and indeed, a different notation, too.

... don't you expect "git show HEAD@{yesterday}:git.txt" while
in Documentation/ subdirectory to work?  I wonder if the current
alternative "git show HEAD@{yesterday}:Documentation/git.txt" a
bit unintuitive.
