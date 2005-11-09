From: Petr Baudis <pasky@suse.cz>
Subject: Re: Cogito: cg-clone doesn't like packed tag objects
Date: Wed, 9 Nov 2005 23:33:04 +0100
Message-ID: <20051109223303.GG30496@pasky.or.cz>
References: <43348086.2040006@zytor.com> <20050924011833.GJ10255@pasky.or.cz> <7vvf0r6x97.fsf@assigned-by-dhcp.cox.net> <20050924125001.GB25069@pasky.or.cz> <7virwqwd3z.fsf@assigned-by-dhcp.cox.net>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Wed Nov 09 23:37:02 2005
Return-path: <git-owner@vger.kernel.org>
Received: from vger.kernel.org ([209.132.176.167])
	by ciao.gmane.org with esmtp (Exim 4.43)
	id 1EZyVC-0008Gt-JG
	for gcvg-git@gmane.org; Wed, 09 Nov 2005 23:33:10 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751051AbVKIWdH (ORCPT <rfc822;gcvg-git@m.gmane.org>);
	Wed, 9 Nov 2005 17:33:07 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751054AbVKIWdH
	(ORCPT <rfc822;git-outgoing>); Wed, 9 Nov 2005 17:33:07 -0500
Received: from w241.dkm.cz ([62.24.88.241]:21648 "EHLO machine.or.cz")
	by vger.kernel.org with ESMTP id S1751051AbVKIWdF (ORCPT
	<rfc822;git@vger.kernel.org>); Wed, 9 Nov 2005 17:33:05 -0500
Received: (qmail 24833 invoked by uid 2001); 9 Nov 2005 23:33:04 +0100
To: Junio C Hamano <junkio@cox.net>
Content-Disposition: inline
In-Reply-To: <7virwqwd3z.fsf@assigned-by-dhcp.cox.net>
X-message-flag: Outlook : A program to spread viri, but it can do mail too.
User-Agent: Mutt/1.5.11
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/11426>

Dear diary, on Sat, Sep 24, 2005 at 08:10:40PM CEST, I got a letter
where Junio C Hamano <junkio@cox.net> told me that...
> > default post-update hook could change to
> >
> > 	[ -e "$_git/git-dummy-support" ] && exec git-update-server-info
> >
> > and be enabled by default?
> 
> That is a thought.  While I think doing update-server-info
> everywhere whenever you update ref is going a bit overboard, I
> agree there should be an easy way for the end user to keep
> repositories that are public accessible all times.  But running
> server-info upon every commit does not make much sense to me --
> something is seriously broken if we need to do that.

Point taken, you are right.

BTW, Cogito has for a while the command 'cg-admin-setuprepo' which is
designed to be used to create those public accessible repositories where
you typically only push to. Recently, I've also changed it so that it
just enables the default post-update hook; is it safe to assume that the
default template post-update hook shipped with GIT will be
good-to-be-autoenabled on public repositories and will always contain
the git-update-server-info invocation (unless it becomes irrelevant in
the future) ?

-- 
				Petr "Pasky" Baudis
Stuff: http://pasky.or.cz/
VI has two modes: the one in which it beeps and the one in which
it doesn't.
