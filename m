From: Petr Baudis <pasky@suse.cz>
Subject: Re: gitweb.cgi in C
Date: Thu, 8 Dec 2005 23:46:26 +0100
Message-ID: <20051208224626.GP22159@pasky.or.cz>
References: <43988299.4090101@tiscali.cz> <20051208222759.GO22159@pasky.or.cz> <7vfyp3b4ki.fsf@assigned-by-dhcp.cox.net>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Thu Dec 08 23:47:49 2005
Return-path: <git-owner@vger.kernel.org>
Received: from vger.kernel.org ([209.132.176.167])
	by ciao.gmane.org with esmtp (Exim 4.43)
	id 1EkUWq-0000ut-H5
	for gcvg-git@gmane.org; Thu, 08 Dec 2005 23:46:20 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932685AbVLHWqR (ORCPT <rfc822;gcvg-git@m.gmane.org>);
	Thu, 8 Dec 2005 17:46:17 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S932686AbVLHWqR
	(ORCPT <rfc822;git-outgoing>); Thu, 8 Dec 2005 17:46:17 -0500
Received: from w241.dkm.cz ([62.24.88.241]:36764 "EHLO machine.or.cz")
	by vger.kernel.org with ESMTP id S932685AbVLHWqR (ORCPT
	<rfc822;git@vger.kernel.org>); Thu, 8 Dec 2005 17:46:17 -0500
Received: (qmail 17260 invoked by uid 2001); 8 Dec 2005 23:46:26 +0100
To: Junio C Hamano <junkio@cox.net>
Content-Disposition: inline
In-Reply-To: <7vfyp3b4ki.fsf@assigned-by-dhcp.cox.net>
X-message-flag: Outlook : A program to spread viri, but it can do mail too.
User-Agent: Mutt/1.5.11
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/13383>

Dear diary, on Thu, Dec 08, 2005 at 11:35:09PM CET, I got a letter
where Junio C Hamano <junkio@cox.net> said that...
> Petr Baudis <pasky@suse.cz> writes:
> 
> > Dear diary, on Thu, Dec 08, 2005 at 07:59:37PM CET, I got a letter
> > where Majkls <majkls@tiscali.cz> said that...
> >> What do you think about gitweb.cgi in C?
> >
> > To add to the collective dismay - why bother?
> 
> It _might_ make sense to do gitweb using libified git Smurf is
> working on, in order to reduce forks and execs, but that is
> mostly independent of rewriting that in C.

I'd see having Perl XS for libgit as something much more sensible. And
you could do cute porcelain stuff with that as well.

-- 
				Petr "Pasky" Baudis
Stuff: http://pasky.or.cz/
VI has two modes: the one in which it beeps and the one in which
it doesn't.
