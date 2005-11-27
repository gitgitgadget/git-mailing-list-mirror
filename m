From: Petr Baudis <pasky@suse.cz>
Subject: Re: [PATCH 6/8] ls-tree: work from subdirectory.
Date: Sun, 27 Nov 2005 12:08:00 +0100
Message-ID: <20051127110800.GE10680@pasky.or.cz>
References: <7v8xveth4l.fsf@assigned-by-dhcp.cox.net> <Pine.LNX.4.63.0511241419390.14297@wbgn013.biozentrum.uni-wuerzburg.de> <7vmzjtn3h1.fsf@assigned-by-dhcp.cox.net> <Pine.LNX.4.63.0511242252080.26485@wbgn013.biozentrum.uni-wuerzburg.de> <7vy83cdu7r.fsf@assigned-by-dhcp.cox.net> <Pine.LNX.4.64.0511251953081.13959@g5.osdl.org> <7voe477n4i.fsf_-_@assigned-by-dhcp.cox.net> <7vpson4tqi.fsf@assigned-by-dhcp.cox.net> <Pine.LNX.4.64.0511260855560.13959@g5.osdl.org> <7vr792fnta.fsf@assigned-by-dhcp.cox.net>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: Linus Torvalds <torvalds@osdl.org>,
	Git Mailing List <git@vger.kernel.org>
X-From: git-owner@vger.kernel.org Sun Nov 27 12:09:48 2005
Return-path: <git-owner@vger.kernel.org>
Received: from vger.kernel.org ([209.132.176.167])
	by ciao.gmane.org with esmtp (Exim 4.43)
	id 1EgKO9-0002xw-A6
	for gcvg-git@gmane.org; Sun, 27 Nov 2005 12:08:09 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1750994AbVK0LID (ORCPT <rfc822;gcvg-git@m.gmane.org>);
	Sun, 27 Nov 2005 06:08:03 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751000AbVK0LID
	(ORCPT <rfc822;git-outgoing>); Sun, 27 Nov 2005 06:08:03 -0500
Received: from w241.dkm.cz ([62.24.88.241]:3489 "EHLO machine.or.cz")
	by vger.kernel.org with ESMTP id S1750994AbVK0LIB (ORCPT
	<rfc822;git@vger.kernel.org>); Sun, 27 Nov 2005 06:08:01 -0500
Received: (qmail 18606 invoked by uid 2001); 27 Nov 2005 12:08:00 +0100
To: Junio C Hamano <junkio@cox.net>
Content-Disposition: inline
In-Reply-To: <7vr792fnta.fsf@assigned-by-dhcp.cox.net>
X-message-flag: Outlook : A program to spread viri, but it can do mail too.
User-Agent: Mutt/1.5.11
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/12801>

Dear diary, on Sun, Nov 27, 2005 at 10:21:53AM CET, I got a letter
where Junio C Hamano <junkio@cox.net> said that...
>  - cg-admin-cat may want to use -r for the first one (${ARGS[@]}
>    may name a directory), but that also would change the
>    behaviour.  The current one shows only one level, instead of
>    going all the way down.

I think the current behaviour is nonsensical, since it cats all the
files in the subdirectory, instead of just listing it. Didn't
git-ls-tree already have the -d implicit sometime in the past? At any
rate, the change to git-ls-tree would fix this. :-)

>  - cg-log:117 uses ls-tree without -r, but I have a feeling that
>    it might be just a bug, even with the current ls-tree; I
>    suspect the user would not see things in subdirectories.
>    This is only for the initial commit so it may or may not
>    matter much.

Thanks, fixed. It uses -r now.

-- 
				Petr "Pasky" Baudis
Stuff: http://pasky.or.cz/
VI has two modes: the one in which it beeps and the one in which
it doesn't.
