From: Petr Baudis <pasky@suse.cz>
Subject: Re: lock
Date: Fri, 11 Nov 2005 17:41:01 +0100
Message-ID: <20051111164101.GV30496@pasky.or.cz>
References: <34a7ae040511110831y3e896738o@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Fri Nov 11 17:43:13 2005
Return-path: <git-owner@vger.kernel.org>
Received: from vger.kernel.org ([209.132.176.167])
	by ciao.gmane.org with esmtp (Exim 4.43)
	id 1Eabxd-0001MZ-3a
	for gcvg-git@gmane.org; Fri, 11 Nov 2005 17:41:09 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1750863AbVKKQlF (ORCPT <rfc822;gcvg-git@m.gmane.org>);
	Fri, 11 Nov 2005 11:41:05 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1750866AbVKKQlF
	(ORCPT <rfc822;git-outgoing>); Fri, 11 Nov 2005 11:41:05 -0500
Received: from w241.dkm.cz ([62.24.88.241]:18620 "EHLO machine.or.cz")
	by vger.kernel.org with ESMTP id S1750863AbVKKQlE (ORCPT
	<rfc822;git@vger.kernel.org>); Fri, 11 Nov 2005 11:41:04 -0500
Received: (qmail 15562 invoked by uid 2001); 11 Nov 2005 17:41:01 +0100
To: Paolo Teti <paolo.teti@gmail.com>
Content-Disposition: inline
In-Reply-To: <34a7ae040511110831y3e896738o@mail.gmail.com>
X-message-flag: Outlook : A program to spread viri, but it can do mail too.
User-Agent: Mutt/1.5.11
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/11616>

Dear diary, on Fri, Nov 11, 2005 at 05:31:31PM CET, I got a letter
where Paolo Teti <paolo.teti@gmail.com> said that...
> Just a question probably stupid because I'm a quite new GIT user.
> 
> Is possible to apply a lock (as in ClearCase) on a given file etc in order to
> prevent accidental check-out or any other tool operation?

Can you be a bit more detailed in the description of what do you exactly
want?

Do you want to lock the file so that noone else will be able to check it
out? That's impossible from GIT's very nature of distributed version
control system.

Do you want to lock the file in your working copy so that you won't be
able to remove it or change it? In that case, this is possible, but not
implemented yet. Part of the solution would involve making the file
read-only, the rest would be probably to make sure all the tools handle
that case gracefully.

-- 
				Petr "Pasky" Baudis
Stuff: http://pasky.or.cz/
VI has two modes: the one in which it beeps and the one in which
it doesn't.
