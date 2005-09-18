From: Petr Baudis <pasky@suse.cz>
Subject: Re: Newbie falls at first hurdle
Date: Sun, 18 Sep 2005 16:59:58 +0200
Message-ID: <20050918145958.GB22391@pasky.or.cz>
References: <200509171309.46893.alan@chandlerfamily.org.uk>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Sun Sep 18 17:01:32 2005
Return-path: <git-owner@vger.kernel.org>
Received: from vger.kernel.org ([209.132.176.167])
	by ciao.gmane.org with esmtp (Exim 4.43)
	id 1EH0eF-0000gZ-Az
	for gcvg-git@gmane.org; Sun, 18 Sep 2005 17:00:07 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932095AbVIRPAD (ORCPT <rfc822;gcvg-git@m.gmane.org>);
	Sun, 18 Sep 2005 11:00:03 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751230AbVIRPAC
	(ORCPT <rfc822;git-outgoing>); Sun, 18 Sep 2005 11:00:02 -0400
Received: from w241.dkm.cz ([62.24.88.241]:57760 "EHLO machine.or.cz")
	by vger.kernel.org with ESMTP id S1751108AbVIRPAA (ORCPT
	<rfc822;git@vger.kernel.org>); Sun, 18 Sep 2005 11:00:00 -0400
Received: (qmail 13381 invoked by uid 2001); 18 Sep 2005 16:59:58 +0200
To: Alan Chandler <alan@chandlerfamily.org.uk>
Content-Disposition: inline
In-Reply-To: <200509171309.46893.alan@chandlerfamily.org.uk>
X-message-flag: Outlook : A program to spread viri, but it can do mail too.
User-Agent: Mutt/1.5.10i
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/8783>

Dear diary, on Sat, Sep 17, 2005 at 02:09:46PM CEST, I got a letter
where Alan Chandler <alan@chandlerfamily.org.uk> told me that...
> I have been lurking on this mailing list since the beginning, but have just 
> got to the point where I want to use git to manage something I am doing.
> 
> I have already got a working directory (or rather a directory hierarchy) of an 
> application with files (combination of html and java), and I need to start 
> applying some control to it.  The Tutorial unfortunately does not cover this 
> case.  Nevertheless I have proceeded.
> 
> So at the top-level I have done 'git-init-db'
> 
> but I now assume I have to add all the files to the cache
> 
> So 'git-update-cache --add *' would seem to be the next step.
> 
> However this fails with a message 
> 
> error: JavaSource: is a directory
> fatal: Unable to add JavaSource to database; maybe you want to use --add 
> option?
> 
> Since I am already using the --add option, I really don't understand what I am 
> doing wrong.

Two reports about this error message in one day, and I've seen more in
the past. Heh. ;-) I'd submit a patch, but I'm still staying at the last
git release because of the command renames.

BTW, cg-add should be now (not in the last release yet, though) totally
directory-friendly.

-- 
				Petr "Pasky" Baudis
Stuff: http://pasky.or.cz/
If you want the holes in your knowledge showing up try teaching
someone.  -- Alan Cox
