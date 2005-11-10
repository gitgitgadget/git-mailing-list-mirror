From: Petr Baudis <pasky@suse.cz>
Subject: Re: [ANNOUNCE] GIT 0.99.9g
Date: Thu, 10 Nov 2005 19:03:11 +0100
Message-ID: <20051110180311.GR30496@pasky.or.cz>
References: <7vmzkc2a3e.fsf@assigned-by-dhcp.cox.net> <43737EC7.6090109@zytor.com> <7v4q6k1jp0.fsf@assigned-by-dhcp.cox.net>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: "H. Peter Anvin" <hpa@zytor.com>, git@vger.kernel.org,
	linux-kernel@vger.kernel.org, barkalow@iabervon.org
X-From: git-owner@vger.kernel.org Thu Nov 10 19:03:40 2005
Return-path: <git-owner@vger.kernel.org>
Received: from vger.kernel.org ([209.132.176.167])
	by ciao.gmane.org with esmtp (Exim 4.43)
	id 1EaGla-0002uI-Au
	for gcvg-git@gmane.org; Thu, 10 Nov 2005 19:03:18 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751190AbVKJSDO (ORCPT <rfc822;gcvg-git@m.gmane.org>);
	Thu, 10 Nov 2005 13:03:14 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751193AbVKJSDO
	(ORCPT <rfc822;git-outgoing>); Thu, 10 Nov 2005 13:03:14 -0500
Received: from w241.dkm.cz ([62.24.88.241]:12195 "EHLO machine.or.cz")
	by vger.kernel.org with ESMTP id S1751190AbVKJSDN (ORCPT
	<rfc822;git@vger.kernel.org>); Thu, 10 Nov 2005 13:03:13 -0500
Received: (qmail 13418 invoked by uid 2001); 10 Nov 2005 19:03:11 +0100
To: Junio C Hamano <junkio@cox.net>
Content-Disposition: inline
In-Reply-To: <7v4q6k1jp0.fsf@assigned-by-dhcp.cox.net>
X-message-flag: Outlook : A program to spread viri, but it can do mail too.
User-Agent: Mutt/1.5.11
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/11497>

Dear diary, on Thu, Nov 10, 2005 at 06:44:43PM CET, I got a letter
where Junio C Hamano <junkio@cox.net> said that...
> "H. Peter Anvin" <hpa@zytor.com> writes:
> 
> > May I *STRONGLY* urge you to name that something different. 
> > "lost+found" is a name with special properties in Unix; for example, 
> > many backup solutions will ignore a directory with that name.
> 
> Yeah, the original proposal (in TODO list) explicitly stated why
> I chose lost-found instead of lost+found back then, and somebody
> on the list (could have been Pasky but I may be mistaken) said
> not to worry.

It was the Large Angry SCM. I share your concern.

> In any case, if we go the route Daniel suggests, we would not be
> storing anything on the filesystem ourselves so this would be a
> non-issue.

I like Daniel's route as well, for the separate command. But it would be
nice to also have a way to tell git-fsck-cache to save the lost+found
refs as it goes, much like the filesystem fsck. So if it reports some
unreachable refs, you will not need to tell it to do the same job
_another_ time to find out the refs and pass them to gitk. Then again,
if we do this, the utility of a separate command will be questionable.

-- 
				Petr "Pasky" Baudis
Stuff: http://pasky.or.cz/
VI has two modes: the one in which it beeps and the one in which
it doesn't.
