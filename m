From: Petr Baudis <pasky@suse.cz>
Subject: Re: [PATCH] Do not print header in diff-tree --root unless asked to
Date: Sun, 26 Mar 2006 03:50:24 +0200
Message-ID: <20060326015024.GC18185@pasky.or.cz>
References: <20060325232807.9146.12846.stgit@machine.or.cz> <7vu09mt4ij.fsf@assigned-by-dhcp.cox.net>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Sun Mar 26 03:50:30 2006
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by ciao.gmane.org with esmtp (Exim 4.43)
	id 1FNKOa-0007Mt-Nq
	for gcvg-git@gmane.org; Sun, 26 Mar 2006 03:50:21 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751118AbWCZBuR (ORCPT <rfc822;gcvg-git@m.gmane.org>);
	Sat, 25 Mar 2006 20:50:17 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751191AbWCZBuR
	(ORCPT <rfc822;git-outgoing>); Sat, 25 Mar 2006 20:50:17 -0500
Received: from w241.dkm.cz ([62.24.88.241]:51102 "EHLO machine.or.cz")
	by vger.kernel.org with ESMTP id S1751118AbWCZBuP (ORCPT
	<rfc822;git@vger.kernel.org>); Sat, 25 Mar 2006 20:50:15 -0500
Received: (qmail 29792 invoked by uid 2001); 26 Mar 2006 03:50:24 +0200
To: Junio C Hamano <junkio@cox.net>
Content-Disposition: inline
In-Reply-To: <7vu09mt4ij.fsf@assigned-by-dhcp.cox.net>
X-message-flag: Outlook : A program to spread viri, but it can do mail too.
User-Agent: Mutt/1.5.11
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/18019>

Dear diary, on Sun, Mar 26, 2006 at 01:48:36AM CET, I got a letter
where Junio C Hamano <junkio@cox.net> said that...
> Petr Baudis <pasky@suse.cz> writes:
> 
> > ... git-diff-tree would always return the sha1 of the commit
> > when --root was passed.
> 
> I am not sure why this change is needed.
> 
> The output from "git-diff-tree --root e83c51" (the very initial
> "git") and "git-diff-tree 8bc9a0" (the second commit) without
> any other parameters (specifically, there is no '-v') look
> comparable right now, but I suspect this change would break it.

I was confused by the fact that

	git-diff-tree --root rev1

gives a different output than

	git-diff-tree --root rev1 rev2

Sorry for the noise,

-- 
				Petr "Pasky" Baudis
Stuff: http://pasky.or.cz/
Right now I am having amnesia and deja-vu at the same time.  I think
I have forgotten this before.
