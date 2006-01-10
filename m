From: Jens Axboe <axboe@suse.de>
Subject: Re: killing a branch
Date: Tue, 10 Jan 2006 11:35:33 +0100
Message-ID: <20060110103533.GT3389@suse.de>
References: <20060110102207.GP3389@suse.de> <7vr77g8jm4.fsf@assigned-by-dhcp.cox.net>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Tue Jan 10 11:33:54 2006
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by ciao.gmane.org with esmtp (Exim 4.43)
	id 1EwGp0-0005h5-Pj
	for gcvg-git@gmane.org; Tue, 10 Jan 2006 11:33:47 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1750875AbWAJKdj (ORCPT <rfc822;gcvg-git@m.gmane.org>);
	Tue, 10 Jan 2006 05:33:39 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751003AbWAJKdj
	(ORCPT <rfc822;git-outgoing>); Tue, 10 Jan 2006 05:33:39 -0500
Received: from ns.virtualhost.dk ([195.184.98.160]:6156 "EHLO virtualhost.dk")
	by vger.kernel.org with ESMTP id S1750873AbWAJKdi (ORCPT
	<rfc822;git@vger.kernel.org>); Tue, 10 Jan 2006 05:33:38 -0500
Received: from [62.242.22.158] (helo=router.home.kernel.dk)
	by virtualhost.dk with esmtp (Exim 3.36 #1)
	id 1EwGop-0004tP-00; Tue, 10 Jan 2006 11:33:35 +0100
Received: from nelson.home.kernel.dk ([192.168.0.33] helo=kernel.dk)
	by router.home.kernel.dk with esmtp (Exim 4.51)
	id 1EwGoo-0000AV-Ey; Tue, 10 Jan 2006 11:33:34 +0100
Received: by kernel.dk (Postfix, from userid 1000)
	id E9A611D95CA; Tue, 10 Jan 2006 11:35:33 +0100 (CET)
To: Junio C Hamano <junkio@cox.net>
Content-Disposition: inline
In-Reply-To: <7vr77g8jm4.fsf@assigned-by-dhcp.cox.net>
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/14416>

On Tue, Jan 10 2006, Junio C Hamano wrote:
> Jens Axboe <axboe@suse.de> writes:
> 
> > $ rm .git/refs/heads/branch-name
> > $ git prune
> >
> > to rid myself of the branch and associated objects. Is there a faster
> > approach?
> 
> Perhaps the "official" way is
> 
> 	$ git branch -d branch-name ;# you may need -D
>         $ git prune
> 
> but that essentially is the same as what you are doing.  Note

So no time saved there :-)

> that having dangling objects in your repository is not a crime,
> and you do not have to religiously do "git prune" every time.

I know, it just doesn't feel nice!

-- 
Jens Axboe
