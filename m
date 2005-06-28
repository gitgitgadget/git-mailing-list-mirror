From: Petr Baudis <pasky@ucw.cz>
Subject: Re: Mercurial vs Updated git HOWTO for kernel hackers
Date: Tue, 28 Jun 2005 17:07:52 +0200
Message-ID: <20050628150752.GC1275@pasky.ji.cz>
References: <42B9E536.60704@pobox.com> <20050623235634.GC14426@waste.org> <20050624064101.GB14292@pasky.ji.cz> <20050624130604.GK17715@g5.random> <42BC112C.1040009@qualitycode.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: Git Mailing List <git@vger.kernel.org>, mercurial@selenic.com
X-From: git-owner@vger.kernel.org Tue Jun 28 17:01:05 2005
Return-path: <git-owner@vger.kernel.org>
Received: from vger.kernel.org ([12.107.209.244])
	by ciao.gmane.org with esmtp (Exim 4.43)
	id 1DnHaB-000798-Fc
	for gcvg-git@gmane.org; Tue, 28 Jun 2005 17:01:03 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261905AbVF1PIE (ORCPT <rfc822;gcvg-git@m.gmane.org>);
	Tue, 28 Jun 2005 11:08:04 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S262012AbVF1PIE
	(ORCPT <rfc822;git-outgoing>); Tue, 28 Jun 2005 11:08:04 -0400
Received: from w241.dkm.cz ([62.24.88.241]:38047 "HELO machine.sinus.cz")
	by vger.kernel.org with SMTP id S261905AbVF1PHy (ORCPT
	<rfc822;git@vger.kernel.org>); Tue, 28 Jun 2005 11:07:54 -0400
Received: (qmail 4146 invoked by uid 2001); 28 Jun 2005 15:07:52 -0000
To: Kevin Smith <yarcs@qualitycode.com>
Content-Disposition: inline
In-Reply-To: <42BC112C.1040009@qualitycode.com>
User-Agent: Mutt/1.4i
X-message-flag: Outlook : A program to spread viri, but it can do mail too.
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org

Dear diary, on Fri, Jun 24, 2005 at 03:57:00PM CEST, I got a letter
where Kevin Smith <yarcs@qualitycode.com> told me that...
> - Can run on (native) MS Windows
>   (necessary for me because I often work on cross-platform projects)

I'd expect everything to work fine with Cygwin (or with only minor
problems easy to fix) or just any working bash + GNU coreutils
installation. Any issue with that?

> - Python code can be more clear and expressive (IMHO)
> 
> In the long run, I think the python code base will be easier to maintain 
> and enhance. A rewrite of cogito in python or ruby would be cool.

I've planned to rewrite Cogito in Perl, but it turned out the shell
scripts really are far from the PITA they appeared to be - they work
just fine and feel quite comfortable from the maintenance standpoint as
well. It surprised me too but I don't plan to rewrite Cogito in a
different language soon.

> One advantage that cogito has is that git viewing/browsing tools can 
> operate directly on cogito repos. But a psychological drawback is the 
> ongoing confusion between git and cogito. Questions: Would a git-based 
> tool that writes to the repo (such as StGIT) mess up a cogito repo? Can 
> you switch a repo between git and cogito or back, at any time?

Cogito's only unusual requirement (well, expectation) is that HEAD is a
symlink to .git/refs/heads/master, and .git/refs/heads/master should
reflect your current head. I will try to ease up this restriction so
that things will mostly work even if you just have HEAD. I think that
most auxiliary commands (e.g. cg-log - you just have to love it) should
work on any sensible git tree (but I didn't test it - yet).

-- 
				Petr "Pasky" Baudis
Stuff: http://pasky.or.cz/
<Espy> be careful, some twit might quote you out of context..
