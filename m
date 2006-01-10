From: Jens Axboe <axboe@suse.de>
Subject: Re: killing a branch
Date: Tue, 10 Jan 2006 12:26:09 +0100
Message-ID: <20060110112608.GU3389@suse.de>
References: <20060110102207.GP3389@suse.de> <7vr77g8jm4.fsf@assigned-by-dhcp.cox.net> <20060110103533.GT3389@suse.de> <7vy81o73t2.fsf@assigned-by-dhcp.cox.net>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Tue Jan 10 12:24:28 2006
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by ciao.gmane.org with esmtp (Exim 4.43)
	id 1EwHbw-00006L-9s
	for gcvg-git@gmane.org; Tue, 10 Jan 2006 12:24:20 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751073AbWAJLYP (ORCPT <rfc822;gcvg-git@m.gmane.org>);
	Tue, 10 Jan 2006 06:24:15 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751074AbWAJLYP
	(ORCPT <rfc822;git-outgoing>); Tue, 10 Jan 2006 06:24:15 -0500
Received: from ns.virtualhost.dk ([195.184.98.160]:19505 "EHLO virtualhost.dk")
	by vger.kernel.org with ESMTP id S1751072AbWAJLYO (ORCPT
	<rfc822;git@vger.kernel.org>); Tue, 10 Jan 2006 06:24:14 -0500
Received: from [62.242.22.158] (helo=router.home.kernel.dk)
	by virtualhost.dk with esmtp (Exim 3.36 #1)
	id 1EwHbn-0008Sh-00; Tue, 10 Jan 2006 12:24:11 +0100
Received: from nelson.home.kernel.dk ([192.168.0.33] helo=kernel.dk)
	by router.home.kernel.dk with esmtp (Exim 4.51)
	id 1EwHbm-0000sy-9r; Tue, 10 Jan 2006 12:24:10 +0100
Received: by kernel.dk (Postfix, from userid 1000)
	id BA1531D95C1; Tue, 10 Jan 2006 12:26:09 +0100 (CET)
To: Junio C Hamano <junkio@cox.net>
Content-Disposition: inline
In-Reply-To: <7vy81o73t2.fsf@assigned-by-dhcp.cox.net>
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/14418>

On Tue, Jan 10 2006, Junio C Hamano wrote:
> Jens Axboe <axboe@suse.de> writes:
> 
> >> that having dangling objects in your repository is not a crime,
> >> and you do not have to religiously do "git prune" every time.
> >
> > I know, it just doesn't feel nice!
> 
> Sorry, but I can think of only three reasons (and a half) why
> somebody cannot live with "one git prune at the end of the day
> before leaving" (or "week" for that matter) workflow:
> 
>  * the filesystem quota is too tight and you cannot afford to
>    leave unused loose objects around.  May still be true on
>    student accounts, perhaps, but I doubt this is much of an
>    issue in the modern world anymore.

Yeah obviously not true.

>  * rsync is used to sync from a repository that dropped a branch
>    just now, and you do not want to push the garbage out.  Well,
>    if you are still using rsync, I'll tell about it to Linus ;-)
>    Pushing via git native protocol over ssh would not send
>    unreferenced objects out and will not contaminate the other
>    end with the garbage.

Haven't used rsync in a long time, I use git:// and ssh:// exclusively.

>  * you do not want to leave after starting prune before it
>    finishes.  If it is your hobby to watch the paint dry, I
>    cannot help you, but you could run prune under nohup (or
>    always work inside "screen", which is what I do).
> 
>  + having unused things on the disk just does not _feel_ right.
>    Well, maybe.  I can argue with a reason but not with a
>    feeling.  On a bright side, leaving recently abandoned
>    objects around for a while lets you run git-lost-found to
>    recover if you accidentally deleted a still-useful branch.

:-)

Alright, I'll just have to shake the habit of running git prune to rid
myself of that dirty dirty feeling.

-- 
Jens Axboe
