From: Russell King <rmk@arm.linux.org.uk>
Subject: Re: please pull ppc64-2.6.git
Date: Mon, 29 Aug 2005 18:45:10 +0100
Message-ID: <20050829184510.A20605@flint.arm.linux.org.uk>
References: <17170.25803.413408.44080@cargo.ozlabs.ibm.com> <Pine.LNX.4.58.0508291006440.3243@g5.osdl.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: Paul Mackerras <paulus@samba.org>, linuxppc64-dev@ozlabs.org,
	Git Mailing List <git@vger.kernel.org>
X-From: git-owner@vger.kernel.org Mon Aug 29 19:47:45 2005
Return-path: <git-owner@vger.kernel.org>
Received: from vger.kernel.org ([209.132.176.167])
	by ciao.gmane.org with esmtp (Exim 4.43)
	id 1E9nhD-0002OQ-CD
	for gcvg-git@gmane.org; Mon, 29 Aug 2005 19:45:23 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751170AbVH2RpU (ORCPT <rfc822;gcvg-git@m.gmane.org>);
	Mon, 29 Aug 2005 13:45:20 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751174AbVH2RpT
	(ORCPT <rfc822;git-outgoing>); Mon, 29 Aug 2005 13:45:19 -0400
Received: from caramon.arm.linux.org.uk ([212.18.232.186]:5139 "EHLO
	caramon.arm.linux.org.uk") by vger.kernel.org with ESMTP
	id S1751170AbVH2RpS (ORCPT <rfc822;git@vger.kernel.org>);
	Mon, 29 Aug 2005 13:45:18 -0400
Received: from flint.arm.linux.org.uk ([2002:d412:e8ba:1:201:2ff:fe14:8fad])
	by caramon.arm.linux.org.uk with asmtp (TLSv1:DES-CBC3-SHA:168)
	(Exim 4.41)
	id 1E9nh2-0002h1-5o; Mon, 29 Aug 2005 18:45:12 +0100
Received: from rmk by flint.arm.linux.org.uk with local (Exim 4.41)
	id 1E9nh0-0005QA-UP; Mon, 29 Aug 2005 18:45:10 +0100
To: Linus Torvalds <torvalds@osdl.org>
Content-Disposition: inline
User-Agent: Mutt/1.2.5.1i
In-Reply-To: <Pine.LNX.4.58.0508291006440.3243@g5.osdl.org>; from torvalds@osdl.org on Mon, Aug 29, 2005 at 10:32:09AM -0700
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/7909>

On Mon, Aug 29, 2005 at 10:32:09AM -0700, Linus Torvalds wrote:
> On Mon, 29 Aug 2005, Paul Mackerras wrote:
> > Please do a pull from:
> > 
> > rsync://rsync.kernel.org/pub/scm/linux/kernel/git/paulus/ppc64-2.6.git
> 
> Gaah.
> 
> This is not a valid git repository.
> 
> Guys, if you do partially populated repositories, _please_ make sure that 
> you still make it a valid git repository. These days you can trivially do 
> so by doing a
> 
> 	echo /pub/scm/linux/kernel/git/torvalds/linux-2.6/objects > objects/info/alternates
> 
> or similar. That also makes gitweb able to show diffs etc, something it 
> can't do for a broken partial repository.

Is the expected filesystem layout documented somewhere online (_external_
to the source code) ?

The reason I stress external to the code is that some of us do not track
git developments.  (Except via the ctrl-d method in our mail readers.)

Alternatively, when changes occur to the repostory format, please can
they be marked with some obvious subject so that folk know when things
are going to break?

-- 
Russell King
