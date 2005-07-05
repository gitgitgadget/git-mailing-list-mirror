From: Petr Baudis <pasky@suse.cz>
Subject: Re: [PATCH] Add script for patch submission via e-mail.
Date: Tue, 5 Jul 2005 11:34:41 +0200
Message-ID: <20050705093441.GD6191@pasky.ji.cz>
References: <7vll5h7k5t.fsf@assigned-by-dhcp.cox.net>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: Junio C Hamano <junkio@cox.net>, git@vger.kernel.org
X-From: git-owner@vger.kernel.org Tue Jul 05 11:35:44 2005
Return-path: <git-owner@vger.kernel.org>
Received: from vger.kernel.org ([12.107.209.244])
	by ciao.gmane.org with esmtp (Exim 4.43)
	id 1Dpjpn-0008K9-VY
	for gcvg-git@gmane.org; Tue, 05 Jul 2005 11:35:20 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261781AbVGEJew (ORCPT <rfc822;gcvg-git@m.gmane.org>);
	Tue, 5 Jul 2005 05:34:52 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261783AbVGEJew
	(ORCPT <rfc822;git-outgoing>); Tue, 5 Jul 2005 05:34:52 -0400
Received: from w241.dkm.cz ([62.24.88.241]:46265 "HELO machine.sinus.cz")
	by vger.kernel.org with SMTP id S261781AbVGEJen (ORCPT
	<rfc822;git@vger.kernel.org>); Tue, 5 Jul 2005 05:34:43 -0400
Received: (qmail 15422 invoked by uid 2001); 5 Jul 2005 09:34:41 -0000
To: Linus Torvalds <torvalds@osdl.org>
Content-Disposition: inline
In-Reply-To: <7vll5h7k5t.fsf@assigned-by-dhcp.cox.net>
User-Agent: Mutt/1.4i
X-message-flag: Outlook : A program to spread viri, but it can do mail too.
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org

Dear diary, on Sat, Jun 11, 2005 at 03:32:30AM CEST, I got a letter
where Junio C Hamano <junkio@cox.net> told me that...
> This git-format-patch-script is what I use to prepare patches
> for e-mail submission.
> 
> Typical usage is:
> 
> $ git-format-patch-script -B -C --find-copies-harder HEAD linus
> 
> to prepare each commit with its patch since "HEAD" forked from
> "linus", one file per patch for e-mail submission.  Each output
> file is numbered sequentially from 1, and uses the first line of
> the commit message (massaged for pathname safety) as the
> filename.
> 
> $ git-format-patch-script -B -C --find-copies-harder HEAD linus .patch/
> 
> creates output files in .patch/ directory.
> 
> Signed-off-by: Junio C Hamano <junkio@cox.net>
> ---
> *** Linus I am submitting this one because some patches on
> *** read-tree I am going to send you will need this for
> *** formatting into a form that is easier to review.  And this
> *** in turn can use diff-tree --find-copies-harder, which I
> *** indeed used to generate the patches that follow.

Any reason why this was not applied? It appears kind of cool. Well, I
will probably take it and extend cg-mkpatch with it so I don't need it
in Git, but I'm so altruistic and want to bring at least a bit of light
to the gloomy dark world of the poor core Git plumbing users.  ;-)

-- 
				Petr "Pasky" Baudis
Stuff: http://pasky.or.cz/
<Espy> be careful, some twit might quote you out of context..
