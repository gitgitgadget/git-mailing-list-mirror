From: Petr Baudis <pasky@suse.cz>
Subject: Re: cogito and merging in steps.
Date: Mon, 12 Sep 2005 02:11:05 +0200
Message-ID: <20050912001105.GC15630@pasky.or.cz>
References: <46a038f9050822232961140d4b@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: GIT <git@vger.kernel.org>
X-From: git-owner@vger.kernel.org Mon Sep 12 02:11:52 2005
Return-path: <git-owner@vger.kernel.org>
Received: from vger.kernel.org ([209.132.176.167])
	by ciao.gmane.org with esmtp (Exim 4.43)
	id 1EEbui-0003y8-8W
	for gcvg-git@gmane.org; Mon, 12 Sep 2005 02:11:12 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751095AbVILALI (ORCPT <rfc822;gcvg-git@m.gmane.org>);
	Sun, 11 Sep 2005 20:11:08 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751097AbVILALI
	(ORCPT <rfc822;git-outgoing>); Sun, 11 Sep 2005 20:11:08 -0400
Received: from w241.dkm.cz ([62.24.88.241]:60133 "EHLO machine.or.cz")
	by vger.kernel.org with ESMTP id S1751095AbVILALH (ORCPT
	<rfc822;git@vger.kernel.org>); Sun, 11 Sep 2005 20:11:07 -0400
Received: (qmail 21414 invoked by uid 2001); 12 Sep 2005 02:11:05 +0200
To: Martin Langhoff <martin.langhoff@gmail.com>
Content-Disposition: inline
In-Reply-To: <46a038f9050822232961140d4b@mail.gmail.com>
X-message-flag: Outlook : A program to spread viri, but it can do mail too.
User-Agent: Mutt/1.5.10i
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/8347>

Dear diary, on Tue, Aug 23, 2005 at 08:29:46AM CEST, I got a letter
where Martin Langhoff <martin.langhoff@gmail.com> told me that...
> I want to be able to 
>  - cg-update
>  - oops! this is a mess! review with cg-log -r master:origin
>  - aha! Here is the conflict in the 9th commit from MacFroz, fire off
> email / open irc session
>  - in the meantime, reset the working copy and merge the 8 clean ones
> with something like: cg-restore ; cg-update origin^^^ ; cg-commit
>  - cg-update origin^ ; emacs file-with-conflict.c ; cg-commit 
>  - cg-update # bring in the last pending commit from origin. 
> 
> How can I achieve the cg-update <somepointinthebranch> ; cg-commit ? I
> mean, without faking a head with
> 
>   echo <somepointinthebranch> > .git/refs/heads/temphead 

Theoretically, it should be as easy as

	cg-merge <somepointinthebranch>

-- 
				Petr "Pasky" Baudis
Stuff: http://pasky.or.cz/
If you want the holes in your knowledge showing up try teaching
someone.  -- Alan Cox
