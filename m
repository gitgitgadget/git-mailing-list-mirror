From: Petr Baudis <pasky@suse.cz>
Subject: Re: [PATCH] gitweb: use action dispatcher for non-project actions, too.
Date: Fri, 18 Aug 2006 17:40:20 +0200
Message-ID: <20060818154020.GU13764@pasky.or.cz>
References: <11557673213372-git-send-email-tali@admingilde.org> <11557673212235-git-send-email-tali@admingilde.org> <1155767325181-git-send-email-tali@admingilde.org> <11557673263081-git-send-email-tali@admingilde.org> <11557673262714-git-send-email-tali@admingilde.org> <11557673281583-git-send-email-tali@admingilde.org> <7vk65815h1.fsf@assigned-by-dhcp.cox.net> <87y7tnxv9g.wl%cworth@cworth.org> <20060818131656.GR13776@pasky.or.cz> <87k656rvim.wl%cworth@cworth.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: Junio C Hamano <junkio@cox.net>,
	Martin Waitz <tali@admingilde.org>, git@vger.kernel.org
X-From: git-owner@vger.kernel.org Fri Aug 18 17:40:46 2006
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by ciao.gmane.org with esmtp (Exim 4.43)
	id 1GE6SS-0007QJ-0J
	for gcvg-git@gmane.org; Fri, 18 Aug 2006 17:40:28 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1161021AbWHRPkX (ORCPT <rfc822;gcvg-git@m.gmane.org>);
	Fri, 18 Aug 2006 11:40:23 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1161027AbWHRPkX
	(ORCPT <rfc822;git-outgoing>); Fri, 18 Aug 2006 11:40:23 -0400
Received: from w241.dkm.cz ([62.24.88.241]:55170 "EHLO machine.or.cz")
	by vger.kernel.org with ESMTP id S1161021AbWHRPkW (ORCPT
	<rfc822;git@vger.kernel.org>); Fri, 18 Aug 2006 11:40:22 -0400
Received: (qmail 9062 invoked by uid 2001); 18 Aug 2006 17:40:20 +0200
To: Carl Worth <cworth@cworth.org>
Content-Disposition: inline
In-Reply-To: <87k656rvim.wl%cworth@cworth.org>
X-message-flag: Outlook : A program to spread viri, but it can do mail too.
User-Agent: Mutt/1.5.11
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/25671>

Dear diary, on Fri, Aug 18, 2006 at 04:03:29PM CEST, I got a letter
where Carl Worth <cworth@cworth.org> said that...
> * A single thingy I could publish for <URL> and <branch>. Ideally this
>   would have no whitespace in it and would be directly
>   cut-and-paste-able for use in either gitweb or the git command-line.

Perhaps you could paste a fetch URL to some gitweb inputbox at the top
of every page and it would show the right thing, sort of like mldonkey
with ed2k URLs...

> * A mechanism for not requiring me to invent tracking-branch names.  I
>   end up manually doing a scheme with short prefixes for any given
>   repository. It would be nice if I could configure that (in
>   .git/remotes/<something> say) once so that any new branch I pulled
>   would get its properly named tracking branch. And git could find the
>   right remotes file by matching up the URL.

We already have .git/refs/remote/ where the tracking branches are just
the same name as on the other side, we only need to start really using
it.

-- 
				Petr "Pasky" Baudis
Stuff: http://pasky.or.cz/
Snow falling on Perl. White noise covering line noise.
Hides all the bugs too. -- J. Putnam
