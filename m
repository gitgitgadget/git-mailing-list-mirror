From: Jeff Garzik <jeff@garzik.org>
Subject: Re: [PATCH] git builtin "push"
Date: Sun, 30 Apr 2006 15:58:45 -0400
Message-ID: <445516F5.1090204@garzik.org>
References: <Pine.LNX.4.64.0604292111570.9901@g5.osdl.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Content-Transfer-Encoding: 7bit
Cc: Junio C Hamano <junkio@cox.net>,
	Git Mailing List <git@vger.kernel.org>
X-From: git-owner@vger.kernel.org Sun Apr 30 21:59:07 2006
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by ciao.gmane.org with esmtp (Exim 4.43)
	id 1FaI4O-0008F9-7X
	for gcvg-git@gmane.org; Sun, 30 Apr 2006 21:59:04 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751021AbWD3T6x (ORCPT <rfc822;gcvg-git@m.gmane.org>);
	Sun, 30 Apr 2006 15:58:53 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751023AbWD3T6w
	(ORCPT <rfc822;git-outgoing>); Sun, 30 Apr 2006 15:58:52 -0400
Received: from srv5.dvmed.net ([207.36.208.214]:2734 "EHLO mail.dvmed.net")
	by vger.kernel.org with ESMTP id S1751010AbWD3T6w (ORCPT
	<rfc822;git@vger.kernel.org>); Sun, 30 Apr 2006 15:58:52 -0400
Received: from cpe-065-190-194-075.nc.res.rr.com ([65.190.194.75] helo=[10.10.10.99])
	by mail.dvmed.net with esmtpsa (Exim 4.60 #1 (Red Hat Linux))
	id 1FaI46-0003pR-TX; Sun, 30 Apr 2006 19:58:47 +0000
User-Agent: Thunderbird 1.5 (X11/20060313)
To: Linus Torvalds <torvalds@osdl.org>
In-Reply-To: <Pine.LNX.4.64.0604292111570.9901@g5.osdl.org>
X-Spam-Score: -4.0 (----)
X-Spam-Report: SpamAssassin version 3.1.1 on srv5.dvmed.net summary:
	Content analysis details:   (-4.0 points, 5.0 required)
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/19353>

Linus Torvalds wrote:
> Now, the reason I did it as a built-in is partly because it's yet another 
> step on relying less on shell, but it's actually mostly because I've 
> wanted to be able to push to _multiple_ repositories, and the most obvious 
> and simplest interface for that would seem be to just have a "remotes" 
> file that has multiple URL entries.

Thanks!  This is why I still use rsync, even though everybody and their 
mother tells me "Linus says rsync is deprecated."

Fact is, rsync is still the best to push a _bunch_ of branches, in the 
same tree, all in one command.  In an attempt to get away from rsync, I 
even tried putting multiple git:// entries into .git/remotes/origin, 
then doing "git push" with no args, without success.

Each time I have a non-trivial libata update, I've updated twelve (12) 
branches, and think its highly silly to have to run

	url=git://git.kernel.org/...jgarzik/...
	git push $url $branch:$branch

twelve times.

	Jeff
