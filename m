From: Petr Baudis <pasky@suse.cz>
Subject: Re: still unclear on setting up a repository
Date: Mon, 28 Nov 2005 00:15:29 +0100
Message-ID: <20051127231529.GM22159@pasky.or.cz>
References: <86br0g883v.fsf@blue.stonehenge.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Mon Nov 28 00:16:46 2005
Return-path: <git-owner@vger.kernel.org>
Received: from vger.kernel.org ([209.132.176.167])
	by ciao.gmane.org with esmtp (Exim 4.43)
	id 1EgVjv-0007e8-VS
	for gcvg-git@gmane.org; Mon, 28 Nov 2005 00:15:24 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751169AbVK0XPQ (ORCPT <rfc822;gcvg-git@m.gmane.org>);
	Sun, 27 Nov 2005 18:15:16 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751171AbVK0XPP
	(ORCPT <rfc822;git-outgoing>); Sun, 27 Nov 2005 18:15:15 -0500
Received: from w241.dkm.cz ([62.24.88.241]:13771 "EHLO machine.or.cz")
	by vger.kernel.org with ESMTP id S1751169AbVK0XPO (ORCPT
	<rfc822;git@vger.kernel.org>); Sun, 27 Nov 2005 18:15:14 -0500
Received: (qmail 7428 invoked by uid 2001); 28 Nov 2005 00:15:29 +0100
To: "Randal L. Schwartz" <merlyn@stonehenge.com>
Content-Disposition: inline
In-Reply-To: <86br0g883v.fsf@blue.stonehenge.com>
X-message-flag: Outlook : A program to spread viri, but it can do mail too.
User-Agent: Mutt/1.5.11
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/12834>

Dear diary, on Sun, Nov 20, 2005 at 01:40:20AM CET, I got a letter
where "Randal L. Schwartz" <merlyn@stonehenge.com> said that...
> This seems to report the right thing.  I have a branch "origin"
> that points at the remote repository.  So far, I think I'm understanding
> what's happening.  But now, go boom:
> 
>         % cg-push
>         cg-push: where to push to?
> 
> Huh?  How do I do the initial push?  Not this way?  Is it me, docs, or
> code that is broken here?

The code was broken, cg-push wouldn't default to origin unless you
already had an origin head, which you obviously can't have when you are
going to push for the first time. Thanks, fixed.

-- 
				Petr "Pasky" Baudis
Stuff: http://pasky.or.cz/
VI has two modes: the one in which it beeps and the one in which
it doesn't.
