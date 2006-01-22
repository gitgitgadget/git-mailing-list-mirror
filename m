From: Petr Baudis <pasky@suse.cz>
Subject: Re: [PATCH] git-count-objects --all support
Date: Sun, 22 Jan 2006 04:02:15 +0100
Message-ID: <20060122030215.GT28365@pasky.or.cz>
References: <20060122022718.16375.78611.stgit@machine.or.cz> <7vslrhht8b.fsf@assigned-by-dhcp.cox.net>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Sun Jan 22 04:00:50 2006
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by ciao.gmane.org with esmtp (Exim 4.43)
	id 1F0VTE-0006li-QD
	for gcvg-git@gmane.org; Sun, 22 Jan 2006 04:00:49 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932143AbWAVDAo (ORCPT <rfc822;gcvg-git@m.gmane.org>);
	Sat, 21 Jan 2006 22:00:44 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S932223AbWAVDAo
	(ORCPT <rfc822;git-outgoing>); Sat, 21 Jan 2006 22:00:44 -0500
Received: from w241.dkm.cz ([62.24.88.241]:44704 "EHLO machine.or.cz")
	by vger.kernel.org with ESMTP id S932143AbWAVDAo (ORCPT
	<rfc822;git@vger.kernel.org>); Sat, 21 Jan 2006 22:00:44 -0500
Received: (qmail 18768 invoked by uid 2001); 22 Jan 2006 04:02:15 +0100
To: Junio C Hamano <junkio@cox.net>
Content-Disposition: inline
In-Reply-To: <7vslrhht8b.fsf@assigned-by-dhcp.cox.net>
X-message-flag: Outlook : A program to spread viri, but it can do mail too.
User-Agent: Mutt/1.5.11
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/15039>

Dear diary, on Sun, Jan 22, 2006 at 03:49:40AM CET, I got a letter
where Junio C Hamano <junkio@cox.net> said that...
> Petr Baudis <pasky@suse.cz> writes:
> 
> > Having command called "git-count-objects" count only unpacked objects is
> > a little strange and confusing. This patch adds a warning if packs are
> > already present in the current repository,
> 
> The point of counting objects is to see if it is time to repack,
> so the warning is something I am quite hesitant to accept, even
> with a suppression option.

Then please change the command name - it is very confusing this way;
I've been "burnt" (well, no big deal but wrong numbers, but anyway...)
multiple times and I know others who were as well.

-- 
				Petr "Pasky" Baudis
Stuff: http://pasky.or.cz/
Of the 3 great composers Mozart tells us what it's like to be human,
Beethoven tells us what it's like to be Beethoven and Bach tells us
what it's like to be the universe.  -- Douglas Adams
