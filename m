From: Petr Baudis <pasky@suse.cz>
Subject: Re: strange cg-add problem
Date: Sun, 27 Nov 2005 14:08:12 +0100
Message-ID: <20051127130812.GE22159@pasky.or.cz>
References: <20051122123058.GB19989@schottelius.org> <7vbr0cfwqd.fsf@assigned-by-dhcp.cox.net>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: Nico -telmich- Schottelius <nico-linux-git@schottelius.org>,
	git@vger.kernel.org
X-From: git-owner@vger.kernel.org Sun Nov 27 14:08:48 2005
Return-path: <git-owner@vger.kernel.org>
Received: from vger.kernel.org ([209.132.176.167])
	by ciao.gmane.org with esmtp (Exim 4.43)
	id 1EgMGD-0004Cj-Ve
	for gcvg-git@gmane.org; Sun, 27 Nov 2005 14:08:06 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751035AbVK0NH6 (ORCPT <rfc822;gcvg-git@m.gmane.org>);
	Sun, 27 Nov 2005 08:07:58 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751036AbVK0NH6
	(ORCPT <rfc822;git-outgoing>); Sun, 27 Nov 2005 08:07:58 -0500
Received: from w241.dkm.cz ([62.24.88.241]:9886 "EHLO machine.or.cz")
	by vger.kernel.org with ESMTP id S1751034AbVK0NH5 (ORCPT
	<rfc822;git@vger.kernel.org>); Sun, 27 Nov 2005 08:07:57 -0500
Received: (qmail 29009 invoked by uid 2001); 27 Nov 2005 14:08:12 +0100
To: Junio C Hamano <junkio@cox.net>
Content-Disposition: inline
In-Reply-To: <7vbr0cfwqd.fsf@assigned-by-dhcp.cox.net>
X-message-flag: Outlook : A program to spread viri, but it can do mail too.
User-Agent: Mutt/1.5.11
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/12805>

Dear diary, on Tue, Nov 22, 2005 at 05:55:38PM CET, I got a letter
where Junio C Hamano <junkio@cox.net> said that...
> Nico -telmich- Schottelius <nico-linux-git@schottelius.org> writes:
> 
> > srwali01:/home/server/backup/db# ~/db-dump.sh 
> > /home/server/backup/db//2005-11-22/13:26 does not exist or is not a regular file
> > cg-add: warning: not all files could be added
> > cg-commit: Nothing to commit
> 
> I do not use cogito, but I suspect it would work if you change
> your script to avoid double slash between db and 2005-11-22.

Did it work? That would have to be GIT's thing, though. Also, GIT does
not seem to like absolute paths being passed to git-update-index.

-- 
				Petr "Pasky" Baudis
Stuff: http://pasky.or.cz/
VI has two modes: the one in which it beeps and the one in which
it doesn't.
