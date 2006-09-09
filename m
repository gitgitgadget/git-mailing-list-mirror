From: Petr Baudis <pasky@suse.cz>
Subject: Re: Change set based shallow clone
Date: Sat, 9 Sep 2006 05:13:07 +0200
Message-ID: <20060909031307.GE23891@pasky.or.cz>
References: <9e4733910609071252ree73effwb06358e9a22ba965@mail.gmail.com> <7vpse7tjp0.fsf@assigned-by-dhcp.cox.net> <46a038f90609072054u5ec8bc46x9878a601953b2c5d@mail.gmail.com> <7vac5ancvo.fsf@assigned-by-dhcp.cox.net> <9e4733910609080720s7a143d9bp5a1dd36869967c22@mail.gmail.com> <eds3fg$u30$1@sea.gmane.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Sat Sep 09 05:13:16 2006
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by ciao.gmane.org with esmtp (Exim 4.43)
	id 1GLtHQ-00005I-1p
	for gcvg-git@gmane.org; Sat, 09 Sep 2006 05:13:16 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932101AbWIIDNM (ORCPT <rfc822;gcvg-git@m.gmane.org>);
	Fri, 8 Sep 2006 23:13:12 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S932103AbWIIDNM
	(ORCPT <rfc822;git-outgoing>); Fri, 8 Sep 2006 23:13:12 -0400
Received: from w241.dkm.cz ([62.24.88.241]:44942 "EHLO machine.or.cz")
	by vger.kernel.org with ESMTP id S932102AbWIIDNK (ORCPT
	<rfc822;git@vger.kernel.org>); Fri, 8 Sep 2006 23:13:10 -0400
Received: (qmail 30474 invoked by uid 2001); 9 Sep 2006 05:13:07 +0200
To: Jakub Narebski <jnareb@gmail.com>
Content-Disposition: inline
In-Reply-To: <eds3fg$u30$1@sea.gmane.org>
X-message-flag: Outlook : A program to spread viri, but it can do mail too.
User-Agent: Mutt/1.5.11
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/26732>

Dear diary, on Fri, Sep 08, 2006 at 05:50:40PM CEST, I got a letter
where Jakub Narebski <jnareb@gmail.com> said that...
> My idea for lazy clone/fetch (lazy = on-demand) is via remote alternatives
> mechanism. We put URI for repository (repositories) that hosts the project,
> and we would need at start to download at least heads and tags, and only
> heads and tags.

  One thing to note is that you won't last very long without getting
at least basically all the commits from the history. git log, git
merge-base and such would either just suck them all, get partially moved
to the server side, or would undergo quite a painful and slooooooooow
process "get me commit X... thank you, sir. hmm, it appears that its
parent is commit Y.  could you get me commit Y, please...? thank you,
sir. hmm, it appears...".

-- 
				Petr "Pasky" Baudis
Stuff: http://pasky.or.cz/
Snow falling on Perl. White noise covering line noise.
Hides all the bugs too. -- J. Putnam
