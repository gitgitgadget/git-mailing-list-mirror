From: Petr Baudis <pasky@suse.cz>
Subject: Re: [Terminology] Push vs. upload?
Date: Tue, 20 Sep 2005 03:44:48 +0200
Message-ID: <20050920014448.GA30912@pasky.or.cz>
References: <20050920001136.GK18320@pasky.or.cz> <Pine.LNX.4.58.0509191753100.2553@g5.osdl.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: junkio@cox.net, git@vger.kernel.org
X-From: git-owner@vger.kernel.org Tue Sep 20 03:46:28 2005
Return-path: <git-owner@vger.kernel.org>
Received: from vger.kernel.org ([209.132.176.167])
	by ciao.gmane.org with esmtp (Exim 4.43)
	id 1EHXBu-0007Zk-39
	for gcvg-git@gmane.org; Tue, 20 Sep 2005 03:45:02 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S964816AbVITBov (ORCPT <rfc822;gcvg-git@m.gmane.org>);
	Mon, 19 Sep 2005 21:44:51 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S964825AbVITBov
	(ORCPT <rfc822;git-outgoing>); Mon, 19 Sep 2005 21:44:51 -0400
Received: from w241.dkm.cz ([62.24.88.241]:20933 "EHLO machine.or.cz")
	by vger.kernel.org with ESMTP id S964816AbVITBou (ORCPT
	<rfc822;git@vger.kernel.org>); Mon, 19 Sep 2005 21:44:50 -0400
Received: (qmail 3377 invoked by uid 2001); 20 Sep 2005 03:44:48 +0200
To: Linus Torvalds <torvalds@osdl.org>
Content-Disposition: inline
In-Reply-To: <Pine.LNX.4.58.0509191753100.2553@g5.osdl.org>
X-message-flag: Outlook : A program to spread viri, but it can do mail too.
User-Agent: Mutt/1.5.10i
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/8944>

Dear diary, on Tue, Sep 20, 2005 at 02:55:08AM CEST, I got a letter
where Linus Torvalds <torvalds@osdl.org> told me that...
> 
> 
> On Tue, 20 Sep 2005, Petr Baudis wrote:
> > 
> >   I've realized today that I "forgot" to rename cg-push to cg-upload, so
> > I impulsively did so right away, but now I'm seeing that the core git
> > still has git-push and no git-upload. This is confusing and appears to
> > be quite inconsistent - push should be the opposite of pull
> 
> No. There is no opposite of pull. You can't update the tree on the other 
> end. It's fundamentally an unsafe operation - the other end is by 
> definition not a private tree.
> 
> (Or, if you want to see it another way: "pull" is "pull"s own opposite:  
> "ssh other-end + git pull from that end" ends up being what you mean.)

Yes, but I'm just arguing about the naming - if you just take the word
"pull", "push" is the obvious opposite to that and vice versa, so if we
are going to use words "pull" and "push" in the same context, this
relation should be preserved. So "push" really _should_ mean

	ssh other-end 'git-pull'

whether it's a safe operation or not - if not, then GIT should have
nothing called "push". But the current "push" is really an opposite of
"fetch", so it should be called "upload", I believe.

-- 
				Petr "Pasky" Baudis
Stuff: http://pasky.or.cz/
VI has two modes: the one in which it beeps and the one in which
it doesn't.
