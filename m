From: Petr Baudis <pasky@suse.cz>
Subject: Re: [PATCH] Disable USE_SYMLINK_HEAD by default
Date: Tue, 15 Nov 2005 18:42:13 +0100
Message-ID: <20051115174213.GO16061@pasky.or.cz>
References: <1132034390.22207.18.camel@dv> <7vveyuqto5.fsf@assigned-by-dhcp.cox.net> <1132042427.3512.50.camel@dv> <7vpsp2qpx4.fsf@assigned-by-dhcp.cox.net> <7vd5l2mco1.fsf@assigned-by-dhcp.cox.net> <Pine.LNX.4.63.0511151207070.21671@wbgn013.biozentrum.uni-wuerzburg.de> <20051115121854.GV30496@pasky.or.cz> <7v8xvpn8ne.fsf@assigned-by-dhcp.cox.net> <1132075295.25640.59.camel@dv> <Pine.LNX.4.64.0511150931010.3945@g5.osdl.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: Pavel Roskin <proski@gnu.org>, Junio C Hamano <junkio@cox.net>,
	Johannes Schindelin <Johannes.Schindelin@gmx.de>,
	git@vger.kernel.org
X-From: git-owner@vger.kernel.org Tue Nov 15 18:45:21 2005
Return-path: <git-owner@vger.kernel.org>
Received: from vger.kernel.org ([209.132.176.167])
	by ciao.gmane.org with esmtp (Exim 4.43)
	id 1Ec4p1-0003va-Pj
	for gcvg-git@gmane.org; Tue, 15 Nov 2005 18:42:20 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751463AbVKORmR (ORCPT <rfc822;gcvg-git@m.gmane.org>);
	Tue, 15 Nov 2005 12:42:17 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751465AbVKORmR
	(ORCPT <rfc822;git-outgoing>); Tue, 15 Nov 2005 12:42:17 -0500
Received: from w241.dkm.cz ([62.24.88.241]:39102 "EHLO machine.or.cz")
	by vger.kernel.org with ESMTP id S1751463AbVKORmQ (ORCPT
	<rfc822;git@vger.kernel.org>); Tue, 15 Nov 2005 12:42:16 -0500
Received: (qmail 30427 invoked by uid 2001); 15 Nov 2005 18:42:13 +0100
To: Linus Torvalds <torvalds@osdl.org>
Content-Disposition: inline
In-Reply-To: <Pine.LNX.4.64.0511150931010.3945@g5.osdl.org>
X-message-flag: Outlook : A program to spread viri, but it can do mail too.
User-Agent: Mutt/1.5.11
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/11926>

Dear diary, on Tue, Nov 15, 2005 at 06:33:44PM CET, I got a letter
where Linus Torvalds <torvalds@osdl.org> said that...
> On Tue, 15 Nov 2005, Pavel Roskin wrote:
> > 
> > With symlinks, cogito doesn't know which branch it is fetching if the
> > branch is not explicitly specified.
> > 
> > The old behavior was to fetch the "master" branch by default.
> > Currently, cogito uses HEAD, but it cannot read the symlink, it can only
> > read the SHA1. 
> 
> Hmm? Why not just use "git-symbolic-ref HEAD" to figure it out? That works 
> with both symlinks and symrefs (and indeed, was added for that reason).

If you show me a way how to do git-symbolic-ref over HTTP, I will be
most grateful. :-)

Seriously though, if people have huge problem with having symbolic refs
by default, that's unfortunate since we have two possibilities which are
not equally tested, but I can live with it - just give me a way to
configure that behaviour per-repository, so that I can make GIT use
symbolic refs in public repositories (or I can whip up a patch myself at
the evening, after all...).

-- 
				Petr "Pasky" Baudis
Stuff: http://pasky.or.cz/
VI has two modes: the one in which it beeps and the one in which
it doesn't.
