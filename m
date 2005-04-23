From: Russell King <rmk@arm.linux.org.uk>
Subject: Re: Catching up: git-pasky-0.6.2 broken?
Date: Sat, 23 Apr 2005 15:21:02 +0100
Message-ID: <20050423152102.D32116@flint.arm.linux.org.uk>
References: <20050423124758.B32116@flint.arm.linux.org.uk> <20050423151238.C32116@flint.arm.linux.org.uk>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
X-From: git-owner@vger.kernel.org Sat Apr 23 16:16:43 2005
Return-path: <git-owner@vger.kernel.org>
Received: from vger.kernel.org ([12.107.209.244])
	by ciao.gmane.org with esmtp (Exim 4.43)
	id 1DPLQm-0004Ke-Sg
	for gcvg-git@gmane.org; Sat, 23 Apr 2005 16:16:25 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261592AbVDWOVI (ORCPT <rfc822;gcvg-git@m.gmane.org>);
	Sat, 23 Apr 2005 10:21:08 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261594AbVDWOVI
	(ORCPT <rfc822;git-outgoing>); Sat, 23 Apr 2005 10:21:08 -0400
Received: from caramon.arm.linux.org.uk ([212.18.232.186]:5384 "EHLO
	caramon.arm.linux.org.uk") by vger.kernel.org with ESMTP
	id S261592AbVDWOVG (ORCPT <rfc822;git@vger.kernel.org>);
	Sat, 23 Apr 2005 10:21:06 -0400
Received: from flint.arm.linux.org.uk ([2002:d412:e8ba:1:201:2ff:fe14:8fad])
	by caramon.arm.linux.org.uk with asmtp (TLSv1:DES-CBC3-SHA:168)
	(Exim 4.41)
	id 1DPLVI-0005tg-6R
	for git@vger.kernel.org; Sat, 23 Apr 2005 15:21:04 +0100
Received: from rmk by flint.arm.linux.org.uk with local (Exim 4.41)
	id 1DPLVH-0005Zk-0v
	for git@vger.kernel.org; Sat, 23 Apr 2005 15:21:03 +0100
To: git@vger.kernel.org
Content-Disposition: inline
User-Agent: Mutt/1.2.5.1i
In-Reply-To: <20050423151238.C32116@flint.arm.linux.org.uk>; from rmk@arm.linux.org.uk on Sat, Apr 23, 2005 at 03:12:39PM +0100
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org

On Sat, Apr 23, 2005 at 03:12:39PM +0100, Russell King wrote:
> On Sat, Apr 23, 2005 at 12:47:58PM +0100, Russell King wrote:
> > Any ideas what's going on?
> 
> Could the problem be related to some random garbage left in .git/add-queue
> and .git/rm-queue?
> 
> If so, how did these files get generated in the first place, and why
> weren't they removed when they were finished with?
> 
> IMHO updating a repository from an external source should _NOT_ be
> affected by the presence (or absense) of these two files, which
> contain only _local_ state information.

Ok, don't bother looking into this - I'm now completely git-free here.
I think I'll prefer to use the old diff and patch method to submit
stuff to Linus, until git has progressed sufficiently such that it
doesn't end up wasting hours of my time.

Yes, it's a radical solution, but since I _can't_ get it to work for
me, it's the only one which will allow me to get any real work done.

(and it all looked soo promising pre-0.6.2)

-- 
Russell King

