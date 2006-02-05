From: Petr Baudis <pasky@suse.cz>
Subject: Re: [PATCH] do not open editor in dumb terminal
Date: Sun, 5 Feb 2006 18:44:22 +0100
Message-ID: <20060205174422.GG31278@pasky.or.cz>
References: <20060203114133.GA11499@kvasir.watson.ibm.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: junkio@cox.net, git@vger.kernel.org, boutcher@cs.umn.edu
X-From: git-owner@vger.kernel.org Sun Feb 05 18:44:42 2006
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by ciao.gmane.org with esmtp (Exim 4.43)
	id 1F5nwE-0002Ym-FC
	for gcvg-git@gmane.org; Sun, 05 Feb 2006 18:44:38 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751099AbWBERo2 (ORCPT <rfc822;gcvg-git@m.gmane.org>);
	Sun, 5 Feb 2006 12:44:28 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751236AbWBERo2
	(ORCPT <rfc822;git-outgoing>); Sun, 5 Feb 2006 12:44:28 -0500
Received: from w241.dkm.cz ([62.24.88.241]:60331 "EHLO machine.or.cz")
	by vger.kernel.org with ESMTP id S1751099AbWBERo2 (ORCPT
	<rfc822;git@vger.kernel.org>); Sun, 5 Feb 2006 12:44:28 -0500
Received: (qmail 23623 invoked by uid 2001); 5 Feb 2006 18:44:22 +0100
To: Amos Waterland <apw@us.ibm.com>
Content-Disposition: inline
In-Reply-To: <20060203114133.GA11499@kvasir.watson.ibm.com>
X-message-flag: Outlook : A program to spread viri, but it can do mail too.
User-Agent: Mutt/1.5.11
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/15632>

Dear diary, on Fri, Feb 03, 2006 at 12:41:33PM CET, I got a letter
where Amos Waterland <apw@us.ibm.com> said that...
> Many people run git from a shell in emacs (obtained by M-x shell).  When
> they try to do a commit without specifying a log message on the command
> line with -m, git opens vi inside emacs, with unpleasant results.  I
> think the right answer is to just refuse to open an editor in any dumb
> terminal.
> 
> Signed-off-by: Amos Waterland <apw@us.ibm.com>
> Cc: Dave C Boutcher <boutcher@cs.umn.edu>

Cogito solves this by [ -t ] and just doing cat instead of $EDITOR if
the input is not a terminal. Couldn't Junio just do

	emacsclient | cg^H^Hgit commit

in that case? (Note that I'm totally clueless about what emacsclient's
usage actually is.)

-- 
				Petr "Pasky" Baudis
Stuff: http://pasky.or.cz/
Of the 3 great composers Mozart tells us what it's like to be human,
Beethoven tells us what it's like to be Beethoven and Bach tells us
what it's like to be the universe.  -- Douglas Adams
