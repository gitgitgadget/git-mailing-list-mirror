From: Petr Baudis <pasky@suse.cz>
Subject: Re: cg-push - push to a different head
Date: Mon, 12 Sep 2005 04:03:56 +0200
Message-ID: <20050912020356.GN15630@pasky.or.cz>
References: <46a038f90509111856aa3c23@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: Git Mailing List <git@vger.kernel.org>
X-From: git-owner@vger.kernel.org Mon Sep 12 04:04:56 2005
Return-path: <git-owner@vger.kernel.org>
Received: from vger.kernel.org ([209.132.176.167])
	by ciao.gmane.org with esmtp (Exim 4.43)
	id 1EEdg0-0003nK-K3
	for gcvg-git@gmane.org; Mon, 12 Sep 2005 04:04:09 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751130AbVILCD7 (ORCPT <rfc822;gcvg-git@m.gmane.org>);
	Sun, 11 Sep 2005 22:03:59 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751131AbVILCD6
	(ORCPT <rfc822;git-outgoing>); Sun, 11 Sep 2005 22:03:58 -0400
Received: from w241.dkm.cz ([62.24.88.241]:42201 "EHLO machine.or.cz")
	by vger.kernel.org with ESMTP id S1751130AbVILCD6 (ORCPT
	<rfc822;git@vger.kernel.org>); Sun, 11 Sep 2005 22:03:58 -0400
Received: (qmail 6387 invoked by uid 2001); 12 Sep 2005 04:03:56 +0200
To: Martin Langhoff <martin.langhoff@gmail.com>
Content-Disposition: inline
In-Reply-To: <46a038f90509111856aa3c23@mail.gmail.com>
X-message-flag: Outlook : A program to spread viri, but it can do mail too.
User-Agent: Mutt/1.5.10i
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/8363>

Dear diary, on Mon, Sep 12, 2005 at 03:56:37AM CEST, I got a letter
where Martin Langhoff <martin.langhoff@gmail.com> told me that...
> Hi Petr,

Hi,

> good to see you back. Now, before you go on holidays again... ;-)
> 
> I'd be happy to work a bit on cg-clone to get this scenario working. 
>   
>       $ cg-clone somehost.com/somerepo.dir#odd-branch locadir
>       ... work ... commit ... work
>       $ cg-push
>       cg-push: pushing to a different head not supported yet
>       ... grrr...
>       $ git-push somehost.com/somerepo.dir master:odd-branch
>       # this works!
>  
> I am 100% confuses as to how cg-push is supposed to work. Am I doing
> something wrong, or how should I fix cg-push to do the right thing?

you are doing nothing wrong, it's entirely matter of a
probably-not-too-complicated cg-push fix. Actually, looking at the code,
cg-push seems to even do the wrong thing if you just aren't on the
master branch.

-- 
				Petr "Pasky" Baudis
Stuff: http://pasky.or.cz/
If you want the holes in your knowledge showing up try teaching
someone.  -- Alan Cox
