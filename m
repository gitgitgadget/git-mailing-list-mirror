From: Petr Baudis <pasky@suse.cz>
Subject: Re: git cole give unexpected error message
Date: Wed, 14 Dec 2005 12:41:56 +0100
Message-ID: <20051214114156.GG22159@pasky.or.cz>
References: <20051213212820.GB5232@mars.ravnborg.org> <20051213222829.GE22159@pasky.or.cz> <439FE7AD.6080602@op5.se>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Wed Dec 14 12:43:58 2005
Return-path: <git-owner@vger.kernel.org>
Received: from vger.kernel.org ([209.132.176.167])
	by ciao.gmane.org with esmtp (Exim 4.43)
	id 1EmV1I-00036Q-VS
	for gcvg-git@gmane.org; Wed, 14 Dec 2005 12:42:05 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932436AbVLNLmA (ORCPT <rfc822;gcvg-git@m.gmane.org>);
	Wed, 14 Dec 2005 06:42:00 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S932450AbVLNLmA
	(ORCPT <rfc822;git-outgoing>); Wed, 14 Dec 2005 06:42:00 -0500
Received: from w241.dkm.cz ([62.24.88.241]:6623 "EHLO machine.or.cz")
	by vger.kernel.org with ESMTP id S932446AbVLNLl7 (ORCPT
	<rfc822;git@vger.kernel.org>); Wed, 14 Dec 2005 06:41:59 -0500
Received: (qmail 1624 invoked by uid 2001); 14 Dec 2005 12:41:56 +0100
To: Andreas Ericsson <ae@op5.se>
Content-Disposition: inline
In-Reply-To: <439FE7AD.6080602@op5.se>
X-message-flag: Outlook : A program to spread viri, but it can do mail too.
User-Agent: Mutt/1.5.11
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/13627>

Dear diary, on Wed, Dec 14, 2005 at 10:36:45AM CET, I got a letter
where Andreas Ericsson <ae@op5.se> said that...
> Petr Baudis wrote:
> >Dear diary, on Tue, Dec 13, 2005 at 10:28:20PM CET, I got a letter
> >where Sam Ravnborg <sam@ravnborg.org> said that...
> >
> >>cogito being a nice porcelain gives the git errormessage but manage to
> >>clean up when the clone fails.
> >>So also cogito would benefit from a more descriptive errormessage.
> >
> >
> >Well, git clone can fail for many reasons and I don't think the "no such
> >repository" one is completely overwhelming, so hinting that by Cogito
> >could be quite confusing (theme of the day: usability ;-)).
> >
> >The real solution would be proper error reporting by the git daemon.
> >
> 
> But that would open up for an information disclosure. If someone's 
> hacking on a patch, please make it configurable at least.

When it breaks at this stage, it's either some bad internal error (I
guess memory allocation error might do this), permission problem, or
repository not being found. We might then report a more generic error
message "Repository not found or access denied.".

-- 
				Petr "Pasky" Baudis
Stuff: http://pasky.or.cz/
VI has two modes: the one in which it beeps and the one in which
it doesn't.
