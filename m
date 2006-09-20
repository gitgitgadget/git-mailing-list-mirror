From: Petr Baudis <pasky@suse.cz>
Subject: Re: [PATCH] Added --mirror-all to git-fetch.
Date: Wed, 20 Sep 2006 18:14:07 +0200
Message-ID: <20060920161407.GQ8259@pasky.or.cz>
References: <20060919232851.GA12195@spearce.org> <7vac4ujzf0.fsf@assigned-by-dhcp.cox.net>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: Shawn Pearce <spearce@spearce.org>, git@vger.kernel.org
X-From: git-owner@vger.kernel.org Wed Sep 20 18:14:55 2006
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by ciao.gmane.org with esmtp (Exim 4.43)
	id 1GQ4iD-000259-Of
	for gcvg-git@gmane.org; Wed, 20 Sep 2006 18:14:14 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751726AbWITQOK (ORCPT <rfc822;gcvg-git@m.gmane.org>);
	Wed, 20 Sep 2006 12:14:10 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751727AbWITQOK
	(ORCPT <rfc822;git-outgoing>); Wed, 20 Sep 2006 12:14:10 -0400
Received: from w241.dkm.cz ([62.24.88.241]:15247 "EHLO machine.or.cz")
	by vger.kernel.org with ESMTP id S1751726AbWITQOJ (ORCPT
	<rfc822;git@vger.kernel.org>); Wed, 20 Sep 2006 12:14:09 -0400
Received: (qmail 4268 invoked by uid 2001); 20 Sep 2006 18:14:07 +0200
To: Junio C Hamano <junkio@cox.net>
Content-Disposition: inline
In-Reply-To: <7vac4ujzf0.fsf@assigned-by-dhcp.cox.net>
X-message-flag: Outlook : A program to spread viri, but it can do mail too.
User-Agent: Mutt/1.5.13 (2006-08-11)
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/27362>

Dear diary, on Wed, Sep 20, 2006 at 06:06:11PM CEST, I got a letter
where Junio C Hamano <junkio@cox.net> said that...
..snip..
>      If there is reluctance against adding yet another new
>      command (and there certainly is), this feels more like a
>      cousin of "git-clone --bare".

Certainly. But, what exactly are you proposing here? :-) (Besides
possible change of the switch name.) Making this a git-clone option
sounds even much worse.

..snip..
>  (2) Although there is no inherent reason not allowing a working
>      tree associated with the repository that is kept updated
>      this way, the user will be utterly confused in a working
>      tree whose current branch head is updated like this, until
>      the working tree and the index is matched to the updated
>      HEAD.

git-fetch --mirror-all can still be very useful even with a working copy
if you are keeping all the remote heads in .git/refs/remotes/. I'd
venture to say that in that case, this is frequently what you actually
want when fetching from the repository (given that you have already let
git clone do that once).

..snip..
>      (the archive vs active repacking strategy we talked about,

Hmm, I think I've missed this, I must look that in the archive.

>      combined with set of packs with staggered spans to help
>      commit walkers Pasky talked about quite a while ago).

Yes, this is certainly one of things I would like to implement at
repo.or.cz.

-- 
				Petr "Pasky" Baudis
Stuff: http://pasky.or.cz/
Snow falling on Perl. White noise covering line noise.
Hides all the bugs too. -- J. Putnam
