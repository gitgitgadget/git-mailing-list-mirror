From: Jens Axboe <axboe@suse.de>
Subject: Re: killing a branch
Date: Tue, 10 Jan 2006 19:59:32 +0100
Message-ID: <20060110185932.GW3389@suse.de>
References: <20060110102207.GP3389@suse.de> <7vr77g8jm4.fsf@assigned-by-dhcp.cox.net> <20060110103533.GT3389@suse.de> <7vy81o73t2.fsf@assigned-by-dhcp.cox.net> <20060110112608.GU3389@suse.de> <Pine.LNX.4.64.0601100910530.4939@g5.osdl.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: Junio C Hamano <junkio@cox.net>, git@vger.kernel.org
X-From: git-owner@vger.kernel.org Tue Jan 10 19:58:09 2006
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by ciao.gmane.org with esmtp (Exim 4.43)
	id 1EwOgs-0003vm-1Y
	for gcvg-git@gmane.org; Tue, 10 Jan 2006 19:57:54 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751180AbWAJS5p (ORCPT <rfc822;gcvg-git@m.gmane.org>);
	Tue, 10 Jan 2006 13:57:45 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751191AbWAJS5p
	(ORCPT <rfc822;git-outgoing>); Tue, 10 Jan 2006 13:57:45 -0500
Received: from ns.virtualhost.dk ([195.184.98.160]:41327 "EHLO virtualhost.dk")
	by vger.kernel.org with ESMTP id S1751180AbWAJS5o (ORCPT
	<rfc822;git@vger.kernel.org>); Tue, 10 Jan 2006 13:57:44 -0500
Received: from [62.242.22.158] (helo=router.home.kernel.dk)
	by virtualhost.dk with esmtp (Exim 3.36 #1)
	id 1EwOgZ-0002dL-00; Tue, 10 Jan 2006 19:57:35 +0100
Received: from nelson.home.kernel.dk ([192.168.0.33] helo=kernel.dk)
	by router.home.kernel.dk with esmtp (Exim 4.51)
	id 1EwOgX-0003wD-EP; Tue, 10 Jan 2006 19:57:33 +0100
Received: by kernel.dk (Postfix, from userid 1000)
	id 99E1D253250; Tue, 10 Jan 2006 19:59:32 +0100 (CET)
To: Linus Torvalds <torvalds@osdl.org>
Content-Disposition: inline
In-Reply-To: <Pine.LNX.4.64.0601100910530.4939@g5.osdl.org>
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/14434>

On Tue, Jan 10 2006, Linus Torvalds wrote:
> 
> 
> On Tue, 10 Jan 2006, Jens Axboe wrote:
> > 
> > Alright, I'll just have to shake the habit of running git prune to rid
> > myself of that dirty dirty feeling.
> 
> Yeah, I'm slowly shaking it off too. I used to run git-fsck-objects 
> religiously just because I worried about bugs. I still do it, but 
> especially with the recursive-strategy merging, I get "dangling blob" 
> messages every once in a while that are _not_ due to bugs, but just due to 
> the temporary merge object.
> 
> So I'm learning to ignore them, and prune the tree only occasionally, 
> instead of compulsively every time.

Compulsive is the right word, it just itches to run the prune after
killing a branch... I'll try and learn as well.

-- 
Jens Axboe
